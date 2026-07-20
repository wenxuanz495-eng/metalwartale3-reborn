package enemy.loadKing
{
   import body.attack.ArmsAttack;
   import body.define.OneArmsDefine;
   import effect.BezierLightning;
   import enemy.AI.Enemy_AI;
   import flash.geom.Point;
   
   public class LoadKing2_AI extends Enemy_AI
   {
      
      private var lifeArr:Array = [90000000,135000000,180000000,270000000,300000000];
      
      private var diffHurtArr:Array = [1,1.5,2,3];
      
      private var fistHurt:Number = 100000;
      
      public var nowAttackOrder:String = "shoot_2";
      
      public var energyValue:int = 0;
      
      public var energy_t:Number = 0;
      
      public var lighting_t:Number = 0;
      
      public var stop_t:Number = 0;
      
      public function LoadKing2_AI(_baba:*)
      {
         super(_baba);
      }
      
      public function addMe() : *
      {
         baba.define.maxLife = int(this.lifeArr[Game.gameData.nowDifficult] + 0.9);
         baba.define.mulLife();
      }
      
      override protected function attackOrder() : *
      {
         if(this.nowAttackOrder == "shoot_1")
         {
            baba.armsDefine.inData("LoadKing2",0);
            baba.attack.startAttackOnce_break();
         }
         else if(this.nowAttackOrder == "shoot_2")
         {
            baba.img.goOnce_ToLoop("shoot_2","stand");
            baba.img.setHurt_byLabel("shoot_2",this.getDiff() * this.fistHurt / baba.define.hurt_0);
         }
         ++this.energyValue;
         Game.BG.hero.plasmaEnabled = false;
      }
      
      public function getDiff() : Number
      {
         var index:int = Game.gameData.nowDifficult;
         if(index > this.diffHurtArr.length - 1)
         {
            index = this.diffHurtArr.length - 1;
         }
         return this.diffHurtArr[index];
      }
      
      override protected function attackOver() : *
      {
         this.nowAttackOrder = "shoot_2";
         baba.define.rectLevel = 0;
         baba.flesh_byDefine();
         baba.img.goPlayLoop("stand");
         super.attackOver();
      }
      
      override protected function getAttackEndB() : Boolean
      {
         if(this.nowAttackOrder == "shoot_2")
         {
            return baba.img.endFrameB;
         }
         return baba.attack.state == "over";
      }
      
      override protected function reachTarget() : *
      {
         followFilp();
         baba.mot.stopFollow();
      }
      
      override public function attackAI() : *
      {
         super.attackAI();
         var label0:String = baba.img.nowLabel;
         var frame0:int = int(baba.img.nowMC.currentFrame);
         if(label0 == "shoot_2")
         {
            if(frame0 == 11)
            {
               Game.oneScene.shake.startShake(3,0.2,90,-32,32,0,"cos");
            }
         }
         else if(label0 == "move")
         {
            if(frame0 == 19 || frame0 == 36)
            {
               Game.oneScene.shake.startShake(3,0.2,90,-8,8,0,"random");
            }
         }
         else if(label0 == "die")
         {
            if(frame0 == 19)
            {
               Game.oneScene.shake.startShake(3,0.2,90,-16,16,0,"cos");
            }
         }
         if(this.energyValue >= 100)
         {
            if(this.energy_t > 1)
            {
               this.energy_t = 0;
               ++this.energyValue;
               this.lightingTo(500000,1);
               trace("雷电蓄能闪电");
            }
            else
            {
               this.energy_t += 1 / 30;
            }
         }
         if(this.lighting_t > 10)
         {
            this.shootLighting();
            trace("雷电降临");
            this.energyValue += 5;
            this.lighting_t = 0;
         }
         else
         {
            this.lighting_t += 1 / 30;
         }
         if(this.stop_t > 6)
         {
            this.stop_t = 0;
            trace("闪电麻痹");
            this.shootStop();
            ++this.energyValue;
         }
         else
         {
            this.stop_t += 1 / 30;
         }
      }
      
      private function lightingTo(hurt0:Number, index0:int = 0) : *
      {
         var ef0:BezierLightning = null;
         if(Boolean(targetBody))
         {
            if(targetBody.die == 0)
            {
               hurt0 *= this.getDiff();
               Game.eventGroup.hurt(targetBody,hurt0,"boom",null,baba,baba.MX,baba.MY,false);
               ef0 = Game.EG.lightning;
               if(index0 == 1)
               {
                  ef0 = Game.EG.lightning2;
               }
               else if(index0 == 2)
               {
                  ef0 = Game.EG.lightning3;
               }
               ef0.Show(new Point(baba.MX,baba.MY),new Point(targetBody.MX,targetBody.MY),Math.random() * 10);
               Game.SG.playSound("lightningBall_lightning");
            }
         }
      }
      
      private function shootLighting() : *
      {
         var x0:int = 0;
         var y0:int = 0;
         var d0:OneArmsDefine = null;
         var i:int = 0;
         var x1:int = 0;
         var y1:int = 0;
         var b0:* = baba.ai.targetBody;
         if(b0 != null)
         {
            x0 = int(baba.mot.x0);
            y0 = int(baba.mot.y0);
            d0 = Game.defineGroup.getArmsDefine("LoadKing2",1,"enemyArms");
            d0.hurtArr = [this.getDiff() / baba.define.hurt_0 * 1000000];
            for(i = 0; i < 6; i++)
            {
               x1 = x0 + (i - 3) * 150 + 75;
               y1 = y0;
               ArmsAttack.shoot(d0,baba,new Point(x1,y1),d0.bulletAngle,-1000);
            }
         }
      }
      
      private function shootStop() : *
      {
         var x0:int = 0;
         var y0:int = 0;
         var d0:OneArmsDefine = null;
         var x1:int = 0;
         var y1:int = 0;
         var b0:* = baba.ai.targetBody;
         if(b0 != null)
         {
            x0 = int(baba.MX);
            y0 = int(baba.MY);
            d0 = Game.defineGroup.getArmsDefine("LoadKing2",2,"enemyArms");
            x1 = x0 + d0.shootPoint.x;
            y1 = y0 + d0.shootPoint.y;
            ArmsAttack.shoot(d0,baba,new Point(x1,y1),d0.bulletAngle,-1000);
         }
      }
   }
}

