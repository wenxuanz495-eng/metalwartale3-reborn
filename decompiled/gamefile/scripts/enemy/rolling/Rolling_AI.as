package enemy.rolling
{
   import enemy.AI.Enemy_AI;
   
   public class Rolling_AI extends Enemy_AI
   {
      
      public function Rolling_AI(_baba:*)
      {
         super(_baba);
      }
      
      override protected function attackOver() : *
      {
         var ran:Number = Math.random();
         var bilv:Number = 0.5;
         if(ran <= bilv)
         {
            baba.armsDefine.inData("Rolling_1",0);
         }
         else
         {
            baba.armsDefine.inData("Rolling_2",0);
         }
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

