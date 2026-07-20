package enemy._normal
{
   import body.motion.GroundMotion;
   import enemy.AI.Enemy_AI;
   
   public class Normal_Change_AI extends Enemy_AI
   {
      
      public var nowState:String = "stand";
      
      public var standAttackIndex:Array = [0];
      
      public var flyAttackIndex:Array = [0];
      
      public var changeToFlyPro:Number = 0.3;
      
      public var changeToStandPro:Number = 0.3;
      
      public function Normal_Change_AI(_baba:*)
      {
         super(_baba);
      }
      
      override protected function followToPoint(x0:Number, y0:Number) : *
      {
         if(this.nowState == "fly")
         {
            baba.mot.followPoint(x0,y0);
            if(follow_t % 2 == 0)
            {
               followFilp();
            }
         }
         else
         {
            super.followToPoint(x0,y0);
            if(baba.mot is GroundMotion)
            {
               if(Boolean(baba.mot.getJumpConditionB()))
               {
                  baba.changeState("fly");
               }
            }
         }
      }
      
      public function changeState(s0:String) : *
      {
         var img:* = baba.img;
         this.nowState = s0;
         if(this.nowState == "stand")
         {
            if(Boolean(img.getIndex_byLabel("stand__fly")))
            {
               img.goOnce_ToLoop("stand__fly","fly");
            }
         }
         else if(Boolean(img.getIndex_byLabel("fly__stand")))
         {
            img.goOnce_ToLoop("fly__stand","stand");
         }
      }
      
      override protected function attackOver() : *
      {
         var minY:int = 0;
         if(this.nowState == "fly")
         {
            if(Math.random() < this.changeToStandPro)
            {
               minY = Game.BGHit.getMinY(baba.mot.x0);
               if(minY > baba.mot.y0 + 100)
               {
                  baba.setState("stand");
               }
            }
         }
         else if(Math.random() < this.changeToFlyPro)
         {
            baba.setState("fly");
         }
         var index0:int = chooseAttack(this[this.nowState + "AttackIndex"]);
         super.attackOver();
      }
      
      override protected function reachTarget() : *
      {
         if(this.nowState == "stand")
         {
            followFilp();
            baba.mot.stopFollow();
         }
         else
         {
            super.followFilp();
         }
      }
   }
}

