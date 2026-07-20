package enemy.gear
{
   import enemy.AI.Enemy_AI;
   
   public class Gear_AI extends Enemy_AI
   {
      
      public function Gear_AI(_baba:*)
      {
         super(_baba);
      }
      
      override protected function followToPoint(x0:Number, y0:Number) : *
      {
         attackX = targetBody.img.x;
         if(Math.abs(baba.mot.x0 - attackX) < 105)
         {
            baba.mot.stopFollow();
         }
         else
         {
            baba.mot.followPoint(x0,y0);
         }
         if(follow_t % 4 == 0)
         {
            followFilp();
         }
         var mot:* = baba.mot;
         if(Boolean(mot.toTargetB))
         {
            if(Boolean(mot.getJumpConditionB()))
            {
               mot.toJump();
            }
         }
      }
      
      override protected function attackOrder() : *
      {
      }
      
      override protected function getAttackEndB() : Boolean
      {
         return baba.img.endFrameB;
      }
      
      override protected function reachTarget() : *
      {
         followFilp();
         baba.mot.stopFollow();
      }
   }
}

