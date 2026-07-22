package gameAll
{
   import UI.UIGroup;
   import UI.gaming.GamingUI;
   import body.bullet.OneBulletBody;
   import body.enemy.EnemyHeroBody;
   import body.hero.HeroCarBody;
   import body.hero.SubBody;
   import body.hurt.HurtCount;
   import body.lieutenant.LieutenantBody;
   import bodyGroup.BodyGroup;
   import data.StringToDefine;
   import effect.EffectGroup;
   import effect.text.RiseTextGroup;
   import enemy.AI.EnemySkill;
   import enemy._die.DieDelayGroup;
   import enemy._normal.Normal_FlyBody;
   import enemy.intercessor.IntercessorBody;
   import enemy.knowing.KnowingBody;
   import flash.events.Event;
   import gameAll.data.ArmsItemsData;
   import gameAll.data.GameData;
   import gameAll.data.GoodsItemsData;
   import gameAll.data.challenge.ChallengeTaskDefine;
   import gameAll.data.collect.CollectTaskDefine;
   import gameAll.define.OneTaskDefine;
   import gameAll.honor.OneHonorDefine;
   import gameAll.level.LevelGroup;
   import gameAll.level.Level_3_13;
   import gameAll.level.extra.VipExtraLevel;
   import gameAll.level.extra.WeekExtraLevel;
   import gameAll.order.EventOrderDefineGroup;
   import gameAll.vip.OneVipDefine;
   import items.ItemsGroup;
   import scene.things.ThingsBody;
   
   public class EventGroup
   {
      
      internal var GUI:GamingUI;
      
      internal var BG:BodyGroup;
      
      internal var GD:GameData;
      
      internal var EG:EffectGroup;
      
      internal var TG:RiseTextGroup;
      
      internal var UIG:UIGroup;
      
      internal var IG:ItemsGroup;
      
      internal var LG:LevelGroup;
      
      internal var hero:HeroCarBody;
      
      public var GAME:Game;
      
      public var dieDelay:DieDelayGroup = new DieDelayGroup();
      
      public var modelType:String = "";
      
      public function EventGroup()
      {
         super();
      }
      
      public function init(game0:*) : *
      {
         this.GAME = game0;
         this.GUI = Game.uiGroup.gamingUI;
         this.BG = Game.BG;
         this.GD = Game.gameData;
         this.EG = Game.EG;
         this.TG = Game.textGroup;
         this.UIG = Game.uiGroup;
         this.IG = Game.itemsGroup;
         this.LG = Game.LG;
         this.hero = this.BG.hero;
      }
      
      public function getLevelState() : String
      {
         return this.LG.state;
      }
      
      public function chosenSave() : *
      {
         this.fleshEquip();
         this.GD.setValue_byLevel();
      }
      
      public function upLevel(level0:int) : *
      {
         this.GUI.lv_txt.text = "LV:" + (level0 + 1);
         if(Game.gameState == "gaming")
         {
            this.EG.addEffect("levelUp","levelUp",this.hero.img);
            Game.dialogboxGroup.showGameTip("levelUp",2);
            this.GD.armsItems.Level_Growth_fleshData();
            this.GD.subItems.Level_Growth_fleshData();
         }
         this.UIG.fleshNew();
      }
      
      public function clearAllCtrl() : *
      {
         this.GD.gameTime = 0;
         this.closeLevel(false,false,false);
         if(Game.gameState == "chosen")
         {
            this.GAME.removeEventListener(Event.ENTER_FRAME,this.GAME.loaderShowTimer);
         }
         Game.swfLoaderManager.stopLoad();
         Game.gameState = "no";
         this.hero.ai.stopAI();
         this.hero.level_ai.stopAI();
      }
      
      public function startHeroAI() : *
      {
         if(this.LG.level is VipExtraLevel)
         {
            this.hero.ai.startAI();
         }
         else
         {
            this.hero.level_ai.startAI();
         }
      }
      
      public function stopHeroAI() : *
      {
         if(this.LG.level is VipExtraLevel)
         {
            this.hero.ai.stopAI();
         }
         else
         {
            this.hero.level_ai.stopAI();
            this.hero.toStop();
         }
      }
      
      public function chosenLevel(level0:int = 0, state0:String = "normal", levelPack0:String = "p1") : *
      {
         this.LG.state = state0;
         if(levelPack0 == "p2")
         {
            level0 += 100;
         }
         if(state0 == "normal")
         {
            this.GD.newLevelData.levelPack = levelPack0;
         }
         this.GAME.chosenLevel(level0);
         this.GD.nowGameEnemyLevel = Game.LG.filter.getEnemyLvNow();
         trace("当前关卡的怪物等级：" + this.GD.nowGameEnemyLevel + "     " + level0 + "，" + this.GD.nowDifficult + "，" + this.GD.newLevelData.levelPack);
         this.UIG.gamingUI.showState();
         if(this.LG.state == "extra")
         {
            if(this.GD.extraData.currentRunCardB)
            {
               this.GD.extraData.startLevelCooldown(this.LG.index);
            }
            this.GD.extraData.setNowExtraState(3);
         }
         else if(this.LG.state == "weekExtra")
         {
            this.GD.weekExtraData.setNowExtraState(false);
         }
         else if(this.LG.state == "arena")
         {
            this.UIG.gamingUI.showState("arena");
         }
         this.GD.collectTaskData.fleshNowNum();
         this.UIG.gamingUI.fleshTaskBox();
      }
      
      public function startLevel() : *
      {
         this.resumeGame();
         this.GAME.startLevel();
      }
      
      public function must_startLevel() : *
      {
         if(this.LG.state == "specialExtra")
         {
            this.GD.specialExtraData.useOneNowData();
            this.GD.livenessData.addTaskNum("special_extra");
            Game.uiGroup.saveDataNoUI();
         }
         else if(this.LG.state == "extra")
         {
            if(this.GD.extraData.currentRunRewardB)
            {
               this.GD.livenessData.addTaskNum("extra");
            }
         }
      }
      
      public function closeLevel(mustSaveB:Boolean = true, mustNoSaveB:Boolean = false, fleshUIG:Boolean = true) : *
      {
         if(this.LG.level is VipExtraLevel)
         {
            this.GD.vipData.startMapCooldown();
         }
         if(this.LG.state == "weekExtra")
         {
            this.GD.weekExtraData.getNowData().readyAt = new Date().time + 1800000;
         }
         else if(this.LG.state == "specialExtra")
         {
            this.GD.specialExtraData.startCooldown();
            Game.uiGroup.saveDataNoUI();
         }
         this.pauseGame();
         this.GAME.closeLevel();
         this.UIG.gameOverFlesh(fleshUIG);
         this.hero.ai.stopAI();
         this.hero.level_ai.stopAI();
         this.hero.arena_ai.stopAI();
         if((this.GD.gameTime > 120 || mustSaveB) && !mustNoSaveB)
         {
            this.UIG.saveDataNoUI();
         }
      }
      
      public function restartLevel() : *
      {
         if(Game.LG.index >= 0)
         {
            this.closeLevel(false);
            this.startLevel();
         }
      }
      
      public function gameFail() : *
      {
         if(this.GD.levelsLock[0] == 1 && this.LG.state == "normal" && this.GD.playerRank == "")
         {
            this.GD.nowExp -= this.GD.nowGetExp;
            this.UIG.fleshNew();
            this.restartLevel();
            return;
         }
         this.UIG.show("gameFail");
         this.UIG.gameoverUI.failShow(this.LG.state);
         this.GD.setLife(1,"mul");
         if(this.LG.state == "extra")
         {
            this.GD.extraData.setNowExtraState(3);
         }
         else if(this.LG.state == "weekExtra")
         {
            this.GD.weekExtraData.setNowExtraState(false);
            Game.uiGroup.saveDataNoUI();
         }
         else if(this.LG.state == "specialExtra")
         {
            this.GD.specialExtraData.startCooldown();
         }
         else if(this.LG.state == "arena")
         {
            this.GD.arenaData.addScore("fail");
            this.GD.arenaData.addStreakNum(0);
         }
         this.gameOverFlash();
         this.closeLevel(false);
      }
      
      public function weekExtraSave() : *
      {
         if(this.LG.level is WeekExtraLevel)
         {
            this.LG.level.saveLife();
         }
      }
      
      public function gameOverFlash(state0:String = "") : *
      {
         var s0:int = 0;
         var hitRate:String = int(this.GD.hitBulletNum / this.GD.bulletNum * 1000) / 10 + " %";
         if(this.LG.state == "arena")
         {
            this.UIG.gameoverUI.setArenaText(this.GD.arenaData.prevScore,this.GD.nowGetExp,this.GD.nowAchieve,this.GD.nowKillNum,int(this.GD.gameTime),hitRate);
         }
         else
         {
            this.UIG.gameoverUI.setText(this.GD.nowGCoin,this.GD.nowGetExp,this.GD.nowAchieve,this.GD.nowKillNum,int(this.GD.gameTime),hitRate);
         }
         if(this.LG.state == "normal" && state0 == "win")
         {
            s0 = this.UIG.gameoverUI.setGroupText(int(this.GD.gameTime),this.GD.hitBulletNum / this.GD.bulletNum,this.GD.nowHurtNum);
            this.GD.newLevelData.setScore(s0 + 10000,this.LG.index,this.GD.nowDifficult);
         }
      }
      
      public function gameWin() : *
      {
         var score0:Number = Number(NaN);
         Game.SG.playSound("win");
         var bb0:Boolean = false;
         if(this.LG.state == "extra")
         {
            bb0 = true;
            score0 = Game.gameDefine.getGroupScore(int(this.GD.gameTime),this.LG.index);
            if(score0 > this.GD.extraData.getScore(this.LG.index))
            {
               this.GD.extraData.setScore(this.LG.index,score0);
            }
         }
         if(this.LG.state == "normal")
         {
            if(this.LG.index == this.GD.levelsMax - 1)
            {
               this.UIG.gameoverUI.title_mc.gotoAndStop(this.GD.nowDifficult + 3);
            }
            trace("触发关卡解锁--------------------------------------");
            this.GD.newLevelData.unLockNextLevel();
            Game.uiGroup.chooseLevelUI.fleshLock();
            this.GD.livenessData.addTaskNum("normal_level");
         }
         else if(this.LG.state == "extra")
         {
            this.GD.extraData.setNowExtraState(2);
         }
         else if(this.LG.state == "weekExtra")
         {
            this.GD.weekExtraData.setNowExtraState(true);
            this.GD.addMCoin(45);
         }
         else if(this.LG.state == "specialExtra")
         {
            this.GD.specialExtraData.startCooldown();
            this.GD.addMCoin(15);
            this.GD.specialExtraData.useOneNowData(100);
         }
         else if(this.LG.state == "arena")
         {
            this.GD.arenaData.addScore("win");
            this.GD.arenaData.addStreakNum(1);
         }
         else if(this.LG.state == "union")
         {
            Game.uiGroup.unionUI.FisCityFight();
         }
         this.UIG.show("gameWin");
         this.UIG.gameoverUI.winShow(this.LG.state);
         this.awardFirstClearMCoin();
         this.gameOverFlash("win");
         Game.uiGroup.saveDataNoUI();
         var mustNoSaveB:Boolean = true;
         this.closeLevel(true,mustNoSaveB);
         this.unlockVipByStory();
         Game.uiGroup.saveDataNoUI();
      }
      
      private function awardFirstClearMCoin() : *
      {
         var reward:int = 0;
         var checkIndex:int = 0;
         var chapter:int = 0;
         var finalIndex:int = 0;
         var difficult:int = 0;
         var pack:String = this.GD.newLevelData.levelPack;
         if(this.LG.state != "normal" || pack != "p1" && pack != "p2")
         {
            return;
         }
         checkIndex = this.LG.index;
         if(pack == "p2")
         {
            checkIndex -= 100;
         }
         difficult = 0;
         while(difficult < 4)
         {
            if(this.GD.newLevelData.getScore(checkIndex,difficult,pack) != -1)
            {
               return;
            }
            difficult++;
         }
         if(pack == "p1" && checkIndex == 0)
         {
            reward = 10;
         }
         else
         {
            chapter = this.getStoryChapter(pack,checkIndex);
            finalIndex = this.getStoryFinalIndex(pack,chapter);
            if(chapter <= 0 || finalIndex < 0)
            {
               return;
            }
            reward = Math.min(chapter + 4,11);
            if(checkIndex == finalIndex)
            {
               reward += Math.min((chapter + 1) * 10,80);
            }
         }
         this.GD.addMCoin(reward);
         Game.dialogboxGroup.showGameTip("首次通关奖励：" + reward + " M币",5,true);
      }
      
      private function getStoryChapter(pack:String, index0:int) : int
      {
         if(pack == "p1")
         {
            if(index0 >= 1 && index0 <= 6)
            {
               return 1;
            }
            if(index0 <= 13)
            {
               return 2;
            }
            if(index0 <= 21)
            {
               return 3;
            }
            if(index0 <= 30)
            {
               return 4;
            }
            if(index0 <= 37)
            {
               return 5;
            }
            if(index0 <= 42)
            {
               return 6;
            }
            if(index0 <= 52)
            {
               return 7;
            }
            if(index0 <= 60)
            {
               return 8;
            }
            if(index0 <= 69)
            {
               return 9;
            }
         }
         else if(pack == "p2")
         {
            if(index0 >= 0 && index0 <= 19)
            {
               return 10;
            }
            if(index0 <= 28)
            {
               return 11;
            }
            if(index0 <= 40)
            {
               return 12;
            }
            if(index0 <= 58)
            {
               return 13;
            }
            if(index0 <= 100)
            {
               return 14;
            }
         }
         return 0;
      }
      
      private function getStoryFinalIndex(pack:String, chapter:int) : int
      {
         if(pack == "p1")
         {
            if(chapter == 1)
            {
               return 6;
            }
            if(chapter == 2)
            {
               return 13;
            }
            if(chapter == 3)
            {
               return 21;
            }
            if(chapter == 4)
            {
               return 30;
            }
            if(chapter == 5)
            {
               return 37;
            }
            if(chapter == 6)
            {
               return 42;
            }
            if(chapter == 7)
            {
               return 52;
            }
            if(chapter == 8)
            {
               return 60;
            }
            if(chapter == 9)
            {
               return 69;
            }
         }
         else if(pack == "p2")
         {
            if(chapter == 10)
            {
               return 19;
            }
            if(chapter == 11)
            {
               return 28;
            }
            if(chapter == 12)
            {
               return 40;
            }
            if(chapter == 13)
            {
               return 58;
            }
            if(chapter == 14)
            {
               return 100;
            }
         }
         return -1;
      }
      
      private function unlockVipByStory() : *
      {
         var targetRank:int = 0;
         var currentRank:int = 0;
         var nowVip:String = null;
         if(this.LG.state != "normal" || this.GD.nowDifficult != 0 || this.GD.newLevelData.levelPack != "p1")
         {
            return;
         }
         if(this.LG.index == 13)
         {
            targetRank = 1;
         }
         else if(this.LG.index == 30)
         {
            targetRank = 2;
         }
         else if(this.LG.index == 37)
         {
            targetRank = 3;
         }
         else if(this.LG.index == 52)
         {
            targetRank = 4;
         }
         if(targetRank == 0)
         {
            return;
         }
         nowVip = this.GD.vipData.nowVip;
         if(nowVip != null && nowVip.indexOf("vipCard_1") == 0)
         {
            currentRank = int(nowVip.substr(8)) - 10;
         }
         if(targetRank > currentRank)
         {
            this.GD.vipData.setVip("vipCard_1" + targetRank);
            Game.dialogboxGroup.showGameTip("VIP等级已永久解锁",5);
         }
      }
      
      public function toTutorial() : *
      {
         if(this.LG.state == "normal")
         {
            this.UIG.tutorialUI.toTutorial();
         }
      }
      
      public function fleshUI_byState() : *
      {
         this.UIG.menuUI.setState(this.LG.state);
      }
      
      public function changArms(site0:int, fleshB:Boolean = false) : *
      {
         var aid:ArmsItemsData = null;
         if(this.hero.img.bodyState != "fly")
         {
            aid = this.GD.armsItems.getEquipBySite(site0);
            if(aid is ArmsItemsData)
            {
               if(this.hero.armsDefine.getLabel() == aid.baseLabel && site0 == this.GD.nowArmsIndex && !fleshB)
               {
                  return;
               }
               this.GD.nowArmsIndex = site0;
               this.GD.nowArmsData = aid;
               this.hero.changeArmsItems(aid);
               this.GUI.fleshArms();
            }
         }
      }
      
      public function fleshArms() : *
      {
         this.changArms(this.GD.nowArmsIndex,true);
      }
      
      public function fleshSub() : *
      {
         this.BG.clearArr(this.BG.sub_arr);
         this.hero.SG.fleshArmsFromItemsData(this.GD.subItems,this.GD.subCarLabel);
      }
      
      public function fleshCar() : *
      {
         if(Boolean(this.GD.carItems.equArr[0]))
         {
            this.hero.changeCarItems(this.GD.carItems.equArr[0]);
         }
      }
      
      public function fleshEquip() : *
      {
         this.fleshSkill();
         this.fleshArms();
         this.fleshSub();
         this.fleshCar();
         this.GD.fleshAdd_byItems();
         this.hero.img.fleshGroupLight(this.GD.groupData.getLightB());
         this.fleshHonor();
      }
      
      public function fleshHonor() : *
      {
         var d0:OneHonorDefine = this.GD.honorData.getNowDefine();
         var honor0:String = d0.name;
         var vip_d:OneVipDefine = this.GD.vipData.getNowDefine();
         if(honor0 == "no" && !vip_d)
         {
            this.hero.headTitle.visible = false;
         }
         else
         {
            this.hero.headTitle.visible = true;
            this.hero.headTitle.txt.y = -30;
            if(honor0 == "no")
            {
               this.hero.headTitle.txt.htmlText = StringToDefine.getFontColor(vip_d.honor,"#FFFF00");
            }
            else if(!vip_d)
            {
               this.hero.headTitle.txt.htmlText = d0.cnName;
            }
            else
            {
               this.hero.headTitle.txt.y = -45;
               this.hero.headTitle.txt.htmlText = StringToDefine.getFontColor(vip_d.honor,"#FFFF00") + "\n" + d0.cnName;
            }
         }
      }
      
      public function fleshSkill() : *
      {
         this.hero.skill.fleshSkillLevel(this.GD.playerData.getFullSkillArr());
         this.hero.changeRocket(this.GD.playerData.getSkillLevel("rocket"));
         this.hero.changePlasma(this.GD.playerData.getSkillLevel("plasma"));
      }
      
      public function pauseGame() : *
      {
         if(Game.gamingTimerB)
         {
            Game.gamingTimerB = false;
            this.BG.pauseAllBody();
            this.EG.pauseAllEffect();
            this.dieDelay.pause();
         }
      }
      
      public function resumeGame() : *
      {
         if(!Game.gamingTimerB)
         {
            Game.gamingTimerB = true;
            this.BG.resumeAllBody();
            this.EG.resumeAllEffect();
            this.dieDelay.resume();
         }
      }
      
      public function heroLeaveWorld() : *
      {
      }
      
      public function heroReturnWorld() : *
      {
      }
      
      public function gamingInit() : *
      {
         this.GAME.music.stop();
         if(this.hero.die > 0)
         {
            this.hero.rebirth();
         }
         this.hero.gamingInit();
         this.GD.armsItems.fleshAllArmsEnergy();
         this.GD.lifeRateB = true;
         this.GD.setValue_byLevel();
         this.GUI.lv_txt.text = "LV:" + (this.GD.level + 1);
         this.GUI.fleshArms();
         this.UIG.gameStartFlesh();
         this.GD.gamingInit();
         this.changArms(0,true);
         this.fleshEquip();
         this.GD.fleshAdd_byItems();
         this.GD.setLife(1,"mul");
         this.UIG.leftUI.hideExtraGift();
         if(this.LG.state == "weekExtra")
         {
            this.UIG.gamingUI.nowSaveNum = 0;
         }
         else
         {
            this.UIG.gamingUI.nowSaveNum = 10000;
         }
         if(this.LG.level is VipExtraLevel)
         {
            this.UIG.leftUI.heroai_btn.visible = true;
            this.UIG.leftUI.heroai_btn.actived = true;
            this.UIG.leftUI.setHeroAI(!this.hero.ai.enabled);
         }
         else if(this.LG.state == "normal")
         {
            this.UIG.leftUI.heroai_btn.visible = true;
            if(this.GD.vipData.nowVip != "")
            {
               this.UIG.leftUI.heroai_btn.actived = true;
               this.UIG.leftUI.setHeroAI(!this.hero.level_ai.enabled);
            }
            else
            {
               this.UIG.leftUI.heroai_btn.actived = false;
               this.UIG.leftUI.heroai_btn.setText("start_heroai");
            }
         }
         else
         {
            this.UIG.leftUI.heroai_btn.visible = false;
         }
         this.UIG.leftUI.fleshVipAuto();
         if(this.GD.vipAideAutoB && this.UIG.leftUI.heroai_btn.visible && this.UIG.leftUI.heroai_btn.actived)
         {
            this.startHeroAI();
            this.UIG.leftUI.setHeroAI(false);
         }
      }
      
      public function gamingOver() : *
      {
         this.GAME.music.play(10000);
         this.hero.stopAllImage();
         this.dieDelay.gameOver();
      }
      
      public function hurt(b0:*, value:Number, attackType:String, itemsData:ArmsItemsData = null, b1:* = null, x0:int = 0, y0:int = 0, hurt_0_B:Boolean = true, hurtTextShow:Boolean = false, bulletType:String = "bullet", bullet0:* = null, mulHurt:Number = 0) : *
      {
         var defenceType:String = null;
         var hurt0:Number = Number(NaN);
         var b_hurt_0:Number = Number(NaN);
         var b_b0:* = undefined;
         var isnn:Boolean = false;
         var boomLabel0:String = null;
         var y000:int = 0;
         var textColor:uint = 0;
         var skill0:* = undefined;
         var hurt3:int = 0;
         var hurtBack0:Number = Number(NaN);
         var hurtBack1:int = 0;
         var hurtDefence0:Number = Number(NaN);
         var redu00:Number = Number(NaN);
         var dropBB:Boolean = false;
         if(b0 is HeroCarBody)
         {
            if(b0.die != 0)
            {
               return;
            }
            if(this.LG.level is VipExtraLevel)
            {
               return;
            }
            if(this.modelType == "die")
            {
               mulHurt = 0.34;
            }
            else if(this.modelType == "contra")
            {
               mulHurt = 1.1;
            }
            if(!hurtTextShow)
            {
               ++this.GD.nowHurtNum;
            }
            defenceType = this.GD.carDefenceType;
            if(hurt_0_B)
            {
               b_hurt_0 = 1;
               if(b1 is SubBody)
               {
                  b_b0 = b1.father;
               }
               else
               {
                  b_b0 = b1;
               }
               if(b_b0 is EnemyHeroBody)
               {
                  if(!b_b0.playerB)
                  {
                     b_hurt_0 = Number(b_b0.define.hurt_0);
                  }
                  else
                  {
                     b_hurt_0 = 1;
                  }
               }
               else
               {
                  b_hurt_0 = Number(b_b0.define.hurt_0);
               }
               value = b_hurt_0 * value;
            }
            hurt0 = HurtCount.getHurt(value,attackType,defenceType);
            hurt0 *= 1 - this.GD.defenceHurtRedu;
            if(hurtTextShow)
            {
               if(hurt0 < 1)
               {
                  hurt0 = 1;
               }
               this.TG.addHurtText("反弹 -" + int(hurt0),b0.img.x,b0.img.y - 65);
            }
            b0.img.car.startHurtEffect(0.1);
            if(bulletType == "bullet")
            {
               if(bullet0 is OneBulletBody)
               {
                  if(bullet0.specialType == "Slow_Missile")
                  {
                     this.GD.setLife(-this.GD.maxLife * 0.2);
                  }
               }
            }
            if(mulHurt > 0)
            {
               this.GD.setLife(-this.GD.maxLife * mulHurt);
            }
            else
            {
               isnn = Boolean(isNaN(hurt0));
               if(isnn)
               {
                  hurt0 = this.GD.maxLife / 10;
               }
               this.GD.setLife(-hurt0);
            }
            if(this.GD.nowLife <= 0)
            {
               this.heroDie();
            }
         }
         else if(!(b0 is LieutenantBody))
         {
            if(b0 is ThingsBody)
            {
               if(Math.abs(b0.img.x - b1.img.x) < 1000)
               {
                  ++b0.hitNum;
                  b0.hurtEffectShow();
                  if(b0.die > 0)
                  {
                     b0.toDie();
                     boomLabel0 = "thingsBoom";
                     if(b0.hitRect0.width > 100)
                     {
                        boomLabel0 = "thingsBoom2";
                     }
                     y000 = b0.img.y - b0.hitRect0.height / 2;
                     this.EG.addEffect("car",boomLabel0,Game.gameSprite.effectL,b0.img.x,y000);
                  }
               }
            }
            else
            {
               if(value >= 999999999 || value <= -10000000)
               {
                  this.UIG.zuobile("单把武器伤害超过999999999");
               }
               textColor = 16777215;
               defenceType = b0.define.defenceType;
               if(b1 is HeroCarBody)
               {
                  value *= this.GD.getAllArmsAdd();
               }
               else if(b1 is SubBody)
               {
                  value *= this.GD.getAllSubAdd();
               }
               else if(b1 != null)
               {
                  if(Boolean(b1.define.hasOwnProperty("hurt_0")))
                  {
                     value *= b1.define.hurt_0;
                  }
               }
               hurt0 = HurtCount.getHurt(value,attackType,defenceType);
               if(Boolean(b0.hasOwnProperty("ai")))
               {
                  if(Boolean(b0.ai.hasOwnProperty("acceptHurt")))
                  {
                     hurt0 = Number(b0.ai.acceptHurt(hurt0,attackType,defenceType));
                  }
               }
               if(itemsData is ArmsItemsData)
               {
                  hurt3 = HurtCount.getCritHurt(itemsData,hurt0);
                  hurt0 += hurt3;
                  if(hurt3 > 0)
                  {
                     textColor = 16711680;
                  }
               }
               skill0 = b0.ai.skill;
               if(skill0 is EnemySkill)
               {
                  hurtBack0 = Number(skill0.hurtBack);
                  hurtBack1 = hurt0 * hurtBack0;
                  if(hurtBack1 < 1)
                  {
                     hurtBack1 = 1;
                  }
                  if(hurtBack0 > 0)
                  {
                     if(b1 is SubBody)
                     {
                        this.hurt(b1.father,hurtBack1,attackType,null,b0,x0,y0,false,true);
                     }
                     else
                     {
                        this.hurt(b1,hurtBack1,attackType,null,b0,x0,y0,false,true);
                     }
                  }
                  hurtDefence0 = Number(b0.ai.skill.hurtDefence);
                  if(hurtDefence0 != 0)
                  {
                     hurt0 *= 1 - hurtDefence0;
                  }
               }
               if(itemsData is ArmsItemsData && this.hero.die == 0)
               {
                  if(this.LG.state != "arena")
                  {
                     if(bulletType == "laser")
                     {
                        this.GD.setLife(itemsData.add.life_steal / 5,"add");
                     }
                     else
                     {
                        this.GD.setLife(itemsData.add.life_steal,"add");
                     }
                  }
               }
               if(this.LG.state == "arena")
               {
                  if(b0 is EnemyHeroBody)
                  {
                     redu00 = this.GD.getDefenceHurtRedu(b0.ai.maxDefence,b0.define.level);
                     trace("伤害减免值：" + redu00);
                     hurt0 *= 1 - redu00;
                  }
               }
               if(b1 is HeroCarBody)
               {
                  this.TG.addAttackText(String(int(hurt0)),x0,y0 - 15,16776960);
               }
               else if(b1 is SubBody)
               {
               }
               if(Game.gameData.modOneHit && (b1 is HeroCarBody || b1 is SubBody))
               {
                  hurt0 = b0.define.maxLife + 1;
               }
               b0.define.nowLife -= hurt0;
               b0.img.startHurtEffect(0.1);
               if(b0.type != "soldier")
               {
                  this.GUI.bossBarTarget = b0;
               }
               if(b0.define.nowLife <= 0)
               {
                  this.LG.level.otherCtrl.readyDie(b0);
                  if(!Boolean(this.LG.level.storyOrder.findOrderBodyTrigger(b0,"die")))
                  {
                     if(b0.define.dialogue == "")
                     {
                        this.bodyDie(b0);
                     }
                     else
                     {
                        this.dieDelay.addDieDelay(b0);
                     }
                  }
               }
               else if(b0.define.getLifePer() <= 0.3 && b0.type == "boss")
               {
                  if(!b0.define.breakB && this.LG.state == "normal")
                  {
                     b0.define.breakB = true;
                     b0.upData_AILevel();
                     b0.upData_AILevel();
                  }
               }
               else if(b0.define.getLifePer() <= 0.5 && b0.type != "soldier" && b0.type != "boss")
               {
                  if(b0.define.dropState == "noing" && this.LG.state == "normal" && Math.random() < 0.75)
                  {
                     b0.define.dropState = "lifePer_ed";
                     this.IG.addAddBall2("lifePer",this.GD.getLifePer(),b0);
                  }
               }
               if(this.LG.state == "normal")
               {
                  if(b0.type == "boss")
                  {
                     dropBB = false;
                     if(b0.define.getLifePer() <= 0.25)
                     {
                        if(b0.define.lifeDropNum < 3)
                        {
                           dropBB = true;
                        }
                     }
                     else if(b0.define.getLifePer() <= 0.5)
                     {
                        if(b0.define.lifeDropNum < 2)
                        {
                           dropBB = true;
                        }
                     }
                     else if(b0.define.getLifePer() <= 0.75)
                     {
                        if(b0.define.lifeDropNum < 1)
                        {
                           dropBB = true;
                        }
                     }
                     if(dropBB)
                     {
                        ++b0.define.lifeDropNum;
                        this.IG.addAddBall2("lifePer",this.GD.getLifePer(),b0);
                     }
                  }
               }
               if(b1 is HeroCarBody || b1 is SubBody)
               {
                  if(b1 is SubBody)
                  {
                     if(!(b1.father is HeroCarBody))
                     {
                        return;
                     }
                  }
                  if(Boolean(bullet0))
                  {
                     if(bullet0.penetrationNum < 2)
                     {
                        ++this.GD.hitBulletNum;
                     }
                  }
               }
            }
         }
      }
      
      public function getShowRC() : Boolean
      {
         var bb:Boolean = false;
         if(this.hero.die == 0 && this.GD.lifeRateB == false)
         {
            bb = true;
         }
         return bb;
      }
      
      public function bagToMenu_shop() : *
      {
         var bb0:Boolean = this.UIG.normalShopB;
         if(!bb0)
         {
            this.showRebirthCrystal();
         }
         else
         {
            this.UIG.show("resumeGame");
         }
      }
      
      public function heroDie() : *
      {
         trace("主角死亡！！！！！");
         this.UIG.normalShopB = false;
         if(this.LG.state == "normal")
         {
            this.GD.challengeTaskData.dieTrigger();
         }
         this.UIG.gamingUI.fleshTaskBox();
         Game.oneScene.showScreenEffect_noTween(0.7,1,4294901760);
         this.UIG.gamingUI.fleshBar();
         this.GD.lifeRateB = false;
         this.hero.readyToDie();
         this.showRebirthCrystal();
      }
      
      public function showRebirthCrystal() : *
      {
         this.pauseGame();
         trace("暂停游戏！！！！！！！！！！！！！！！！！！！！！！！！！！！！");
         if(this.LG.rebirthNum > this.LG.level.allowRebirthCrystalNum)
         {
            this.noUseRebirthCrystal();
            return;
         }
         var num0:int = this.LG.getRebirthCrystal();
         if(this.LG.state == "extra")
         {
            if(this.LG.rebirthNum >= 5)
            {
               this.UIG.checkTip.showCheck2("<font color=\'#FF5B5B\'>当前副本最高只能使用5次复活水晶</font>",2,this.noUseRebirthCrystal,null,3);
            }
         }
         else if(this.LG.state == "weekExtra" || this.LG.state == "union")
         {
            this.noUseRebirthCrystal();
            return;
         }
         var items0:GoodsItemsData = this.GD.propsItems.getItemsByBase("rebirth_crystal");
         if(items0 is GoodsItemsData)
         {
            if(items0.nowNum >= num0)
            {
               this.UIG.checkTip.showCheck2("是否要原地复活？\n" + "需要消耗 <font color=\'#FFFF00\'>" + num0 + "个复活水晶</font>",1,this.heroRebirth,this.noUseRebirthCrystal,3);
            }
            else
            {
               this.UIG.checkTip.showCheck2("是否要原地复活？\n" + "需要消耗 <font color=\'#FFFF00\'>" + num0 + "个复活水晶</font>" + "<font color=\'#FF0000\'>（缺少" + (num0 - items0.nowNum) + "个）</font>",5,this.gotoShopRebirthCrystal,this.noUseRebirthCrystal,3);
            }
         }
         else
         {
            this.UIG.checkTip.showCheck2("是否要原地复活？\n" + "需要消耗 <font color=\'#FFFF00\'>" + num0 + "个复活水晶</font>" + "<font color=\'#FF0000\'>（缺少" + num0 + "个）</font>",5,this.gotoShopRebirthCrystal,this.noUseRebirthCrystal,3);
         }
      }
      
      public function gotoShopRebirthCrystal() : *
      {
         this.UIG.show("shop");
         this.UIG.shopUI.onlyShowRebirthCrystal();
      }
      
      private function heroRebirth() : *
      {
         var num0:int = this.LG.getRebirthCrystal();
         this.GD.propsItems.useItemsNum("rebirth_crystal",num0);
         ++this.LG.rebirthNum;
         Game.oneScene.clearScreenEffect();
         this.resumeGame();
         this.GD.lifeRateB = true;
         this.hero.rebirth();
         this.GD.setValue_byLevel();
         this.GD.armsItems.fleshAllArmsEnergy();
         this.BG.allEnemyAttackHero(null,true);
         this.hero.openPlasma(5);
         this.LG.level.heroRebirth();
      }
      
      public function noUseRebirthCrystal() : *
      {
         this.resumeGame();
         this.hero.toDie();
         Game.oneScene.tweenScreenEffect(1,5,0.3);
         this.LG.level.heroDie();
      }
      
      public function bodyAdd(b0:*, level0:int = -1, super3B:Boolean = true) : *
      {
         var trueLevel0:int = 0;
         var ran0:Number = Number(NaN);
         var superAllRa:Array = null;
         var bl2:Number = Number(NaN);
         var skillArr:* = undefined;
         var superPArr:Array = null;
         var m:int = 0;
         var b1:* = undefined;
         var championAllRa:Array = null;
         var bl0:Number = Number(NaN);
         var superName3:String = null;
         var b2:* = undefined;
         var eo:EventOrderDefineGroup = null;
         var bossAllRa:Array = null;
         var life_00:int = 0;
         var hurt_00:int = 0;
         if(level0 >= 0)
         {
            b0.setLevel(level0);
         }
         else
         {
            trueLevel0 = 0;
            if(this.LG.state == "normal")
            {
               trueLevel0 = Game.LG.filter.getEnemyLvNow();
               if(this.LG.level is VipExtraLevel)
               {
                  trueLevel0 = this.GD.level;
               }
               else if(this.LG.level is Level_3_13)
               {
                  if(b0.type == "boss")
                  {
                     trueLevel0 = 77;
                  }
               }
            }
            else if(this.LG.state == "extra")
            {
               trueLevel0 = this.GD.extraData.getEnemyLevel();
            }
            else if(this.LG.state == "weekExtra")
            {
               trueLevel0 = this.GD.weekExtraData.getNowData().define.level - 1;
            }
            else if(this.LG.state == "specialExtra")
            {
               trueLevel0 = this.GD.level;
            }
            else if(this.LG.state == "union")
            {
               trueLevel0 = int(this.LG.level.enemyLv);
            }
            if(b0.type == "boss")
            {
               b0.define.isBossB = true;
            }
            b0.setLevel(trueLevel0);
         }
         var skillNum:int = this.GD.nowDifficult + 2;
         var isSuperB:Boolean = Game.gameDefine.checkSuper(b0.define.name);
         var onlyChampionB:Boolean = Game.gameDefine.checkOnlyChampion(b0.define.name);
         if(b0.type == "soldier" && !this.LG.level.superShowB && isSuperB && !(this.LG.index == 0 && this.GD.newLevelData.levelPack == "p1") && this.LG.state == "normal" && !(b0 is EnemyHeroBody))
         {
            ran0 = Math.random();
            if(ran0 < 0.01)
            {
               b0.type = "champion";
            }
            else if(ran0 < 0.05)
            {
               if(!onlyChampionB)
               {
                  b0.type = "super";
               }
            }
         }
         if(b0.type == "super")
         {
            Game.LG.level.superShowB = true;
            b0.img.colorF2 = Game.gameDefine.superEnemyColor;
            b0.img.hurtEffectHide();
            superAllRa = Game.gameDefine.superAllRa;
            bl2 = Number(b0.define.baseLife);
            b0.define.mulLife(superAllRa[0] / bl2 * (1 + (bl2 - 1) * 0.2));
            b0.define.exp *= superAllRa[1];
            b0.define.coin *= superAllRa[2];
            b0.define.hurt_0 *= superAllRa[3];
            if(b0.ai.skill.arr.length == 0)
            {
               b0.ai.skill.randomSkill(skillNum);
            }
            skillArr = b0.ai.skill.strArr;
            if(super3B)
            {
               b0.define.certainChip = "orange_chip";
            }
            if(super3B && b0.define.superNum == 0)
            {
               superPArr = [50,-40];
               m = 0;
               while(m < 2)
               {
                  b1 = this.BG.getUnit(b0.define.name);
                  if(b1 == null)
                  {
                     break;
                  }
                  b1.type = "super";
                  b1.y = b0.img.y;
                  b1.x = b0.img.x + superPArr[m];
                  b1.ai.attackBody(this.BG.hero);
                  b1.ai.skill.setSkillArr(skillArr);
                  this.bodyAdd(b1,-1,false);
                  m++;
               }
            }
         }
         else if(b0.type == "champion")
         {
            championAllRa = Game.gameDefine.championAllRa;
            bl0 = Number(b0.define.baseLife);
            b0.define.mulLife(championAllRa[0] / bl0 * (1 + (bl0 - 1) * 0.2));
            b0.define.exp *= championAllRa[1];
            b0.define.coin *= championAllRa[2];
            b0.define.hurt_0 *= championAllRa[3];
            superName3 = b0.define.name;
            if(onlyChampionB || !isSuperB)
            {
               superName3 = Game.LG.randomSuper();
            }
            if(superName3 != "" && b0.define.superNum == 0)
            {
               b2 = this.BG.getUnit(superName3);
               b2.type = "super";
               b2.y = b0.img.y;
               b2.x = b0.img.x + 20;
               b2.ai.attackBody(this.BG.hero);
               this.bodyAdd(b2);
            }
            Game.LG.level.superShowB = true;
            b0.img.colorF2 = Game.gameDefine.championEnemyColor;
            b0.img.hurtEffectHide();
            b0.upData_AILevel();
            b0.upData_AILevel();
            b0.ai.skill.randomSkill(skillNum + 1);
         }
         if(b0.type == "super")
         {
            ++Game.LG.level.nowSuperNum;
            trace("如果是精英怪，停止发兵…………" + Game.LG.level.nowSuperNum);
            eo = this.LG.level.nowEODG;
            if(eo != null)
            {
               eo.pause();
            }
         }
         if(b0.type == "boss")
         {
            this.LG.level.superShowB = true;
            this.LG.level.bossShowB = true;
            bossAllRa = Game.gameDefine.bossAllRa;
            b0.define.mulLife(bossAllRa[0]);
            b0.define.exp *= bossAllRa[1];
            b0.define.coin *= bossAllRa[2];
            b0.define.hurt_0 *= bossAllRa[3];
            if(b0 is IntercessorBody || b0 is KnowingBody)
            {
               b0.addSuper();
            }
            b0.define.certainChip = "green_chip";
         }
         if(b0.define.firstDialogue != "")
         {
            this.dieDelay.addFisrtDialogue(b0.define.firstDialogue,b0);
         }
         if(b0.type == "boss" || b0.type == "super" || b0.type == "champion")
         {
            this.GUI.bossBarTarget = b0;
         }
         if(b0 is EnemyHeroBody)
         {
            if(this.LG.state == "normal")
            {
               Game.enemyCtrl.changeAll_byName(b0);
            }
            else if(this.LG.state == "weekExtra")
            {
               b0.define.hurt_0 = 1;
            }
         }
         if(this.LG.state == "extra")
         {
            if(b0.type == "boss")
            {
               life_00 = Game.gameDefine.extra.getLife(this.GD.extraData.nowDiff,this.LG.index);
               hurt_00 = Game.gameDefine.extra.getHurt(this.GD.extraData.nowDiff,this.LG.index);
               b0.define.hurt_0 = hurt_00;
               b0.define.maxLife = life_00;
               b0.define.mulLife();
               if(Boolean(b0.hasOwnProperty("extraSkill")) && Boolean(b0.extraSkill))
               {
                  b0.extraSkill.init();
               }
            }
         }
         if(this.LG.state == "specialExtra" && this.LG.index == 10)
         {
            b0.define.mulLife(40);
         }
         if(Boolean(b0.hasOwnProperty("ai")))
         {
            if(Boolean(b0.ai.hasOwnProperty("addMe")))
            {
               b0.ai.addMe();
            }
         }
         this.BG.addLifeBar(b0);
         this.LG.level.bodyAdd(b0);
      }
      
      public function bodyDie(b0:*) : *
      {
         var expMul101:Number = Number(NaN);
         var coinMul101:Number = Number(NaN);
         var exp001:Number = Number(NaN);
         var vip_d0:OneVipDefine = null;
         var vip_achieve0:Number = Number(NaN);
         var coin0:int = 0;
         var zra0:Number = Number(NaN);
         var achieve0:int = 0;
         var cd0:ChallengeTaskDefine = null;
         var eo:EventOrderDefineGroup = null;
         var cd22:ChallengeTaskDefine = null;
         var cd2:CollectTaskDefine = null;
         if(b0 is Normal_FlyBody)
         {
            if(!b0.toDieB)
            {
               return;
            }
         }
         b0.toDie();
         if(this.LG.state != "extra" || this.GD.extraData.currentRunRewardB)
         {
            this.GD.addKillNum(1);
            ++this.GD.honorData.ac.killEnemyNum;
         }
         if((this.LG.state == "normal" || Boolean(this.LG.level.doDropProgressB)) && (this.LG.state != "extra" || this.GD.extraData.currentRunRewardB))
         {
            expMul101 = 1.5;
            coinMul101 = 1;
            exp001 = (b0.define.exp * (1 + this.GD.rankAdd.expMul) + this.GD.itemsAdd.exp) * (this.GD.rankAdd.expTime + 1);
            exp001 *= 1;
            exp001 *= 1;
            vip_d0 = this.GD.vipData.getNowDefine();
            vip_achieve0 = 0;
            if(Boolean(vip_d0))
            {
               exp001 *= 1 + vip_d0.expAdd;
               vip_achieve0 = vip_d0.achieveAdd;
            }
            if(Game.nowSaveIndex == 0 || Game.nowSaveIndex == 1)
            {
               exp001 *= 1;
            }
            exp001 = Math.ceil(exp001);
            this.GD.addExp(exp001);
            this.TG.addText("经验值+" + exp001,this.hero.MX,this.hero.MY - 70,16711935,1);
            coin0 = b0.define.coin * (1 + this.GD.itemsAdd.coin + this.GD.rankAdd.coin) * coinMul101;
            if(this.GD.rankAdd.coin > 10)
            {
               this.UIG.zuobile("军衔的金币加成异常");
            }
            zra0 = 0;
            if(b0.type == "boss" || b0.type == "champion")
            {
               zra0 = Game.gameDefine.drop.getDropSuperalloy_Z(this.GD.level,b0.define.level);
            }
            if(b0.type == "boss" || b0.type == "champion" || b0.type == "super")
            {
               Game.uiGroup.unionUI.CUnionTask.AddTaskGoal(4);
            }
            achieve0 = Game.gameDefine.getEnemyAchieve_byLevel(b0.define.level,this.GD.level,b0.type);
            if(achieve0 > 0)
            {
               this.GD.addAchieve(achieve0 * (1 + this.GD.itemsAdd.achieve + vip_achieve0));
            }
            this.IG.dropItems(b0,coin0,zra0);
            if(b0.type != "soldier")
            {
               if(Math.random() < 0.75)
               {
                  this.IG.addAddBall2("lifePer",this.GD.getLifePer(),b0);
               }
               --this.LG.level.nowSuperNum;
               if(this.LG.level.nowSuperNum == 1)
               {
                  eo = this.LG.level.nowEODG;
                  if(eo != null)
                  {
                     eo.resume();
                     eo.gotoNextEnemy();
                  }
               }
            }
            for each(cd0 in this.GD.challengeTaskData.arr)
            {
               if(cd0 is ChallengeTaskDefine && cd0.state == "ing")
               {
                  cd22 = cd0.getNewDefine();
                  if(this.GD.nowDifficult == cd22.targetDiff % 4)
                  {
                     if(this.LG.index == cd22.targetLevel)
                     {
                        if(this.GD.newLevelData.levelPack == cd22.getPageName())
                        {
                           if((b0.define != null && String(cd0.enemyName) != "" && (String(b0.define.name) == String(cd0.enemyName) || String(b0.define.trueName) == String(cd0.enemyName))) && (b0.type == "boss" || b0.type == "champion" || b0.define.isBossB || b0.type != "soldier"))
                           {
                              if(this.GD.challengeTaskData.getFail(cd0.index) == "no")
                              {
                                 this.GD.challengeTaskData.completeTask(cd0.index);
                                 this.UIG.gamingUI.fleshTaskBox();
                              }
                           }
                        }
                     }
                  }
               }
            }
            if(this.GD.newLevelData.getBeforeLevelPackNow2() == "ghost")
            {
               for each(cd2 in this.GD.collectTaskData.arr)
               {
                  if(cd2 is CollectTaskDefine && Math.random() > 0.5 && cd2.state == "ing")
                  {
                     this.IG.dropAppointItems(b0,cd2.targetItems,70);
                  }
               }
            }
            Game.uiGroup.unionUI.CUnionTask.AddTaskGoal(2);
         }
         var td0:OneTaskDefine = null;
         for each(td0 in this.GD.taskData.task5)
         {
            if(td0.state == "ing" && this.GD.nowDifficult == td0.targetDiff % 4)
            {
               if(this.LG.index % 100 == td0.targetLevel)
               {
                  if(this.GD.newLevelData.levelPack == td0.getPageName())
                  {
                     td0.addKillNum();
                  }
               }
            }
         }
         this.UIG.gamingUI.fleshTaskBox();
         var tttr:Number = 0.15; // Children's Day heart drop: 15% in normal play
         if(Game.getTest())
         {
            tttr = 0.15;
         }
         if(Math.random() < tttr)
         {
            this.IG.dropAppointItems(b0,"ertongaixin",1);
         }
         Game.LG.level.bodyDie(b0);
         if(this.GUI.bossBarTarget == b0)
         {
            this.GUI.bossBarTarget = null;
         }
      }
      
      public function killAllNormalEnemy() : *
      {
         var n:* = undefined;
         var i:* = undefined;
         var b0:* = undefined;
         for(n in this.BG.enemy_arr)
         {
            for(i in this.BG.enemy_arr[n])
            {
               b0 = this.BG.enemy_arr[n][i];
               if(b0.die == 0 && b0.type == "soldier")
               {
                  this.bodyDie(b0);
               }
            }
         }
      }
   }
}

