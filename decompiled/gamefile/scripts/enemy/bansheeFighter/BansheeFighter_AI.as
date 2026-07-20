package enemy.bansheeFighter
{
   import enemy.AI.Enemy_AI;
   
   public class BansheeFighter_AI extends Enemy_AI
   {
      
      public function BansheeFighter_AI(_baba:*)
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
            baba.armsDefine.inData("BansheeFighter_2",0);
            baba.define.rectLevel = 0;
            grapRect = baba.define.grapRect;
         }
         else
         {
            baba.armsDefine.inData("BansheeFighter_1",0);
            baba.define.rectLevel = 1;
            grapRect = baba.define.grapRect;
         }
         super.attackOver();
      }
   }
}

