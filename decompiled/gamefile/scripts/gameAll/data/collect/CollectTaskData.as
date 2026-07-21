package gameAll.data.collect
{
   import data.TextWay;
   
   public class CollectTaskData
   {
      
      public static const CARD_COOLDOWN:Number = 600000;
      
      public static const TASK_COOLDOWN:Number = 900000;
      
      public var pro_arr:Array = [];
      
      public var arr:Array = [];
      
      public var nowTask:CollectTaskDefine = null;
      
      private var _nowNum:String = "";
      
      public var readyAt:Array = [];
      
      public var taskReadyAt:Array = [];
      
      public var roundCompleted:int = 0;
      
      public function CollectTaskData()
      {
         super();
         this.nowNum = 0;
         this.readyAt = [];
         this.taskReadyAt = [];
         this.roundCompleted = 0;
      }
      
      public function init() : *
      {
         this.nowTask = null;
         this.nowNum = 0;
         this.readyAt = [];
         this.taskReadyAt = [];
         this.roundCompleted = 0;
      }
      
      public function inData_byObj(obj:Object) : *
      {
         var n:* = undefined;
         var nowTask0:* = undefined;
         var m:* = undefined;
         var pro0:String = null;
         var d0:CollectTaskDefine = null;
         for(n in this.pro_arr)
         {
            pro0 = this.pro_arr[n];
            this[pro0] = obj[pro0];
         }
         this.arr.length = 0;
         nowTask0 = null;
         for(m in obj.arr)
         {
            d0 = new CollectTaskDefine();
            d0.state = obj.arr[m].state;
            this.arr[m] = d0;
            if(nowTask0 == null && d0.getNowB())
            {
               nowTask0 = d0;
            }
         }
         this.nowTask = nowTask0;
         this.nowNum = 0;
         this.readyAt = obj.hasOwnProperty("readyAt") ? this.restoreArray(obj.readyAt) : [];
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
         var d0:CollectTaskDefine = null;
         var arr1:Array = Game.gameDefine.taskDefine.collectArr;
         for(n in arr1)
         {
            if(n < this.arr.length)
            {
               d0 = this.arr[n];
            }
            else
            {
               d0 = new CollectTaskDefine();
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
         var td0:CollectTaskDefine = this.getTrueTask_byIndex(nowIndex);
         if(td0 != null && td0.state == "no")
         {
            td0.state = "ing";
            Game.gameData.taskData.reserveChallengeCard("collect",int(nowIndex));
         }
         this.fleshAllNowNum();
      }
      
      public function canStart(index0:int) : Boolean
      {
         var td0:CollectTaskDefine = this.getTrueTask_byIndex(index0);
         this.refreshTask(index0);
         return td0.state == "no";
      }
      
      public function getCooldownSeconds(index0:int) : int
      {
         if(Game.gameData.modNoTaskCooldown)
         {
            return 0;
         }
         this.refreshTask(index0);
         return Math.max(0,Math.ceil((Number(this.taskReadyAt[index0]) - new Date().time) / 1000));
      }
      
      public function giveupNowTask() : *
      {
         this.nowTask.state = "no";
         this.nowTask = null;
         this.nowNum = 0;
      }
      
      public function completeNowTask() : *
      {
         this.nowTask.state = "complete";
         this.nowNum = 0;
      }
      
      public function getGiftNowTask() : *
      {
         this.giveupNowTask();
      }
      
      public function giveupTask(index0:int) : *
      {
         var td0:CollectTaskDefine = this.getTrueTask_byIndex(index0);
         if(td0 != null && (td0.state == "ing" || td0.state == "complete"))
         {
            td0.state = "no";
            Game.gameData.taskData.releaseChallengeCard("collect",index0);
         }
         this.fleshAllNowNum();
      }
      
      public function getGiftTask(index0:int) : *
      {
         var td0:CollectTaskDefine = this.getTrueTask_byIndex(index0);
         if(td0 != null)
         {
            td0.state = "over";
            this.taskReadyAt[index0] = Game.gameData.modNoTaskCooldown ? 0 : new Date().time + TASK_COOLDOWN;
            ++this.roundCompleted;
            if(Game.gameData.modNoTaskCooldown || this.getCoolingNum() >= this.arr.length)
            {
               this.refreshRound();
            }
         }
         this.fleshAllNowNum();
      }
      
      private function refreshTask(index0:int) : *
      {
         var td0:CollectTaskDefine = this.getTrueTask_byIndex(index0);
         var ready:Number = Number(this.taskReadyAt[index0]);
         if(td0 != null && td0.state == "over" && (Game.gameData.modNoTaskCooldown || isNaN(ready) || new Date().time >= ready))
         {
            td0.state = "no";
            this.taskReadyAt[index0] = 0;
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
         this.fleshAllNowNum();
      }
      
      private function getCoolingNum() : int
      {
         var result:int = 0;
         var td0:CollectTaskDefine = null;
         for each(td0 in this.arr)
         {
            if(td0 != null && td0.state == "over")
            {
               result++;
            }
         }
         return result;
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
      
      public function fleshAllNowNum() : *
      {
         var td0:CollectTaskDefine = null;
         this.nowTask = null;
         for each(td0 in this.arr)
         {
            if(td0 != null && td0.state == "ing" && Game.gameData.materialsItems.getRealNumByBase(td0.targetItems) >= td0.targetNum)
            {
               td0.state = "complete";
            }
            if(this.nowTask == null && td0 != null && td0.getNowB())
            {
               this.nowTask = td0;
            }
         }
      }
      
      public function tryGrantChallengeCard(index0:int) : Boolean
      {
         return Game.gameData.taskData.consumeChallengeCard("collect",index0);
      }
      
      public function canShowChallengeCard(index0:int) : Boolean
      {
         var td0:CollectTaskDefine = this.getTrueTask_byIndex(index0);
         return td0 != null && Game.gameData.taskData.canShowChallengeCardFor("collect",index0,td0.state);
      }
      
      public function setNum(num0:int) : *
      {
         if(this.nowTask is CollectTaskDefine)
         {
            this.nowNum = num0;
            if(this.nowNum >= this.nowTask.targetNum)
            {
               this.completeNowTask();
            }
         }
         else
         {
            this.nowNum = 0;
         }
      }
      
      public function fleshNowNum() : *
      {
         this.fleshAllNowNum();
         if(this.nowTask is CollectTaskDefine)
         {
            if(this.nowTask.state == "ing")
            {
               this.nowNum = Game.gameData.materialsItems.getRealNumByBase(this.nowTask.targetItems);
            }
            else
            {
               this.nowNum = 0;
            }
         }
         else
         {
            this.nowNum = 0;
         }
      }
      
      public function getEnabledNum() : int
      {
         var n:* = undefined;
         var d0:CollectTaskDefine = null;
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
         this.fleshNowNum();
      }
      
      public function get nowNum() : Number
      {
         return Number(TextWay.getText(this._nowNum));
      }
      
      public function set nowNum(v0:Number) : *
      {
         this._nowNum = TextWay.toCode(String(v0));
      }
   }
}

