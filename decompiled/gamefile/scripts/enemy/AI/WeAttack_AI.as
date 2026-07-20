package enemy.AI
{
   public class WeAttack_AI
   {
      
      protected var baba:*;
      
      protected var ai:*;
      
      public var enabled:Boolean = false;
      
      public var attack_t:Number = 0;
      
      public function WeAttack_AI(_baba:*, _ai:*)
      {
         super();
         this.baba = _baba;
         this.ai = _ai;
      }
      
      public function pan() : *
      {
         var earr:Array = null;
         var num0:int = 0;
         var chooseB:Boolean = false;
         if(this.ai.targetBody == null)
         {
            chooseB = true;
         }
         else if(this.ai.targetBody.die != 0)
         {
            chooseB = true;
         }
         if(chooseB || this.attack_t >= 5)
         {
            this.attack_t = 0;
            earr = Game.BG.getLiveEnemy();
            if(earr.length > 0)
            {
               num0 = earr.length * Math.random();
               trace("攻击单位：" + earr[num0].define.name);
               this.ai.attackBody(earr[num0]);
            }
            else if(this.ai.state != "noing")
            {
               this.ai.stopAttack();
               this.ai.state = "noing";
            }
            else
            {
               this.ai.hoverTarget();
               this.ai.weFollowFilp();
            }
         }
         else
         {
            this.attack_t += 1 / 30;
         }
      }
      
      public function FTimer() : *
      {
         if(this.enabled)
         {
            this.pan();
         }
      }
   }
}

