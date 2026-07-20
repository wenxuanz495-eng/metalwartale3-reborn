package UI.gaming
{
   import body.hurt.HurtCount;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class EnemyLifeBar extends Sprite
   {
      
      public var BB:*;
      
      public var cx:int = 0;
      
      public var cy:int = 0;
      
      public var mc:Sprite;
      
      public var txt:TextField;
      
      public var type_mc:MovieClip;
      
      public function EnemyLifeBar()
      {
         super();
      }
      
      public function setText(num0:int) : *
      {
         this.txt.text = num0 + "";
      }
      
      public function setDefenceType(str0:String) : *
      {
         this.type_mc.gotoAndStop(HurtCount.getDefenceLabel(str0));
      }
      
      public function setBaifen(num0:Number) : *
      {
         if(num0 < 0)
         {
            num0 = 0;
         }
         if(num0 > 1)
         {
            num0 = 1;
         }
         this.mc.scaleX = num0;
      }
      
      public function bodyTimer() : *
      {
         x = this.BB.img.x + this.cx - width / 2;
         y = this.BB.img.y + this.cy - 15;
         var d0:* = this.BB.define;
         if(this.BB.die == 0)
         {
            this.setBaifen(d0.getLifePer());
         }
         else
         {
            this.setBaifen(0);
         }
         if(this.txt.text != d0.level + 1 + "")
         {
            this.txt.text = d0.level + 1 + "";
         }
         this.setDefenceType(d0.defenceType);
      }
   }
}

