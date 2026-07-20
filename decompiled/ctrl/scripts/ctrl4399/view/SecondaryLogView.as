package ctrl4399.view
{
   import ctrl4399.proxy.SecondaryProxy;
   import ctrl4399.strconst.AllConst;
   import ctrl4399.view.components.SecondaryLogUI;
   import frame4399.simplePureMvc.core.Facade;
   import frame4399.simplePureMvc.core.Notification;
   import frame4399.simplePureMvc.interfaces.IMediator;
   import frame4399.simplePureMvc.mediator.Mediator;
   
   public class SecondaryLogView extends Mediator implements IMediator
   {
      
      private var _secondaryProxy:SecondaryProxy;
      
      private var main:*;
      
      private var secondaryLogUI:SecondaryLogUI;
      
      public function SecondaryLogView(param1:String, param2:Object)
      {
         super(param1);
         this.main = param2;
         this.secondaryLogUI = new SecondaryLogUI();
         this.secondaryLogUI.loginHandle = this.loginHandle;
      }
      
      override public function listNotificationInterests() : Array
      {
         return [AllConst.MVC_SHOW_SECONDARY_LOGBOX,AllConst.MVC_LOGOUT,AllConst.MVC_HIDE_SECONDARY_LOGBOX,AllConst.MVC_SECONDARY_COM_ERROR,AllConst.MVC_SECONDARY_LOG_ERROR,AllConst.MVC_SECONDARY_IP_ERROR,AllConst.MVC_SECONDARY_USERLOCKED_ERROR,AllConst.MVC_SECONDARY_CHECK_CODE_ERROR];
      }
      
      override public function handleNotification(param1:Notification) : void
      {
         if(!this.secondaryLogUI)
         {
            return;
         }
         switch(param1.getName())
         {
            case AllConst.MVC_SHOW_SECONDARY_LOGBOX:
               this.secondaryLogUI.isShowCheckCode = this.secondaryProxy.isShowCheckCode;
               this.secondaryLogUI.showBox();
               break;
            case AllConst.MVC_LOGOUT:
            case AllConst.MVC_HIDE_SECONDARY_LOGBOX:
               this.secondaryLogUI.hideBox();
               break;
            case AllConst.MVC_SECONDARY_COM_ERROR:
            case AllConst.MVC_SECONDARY_LOG_ERROR:
            case AllConst.MVC_SECONDARY_IP_ERROR:
            case AllConst.MVC_SECONDARY_USERLOCKED_ERROR:
               this.secondaryLogUI.setCheckLogInfo(param1.getName());
               break;
            case AllConst.MVC_SECONDARY_CHECK_CODE_ERROR:
               this.secondaryLogUI.setCheckCodeInfo();
         }
      }
      
      public function get secondaryProxy() : SecondaryProxy
      {
         if(!this._secondaryProxy)
         {
            this._secondaryProxy = Facade.getInstance().retrieveProxy(AllConst.PROXY_NAME_SECONDARY) as SecondaryProxy;
         }
         return this._secondaryProxy;
      }
      
      public function loginHandle(param1:String, param2:String, param3:String = null) : void
      {
         this._secondaryProxy.Login(param1,param2,param3);
      }
   }
}

