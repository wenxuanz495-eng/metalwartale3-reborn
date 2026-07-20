package frame4399.simplePureMvc.core
{
   import frame4399.simplePureMvc.interfaces.IProxy;
   
   public class Model
   {
      
      protected static var _instance:Model;
      
      protected var _proxyMap:Object;
      
      public function Model()
      {
         super();
         this._proxyMap = new Object();
      }
      
      public static function getInstance() : Model
      {
         if(_instance == null)
         {
            _instance = new Model();
         }
         return _instance;
      }
      
      public function registerProxy(param1:IProxy) : void
      {
         this._proxyMap[param1.getProxyName()] = param1;
         param1.onRegister();
      }
      
      public function retrieveProxy(param1:String) : IProxy
      {
         return this._proxyMap[param1];
      }
      
      public function hasProxy(param1:String) : Boolean
      {
         return this._proxyMap[param1] != null;
      }
      
      public function removeProxy(param1:String) : IProxy
      {
         var _loc2_:IProxy = this._proxyMap[param1] as IProxy;
         if(_loc2_)
         {
            this._proxyMap[param1] = null;
            _loc2_.onRemove();
         }
         return _loc2_;
      }
   }
}

