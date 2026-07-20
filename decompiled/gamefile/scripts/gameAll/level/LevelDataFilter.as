package gameAll.level
{
   public class LevelDataFilter
   {
      
      public var LG:LevelGroup;
      
      public var diffArr:Array = [1,1,1,1];
      
      public var enemyDataArr:Array = [];
      
      public function LevelDataFilter()
      {
         super();
      }
      
      public function inEnemyData_byXML(xml0:XML) : *
      {
         var n:* = undefined;
         var l_xml0:XML = null;
         var d0:EnemyLevelDefine = null;
         var list0:XMLList = xml0.level;
         for(n in list0)
         {
            l_xml0 = list0[n];
            d0 = new EnemyLevelDefine();
            d0.inData_byXML(l_xml0);
            this.enemyDataArr.push(d0);
         }
      }
      
      public function init() : *
      {
         var n:* = undefined;
         var i:* = undefined;
         var d0:LevelsDefine = null;
         this.LG.normalEnemyLevelObj["p1"] = [];
         this.LG.normalEnemyLevelObj["p2"] = [];
         for(n in this.LG.normalLevelObj)
         {
            for(i in this.LG.normalLevelObj[n])
            {
               d0 = this.LG.normalLevelObj[n][i];
               this.LG.normalEnemyLevelObj[n].push(d0.enemyLv);
            }
         }
      }
      
      public function getEnemyLvNow() : int
      {
         return this.getEnemyLv(Game.gameData.nowGameLevel,Game.gameData.newLevelData.levelPack);
      }
      
      public function getEnemyLv(level0:int, lp0:String) : int
      {
         var arr0:Array = null;
         var obj0:Object = this.LG.normalEnemyLevelObj;
         if(obj0.hasOwnProperty(lp0))
         {
            arr0 = obj0[lp0];
            if(lp0 == "p2")
            {
               level0 %= 100;
            }
            if(arr0.length < level0)
            {
               trace("没找到资料片【" + lp0 + "】的关卡：" + level0);
               return Game.gameData.level;
            }
            return arr0[level0];
         }
         trace("没找到资料片【" + lp0 + "】的");
         return 1;
      }
      
      public function getEnemyLevelDefine(lv0:int) : EnemyLevelDefine
      {
         var d0:EnemyLevelDefine = new EnemyLevelDefine();
         d0.baseAttack = Game.gameDefine.test_getEnemyHurt_byLevel(lv0 - 1,Game.gameData.nowDifficult);
         d0.baseLife = Game.gameDefine.test_getEnemyLife_byLevel(lv0 - 1,Game.gameData.nowDifficult);
         d0.baseExp = Game.gameDefine.test_getEnemyExp_byLevel(lv0 - 1);
         d0.baseCoin = Game.gameDefine.test_getEnemyCoin_byLevel(lv0 - 1);
         return d0;
      }
      
      public function test2() : *
      {
         var arr0:Array = null;
         var xxx:int = 0;
         for(var i:int = 0; i < 10; i++)
         {
            arr0 = this.getLevelArr_byLessLv(i * 10 + 1,5);
            xxx = 0;
         }
      }
      
      public function getDifficultRaNow() : Number
      {
         return this.getDifficultRa(Game.gameData.nowGameLevel,Game.gameData.nowDifficult,Game.gameData.newLevelData.levelPack);
      }
      
      public function getDifficultRa(level0:int, diff0:int, lp0:String) : Number
      {
         return this.diffArr[diff0];
      }
      
      public function getLevelArr_byLessLv(lv0:int, num0:int) : Array
      {
         var i:* = undefined;
         var arr2:Array = null;
         var nowlevel0:LevelsDefine = null;
         var n:* = undefined;
         var level0:LevelsDefine = null;
         var len0:int = 0;
         var j:int = 0;
         var arr1:Array = [];
         for(i in this.LG.normalLevelObj)
         {
            arr1 = arr1.concat(this.LG.normalLevelObj[i]);
         }
         arr1.sortOn("enemyLv",Array.NUMERIC);
         arr1.reverse();
         arr1.pop();
         arr2 = [];
         nowlevel0 = this.getLastUnlockLevel();
         for(n in arr1)
         {
            if(arr2.length >= num0)
            {
               break;
            }
            level0 = arr1[n];
            if(Boolean(level0.enemyLv >= 0) && Boolean(nowlevel0) && level0.enemyLv + 1 <= nowlevel0.enemyLv)
            {
               arr2.unshift(level0);
            }
         }
         if(arr2.length < num0)
         {
            len0 = num0 - arr2.length;
            for(j = 0; j < len0; j++)
            {
               arr2.unshift(arr1[arr1.length - 1]);
            }
         }
         var xx:int = 0;
         return arr2;
      }
      
      public function getLastUnlockLevel() : LevelsDefine
      {
         var num0:int = Game.gameData.newLevelData.p1.lockNum;
         var num1:int = Game.gameData.newLevelData.p2.lockNum;
         if(num1 > 0)
         {
            return this.LG.normalLevelObj.p2[num1 % 70 - 1];
         }
         return this.LG.normalLevelObj.p1[num0 - 1];
      }
      
      public function getBeforeLevel(diff0:int, level0:int) : LevelsDefine
      {
         trace("diff0:" + diff0 + ",level0:" + level0);
         var arr0:Array = Game.gameData.changeToNewLevel(diff0,level0);
         return this.getLevelDefine(arr0[0],arr0[1]);
      }
      
      public function getLevelDefine(pack0:String, level0:int) : LevelsDefine
      {
         trace("pack0:" + pack0 + ",level0:" + level0);
         return this.LG.normalLevelObj[pack0][level0];
      }
   }
}

