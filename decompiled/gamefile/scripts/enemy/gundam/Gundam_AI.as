package enemy.gundam
{
   import body.motion.GroundMotion;
   import enemy.AI.Enemy_AI;
   
   public class Gundam_AI extends Enemy_AI
   {
      
      public var changeB:Boolean = true;
      
      public var heroState:String = "fly";
      
      public var nowAttackOrder:String = "Gundam_fly_1";
      
      public function Gundam_AI(_baba:*)
      {
         super(_baba);
      }
      
      public function resumeAttack() : *
      {
         state = "noing";
      }
      
      override protected function attackOrder() : *
      {
         var fun0:FunnelBody = null;
         baba.armsDefine.inData(this.nowAttackOrder,0);
         super.attackOrder();
         if(this.nowAttackOrder == "Gundam_funnel")
         {
            fun0 = Game.BG.addGundamFunnel();
            fun0.define.hurt_0 = baba.define.hurt_0;
            fun0.x = attackX;
            fun0.y = attackY - 100;
            if(baba.mot.x0 < attackX)
            {
               fun0.img.flipToRight();
            }
         }
      }
      
      override protected function attackOver() : *
      {
         var ran:Number = NaN;
         var bilv:Number = NaN;
         super.attackOver();
         if(this.changeB)
         {
            ran = Math.random();
            bilv = 0.3;
            if(ran <= bilv)
            {
               baba.changeState("plane");
               this.heroState = "plane";
            }
            else if(ran <= bilv * 2)
            {
               baba.changeState("fly");
               this.heroState = "fly";
            }
            else if(ran <= bilv * 3)
            {
               baba.changeState("land");
               this.heroState = "land";
            }
         }
         var ran2:Number = Math.random();
         var bilv2:Number = 0.5;
         if(this.heroState == "plane")
         {
            if(ran2 <= bilv2)
            {
               this.nowAttackOrder = "Gundam_plane";
               baba.define.rectLevel = 3;
               baba.flesh_byDefine();
            }
            else
            {
               this.nowAttackOrder = "Gundam_plane";
               baba.define.rectLevel = 3;
               baba.flesh_byDefine();
            }
         }
         else if(this.heroState == "fly")
         {
            if(ran2 <= bilv2)
            {
               this.nowAttackOrder = "Gundam_fly_1";
               baba.define.rectLevel = 1;
               baba.flesh_byDefine();
            }
            else
            {
               this.nowAttackOrder = "Gundam_fly_2";
               baba.define.rectLevel = 2;
               baba.flesh_byDefine();
            }
         }
         else if(this.heroState == "land")
         {
            if(ran2 <= bilv2)
            {
               this.nowAttackOrder = "Gundam_land";
               baba.define.rectLevel = 0;
               baba.flesh_byDefine();
            }
            else
            {
               this.nowAttackOrder = "Gundam_funnel";
               baba.define.rectLevel = 0;
               baba.flesh_byDefine();
            }
         }
      }
      
      public function shootPan() : *
      {
         if(this.nowAttackOrder == "Gundam_fly_1" || this.nowAttackOrder == "Gundam_fly_2" || this.nowAttackOrder == "Gundam_land")
         {
            if(baba.attack.state == "shoot")
            {
               Game.oneScene.showScreenEffect();
               Game.oneScene.shake.startShake(20,1,-baba.AAHD.shootRa,-40,40,0,"random");
            }
         }
      }
      
      override protected function reachTarget() : *
      {
         followFilp();
         baba.mot.stopFollow();
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
               this.heroState = "fly";
            }
         }
         baba.mot.followPoint(x0,y0);
      }
      
      override public function aiTimer() : *
      {
         super.aiTimer();
         this.shootPan();
      }
   }
}

