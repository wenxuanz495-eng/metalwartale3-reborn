package gameAll.level.extra
{
   import data.StringToDefine;
   import data.TextWay;
   import enemy.spider.SpiderBody;
   import gameAll.level.Level_2_5;
   
   public class SpecialExtraLevel_7 extends Level_2_5
   {
      
      public var TT:String = TextWay.toCode("15");
      
      public var SS:String = TextWay.toCode("10");
      
      public var hold_t:Number = 0;
      
      public var enemy_t:Number = 0;
      
      public var enemyT:Number = 0;
      
      public var enemyT_t:Number = 0;
      
      public var holdB:Boolean = false;
      
      public function SpecialExtraLevel_7()
      {
         super();
      }
      
      override public function startLevel() : *
      {
         super.startLevel();
         now_t = 235;
         this.holdB = false;
         this.hold_t = 0;
         this.enemyT = 0.8;
         allowRebirthCrystalNum = -1;
      }
      
      override protected function hitAreaEvent(id0:String, isEventOrderDefineGroupB:Boolean = true) : *
      {
         if(id0 == "enemy1")
         {
            this.holdB = true;
            this.hold_t = 0;
         }
      }
      
      override public function getTimeLimitText() : String
      {
         return "剩余时间 " + StringToDefine.getTimeStr(now_t);
      }
      
      public function lifeBallTimer() : *
      {
         var b0:SpiderBody = null;
         var xarr:Array = null;
         var xx0:int = 0;
         var ymin:int = 0;
         if(this.holdB && hero.die == 0)
         {
            if(this.hold_t >= int(TextWay.getText(this.TT)))
            {
               this.hold_t = 0;
               Game.textGroup.addText("功勋+" + TextWay.getText(this.SS),hero.MX,hero.MY - 70,16776960,3);
               Game.gameData.addAchieve(int(TextWay.getText(this.SS)));
               Game.SG.playSound("upgradeArms");
               this.enemyT *= 0.8;
            }
            else
            {
               this.hold_t += 1 / 6;
            }
            if(this.enemy_t > this.enemyT + 0.05)
            {
               b0 = Game.BG.getUnit("自爆蜘蛛机");
               xarr = [500,-500];
               xx0 = xarr[int(xarr.length * Math.random())] + Game.oneScene.getPositionMiddle().x;
               ymin = Game.BGHit.getMinY(xx0) - 50;
               b0.x = xx0;
               b0.y = ymin;
               b0.ai.attackBody(hero);
               Game.eventGroup.bodyAdd(b0,Game.gameData.level);
               b0.define.mulHurt = 0.34;
               b0.define.maxLife *= 4;
               b0.define.mulLife();
               this.enemy_t = 0;
            }
            else
            {
               this.enemy_t += 1 / 6;
            }
         }
      }
      
      override public function timeTimer() : *
      {
         if(enabled && !failB)
         {
            if(now_t < 0)
            {
               now_t = 0;
               fail();
            }
            else if(this.holdB)
            {
               now_t -= 1 / 6;
            }
            Game.uiGroup.gamingUI.timeLimit_txt.visible = true;
            Game.uiGroup.gamingUI.timeLimit_txt.text = this.getTimeLimitText();
         }
      }
      
      override public function unlockView() : *
      {
      }
      
      override public function levelTimer() : *
      {
         if(enabled)
         {
            this.lifeBallTimer();
         }
         super.levelTimer();
      }
   }
}

