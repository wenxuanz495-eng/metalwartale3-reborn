package enemy.ostrich
{
   import enemy.AI.Enemy_AI;
   
   public class Ostrich_AI extends Enemy_AI
   {
      
      public function Ostrich_AI(_baba:*)
      {
         super(_baba);
      }
      
      override protected function reachTarget() : *
      {
         followFilp();
         baba.mot.stopFollow();
      }
      
      override protected function attackOver() : *
      {
         baba.img.goPlayLoop("stand");
         super.attackOver();
      }
   }
}

