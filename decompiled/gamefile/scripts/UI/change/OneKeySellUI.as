package UI.change
{
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class OneKeySellUI extends Sprite
   {
      
      public var _btn:SimpleButton;
      
      public var prev_btn:SimpleButton;
      
      public var next_btn:SimpleButton;
      
      public var num_txt:TextField;
      
      public var prev2_btn:SimpleButton;
      
      public var next2_btn:SimpleButton;
      
      public var num2_txt:TextField;
      
      public var yellow_btn:SimpleButton;
      
      public var white_btn:SimpleButton;
      
      public var orange_btn:SimpleButton;
      
      public var colorArr:Array = ["white_chip","blue_chip","yellow_chip","orange_chip","green_chip"];
      
      public var colorNameArr:Array = ["白色芯片","<font color=\'#00FFFF\'>蓝色芯片</font>","<font color=\'#FFFF00\'>金色芯片</font>","<font color=\'#FF6600\'>橙色芯片</font>","<font color=\'#00FF00\'>绿色芯片</font>"];
      
      public var levelArr:Array = [10,20,30,40,50,60,70,80,90,100,110,120,130,140,150,-10];
      
      public var levelNameArr:Array = ["1级~10级","1级~20级","1级~30级","1级~40级","1级~50级","1级~60级","1级~70级","1级~80级","1级~90级","1级~100级","所有"];
      
      public var colorIndex:int = 0;
      
      public var levelIndex:int = 0;
      
      public function OneKeySellUI()
      {
         super();
         this.prev_btn.addEventListener(MouseEvent.CLICK,this.click);
         this.next_btn.addEventListener(MouseEvent.CLICK,this.click);
         this.prev2_btn.addEventListener(MouseEvent.CLICK,this.click);
         this.next2_btn.addEventListener(MouseEvent.CLICK,this.click);
         this.fleshData();
      }
      
      private function fleshData() : *
      {
         this.num_txt.htmlText = this.colorNameArr[this.colorIndex];
         this.num2_txt.text = this.levelNameArr[this.levelIndex];
      }
      
      public function click(e:*) : *
      {
         var mc0:* = e.target;
         if(mc0 == this.prev_btn)
         {
            this.colorIndex = (this.colorIndex - 1 + this.colorArr.length) % this.colorArr.length;
         }
         else if(mc0 == this.next_btn)
         {
            this.colorIndex = (this.colorIndex + 1 + this.colorArr.length) % this.colorArr.length;
         }
         else if(mc0 == this.prev2_btn)
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

