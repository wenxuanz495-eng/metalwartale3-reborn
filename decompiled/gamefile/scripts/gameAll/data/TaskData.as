package gameAll.data
{
   import data.TextWay;
   import gameAll.define.OneTaskDefine;
   
   public class TaskData
   {
      
      public static var baseMaxNum:int = 10;
      
      public static const CARD_COOLDOWN:Number = 1800000;
      
      public static const TASK_COOLDOWN:Number = 600000;
      
      public var saveDataVersion:Number = 1.2;
      
      private var _nowNum:String = "0";
      
      private var _maxNum:String = "0";
      
      public var nowTask:OneTaskDefine = new OneTaskDefine();
      
      private var _index:String = "0";
      
      private var _otherLevel:String = "0";
      
      public var task5:Array = [];
      
      public var slotReadyAt:Array = [0,0,0,0,0];
      
      public var cardReadyAt:Number = 0;
      
      public var normalCardReadyAt:Array = [0,0,0,0,0];
      
      public var cardReservedIndex:int = -1;
      
      public var cardReservedType:String = "";
      
      public function TaskData()
      {
         super();
      }
      
      public function init() : *
      {
         this.nowNum = 0;
         this.maxNum = baseMaxNum;
         this.otherLevel = 0;
         this.nowTask.init();
         this.fleshTaskStr();
         this.slotReadyAt = [0,0,0,0,0];
         this.cardReadyAt = 0;
         this.normalCardReadyAt = [0,0,0,0,0];
         this.cardReservedIndex = -1;
         this.cardReservedType = "";
      }
      
      public function inData_byObj(obj:Object) : *
      {
         var n:* = undefined;
         var m:* = undefined;
         var pro0:String = null;
         var ready0:Number = 0;
         var now0:Number = new Date().time;
         var i:int = 0;
         if(!obj.hasOwnProperty("saveDataVersion"))
         {
            this.init();
            return;
         }
         if(obj.saveDataVersion < this.saveDataVersion)
         {
            this.init();
            return;
         }
         var pro_arr:Array = ["nowNum","maxNum","otherLevel","saveDataVersion"];
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            this[pro0] = obj[pro0];
         }
         if(this.maxNum < baseMaxNum)
         {
            this.maxNum = baseMaxNum;
         }
         this.nowTask.inData_byObj(obj.nowTask);
         this.task5.length = 0;
         for(m in obj.task5)
         {
            this.task5[m] = new OneTaskDefine();
            this.task5[m].inData_byObj(obj.task5[m]);
         }
         if(this.nowTask.state != "no" && this.nowTask.index >= 0 && this.nowTask.index < this.task5.length)
         {
            this.task5[this.nowTask.index].inData_byObj(this.nowTask);
            this.nowTask.init();
         }
         if(obj.hasOwnProperty("slotReadyAt"))
         {
            this.slotReadyAt = this.restoreArray(obj.slotReadyAt);
         }
         else
         {
            this.slotReadyAt = [0,0,0,0,0];
         }
         // Normalize early/sparse editor saves and clamp old 15-minute
         // timestamps to the current 10-minute rule.
         i = 0;
         while(i < this.task5.length)
         {
            ready0 = i < this.slotReadyAt.length ? Number(this.slotReadyAt[i]) : 0;
            if(this.task5[i].state != "over" || isNaN(ready0) || ready0 <= now0)
            {
               ready0 = 0;
            }
            else if(ready0 > now0 + TASK_COOLDOWN)
            {
               ready0 = now0 + TASK_COOLDOWN;
            }
            this.slotReadyAt[i] = ready0;
            i++;
         }
         this.slotReadyAt.length = this.task5.length;
         this.cardReadyAt = obj.hasOwnProperty("cardReadyAt") ? Number(obj.cardReadyAt) : 0;
         if(obj.hasOwnProperty("normalCardReadyAt"))
         {
            this.normalCardReadyAt = this.restoreArray(obj.normalCardReadyAt);
         }
         else
         {
            this.normalCardReadyAt = [this.cardReadyAt,this.cardReadyAt,this.cardReadyAt,this.cardReadyAt,this.cardReadyAt];
         }
         this.cardReservedIndex = obj.hasOwnProperty("cardReservedIndex") ? int(obj.cardReservedIndex) : -1;
         this.cardReservedType = obj.hasOwnProperty("cardReservedType") ? String(obj.cardReservedType) : (this.cardReservedIndex >= 0 ? "normal" : "");
      }
      
      public function fleshAllGift() : *
      {
         var n:* = undefined;
         var td0:OneTaskDefine = null;
         for(n in this.task5)
         {
            td0 = this.task5[n];
            td0.fleshAllGift();
         }
      }
      
      public function startOneTask(num0:int) : *
      {
         var td0:OneTaskDefine = null;
         if(num0 >= 0 && num0 < this.task5.length)
         {
            td0 = this.getTask_byIndex(num0);
            if(td0.state == "no")
            {
               td0.state = "ing";
               this.reserveChallengeCard("normal",num0);
            }
         }
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
      
      public function giveupTask(num0:int) : *
      {
         var td0:OneTaskDefine = this.getTask_byIndex(num0);
         if(td0 != null && td0.state == "ing")
         {
            td0.completeNum = 0;
            td0.state = "no";
            if(this.cardReservedIndex == num0)
            {
               this.releaseChallengeCard("normal",num0);
            }
         }
      }
      
      public function giveupNowTask() : *
      {
         this.nowTask.init();
      }
      
      public function upStar() : *
      {
         if(this.otherLevel < 4)
         {
            ++this.otherLevel;
            this.nowTask.starLevel = this.otherLevel;
            this.setAllStarLevel(this.otherLevel);
            this.fleshAllGift();
         }
      }
      
      public function setAllStarLevel(num0:int) : *
      {
         var n:* = undefined;
         for(n in this.task5)
         {
            this.task5[n].starLevel = num0;
         }
      }
      
      public function addUseNum() : *
      {
         if(this.getGetTaskB())
         {
            ++this.nowNum;
         }
         else
         {
            this.nowNum = this.maxNum;
         }
      }
      
      public function upUseNum() : *
      {
         ++this.maxNum;
      }
      
      public function fleshTaskStr(keepStarB:Boolean = false) : *
      {
         this.fleshListData();
         if(!keepStarB)
         {
            this.otherLevel = 0;
            this.nowTask.starLevel = 0;
         }
         else if(this.otherLevel > 0)
         {
            this.nowTask.starLevel = this.otherLevel;
            this.setAllStarLevel(this.otherLevel);
         }
         this.fleshAllGift();
         this.giveupNowTask();
         this.slotReadyAt = [0,0,0,0,0];
      }
      
      public function finishTask(index0:int) : Boolean
      {
         var grantedB:Boolean = false;
         if(index0 >= 0 && index0 < this.task5.length)
         {
            this.task5[index0].state = "over";
            this.slotReadyAt[index0] = Game.gameData.modNoTaskCooldown ? 0 : new Date().time + TASK_COOLDOWN;
         }
         ++this.nowNum;
         if(this.consumeChallengeCard("normal",index0))
         {
            grantedB = true;
         }
         if(Game.gameData.modNoTaskCooldown || this.getCoolingNum() >= this.task5.length)
         {
            this.fleshTaskStr(true);
         }
         return grantedB;
      }
      
      public function refreshCooldownTasks() : *
      {
         var n:int = 0;
         var fresh:Array = null;
         var now:Number = new Date().time;
         n = 0;
         while(n < this.task5.length)
         {
            if(this.task5[n].state == "over" && (Game.gameData.modNoTaskCooldown || Number(this.slotReadyAt[n]) <= 0 || now >= Number(this.slotReadyAt[n])))
            {
               if(fresh == null)
               {
                  Game.taskCreater.fleshList();
                  fresh = Game.taskCreater.getTaskArrCopy();
               }
               this.task5[n] = fresh[n];
               this.task5[n].starLevel = this.otherLevel;
               this.task5[n].fleshAllGift();
               this.slotReadyAt[n] = 0;
            }
            n++;
         }
      }
      
      public function getCoolingNum() : int
      {
         var n:* = undefined;
         var result:int = 0;
         for(n in this.task5)
         {
            if(this.task5[n].state == "over")
            {
               result++;
            }
         }
         return result;
      }
      
      public function getCooldownSeconds(index0:int) : int
      {
         if(index0 < 0 || index0 >= this.slotReadyAt.length)
         {
            return 0;
         }
         return Math.max(0,Math.ceil((Number(this.slotReadyAt[index0]) - new Date().time) / 1000));
      }
      
      public function getCardCooldownSeconds(index0:int = 0) : int
      {
         return Math.max(0,Math.ceil((this.getChallengeCardReadyAt("normal",index0) - new Date().time) / 1000));
      }
      
      public function fleshListData() : *
      {
         Game.taskCreater.fleshList();
         this.task5 = Game.taskCreater.getTaskArrCopy();
      }
      
      public function newDayCtrl() : *
      {
         this.refreshCooldownTasks();
      }
      
      public function getTask_byIndex(num0:int) : OneTaskDefine
      {
         return this.task5[num0];
      }
      
      public function getTrueTask_byIndex(num0:int) : OneTaskDefine
      {
         return this.getTask_byIndex(num0);
      }
      
      public function get nowNum() : int
      {
         return int(TextWay.getText(this._nowNum));
      }
      
      public function set nowNum(v0:int) : *
      {
         this._nowNum = TextWay.toCode(String(v0));
      }
      
      public function get maxNum() : int
      {
         return int(TextWay.getText(this._maxNum));
      }
      
      public function set maxNum(v0:int) : *
      {
         this._maxNum = TextWay.toCode(String(v0));
      }
      
      public function get otherLevel() : int
      {
         return int(TextWay.getText(this._otherLevel));
      }
      
      public function set otherLevel(v0:int) : *
      {
         this._otherLevel = TextWay.toCode(String(v0));
      }
      
      public function getGetTaskB() : Boolean
      {
         return true;
      }
      
      public function getTrueTask5() : Array
      {
         return this.task5;
      }
      
      public function canShowChallengeCard(index0:int) : Boolean
      {
         var td0:OneTaskDefine = this.getTask_byIndex(index0);
         if(td0 == null)
         {
            return false;
         }
         return this.canShowChallengeCardFor("normal",index0,td0.state);
      }
      
      public function reserveChallengeCard(type0:String, index0:int) : Boolean
      {
         return new Date().time >= this.getChallengeCardReadyAt(type0,index0);
      }
      
      public function releaseChallengeCard(type0:String, index0:int) : *
      {
      }
      
      public function consumeChallengeCard(type0:String, index0:int) : Boolean
      {
         var ready:Array = this.getChallengeCardReadyArray(type0);
         if(new Date().time >= this.getChallengeCardReadyAt(type0,index0))
         {
            ready[index0] = new Date().time + CARD_COOLDOWN;
            return true;
         }
         return false;
      }
      
      public function canShowChallengeCardFor(type0:String, index0:int, state0:String) : Boolean
      {
         return new Date().time >= this.getChallengeCardReadyAt(type0,index0);
      }
      
      private function getChallengeCardReadyAt(type0:String, index0:int) : Number
      {
         var value:Number = Number(this.getChallengeCardReadyArray(type0)[index0]);
         return isNaN(value) ? 0 : value;
      }
      
      private function getChallengeCardReadyArray(type0:String) : Array
      {
         if(type0 == "challenge")
         {
            return Game.gameData.challengeTaskData.readyAt;
         }
         if(type0 == "collect")
         {
            return Game.gameData.collectTaskData.readyAt;
         }
         return this.normalCardReadyAt;
      }
   }
}

