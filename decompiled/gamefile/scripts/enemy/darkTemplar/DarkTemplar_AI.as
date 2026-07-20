package enemy.darkTemplar
{
   import body.attack.ArmsAttack;
   import body.define.OneArmsDefine;
   import data.StringToDefine;
   import enemy.AI.Enemy_AI;
   import flash.geom.Point;
   
   public class DarkTemplar_AI extends Enemy_AI
   {
      
      public var shootLabel:Array = ["shoot1","shoot2","shoot3","shoot4","shoot5","shoot11","shoot12","shoot13","shoot14"];
      
      public var slay_t:Number = 0;
      
      public function DarkTemplar_AI(_baba:*)
      {
         super(_baba);
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
      
      override protected function reachTarget() : *
      {
         followFilp();
         baba.mot.stopFollow();
      }
      
      override protected function attackOrder() : *
      {
         var pro_arr:Array = [0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.2];
         var label0:String = this.shootLabel[StringToDefine.getPro_byArr2(pro_arr)];
         if(label0 == "shoot14")
         {
            baba.hitHurtB = 1;
            baba.define.lifeBar.visible = false;
         }
         else
         {
            baba.hitHurtB = 0;
            baba.define.lifeBar.visible = true;
         }
         baba.img.goOnce_ToLoop(label0,"stand");
      }
      
      override protected function getAttackEndB() : Boolean
      {
         return baba.img.endFrameB;
      }
      
      override protected function attackOver() : *
      {
         var ran:Number = Math.random();
         if(ran < 0.5)
         {
            baba.mot.vxmax_Fi = (baba.define.vx + 200) / 30;
         }
         else
         {
            baba.mot.vxmax_Fi = baba.define.vx / 30;
         }
         baba.hitHurtB = 0;
         baba.define.lifeBar.visible = true;
         baba.img.goPlayLoop("stand");
         super.attackOver();
      }
      
      override public function attackAI() : *
      {
         var d0:OneArmsDefine = null;
         var xx0:int = 0;
         var yy0:int = 0;
         super.attackAI();
         var label0:String = baba.img.nowLabel;
         if(label0 == "shoot14")
         {
            this.slay_t += 1 / 30;
            if(this.slay_t > 0.3)
            {
               this.slay_t = 0;
               d0 = Game.defineGroup.getArmsDefine("DarkTemplar",0,"enemyArms");
               xx0 = Game.BG.hero.img.x - 250 + 500 * Math.random();
               yy0 = Game.BGHit.getMinY(xx0);
               ArmsAttack.shoot(d0,baba,new Point(xx0,yy0),-Math.PI / 2);
               if(baba.img.nowMC.currentFrame >= 78)
               {
                  baba.hitHurtB = 0;
                  baba.define.lifeBar.visible = true;
               }
               else
               {
                  baba.hitHurtB = 1;
                  baba.define.lifeBar.visible = false;
               }
               Game.oneScene.shake.startShake(4,0.1,Math.random() * 10,-10,10,0,"random");
            }
         }
         else
         {
            this.slay_t = 0;
            if(label0 == "shoot13")
            {
               if(baba.img.nowMC.currentFrame >= 41)
               {
                  Game.oneScene.shake.startShake(8,0.1,Math.random() * 10,-18,18,0,"random");
               }
               else if(baba.img.nowMC.currentFrame == 33)
               {
                  Game.oneScene.shake.startShake(3,0.2,90,-32,32,0,"cos");
               }
            }
         }
      }
   }
}

