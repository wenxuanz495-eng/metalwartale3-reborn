package UI.gaming
{
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class LifeBar extends Sprite
   {
      
      public var txt:TextField;
      
      public var cover:Sprite;
      
      public function LifeBar()
      {
         super();
         this.mouseChildren = false;
         this.mouseEnabled = false;
      }
      
      public function inData(now:Number, max:Number) : *
      {
         var now0:Number = now;
         if(now < 0)
         {
            now0 = 0;
         }
         else if(now > max)
         {
            now0 = max;
         }
         this.txt.text = String(Math.floor(now0) + "/" + Math.floor(max));
         this.cover.scaleX = now0 / max;
      }
   }
}

