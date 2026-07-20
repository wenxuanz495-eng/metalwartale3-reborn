package frame4399.simplePureMvc.proxy
{
   import frame4399.simplePureMvc.core.Notifier;
   import frame4399.simplePureMvc.interfaces.INotifier;
   import frame4399.simplePureMvc.interfaces.IProxy;
   
   public class Proxy extends Notifier implements IProxy, INotifier
   {
      
      public static const NAME:String = "proxy";
      
      protected var _name:String;
      
      public function Proxy(param1:String = null)
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
      
      public function getProxyName() : String
      {
         return this._name;
      }
      
      public function onRegister() : void
      {
      }
      
      public function onRemove() : void
      {
      }
   }
}

