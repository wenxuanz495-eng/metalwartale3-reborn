package gameAll.level.extra
{
   import gameAll.level.Levels;
   
   public class SpecialExtraLevel_10 extends Levels
   {
      
      public function SpecialExtraLevel_10()
      {
         super();
      }
      
      override public function bodyDie(b0:*) : *
      {
         super.bodyDie(b0);
         Game.itemsGroup.dropMaterials(b0);
         Game.itemsGroup.dropMaterials(b0);
      }
   }
}

