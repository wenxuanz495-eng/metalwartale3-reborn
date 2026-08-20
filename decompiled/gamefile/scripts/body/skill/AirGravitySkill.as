package body.skill
{
   import data.INIT;

   /**
    * Standalone charge-based air-gravity controller.
    * It intentionally does not use OneSkill or any other skill's timer state.
    */
   public class AirGravitySkill
   {
      public var maxCharges:int = 1;
      public var charges:int = 1;
      public var recoveryTime:Number = 3.5;
      public var recoveryTimer:Number = -1;
      public var enabled:Boolean = true;

      public function AirGravitySkill()
      {
         super();
      }

      public function configure(maxCharges0:int, recoveryTime0:Number = 3.5) : *
      {
         if(maxCharges0 < 1)
         {
            maxCharges0 = 1;
         }
         this.maxCharges = maxCharges0;
         this.recoveryTime = recoveryTime0 > 0 ? recoveryTime0 : 3.5;
         this.charges = this.maxCharges;
         this.recoveryTimer = -1;
      }

      public function reset() : *
      {
         this.charges = this.maxCharges;
         this.recoveryTimer = -1;
      }

      public function canUse() : Boolean
      {
         return this.enabled && this.charges > 0;
      }

      public function consume() : Boolean
      {
         if(!this.canUse())
         {
            return false;
         }
         --this.charges;
         if(this.charges < this.maxCharges && this.recoveryTimer < 0)
         {
            this.recoveryTimer = 0;
         }
         return true;
      }

      public function timer() : *
      {
         if(!this.enabled || this.charges >= this.maxCharges)
         {
            this.recoveryTimer = -1;
            return;
         }
         if(this.recoveryTimer < 0)
         {
            this.recoveryTimer = 0;
         }
         this.recoveryTimer += 1 / INIT.FPS;
         if(this.recoveryTimer >= this.recoveryTime)
         {
            ++this.charges;
            this.recoveryTimer = this.charges < this.maxCharges ? 0 : -1;
         }
      }
   }
}
