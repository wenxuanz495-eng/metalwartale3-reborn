package enemy.drilling
{
   import enemy.AI.Enemy_AI;
   
   public class Drilling_AI extends Enemy_AI
   {
      
      public function Drilling_AI(_baba:*)
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
         baba.img.goOnce_ToLoop("shoot","fly");
      }
      
      override protected function getAttackEndB() : Boolean
      {
         return baba.img.endFrameB;
      }
   }
}

