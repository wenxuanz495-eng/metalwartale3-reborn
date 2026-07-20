package enemy.landFort
{
   import enemy.AI.Enemy_AI;
   
   public class LandFort_AI extends Enemy_AI
   {
      
      public function LandFort_AI(_baba:*)
      {
         super(_baba);
      }
      
      private function shootPan() : *
      {
         if(state == "attackDelaying")
         {
            if(baba.img.nowLabel == "fly")
            {
               baba.img.goOnce_ToLoop("fly__","stand");
               baba.hitHurtB = 0;
            }
         }
      }
      
      override protected function attackOrder() : *
      {
         baba.attack.startAttackOnce_break();
      }
      
      override protected function attackOver() : *
      {
         baba.img.goPlayLoop("stand");
         super.attackOver();
      }
      
      override protected function followToPoint(x0:Number, y0:Number) : *
      {
      }
      
      override protected function reachTarget() : *
      {
         followFilp();
         baba.mot.stopFollow();
      }
      
      override public function aiTimer() : *
      {
         if(enabled)
         {
            this.shootPan();
            attackAI();
            super.FTimer();
         }
      }
   }
}

