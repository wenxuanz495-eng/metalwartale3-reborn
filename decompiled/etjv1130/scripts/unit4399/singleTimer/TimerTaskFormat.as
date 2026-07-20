package unit4399.singleTimer
{
   public class TimerTaskFormat
   {
      
      private var _isUse:Boolean;
      
      private var _runInterval:int;
      
      private var _id:int;
      
      private var _curCount:int;
      
      private var _totalCount:int;
      
      private var _observer:Observer;
      
      private var _curRunTime:int;
      
      public function TimerTaskFormat(param1:int = -1, param2:int = -1, param3:int = -1, param4:Object = null, param5:Function = null, param6:Array = null)
      {
         super();
         this._runInterval = param1;
         this._curRunTime = param1;
         this._id = param2;
         this._totalCount = param3;
         this._curCount = 0;
         if(this._observer == null)
         {
            this._observer = new Observer();
         }
         this._observer.setNotifyMethod(param5);
         this._observer.setNotifyContext(param4);
         this._observer.setNotifyArags(param6);
         if(this._id != -1)
         {
            this._isUse = true;
         }
         else
         {
            this._isUse = false;
         }
      }
      
      public function setDisable() : void
      {
         this._isUse = false;
         this._observer.setNotifyArags(null);
         this._observer.setNotifyContext(null);
         this._observer.setNotifyMethod(null);
         this._totalCount = -1;
         this._curCount = 0;
         this._curRunTime = 0;
         this._id = -1;
         this._runInterval = -1;
      }
      
      public function notifyObserver() : void
      {
         if(this._observer == null)
         {
            throw new ArgumentError(TimerTaskRunErrorType.RUN_FUNC_ERROR);
         }
         this._observer.notifyObserver(this._curCount);
      }
      
      public function addRunTime(param1:int) : Boolean
      {
         this._curRunTime -= param1;
         if(this._curRunTime <= 0)
         {
            this._curRunTime = this._runInterval;
            ++this._curCount;
            this.notifyObserver();
            if(this._totalCount != -1 && this._curCount >= this._totalCount)
            {
               return true;
            }
         }
         return false;
      }
      
      public function set runInterval(param1:int) : void
      {
         this._runInterval = param1;
      }
      
      public function get runInterval() : int
      {
         return this._runInterval;
      }
      
      public function set id(param1:int) : void
      {
         this._id = param1;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function set isUse(param1:Boolean) : void
      {
         this._isUse = param1;
      }
      
      public function get isUse() : Boolean
      {
         return this._isUse;
      }
      
      public function set curCount(param1:int) : void
      {
         this._curCount = param1;
      }
      
      public function get curCount() : int
      {
         return this._curCount;
      }
      
      public function set totalCount(param1:int) : void
      {
         this._totalCount = param1;
      }
      
      public function get totalCount() : int
      {
         return this._totalCount;
      }
      
      public function set notifyMethod(param1:Function) : void
      {
         if(this._observer == null)
         {
            this._observer = new Observer();
         }
         this._observer.setNotifyMethod(param1);
      }
      
      public function set notifyContext(param1:Object) : void
      {
         if(this._observer == null)
         {
            this._observer = new Observer();
         }
         this._observer.setNotifyContext(param1);
      }
      
      public function set notifyArags(param1:Array) : void
      {
         if(this._observer == null)
         {
            this._observer = new Observer();
         }
         this._observer.setNotifyArags(param1);
      }
   }
}

