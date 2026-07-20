package enemy.electricSaw
{
   public class ElectricSawAnimation
   {
      
      internal var img:*;
      
      internal var mot:*;
      
      public var enabled:Boolean = true;
      
      public var moveCtrlB:Boolean = true;
      
      public var flipCtrlB:Boolean = true;
      
      public function ElectricSawAnimation(_img:*, _mot:*)
      {
         super();
         this.img = _img;
         this.mot = _mot;
      }
      
      protected function ActionCtrl() : *
      {
         if(Boolean(this.mot.toTargetB))
         {
            if(Boolean(this.mot.getJumpConditionB()))
            {
               this.mot.toJump();
            }
         }
         if(Boolean(this.mot.getFloorB()))
         {
            if(Math.abs(this.mot.vx) > 0.1)
            {
               if(this.img.nowLabel == "stand")
               {
                  this.img.goPlayLoop("move");
               }
               else
               {
                  this.img.waitPlayLoop("move");
               }
            }
            else
            {
               this.img.waitPlayLoop("stand");
            }
         }
      }
      
      protected function flipCtrl() : *
      {
         if(this.mot.state == "left")
         {
            this.img.flipToRight();
         }
         else if(this.mot.state == "right")
         {
            this.img.flipToLeft();
         }
      }
      
      public function animationTimer() : *
      {
         if(this.enabled)
         {
            if(this.moveCtrlB)
            {
               this.ActionCtrl();
            }
            if(this.flipCtrlB)
            {
               this.flipCtrl();
            }
         }
      }
   }
}

