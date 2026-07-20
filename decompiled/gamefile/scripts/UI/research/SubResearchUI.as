package UI.research
{
   public class SubResearchUI extends ArmsResearchUI
   {
      
      public function SubResearchUI()
      {
         super();
      }
      
      override public function init() : *
      {
         itemsData = Game.gameData.subItems;
         materialsItems = Game.gameData.materialsItems;
         armsFatherLabel = "subArms";
      }
   }
}

