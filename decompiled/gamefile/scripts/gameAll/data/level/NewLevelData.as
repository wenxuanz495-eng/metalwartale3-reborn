package gameAll.data.level
{
   import com.adobe.serialization.json.JSON2;
   
   public class NewLevelData
   {
      
      public static var packId:Array = ["p1","p2"];
      
      public static var packName:Array = ["自由之心","月球危机"];
      
      public var p1:OnePackData = new OnePackData();
      
      public var p2:OnePackData = new OnePackData();
      
      public var scoreObj:Object = {};
      
      private var _levelPack:String = "p1";
      
      public function NewLevelData()
      {
         super();
      }
      
      public function init() : *
      {
         this.p1.lockNum = 1;
         this.p2.lockNum = 0;
      }
      
      public function inData_byObj(obj:*) : *
      {
         this.p1.inData_byObj(obj.p1);
         this.p2.inData_byObj(obj.p2);
         if(obj.scoreObj is Object)
         {
            this.scoreObj = JSON2.decode(JSON2.encode(obj.scoreObj));
         }
         else
         {
            this.scoreObj = {};
         }
      }
      
      public function set levelPack(str0:String) : *
      {
         this._levelPack = str0;
      }
      
      public function get levelPack() : String
      {
         return this._levelPack;
      }
      
      public function getBeforeLevelPack(lv0:int, lp0:String) : String
      {
         var max0:int = 0;
         var max1:int = 0;
         if(lp0 == "p1")
         {
            max0 = Game.gameData.levelsMax;
            max1 = Game.gameData.knowingData.levelsMax;
            if(lv0 < max0)
            {
               return "";
            }
            if(lv0 < max1)
            {
               return "knowing";
            }
            return "ghost";
         }
         return lp0;
      }
      
      public function getBeforeLevelPackNow(lv0:int) : String
      {
         return this.getBeforeLevelPack(lv0,this.levelPack);
      }
      
      public function getBeforeLevelPackNow2() : String
      {
         return this.getBeforeLevelPack(Game.gameData.nowGameLevel,this.levelPack);
      }
      
      public function switchData(arr0:Array, arr1:Array, arr2:Array, pObj0:Object) : *
      {
         var n:* = undefined;
         var name0:String = null;
         var score0:int = 0;
         var n_arr0:Array = null;
         var newLevel0:int = 0;
         var max0:int = Game.gameData.levelsMax;
         var max1:int = Game.gameData.knowingData.levelsMax;
         var newNum0:int = 1;
         var num0:int = int(arr0[0]);
         var num1:int = int(arr1[0]);
         var num2:int = int(arr2[0]);
         if(num2 > 0)
         {
            newNum0 = num2 + max0 + max1;
         }
         else if(num1 > 0)
         {
            newNum0 = num1 + max0;
         }
         else
         {
            newNum0 = num0;
         }
         this.p1.lockNum = newNum0;
         for(n in pObj0)
         {
            name0 = String(n);
            score0 = int(pObj0[n]);
            n_arr0 = name0.split("_");
            newLevel0 = 0;
            if(n_arr0[0] == "l0")
            {
               newLevel0 = int(n_arr0[2]);
            }
            else if(n_arr0[0] == "l1")
            {
               newLevel0 = int(n_arr0[2]) + max0;
            }
            else
            {
               newLevel0 = int(n_arr0[2]) + max0 + max1;
            }
            this.setScore(score0,newLevel0,int(n_arr0[1]),"p1");
         }
      }
      
      public function unLockNextLevel() : *
      {
         var p0:OnePackData = this.nowPack;
         var nowGameLevel:int = Game.gameData.nowGameLevel;
         trace("nowGameLevel:" + nowGameLevel);
         trace("p0.lockNum:" + p0.lockNum);
         if(nowGameLevel % 100 >= p0.levelsMax - 1)
         {
            trace("如果当前关卡大于最大关卡，说明通关了");
         }
         else if(nowGameLevel % 100 >= p0.lockNum - 1)
         {
            trace("没解锁，就解锁");
            p0.lockNum = nowGameLevel % 100 + 2;
         }
         else
         {
            trace("解锁了");
         }
      }
      
      public function get nowPack() : OnePackData
      {
         return this[this.levelPack];
      }
      
      public function setScore(score0:int, level0:int, diff0:int, packName:String = "") : *
      {
         if(packName == "")
         {
            packName = this.levelPack;
         }
         var name0:String = packName + "_" + diff0 + "_" + level0;
         if(name0 == "p1_0_0")
         {
            score0 = 1;
         }
         if(this.scoreObj.hasOwnProperty(name0))
         {
            if(this.scoreObj[name0] < score0)
            {
               this.scoreObj[name0] = score0;
            }
         }
         else
         {
            this.scoreObj[name0] = score0;
         }
      }
      
      public function getScore(level0:int, diff0:int, packName:String = "") : int
      {
         if(packName == "")
         {
            packName = this.levelPack;
         }
         var name0:String = "";
         name0 = packName + "_" + diff0 + "_" + level0;
         if(packName == "p2")
         {
            name0 = packName + "_" + diff0 + "_" + (level0 + 100);
         }
         if(this.scoreObj.hasOwnProperty(name0))
         {
            return this.scoreObj[name0];
         }
         return -1;
      }
      
      public function getAllStar() : int
      {
         return (this.p1.levelsMax + this.p2.levelsMax) * 4 - 4;
      }
      
      public function plusAllStar() : int
      {
         var n:* = undefined;
         var num0:int = 0;
         for(n in this.scoreObj)
         {
            if(n != "p1_0_0")
            {
               num0 += Game.gameDefine.getPassGradeIndex(this.scoreObj[n]);
            }
         }
         return num0;
      }
   }
}

