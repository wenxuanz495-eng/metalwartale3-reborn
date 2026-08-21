package gameAll.data.challenge
{
   public class ChallengeTaskData
   {
      
      public static const CARD_COOLDOWN:Number = 1200000;
      
      public static const TASK_COOLDOWN:Number = 1800000;
      
      public var arr:Array = [];
      
      public var nowTask:ChallengeTaskDefine = null;
      
      public var challengeFail:String = "no";
      
      public var extraNum:int = 0;
      
      public var readyAt:Array = [];
      
      public var failArr:Array = [];
      
      public var taskReadyAt:Array = [];
      
      public var roundCompleted:int = 0;
      
      public function ChallengeTaskData()
      {
         super();
      }
      
      public function init() : *
      {
         this.nowTask = null;
         this.challengeFail = "no";
         this.extraNum = 0;
         this.readyAt = [];
         this.failArr = [];
         this.taskReadyAt = [];
         this.roundCompleted = 0;
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
         this.extraNum = obj.hasOwnProperty("extraNum") ? int(obj.extraNum) : 0;
         this.readyAt = obj.hasOwnProperty("readyAt") ? this.restoreArray(obj.readyAt) : [];
         this.failArr = obj.hasOwnProperty("failArr") ? this.restoreArray(obj.failArr) : [];
         this.taskReadyAt = obj.hasOwnProperty("taskReadyAt") ? this.restoreArray(obj.taskReadyAt) : [];
         this.roundCompleted = obj.hasOwnProperty("roundCompleted") ? int(obj.roundCompleted) : 0;
      }
      
      private function restoreArray(value:*) : Array
      {
         var result:Array = [];
         var key:String = null;
         if(value is Array)
         {
            return (value as Array).concat();
         }
         if(value != null && value.hasOwnProperty("$dense") && value["$dense"] is Array)
         {
            result = (value["$dense"] as Array).concat();
         }
         if(value != null)
         {
            for(key in value)
            {
               if(key != "$dense" && !isNaN(Number(key)))
               {
                  result[int(key)] = value[key];
               }
            }
         }
         return result;
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
         var idx:int = int(nowIndex);
         if(!this.canStart(idx))
         {
            return;
         }
         var td0:ChallengeTaskDefine = this.getTrueTask_byIndex(idx);
         if(td0 != null && td0.state == "no")
         {
            td0.state = "ing";
            this.failArr[idx] = "no";
            this.challengeFail = "no";
            Game.gameData.taskData.reserveChallengeCard("challenge",idx);
         }
         this.syncNowTask();
      }
      
      public function canStart(index0:int) : Boolean
      {
         var td0:ChallengeTaskDefine = this.getTrueTask_byIndex(index0);
         this.refreshTask(index0);
         if(td0 == null)
         {
            return false;
         }
         // Any remaining cooldown blocks accept, even if state already flipped to "no".
         if(this.getCooldownSeconds(index0) > 0)
         {
            return false;
         }
         // Only pure idle tasks can be accepted.
         if(td0.state == "no")
         {
            return true;
         }
         return false;
      }
      
      public function getCooldownSeconds(index0:int) : int
      {
         if(Game.gameData != null && Game.gameData.modNoExtraCooldown)
         {
            return 0;
         }
         this.refreshTask(index0);
         var ready:Number = Number(this.taskReadyAt[index0]);
         if(isNaN(ready) || ready <= 0)
         {
            return 0;
         }
         return Math.max(0,Math.ceil((ready - new Date().time) / 1000));
      }
      
      public function giveupNowTask() : *
      {
         if(this.nowTask != null)
         {
            this.nowTask.state = "no";
            this.nowTask = null;
         }
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
      
      public function giveupTask(index0:int) : *
      {
         var td0:ChallengeTaskDefine = this.getTrueTask_byIndex(index0);
         if(td0 != null && (td0.state == "ing" || td0.state == "complete"))
         {
            td0.state = "no";
            Game.gameData.taskData.releaseChallengeCard("challenge",index0);
         }
         this.syncNowTask();
      }
      
      public function getGiftTask(index0:int) : *
      {
         var td0:ChallengeTaskDefine = this.getTrueTask_byIndex(index0);
         if(td0 != null)
         {
            td0.state = "over";
            this.taskReadyAt[index0] = Game.gameData != null && Game.gameData.modNoExtraCooldown ? 0 : new Date().time + TASK_COOLDOWN;
            ++this.roundCompleted;
            if(this.roundCompleted >= 3)
            {
               this.roundCompleted = 0;
            }
         }
         this.syncNowTask();
      }
      
      private function refreshTask(index0:int) : *
      {
         var td0:ChallengeTaskDefine = this.getTrueTask_byIndex(index0);
         if(td0 == null)
         {
            return;
         }
         var ready:Number = Number(this.taskReadyAt[index0]);
         if(td0.state == "over")
         {
            // Missing/invalid ready timestamp must NOT unlock immediately.
            if(isNaN(ready) || ready <= 0)
            {
               this.taskReadyAt[index0] = new Date().time + TASK_COOLDOWN;
               return;
            }
            if(new Date().time >= ready)
            {
               td0.state = "no";
               this.taskReadyAt[index0] = 0;
            }
         }
      }
      
      public function refreshCooldownTasks() : *
      {
         var i:int = 0;
         i = 0;
         while(i < this.arr.length)
         {
            this.refreshTask(i);
            i++;
         }
         this.syncNowTask();
      }
      
      private function refreshRound() : *
      {
         var i:int = 0;
         i = 0;
         while(i < this.arr.length)
         {
            if(this.arr[i] != null && this.arr[i].state == "over")
            {
               this.arr[i].state = "no";
            }
            this.taskReadyAt[i] = 0;
            i++;
         }
         this.roundCompleted = 0;
      }
      
      public function completeTask(index0:int) : *
      {
         var td0:ChallengeTaskDefine = this.getTrueTask_byIndex(index0);
         if(td0 != null && td0.state == "ing")
         {
            td0.state = "complete";
            this.failArr[index0] = "no";
            this.challengeFail = "no";
            // Start cooldown immediately on kill-complete, so the slot cannot be re-accepted.
            var readyNow:Number = Number(this.taskReadyAt[index0]);
            if(!(Game.gameData != null && Game.gameData.modNoExtraCooldown) && (isNaN(readyNow) || readyNow < new Date().time))
            {
               this.taskReadyAt[index0] = new Date().time + TASK_COOLDOWN;
            }
            Game.gameData.livenessData.addTaskNum("challenge_task");
         }
         this.syncNowTask();
      }
      
      public function getFail(index0:int) : String
      {
         if(index0 >= 0 && index0 < this.failArr.length && Boolean(this.failArr[index0]))
         {
            return String(this.failArr[index0]);
         }
         return "no";
      }
      
      public function syncNowTask() : *
      {
         var td0:ChallengeTaskDefine = null;
         this.nowTask = null;
         for each(td0 in this.arr)
         {
            if(td0 != null && td0.getNowB())
            {
               this.nowTask = td0;
               return;
            }
         }
      }
      
      public function tryGrantChallengeCard(index0:int) : Boolean
      {
         return Game.gameData.taskData.consumeChallengeCard("challenge",index0);
      }
      
      public function canShowChallengeCard(index0:int) : Boolean
      {
         var td0:ChallengeTaskDefine = this.getTrueTask_byIndex(index0);
         return td0 != null && Game.gameData.taskData.canShowChallengeCardFor("challenge",index0,td0.state);
      }
      
      public function dieTrigger() : *
      {
         var td0:ChallengeTaskDefine = null;
         for each(td0 in this.arr)
         {
            if(td0 != null && td0.state == "ing")
            {
               if(Game.gameData.nowDifficult == td0.targetDiff % 4 && Game.gameData.nowGameLevel == td0.getNewDefine().targetLevel)
               {
                  if(td0.noDieB)
                  {
                     this.failArr[td0.index] = "died";
                  }
               }
            }
         }
      }
      
      public function timeTrigger(time0:int) : Boolean
      {
         var td0:ChallengeTaskDefine = null;
         var result:Boolean = true;
         for each(td0 in this.arr)
         {
            if(td0 != null && td0.state == "ing")
            {
               if(td0.time > 0 && td0.time < time0)
               {
                  this.failArr[td0.index] = "timeout";
                  result = false;
               }
            }
         }
         return result;
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
         this.challengeFail = "no";
      }
   }
}
