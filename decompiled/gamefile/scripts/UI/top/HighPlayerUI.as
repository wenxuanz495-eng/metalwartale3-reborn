package UI.top
{
   import UI.button.SountoScrollBar;
   import flash.display.Sprite;
   
   public class HighPlayerUI extends Sprite
   {
      
      public var sBar:SountoScrollBar;
      
      public var content:Sprite;
      
      public function HighPlayerUI()
      {
         super();
         this.sBar.setHigh(314);
         this.sBar.setTarget(this.content);
      }
   }
}

