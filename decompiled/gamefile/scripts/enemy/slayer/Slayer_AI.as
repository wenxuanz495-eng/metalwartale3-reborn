package enemy.slayer
{
   import enemy.AI.Enemy_AI;
   
   public class Slayer_AI extends Enemy_AI
   {
      
      public var nowAttackOrder:String = "shoot";
      
      public function Slayer_AI(_baba:*)
      {
         super(_baba);
         bilvArr = [1,1,1];
      }
      
      override protected function attackOver() : *
      {
         var ran:Number = Math.random();
         if(ran <= getBilv(0))
         {
            baba.armsDefine.inData("Charger_1",0);
         }
         else if(ran <= getBilv(1))
         {
            baba.armsDefine.inData("Charger_2",1);
         }
         else
         {
            baba.armsDefine.inData("Slayer_1",0);
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

