package enemy._normal
{
   import enemy.AI.Enemy_AI;
   
   public class Normal_Fly_AI extends Enemy_AI
   {
      
      public function Normal_Fly_AI(_baba:*)
      {
         super(_baba);
      }
      
      override protected function followToPoint(x0:Number, y0:Number) : *
      {
         baba.mot.followPoint(x0,y0);
         if(follow_t % 2 == 0)
         {
            followFilp();
         }
      }
      
      override protected function attackOver() : *
      {
         chooseAttack();
         super.attackOver();
      }
   }
}

