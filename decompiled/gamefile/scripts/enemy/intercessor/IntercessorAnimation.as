package enemy.intercessor
{
   public class IntercessorAnimation
   {
      
      internal var BB:IntercessorBody;
      
      internal var mot:*;
      
      internal var img:*;
      
      public var state:String = "intercessor";
      
      public var enabled:Boolean = true;
      
      public var moveCtrlB:Boolean = true;
      
      public var flipCtrlB:Boolean = true;
      
      public function IntercessorAnimation(_mot:*, _img:*)
      {
         super();
         this.mot = _mot;
         this.img = _img;
      }
      
      public function intercessorCtrl() : *
      {
         if(Boolean(this.mot.toTargetB))
         {
            if(Boolean(this.mot.getJumpConditionB()))
            {
               this.mot.toJump();
            }
         }
         if(this.img.nowLabel != "__stand2")
         {
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
      }
      
      public function adjudicatorCtrl() : *
      {
         if(Boolean(this.mot.toTargetB))
         {
            if(Boolean(this.mot.getJumpConditionB()))
            {
               this.delayToJump();
            }
         }
         if(this.img.nowLabel != "__stand2")
         {
            if(Boolean(this.mot.getFloorB()) && this.mot.vy >= 0)
            {
               if(this.img.nowLabel != "__jump_up")
               {
                  if(this.mot.vx0 == 0)
                  {
                     this.img.toPlayLoop("stand2");
                  }
                  else
                  {
                     this.img.toPlayLoop("move2");
                  }
               }
            }
            else if(this.mot.vy > 0.1)
            {
               trace("img.toPlayLoop(jump_down)");
               this.img.toPlayLoop("jump_down");
            }
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
            if(!this.img.shootB)
            {
               if(this.moveCtrlB)
               {
                  if(this.state == "intercessor")
                  {
                     this.intercessorCtrl();
                  }
                  else if(this.state == "adjudicator")
                  {
                     this.adjudicatorCtrl();
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
}

