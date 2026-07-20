package enemy.airLaserFort
{
   import enemy.AI.Enemy_AI;
   import hit.HitIO;
   
   public class AirLaserFort_AI extends Enemy_AI
   {
      
      public var attackType:String = "";
      
      public function AirLaserFort_AI(_baba:AirLaserFortBody)
      {
         super(_baba);
      }
      
      override protected function attackOrder() : *
      {
         if(this.attackType == "selfBoom")
         {
            this.setToSelfBoom();
         }
         else
         {
            super.attackOrder();
         }
      }
      
      public function setToSelfBoom() : *
      {
         baba.define.tweenValue = 0;
         baba.flesh_byDefine();
         baba.mot.vymax *= 2;
         baba.mot.vxmax *= 2;
      }
      
      override protected function getAttackEndB() : Boolean
      {
         var bb:Boolean = false;
         var b0:* = undefined;
         if(this.attackType == "selfBoom")
         {
            if(targetBody != null)
            {
               if(targetBody.die == 0)
               {
                  followToPoint(targetBody.MX,targetBody.MY);
                  bb = HitIO.hitRectArrPoint(targetBody.AAHD.hurtRectArr,baba.MX,baba.MY);
                  if(bb)
                  {
                     b0 = targetBody;
                     Game.eventGroup.hurt(b0,baba.define.hurt_0,"mixed",null,baba,b0.MX,b0.MY,true,false,"bullet",null,0.1);
                     baba.toDie();
                  }
               }
               else
               {
                  baba.toDie();
               }
            }
            return false;
         }
         return super.getAttackEndB();
      }
   }
}

