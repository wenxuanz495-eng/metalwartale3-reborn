package gameAll.level.extra
{
   import gameAll.level.Level_2_5;
   
   public class SpecialExtraLevel_3 extends Level_2_5
   {
      
      public function SpecialExtraLevel_3()
      {
         super();
      }
      
      override public function startLevel() : *
      {
         super.startLevel();
         now_t = 3 * 60;
      }
      
      override public function bodyDie(b0:*) : *
      {
         super.bodyDie(b0);
         if(Math.random() <= 0.05)
         {
            Game.itemsGroup.addAddBall("timeRecover",0.34,b0.img.x,b0.img.y,Math.PI / 2);
         }
      }
   }
}

