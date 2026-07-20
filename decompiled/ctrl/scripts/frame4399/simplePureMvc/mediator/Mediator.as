package frame4399.simplePureMvc.mediator
{
   import frame4399.simplePureMvc.core.Notification;
   import frame4399.simplePureMvc.core.Notifier;
   import frame4399.simplePureMvc.interfaces.IMediator;
   
   public class Mediator extends Notifier implements IMediator
   {
      
      public static const NAME:String = "mediator";
      
      protected var viewComponent:Object;
      
      protected var _name:String;
      
      public function Mediator(param1:String)
      {
         super();
         if(param1 == null)
         {
            this._name = NAME;
         }
         else
         {
            this._name = param1;
         }
      }
      
      public function setViewComponent(param1:Object) : void
      {
         this.viewComponent = param1;
      }
      
      public function getViewComponent() : Object
      {
         return this.viewComponent;
      }
      
      public function listNotificationInterests() : Array
      {
         return [];
      }
      
      public function onRegister() : void
      {
      }
      
      public function onRemove() : void
      {
      }
      
      public function getMediatorName() : String
      {
         return this._name;
      }
      
      public function handleNotification(param1:Notification) : void
      {
      }
   }
}

