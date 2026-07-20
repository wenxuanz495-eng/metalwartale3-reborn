package effect.text
{
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class RiseText extends TextField
   {
      
      public var life:int = 0;
      
      public var life_t:int = 0;
      
      public var vy:Number = -2;
      
      public function RiseText()
      {
         super();
         this.mouseEnabled = false;
         this.mouseWheelEnabled = false;
         this.selectable = false;
         this.multiline = false;
         this.embedFonts = false;
         this.wordWrap = false;
         this.autoSize = "center";
         var tf:TextFormat = new TextFormat(null,13);
         this.defaultTextFormat = tf;
      }
      
      public function setText(str:String) : *
      {
         this.width = 0;
         text = str;
         this.width = 10;
      }
      
      public function addFilter() : *
      {
         var f0:DropShadowFilter = new DropShadowFilter(0,0,0,0.5);
         f0.blurX = 5;
         f0.blurY = 5;
         f0.strength = 10;
         this.filters = [f0];
      }
      
      public function FTimer() : *
      {
         ++this.life_t;
         this.y += this.vy;
      }
   }
}

