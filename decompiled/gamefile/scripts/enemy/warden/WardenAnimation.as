package enemy.warden
{
   public class WardenAnimation
   {
      
      internal var BB:*;
      
      public var state:String = "fly";
      
      public var enabled:Boolean = true;
      
      public var moveCtrlB:Boolean = true;
      
      public var flipCtrlB:Boolean = true;
      
      public function WardenAnimation(_BB:*)
      {
         super();
         this.BB = _BB;
      }
      
      public function flyCtrl() : *
      {
         var mot:* = this.BB.mot;
         var img:* = this.BB.img;
         img.toPlayLoop("fly");
      }
      
      public function landCtrl() : *
      {
         var mot:* = this.BB.mot;
         var img:* = this.BB.img;
         if(Boolean(mot.getFloorB()))
         {
            if(img.nowLabel.indexOf("__") < 0)
            {
               if(Math.abs(mot.vx) > 0.1 && img.getIndex_byLabel("move") >= 0)
               {
                  img.toPlayLoop("move");
               }
               else
               {
                  img.toPlayLoop("stand");
               }
            }
         }
         this.flipCtrl();
      }
      
      protected function flipCtrl() : *
      {
         var mot:* = this.BB.mot;
         var img:* = this.BB.img;
         if(mot.state == "left")
         {
            img.flipToRight();
         }
         else if(mot.state == "right")
         {
            img.flipToLeft();
         }
      }
      
      public function animationTimer() : *
      {
         if(this.enabled)
         {
            if(!this.BB.img.shootB)
            {
               if(this.moveCtrlB)
               {
                  if(this.state == "fly")
                  {
                     this.flyCtrl();
                  }
                  else if(this.state == "stand")
                  {
                     this.landCtrl();
                  }
               }
            }
            else if(this.state == "stand")
            {
               this.BB.mot.toStop();
            }
         }
      }
   }
}

