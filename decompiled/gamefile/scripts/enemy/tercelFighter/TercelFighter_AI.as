package enemy.tercelFighter
{
   import enemy.AI.Enemy_AI;
   
   public class TercelFighter_AI extends Enemy_AI
   {
      
      public function TercelFighter_AI(_baba:*)
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
            baba.armsDefine.inData("TercelFighter",0);
         }
         else
         {
            baba.armsDefine.inData("TercelFighter_2",0);
         }
         super.attackOver();
      }
   }
}

