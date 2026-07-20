package gameAll.level
{
   import data.StringToDefine;
   
   public class Level_2_5 extends Levels
   {
      
      public var now_t:Number = 720;
      
      public var failB:Boolean = false;
      
      public var failText:String = "时间到！闯关失败！ ";
      
      public function Level_2_5()
      {
         super();
      }
      
      override public function startLevel() : *
      {
         super.startLevel();
         Game.uiGroup.gamingUI.timeLimit_txt.visible = true;
         this.now_t = 12 * 60;
         this.failB = false;
      }
      
      public function fail() : *
      {
         this.failB = true;
         Game.uiGroup.gamingUI.timeLimit_txt.text = this.failText;
         Game.eventGroup.noUseRebirthCrystal();
      }
      
      override public function levelTimer() : *
      {
         this.timeTimer();
         super.levelTimer();
      }
      
      public function timeTimer() : *
      {
         if(enabled && !this.failB)
         {
            if(this.now_t < 0)
            {
               this.now_t = 0;
               this.fail();
            }
            else
            {
               this.now_t -= 1 / 6;
            }
            Game.uiGroup.gamingUI.timeLimit_txt.visible = true;
            Game.uiGroup.gamingUI.timeLimit_txt.text = this.getTimeLimitText();
         }
      }
      
      public function getTimeLimitText() : String
      {
         return "限时闯关 " + StringToDefine.getTimeStr(this.now_t);
      }
   }
}

