package ctrl4399.view
{
   import ctrl4399.proxy.MainProxy;
   import ctrl4399.proxy.SaveProxy;
   import ctrl4399.strconst.AllConst;
   import ctrl4399.view.components.ComponentEvent;
   import ctrl4399.view.components.SaveListUI;
   import flash.events.Event;
   import flash.text.TextField;
   import frame4399.simplePureMvc.core.Facade;
   import frame4399.simplePureMvc.core.Notification;
   import frame4399.simplePureMvc.mediator.Mediator;
   
   public class SaveLocalMediator extends Mediator
   {
      
      public static const NAME:String = "SaveLocalMediator";
      
      private var _saveParamObj:Object;
      
      private var _isSaveReturn:Boolean;
      
      private var _saveData:Object;
      
      private var _saveTitle:String;
      
      private var _saveProxy:SaveProxy;
      
      private var _saveLocalUI:SaveListUI;
      
      private var _titleTxt:TextField;
      
      private var _data:Object;
      
      private var _mainProxy:MainProxy;
      
      public function SaveLocalMediator()
      {
         super(NAME);
      }
      
      override public function handleNotification(param1:Notification) : void
      {
         var _loc2_:String = null;
         var _loc3_:Object = null;
         var _loc4_:String = null;
         _loc2_ = param1.getName();
         switch(_loc2_)
         {
            case AllConst.OPEN_SAVE_LOCAL_UI:
               this._saveParamObj = new Object();
               this._saveParamObj.type = "openSaveList";
               this._saveParamObj.data = param1.getBody();
               this.openSaveLocalUI(param1.getBody());
               break;
            case AllConst.SAVE_DATA_RETURN:
               trace("saveLoaclMediator.AllConst.SAVE_DATA_RETURN = " + param1.getBody().type + "    " + this._saveLocalUI);
               if(this._saveLocalUI == null)
               {
                  return;
               }
               _loc4_ = param1.getBody().type;
               if(_loc4_ == "save")
               {
                  _loc3_ = param1.getBody();
                  trace("notification.getBody().data as Boolean = " + param1.getBody().data);
                  this.saveDataReturn(_loc3_.data,_loc3_.index,_loc3_.title,_loc3_.datetime);
               }
               else if(_loc4_ == "get")
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
         }
      }
      
      private function saveGetDataExcepHandler(param1:String) : void
      {
         if(this._saveLocalUI != null)
         {
            trace("e = " + param1);
            if(param1 == AllConst.TempStop)
            {
               this._saveLocalUI.showError(AllConst.TemExcepInfo,true);
            }
            else if(param1 == AllConst.ForeverStop)
            {
               this._saveLocalUI.showError(AllConst.ForeverExcepInfo);
            }
            this._saveLocalUI.showLoading(false);
         }
      }
      
      private function saveErrorHandler(param1:String) : void
      {
         if(this._saveLocalUI != null)
         {
            trace("e = " + param1);
            if(param1 == AllConst.MultipleError)
            {
               param1 = AllConst.MultipleErrorInfo;
            }
            this._saveLocalUI.showError(param1);
            this._saveLocalUI.showLoading(false);
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
      
      override public function listNotificationInterests() : Array
      {
         return [AllConst.OPEN_SAVE_LOCAL_UI,AllConst.SAVE_DATA_RETURN,AllConst.CLOASE_SAVE_LIST_UI,AllConst.MVC_LOGOUT,AllConst.SAVE_ERROR,AllConst.GetData_Excep];
      }
      
      public function setSaveListData(param1:Array) : void
      {
         if(this._saveLocalUI == null)
         {
            return;
         }
         this._saveLocalUI.setListData(param1);
         if(this._isSaveReturn)
         {
            this._isSaveReturn = false;
            this._saveLocalUI.saveLocalSucTip();
         }
      }
      
      private function openSaveLocalUI(param1:Object) : void
      {
         this._data = param1;
         if(this._saveLocalUI == null)
         {
            this._saveLocalUI = new SaveListUI(param1.mode,SaveListUI.LOCAL_MODE);
            this._saveLocalUI.addEventListener(AllConst.SAVE_SERVER_DATA,this.saveTipDownHandler,false,0,true);
            this._saveLocalUI.addEventListener(AllConst.GET_SERVER_DATA,this.saveTipDownHandler,false,0,true);
            this._saveLocalUI.addEventListener(AllConst.CLOSE_BTN_CLICK,this.closeSaveListUI,false,0,true);
            this._saveLocalUI.addEventListener(AllConst.SAVE_UI_SHOW_LOG,this.showLogHandler,false,0,true);
         }
         if(this._saveProxy == null)
         {
            this._saveProxy = Facade.getInstance().retrieveProxy(AllConst.PROXY_NAME_SAVE) as SaveProxy;
         }
         if(this._mainProxy == null)
         {
            this._mainProxy = Facade.getInstance().retrieveProxy(AllConst.PROXY_NAME_MAIN) as MainProxy;
         }
         var _loc2_:Array = this._saveProxy.getLocalList("local43990000",this._mainProxy.gameID);
         this._saveLocalUI.setListData(_loc2_);
      }
      
      private function showLogHandler(param1:Event) : void
      {
         this.closeSaveListUI();
         this._mainProxy.addNeedFunc(this._saveParamObj.type,this._saveParamObj.data);
         sendNotification(AllConst.MVC_SHOW_LOGBOX);
         this._saveParamObj = null;
      }
      
      private function saveTipDownHandler(param1:ComponentEvent) : void
      {
         var data:Object = null;
         var e:ComponentEvent = param1;
         if(this._saveProxy == null)
         {
            this._saveProxy = Facade.getInstance().retrieveProxy(AllConst.PROXY_NAME_SAVE) as SaveProxy;
         }
         if(this._mainProxy == null)
         {
            this._mainProxy = Facade.getInstance().retrieveProxy(AllConst.PROXY_NAME_MAIN) as MainProxy;
         }
         trace("e.type = " + e.type);
         trace("e.data = " + e.data);
         switch(e.type)
         {
            case AllConst.SAVE_SERVER_DATA:
               trace("_saveProxy.saveDataAt");
               trace(this._data.title);
               try
               {
                  trace(this._data.data);
               }
               catch(e:Error)
               {
                  trace("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
               }
               this._saveProxy.saveLocal("local43990000",this._mainProxy.gameID,String(e.data),this._data.title,this._data.data);
               break;
            case AllConst.GET_SERVER_DATA:
               data = this._saveProxy.getLocal("local43990000",this._mainProxy.gameID,e.data as int);
               sendNotification(AllConst.SAVE_RETURN,{
                  "type":AllConst.SAVE_EVENT_GET,
                  "data":data,
                  "from":AllConst.DATA_FROM_LOCAL
               });
               this.getDataReturn(data);
         }
      }
      
      private function closeSaveListUI(param1:Event = null) : void
      {
         trace("_saveListUI  = " + this._saveLocalUI);
         if(this._saveLocalUI != null)
         {
            this._saveLocalUI.removeEventListener(AllConst.SAVE_UI_SHOW_LOG,this.showLogHandler);
            this._saveLocalUI.removeEventListener(AllConst.SAVE_SERVER_DATA,this.saveTipDownHandler);
            this._saveLocalUI.removeEventListener(AllConst.GET_SERVER_DATA,this.saveTipDownHandler);
            this._saveLocalUI.removeEventListener(AllConst.CLOSE_BTN_CLICK,this.closeSaveListUI);
            this._saveLocalUI.dispose();
            this._saveLocalUI = null;
            trace("closeSaveListUI");
         }
         sendNotification(AllConst.MVC_CLOSE_PANEL,AllConst.CLOSE_SAVE_WIN);
      }
      
      private function saveDataReturn(param1:Boolean, param2:int = 0, param3:String = "", param4:String = "") : void
      {
         if(this._saveLocalUI == null)
         {
            return;
         }
         if(param1)
         {
            this._saveLocalUI.updataAt(param2,param3,param4);
            this._saveLocalUI.saveLocalSucTip();
         }
      }
   }
}

