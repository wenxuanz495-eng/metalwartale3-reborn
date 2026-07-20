package frame4399.simplePureMvc.core
{
   import frame4399.simplePureMvc.interfaces.IMediator;
   
   public class View
   {
      
      private static var instance:View;
      
      protected var _mediatorMap:Object;
      
      protected var _observerMap:Object;
      
      public function View()
      {
         super();
         this._observerMap = new Object();
         this._mediatorMap = new Object();
      }
      
      public static function getInstance() : View
      {
         if(instance == null)
         {
            instance = new View();
         }
         return instance;
      }
      
      public function registerObserver(param1:String, param2:Observer) : void
      {
         if(this._observerMap[param1] != null)
         {
            this._observerMap[param1].push(param2);
         }
         else
         {
            this._observerMap[param1] = [param2];
         }
      }
      
      public function notifyObservers(param1:Notification) : void
      {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:Observer = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(this._observerMap[param1.getName()] != null)
         {
            _loc2_ = this._observerMap[param1.getName()] as Array;
            _loc3_ = new Array();
            _loc6_ = int(_loc2_.length);
            _loc5_ = 0;
            while(_loc5_ < _loc6_)
            {
               _loc4_ = _loc2_[_loc5_] as Observer;
               _loc3_.push(_loc4_);
               _loc5_++;
            }
            _loc6_ = int(_loc3_.length);
            _loc5_ = 0;
            while(_loc5_ < _loc6_)
            {
               _loc4_ = _loc3_[_loc5_] as Observer;
               _loc4_.notifyObserver(param1);
               _loc5_++;
            }
         }
      }
      
      public function removeObserver(param1:String, param2:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:Array = this._observerMap[param1] as Array;
         _loc5_ = int(_loc3_.length);
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            if(Observer(_loc3_[_loc4_]).compareNotifyContext(param2) == true)
            {
               _loc3_.splice(_loc4_,1);
               break;
            }
            _loc4_++;
         }
         if(_loc3_.length == 0)
         {
            delete this._observerMap[param1];
         }
      }
      
      public function registerMediator(param1:IMediator) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Observer = null;
         if(this._mediatorMap[param1.getMediatorName()] != null)
         {
            return;
         }
         this._mediatorMap[param1.getMediatorName()] = param1;
         var _loc2_:Array = param1.listNotificationInterests();
         _loc4_ = int(_loc2_.length);
         if(_loc4_ > 0)
         {
            _loc5_ = new Observer(param1.handleNotification,param1);
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               this.registerObserver(_loc2_[_loc3_],_loc5_);
               _loc3_++;
            }
         }
         param1.onRegister();
      }
      
      public function retrieveMediator(param1:String) : IMediator
      {
         return this._mediatorMap[param1];
      }
      
      public function removeMediator(param1:String) : IMediator
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:Array = null;
         var _loc4_:IMediator = this._mediatorMap[param1] as IMediator;
         if(_loc4_)
         {
            _loc5_ = _loc4_.listNotificationInterests();
            _loc3_ = int(_loc5_.length);
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               this.removeObserver(_loc5_[_loc2_],_loc4_);
               _loc2_++;
            }
            delete this._mediatorMap[param1];
            _loc4_.onRemove();
         }
         return _loc4_;
      }
      
      public function hasMediator(param1:String) : Boolean
      {
         return this._mediatorMap[param1] != null;
      }
   }
}

