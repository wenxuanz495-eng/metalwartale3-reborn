package enemy.spider
{
   import enemy.AI.Enemy_AI;
   
   public class Spider_AI extends Enemy_AI
   {
      
      private var increaseTime:int = 30;
      
      private var increase_t:int = 0;
      
      public function Spider_AI(_baba:SpiderBody)
      {
         super(_baba);
      }
      
      override protected function reachTarget() : *
      {
      }
      
      override protected function attackOrder() : *
      {
         baba.mot.delayToJump();
      }
      
      override protected function followToPoint(x0:Number, y0:Number) : *
      {
         baba.mot.followPoint(x0,y0);
      }
      
      override protected function getAttackEndB() : Boolean
      {
         return true;
      }
      
      private function increaseSpeed() : *
      {
         if(this.increase_t >= this.increaseTime)
         {
            this.increase_t = 0;
            baba.mot.vxmax += 200 / 30;
         }
         else
         {
            ++this.increase_t;
         }
      }
      
      override public function aiTimer() : *
      {
         if(enabled)
         {
            this.increaseSpeed();
            super.aiTimer();
         }
      }
   }
}

