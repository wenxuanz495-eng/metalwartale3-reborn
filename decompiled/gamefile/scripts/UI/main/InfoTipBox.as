package UI.main
{
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class InfoTipBox extends Sprite
   {
      
      public var txt:TextField;
      
      public var back:Sprite;
      
      public function InfoTipBox()
      {
         super();
         this.txt.autoSize = "left";
         this.txt.wordWrap = false;
         this.visible = false;
         this.mouseChildren = false;
         this.mouseEnabled = false;
      }
      
      public function showText(str:String, setWidth:int = -1) : *
      {
         this.visible = true;
         if(setWidth > 0)
         {
            this.txt.width = setWidth;
            this.txt.wordWrap = true;
         }
         else
         {
            this.txt.wordWrap = false;
         }
         this.txt.htmlText = str;
         if(this.txt.numLines <= 1)
         {
            this.back.height = this.txt.height + 4;
         }
         else
         {
            this.back.height = this.txt.height + 13;
         }
         this.back.width = this.txt.width + 14;
      }
      
      public function hide() : *
      {
         this.visible = false;
      }
   }
}

