package unit4399.singleTimer
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class SingleTimer
   {
      
      private static var _instance:SingleTimer = null;
      
      private var _runInterval:int = 100;
      
      private var _timer:Timer;
      
      private var _taskList:Array;
      
      private var _runTaskCount:int = 0;
      
      private var _isDisPose:Boolean = false;
      
      private var _curTime:int;
      
      private var _lastTime:int;
      
      private var _realRunInteral:int;
      
      public function SingleTimer(param1:SingleClass)
      {
         super();
      }
      
      public static function getInstance() : SingleTimer
      {
         if(_instance == null)
         {
            _instance = new SingleTimer(new SingleClass());
         }
         return _instance;
      }
      
      public function addTask(param1:int = -1, param2:int = -1, param3:Object = null, param4:Function = null, ... rest) : int
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TimerTaskFormat = null;
         if(param1 < this._runInterval)
         {
            throw new ArgumentError(TimerTaskRunErrorType.TIME_SHORT);
         }
         if(this._taskList == null)
         {
            this._taskList = [];
         }
         _loc7_ = int(this._taskList.length);
         if(_loc7_ == 0)
         {
            this._taskList.push(new TimerTaskFormat(param1,_loc7_,param2,param3,param4,rest));
            ++this._runTaskCount;
            this.testCanRun();
            return 0;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            _loc8_ = this._taskList[_loc6_];
            if(_loc8_ == null)
            {
               this._taskList[_loc6_] = new TimerTaskFormat(param1,_loc6_,param2,param3,param4,rest);
               ++this._runTaskCount;
               this.testCanRun();
               return _loc6_;
            }
            if(!_loc8_.isUse)
            {
               _loc8_.isUse = true;
               _loc8_.id = _loc6_;
               _loc8_.runInterval = param1;
               _loc8_.curCount = 0;
               _loc8_.totalCount = param2;
               _loc8_.notifyMethod = param4;
               _loc8_.notifyContext = param3;
               _loc8_.notifyArags = rest;
               ++this._runTaskCount;
               this.testCanRun();
               return _loc6_;
            }
            _loc6_++;
         }
         this._taskList.push(new TimerTaskFormat(param1,_loc7_,param2,param3,param4,rest));
         ++this._runTaskCount;
         this.testCanRun();
         return _loc7_;
      }
      
      public function delTask(param1:int) : void
      {
         var _loc2_:TimerTaskFormat = null;
         if(this._taskList == null || this._taskList.length <= param1)
         {
            throw new ArgumentError(TimerTaskRunErrorType.DEL_ID_ERROR);
         }
         _loc2_ = this._taskList[param1] as TimerTaskFormat;
         _loc2_.setDisable();
         --this._runTaskCount;
         this.testCanStop();
      }
      
      public function set runInterval(param1:int) : void
      {
         if(param1 <= 5)
         {
            throw new ArgumentError(TimerTaskRunErrorType.INTERVAL_SHORT);
         }
         this._runInterval = param1;
      }
      
      public function get runInterval() : int
      {
         return this._runInterval;
      }
      
      public function dispose() : void
      {
         this._isDisPose = true;
      }
      
      private function testCanRun() : void
      {
         if(this._timer == null)
         {
            this._timer = new Timer(this._runInterval);
            this._timer.addEventListener(TimerEvent.TIMER,this.runFunc,false,0,true);
         }
         if(!this._timer.running && this._runTaskCount > 0)
         {
            this._lastTime = getTimer();
            this._timer.start();
         }
      }
      
      private function runFunc(param1:TimerEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TimerTaskFormat = null;
         var _loc5_:Boolean = false;
         _loc5_ = false;
         this._curTime = getTimer();
         this._realRunInteral = this._curTime - this._lastTime;
         this._lastTime = this._curTime;
         if(this._taskList == null)
         {
            if(this._timer != null)
            {
               if(this._timer.running)
               {
                  this._timer.stop();
               }
            }
            return;
         }
         _loc3_ = int(this._taskList.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this._taskList[_loc2_] as TimerTaskFormat;
            if(_loc4_ != null && _loc4_.isUse)
            {
               _loc5_ = _loc4_.addRunTime(this._realRunInteral);
               if(_loc5_)
               {
                  _loc4_.setDisable();
                  --this._runTaskCount;
               }
            }
            _loc2_++;
         }
         if(this._runTaskCount <= 0 && this._timer.running)
         {
            this._timer.stop();
         }
         if(this._isDisPose)
         {
            this.doDisPose();
         }
      }
      
      private function testCanStop() : void
      {
         if(this._timer == null || this._taskList == null)
         {
            return;
         }
         if(this._runTaskCount > 0)
         {
            return;
         }
         if(this._timer.running)
         {
            this._timer.stop();
         }
      }
      
      private function doDisPose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TimerTaskFormat = null;
         this._isDisPose = false;
         this._runTaskCount = 0;
         this.testCanStop();
         if(this._timer != null)
         {
            if(this._timer.hasEventListener(TimerEvent.TIMER))
            {
               this._timer.removeEventListener(TimerEvent.TIMER,this.runFunc);
            }
            this._timer = null;
         }
         if(this._taskList == null)
         {
            return;
         }
         _loc2_ = int(this._taskList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this._taskList[_loc1_] as TimerTaskFormat;
            if(_loc3_ != null && _loc3_.isUse)
            {
               _loc3_.setDisable();
            }
            this._taskList[_loc1_] = null;
            _loc1_++;
         }
         this._taskList = null;
      }
   }
}

class SingleClass
{
   
   public function SingleClass()
   {
      super();
   }
}
