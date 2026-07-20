package gameAll.data.collect
{
   import data.TextWay;
   
   public class CollectTaskData
   {
      
      public var pro_arr:Array = [];
      
      public var arr:Array = [];
      
      public var nowTask:CollectTaskDefine = null;
      
      private var _nowNum:String = "";
      
      public function CollectTaskData()
      {
         super();
         this.nowNum = 0;
      }
      
      public function init() : *
      {
         this.nowTask = null;
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
         this.nowNum = 0;
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
         this.nowTask = this.getTrueTask_byIndex(nowIndex);
         this.nowTask.state = "ing";
      }
      
      public function giveupNowTask() : *
      {
         this.nowTask.state = "over";
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
         if(this.nowTask is CollectTaskDefine)
         {
            if(this.nowTask.state == "ing")
            {
               this.nowNum = Game.gameData.materialsItems.getNumByBase(this.nowTask.targetItems);
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

