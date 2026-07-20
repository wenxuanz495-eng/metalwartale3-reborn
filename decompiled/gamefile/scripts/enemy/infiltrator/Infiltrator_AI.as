package enemy.infiltrator
{
   import effect.EffectSMC;
   import enemy.gear.Gear2_AI;
   
   public class Infiltrator_AI extends Gear2_AI
   {
      
      public var stealthB:Boolean = false;
      
      public var now_t:Number = 20;
      
      public var hide_forLifeB:Boolean = false;
      
      public function Infiltrator_AI(_baba:*)
      {
         super(_baba);
         this.fleshMax();
      }
      
      public function fleshMax() : *
      {
         if(baba.type == "boss")
         {
            this.now_t = 20;
         }
         else
         {
            this.now_t = 10;
         }
      }
      
      override public function attackAI() : *
      {
         var ed0:EffectSMC = null;
         if(this.now_t <= 0)
         {
            this.fleshMax();
            if(this.stealthB)
            {
               this.stealthB = false;
               baba.img.visible = true;
               if(Boolean(baba.define.lifeBar))
               {
                  baba.define.lifeBar.visible = true;
               }
            }
            else
            {
               this.stealthB = true;
               baba.img.visible = false;
               if(Boolean(baba.define.lifeBar))
               {
                  baba.define.lifeBar.visible = false;
               }
               ed0 = Game.EG.addEffect("Infiltrator","effect",Game.gameSprite.effectL,baba.img.x,baba.img.y,0);
               if(Boolean(baba.img.rightB))
               {
                  ed0.mc.scaleX = -1;
               }
            }
         }
         else
         {
            this.now_t -= 1 / 30;
         }
         if(!this.hide_forLifeB)
         {
            if(baba.define.getLifePer() < 0.5)
            {
               this.hide_forLifeB = false;
               if(this.stealthB)
               {
                  this.fleshMax();
               }
               else
               {
                  this.now_t = 0;
               }
            }
         }
         super.attackAI();
      }
   }
}

