package enemy.tank
{
   public class TankAnimation
   {
      
      internal var img:*;
      
      internal var mot:*;
      
      public var enabled:Boolean = true;
      
      public var moveCtrlB:Boolean = true;
      
      public var flipCtrlB:Boolean = true;
      
      public function TankAnimation(_img:*, _mot:*)
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
            if(!this.img.rightB)
            {
               this.img.flipToRight();
               this.img.goOnce_ToLoop("flip","stand");
            }
         }
         else if(this.mot.state == "right")
         {
            if(Boolean(this.img.rightB))
            {
               this.img.flipToLeft();
               this.img.goOnce_ToLoop("flip","stand");
            }
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

