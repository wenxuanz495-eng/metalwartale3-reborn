package body.skill
{
   public class OneSkill
   {
      
      public var index:int = 0;
      
      public var define:SkillDefine = null;
      
      public var levelDefine:OneLevelSkillDefine = null;
      
      public var nowNum:int = 0;
      
      public var time_t:Number = 0;
      
      public var timeUseB:Boolean = false;
      
      public var timeUseFun:Function = null;
      
      public var timeTimeFun:Function = null;
      
      public var timeCloseFun:Function = null;
      
      public var cool_t:Number = -1;
      
      public var jump_t:Number = 10000;
      
      public var enabled:Boolean = true;
      
      public function OneSkill()
      {
         super();
      }
      
      public function initData_byDefine(d0:OneLevelSkillDefine) : *
      {
         this.levelDefine = d0;
         this.nowNum = d0.maxNum;
         this.time_t = d0.maxTime;
         this.cool_t = -1;
         this.timeUseB = false;
      }
      
      public function useSkill() : Boolean
      {
         if(this.getUseB())
         {
            if(this.define.skillType == "time")
            {
               this.timeUseB = true;
               if(this.timeUseFun is Function)
               {
                  this.timeUseFun();
               }
            }
            else if(this.define.skillType == "number")
            {
               --this.nowNum;
            }
            return true;
         }
         return false;
      }
      
      public function closeSkill() : *
      {
         if(this.define.skillType == "time")
         {
            this.timeUseB = false;
            if(this.levelDefine.coolingTime > 0)
            {
               this.cool_t = 0;
            }
            if(this.timeCloseFun is Function)
            {
               this.timeCloseFun();
            }
         }
      }
      
      public function getUseB() : Boolean
      {
         if(this.define.skillType == "time")
         {
            return this.cool_t < 0 && this.time_t >= 0.5;
         }
         if(this.define.skillType == "number")
         {
            if(this.define.name == "lighting")
            {
               return this.nowNum > 0 && (this.cool_t < 0 || this.cool_t > 2);
            }
            return this.nowNum > 0;
         }
         return false;
      }
      
      public function getUseNum() : int
      {
         return this.levelDefine.maxNum - this.nowNum;
      }
      
      public function getCoolPer() : Number
      {
         if(this.cool_t > 0)
         {
            return this.cool_t / this.levelDefine.coolingTime;
         }
         return 0;
      }
      
      public function getTimePer() : Number
      {
         if(this.time_t > 0)
         {
            return this.time_t / this.levelDefine.maxTime;
         }
         return 0;
      }
      
      private function numberTimer() : *
      {
         if(this.nowNum < this.levelDefine.maxNum)
         {
            if(this.cool_t < 0)
            {
               this.cool_t = 0;
            }
            else if(this.cool_t >= this.levelDefine.coolingTime)
            {
               ++this.nowNum;
               this.cool_t = -1;
            }
            else
            {
               this.cool_t += 1 / 30;
            }
         }
         else
         {
            this.cool_t = -1;
         }
      }
      
      private function timeTimer() : *
      {
         if(this.timeUseB)
         {
            if(this.time_t <= 0)
            {
               this.time_t = 0;
               this.closeSkill();
            }
            else
            {
               this.time_t -= 1 / 30;
               if(this.timeTimeFun is Function)
               {
                  this.timeTimeFun();
               }
            }
         }
         else
         {
            this.jump_t = 10000;
            if(this.time_t >= this.levelDefine.maxTime)
            {
               this.time_t = this.levelDefine.maxTime;
            }
            else
            {
               this.time_t += 1 / 30 / this.levelDefine.recoveryTime;
            }
            if(this.cool_t >= 0 && this.levelDefine.coolingTime > 0)
            {
               this.cool_t += 1 / 30;
               if(this.cool_t >= this.levelDefine.coolingTime)
               {
                  this.cool_t = -1;
               }
            }
            else
            {
               this.cool_t = -1;
            }
         }
      }
      
      public function skillTimer() : *
      {
         if(this.enabled)
         {
            if(this.define.skillType == "time")
            {
               this.timeTimer();
            }
            else if(this.define.skillType == "number")
            {
               this.numberTimer();
            }
         }
      }
   }
}

