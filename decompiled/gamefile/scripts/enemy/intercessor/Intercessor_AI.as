package enemy.intercessor
{
   import enemy.AI.Enemy_AI;
   
   public class Intercessor_AI extends Enemy_AI
   {
      
      public var attackWay:int = 0;
      
      public var nowAttackOrder:String = "shoot_3";
      
      public var heroState:String = "intercessor";
      
      public function Intercessor_AI(_baba:*)
      {
         super(_baba);
      }
      
      override protected function attackOrder() : *
      {
         var ran:Number = NaN;
         var bilv:Number = NaN;
         if(this.heroState == "intercessor")
         {
            ran = Math.random();
            bilv = 0.5;
            if(ran <= bilv)
            {
               this.attackWay = 0;
               baba.attack.startAttackOnce_break();
            }
            else
            {
               this.attackWay = 1;
               baba.img.goOnce_ToLoop("shoot_2","stand");
            }
         }
         else if(this.nowAttackOrder == "shoot_3")
         {
            this.attackWay = 1;
            baba.img.goOnce_ToLoop("shoot_3","stand2");
         }
         else if(this.nowAttackOrder == "shoot_jump")
         {
            this.attackWay = 0;
            baba.armsDefine.inData("Intercessor_jump",0);
            baba.attack.startAttackOnce_break();
            baba.mot.delayToJump();
         }
         else if(this.nowAttackOrder == "shoot_attack")
         {
            this.attackWay = 1;
            baba.img.goOnce_ToLoop("shoot_attack","stand2");
         }
         else
         {
            this.attackWay = 1;
            baba.img.goOnce_ToLoop("shoot_4","stand2");
         }
      }
      
      override protected function attackOver() : *
      {
         var ran:Number = NaN;
         var bilv:Number = NaN;
         var ran2:Number = NaN;
         var bilv2:Number = NaN;
         var x0:Number = NaN;
         var cx:Number = NaN;
         var ran3:Number = NaN;
         if(this.heroState == "intercessor")
         {
            baba.img.goPlayLoop("stand");
            ran = Math.random();
            bilv = 0.7;
            if(ran <= bilv && Boolean(baba.changeB))
            {
               baba.changeState("adjudicator");
            }
         }
         else if(this.heroState == "adjudicator")
         {
            if(this.nowAttackOrder == "shoot_jump")
            {
               baba.img.toPlayLoop("jump_down");
            }
            else
            {
               baba.img.goPlayLoop("stand2");
            }
            ran2 = Math.random();
            bilv2 = 0.25;
            if(ran2 <= bilv2)
            {
               this.nowAttackOrder = "shoot_3";
            }
            else if(ran2 <= bilv2 * 2)
            {
               this.nowAttackOrder = "shoot_jump";
            }
            else if(ran2 <= bilv2 * 3)
            {
               this.nowAttackOrder = "shoot_attack";
            }
            else
            {
               this.nowAttackOrder = "shoot_4";
            }
            x0 = Number(baba.mot.x0);
            cx = Math.abs(x0 - attackX);
            ran3 = Math.random();
            if(ran3 > 0.7)
            {
               if(cx > 350)
               {
                  this.nowAttackOrder = "shoot_4";
               }
               else if(cx < 120)
               {
                  this.nowAttackOrder = "shoot_attack";
               }
            }
            if(this.nowAttackOrder == "shoot_attack")
            {
               baba.define.rectLevel = 2;
               baba.flesh_byDefine();
            }
            else if(this.nowAttackOrder == "shoot_4")
            {
               baba.define.rectLevel = 1;
               baba.flesh_byDefine();
            }
            else
            {
               baba.define.rectLevel = 0;
               baba.flesh_byDefine();
            }
         }
         super.attackOver();
      }
      
      override protected function getAttackEndB() : Boolean
      {
         if(this.attackWay == 0 || this.attackWay == 2)
         {
            return baba.attack.state == "over";
         }
         return baba.img.endFrameB;
      }
      
      override protected function reachTarget() : *
      {
         followFilp();
         baba.mot.stopFollow();
      }
   }
}

