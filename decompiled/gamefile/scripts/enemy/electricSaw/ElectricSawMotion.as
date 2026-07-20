package enemy.electricSaw
{
   import body.motion.GroundMotion;
   
   public class ElectricSawMotion extends GroundMotion
   {
      
      public function ElectricSawMotion()
      {
         super();
      }
      
      override public function toTargetTimer() : *
      {
         var cx:Number = NaN;
         var cy:Number = NaN;
         if(toTargetB)
         {
            cx = mx - x0;
            cy = my - y0;
            if(Math.abs(cx) < 5)
            {
               toTargetB = false;
               toStop();
            }
            else
            {
               if(cx > 0)
               {
                  moveToRight();
               }
               else if(cx < 0)
               {
                  moveToLeft();
               }
               if(getJumpConditionB())
               {
                  toJump();
               }
            }
         }
      }
   }
}

