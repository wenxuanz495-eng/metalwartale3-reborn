package enemy.spiderFort
{
   import enemy.charger.ChargerAnimation;
   
   public class SpiderFortAnimation extends ChargerAnimation
   {
      
      public function SpiderFortAnimation(_img:*, _mot:*)
      {
         super(_img,_mot);
      }
      
      override protected function ActionCtrl() : *
      {
         if(mot.toTargetB)
         {
            if(mot.getJumpConditionB())
            {
               delayToJump();
            }
         }
         if(mot.getFloorB() && mot.vy >= 0)
         {
            if(img.nowLabel != "__" + airState + "_up")
            {
               if(mot.vx0 == 0)
               {
                  img.toPlayLoop("stand");
               }
               else
               {
                  img.toPlayLoop("move");
               }
            }
         }
         else if(mot.vy > 0.1)
         {
            img.toPlayLoop(airState + "_down");
         }
      }
      
      override public function animationTimer() : *
      {
         if(enabled)
         {
            if(moveCtrlB)
            {
               if(!img.shootB)
               {
                  this.ActionCtrl();
               }
            }
            if(flipCtrlB)
            {
               flipCtrl();
            }
         }
      }
   }
}

