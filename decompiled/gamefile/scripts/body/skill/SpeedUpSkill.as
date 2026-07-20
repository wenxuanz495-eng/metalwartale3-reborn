package body.skill
{
   import data.INIT;
   import effect.GhostingEffectBMC;
   
   public class SpeedUpSkill
   {
      
      internal var BB:*;
      
      public var ghostingEffect:GhostingEffectBMC;
      
      public var speedUpTime:int = -1;
      
      public var maxSpeed:Number = 33.333333333333336;
      
      public function SpeedUpSkill(_BB:*)
      {
         super();
         this.BB = _BB;
      }
      
      public function getSpeedUpB() : Boolean
      {
         if(this.speedUpTime > 0)
         {
            return true;
         }
         return false;
      }
      
      public function speedUp(_time:Number = 0.2, direction:* = "no") : *
      {
         if(this.speedUpTime == -1)
         {
            this.speedUpTime = int(_time * INIT.FPS);
            this.BB.mot.xAffectB = false;
            if(direction == "no")
            {
               if(Boolean(this.BB.img.rightB))
               {
                  this.BB.mot.eVx = -this.maxSpeed;
               }
               else
               {
                  this.BB.mot.eVx = this.maxSpeed;
               }
            }
            else if(direction == "left")
            {
               this.BB.mot.eVx = -this.maxSpeed;
            }
            else if(direction == "right")
            {
               this.BB.mot.eVx = this.maxSpeed;
            }
            if(this.ghostingEffect is GhostingEffectBMC)
            {
               this.ghostingEffect.dispose();
            }
            this.ghostingEffect = new GhostingEffectBMC();
            this.ghostingEffect.Switch(this.BB.img);
            Game.SG.playSound("speedUp");
         }
      }
      
      public function stopSpeedUp() : *
      {
         this.BB.mot.xAffectB = true;
         this.BB.mot.setVx(this.BB.mot.eVx);
         this.BB.mot.eVx = 0;
      }
      
      public function speedUpTimer() : *
      {
         if(this.speedUpTime > 0)
         {
            --this.speedUpTime;
            Game.EG.addEffectInMC(this.ghostingEffect.copy(),"car","car",Game.gameSprite.effectL,this.BB.img.x,this.BB.img.y);
         }
         else if(this.speedUpTime == 0)
         {
            --this.speedUpTime;
            this.stopSpeedUp();
         }
      }
   }
}

