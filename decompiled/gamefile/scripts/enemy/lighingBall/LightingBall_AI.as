package enemy.lighingBall
{
   import enemy.AI.Enemy_AI;
   import flash.geom.Point;
   
   public class LightingBall_AI extends Enemy_AI
   {
      
      public var num0:int = 0;
      
      public var tt:Number = 0;
      
      public var ballType:String = "LightingBall";
      
      public function LightingBall_AI(_baba:*)
      {
         super(_baba);
      }
      
      override public function attackBody(body0:*) : *
      {
         targetBody = body0;
         if(this.ballType == "SevenBall")
         {
            super.attackBody(body0);
         }
      }
      
      override public function attackAI() : *
      {
         var minY:int = 0;
         if(this.ballType == "LightingBall")
         {
            baba.mot.vy = 5;
            baba.mot.vx = 0;
            if(this.num0 == 0)
            {
               minY = Game.BGHit.getMinY(baba.img.x);
               if(baba.img.y > minY)
               {
                  baba.mot.stopFollow();
                  this.num0 = 1;
                  this.lightingTo();
               }
            }
            else if(this.num0 >= 10)
            {
               baba.toDie();
            }
            else
            {
               this.tt += 1 / 30;
               if(this.tt > 0.3)
               {
                  this.tt = 0;
                  ++this.num0;
                  this.lightingTo();
               }
            }
         }
         else if(this.ballType == "SevenBall")
         {
            super.attackAI();
         }
      }
      
      override protected function attackOrder() : *
      {
         var xx0:* = undefined;
         var yy0:* = undefined;
         var xx1:* = undefined;
         var yy1:* = undefined;
         if(this.ballType == "SevenBall")
         {
            xx0 = targetBody.MX;
            yy0 = targetBody.MY;
            xx1 = baba.MX;
            yy1 = baba.MY;
            Game.EG.addEffect("sub","boom_hit_effect2",Game.gameSprite.effectL,(xx0 + xx1) / 2,(yy0 + yy1) / 2);
            Game.eventGroup.hurt(targetBody,9999999999,"mixed",null,baba,0,0,false);
            baba.toDie();
         }
      }
      
      override protected function getAttackEndB() : Boolean
      {
         return false;
      }
      
      public function lightingTo() : *
      {
         var b0:* = Game.BG.hero;
         if(b0.die == 0)
         {
            Game.eventGroup.hurt(b0,baba.define.hurt_0,"mixed",null,baba,b0.MX,b0.MY,true,false,"bullet",null,0.2);
            Game.EG.lightning.Show(new Point(baba.img.x,baba.img.y),new Point(b0.MX,b0.MY),Math.random() * 10,0.1);
            Game.SG.playSound("lightningBall_lightning");
         }
      }
   }
}

