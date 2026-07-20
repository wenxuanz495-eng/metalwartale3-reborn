package enemy.landFort
{
   import enemy.AI.Enemy_AI;
   import scene.OneSence;
   
   public class LandFort_AI2 extends Enemy_AI
   {
      
      public function LandFort_AI2(_baba:*)
      {
         super(_baba);
      }
      
      private function shootPan() : *
      {
         var os:OneSence = Game.oneScene;
         if(os.lockB && baba.die == 0)
         {
            if(os.viewRangeRect2.contains(baba.img.x,baba.img.y))
            {
               baba.hitHurtB = 0;
            }
            else
            {
               baba.hitHurtB = 1;
            }
         }
         else
         {
            baba.hitHurtB = 1;
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

