package gameAll.data.collect
{
   import data.StringDate;
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
         this.nowTask.state = "ing";
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
         this.nowTask.state = "over";
         this.nowTask = null;
         this.nowNum = 0;
      }
      
      public function newDayCtrl() : *
      {
         var cd0:int = 0;
         var nd0:StringDate = Game.severTime.nowTime;
         trace("当前时间：" + nd0.getStr());
         trace("刷新日期：" + this.weekFleshDate);
         var d0:StringDate = new StringDate();
         if(this.weekFleshDate == "")
         {
            this.weekFleshDate = nd0.getStr();
         }
         d0.inData_byStr(this.weekFleshDate);
         if(nd0.fullYear >= 2013)
         {
            cd0 = -nd0.compareDate(d0);
            if(cd0 >= 7)
            {
               this.buyB = false;
               this.newWeekCtrl();
               this.weekFleshDate = nd0.getStr();
            }
         }
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

