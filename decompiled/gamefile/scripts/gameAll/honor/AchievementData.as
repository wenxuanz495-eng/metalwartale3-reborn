package gameAll.honor
{
   import data.TextWay;
   
   public class AchievementData
   {
      
      public var arr:Array = [];
      
      private var _acValue:String = "";
      
      private var _killEnemyNum:String = "";
      
      public function AchievementData()
      {
         super();
      }
      
      public function init() : *
      {
         this.arr.length = 0;
         this.acValue = 0;
         this.killEnemyNum = 0;
      }
      
      public function inData_byObj(obj:Object) : *
      {
         var n:* = undefined;
         var m:* = undefined;
         var pro0:String = null;
         var data0:AchievementOneData = null;
         var pro_arr:Array = ["acValue"];
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            this[pro0] = obj[pro0];
         }
         this.arr.length = 0;
         for(m in obj.arr)
         {
            data0 = new AchievementOneData();
            data0.inData_byObj(obj.arr[m]);
            this.arr.push(data0);
         }
         if(obj.hasOwnProperty("killEnemyNum"))
         {
            this.killEnemyNum = obj.killEnemyNum;
         }
         else
         {
            this.killEnemyNum = 0;
         }
      }
      
      public function addValue(v0:Number) : *
      {
         this.acValue += v0;
         if(this.acValue < 0)
         {
            this.acValue = 0;
         }
      }
      
      public function fleshComplete(type0:String) : *
      {
         var n:* = undefined;
         var arr0:Array = this.getDefineList_expectData(type0);
         var p_type0:String = AchievementOneDefine.getProgressTypeOther(type0);
         var now0:Number = 0;
         var max0:Number = 0;
         var nowStr:* = Game.gameData.getOneData_byType(type0);
         var d0:AchievementOneDefine = null;
         if(p_type0 == "stateNumberType")
         {
            for(n in arr0)
            {
               d0 = arr0[n];
               if(nowStr is Array)
               {
                  now0 = Number(nowStr[int(d0.getMustArray()[0])]) - 1;
                  max0 = Number(int(d0.getMustArray()[1])) - 1;
               }
               else
               {
                  now0 = Number(nowStr);
                  max0 = Number(d0.must);
               }
               if(now0 >= max0)
               {
                  this.addData_byDefine(d0);
               }
               else if(d0.type != "level")
               {
                  break;
               }
            }
         }
         else if(p_type0 == "arrayNumberType")
         {
         }
      }
      
      public function addData_byDefine(d0:AchievementOneDefine, nowStr:String = "") : *
      {
         var data0:AchievementOneData = new AchievementOneData();
         data0.type = d0.type;
         data0.name = d0.name;
         data0.haveGiftB = false;
         if(nowStr == "")
         {
            data0.now = "";
            data0.completeTime = Game.timeDate.getLocalTimeStr();
         }
         else
         {
            data0.now = nowStr;
            data0.completeTime = "";
         }
         this.arr.push(data0);
      }
      
      public function getNoCompleteList(type0:String) : Array
      {
         var n:* = undefined;
         var d0:AchievementOneDefine = null;
         var data0:AchievementOneData = null;
         var nowArr0:Array = [];
         var arr0:Array = [];
         var name0:String = type0 + "_arr";
         if(Game.gameDefine.honor.ac.hasOwnProperty(name0))
         {
            arr0 = Game.gameDefine.honor.ac[name0];
         }
         var data_arr0:Array = this.getDataList(type0);
         for(n in arr0)
         {
            d0 = arr0[n];
            data0 = this.findData_inArr(data_arr0,d0.name);
            if(this.findData_inArr(data_arr0,d0.name) is AchievementOneData)
            {
               if(data0.completeTime == "")
               {
                  nowArr0.push(data0);
               }
            }
            else
            {
               nowArr0.push(d0);
            }
         }
         return nowArr0;
      }
      
      public function getCompleteList(type0:String) : Array
      {
         var n:* = undefined;
         var data0:AchievementOneData = null;
         var arr0:Array = [];
         for(n in this.arr)
         {
            data0 = this.arr[n];
            if(data0.type == type0 && data0.completeTime != "")
            {
               arr0.push(data0);
            }
         }
         return arr0;
      }
      
      private function getDefineList(type0:String) : Array
      {
         var arr0:Array = [];
         var name0:String = type0 + "_arr";
         if(Game.gameDefine.honor.ac.hasOwnProperty(name0))
         {
            arr0 = Game.gameDefine.honor.ac[name0];
         }
         return arr0;
      }
      
      private function getDefineList_expectData(type0:String) : Array
      {
         var n:* = undefined;
         var d0:AchievementOneDefine = null;
         var nowArr0:Array = [];
         var arr0:Array = [];
         var name0:String = type0 + "_arr";
         if(Game.gameDefine.honor.ac.hasOwnProperty(name0))
         {
            arr0 = Game.gameDefine.honor.ac[name0];
         }
         var data_arr0:Array = this.getDataList(type0);
         for(n in arr0)
         {
            d0 = arr0[n];
            if(!(this.findData_inArr(data_arr0,d0.name) is AchievementOneData))
            {
               nowArr0.push(d0);
            }
         }
         return nowArr0;
      }
      
      private function getDataList(type0:String) : Array
      {
         var n:* = undefined;
         var data0:AchievementOneData = null;
         var arr0:Array = [];
         for(n in this.arr)
         {
            data0 = this.arr[n];
            if(data0.type == type0)
            {
               arr0.push(data0);
            }
         }
         return arr0;
      }
      
      private function findData(type0:String, name0:String) : AchievementOneData
      {
         var arr0:Array = this.getDataList(type0);
         return this.findData_inArr(arr0,name0);
      }
      
      private function findData_inArr(arr0:Array, name0:String) : AchievementOneData
      {
         var n:* = undefined;
         var data0:AchievementOneData = null;
         for(n in arr0)
         {
            data0 = arr0[n];
            if(data0.name == name0)
            {
               return data0;
            }
         }
         return null;
      }
      
      public function getDefine(type0:String, name0:String) : AchievementOneDefine
      {
         return Game.gameDefine.honor.ac.getDefine(type0,name0);
      }
      
      public function set acValue(value0:Number) : *
      {
         this._acValue = TextWay.toCode(String(value0));
      }
      
      public function get acValue() : Number
      {
         return Number(TextWay.getText(this._acValue));
      }
      
      public function set killEnemyNum(value0:Number) : *
      {
         this._killEnemyNum = TextWay.toCode(String(value0));
      }
      
      public function get killEnemyNum() : Number
      {
         return Number(TextWay.getText(this._killEnemyNum));
      }
   }
}

