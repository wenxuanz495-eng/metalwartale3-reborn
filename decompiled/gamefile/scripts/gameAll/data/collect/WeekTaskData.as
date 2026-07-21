package gameAll.data.collect
{
   import data.TextWay;
   
   public class WeekTaskData
   {
      
      public var pro_arr:Array = [];
      
      public var arr:Array = [];
      
      public var nowTask:CollectTaskDefine = null;
      
      private var _nowNum:String = "";
      
      public var buyB:Boolean = false;
      
      public var weekFleshDate:String = "";
      
      public function WeekTaskData()
      {
         super();
         this.pro_arr = ["buyB","weekFleshDate","nowNum"];
      }
      
      public function init() : *
      {
         this.nowTask = null;
         this.buyB = false;
         this.weekFleshDate = "";
         this.nowNum = 0;
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
            // Legacy saves used "over" as a daily/weekly exhausted state.
            // Sweep tasks are now unlimited, so migrate it to available.
            if(d0.state == "over")
            {
               d0.state = "no";
            }
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
         var d0:CollectTaskDefine = null;
         var arr1:Array = Game.gameDefine.taskDefine.weekArr;
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
            if(d0.state == "over")
            {
               d0.state = "no";
            }
            this.arr[n] = d0;
         }
      }
      
      public function addKillNum(value:int) : *
      {
         if(Boolean(this.nowTask))
         {
            if(this.nowTask.state == "ing")
            {
               this.nowNum += value;
               Game.uiGroup.gamingUI.fleshTaskBox();
               if(this.nowNum >= this.nowTask.targetNum)
               {
                  this.completeNowTask();
               }
            }
         }
      }
      
      public function startOneTask(nowIndex:*) : *
      {
         this.nowTask = this.getTrueTask_byIndex(nowIndex);
         if(this.nowTask != null)
         {
            this.nowTask.state = "ing";
            this.nowNum = 0;
         }
      }
      
      public function getTrueTask_byIndex(index0:int) : *
      {
         return this.arr[index0];
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
         Game.uiGroup.gamingUI.fleshTaskBox();
      }
      
      public function getGiftNowTask() : *
      {
         this.nowTask.state = "no";
         this.nowTask = null;
         this.nowNum = 0;
      }
      
      public function newDayCtrl() : *
      {
         // No daily/weekly quota remains. Keep this method only for old save
         // compatibility and normalize exhausted legacy states.
         this.buyB = false;
         this.newWeekCtrl();
      }
      
      public function newWeekCtrl() : *
      {
         var n:* = undefined;
         var td0:CollectTaskDefine = null;
         for(n in this.arr)
         {
            td0 = this.arr[n];
            if(td0.state == "over")
            {
               td0.state = "no";
            }
         }
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

