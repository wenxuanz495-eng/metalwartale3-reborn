package body.animation
{
   public class JumpAnimation
   {
      
      internal var img:*;
      
      internal var mot:*;
      
      public var enabled:Boolean = true;
      
      public var moveCtrlB:Boolean = true;
      
      public var flipCtrlB:Boolean = true;
      
      public var airState:String = "jump";
      
      public function JumpAnimation(_img:*, _mot:*)
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
               this.delayToJump();
            }
         }
         if(Boolean(this.mot.getFloorB()))
         {
            if(this.img.nowLabel != "__" + this.airState + "_up")
            {
               if(this.mot.vx0 == 0)
               {
                  this.img.toPlayLoop("stand");
               }
               else
               {
                  this.img.toPlayLoop("move");
               }
            }
         }
         else if(this.mot.vy > 0.1)
         {
            this.img.toPlayLoop(this.airState + "_down");
         }
      }
      
      public function delayToJump() : *
      {
         if(this.mot.jumpNow < this.mot.jumpNum)
         {
            this.img.goOnce_ToLoop("__jump_up","jump_up");
            this.mot.delayToJump();
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

