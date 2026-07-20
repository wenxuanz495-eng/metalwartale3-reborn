package enemy.satellite
{
   import enemy.AI.Enemy_AI;
   
   public class SmallSatellite_AI extends Enemy_AI
   {
      
      public var now_t:Number = 0;
      
      public function SmallSatellite_AI(_baba:*)
      {
         super(_baba);
      }
      
      override public function aiTimer() : *
      {
         if(enabled)
         {
            super.aiTimer();
            this.timer00();
         }
      }
      
      public function timer00() : *
      {
         var hero0:* = undefined;
         this.now_t += 1 / 30;
         if(this.now_t >= 4)
         {
            hero0 = Game.BG.hero;
            if(hero0.die == 0)
            {
               followToPoint(hero0.MX,hero0.MY);
            }
         }
      }
   }
}

