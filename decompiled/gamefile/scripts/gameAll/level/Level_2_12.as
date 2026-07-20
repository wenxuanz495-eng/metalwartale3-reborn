package gameAll.level
{
   import data.StringToDefine;
   import enemy.airLaserFort.AirLaserFortBody;
   import enemy.bansheeFighter.BansheeFighterBody;
   
   public class Level_2_12 extends Levels
   {
      
      internal var air0:AirLaserFortBody;
      
      public var now_t:Number = -1;
      
      public var failB:Boolean = false;
      
      public function Level_2_12()
      {
         super();
      }
      
      public function fail() : *
      {
         this.failB = true;
         Game.uiGroup.gamingUI.timeLimit_txt.text = "时间到！闯关失败！ ";
         Game.eventGroup.noUseRebirthCrystal();
      }
      
      public function timeTimer() : *
      {
         if(this.now_t > 0)
         {
            this.now_t -= 1 / 5;
            Game.uiGroup.gamingUI.timeLimit_txt.visible = true;
            Game.uiGroup.gamingUI.timeLimit_txt.text = "限时闯关 " + StringToDefine.getTimeStr(this.now_t);
            trace("now_t：" + this.now_t);
         }
         else if(this.now_t <= 0 && this.now_t > -1)
         {
            this.fail();
            this.now_t = -1;
         }
         else
         {
            Game.uiGroup.gamingUI.timeLimit_txt.visible = false;
         }
      }
      
      override public function startLevel() : *
      {
         super.startLevel();
         this.now_t = -1;
         this.failB = false;
      }
      
      public function addUnit(num0:int) : *
      {
         var b0:AirLaserFortBody = null;
         b0 = Game.BG.addAirLaserFort("AirLaserFort",false);
         b0.setLevel(50);
         b0.hitHurtB = 1;
         b0.ai.enabled = false;
         b0.x = 9800 + 450;
         b0.y = Game.BGHit.getMinY(b0.img.x) - 200;
         b0.ai.hoverBody = hero;
         b0.img.colorF2 = Game.gameDefine.weEnemyColor;
         b0.img.hurtEffectHide();
         this.air0 = b0;
      }
      
      override protected function hitAreaEvent(id0:String, isEventOrderDefineGroupB:Boolean = true) : *
      {
         var str0:* = undefined;
         super.hitAreaEvent(id0,isEventOrderDefineGroupB);
         if(id0 == "enemy3")
         {
            this.addUnit(0);
            str0 = Game.gameDefine.dialogue.text["k1_10_1"];
            Game.dialogboxGroup.showDialog(this.air0,str0,null,4);
         }
      }
      
      override public function firstDialogueOver(b0:*) : *
      {
         if(b0 is BansheeFighterBody && this.now_t == -1)
         {
            this.now_t = (5 - Game.gameData.nowDifficult) * 60;
            if(Game.gameData.nowDifficult == 3)
            {
               this.now_t = 3 * 60;
            }
            this.followHero();
            trace("开始倒计时！！！！！！");
         }
      }
      
      override public function closeLevel() : *
      {
         super.closeLevel();
         this.air0 = null;
         this.now_t = -1;
         this.failB = false;
      }
      
      public function followHero() : *
      {
         if(this.air0 != null)
         {
            this.air0.ai.hoverBody = hero;
            this.air0.ai.state = "nextAttacking";
            this.air0.ai.affterAttack = "hoverAndAttack";
            this.air0.ai.enabled = true;
            this.air0 = null;
         }
      }
      
      override public function levelTimer() : *
      {
         if(enabled)
         {
            super.levelTimer();
            this.timeTimer();
         }
      }
   }
}

