package enemy.loadKing
{
   import enemy.AI.Enemy_AI;
   
   public class LoadKing_AI extends Enemy_AI
   {
      
      public var nowAttackOrder:String = "shoot_1";
      
      public function LoadKing_AI(_baba:*)
      {
         super(_baba);
      }
      
      override protected function attackOrder() : *
      {
         if(this.nowAttackOrder == "shoot_attack")
         {
            baba.img.goOnce_ToLoop("shoot_attack","stand");
         }
         else if(this.nowAttackOrder == "shoot_1")
         {
            baba.armsDefine.inData("LoadKing",0);
            baba.attack.startAttackOnce_break();
         }
         else if(this.nowAttackOrder == "shoot_2")
         {
            baba.armsDefine.inData("LoadKing",1);
            baba.attack.startAttackOnce_break();
         }
      }
      
      override protected function attackOver() : *
      {
         var ran2:Number = Math.random();
         var bilv2:Number = 0.33;
         if(ran2 <= bilv2)
         {
            this.nowAttackOrder = "shoot_1";
            baba.define.rectLevel = 0;
         }
         else if(ran2 <= bilv2 * 2)
         {
            this.nowAttackOrder = "shoot_2";
            baba.define.rectLevel = 0;
         }
         else
         {
            this.nowAttackOrder = "shoot_attack";
            baba.define.rectLevel = 1;
         }
         baba.flesh_byDefine();
         baba.img.goPlayLoop("stand");
         super.attackOver();
      }
      
      override protected function getAttackEndB() : Boolean
      {
         if(this.nowAttackOrder.indexOf("attack") >= 0)
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
         if(label0 == "shoot_attack")
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
      }
   }
}

