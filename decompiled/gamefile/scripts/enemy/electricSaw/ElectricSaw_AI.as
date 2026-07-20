package enemy.electricSaw
{
   import enemy.AI.Enemy_AI;
   
   public class ElectricSaw_AI extends Enemy_AI
   {
      
      public function ElectricSaw_AI(_baba:ElectricSawBody)
      {
         super(_baba);
      }
      
      override protected function reachTarget() : *
      {
         if(baba.mot.x0 < attackX)
         {
            baba.img.flipToLeft();
         }
         else
         {
            baba.img.flipToRight();
         }
         baba.mot.stopFollow();
      }
      
      override protected function attackOrder() : *
      {
         baba.AAHD.imgAttackOnce();
      }
      
      override protected function followToPoint(x0:Number, y0:Number) : *
      {
         baba.mot.followPoint(x0,y0);
      }
      
      override protected function getAttackEndB() : Boolean
      {
         return baba.img.endFrameB;
      }
   }
}

