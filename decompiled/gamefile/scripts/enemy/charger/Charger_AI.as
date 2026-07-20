package enemy.charger
{
   import enemy.AI.Enemy_AI;
   
   public class Charger_AI extends Enemy_AI
   {
      
      public var nowAttackOrder:String = "shoot";
      
      public function Charger_AI(_baba:*)
      {
         super(_baba);
         bilvArr = [1,1,1];
      }
      
      override protected function attackOver() : *
      {
         this.nowAttackOrder = "shoot";
         var ran:Number = Math.random();
         var bilv:Number = 0.5;
         if(ran <= getBilv(0))
         {
            baba.armsDefine.inData("Charger_1",0);
         }
         else if(ran <= getBilv(1))
         {
            baba.armsDefine.inData("Charger_2",0);
         }
         else
         {
            baba.armsDefine.inData("Charger_3",0);
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

