package UI.fase
{
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class LoaderBar extends Sprite
   {
      
      public var txt:TextField;
      
      public var cover:Sprite;
      
      public function LoaderBar()
      {
         super();
         this.mouseChildren = false;
         this.mouseEnabled = false;
      }
      
      public function setText(str:String) : *
      {
         this.txt.htmlText = str;
      }
      
      public function setBaifen(baifen:Number) : *
      {
         if(baifen >= 0 && baifen <= 1)
         {
            this.cover.scaleX = baifen;
         }
      }
   }
}

