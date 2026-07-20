package gameAll.level
{
   import data.StringToDefine;
   import gameAll.order.StoryOrderDefine;
   
   public class LevelsOther
   {
      
      public var levels:Levels;
      
      public var doTimeOverB:Boolean = false;
      
      public function LevelsOther(lv0:Levels)
      {
         super();
         this.levels = lv0;
      }
      
      public function startLevel() : *
      {
         this.doTimeOverB = false;
      }
      
      private function timePan() : *
      {
         var time0:Number = NaN;
         var time_txt0:String = null;
         if(this.levels.limitTime > 0 && !this.doTimeOverB)
         {
            time0 = Game.gameData.gameTime;
            if(time0 >= this.levels.limitTime)
            {
               this.doTimeOverB = true;
               if(this.levels.timeOverOrder == "fail")
               {
                  Game.eventGroup.noUseRebirthCrystal();
               }
               else if(this.levels.timeOverOrder == "win")
               {
                  this.levels.exitEvent();
               }
               Game.uiGroup.gamingUI.timeLimit_txt.text = this.levels.timeOverText;
            }
            else
            {
               time_txt0 = StringToDefine.getTimeStr(this.levels.limitTime - time0);
               Game.uiGroup.gamingUI.timeLimit_txt.text = this.levels.timingText.replace("@time",time_txt0);
            }
            Game.uiGroup.gamingUI.timeLimit_txt.visible = true;
         }
      }
      
      public function bodyAdd(b0:*) : *
      {
         var s0:StoryOrderDefine = this.levels.storyOrder.findOrderBodyTrigger(b0,"show");
         if(Boolean(s0))
         {
            s0.doAction();
         }
      }
      
      public function readyDie(b0:*) : *
      {
         var s0:StoryOrderDefine = this.levels.storyOrder.findOrderBodyTrigger(b0,"die");
         if(Boolean(s0))
         {
            s0.doAction();
         }
      }
      
      public function hitAreaEvent(id0:String, isEventOrderDefineGroupB:Boolean = true) : *
      {
         var s0:StoryOrderDefine = this.levels.storyOrder.findOrderTrigger("area:" + id0);
         if(Boolean(s0))
         {
            s0.doAction();
         }
      }
      
      public function FTimer() : *
      {
         this.timePan();
      }
   }
}

