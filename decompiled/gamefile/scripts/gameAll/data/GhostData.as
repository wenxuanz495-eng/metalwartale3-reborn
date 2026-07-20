package gameAll.data
{
   public class GhostData extends KnowingData
   {
      
      public function GhostData()
      {
         super();
         levelsMax = 24;
      }
      
      override public function getMustLevel(num0:int) : *
      {
         return Game.gameDefine.getGhostMustLevel(num0);
      }
      
      override public function unLockNextLevel(nowdiff0:int, index0:int) : *
      {
         var nextDiff0:int = 0;
         var num0:int = int(levelsLock[nowdiff0]);
         if(index0 + 1 >= levelsMax)
         {
            trace("最后一关");
            if(Game.gameData.nowDifficult >= 0 && Game.gameData.nowDifficult < 3)
            {
               nextDiff0 = Game.gameData.nowDifficult + 1;
               if(levelsLock[nextDiff0] == 0)
               {
                  trace("解锁下面一个难度");
                  levelsLock[nextDiff0] = 1;
               }
            }
         }
         else if(index0 + 1 >= num0)
         {
            trace("解锁下一关");
            levelsLock[nowdiff0] = num0 + 1;
         }
         else
         {
            trace("玩之前的关卡 不作处理");
         }
      }
   }
}

