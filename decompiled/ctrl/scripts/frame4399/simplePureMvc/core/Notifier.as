package frame4399.simplePureMvc.core
{
   import frame4399.simplePureMvc.interfaces.INotifier;
   
   public class Notifier implements INotifier
   {
      
      private var _facade:Facade;
      
      public function Notifier()
      {
         super();
         this._facade = Facade.getInstance();
      }
      
      public function sendNotification(param1:String, param2:Object = null, param3:String = null) : void
      {
         this._facade.sendNotification(param1,param2,param3);
      }
   }
}

