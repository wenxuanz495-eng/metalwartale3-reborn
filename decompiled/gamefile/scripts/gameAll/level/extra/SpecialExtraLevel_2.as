package gameAll.level.extra
{
   import gameAll.level.Levels;
   
   public class SpecialExtraLevel_2 extends Levels
   {
      
      public function SpecialExtraLevel_2()
      {
         super();
      }
      
      override public function startLevel() : *
      {
         super.startLevel();
         allowRebirthCrystalNum = -1;
      }
      
      override public function levelTimer() : *
      {
         if(enabled)
         {
            super.levelTimer();
            if(hero.img.y >= 1300)
            {
               if(hero.die == 0)
               {
                  Game.eventGroup.noUseRebirthCrystal();
               }
            }
         }
      }
   }
}

