package enemy.knowing
{
   import enemy.AI.Enemy_AI;
   
   public class Knowing_AI extends Enemy_AI
   {
      
      public var attackWay:int = 0;
      
      public var nowAttackOrder:String = "shoot1";
      
      public function Knowing_AI(_baba:*)
      {
         super(_baba);
      }
      
      override protected function attackOrder() : *
      {
         var indstr:String = "Knowing";
         if(baba.define.id == "heianxianzhi")
         {
            indstr = "heianxianzhi";
         }
         if(this.nowAttackOrder == "shoot1")
         {
            this.attackWay = 1;
            baba.img.goOnce_ToLoop("shoot1","stand");
         }
         else if(this.nowAttackOrder == "shoot2")
         {
            this.attackWay = 0;
            baba.armsDefine.inData(indstr,1);
            baba.attack.startAttackOnce_break();
         }
         else if(this.nowAttackOrder == "shoot3")
         {
            this.attackWay = 0;
            baba.armsDefine.inData(indstr,0);
            baba.attack.startAttackOnce_break();
         }
      }
      
      override protected function attackOver() : *
      {
         var ran2:Number = Math.random();
         var bilv2:Number = 0.3;
         if(ran2 <= bilv2)
         {
            this.nowAttackOrder = "shoot1";
         }
         else if(ran2 <= bilv2 * 2)
         {
            this.nowAttackOrder = "shoot2";
         }
         else
         {
            this.nowAttackOrder = "shoot3";
         }
         if(this.nowAttackOrder == "shoot2")
         {
            baba.define.rectLevel = 1;
            baba.flesh_byDefine();
         }
         else
         {
            baba.define.rectLevel = 0;
            baba.flesh_byDefine();
         }
         super.attackOver();
      }
      
      override protected function getAttackEndB() : Boolean
      {
         if(this.attackWay == 0)
         {
            return baba.attack.state == "over";
         }
         return baba.img.endFrameB;
      }
      
      override protected function reachTarget() : *
      {
         followFilp();
         baba.mot.stopFollow();
      }
   }
}

