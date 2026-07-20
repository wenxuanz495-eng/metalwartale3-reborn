package frame4399.simplePureMvc.interfaces
{
   import frame4399.simplePureMvc.core.Notification;
   
   public interface IMediator
   {
      
      function getMediatorName() : String;
      
      function listNotificationInterests() : Array;
      
      function onRegister() : void;
      
      function onRemove() : void;
      
      function handleNotification(param1:Notification) : void;
   }
}

