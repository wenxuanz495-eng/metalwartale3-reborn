package ctrl4399.view
{
   import ctrl4399.strconst.AllConst;
   import frame4399.simplePureMvc.core.Notification;
   import frame4399.simplePureMvc.interfaces.IMediator;
   import frame4399.simplePureMvc.mediator.Mediator;
   import unit4399.calljs.CallJsClass;
   
   public class LogView extends Mediator implements IMediator
   {
      
      public function LogView(param1:String, param2:Object)
      {
         super(param1);
      }
      
      override public function listNotificationInterests() : Array
      {
         return [AllConst.MVC_SHOW_LOGBOX];
      }
      
      override public function handleNotification(param1:Notification) : void
      {
         var _loc2_:* = param1.getBody();
         switch(param1.getName())
         {
            case AllConst.MVC_SHOW_LOGBOX:
               CallJsClass.asCallJsFun("UniLogin.showPopupLogin(\'\',\'\',true)");
         }
      }
   }
}

