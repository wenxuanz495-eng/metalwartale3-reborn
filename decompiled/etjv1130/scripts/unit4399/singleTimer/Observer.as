package unit4399.singleTimer
{
   public class Observer
   {
      
      private var _notify:Function;
      
      private var _context:Object;
      
      private var _arags:Array;
      
      public function Observer(param1:Function = null, param2:Object = null, param3:Array = null)
      {
         super();
         this.setNotifyMethod(param1);
         this.setNotifyContext(param2);
         this.setNotifyArags(param3);
      }
      
      public function notifyObserver(param1:int) : void
      {
         if(this._context == null)
         {
            throw new ArgumentError(TimerTaskRunErrorType.OBSERVER_NOT_CONTEXT);
         }
         if(this._notify == null)
         {
            throw new ArgumentError(TimerTaskRunErrorType.OBSERVER_NOT_FUNC);
         }
         this.getNotifyMethod().apply(this.getNotifyContext(),[param1,this._arags]);
      }
      
      public function setNotifyMethod(param1:Function) : void
      {
         this._notify = param1;
      }
      
      public function setNotifyContext(param1:Object) : void
      {
         this._context = param1;
      }
      
      public function setNotifyArags(param1:Array) : void
      {
         this._arags = param1;
      }
      
      public function compareNotifyContext(param1:Object) : Boolean
      {
         return param1 === this._context;
      }
      
      private function getNotifyMethod() : Function
      {
         return this._notify;
      }
      
      private function getNotifyContext() : Object
      {
         return this._context;
      }
      
      private function getNotifyArags() : Array
      {
         return this._arags;
      }
   }
}

