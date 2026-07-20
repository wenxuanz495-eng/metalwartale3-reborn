package enemy.cutter
{
   import enemy.AI.Enemy_AI;
   
   public class Cutter_AI extends Enemy_AI
   {
      
      public function Cutter_AI(_baba:*)
      {
         super(_baba);
      }
      
      override protected function followToPoint(x0:Number, y0:Number) : *
      {
         baba.mot.followPoint(x0,y0);
         if(follow_t % 4 == 0)
         {
            followFilp();
         }
      }
      
      override protected function attackOrder() : *
      {
      }
      
      override protected function getAttackEndB() : Boolean
      {
         if(Boolean(baba.img.endFrameB))
         {
         }
         return baba.img.endFrameB;
      }
      
      override protected function reachTarget() : *
      {
         followFilp();
         baba.mot.stopFollow();
      }
   }
}

