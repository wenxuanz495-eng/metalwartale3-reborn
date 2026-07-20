package gameAll.level.extra
{
   import gameAll.level.Levels;
   
   public class SpecialExtraLevel_9 extends Levels
   {
      
      public function SpecialExtraLevel_9()
      {
         super();
      }
      
      override public function bodyAdd(b0:*) : *
      {
         super.bodyAdd(b0);
         b0.define.coin = 20000;
      }
      
      override public function bodyDie(b0:*) : *
      {
         super.bodyDie(b0);
         var coin0:int = int(b0.define.coin);
         if(coin0 * 4 > 80000)
         {
            Game.uiGroup.showZuobile("");
         }
         Game.itemsGroup.addAddBall2("money",coin0,b0);
      }
   }
}

