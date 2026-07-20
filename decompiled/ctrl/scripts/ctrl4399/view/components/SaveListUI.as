package ctrl4399.view.components
{
   import ctrl4399.proxy.MainProxy;
   import ctrl4399.strconst.AllConst;
   import ctrl4399.view.components.styleConst.StyleClass;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.ui.Mouse;
   import flash.utils.Timer;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import frame4399.simplePureMvc.core.Facade;
   import org.heaven.impl.tot.Singleton;
   import org.hell.SetBox;
   
   public class SaveListUI extends SetBox
   {
      
      public static const LOCAL_MODE:int = 1;
      
      public static const NET_MODE:int = 0;
      
      private var _btnTxt:TextField;
      
      private var _btnTxtFormat:TextFormat;
      
      private var _itemList:Array;
      
      private var _facade:Facade;
      
      private var mainProxy:MainProxy;
      
      private var _curClickIndex:int;
      
      private var _isSet:Boolean;
      
      private var _isInit:Boolean;
      
      private var _listData:Array;
      
      private var _waitMc:MovieClip;
      
      private var _logName:TextField;
      
      private const LOCAL_SAVE_TITLE:String = "保存进度";
      
      private const NET_SAVE_TITLE:String = "保存进度";
      
      private const LOCAL_GET_TITLE:String = "读取进度";
      
      private const NET_GET_TITLE:String = "读取进度";
      
      private var _titleTxtBack:TextField;
      
      private var _titleTxt:TextField;
      
      private var _curShowMode:int;
      
      private var _logBtn:Sprite;
      
      private var _btnLogout:Sprite;
      
      private var gdeTip:GetDataExcepTip;
      
      private var shape:Sprite;
      
      private var _hitEmpytTime:Timer;
      
      private const HIT_INC:Number = 0.1;
      
      private var _emptyTip:Sprite;
      
      private var _showMode:int;
      
      private var _saveTipUI:SaveTip;
      
      private var _saveTipX:Number;
      
      private var _saveTipY:Number;
      
      private var _showTipTxt:TextField;
      
      private var _isHitEmptyTip:Boolean;
      
      private var _hitEmptyTipId:uint;
      
      private var _upDataObj:Object;
      
      private var _isUpDataBol:Boolean;
      
      public function SaveListUI(param1:int, param2:int = 0)
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc7_:TextField = null;
         var _loc8_:TextField = null;
         this._facade = Facade.getInstance();
         super();
         this._showMode = param1;
         this._curShowMode = param2;
         this.mainProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_MAIN) as MainProxy;
         this._curClickIndex = -1;
         var _loc5_:Object = new Object();
         _loc5_.viewClass = Singleton.getClass(AllConst.SAVE_LIST_VIEW);
         _loc5_.contentViewClass = Singleton.getClass(AllConst.SPC_RegCont);
         _loc5_.tfd = new TextFormat();
         initSetBox("",_loc5_,null,this.checkBtnFun,null);
         setBtnVisible();
         this._btnTxt = new TextField();
         this.initBtnTxt();
         this.createItem();
         this._logName = new TextField();
         this._logName.defaultTextFormat = new TextFormat("宋体",13,16777215);
         if(this.mainProxy.userNickName != null && this.mainProxy.userNickName != "")
         {
            this._logName.styleSheet = StyleClass.userNameLinkStyle();
            this._logName.htmlText = "欢迎回来: <a href=\'https://u.4399.com/user/info\' target=\'_blank\'>" + this.mainProxy.userNickName + "</a>";
            this._logName.selectable = false;
            this._logName.autoSize = TextFieldAutoSize.LEFT;
            this._logName.multiline = false;
            this._logName.wordWrap = false;
            this._btnLogout = new Sprite();
            _loc7_ = new TextField();
            _loc7_.defaultTextFormat = new TextFormat("宋体",13,16777215);
            _loc7_.htmlText = "(<u>退出</u>)";
            _loc7_.mouseEnabled = false;
            _loc7_.autoSize = TextFieldAutoSize.LEFT;
            _loc7_.multiline = false;
            _loc7_.wordWrap = false;
            this._btnLogout.addChild(_loc7_);
            this._btnLogout.buttonMode = true;
            this._btnLogout.addEventListener(MouseEvent.CLICK,this.logOutHandler,false,0,true);
            addToBg(this._logName,int((502 - this._logName.width - this._btnLogout.width - 40) * 0.5) + 40,8);
            addToBg(this._btnLogout,Math.ceil(this._logName.x + this._logName.width) - 8,8);
         }
         this._titleTxt = view["tmp"].titleTxt as TextField;
         this._titleTxtBack = view["tmp"].titleTxtBack as TextField;
         this._titleTxt.selectable = false;
         this._titleTxt.mouseWheelEnabled = false;
         this._titleTxtBack.selectable = false;
         this._titleTxtBack.mouseWheelEnabled = false;
         if(param2 == LOCAL_MODE)
         {
            if(this._showMode == AllConst.SAVE_MODE)
            {
               this._titleTxt.text = this._titleTxtBack.text = this.LOCAL_SAVE_TITLE;
            }
            else if(this._showMode == AllConst.GET_MODE)
            {
               this._titleTxt.text = this._titleTxtBack.text = this.LOCAL_GET_TITLE;
            }
         }
         else if(param2 == NET_MODE)
         {
            if(this._showMode == AllConst.SAVE_MODE)
            {
               this._titleTxt.text = this._titleTxtBack.text = this.NET_SAVE_TITLE;
            }
            else if(this._showMode == AllConst.GET_MODE)
            {
               this._titleTxt.text = this._titleTxtBack.text = this.NET_GET_TITLE;
            }
         }
         setStageSize(502,357);
         moveCenter();
         addEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler,false,0,true);
         addEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHanlder,false,0,true);
         addEventListener(MouseEvent.MOUSE_UP,this.mouseRollOverHandler,false,0,true);
         addEventListener(MouseEvent.MOUSE_DOWN,this.mouseRollOverHandler,false,0,true);
         this._saveTipUI = new SaveTip();
         _loc3_ = view.width / 2;
         _loc4_ = view.height / 2;
         this._saveTipUI.visible = false;
         append(this._saveTipUI,_loc3_,_loc4_);
         var _loc6_:Class = Singleton.getClass(AllConst.WAIT_MC);
         this._waitMc = new _loc6_() as MovieClip;
         this._waitMc.mouseChildren = false;
         this._waitMc.mouseEnabled = false;
         _loc3_ = view.width / 2;
         _loc4_ = view.height / 2;
         append(this._waitMc,_loc3_,_loc4_);
         this._saveTipUI.addEventListener(AllConst.SAVE_TIP_DOWN,this.saveTipDownHandler,false,0,true);
         this._saveTipUI.addEventListener(AllConst.GetData_Excep,this.getDataExcepHandler,false,0,true);
         _loc6_ = Singleton.getClass(AllConst.EMPTY_TIP);
         this._emptyTip = new _loc6_() as Sprite;
         _loc3_ = view.width / 2;
         _loc4_ = view.height / 2;
         append(this._emptyTip,_loc3_,_loc4_);
         this._emptyTip.visible = false;
         this._showTipTxt = this._emptyTip["title"] as TextField;
         this._showTipTxt.selectable = false;
         this._showTipTxt.mouseEnabled = false;
         this._emptyTip.mouseChildren = false;
         this._emptyTip.mouseEnabled = false;
         this._showTipTxt.mouseWheelEnabled = false;
         this._showTipTxt.wordWrap = false;
         if(this._curShowMode == LOCAL_MODE)
         {
            this._logBtn = new Sprite();
            _loc8_ = new TextField();
            _loc8_.width = 40;
            _loc8_.height = 30;
            _loc8_.defaultTextFormat = new TextFormat("宋体",13,16777215,null,null,true);
            _loc8_.autoSize = TextFieldAutoSize.LEFT;
            _loc8_.text = "登录";
            _loc8_.mouseEnabled = false;
            this._logBtn.addChild(_loc8_);
            _loc3_ = 502 - this._logBtn.width - 30;
            append(this._logBtn,_loc3_,-18);
            this._logBtn.buttonMode = true;
            this._logBtn.addEventListener(MouseEvent.CLICK,this.logBtnDownHandler,false,0,true);
         }
         this.showLoading(true);
         this._isInit = true;
         if(this._isSet)
         {
            this.doSetListData();
         }
         if(this._isUpDataBol)
         {
            this.doUpDataAt();
         }
         this.addBg();
      }
      
      private function logBtnDownHandler(param1:MouseEvent) : void
      {
         trace("^^^^^^^^^^^^^^^^^^^^");
         dispatchEvent(new Event(AllConst.SAVE_UI_SHOW_LOG));
      }
      
      private function saveTipDownHandler(param1:ComponentEvent) : void
      {
         trace("saveListUI e.dat = " + param1.data);
         switch(param1.data)
         {
            case AllConst.SAVE_DATA:
               this._saveTipUI.visible = false;
               this.showLoading(true);
               dispatchEvent(new ComponentEvent(AllConst.SAVE_SERVER_DATA,this._curClickIndex));
               break;
            case AllConst.GET_DATA:
               this._saveTipUI.visible = false;
               this.showLoading(true);
               dispatchEvent(new ComponentEvent(AllConst.GET_SERVER_DATA,this._curClickIndex));
               break;
            case AllConst.SAVE_PRO:
               this._saveTipUI.showMode(AllConst.SAVE_COVER_MODE);
               break;
            case AllConst.GET_PRO:
               this._saveTipUI.showMode(AllConst.GET_MODE);
               break;
            case AllConst.CLOSE:
               this._saveTipUI.visible = false;
               break;
            case AllConst.SAVE_SUC_DATA:
               this.dispose();
         }
      }
      
      private function mouseRollOverHandler(param1:MouseEvent = null) : void
      {
         this._facade.sendNotification(AllConst.SET_AS2_FOCUSMANAGER);
         if(!this.mainProxy.mouseVisible)
         {
            Mouse.show();
         }
      }
      
      private function mouseRollOutHanlder(param1:MouseEvent = null) : void
      {
         if(!this.mainProxy.mouseVisible)
         {
            Mouse.hide();
         }
      }
      
      private function initBtnTxt() : void
      {
         this._btnTxt = new TextField();
         this._btnTxt.selectable = false;
         this._btnTxt.mouseWheelEnabled = false;
         this._btnTxt.mouseEnabled = false;
         this._btnTxt.text = "本地存档";
         this._btnTxt.autoSize = TextFieldAutoSize.LEFT;
         this._btnTxtFormat = new TextFormat();
         this._btnTxtFormat.color = 16777215;
         this._btnTxtFormat.underline = true;
         this._btnTxtFormat.font = "宋体";
         this._btnTxtFormat.size = 14;
         this._btnTxt.setTextFormat(this._btnTxtFormat,0,this._btnTxt.length);
      }
      
      private function checkBtnFun(param1:* = null, param2:int = -1) : void
      {
      }
      
      public function showLoading(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:SaveListItem = null;
         _loc3_ = int(this._itemList.length);
         if(this._waitMc != null && param1)
         {
            this._waitMc.visible = true;
            this._waitMc.play();
         }
         else if(this._waitMc != null && !param1)
         {
            this._waitMc.stop();
            this._waitMc.visible = false;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this._itemList[_loc2_] as SaveListItem;
            _loc4_.setCanClick(!param1);
            _loc2_++;
         }
      }
      
      private function logOutHandler(param1:MouseEvent) : void
      {
         this.mainProxy.loginOut();
      }
      
      override protected function closeHandler(param1:Event) : void
      {
         super.closeHandler(param1);
         if(this._isHitEmptyTip)
         {
            clearTimeout(this._hitEmptyTipId);
         }
         this.clearHitEmptyTimer();
         if(!this.mainProxy.mouseVisible)
         {
            Mouse.hide();
         }
         if(this._logBtn != null)
         {
            this._logBtn.removeEventListener(MouseEvent.CLICK,this.logBtnDownHandler);
            this._logBtn = null;
         }
         if(this._btnLogout)
         {
            this._btnLogout.removeEventListener(MouseEvent.CLICK,this.logOutHandler);
            this._btnLogout = null;
         }
         removeEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHanlder);
         removeEventListener(MouseEvent.MOUSE_UP,this.mouseRollOverHandler);
         removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseRollOverHandler);
         dispatchEvent(new Event(AllConst.CLOSE_BTN_CLICK));
      }
      
      public function dispose() : void
      {
         this.closeHandler(null);
      }
      
      private function createItem() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:SaveListItem = null;
         if(this._itemList == null)
         {
            this._itemList = [];
         }
         _loc2_ = 8;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc5_ = new SaveListItem(this._showMode);
            _loc3_ = view["tmp"]["item" + _loc1_].x + view.x + view["tmp"].x + 5;
            _loc4_ = view["tmp"]["item" + _loc1_].y + view.y + view["tmp"].y - 10;
            view["tmp"]["item" + _loc1_].visible = false;
            append(_loc5_,_loc3_,_loc4_);
            _loc5_.index = _loc1_;
            _loc5_.mainHold = this;
            this._itemList.push(_loc5_);
            _loc1_++;
         }
      }
      
      private function getDataExcepHandler(param1:ComponentEvent) : void
      {
         this.stopGetData(String(param1.data));
      }
      
      private function stopGetData(param1:String) : void
      {
         if(this.gdeTip == null)
         {
            this.gdeTip = new GetDataExcepTip();
            this.gdeTip.addEventListener("DelBgEvent",this.onDelBgHandler);
            this.gdeTip.x = int((view.width - this.gdeTip.width) / 2);
            this.gdeTip.y = int((view.height - this.gdeTip.height) / 2);
         }
         if(!this.contains(this.shape))
         {
            this.addChild(this.shape);
         }
         if(!this.contains(this.gdeTip))
         {
            this.addChild(this.gdeTip);
         }
         this.gdeTip.showTip(param1);
         this.showLoading(false);
         this._emptyTip.visible = false;
         this._saveTipUI.visible = false;
      }
      
      private function onDelBgHandler(param1:Event) : void
      {
         if(this.contains(this.shape))
         {
            this.removeChild(this.shape);
         }
      }
      
      private function addBg() : void
      {
         this.shape = new Sprite();
         this.shape.graphics.clear();
         this.shape.graphics.beginFill(0,0);
         this.shape.graphics.drawRect(0,0,view.width,view.height);
         this.shape.graphics.endFill();
      }
      
      public function itemClickHandler(param1:int, param2:String, param3:String) : void
      {
         if(this._curClickIndex != -1)
         {
            this._itemList[this._curClickIndex].setSelect(false);
         }
         this._emptyTip.visible = false;
         this._emptyTip.mouseChildren = false;
         this._emptyTip.mouseEnabled = false;
         this._curClickIndex = param1;
         this._itemList[this._curClickIndex].setSelect(true);
         trace("_showMode = " + this._showMode,param3);
         if(this._showMode == AllConst.GET_MODE && param3 != AllConst.DataOK)
         {
            this.stopGetData(param3);
            return;
         }
         if(param2 != "" && this._showMode == AllConst.SAVE_MODE)
         {
            this._saveTipUI.showMode(AllConst.SAVE_COVER_MODE);
            this.setSaveTip();
         }
         else if(param2 == "" && this._showMode == AllConst.SAVE_GET_MODE)
         {
            trace("#####################");
            this._saveTipUI.showMode(AllConst.SAVE_MODE);
         }
         else if(param2 != "" && this._showMode == AllConst.SAVE_GET_MODE)
         {
            this._saveTipUI.showMode(this._showMode,param3);
            this.setSaveTip();
         }
         else
         {
            this._saveTipUI.showMode(this._showMode);
         }
      }
      
      public function saveSucTip() : void
      {
         this._saveTipUI.showMode(AllConst.SAVE_SUC_MODE);
         this.setSaveTip();
      }
      
      public function saveLocalSucTip() : void
      {
         this._saveTipUI.showMode(AllConst.SAVE_LOCAL_SUC_MODE);
         this.setSaveTip();
      }
      
      public function setListData(param1:Array) : void
      {
         this._listData = param1;
         this._isSet = true;
         if(this._isInit)
         {
            this.doSetListData();
         }
      }
      
      private function doSetListData() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         if(this._listData != null)
         {
            _loc2_ = int(this._listData.length);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc3_ = this._listData[_loc1_];
               if(_loc3_ != null)
               {
                  (this._itemList[_loc3_.index] as SaveListItem).setData(_loc3_.title,_loc3_.datetime,_loc3_.status);
               }
               _loc1_++;
            }
         }
         else if(this._showMode != AllConst.GET_MODE)
         {
            this._showTipTxt.text = "没有存档记录,请点击存档位置";
            this._emptyTip.visible = true;
            this._emptyTip.mouseChildren = false;
            this._emptyTip.mouseEnabled = false;
         }
         this.showLoading(false);
      }
      
      public function updataAt(param1:int, param2:String, param3:String) : void
      {
         this._isUpDataBol = true;
         if(this._upDataObj == null)
         {
            this._upDataObj = new Object();
         }
         this._upDataObj.index = param1;
         this._upDataObj.title = param2;
         this._upDataObj.datetime = param3;
         if(this._isInit)
         {
            this.doUpDataAt();
         }
      }
      
      private function doUpDataAt() : void
      {
         if(this._itemList[this._upDataObj.index] != null)
         {
            (this._itemList[this._upDataObj.index] as SaveListItem).setData(this._upDataObj.title,this._upDataObj.datetime,AllConst.DataOK);
         }
         this.showLoading(false);
      }
      
      private function setSaveTip() : void
      {
         this._saveTipUI.visible = true;
      }
      
      public function setShowTxt(param1:String, param2:Boolean = true) : void
      {
         if(this._emptyTip == null)
         {
            return;
         }
         if(param2)
         {
            if(this._isHitEmptyTip)
            {
               clearTimeout(this._hitEmptyTipId);
            }
            this.clearHitEmptyTimer();
            this._emptyTip.visible = true;
            this._emptyTip.alpha = 1;
            this._hitEmptyTipId = setTimeout(this.hitEmptyTip,2000);
            this._isHitEmptyTip = true;
         }
         else
         {
            this._emptyTip.visible = false;
         }
         this._emptyTip.mouseChildren = false;
         this._emptyTip.mouseEnabled = false;
         this._showTipTxt.text = param1;
      }
      
      private function clearHitEmptyTimer() : void
      {
         if(this._hitEmpytTime)
         {
            this._emptyTip.visible = false;
            this._hitEmpytTime.stop();
            this._hitEmpytTime.removeEventListener(TimerEvent.TIMER,this.doHitEmptyTip);
            this._hitEmpytTime = null;
         }
      }
      
      private function hitEmptyTip() : void
      {
         this._isHitEmptyTip = false;
         if(this._hitEmpytTime == null)
         {
            this._hitEmpytTime = new Timer(100);
            this._hitEmpytTime.addEventListener(TimerEvent.TIMER,this.doHitEmptyTip);
         }
         this._hitEmpytTime.start();
      }
      
      private function doHitEmptyTip(param1:TimerEvent) : void
      {
         if(!this._emptyTip.visible || this._emptyTip.alpha <= 0)
         {
            this.clearHitEmptyTimer();
         }
         this._emptyTip.alpha -= this.HIT_INC;
      }
      
      public function showError(param1:String, param2:Boolean = false) : void
      {
         if(this._emptyTip == null)
         {
            return;
         }
         if(this._isHitEmptyTip)
         {
            clearTimeout(this._hitEmptyTipId);
            this._isHitEmptyTip = false;
         }
         this.clearHitEmptyTimer();
         this._emptyTip.visible = true;
         this._emptyTip.alpha = 1;
         this._emptyTip.mouseChildren = false;
         this._emptyTip.mouseEnabled = false;
         if(!param2)
         {
            this._showTipTxt.text = param1;
         }
         else
         {
            this._showTipTxt.htmlText = param1;
         }
      }
   }
}

