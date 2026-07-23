package gameAll.level
{
   import UI.gaming.ArenaGamingUI;
   import body.enemy.EnemyHeroBody;
   import flash.text.TextField;
   import gameAll.high.HighArena_All;
   
   public class ArenaLevel extends Levels
   {
      
      public var arenaUI:ArenaGamingUI;
      
      public var time_txt:TextField;
      
      public var now_t:Number = 0;
      
      public var time_num:int = 3;
      
      public function ArenaLevel()
      {
         super();
      }
      
      override public function startLevel() : *
      {
         allowRebirthCrystalNum = -1;
         this.arenaUI = Game.uiGroup.gamingUI._mc2;
         this.now_t = 0;
         this.time_num = 3;
         super.startLevel();
         this.addArival();
         Game.uiGroup.saveDataNoUI();
         Game.gameData.lifeRateB2 = false;
      }
      
      public function addArival() : *
      {
         var b0:EnemyHeroBody = BG.addEnemyHeroBody();
         b0.type = "boss";
         nowBoss = b0;
         var d0:HighArena_All = Game.gameData.arenaData.arival;
         d0.extra.dps = Math.min(d0.extra.dps,Game.gameData.getAllDps());
         d0.extra.life = Math.min(d0.extra.life,Game.gameData.maxLife);
         d0.extra.defence = Math.min(d0.extra.defence,Game.gameData.maxDefence);
         b0.ai.fleshData_byHighArena_All(d0);
         b0.define.trueName = d0.extra.name;
         b0.headTitle.txt.text = d0.extra.name;
         var maxLife_00:Number = d0.extra.life;
         b0.define.maxLife = maxLife_00;
         b0.define.mulLife();
         var armsDps0:Number = Game.defineGroup.getAllDps_byStrArr(d0.extra.arms) / d0.extra.arms.length;
         var subDps0:Number = Game.defineGroup.getAllDps_byStrArr(d0.extra.sub);
         trace("计算出来对手的基础dps为：" + (armsDps0 + subDps0));
         b0.define.hurt_0 = d0.extra.dps / (armsDps0 + subDps0);
         trace("计算出来对手的系数为：" + b0.define.hurt_0);
         b0.x = hero.img.x + 300;
         b0.y = hero.img.y;
         b0.img.flipToRight();
         b0.inMouseXY(hero.img.x,hero.img.y);
         b0.SG.fleshAllPosition();
         hero.img.flipToLeft();
         Game.uiGroup.gamingUI._mc2.setBoss(b0);
         hero.setNoAttack(3.5);
         hero.key.enabled = false;
         hero.toStop();
         this.now_t = 1;
         this.arenaUI.showNumber(this.time_num);
         Game.gameState = "gaming2";
         var mx:int = (hero.img.x + b0.img.x) / 2;
         Game.oneScene.lockView(mx,"",800,800);
         Game.oneScene.enabled = false;
         this.gotoScreennMiddle();
         this.arenaUI.black_mc.visible = true;
      }
      
      override public function bodyAdd(b0:*) : *
      {
      }
      
      public function gotoScreennMiddle() : *
      {
         var mx:int = 0;
         if(Boolean(nowBoss))
         {
            mx = (hero.img.x + nowBoss.img.x) / 2;
            Game.oneScene.inPositionMiddle(mx,hero.img.y - 120);
         }
      }
      
      override public function unlockView() : *
      {
      }
      
      public function timer() : *
      {
         if(this.now_t <= 0 && this.now_t > -1)
         {
            this.now_t = 1;
            --this.time_num;
            if(this.time_num <= 0)
            {
               this.now_t = -1;
               this.arenaUI.showGo();
               nowBoss.ai.attackBody(hero);
               hero.key.enabled = true;
               Game.gameState = "gaming";
               this.arenaUI.black_mc.visible = false;
               Game.oneScene.enabled = true;
               if(Game.gameData.arenaData.autoFightingB)
               {
                  hero.arena_ai.startAI();
               }
               else
               {
                  hero.arena_ai.stopAI();
               }
            }
            else
            {
               this.arenaUI.showNumber(this.time_num);
            }
         }
         else if(this.now_t > 0)
         {
            this.now_t -= 1 / 6;
         }
      }
      
      override public function heroDie() : *
      {
         this.arenaUI.showFail();
         if(Boolean(nowBoss))
         {
            nowBoss.hitHurtB = 1;
            nowBoss = null;
         }
      }
      
      override public function bodyDie(b0:*) : *
      {
         if(b0.type == "boss")
         {
            Game.gameData.arenaData.startCurrentBotCooldown();
            Game.uiGroup.saveDataNoUI();
            hero.hitHurtB = 1;
            this.arenaUI.showWin();
            addOnceFun(exitEvent,2 / 6);
         }
      }
      
      override public function levelTimer() : *
      {
         if(enabled)
         {
            super.levelTimer();
            this.timer();
         }
      }
   }
}

