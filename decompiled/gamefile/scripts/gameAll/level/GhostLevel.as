package gameAll.level
{
   import UI.gaming.HeadTitle;
   
   public class GhostLevel extends Levels
   {
      
      public function GhostLevel()
      {
         super();
      }
      
      public function addHeadTitle(b0:*) : *
      {
         var headTitle:HeadTitle = new HeadTitle();
         b0.img.addChild(headTitle);
         b0.img.headTitle = headTitle;
         headTitle.y = b0.define.hitRect.y - 20;
         headTitle.x = 0;
         headTitle.txt.text = b0.define.trueName;
      }
      
      override public function bodyAdd(b0:*) : *
      {
         super.bodyAdd(b0);
         if(b0.define.trueName != "")
         {
            this.addHeadTitle(b0);
         }
      }
   }
}

