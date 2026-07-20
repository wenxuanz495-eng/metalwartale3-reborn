package frame4399.simplePureMvc.core
{
   public class Controller
   {
      
      private static var instance:Controller;
      
      private var _commandMap:Object;
      
      public function Controller()
      {
         super();
      }
      
      public static function getInstance() : Controller
      {
         if(instance == null)
         {
            instance = new Controller();
         }
         return instance;
      }
      
      public function removeCommand(param1:String) : void
      {
         if(this.hasCommand(param1))
         {
            this._commandMap[param1] = null;
            delete this._commandMap[param1];
         }
      }
      
      public function hasCommand(param1:String) : Boolean
      {
         if(this._commandMap == null)
         {
            return false;
         }
         return this._commandMap[param1] != null;
      }
      
      public function sendNotification(param1:Notification) : void
      {
         var _loc3_:Observer = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:Array = this._commandMap[param1.getName()];
         if(_loc2_ == null)
         {
            return;
         }
         _loc5_ = int(_loc2_.length);
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc3_ = _loc2_[_loc4_] as Observer;
            if(_loc3_ != null)
            {
               _loc3_.notifyObserver(param1);
            }
            _loc4_++;
         }
      }
      
      public function registerCommand(param1:String, param2:Function, param3:Object) : void
      {
         var _loc4_:Observer = null;
         var _loc5_:Array = null;
         _loc4_ = new Observer(param2,param3);
         if(this._commandMap == null)
         {
            this._commandMap = new Object();
         }
         if(this._commandMap[param1] == null)
         {
            this._commandMap[param1] = [_loc4_];
         }
         else
         {
            _loc5_ = this._commandMap[param1] as Array;
            if(_loc5_ != null)
            {
               _loc5_.push(_loc4_);
            }
         }
      }
   }
}

