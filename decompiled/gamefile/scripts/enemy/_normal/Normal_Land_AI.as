package enemy._normal
{
   import enemy.AI.Enemy_AI;
   
   public class Normal_Land_AI extends Enemy_AI
   {
      
      public function Normal_Land_AI(_baba:*)
      {
         super(_baba);
      }
      
      override protected function attackOver() : *
      {
         chooseAttack();
         baba.img.goPlayLoop("stand");
         super.attackOver();
      }
      
      override protected function reachTarget() : *
      {
         followFilp();
         baba.mot.stopFollow();
      }
   }
}

