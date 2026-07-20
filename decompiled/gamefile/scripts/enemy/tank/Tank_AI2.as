package enemy.tank
{
   import enemy.AI.Enemy_AI;
   
   public class Tank_AI2 extends Enemy_AI
   {
      
      public function Tank_AI2(_baba:*)
      {
         super(_baba);
      }
      
      override protected function attackOver() : *
      {
         var ran:Number = Math.random();
         var bilv:Number = 0.5;
         if(ran <= bilv)
         {
            baba.armsDefine.inData("Tank2",0);
         }
         else if(ran <= bilv * 2)
         {
            baba.armsDefine.inData("Tank2",1);
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

