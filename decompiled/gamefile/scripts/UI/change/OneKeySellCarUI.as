package UI.change
{
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class OneKeySellCarUI extends Sprite
   {
      
      public var _btn:SimpleButton;
      
      public var prev2_btn:SimpleButton;
      
      public var next2_btn:SimpleButton;
      
      public var num2_txt:TextField;
      
      public var blue_btn:SimpleButton;
      
      public var white_btn:SimpleButton;
      
      public var yellow_btn:SimpleButton;
      
      public var levelArr:Array = [10,20,30,40,50,60,70,80,-10];
      
      public var levelNameArr:Array = ["1级~10级","1级~20级","1级~30级","1级~40级","1级~50级","1级~60级","1级~70级","1级~80级","所有"];
      
      public var colorIndex:int = 0;
      
      public var levelIndex:int = 0;
      
      public function OneKeySellCarUI()
      {
         super();
         this.fleshData();
      }
      
      private function fleshData() : *
      {
      }
      
      public function click(e:*) : *
      {
         var mc0:* = e.target;
         if(mc0 == this.prev2_btn)
         {
            this.levelIndex = (this.levelIndex - 1 + this.levelArr.length) % this.levelArr.length;
         }
         else if(mc0 == this.next2_btn)
         {
            this.levelIndex = (this.levelIndex + 1 + this.levelArr.length) % this.levelArr.length;
         }
         this.fleshData();
      }
   }
}

