package gameAll.data
{
   public class KnowingData
   {
      
      public static var diffText:Array = ["","knowing","ghost","3"];
      
      public static var VERSION:Number = 2.9;
      
      public var levelsLock:Array = [0,0,0,0];
      
      public var diffChoose:Array = [0,0,0,0];
      
      public var levelsMax:int = 12;
      
      public var saveDataVersion:Number = 0;
      
      public function KnowingData()
      {
         super();
      }
      
      public function init() : *
      {
         this.levelsLock = [0,0,0,0];
         this.diffChoose = [0,0,0,0];
      }
      
      public function inData_byObj(obj:Object) : *
      {
         var n:* = undefined;
         var m:* = undefined;
         var pro0:String = null;
         var i:* = undefined;
         var pro_arr:Array = [];
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            this[pro0] = obj[pro0];
         }
         this.diffChoose = [0,0,0,0];
         for(m in this.levelsLock)
         {
            this.levelsLock[m] = obj.levelsLock[m];
         }
         if(!obj.hasOwnProperty("saveDataVersion"))
         {
            this.saveDataVersion = VERSION - 0.01;
         }
         else
         {
            this.saveDataVersion = obj.saveDataVersion;
         }
         if(this.saveDataVersion < VERSION)
         {
            if(this is GhostData)
            {
               if(this.levelsLock[1] <= 0)
               {
                  if(Game.gameData.level < 59)
                  {
                     this.levelsLock[0] = 0;
                  }
               }
               for(i in this.levelsLock)
               {
                  if(this.levelsLock[i] == 22)
                  {
                     this.levelsLock[i] = 23;
                  }
               }
            }
            else
            {
               this.levelsLock[0] = this.getUnlockLevel();
               if(this.levelsLock[0] >= this.levelsMax)
               {
                  if(this.levelsLock[1] <= 0)
                  {
                     this.levelsLock[1] = 1;
                  }
               }
            }
         }
         this.saveDataVersion = VERSION;
      }
      
      public function getMustLevel(num0:int) : *
      {
         return Game.gameDefine.getKnowingMustLevel(num0);
      }
      
      public function getUnlockLevel() : int
      {
         return Game.gameDefine.getKnowingUnlockLevel(Game.gameData.level,this.levelsMax);
      }
      
      public function unLockNextLevel(nowdiff0:int, index0:int) : *
      {
         var nextDiff0:int = 0;
         var num0:int = int(this.levelsLock[nowdiff0]);
         if(index0 + 1 >= this.levelsMax)
         {
            trace("最后一关");
            if(Game.gameData.nowDifficult >= 0 && Game.gameData.nowDifficult <= 3)
            {
               if(Game.gameData.nowDifficult >= 3)
               {
                  trace("全难度通关，开启幽灵行动");
               }
               else
               {
                  nextDiff0 = Game.gameData.nowDifficult + 1;
                  if(this.levelsLock[nextDiff0] == 0)
                  {
                     trace("解锁下面一个难度");
                     this.levelsLock[nextDiff0] = 1;
                  }
                  trace("开启幽灵行动");
                  if(Game.gameData.ghostData.levelsLock[0] <= 0)
                  {
                     Game.gameData.ghostData.levelsLock[0] = 1;
                  }
               }
            }
         }
         else if(index0 + 1 >= num0)
         {
            trace("解锁下一关");
            this.levelsLock[nowdiff0] = num0 + 1;
         }
         else
         {
            trace("玩之前的关卡 不作处理");
         }
      }
      
      public function setDiff_byStr(str0:String, diff0:int) : *
      {
         var index0:int = diffText.indexOf(str0);
         this.diffChoose[index0] = diff0;
      }
      
      public function getDiff_byStr(str0:String) : int
      {
         var index0:int = diffText.indexOf(str0);
         return this.diffChoose[index0];
      }
   }
}

