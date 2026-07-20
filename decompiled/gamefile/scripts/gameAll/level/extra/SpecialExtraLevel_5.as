package gameAll.level.extra
{
   import gameAll.level.Levels;
   
   public class SpecialExtraLevel_5 extends Levels
   {
      
      public function SpecialExtraLevel_5()
      {
         super();
      }
      
      override public function startLevel() : *
      {
         super.startLevel();
         Game.eventGroup.modelType = "contra";
         hero.SG.attackB = false;
         Game.eventGroup.changArms(0);
      }
      
      override public function bodyAdd(b0:*) : *
      {
         super.bodyAdd(b0);
         b0.define.maxLife = 1;
         b0.define.mulLife();
      }
      
      override public function bodyDie(b0:*) : *
      {
         super.bodyDie(b0);
         if(Math.random() <= 0.05)
         {
            Game.itemsGroup.addAddBall("clearEnemy",0.34,b0.img.x,b0.img.y,Math.PI / 2);
         }
      }
      
      override public function heroRebirth() : *
      {
         hero.SG.attackB = false;
         Game.eventGroup.changArms(0);
      }
   }
}

