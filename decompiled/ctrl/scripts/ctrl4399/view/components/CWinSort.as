package ctrl4399.view.components
{
   import ctrl4399.proxy.MainProxy;
   import ctrl4399.proxy.SortProxy;
   import ctrl4399.strconst.AllConst;
   import ctrl4399.view.components.sortlist.SList;
   import ctrl4399.view.components.sortlist.SelfItem;
   import ctrl4399.view.components.styleConst.StyleClass;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.ui.Mouse;
   import frame4399.simplePureMvc.core.Facade;
   import org.heaven.impl.tot.Singleton;
   import org.hell.SetBox;
   import org.hell.TabPages;
   
   public class CWinSort extends SetBox
   {
      
      private var btnWorld:*;
      
      private var btnFriend:*;
      
      private var _listSelf:SelfItem;
      
      private var _loadType:String = "";
      
      private var _dtab:TabPages;
      
      private var _sList:SList;
      
      private var _day_now:Sprite;
      
      private var _day_month:Sprite;
      
      private var _day_tot:Sprite;
      
      private var _facade:Facade;
      
      private var _mainProxy:MainProxy;
      
      private var _sortProxy:SortProxy;
      
      private var _isShow:Boolean;
      
      private var _btnLogout:Sprite;
      
      private var _backBtn:SimpleButton;
      
      private var _errorTip:Sprite;
      
      private var _waitMc:MovieClip;
      
      private var _errorTxt:TextField;
      
      private var logName:TextField;
      
      public var isSortAPi:Boolean;
      
      public function CWinSort()
      {
         var _loc2_:TextField = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         this._day_now = new Sprite();
         this._day_month = new Sprite();
         this._day_tot = new Sprite();
         this._facade = Facade.getInstance();
         super();
         this._mainProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_MAIN) as MainProxy;
         this._sortProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_SORT) as SortProxy;
         var _loc1_:Object = new Object();
         _loc1_.viewClass = Singleton.getClass(AllConst.SPC_SortView);
         _loc1_.contentViewClass = Singleton.getClass(AllConst.SPC_SortCont);
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
         _loc2_ = new TextField();
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
         this._listSelf = new SelfItem();
         this._dtab = new TabPages();
         var _loc3_:Object = new Object();
         _loc3_.skinClass = null;
         _loc3_.tabHeight = 18;
         _loc3_.horSep = 0;
         _loc3_.tabPaddingWidth = 48;
         var _loc4_:Object = new Object();
         _loc4_.skinClass = Singleton.getClass(AllConst.SPC_SBtnBg);
         _loc4_.labelStyle = {
            "icon":null,
            "textFieldHolderClass":Singleton.getClass(AllConst.SPC_TabTxt),
            "textFieldStyle":null,
            "textFormatStyle":{
               "bold":false,
               "color":16777215,
               "size":13
            }
         };
         _loc4_.selectedLabelStyle = {
            "icon":null,
            "textFieldHolderClass":Singleton.getClass(AllConst.SPC_TabTxt),
            "textFieldStyle":null,
            "textFormatStyle":{
               "bold":false,
               "color":0,
               "size":13
            }
         };
         _loc3_.buttonStyle = _loc4_;
         this._dtab.initialize(this,new Rectangle(0,0,90,80),_loc3_);
         append(this._dtab,315,53);
         this._dtab.addPageAt("日排行",null,this._day_now,0);
         this._dtab.addPageAt("月排行",null,this._day_month,1);
         this._dtab.addPageAt("总排行",null,this._day_tot,2);
         this._dtab.addEventListener("changeTabPage",this.changeTabPageHandler,false,0,true);
         this._sList = new SList();
         this._sList.move(-297,8);
         this._day_now.addChild(this._sList);
         var _loc5_:Class = Singleton.getClass(AllConst.SORT_BACK_BTN_SKIN);
         this._backBtn = new _loc5_() as SimpleButton;
         append(this._backBtn,16.4,15);
         this._backBtn.addEventListener(MouseEvent.CLICK,this.backBtnDownHandler,false,0,true);
         this._errorTip = view["tmp"]["errorTip"] as Sprite;
         if(this._errorTip != null)
         {
            _loc6_ = this._errorTip.x;
            _loc7_ = this._errorTip.y;
            this._errorTip.mouseEnabled = false;
            this._errorTip.mouseChildren = false;
            this._errorTxt = this._errorTip["title"] as TextField;
            if(this._errorTxt != null)
            {
               this._errorTxt.selectable = false;
            }
            this._errorTip.visible = false;
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
         addEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler,false,0,true);
         addEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHanlder,false,0,true);
         addEventListener(MouseEvent.MOUSE_UP,this.mouseRollOverHandler,false,0,true);
         addEventListener(MouseEvent.MOUSE_DOWN,this.mouseRollOverHandler,false,0,true);
      }
      
      private function logOutHandler(param1:MouseEvent) : void
      {
         this._mainProxy.loginOut();
      }
      
      public function showError(param1:String) : void
      {
         if(this._errorTip != null)
         {
            if(this._errorTxt != null)
            {
               this._errorTxt.wordWrap = false;
               this._errorTxt.y = -15;
               this._errorTxt.text = param1;
               if(this._errorTxt.textWidth > this._errorTxt.width)
               {
                  this._errorTxt.wordWrap = true;
                  this._errorTxt.y = -48;
               }
            }
            this._errorTip.visible = true;
         }
         if(this._waitMc != null)
         {
            this._waitMc.stop();
            this._waitMc.visible = false;
         }
      }
      
      public function start() : void
      {
         if(Boolean(this._backBtn) && Boolean(this.logName) && Boolean(this._btnLogout))
         {
            this._backBtn.visible = this.logName.visible = this._btnLogout.visible = !this.isSortAPi;
         }
         this._dtab.selectedIndex = 0;
         if(this._waitMc != null)
         {
            this._waitMc.visible = true;
            this._waitMc.play();
         }
         if(this._errorTip != null)
         {
            this._errorTip.visible = false;
         }
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
      
      private function backBtnDownHandler(param1:MouseEvent) : void
      {
         this._backBtn.removeEventListener(MouseEvent.CLICK,this.backBtnDownHandler);
         dispatchEvent(new Event(AllConst.SORT_WIN_BAKC));
      }
      
      private function changeTabPageHandler(param1:Event) : void
      {
         switch(this._dtab.selectedIndex)
         {
            case 0:
               this._loadType = SortProxy.TYPE_DAY;
               break;
            case 1:
               this._loadType = SortProxy.TYPE_MONTH;
               break;
            case 2:
               this._loadType = SortProxy.TYPE_ALL;
         }
         if(this._waitMc != null)
         {
            this._waitMc.visible = true;
            this._waitMc.play();
         }
         dispatchEvent(new ComponentEvent(AllConst.CHANGE_SORT_TYPE,this._loadType));
      }
      
      public function upDataList(param1:Array, param2:String) : void
      {
         if(param2 != this._loadType)
         {
            return;
         }
         switch(param2)
         {
            case SortProxy.TYPE_DAY:
               this._day_now.addChild(this._sList);
               break;
            case SortProxy.TYPE_MONTH:
               this._day_month.addChild(this._sList);
               break;
            case SortProxy.TYPE_ALL:
               this._day_tot.addChild(this._sList);
         }
         if(this._waitMc != null)
         {
            this._waitMc.stop();
            this._waitMc.visible = false;
         }
         if(this._errorTip != null)
         {
            this._errorTip.visible = false;
         }
         this._sList.showData(param1);
      }
      
      private function checkBtnFun(param1:* = null, param2:int = -1) : void
      {
         if(param2 == 2)
         {
            if(!this._mainProxy.mouseVisible)
            {
               Mouse.hide();
            }
            if(this._waitMc != null)
            {
               this._waitMc.stop();
               this._waitMc = null;
            }
            if(this._errorTip != null)
            {
               this._errorTip = null;
            }
            this._loadType = "";
            removeEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler);
            removeEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHanlder);
            removeEventListener(MouseEvent.MOUSE_UP,this.mouseRollOverHandler);
            removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseRollOverHandler);
            this._btnLogout.removeEventListener(MouseEvent.CLICK,this.logOutHandler);
            dispatchEvent(new Event(AllConst.CLOSE_BTN_CLICK));
         }
      }
      
      public function updataPic(param1:DisplayObject, param2:String, param3:String) : void
      {
         if(param2 == this._loadType)
         {
            this._sList.upDataPic(param1,param3);
         }
      }
      
      public function disPose() : void
      {
         super.closeHandler(new MouseEvent(MouseEvent.CLICK));
      }
   }
}

