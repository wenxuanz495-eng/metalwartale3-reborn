package UI.research
{
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class ChipAffixBar extends Sprite
   {
      
      public var affixName:String = "";
      
      public var affixValue:Number = 0;
      
      public var lockB:Boolean = false;
      
      public var txt:TextField;
      
      public var lock_btn:SimpleButton;
      
      public var unlock_btn:SimpleButton;
      
      public var tip_mc:Sprite;
      
      public function ChipAffixBar()
      {
         super();
         this.unlock();
         this.tip_mc.visible = false;
      }
      
      public function mouseOver(e:*) : *
      {
         this.tip_mc.visible = true;
      }
      
      public function mouseOut(e:*) : *
      {
         this.tip_mc.visible = false;
      }
      
      public function lock() : *
      {
         this.lockB = true;
         this.txt.textColor = 10066329;
         this.lock_btn.visible = false;
         this.unlock_btn.visible = true;
      }
      
      public function unlock() : *
      {
         this.lockB = false;
         this.txt.textColor = 65280;
         this.lock_btn.visible = true;
         this.unlock_btn.visible = false;
      }
   }
}

