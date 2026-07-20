package enemy.atomicTower
{
   import enemy.AI.Enemy_AI;
   
   public class AtomicTower_AI extends Enemy_AI
   {
      
      public function AtomicTower_AI(_baba:*)
      {
         super(_baba);
         armsNum = 3;
      }
      
      override protected function attackOrder() : *
      {
         baba.attack.startAttackOnce_break();
      }
      
      override protected function attackOver() : *
      {
         var name0:String = baba.armsDefine.id;
         var ran:Number = Math.random();
         var num0:int = ran * armsNum;
         baba.armsDefine.inData(name0,num0);
         baba.img.goPlayLoop("stand");
         super.attackOver();
      }
   }
}

