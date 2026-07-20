package UI.change
{
   public class SubEquipmentUI extends EquipmentUI
   {
      
      public function SubEquipmentUI()
      {
         super();
      }
      
      override protected function initData() : *
      {
         itemsData = Game.gameData.subItems;
         mustDefine = Game.gameDefine.subMust;
         nowArmsType = [0,0,0,0,0,0,0,0];
         equipSite = 0;
         type = "sub";
      }
   }
}

