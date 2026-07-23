package gameAll.data
{
   import data.TextWay;
   import gameAll.define.liveness.LivenessGiftDefine;
   import gameAll.define.liveness.LivenessTaskDefine;
   
   public class LivenessData
   {
      
      public static var max:int = 100;
      
      public static var giftNum:int = 5;
      
      public static var taskMaxNum:int = 7;
      
      private var _value:String = "";
      
      public var firstGetB:Boolean = false;
      
      public var newGiftGetB:Boolean = false;
      
      public var upgradeGiftGetB:Boolean = false;
      
      public var giftGetB:Array = [];
      
      private var _taskNumArr:Array = [];
      
      public var boughtArr:Array = [];
      
      public function LivenessData()
      {
         super();
      }
      
      public function getEnabledNum() : int
      {
         var m:* = undefined;
         var num0:int = 0;
         var arr0:Array = this.getGiftStateArr();
         for(m in arr0)
         {
            if(arr0[m] == "get")
            {
               num0++;
            }
         }
         return num0;
      }
      
      public function init() : *
      {
         this.value = 0;
         this.firstGetB = false;
         this.newGiftGetB = false;
         this.upgradeGiftGetB = false;
         this.initGiftGet();
         this.initTaskNum();
         this.forceLoginTaskComplete();
      }
      
      public function initGiftGet() : *
      {
         this.giftGetB = [];
         for(var i:int = 0; i < giftNum; i++)
         {
            this.giftGetB.push(false);
         }
      }
      
      public function initTaskNum() : *
      {
         var arr0:Array = [];
         for(var i:int = 0; i < taskMaxNum; i++)
         {
            arr0.push(0);
         }
         this.taskNumArr = arr0;
      }
      
      public function newDayCtrl(countLogin:Boolean = true) : *
      {
         this.value = 0;
         this.initGiftGet();
         this.initTaskNum();
         this.forceLoginTaskComplete();
      }
      
      public function inData_byObj(obj:Object) : *
      {
         var i:* = undefined;
         var taskArr:Array = null;
         if(obj == null)
         {
            this.init();
            return;
         }
         this.value = obj.hasOwnProperty("value") ? int(obj.value) : 0;
         this.firstGetB = obj.hasOwnProperty("firstGetB") ? Boolean(obj.firstGetB) : false;
         taskArr = obj.hasOwnProperty("taskNumArr") && obj.taskNumArr is Array ? obj.taskNumArr.concat() : [];
         while(taskArr.length < taskMaxNum)
         {
            taskArr.push(0);
         }
         if(taskArr.length > taskMaxNum)
         {
            taskArr.length = taskMaxNum;
         }
         this.taskNumArr = taskArr;
         this.forceLoginTaskComplete();
         this.initGiftGet();
         if(obj.hasOwnProperty("giftGetB") && obj.giftGetB is Array)
         {
            for(i in obj.giftGetB)
            {
               if(int(i) < giftNum)
               {
                  this.giftGetB[i] = Boolean(obj.giftGetB[i]);
               }
            }
         }
         if(!obj.hasOwnProperty("newGiftGetB"))
         {
            this.newGiftGetB = false;
         }
         else
         {
            this.newGiftGetB = obj.newGiftGetB;
         }
         if(!obj.hasOwnProperty("upgradeGiftGetB"))
         {
            this.upgradeGiftGetB = false;
         }
         else
         {
            this.upgradeGiftGetB = obj.upgradeGiftGetB;
         }
         if(!obj.hasOwnProperty("boughtArr"))
         {
            this.boughtArr = [];
         }
         else
         {
            this.boughtArr = obj.boughtArr;
         }
      }

      private function forceLoginTaskComplete() : *
      {
         var d0:LivenessTaskDefine = Game.gameDefine.liveness.getTaskDefine_byId("login");
         var arr0:Array = null;
         if(d0 is LivenessTaskDefine)
         {
            arr0 = this.taskNumArr;
            if(int(arr0[d0.index]) != -1)
            {
               arr0[d0.index] = -1;
               this.taskNumArr = arr0;
               this.addValue(d0.gift);
            }
         }
      }
      
      public function addValue(num0:int) : *
      {
         this.value += num0;
         if(this.value > max)
         {
            this.value = max;
         }
         else if(this.value < 0)
         {
            this.value = 0;
         }
      }
      
      public function getGift_byIndex(index0:int) : Boolean
      {
         this.giftGetB[index0] = true;
         if(this.value < max)
         {
            return false;
         }
         var i:int = 0;
         while(i < giftNum)
         {
            if(!Boolean(this.giftGetB[i]))
            {
               return false;
            }
            i++;
         }
         // Reuse the daily reset path, but do not count login again in the
         // same session. The new cycle must visibly start at 0 liveness.
         this.newDayCtrl(false);
         return true;
      }
      
      public function getGiftStateArr() : Array
      {
         var n:* = undefined;
         var d0:LivenessGiftDefine = null;
         var sB:Boolean = false;
         var arr1:Array = [];
         var arr0:Array = Game.gameDefine.liveness.arr;
         for(n in arr0)
         {
            d0 = arr0[n];
            sB = Boolean(this.giftGetB[n]);
            if(sB)
            {
               arr1.push("over");
            }
            else if(this.value >= d0.mustValue)
            {
               arr1.push("get");
            }
            else
            {
               arr1.push("no");
            }
         }
         return arr1;
      }
      
      public function addTaskNum(id0:String) : *
      {
         var now_v:int = 0;
         var arr0:Array = this.taskNumArr;
         var d0:LivenessTaskDefine = Game.gameDefine.liveness.getTaskDefine_byId(id0);
         if(d0 is LivenessTaskDefine)
         {
            now_v = int(arr0[d0.index]);
            if(now_v >= 0)
            {
               now_v++;
               trace("增加了任务：" + d0.name + "：一次");
               if(now_v >= d0.must)
               {
                  now_v = -1;
                  trace("完成任务：" + d0.name + "，获得活跃值：" + d0.gift);
                  this.addValue(d0.gift);
               }
               arr0[d0.index] = now_v;
            }
         }
         this.taskNumArr = arr0;
      }
      
      public function set taskNumArr(arr0:Array) : *
      {
         var n:* = undefined;
         this._taskNumArr = [];
         for(n in arr0)
         {
            this._taskNumArr[n] = TextWay.toCode(String(arr0[n]));
         }
      }
      
      public function get taskNumArr() : Array
      {
         var n:* = undefined;
         var arr0:Array = [];
         for(n in this._taskNumArr)
         {
            arr0[n] = int(TextWay.getText(this._taskNumArr[n]));
         }
         return arr0;
      }
      
      public function set value(num0:int) : *
      {
         this._value = TextWay.toCode(String(num0));
      }
      
      public function get value() : int
      {
         return int(TextWay.getText(this._value));
      }
   }
}

