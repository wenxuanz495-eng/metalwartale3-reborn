package gameAll.level
{
   import data.StringToDefine;
   import enemy._normal.Normal_FlyBody;
   
   public class Level_3_15 extends Levels
   {
      
      public var en:Normal_FlyBody = null;
      
      public var now_t:Number = 0;
      
      public var failB:Boolean = false;
      
      public var enemy6B:Boolean = false;
      
      public var failText:String = "时间到！闯关失败！ ";
      
      public function Level_3_15()
      {
         super();
      }
      
      override public function startLevel() : *
      {
         super.startLevel();
         hero.toStop();
         hero.key.enabled = false;
         var b0:* = Game.BG.addEngineers();
         b0.setLevel(50);
         b0.define.maxLife = 5000000;
         b0.define.hurt_0 = 1000;
         b0.define.mulLife();
         b0.x = hero.img.x - 300;
         b0.y = hero.img.y;
         b0.ai.enabled = false;
         b0.we_AI.enabled = false;
         this.en = b0;
         addOnceFun(this.addUnit,1 / 5);
         Game.uiGroup.gamingUI.timeLimit_txt.visible = true;
         this.now_t = 5 * 60;
         this.failB = false;
         this.enemy6B = false;
      }
      
      override public function closeLevel() : *
      {
         this.en = null;
         super.closeLevel();
      }
      
      public function addUnit() : *
      {
         Game.dialogboxGroup.showDialog(this.en,"来的正好，英雄，现在我们已经成功的清除了敌人的外围据点，是时候攻击敌人的城墙。");
         addOnceFun(this.fun4,4 / 5);
         addOnceFun(this.fun5,4 / 5);
         addOnceFun(this.fun6,3 / 5);
      }
      
      private function fun4() : *
      {
         Game.dialogboxGroup.showDialog(this.en,"看，那里，敌人的部队正在集结，看来我们有一场硬仗要打了。");
         this.en.ai.enabled = false;
         this.en.we_AI.enabled = false;
         this.en.mot.followPoint(hero.img.x + 300,hero.img.y);
      }
      
      private function fun5() : *
      {
         this.en.mot.followPoint(hero.img.x + 6300,hero.img.y);
      }
      
      private function fun6() : *
      {
         Game.BG.delBody_inArr(Game.BG.weLand_arr,this.en);
         this.en = null;
         hero.key.enabled = true;
      }
      
      override public function bodyAdd(b0:*) : *
      {
         var arr0:Array = null;
         super.bodyAdd(b0);
         if(b0.type == "boss")
         {
            arr0 = [0.6,0.8,1.1,1.2];
            b0.define.maxLife = arr0[Game.gameData.nowDifficult] * 100000000;
            b0.define.mulLife();
         }
      }
      
      override protected function hitAreaEvent(id0:String, isEventOrderDefineGroupB:Boolean = true) : *
      {
         super.hitAreaEvent(id0,isEventOrderDefineGroupB);
         if(id0 == "enemy6")
         {
            this.enemy6B = true;
            Game.uiGroup.gamingUI.timeLimit_txt.visible = false;
         }
      }
      
      public function fail() : *
      {
         this.failB = true;
         Game.uiGroup.gamingUI.timeLimit_txt.text = this.failText;
         Game.eventGroup.noUseRebirthCrystal();
      }
      
      override public function levelTimer() : *
      {
         if(!this.enemy6B)
         {
            this.timeTimer();
         }
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
         return "剩余 " + StringToDefine.getTimeStr(this.now_t);
      }
   }
}

