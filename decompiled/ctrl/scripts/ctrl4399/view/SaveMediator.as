package ctrl4399.view
{
   import ctrl4399.proxy.MainProxy;
   import ctrl4399.proxy.SaveProxy;
   import ctrl4399.strconst.AllConst;
   import ctrl4399.view.components.ComponentEvent;
   import ctrl4399.view.components.NetFailureUI;
   import ctrl4399.view.components.SaveListUI;
   import ctrl4399.view.components.SaveTip;
   import flash.events.Event;
   import frame4399.simplePureMvc.core.Facade;
   import frame4399.simplePureMvc.core.Notification;
   import frame4399.simplePureMvc.interfaces.IMediator;
   import frame4399.simplePureMvc.mediator.Mediator;
   
   public class SaveMediator extends Mediator implements IMediator
   {
      
      public static const NAME:String = "SaveMediator";
      
      private var mainProxy:MainProxy;
      
      private var _isSaveReturn:Boolean;
      
      private var _failurePar:Object;
      
      private var _netFailureUI:NetFailureUI;
      
      private var _saveListUI:SaveListUI;
      
      private var _curSelecIndex:int;
      
      private var _saveTipUI:SaveTip;
      
      private var _saveProxy:SaveProxy;
      
      private var _curShowMode:int;
      
      public function SaveMediator()
      {
         super(NAME);
      }
      
      override public function listNotificationInterests() : Array
      {
         return [AllConst.OPEN_NET_FAILURE_UI,AllConst.OPEN_SAVE_LIST_UI,AllConst.SAVE_DATA_RETURN,AllConst.CLOASE_SAVE_LIST_UI,AllConst.MVC_LOGOUT,AllConst.SAVE_ERROR,AllConst.GetData_Excep,AllConst.MVC_GET_SESSION];
      }
      
      override public function handleNotification(param1:Notification) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(this._saveProxy == null)
         {
            this._saveProxy = Facade.getInstance().retrieveProxy(AllConst.PROXY_NAME_SAVE) as SaveProxy;
         }
         if(this.mainProxy == null)
         {
            this.mainProxy = Facade.getInstance().retrieveProxy(AllConst.PROXY_NAME_MAIN) as MainProxy;
         }
         switch(param1.getName())
         {
            case AllConst.OPEN_NET_FAILURE_UI:
               this.openNetFailureUI(param1.getBody());
               break;
            case AllConst.OPEN_SAVE_LIST_UI:
               _loc3_ = param1.getBody();
               if(_loc3_ == null)
               {
                  break;
               }
               _loc2_ = int(_loc3_.mode);
               if(!_loc3_.needUI)
               {
                  if(_loc2_ == AllConst.SAVE_MODE)
                  {
                     if(this.mainProxy.saveStoreAry == null)
                     {
                        this.mainProxy.saveStoreAry = [];
                     }
                     this.mainProxy.saveStoreAry.push(_loc3_);
                     if(this.mainProxy.saveStoreAry.length == 1)
                     {
                        this._saveProxy.setOldData(_loc3_.data);
                        _loc4_ = this._saveProxy.setData(_loc3_.data);
                        this._saveProxy.setStore(_loc3_.index,_loc3_.title,_loc4_,_loc3_.data);
                     }
                  }
                  else if(_loc2_ == AllConst.GET_MODE)
                  {
                     if(this.mainProxy.getStoreAry == null)
                     {
                        this.mainProxy.getStoreAry = [];
                     }
                     this.mainProxy.getStoreAry.push(_loc3_.index);
                     if(this.mainProxy.getStoreAry.length == 1)
                     {
                        this._saveProxy.getStore(_loc3_.index);
                     }
                  }
               }
               else
               {
                  if(_loc2_ == AllConst.SAVE_MODE || _loc2_ == AllConst.SAVE_GET_MODE)
                  {
                     this._saveProxy.setTitle(_loc3_.title);
                     this._saveProxy.setOldData(_loc3_.data);
                     this._saveProxy.setData(_loc3_.data);
                  }
                  this.openSaveListUI(param1.getBody().mode);
               }
               break;
            case AllConst.SAVE_DATA_RETURN:
               if(this._saveListUI == null)
               {
                  return;
               }
               _loc5_ = param1.getBody().type;
               if(_loc5_ == "list")
               {
                  this.setSaveListData(param1.getBody().data as Array,param1.getBody().source as int);
               }
               else if(_loc5_ == "save")
               {
                  _loc3_ = param1.getBody();
                  trace("notification.getBody().data as Boolean = " + param1.getBody().data);
                  this.saveDataReturn(_loc3_.data,_loc3_.index,_loc3_.title,_loc3_.datetime,_loc3_.source);
               }
               else if(_loc5_ == "get")
               {
                  this.getDataReturn(param1.getBody().data);
               }
               break;
            case AllConst.MVC_LOGOUT:
            case AllConst.CLOASE_SAVE_LIST_UI:
               this.closeSaveListUI();
               break;
            case AllConst.SAVE_ERROR:
               this.saveErrorHandler(param1.getBody() as String);
               break;
            case AllConst.GetData_Excep:
               this.saveGetDataExcepHandler(param1.getBody() as String);
               break;
            case AllConst.MVC_GET_SESSION:
               this._saveProxy.getSeesionFun();
         }
      }
      
      private function saveGetDataExcepHandler(param1:String) : void
      {
         if(this._saveListUI != null)
         {
            trace("e = " + param1);
            if(param1 == AllConst.TempStop)
            {
               this._saveListUI.showError(AllConst.TemExcepInfo,true);
            }
            else if(param1 == AllConst.ForeverStop)
            {
               this._saveListUI.showError(AllConst.ForeverExcepInfo);
            }
            this._saveListUI.showLoading(false);
         }
      }
      
      private function saveErrorHandler(param1:String) : void
      {
         if(this._saveListUI != null)
         {
            trace("e = " + param1);
            if(param1 == AllConst.MultipleError)
            {
               param1 = AllConst.MultipleErrorInfo;
            }
            this._saveListUI.showError(param1);
            this._saveListUI.showLoading(false);
         }
      }
      
      private function saveDataReturn(param1:Boolean, param2:int = 0, param3:String = "", param4:String = "", param5:int = 0) : void
      {
         if(this._saveListUI == null)
         {
            return;
         }
         if(param1)
         {
            this._saveListUI.updataAt(param2,param3,param4);
            if(param5 == AllConst.DATA_FROM_LOCAL)
            {
               this._saveListUI.saveLocalSucTip();
            }
            else if(param5 == AllConst.DATA_FROM_NET)
            {
               this._saveListUI.saveSucTip();
            }
         }
      }
      
      private function getDataReturn(param1:Object) : void
      {
         trace("###########getDataReturn##############");
         trace("data = " + param1);
         if(param1 != null)
         {
            this.closeSaveListUI();
         }
      }
      
      private function closeSaveListUI(param1:Event = null) : void
      {
         trace("_saveListUI  = " + this._saveListUI);
         if(this._saveListUI != null)
         {
            this._saveListUI.removeEventListener(AllConst.SAVE_SERVER_DATA,this.saveTipDownHandler);
            this._saveListUI.removeEventListener(AllConst.GET_SERVER_DATA,this.saveTipDownHandler);
            this._saveListUI.removeEventListener(AllConst.SAVE_LIST_ITEM_CLICK,this.saveItemClickHandler);
            this._saveListUI.removeEventListener(AllConst.CLOSE_BTN_CLICK,this.closeSaveListUI);
            this._saveListUI.dispose();
            this._saveListUI = null;
            trace("closeSaveListUI");
         }
         sendNotification(AllConst.MVC_CLOSE_PANEL,AllConst.CLOSE_SAVE_WIN);
      }
      
      private function openNetFailureUI(param1:Object = null) : void
      {
         this._failurePar = param1;
         if(this._netFailureUI == null)
         {
            this._netFailureUI = new NetFailureUI();
            this._netFailureUI.setShowMode(AllConst.SHOW_NET_MODE);
            this._netFailureUI.addEventListener(AllConst.BTN_DOWN,this.netFailureUIBtnDownHandler,false,0,true);
            this._netFailureUI.addEventListener(AllConst.CLOSE_BTN_CLICK,this.closeFailureUI,false,0,true);
         }
      }
      
      private function netFailureUIBtnDownHandler(param1:Event) : void
      {
         this._netFailureUI.disPose();
         this.closeFailureUI();
         this._netFailureUI = null;
         sendNotification(AllConst.OPEN_SAVE_LIST_UI,this._failurePar);
      }
      
      private function closeFailureUI(param1:Event = null) : void
      {
         this._netFailureUI.removeEventListener(AllConst.BTN_DOWN,this.netFailureUIBtnDownHandler);
         this._netFailureUI.removeEventListener(AllConst.CLOSE_BTN_CLICK,this.closeFailureUI);
         this._netFailureUI = null;
      }
      
      private function openSaveListUI(param1:int) : void
      {
         if(this._saveListUI == null)
         {
            this._saveListUI = new SaveListUI(param1);
            this._saveListUI.addEventListener(AllConst.SAVE_SERVER_DATA,this.saveTipDownHandler,false,0,true);
            this._saveListUI.addEventListener(AllConst.GET_SERVER_DATA,this.saveTipDownHandler,false,0,true);
            this._saveListUI.addEventListener(AllConst.SAVE_LIST_ITEM_CLICK,this.saveItemClickHandler,false,0,true);
            this._saveListUI.addEventListener(AllConst.CLOSE_BTN_CLICK,this.closeSaveListUI,false,0,true);
         }
         if(this._saveProxy == null)
         {
            this._saveProxy = Facade.getInstance().retrieveProxy(AllConst.PROXY_NAME_SAVE) as SaveProxy;
         }
         this._saveProxy.getList();
      }
      
      private function saveTipDownHandler(param1:ComponentEvent) : void
      {
         if(this._saveProxy == null)
         {
            this._saveProxy = Facade.getInstance().retrieveProxy(AllConst.PROXY_NAME_SAVE) as SaveProxy;
         }
         trace(param1.type);
         switch(param1.type)
         {
            case AllConst.SAVE_SERVER_DATA:
               trace("_saveProxy.saveDataAt");
               this._saveProxy.saveDataAt(param1.data as int);
               break;
            case AllConst.GET_SERVER_DATA:
               if(this.mainProxy.getStoreAry == null)
               {
                  this.mainProxy.getStoreAry = [];
               }
               this.mainProxy.getStoreAry.push(String(param1.data));
               if(this.mainProxy.getStoreAry.length == 1)
               {
                  this._saveProxy.getStore(String(param1.data));
               }
         }
      }
      
      private function saveItemClickHandler(param1:ComponentEvent) : void
      {
         this._curSelecIndex = param1.data as int;
      }
      
      public function setSaveListData(param1:Array, param2:int) : void
      {
         if(this._saveListUI == null)
         {
            return;
         }
         this._saveListUI.setListData(param1);
         if(this._isSaveReturn)
         {
            this._isSaveReturn = false;
            if(param2 == AllConst.DATA_FROM_LOCAL)
            {
               this._saveListUI.saveLocalSucTip();
            }
            else if(param2 == AllConst.DATA_FROM_NET)
            {
               this._saveListUI.saveSucTip();
            }
         }
      }
   }
}

