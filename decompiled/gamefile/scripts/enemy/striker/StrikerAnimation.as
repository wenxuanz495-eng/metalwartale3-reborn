package enemy.striker
{
   import body.image.MultipleImage;
   import body.motion.GroundMotion;
   
   public class StrikerAnimation
   {
      
      internal var img:MultipleImage;
      
      internal var mot:GroundMotion;
      
      public var enabled:Boolean = true;
      
      public var moveCtrlB:Boolean = true;
      
      public var flipCtrlB:Boolean = true;
      
      public var airState:String = "jump";
      
      public function StrikerAnimation(_img:MultipleImage, _mot:GroundMotion)
      {
         super();
         this.img = _img;
         this.mot = _mot;
      }
      
      protected function ActionCtrl() : *
      {
         if(this.mot.toTargetB)
         {
            if(this.mot.getJumpConditionB())
            {
               this.delayToJump();
            }
         }
         if(this.mot.getFloorB())
         {
            if(this.img.nowLabel != "__" + this.airState + "_up")
            {
               if(this.mot.vx0 == 0)
               {
                  this.img.toPlayLoop("stand");
               }
               else if(Math.abs(this.mot.vx0) > 210 / 30)
               {
                  this.img.toPlayLoop("move2");
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
               if(this.img.shootB)
               {
                  this.mot.toStop();
               }
               else
               {
                  this.ActionCtrl();
               }
            }
            if(this.flipCtrlB)
            {
               this.flipCtrl();
            }
         }
      }
   }
}

