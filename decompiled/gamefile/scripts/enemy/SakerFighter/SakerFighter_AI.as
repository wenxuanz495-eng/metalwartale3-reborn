package enemy.SakerFighter
{
   import enemy.AI.Enemy_AI;
   
   public class SakerFighter_AI extends Enemy_AI
   {
      
      public function SakerFighter_AI(_baba:*)
      {
         super(_baba);
      }
      
      override protected function followToPoint(x0:Number, y0:Number) : *
      {
         baba.mot.followPoint(x0,y0);
         if(follow_t % 4 == 0)
         {
            followFilp();
         }
      }
      
      override protected function attackOver() : *
      {
         var ran:Number = Math.random();
         var bilv:Number = 0.5;
         if(ran >= bilv)
         {
            baba.armsDefine.inData("SakerFighter",0);
            baba.define.rectLevel = 0;
            baba.flesh_byDefine();
         }
         else
         {
            baba.armsDefine.inData("SakerFighter",1);
            baba.define.rectLevel = 1;
            baba.flesh_byDefine();
         }
         super.attackOver();
      }
   }
}

