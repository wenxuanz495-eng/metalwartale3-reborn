package enemy.havenFighter
{
   import enemy.AI.Enemy_AI;
   
   public class HavenFighter_AI extends Enemy_AI
   {
      
      public var attackWay:int = 0;
      
      public function HavenFighter_AI(_baba:*)
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
      
      override protected function attackOrder() : *
      {
         var ran:Number = Math.random();
         var bilv:Number = 0.5;
         if(ran <= bilv)
         {
            super.attackOrder();
            this.attackWay = 0;
         }
         else
         {
            this.attackWay = 1;
            baba.img.goOnce_ToLoop("shoot_1","fly");
         }
      }
      
      override protected function getAttackEndB() : Boolean
      {
         if(this.attackWay == 0)
         {
            return baba.attack.state == "over";
         }
         return baba.img.endFrameB;
      }
   }
}

