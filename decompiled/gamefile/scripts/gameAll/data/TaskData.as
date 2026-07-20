package gameAll.data
{
   import data.TextWay;
   import gameAll.define.OneTaskDefine;
   
   public class TaskData
   {
      
      public static var baseMaxNum:int = 10;
      
      public var saveDataVersion:Number = 1.2;
      
      private var _nowNum:String = "0";
      
      private var _maxNum:String = "0";
      
      public var nowTask:OneTaskDefine = new OneTaskDefine();
      
      private var _index:String = "0";
      
      private var _otherLevel:String = "0";
      
      public var task5:Array = [];
      
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
      }
      
      public function inData_byObj(obj:Object) : *
      {
         var n:* = undefined;
         var m:* = undefined;
         var pro0:String = null;
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
            this.nowTask.init();
            this.nowTask.inData_byObj(td0);
            this.nowTask.state = "ing";
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
      }
      
      public function fleshListData() : *
      {
         Game.taskCreater.fleshList();
         this.task5 = Game.taskCreater.getTaskArrCopy();
      }
      
      public function newDayCtrl() : *
      {
         this.otherLevel = 0;
         this.fleshListData();
         this.fleshAllGift();
         this.nowNum = 0;
         this.maxNum = baseMaxNum;
         this.nowTask.init();
      }
      
      public function getTask_byIndex(num0:int) : OneTaskDefine
      {
         return this.task5[num0];
      }
      
      public function getTrueTask_byIndex(num0:int) : OneTaskDefine
      {
         if(this.nowTask.state != "no")
         {
            if(num0 == this.nowTask.index)
            {
               return this.nowTask;
            }
         }
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
         if(this.nowNum >= this.maxNum)
         {
            return false;
         }
         return true;
      }
      
      public function getTrueTask5() : Array
      {
         var n:* = undefined;
         var arr0:Array = [];
         for(n in this.task5)
         {
            if(this.nowTask.state == "no")
            {
               arr0.push(this.task5[n]);
            }
            else if(this.nowTask.index == n)
            {
               arr0.push(this.nowTask);
            }
            else
            {
               arr0.push(this.task5[n]);
            }
         }
         return arr0;
      }
   }
}

