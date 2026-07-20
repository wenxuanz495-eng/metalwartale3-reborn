package enemy.warden
{
   import enemy.AI.Enemy_AI;
   
   public class Warden_AI extends Enemy_AI
   {
      
      public var nowState:String = "stand";
      
      public function Warden_AI(_baba:*)
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
         }
      }
      
      override protected function attackOver() : *
      {
         var minY:int = 0;
         if(Math.random() < 0.3)
         {
            if(this.nowState == "stand")
            {
               baba.setState("fly");
            }
            else
            {
               minY = Game.BGHit.getMinY(baba.mot.x0);
               if(minY > baba.mot.y0 + 100)
               {
                  baba.setState("stand");
               }
            }
         }
         var index0:int = 0;
         if(this.nowState == "stand")
         {
            baba.img.goPlayLoop("stand");
         }
         else
         {
            index0 = 1 + Math.random() * 3;
         }
         baba.armsDefine.inData(armsName,index0);
         var arr0:Array = [0,1,2,2];
         baba.define.rectLevel = arr0[index0];
         baba.flesh_byDefine();
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

