package enemy.gundam
{
   import body.motion.GroundMotion;
   import enemy.AI.EnemySkillDefine;
   import enemy.AI.Enemy_AI;
   
   public class Gundam2_AI extends Enemy_AI
   {
      
      public var heroState:String = "land";
      
      public var turnRightB:int = 0;
      
      public var openGundam3B:Boolean = false;
      
      public var mustOrder:String = "";
      
      public var skill_list:Array = ["shoot_1","shoot_1","shoot_1","","shoot_2","shoot_1","shoot_1","shoot_3","","shoot_2"];
      
      public var nowIndex:int = 0;
      
      public var nowOrder:String = "shoot_1";
      
      public function Gundam2_AI(_baba:*)
      {
         super(_baba);
         bilvArr = [1,1,1,1];
      }
      
      public function shootPan() : *
      {
         if(this.openGundam3B)
         {
            if(baba.img.nowLabel == "shoot_2")
            {
               if(Boolean(baba.img.rightB))
               {
                  baba.mot.x0 -= 20;
               }
               else
               {
                  baba.mot.x0 += 20;
               }
            }
         }
      }
      
      override protected function attackOrder() : *
      {
         var ran:Number = NaN;
         this.turnRightB = 0;
         if(baba.define.getLifePer() < 0.3)
         {
            baba.upData_AILevel();
         }
         if(this.openGundam3B)
         {
            if(this.mustOrder != "")
            {
               baba.img.goOnce_ToLoop(this.mustOrder,"stand");
               this.mustOrder = "";
            }
            else if(this.nowOrder == "shoot_1")
            {
               baba.img.goOnce_ToLoop("shoot_1","stand");
            }
            else if(this.nowOrder == "shoot_2")
            {
               baba.img.goOnce_ToLoop("shoot_2","stand");
               EnemySkillDefine.shootBullet(baba,"Gundam3");
            }
            else if(this.nowOrder == "shoot_3")
            {
               baba.img.goOnce_ToLoop("shoot_3","stand");
            }
            else
            {
               this.addFunnel();
               baba.img.goOnce_ToLoop("shoot_missile","stand");
            }
         }
         else
         {
            ran = Math.random();
            if(ran <= 0.25)
            {
               baba.img.goOnce_ToLoop("shoot_1","stand");
            }
            else if(ran <= 0.5)
            {
               baba.img.goOnce_ToLoop("shoot_2","stand");
            }
            else if(ran <= 0.75)
            {
               baba.img.goOnce_ToLoop("shoot_3","stand");
            }
            else
            {
               this.addFunnel();
               baba.img.goOnce_ToLoop("shoot_missile","stand");
            }
         }
         baba.img.visible = true;
         if(Boolean(baba.define.lifeBar))
         {
            baba.define.lifeBar.visible = true;
         }
      }
      
      private function addFunnel() : *
      {
         var father0:String = "bullet";
         if(this.openGundam3B)
         {
            father0 = "Gundam3";
         }
         var fun0:FunnelBody = Game.BG.addGundamFunnel(father0);
         fun0.define.hurt_0 = baba.define.hurt_0;
         fun0.x = attackX;
         fun0.y = attackY - 100;
         if(baba.mot.x0 < attackX)
         {
            fun0.img.flipToRight();
         }
      }
      
      override public function stopAttack() : *
      {
         if(Boolean(baba.img.shootB))
         {
            baba.img.goPlayLoop("stand");
         }
         state = "noing";
         ClearAllFun();
      }
      
      override protected function followToPoint(x0:Number, y0:Number) : *
      {
         if(this.heroState != "land")
         {
            followFilp();
         }
         else if(baba.mot is GroundMotion)
         {
            if(Boolean(baba.mot.getJumpConditionB()))
            {
               baba.changeState("fly");
               bilvArr = [1,1];
            }
         }
         baba.mot.followPoint(x0,y0);
      }
      
      override protected function reachTarget() : *
      {
         followFilp();
         baba.mot.stopFollow();
      }
      
      override protected function getAttackEndB() : Boolean
      {
         return baba.img.endFrameB;
      }
      
      override protected function attackOver() : *
      {
         var ran:Number = NaN;
         if(this.heroState == "land")
         {
            baba.img.goPlayLoop("stand");
         }
         else
         {
            baba.img.goPlayLoop("fly");
         }
         if(this.openGundam3B)
         {
            if(baba.state != "land")
            {
               baba.changeState("land");
               bilvArr = [1,1,1];
            }
            this.nowIndex = (this.nowIndex + 1) % this.skill_list.length;
            this.nowOrder = this.skill_list[this.nowIndex];
            if(this.nowOrder == "shoot_3")
            {
               baba.img.visible = false;
               if(Boolean(baba.define.lifeBar))
               {
                  baba.define.lifeBar.visible = false;
               }
            }
         }
         else
         {
            ran = Math.random();
            if(ran > 0.7)
            {
               baba.changeState("fly");
               bilvArr = [1,1];
            }
            else
            {
               baba.changeState("land");
               bilvArr = [1,1,1];
            }
         }
         super.attackOver();
      }
      
      override public function aiTimer() : *
      {
         super.aiTimer();
         this.shootPan();
      }
   }
}

