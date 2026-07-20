package ctrl4399.view.components
{
   import ctrl4399.proxy.MainProxy;
   import ctrl4399.proxy.ShopProxy;
   import ctrl4399.strconst.AllConst;
   import ctrl4399.view.components.shopModule.*;
   import ctrl4399.view.components.styleConst.StyleClass;
   import flash.display.Bitmap;
   import flash.display.Shape;
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
   
   public class ShopItemView extends SetBox
   {
      
      private var _mainProxy:MainProxy;
      
      private var _shopProxy:ShopProxy;
      
      private var _facade:Facade;
      
      private var logName:TextField;
      
      private var _btnLogout:Sprite;
      
      private var _errorTip:Sprite;
      
      private var _errorTxt:TextField;
      
      private var _closeBtn:SimpleButton;
      
      private var _payTipBtn:SimpleButton;
      
      private var payBtn:PayBtn;
      
      private var itemSp:Sprite;
      
      private var picModule:PicModule;
      
      private var totalMoneyTxt:TextField;
      
      private var subAddMoudle:SubAddModule;
      
      private var buyBtn:BuyBtn;
      
      private var buyCancelBtn:BuyCancelBtn;
      
      private var scroll_mc:ScrollBarMc;
      
      private var maskSp:Shape;
      
      private var zdBgMc:ZdBgMc;
      
      private var body_mc:Sprite;
      
      private var totalMoneySp:Sprite;
      
      private var moneyTxt:TextField;
      
      private var buCountTxt:TextField;
      
      private var payMoney:int = 1;
      
      private var _scaleY:Number = 1.1;
      
      private var buyMoney:int = 0;
      
      private var closeOldX:Number = 0;
      
      private var isNoMoney:Boolean = false;
      
      private var proId:String = "";
      
      private var proName:String = "";
      
      public function ShopItemView()
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         this._facade = Facade.getInstance();
         super();
         this._mainProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_MAIN) as MainProxy;
         this._shopProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_SHOP) as ShopProxy;
         var _loc1_:Object = new Object();
         _loc1_.viewClass = Singleton.getClass(AllConst.SPC_View_Shop_Item);
         _loc1_.contentViewClass = Singleton.getClass(AllConst.SPC_Cont_Shop_Item);
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
         this._btnLogout.addChild(_loc2_);
         this._btnLogout.buttonMode = true;
         this._btnLogout.addEventListener(MouseEvent.CLICK,this.logOutHandler,false,0,true);
         addToBg(this.logName,int((502 - this.logName.width - this._btnLogout.width - 40) * 0.5) + 40,8);
         addToBg(this._btnLogout,Math.ceil(this.logName.x + this.logName.width) - 5,8);
         addEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler,false,0,true);
         addEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHanlder,false,0,true);
         addEventListener(MouseEvent.MOUSE_UP,this.mouseRollOverHandler,false,0,true);
         addEventListener(MouseEvent.MOUSE_DOWN,this.mouseRollOverHandler,false,0,true);
         this.payBtn = new PayBtn();
         append(this.payBtn,this.width - 60,17);
         this.moneyTxt = new TextField();
         this.moneyTxt.height = 20;
         this.moneyTxt.defaultTextFormat = new TextFormat("宋体",13,16777215);
         this.moneyTxt.text = "正在获取余额";
         this.moneyTxt.wordWrap = false;
         this.moneyTxt.multiline = false;
         this.moneyTxt.autoSize = "left";
         this.moneyTxt.selectable = false;
         append(this.moneyTxt,int(this.payBtn.x - this.moneyTxt.width - 5),this.payBtn.y + 3);
         this.itemSp = new Sprite();
         this.picModule = new PicModule();
         this.picModule.scaleY = this._scaleY;
         this.itemSp.addChild(this.picModule);
         append(this.itemSp,20,65);
         this.totalMoneySp = new Sprite();
         var _loc3_:MoneyIcon = new MoneyIcon();
         this.totalMoneySp.addChild(_loc3_);
         this.totalMoneyTxt = new TextField();
         this.totalMoneyTxt.height = 18;
         this.totalMoneyTxt.multiline = false;
         this.totalMoneyTxt.wordWrap = false;
         this.totalMoneyTxt.autoSize = "left";
         this.totalMoneyTxt.defaultTextFormat = new TextFormat("宋体",15,16763904);
         this.totalMoneyTxt.text = "0";
         this.totalMoneyTxt.selectable = false;
         this.totalMoneyTxt.x = int(_loc3_.x + _loc3_.width) - 1;
         this.totalMoneyTxt.y = int(_loc3_.y + (_loc3_.height - this.totalMoneyTxt.height) * 0.5) - 2;
         this.totalMoneySp.addChild(this.totalMoneyTxt);
         var _loc4_:int = int(this.itemSp.x);
         var _loc5_:int = int(this.itemSp.y + this.itemSp.height + 8);
         append(this.totalMoneySp,_loc4_,_loc5_);
         this.subAddMoudle = new SubAddModule();
         this.subAddMoudle.scaleY = this._scaleY;
         append(this.subAddMoudle,338,260);
         this.buCountTxt = new TextField();
         this.buCountTxt.height = 20;
         this.buCountTxt.defaultTextFormat = new TextFormat("宋体",13,16777215);
         this.buCountTxt.text = "每人限购：";
         this.buCountTxt.wordWrap = false;
         this.buCountTxt.multiline = false;
         this.buCountTxt.autoSize = "left";
         this.buCountTxt.visible = false;
         this.buCountTxt.selectable = false;
         append(this.buCountTxt,10,262);
         this.buyCancelBtn = new BuyCancelBtn();
         this.buyCancelBtn.addEventListener(MouseEvent.CLICK,this.onCancelHandler);
         append(this.buyCancelBtn,268,310);
         this.buyBtn = new BuyBtn();
         this.buyBtn.addEventListener(MouseEvent.CLICK,this.onBuyHandler);
         append(this.buyBtn,110,310);
         this.maskSp = new Shape();
         this.maskSp.graphics.clear();
         this.maskSp.graphics.beginFill(0,0);
         this.maskSp.graphics.drawRect(0,0,330,175);
         this.maskSp.graphics.endFill();
         _loc4_ = int(this.itemSp.x + this.itemSp.width + 30);
         _loc5_ = int(this.itemSp.y);
         append(this.maskSp,_loc4_,_loc5_);
         this.body_mc = new Sprite();
         append(this.body_mc,_loc4_,_loc5_);
         this.scroll_mc = new ScrollBarMc();
         _loc4_ = int(this.maskSp.x + this.maskSp.width);
         _loc5_ = int(this.maskSp.y);
         append(this.scroll_mc,_loc4_,_loc5_);
         this.zdBgMc = new ZdBgMc();
         this.zdBgMc.scaleY = this._scaleY;
         this.zdBgMc.visible = false;
         append(this.zdBgMc,0,0);
         this._errorTip = view["tmp"]["errorTip"] as Sprite;
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
               this.closeOldX = this._closeBtn.x;
               this._closeBtn.addEventListener(MouseEvent.CLICK,this.onTipHandler);
            }
            this._payTipBtn = this._errorTip["payTipBtn"] as SimpleButton;
            if(this._payTipBtn != null)
            {
               this._payTipBtn.addEventListener(MouseEvent.CLICK,this.onTipHandler);
            }
            append(this._errorTip,view["tmp"].x + _loc6_,view["tmp"].y + _loc7_);
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
      
      public function showError(param1:String) : void
      {
         if(this._errorTip != null)
         {
            if(this._errorTxt != null)
            {
               if(param1 == AllConst.NO_Enough_Money)
               {
                  this._payTipBtn.visible = true;
                  this._closeBtn.x = this.closeOldX;
                  param1 = "您的账户余额不够支付，请充值后购买！";
               }
               else
               {
                  this._payTipBtn.visible = false;
                  this._closeBtn.x = -this._closeBtn.width * 0.5;
               }
               if(param1 == AllConst.ADDPRO_SUCCESS)
               {
                  param1 = "您成功购买了" + this.proName + "!";
               }
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
      }
      
      private function onTipHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleButton = param1.target as SimpleButton;
         if(_loc2_ == null)
         {
            return;
         }
         switch(_loc2_.name)
         {
            case "closeTipBtn":
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
               break;
            case "payTipBtn":
               this.onPayMoneyHandler(param1);
               this.isNoMoney = true;
               this.showError("请在弹出的新页面完成充值,充值成功后点击关闭！");
         }
      }
      
      public function start(param1:Array) : void
      {
         var _loc2_:Bitmap = null;
         var _loc3_:Object = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         this.canPayMoney = false;
         this.isNoMoney = false;
         if(param1 != null && param1.length != 0)
         {
            _loc2_ = param1[0];
            _loc3_ = param1[1];
            if(_loc2_ != null)
            {
               this.picModule.addPicAndNameFun(_loc2_,_loc3_.title);
               this.picModule.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseHandler,false,0,true);
               this.picModule.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseHandler,false,0,true);
            }
            if(_loc3_.price != undefined)
            {
               this.buyMoney = int(_loc3_.price);
               this.totalMoneyTxt.text = String(this.buyMoney);
               _loc5_ = int(this.itemSp.x + (this.itemSp.width - this.totalMoneySp.width) * 0.5);
               this.totalMoneySp.x = _loc5_;
            }
            if(_loc3_.infinite != undefined)
            {
               this.buCountTxt.text = "每人限购：" + int(_loc3_.infinite);
               this.buCountTxt.x = int(this.subAddMoudle.x - this.buCountTxt.width - 5);
               this.buCountTxt.visible = Boolean(int(_loc3_.infinite));
               _loc6_ = int(_loc3_.infinite);
               if(!this.buCountTxt.visible)
               {
                  _loc6_ = 999;
               }
               this.subAddMoudle.setSubAddFun(_loc6_,1);
               this.subAddMoudle.addEventListener("addSubEvent",this.onChangePriceHandler);
            }
            this.proId = _loc3_.id.toString();
            this.proName = _loc3_.title.toString();
            _loc4_ = _loc3_.keys as Array;
            this.creatDgInfoFun(_loc4_,_loc3_.description);
            this.payMoney = param1[2];
         }
         if(this._errorTip != null)
         {
            this._errorTip.visible = false;
            this.zdBgMc.visible = false;
         }
      }
      
      private function onMouseHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = param1.target;
         if(_loc2_ == null)
         {
            return;
         }
         switch(param1.type)
         {
            case "mouseOut":
               _loc2_.stopMoveTxtFun();
               break;
            case "mouseOver":
               _loc2_.startMoveTxtFun();
         }
      }
      
      private function creatDgInfoFun(param1:Array, param2:String) : void
      {
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:Sprite = null;
         var _loc11_:Sprite = null;
         var _loc12_:* = undefined;
         var _loc13_:Object = null;
         var _loc14_:TextField = null;
         var _loc15_:TextField = null;
         var _loc16_:Sprite = null;
         if(this.body_mc == null)
         {
            return;
         }
         while(this.body_mc.numChildren)
         {
            this.body_mc.removeChildAt(0);
         }
         var _loc3_:Sprite = new Sprite();
         var _loc4_:int = 5;
         if(param1 != null && param1.length > 0)
         {
            _loc7_ = 15;
            _loc8_ = -1;
            _loc9_ = 0;
            _loc10_ = new Sprite();
            _loc11_ = new Sprite();
            _loc3_.addChild(_loc10_);
            _loc3_.addChild(_loc11_);
            for(_loc12_ in param1)
            {
               _loc13_ = Object(param1[_loc12_]);
               if(_loc13_ != null)
               {
                  _loc14_ = this.creatTxtFun("left",16777215,60);
                  _loc14_.text = _loc13_["proName"].toString() + ":";
                  _loc15_ = this.creatTxtFun("left",16023328,70);
                  _loc15_.text = _loc13_["proValue"].toString();
                  if(++_loc8_ >= 2)
                  {
                     _loc8_ = 0;
                     _loc9_++;
                  }
                  _loc14_.x = 0;
                  _loc15_.x = _loc14_.x + _loc14_.width;
                  _loc15_.y = _loc9_ * (_loc15_.height + _loc4_);
                  _loc14_.y = _loc15_.y;
                  _loc16_ = new Sprite();
                  if(_loc8_)
                  {
                     _loc16_ = _loc11_;
                     _loc16_.x = _loc10_.x + _loc10_.width + _loc7_;
                  }
                  else
                  {
                     _loc16_ = _loc10_;
                  }
                  _loc16_.addChild(_loc14_);
                  _loc16_.addChild(_loc15_);
               }
            }
         }
         var _loc5_:TextField = this.creatTxtFun("left",16777215,60);
         _loc5_.text = "物品描述:";
         var _loc6_:TextField = this.creatTxtFun("left",16023328,250,true,true);
         _loc6_.text = param2;
         _loc5_.x = _loc3_.x;
         _loc6_.x = _loc5_.x + _loc5_.width;
         if(_loc3_.height == 0)
         {
            _loc6_.y = _loc5_.y = _loc3_.y + _loc3_.height;
         }
         else
         {
            _loc6_.y = _loc5_.y = _loc3_.y + _loc3_.height + _loc4_;
         }
         this.body_mc.addChild(_loc3_);
         this.body_mc.addChild(_loc5_);
         this.body_mc.addChild(_loc6_);
         this.scroll_mc.scrolling(this.body_mc,this.maskSp,0.2);
      }
      
      private function creatTxtFun(param1:String, param2:uint, param3:int, param4:Boolean = false, param5:Boolean = false) : TextField
      {
         var _loc6_:TextField = new TextField();
         _loc6_.selectable = false;
         _loc6_.height = 28;
         _loc6_.width = param3;
         _loc6_.autoSize = param1;
         _loc6_.multiline = param4;
         _loc6_.wordWrap = param5;
         var _loc7_:TextFormat = new TextFormat("宋体",13,param2);
         _loc6_.defaultTextFormat = _loc7_;
         return _loc6_;
      }
      
      private function onChangePriceHandler(param1:DataEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:Number = this.buyMoney * int(param1.data);
         if(_loc2_ > int.MAX_VALUE)
         {
            this.subAddMoudle.isAdd = false;
            this.subAddMoudle.isSub = true;
            _loc3_ = this.getTotalMoneyFun();
            _loc4_ = int(_loc3_ / this.buyMoney);
            this.subAddMoudle.setBuyNumTxtFun(_loc4_);
         }
         else if(_loc2_ < int.MIN_VALUE)
         {
            this.subAddMoudle.isAdd = true;
            this.subAddMoudle.isSub = false;
         }
         else
         {
            this.subAddMoudle.isAdd = true;
            this.subAddMoudle.isSub = true;
            this.totalMoneyTxt.text = String(_loc2_);
            _loc5_ = int(this.itemSp.x + (this.itemSp.width - this.totalMoneySp.width) * 0.5);
            this.totalMoneySp.x = _loc5_;
         }
      }
      
      private function getTotalMoneyFun() : int
      {
         if(this.totalMoneyTxt == null)
         {
            return 0;
         }
         return int(this.totalMoneyTxt.text);
      }
      
      private function onBuyHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = this.getTotalMoneyFun();
         var _loc3_:int = int(_loc2_ / this.buyMoney);
         if(this._shopProxy != null)
         {
            this._shopProxy.buyProFun([_loc3_,this.proId]);
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
      
      private function onCancelHandler(param1:MouseEvent) : void
      {
         this.disPose();
      }
      
      private function checkBtnFun(param1:* = null, param2:int = -1) : void
      {
         if(param2 == 2)
         {
            if(this.picModule)
            {
               this.picModule.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseHandler);
               this.picModule.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseHandler);
               this.picModule = null;
            }
            if(this.totalMoneySp != null)
            {
               while(this.totalMoneySp.numChildren)
               {
                  this.totalMoneySp.removeChildAt(0);
               }
               this.totalMoneySp = null;
            }
            if(this.subAddMoudle != null)
            {
               this.subAddMoudle.removeEventListener("addSubEvent",this.onChangePriceHandler);
               this.subAddMoudle = null;
            }
            if(this.buyBtn != null)
            {
               this.buyBtn.removeEventListener(MouseEvent.CLICK,this.onBuyHandler);
               this.buyBtn = null;
            }
            if(this.buyCancelBtn != null)
            {
               this.buyCancelBtn.removeEventListener(MouseEvent.CLICK,this.onCancelHandler);
               this.buyCancelBtn = null;
            }
            if(this.payBtn != null)
            {
               this.payBtn.removeEventListener(MouseEvent.CLICK,this.onPayMoneyHandler);
               this.payBtn = null;
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
            if(this._closeBtn != null)
            {
               this._closeBtn.removeEventListener(MouseEvent.CLICK,this.onTipHandler);
               this._closeBtn = null;
            }
            if(this._payTipBtn != null)
            {
               this._payTipBtn.removeEventListener(MouseEvent.CLICK,this.onTipHandler);
               this._payTipBtn = null;
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

