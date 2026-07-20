package ctrl4399.view.components
{
   import ctrl4399.proxy.MainProxy;
   import ctrl4399.proxy.ShopProxy;
   import ctrl4399.strconst.AllConst;
   import ctrl4399.view.components.shopModule.DescribeModule;
   import ctrl4399.view.components.shopModule.NoticeModule;
   import ctrl4399.view.components.shopModule.PageModule;
   import ctrl4399.view.components.shopModule.PicModule;
   import ctrl4399.view.components.shopModule.selectlist.ChaneEvent;
   import ctrl4399.view.components.shopModule.selectlist.SelectMc;
   import ctrl4399.view.components.styleConst.StyleClass;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.DataEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.ui.Mouse;
   import frame4399.simplePureMvc.core.Facade;
   import org.heaven.impl.tot.Singleton;
   import org.hell.SetBox;
   
   public class ShopView extends SetBox
   {
      
      private var _mainProxy:MainProxy;
      
      private var _shopProxy:ShopProxy;
      
      private var _facade:Facade;
      
      private var logName:TextField;
      
      private var _btnLogout:Sprite;
      
      private var _errorTip:Sprite;
      
      private var _waitMc:MovieClip;
      
      private var _errorTxt:TextField;
      
      private var _closeBtn:SimpleButton;
      
      private var pageMc:PageModule;
      
      private var noticeSp:NoticeModule;
      
      private var payBtn:PayBtn;
      
      private var desModule:DescribeModule;
      
      private var moneyTxt:TextField;
      
      private var typeCom:SelectMc;
      
      private var zdBgMc:ZdBgMc;
      
      private var picSp:Sprite;
      
      private var picAry:Array;
      
      private var picWid:int = 90;
      
      private var picHei:int = 90;
      
      private var maxPicNum:uint = 8;
      
      private var xspan:int = 20;
      
      private var yspan:int = 15;
      
      private var _scaleY:Number = 1.1;
      
      public var payMoney:uint = 1;
      
      private var curPageAry:Array;
      
      private var curType:int = 0;
      
      private var remCurPage:int = 0;
      
      public var curItme:int = -1;
      
      private var isNoMoney:Boolean = false;
      
      private var _ggBg:MovieClip;
      
      private var _titleMc:MovieClip;
      
      private var _yspan:int = 15;
      
      private var pageAry:Array;
      
      public function ShopView()
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:SimpleButton = null;
         this._facade = Facade.getInstance();
         super();
         this._mainProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_MAIN) as MainProxy;
         this._shopProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_SHOP) as ShopProxy;
         var _loc1_:Object = new Object();
         _loc1_.viewClass = Singleton.getClass(AllConst.SPC_View_Shop);
         _loc1_.contentViewClass = Singleton.getClass(AllConst.SPC_Cont_Shop);
         _loc1_.tfd = new TextFormat();
         initSetBox("",_loc1_,null,this.checkBtnFun,null);
         titleHeight = 32;
         setStageSize(502,357);
         setBtnVisible();
         this.logName = new TextField();
         this.logName.defaultTextFormat = new TextFormat("宋体",13,16777215);
         this.logName.text = "未登录";
         this.logName.selectable = false;
         this.logName.autoSize = TextFieldAutoSize.LEFT;
         this.logName.multiline = false;
         this.logName.wordWrap = false;
         if(this._mainProxy.userNickName != null)
         {
            this.logName.styleSheet = StyleClass.userNameLinkStyle();
            this.logName.htmlText = "欢迎回来: <a href=\'https://u.4399.com/user/info\' target=\'_blank\'>" + this._mainProxy.userNickName + "</a>";
         }
         this._btnLogout = new Sprite();
         var _loc2_:TextField = new TextField();
         _loc2_.defaultTextFormat = new TextFormat("宋体",13,16777215);
         _loc2_.htmlText = "(<u>退出</u>)";
         _loc2_.mouseEnabled = false;
         _loc2_.autoSize = TextFieldAutoSize.LEFT;
         _loc2_.multiline = false;
         _loc2_.wordWrap = false;
         _loc2_.mouseEnabled = false;
         this._btnLogout.addChild(_loc2_);
         this._btnLogout.buttonMode = true;
         this._btnLogout.addEventListener(MouseEvent.CLICK,this.logOutHandler,false,0,true);
         addToBg(this.logName,int((502 - this.logName.width - this._btnLogout.width - 40) * 0.5) + 40,8);
         addToBg(this._btnLogout,Math.ceil(this.logName.x + this.logName.width) - 5,8);
         addEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler,false,0,true);
         addEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHanlder,false,0,true);
         addEventListener(MouseEvent.MOUSE_UP,this.mouseRollOverHandler,false,0,true);
         addEventListener(MouseEvent.MOUSE_DOWN,this.mouseRollOverHandler,false,0,true);
         this.picAry = new Array();
         this.picSp = new Sprite();
         this.picHei = this._scaleY * this.picHei;
         this.creatPicFun(0,8);
         append(this.picSp,38,85);
         this.pageMc = new PageModule();
         var _loc3_:int = int((this.width - this.pageMc.width) * 0.5);
         var _loc4_:int = int(this.picSp.y + this.picSp.height + 10);
         append(this.pageMc,_loc3_,_loc4_);
         this.pageMc.addEventListener("pageEvent",this.onPageHandler);
         this.noticeSp = new NoticeModule();
         this.noticeSp.setConent("您好，这里是商城信息！");
         append(this.noticeSp,20,3);
         this.payBtn = new PayBtn();
         append(this.payBtn,this.width - 60,37);
         this.moneyTxt = new TextField();
         this.moneyTxt.height = 20;
         this.moneyTxt.defaultTextFormat = new TextFormat("宋体",13,16777215,null,null,null,null,null,"left");
         this.moneyTxt.text = "正在获取余额";
         this.moneyTxt.wordWrap = false;
         this.moneyTxt.multiline = false;
         this.moneyTxt.autoSize = "left";
         this.moneyTxt.selectable = false;
         append(this.moneyTxt,int(this.payBtn.x - this.moneyTxt.width - 5),this.payBtn.y + 3);
         var _loc5_:ComboBoxModule = new ComboBoxModule();
         append(_loc5_,20,37);
         if(_loc5_)
         {
            this.typeCom = new SelectMc(_loc5_,"scrollTxt_btn");
            append(this.typeCom,20,37);
            this.typeCom.setTxt("请选择物品分类");
         }
         this.desModule = new DescribeModule();
         this.desModule.visible = false;
         append(this.desModule,10,10);
         this.zdBgMc = new ZdBgMc();
         this.zdBgMc.scaleY = this._scaleY;
         this.zdBgMc.visible = false;
         append(this.zdBgMc,0,0);
         this._errorTip = view["tmp"]["errorTip"] as Sprite;
         this._ggBg = view["tmp"]["ggBg"] as MovieClip;
         this._titleMc = view["tmp"]["titleMc"] as MovieClip;
         if(this._errorTip != null)
         {
            _loc6_ = this._errorTip.x;
            _loc7_ = this._errorTip.y;
            this._errorTxt = this._errorTip["title"] as TextField;
            if(this._errorTxt != null)
            {
               this._errorTxt.selectable = false;
            }
            this._errorTip.visible = false;
            this._errorTip.scaleX = this._errorTip.scaleY = 1.1;
            this._closeBtn = this._errorTip["closeTipBtn"] as SimpleButton;
            if(this._closeBtn != null)
            {
               this._closeBtn.x = -this._closeBtn.width * 0.5;
               this._closeBtn.addEventListener(MouseEvent.CLICK,this.onCloseSelfHandler);
            }
            _loc8_ = this._errorTip["payTipBtn"] as SimpleButton;
            if(_loc8_ != null)
            {
               _loc8_.visible = false;
               if(this._errorTip.contains(_loc8_))
               {
                  this._errorTip.removeChild(_loc8_);
               }
               _loc8_ = null;
            }
            append(this._errorTip,view["tmp"].x + _loc6_,view["tmp"].y + _loc7_);
         }
         this._waitMc = view["tmp"]["wait_Mc"] as MovieClip;
         if(this._waitMc != null)
         {
            _loc6_ = this._waitMc.x;
            _loc7_ = this._waitMc.y;
            this._waitMc.stop();
            this._waitMc.visible = false;
            append(this._waitMc,view["tmp"].x + _loc6_,view["tmp"].y + _loc7_);
         }
      }
      
      public function setTypeFun(param1:Array) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(this.noticeSp)
         {
            this.noticeSp.setConent(String(param1[0]));
         }
         this.payMoney = param1[1];
         if(this.typeCom == null)
         {
            return;
         }
         var _loc2_:Array = param1[2] as Array;
         if(_loc2_ == null || _loc2_.length == 0)
         {
            return;
         }
         this.curType = 0;
         this.typeCom.setTxt(_loc2_[0],_loc2_);
         this.typeCom.addEventListener(ChaneEvent.CHANGE,this.onchangeHandler);
         if(this._titleMc == null || this._ggBg == null)
         {
            return;
         }
         if(param1[0] == undefined || String(param1[0]) == "")
         {
            this.changePosFun(-1 * this._yspan,-1 * 1,false);
         }
      }
      
      private function changePosFun(param1:int, param2:int, param3:Boolean) : void
      {
         this._titleMc.y += param1;
         this._ggBg.visible = param3;
         this.moneyTxt.y += param1 + param2;
         this.payBtn.y += param1 + param2;
         this.picSp.y += param1;
         this.typeCom.setPosY(param1 + param2);
      }
      
      private function onchangeHandler(param1:ChaneEvent) : void
      {
         trace("分类---->" + param1._id);
         var _loc2_:int = int(param1._id);
         if(_loc2_ == this.curType)
         {
            return;
         }
         this.curType = _loc2_;
         this.remCurPage = 0;
         if(this.picAry == null || this.picAry[this.curType] == undefined)
         {
            if(this._waitMc != null)
            {
               this._waitMc.play();
               this._waitMc.visible = true;
               this.zdBgMc.visible = true;
            }
            dispatchEvent(new DataEvent("changeShopType",false,false,String(this.curType)));
         }
         else
         {
            this.readBufferFun(this.remCurPage);
            this.pageMc.setPageFun(1,this.pageAry[this.curType]);
         }
      }
      
      private function onPageHandler(param1:DataEvent) : void
      {
         var _loc2_:String = null;
         this.remCurPage = int(param1.data) - 1;
         if(this.picAry == null || this.picAry[this.curType] == undefined || this.picAry[this.curType][this.remCurPage] == undefined)
         {
            if(this._waitMc != null)
            {
               this._waitMc.play();
               this._waitMc.visible = true;
               this.zdBgMc.visible = true;
            }
            _loc2_ = String(param1.data) + "," + this.curType;
            dispatchEvent(new DataEvent("changeShopPage",false,false,_loc2_));
         }
         else
         {
            this.readBufferFun(this.remCurPage);
         }
      }
      
      private function readBufferFun(param1:int) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         if(this.picSp == null)
         {
            return;
         }
         while(this.picSp.numChildren)
         {
            this.picSp.removeChildAt(0);
         }
         var _loc2_:Array = this.picAry[this.curType][param1];
         if(_loc2_ == null)
         {
            return;
         }
         for(_loc3_ in _loc2_)
         {
            _loc4_ = _loc2_[_loc3_];
            if(_loc4_ != null)
            {
               _loc4_.x = _loc3_ % 4 * (this.picWid + this.xspan);
               _loc4_.y = int(_loc3_ / 4) * (this.picHei + this.yspan);
               this.picSp.addChild(_loc4_);
            }
         }
      }
      
      private function creatPicFun(param1:uint, param2:uint) : void
      {
         var _loc4_:PicModule = null;
         if(this.picSp == null)
         {
            return;
         }
         if(this.picAry == null)
         {
            this.picAry = new Array();
         }
         if(this.picAry[this.curType] == undefined)
         {
            this.picAry[this.curType] = new Array();
         }
         if(this.picAry[this.curType][param1] == undefined)
         {
            this.picAry[this.curType][param1] = new Array();
         }
         if(param2 > this.maxPicNum)
         {
            param2 = this.maxPicNum;
         }
         while(this.picSp.numChildren)
         {
            this.picSp.removeChildAt(0);
         }
         var _loc3_:int = 0;
         while(_loc3_ < param2)
         {
            _loc4_ = new PicModule();
            _loc4_.itemNum = _loc3_;
            _loc4_.scaleY = this._scaleY;
            _loc4_.x = _loc3_ % 4 * (this.picWid + this.xspan);
            _loc4_.y = int(_loc3_ / 4) * (this.picHei + this.yspan);
            this.picAry[this.curType][param1][_loc3_] = _loc4_;
            this.picSp.addChild(_loc4_);
            _loc3_++;
         }
      }
      
      public function changeMoneyFun(param1:String) : void
      {
         if(this.moneyTxt == null)
         {
            return;
         }
         this.moneyTxt.text = "余额:" + param1;
         this.moneyTxt.x = int(this.payBtn.x - this.moneyTxt.width - 5);
      }
      
      public function set canPayMoney(param1:Boolean) : void
      {
         if(this.payBtn == null)
         {
            return;
         }
         if(param1)
         {
            this.payBtn.addEventListener(MouseEvent.CLICK,this.onPayMoneyHandler,false,0,true);
         }
         else
         {
            this.payBtn.removeEventListener(MouseEvent.CLICK,this.onPayMoneyHandler);
         }
      }
      
      private function onPayMoneyHandler(param1:MouseEvent) : void
      {
         this._mainProxy.payMoneyFun(this.payMoney);
         this.isNoMoney = true;
         this.showError("请在弹出的新页面完成充值,充值成功后点击关闭！");
      }
      
      public function showPicItemFun(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc5_:* = undefined;
         if(param1 == null)
         {
            return;
         }
         var _loc2_:Object = param1.shift();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:int = _loc2_.cur - 1;
         if(_loc3_ < 0)
         {
            return;
         }
         if(this.curPageAry == null)
         {
            this.curPageAry = new Array();
         }
         if(this.curPageAry[this.curType] == undefined)
         {
            this.curPageAry[this.curType] = new Array();
         }
         if(this.curPageAry[this.curType][_loc3_] == undefined)
         {
            this.curPageAry[this.curType][_loc3_] = new Array();
         }
         this.curPageAry[this.curType][_loc3_] = param1;
         if(this.picAry == null || this.picAry[this.curType] == undefined || this.picAry[this.curType][_loc3_] == undefined)
         {
            this.creatPicFun(_loc3_,param1.length);
         }
         if(this.picAry[this.curType][_loc3_].length > param1.length)
         {
            _loc4_ = int(param1.length);
            while(_loc4_ < this.picAry[this.curType][_loc3_].length)
            {
               _loc5_ = this.picAry[this.curType][_loc3_][_loc4_];
               if((Boolean(_loc5_)) && this.picSp.contains(_loc5_))
               {
                  this.picSp.removeChild(_loc5_);
                  _loc5_ = null;
               }
               _loc4_++;
            }
            this.picAry[this.curType][_loc3_].splice(param1.length);
         }
         this.showItemDataFun(this.picAry[this.curType][_loc3_],param1);
         this.remCurPage = _loc3_;
         this.pageMc.setPageFun(_loc2_.cur,_loc2_.total);
         if(this.pageAry == null)
         {
            this.pageAry = new Array();
         }
         this.pageAry[this.curType] = _loc2_.total;
      }
      
      private function showItemDataFun(param1:Array, param2:Array) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:Object = null;
         for(_loc3_ in param2)
         {
            _loc4_ = param1[_loc3_];
            _loc5_ = param2[_loc3_];
            if(_loc4_)
            {
               _loc4_.setPicFun(_loc5_.thumb,_loc5_.title);
            }
         }
         if(this._waitMc != null)
         {
            this._waitMc.stop();
            this._waitMc.visible = false;
            this.zdBgMc.visible = false;
         }
         if(this.picSp == null)
         {
            return;
         }
         this.picSp.addEventListener(MouseEvent.MOUSE_OUT,this.onPicItemHandler);
         this.picSp.addEventListener(MouseEvent.MOUSE_OVER,this.onPicItemHandler);
         this.picSp.addEventListener(MouseEvent.CLICK,this.onPicItemHandler);
      }
      
      private function onPicItemHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = undefined;
         var _loc4_:Bitmap = null;
         var _loc5_:String = null;
         _loc2_ = param1.target;
         if(_loc2_ == null || _loc2_.itemNum == undefined || this.curPageAry == null || this.curPageAry[this.curType] == undefined || this.curPageAry[this.curType][this.remCurPage] == undefined)
         {
            return;
         }
         var _loc3_:Object = this.curPageAry[this.curType][this.remCurPage][_loc2_.itemNum];
         if(_loc3_ == null)
         {
            return;
         }
         switch(param1.type)
         {
            case "click":
               if(this._shopProxy == null || this.curItme == _loc2_.itemNum)
               {
                  break;
               }
               this.curItme = _loc2_.itemNum;
               _loc4_ = _loc2_.getPicBitMap();
               this._shopProxy.showShopItemFun(_loc4_,_loc3_);
               break;
            case "mouseOver":
               if(this.desModule != null)
               {
                  _loc5_ = _loc3_.title + "：" + _loc3_.description;
                  this.desModule.setConent(_loc5_);
                  this.desModule.setDirX(68);
                  this.desModule.x = _loc2_.x + (this.picWid - this.desModule.width) * 0.5 + this.picSp.x;
                  this.desModule.y = _loc2_.y + this.picHei - 5 + this.picSp.y;
                  this.desModule.visible = true;
               }
               _loc2_.startMoveTxtFun();
               break;
            case "mouseOut":
               if(this.desModule != null)
               {
                  this.desModule.visible = false;
               }
               _loc2_.stopMoveTxtFun();
         }
      }
      
      public function showError(param1:String) : void
      {
         if(this._errorTip != null)
         {
            if(this._errorTxt != null)
            {
               this._errorTxt.wordWrap = false;
               this._errorTxt.text = param1;
               if(this._errorTxt.textWidth > this._errorTxt.width)
               {
                  this._errorTxt.wordWrap = true;
               }
            }
            this._errorTip.visible = true;
            this.zdBgMc.visible = true;
         }
         if(this._waitMc != null)
         {
            this._waitMc.stop();
            this._waitMc.visible = false;
         }
      }
      
      private function onCloseSelfHandler(param1:MouseEvent) : void
      {
         if(this._errorTip != null)
         {
            this._errorTip.visible = false;
         }
         if(this.zdBgMc != null)
         {
            this.zdBgMc.visible = false;
         }
         if(this.isNoMoney)
         {
            this._mainProxy.getMoneyFun();
            this.isNoMoney = false;
         }
      }
      
      public function start() : void
      {
         this.canPayMoney = false;
         if(this._waitMc != null)
         {
            this._waitMc.visible = true;
            this.zdBgMc.visible = true;
            this._waitMc.play();
         }
         if(this._errorTip != null)
         {
            this._errorTip.visible = false;
         }
      }
      
      private function logOutHandler(param1:MouseEvent) : void
      {
         this._mainProxy.loginOut();
      }
      
      private function mouseRollOverHandler(param1:MouseEvent = null) : void
      {
         if(!this._mainProxy.mouseVisible)
         {
            Mouse.show();
         }
      }
      
      private function mouseRollOutHanlder(param1:MouseEvent = null) : void
      {
         if(!this._mainProxy.mouseVisible)
         {
            Mouse.hide();
         }
      }
      
      private function checkBtnFun(param1:* = null, param2:int = -1) : void
      {
         if(param2 == 2)
         {
            this.picAry = null;
            this.curPageAry = null;
            this.desModule = null;
            this.curItme = -1;
            if(this.picSp != null)
            {
               while(this.picSp.numChildren)
               {
                  this.picSp.removeChildAt(0);
               }
               this.picSp.removeEventListener(MouseEvent.MOUSE_OUT,this.onPicItemHandler);
               this.picSp.removeEventListener(MouseEvent.MOUSE_OVER,this.onPicItemHandler);
               this.picSp.removeEventListener(MouseEvent.CLICK,this.onPicItemHandler);
               this.picSp = null;
            }
            if(this.typeCom != null)
            {
               this.typeCom.removeEventListener(ChaneEvent.CHANGE,this.onchangeHandler);
            }
            if(this.pageMc != null)
            {
               this.pageMc.removeEventListener("pageEvent",this.onPageHandler);
               this.pageMc = null;
            }
            if(this.payBtn != null)
            {
               this.payBtn.removeEventListener(MouseEvent.CLICK,this.onPayMoneyHandler);
               this.payBtn = null;
            }
            if(this.noticeSp != null)
            {
               this.noticeSp.clearFun();
               this.noticeSp = null;
            }
            if(this._btnLogout != null)
            {
               this._btnLogout.removeEventListener(MouseEvent.CLICK,this.logOutHandler);
               this._btnLogout = null;
            }
            removeEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler);
            removeEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHanlder);
            removeEventListener(MouseEvent.MOUSE_UP,this.mouseRollOverHandler);
            removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseRollOverHandler);
            if(!this._mainProxy.mouseVisible)
            {
               Mouse.hide();
            }
            if(this._titleMc != null)
            {
               this._titleMc = null;
            }
            if(this._ggBg != null)
            {
               this._ggBg = null;
            }
            if(this._waitMc != null)
            {
               this._waitMc.stop();
               this._waitMc = null;
            }
            if(this._closeBtn != null)
            {
               this._closeBtn.removeEventListener(MouseEvent.CLICK,this.onCloseSelfHandler);
               this._closeBtn = null;
            }
            if(this._errorTip != null)
            {
               this._errorTip = null;
            }
            if(this.zdBgMc != null)
            {
               this.zdBgMc = null;
            }
            dispatchEvent(new Event(AllConst.CLOSE_BTN_CLICK));
         }
      }
      
      public function disPose() : void
      {
         super.closeHandler(new MouseEvent(MouseEvent.CLICK));
      }
   }
}

