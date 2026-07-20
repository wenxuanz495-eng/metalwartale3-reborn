package gameAll.data.challenge
{
   public class ChallengeTaskData
   {
      
      public var arr:Array = [];
      
      public var nowTask:ChallengeTaskDefine = null;
      
      public var challengeFail:String = "no";
      
      public function ChallengeTaskData()
      {
         super();
      }
      
      public function init() : *
      {
         this.nowTask = null;
         this.challengeFail = "no";
      }
      
      public function inData_byObj(obj:Object) : *
      {
         var n:* = undefined;
         var nowTask0:* = undefined;
         var m:* = undefined;
         var pro0:String = null;
         var d0:ChallengeTaskDefine = null;
         var pro_arr:Array = [];
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            this[pro0] = obj[pro0];
         }
         this.arr.length = 0;
         nowTask0 = null;
         for(m in obj.arr)
         {
            d0 = new ChallengeTaskDefine();
            d0.state = obj.arr[m].state;
            this.arr[m] = d0;
            if(nowTask0 == null && d0.getNowB())
            {
               nowTask0 = d0;
            }
         }
         this.nowTask = nowTask0;
      }
      
      public function fleshByTaskDefine() : *
      {
         var n:* = undefined;
         var d0:ChallengeTaskDefine = null;
         var arr1:Array = Game.gameDefine.taskDefine.challengeArr;
         for(n in arr1)
         {
            if(n < this.arr.length)
            {
               d0 = this.arr[n];
            }
            else
            {
               d0 = new ChallengeTaskDefine();
            }
            d0.inData_byObj(arr1[n]);
            this.arr[n] = d0;
         }
      }
      
      public function getTrueTask_byIndex(index0:int) : *
      {
         return this.arr[index0];
      }
      
      public function startOneTask(nowIndex:*) : *
      {
         this.nowTask = this.getTrueTask_byIndex(nowIndex);
         this.nowTask.state = "ing";
      }
      
      public function giveupNowTask() : *
      {
         this.nowTask.state = "over";
         this.nowTask = null;
      }
      
      public function completeNowTask() : *
      {
         this.nowTask.state = "complete";
         Game.gameData.livenessData.addTaskNum("challenge_task");
      }
      
      public function getGiftNowTask() : *
      {
         this.giveupNowTask();
      }
      
      public function dieTrigger() : *
      {
         if(this.nowTask != null)
         {
            if(this.nowTask.state == "ing")
            {
               if(Game.gameData.nowDifficult == this.nowTask.targetDiff && Game.gameData.nowGameLevel == this.nowTask.targetLevel)
               {
                  if(this.nowTask.noDieB)
                  {
                     this.challengeFail = "died";
                  }
               }
            }
         }
      }
      
      public function timeTrigger(time0:int) : Boolean
      {
         if(this.nowTask != null)
         {
            if(this.nowTask.state == "ing")
            {
               if(this.nowTask.time > 0 && this.nowTask.time < time0)
               {
                  this.challengeFail = "timeout";
                  return false;
               }
            }
         }
         return true;
      }
      
      public function getEnabledNum() : int
      {
         var n:* = undefined;
         var d0:ChallengeTaskDefine = null;
         var num0:int = 0;
         for(n in this.arr)
         {
            d0 = this.arr[n];
            if(d0.state != "over")
            {
               num0++;
            }
         }
         return num0;
      }
      
      public function newDayCtrl() : *
      {
         var n:* = undefined;
         var td0:ChallengeTaskDefine = null;
         for(n in this.arr)
         {
            td0 = this.arr[n];
            if(td0.state == "over")
            {
               td0.state = "no";
            }
         }
      }
   }
}

