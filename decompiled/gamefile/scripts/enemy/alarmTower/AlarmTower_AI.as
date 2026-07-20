package enemy.alarmTower
{
   import enemy.AI.Enemy_AI;
   
   public class AlarmTower_AI extends Enemy_AI
   {
      
      public function AlarmTower_AI(_baba:*)
      {
         super(_baba);
      }
      
      override public function attackBody(b0:*) : *
      {
         super.attackBody(b0);
         baba.hitHurtB = 0;
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
   }
}

