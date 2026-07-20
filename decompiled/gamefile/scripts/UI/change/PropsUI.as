package UI.change
{
   public class PropsUI extends MaterialsUI
   {
      
      public function PropsUI()
      {
         super();
      }
      
      override protected function initData() : *
      {
         itemsData = Game.gameData.propsItems;
      }
      
      override public function differentFun() : *
      {
         itemsBox.setNum(3,5,178,309);
         itemsBox.x = 149;
         itemsBox.y = 73;
      }
   }
}

