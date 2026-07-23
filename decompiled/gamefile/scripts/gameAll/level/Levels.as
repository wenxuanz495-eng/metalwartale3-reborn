package gameAll.level
{
   import body.hero.HeroCarBody;
   import bodyGroup.BodyGroup;
   import flash.geom.Rectangle;
   import gameAll.order.EventOrderDefineGroup;
   import gameAll.other.IDArea;
   import sound.OneMusic;
   
   public class Levels extends LevelsDefine
   {
      
      protected var hero:HeroCarBody;
      
      protected var BG:BodyGroup;
      
      public var otherCtrl:LevelsOther;
      
      public var nowBoss:* = null;
      
      public var nowEODG:EventOrderDefineGroup = null;
      
      public var exitHeadTitle:*;
      
      public var enemyOverB:Boolean = true;
      
      private var enemyMusic:OneMusic;
      
      public var supplyB:int = 0;
      
      public var nowPortal:IDArea = null;
      
      public var superShowB:Boolean = false;
      
      public var bossShowB:Boolean = false;
      
      public var nowSuperNum:int = 0;
      
      public var nowEnemyNum:int = 0;
      
      public var enemyNumAffterBoss:int = 0;
      
      public var allowRebirthCrystalNum:int = 999999;
      
      public var doDropProgressB:Boolean = false;
      
      public var dropCoinB:Boolean = false;
      
      public var dropExpB:Boolean = false;
      
      public function Levels()
      {
         super();
         enabled = false;
         this.otherCtrl = new LevelsOther(this);
      }
      
      override public function inData_byXML(xml0:XML) : *
      {
         this.BG = Game.BG;
         super.inData_byXML(xml0);
      }
      
      public function startLevel() : *
      {
         var i:* = undefined;
         var ar0:IDArea = null;
         var id0:String = null;
         var s0:* = undefined;
         var s1:* = undefined;
         var eo:EventOrderDefineGroup = null;
         this.otherCtrl.startLevel();
         this.showDownUI();
         this.nowSuperNum = 0;
         this.nowEnemyNum = 0;
         this.enemyNumAffterBoss = 0;
         this.superShowB = false;
         this.bossShowB = false;
         this.supplyB = 0;
         this.nowPortal = null;
         trace("startLevel设置superShowB：" + this.superShowB);
         exitPoint.y = Game.BGHit.getMinY(exitPoint.x) - 40;
         inAreaData(xml);
         enabled = true;
         this.enemyMusic = Game.SG.getMusic(musicLabel);
         this.enemyMusic.play(10000);
         this.hero = this.BG.hero;
         this.hero.x = bornPoint.x;
         this.hero.y = Game.BGHit.getMinY(bornPoint.x) - 30;
         this.hero.SG.fleshAllPosition();
         if(this.exitHeadTitle == null)
         {
            this.exitHeadTitle = Game.swfLoaderManager.getResource("ui","ExitHead");
            Game.gameSprite.effectL2.addChild(this.exitHeadTitle);
            this.exitHeadTitle.x = exitPoint.x;
            this.exitHeadTitle.y = exitPoint.y;
         }
         Game.oneScene.inPositionMiddle(bornPoint.x,bornPoint.y);
         for(i in area)
         {
            ar0 = area[i];
            id0 = ar0.id;
            if(id0 == "supply")
            {
               s0 = this.BG.addSupply();
               s0.x = ar0.x + ar0.width / 2;
               s0.y = Game.BGHit.getMinY(s0.x);
               ar0.index = this.BG.supply_arr.length - 1;
               trace("创建补给站：" + s0.x + "  " + s0.y);
            }
            else if(id0 == "portal")
            {
               s1 = this.BG.addPortal();
               s1.x = ar0.x + ar0.width / 2;
               s1.y = Game.BGHit.getMinY(s1.x);
               ar0.index = this.BG.supply_arr.length - 1;
               trace("创建传送门：" + s1.x + "  " + s1.y);
            }
            else
            {
               eo = this.getEODG(id0);
               if(eo is EventOrderDefineGroup)
               {
                  eo.addRegularUnit(ar0);
               }
            }
         }
      }
      
      public function closeLevel() : *
      {
         this.allowRebirthCrystalNum = 99999;
         enabled = false;
         if(Boolean(this.enemyMusic))
         {
            this.enemyMusic.stop();
         }
         this.clear();
         if(Boolean(this.exitHeadTitle))
         {
            if(Game.gameSprite.effectL2.contains(this.exitHeadTitle))
            {
               Game.gameSprite.effectL2.removeChild(this.exitHeadTitle);
            }
            this.exitHeadTitle = null;
         }
      }
      
      public function clear() : *
      {
         area.length = 0;
         eventOrder.length = 0;
         ClearAllFun();
         storyOrder.arr.length = 0;
      }
      
      public function getEODG(_id:String) : EventOrderDefineGroup
      {
         var n:* = undefined;
         var eo:EventOrderDefineGroup = null;
         for(n in eventOrder)
         {
            eo = eventOrder[n];
            if(_id == eo.id)
            {
               return eo;
            }
         }
         return null;
      }
      
      public function killLoop(id0:String) : *
      {
         var eod:EventOrderDefineGroup = this.getEODG(id0);
         if(eod is EventOrderDefineGroup)
         {
            eod.killLoop();
         }
      }
      
      public function toEvent(str:String) : *
      {
         var eo:EventOrderDefineGroup = this.getEODG(str);
         if(eo is EventOrderDefineGroup)
         {
            eo.enabled = true;
         }
      }
      
      private function fleshEventOrder() : *
      {
         var n:* = undefined;
         var eo:EventOrderDefineGroup = null;
         var unlockB:Boolean = true;
         var eo_id:String = "";
         for(n in eventOrder)
         {
            eo = eventOrder[n];
            eo.happen();
            if(eo.enabled == true)
            {
               unlockB = false;
            }
         }
         if(unlockB)
         {
            if(!this.BG.getLiveEnemyB2() && !this.enemyOverB)
            {
               this.enemyOverB = true;
               this.unlockView();
               this.enemyOverEvent("");
            }
         }
      }
      
      public function openEventOrderDefineGroup(eo:EventOrderDefineGroup, x0:int, y0:int, id0:String) : *
      {
         var px0:int = 0;
         if(eo is EventOrderDefineGroup)
         {
            this.enemyOverB = false;
            eo.initAll();
            eo.enabled = true;
            eo.inMiddlePoint(x0,y0);
            if(id0.indexOf("tip") == -1)
            {
               Game.oneScene.lockView(x0,"middle",eo.lockWidth,eo.lockWidth2);
               Game.SG.playSound("enemy_coming_larm");
               px0 = Game.oneScene.getPositionMiddle().x;
               this.BG.attackBody_byArr(this.BG.getLiveEnemy_byRect(new Rectangle(x0 - 800,-10000,1600,100000)));
               trace("锁屏位置：" + Game.oneScene.viewRangeRect2);
            }
         }
         this.nowEODG = eo;
      }
      
      protected function enemyOverEvent(id0:String) : *
      {
      }
      
      public function hitArea(x0:Number, y0:Number) : IDArea
      {
         var n:* = undefined;
         var ar0:IDArea = null;
         var id0:String = null;
         var mc0:* = undefined;
         var mc22:* = undefined;
         var eo:EventOrderDefineGroup = null;
         var mc1:* = undefined;
         for(n in area)
         {
            ar0 = area[n];
            id0 = ar0.id;
            if(ar0.contains(x0,y0))
            {
               if(id0 == "supply")
               {
                  if(!ar0.hitB)
                  {
                     mc0 = this.BG.supply_arr[ar0.index];
                     if(Boolean(mc0))
                     {
                        mc0.gotoAndStop(2);
                     }
                     this.supplyB = 1;
                     trace("碰到补给站：" + this.supplyB);
                  }
                  ar0.hitB = true;
               }
               else if(id0 == "portal")
               {
                  if(!ar0.hitB)
                  {
                     mc22 = this.BG.supply_arr[ar0.index];
                     if(Boolean(mc22))
                     {
                        mc22.play();
                     }
                     this.supplyB = 2;
                     trace("碰到传送门：" + this.supplyB);
                     this.nowPortal = ar0;
                  }
                  ar0.hitB = true;
               }
               else
               {
                  area.splice(n,1);
                  if(id0 == "exit")
                  {
                     this.exitEvent();
                  }
                  else
                  {
                     eo = this.getEODG(id0);
                     this.hitAreaEvent(id0,eo is EventOrderDefineGroup);
                     this.openEventOrderDefineGroup(eo,ar0.point.x,ar0.point.y,id0);
                  }
               }
               return ar0;
            }
            if(id0 == "supply" || id0 == "portal")
            {
               if(ar0.hitB)
               {
                  mc1 = this.BG.supply_arr[ar0.index];
                  mc1.gotoAndStop(1);
                  this.supplyB = 0;
                  trace("离开补给站：" + this.supplyB);
               }
               ar0.hitB = false;
            }
         }
         return null;
      }
      
      protected function hitAreaEvent(id0:String, isEventOrderDefineGroupB:Boolean = true) : *
      {
         this.otherCtrl.hitAreaEvent(id0,isEventOrderDefineGroupB);
      }
      
      public function exitEvent() : *
      {
         var giftArr0:Array = null;
         if(Game.LG.state == "extra" || Game.LG.state == "weekExtra" || Game.LG.state == "specialExtra")
         {
            if(Game.LG.state == "specialExtra")
            {
               giftArr0 = Game.gameData.specialExtraData.getNowData().giftArr;
               if(giftArr0.length == 0)
               {
                  Game.eventGroup.gameWin();
                  return;
               }
            }
            Game.eventGroup.pauseGame();
            Game.stage0.quality = "high";
            Game.uiGroup.leftUI.showExtraGift();
         }
         else
         {
            Game.eventGroup.gameWin();
         }
      }
      
      public function gotoPortal() : *
      {
      }
      
      public function unlockView() : *
      {
         Game.oneScene.unLockView();
         this.BG.unlockArr(this.BG.heroCar_arr);
         this.superShowB = false;
      }
      
      public function showDownUI() : *
      {
         Game.uiGroup.gamingUI.showArmsBar();
         Game.uiGroup.gamingUI.showSkillIcon();
         Game.uiGroup.leftUI.showBtn();
      }
      
      public function firstDialogueOver(b0:*) : *
      {
      }
      
      public function heroDie() : *
      {
      }
      
      public function heroRebirth() : *
      {
      }
      
      public function bodyDie(b0:*) : *
      {
         var num0:int = 0;
         if(b0.type == "boss" || this.enemyNumAffterBoss >= 100)
         {
            trace("停止指定发兵循环：" + b0.define.eventOrderDefineGroupID);
            this.killLoop(b0.define.eventOrderDefineGroupID);
         }
         if(this.nowEODG is EventOrderDefineGroup)
         {
            num0 = this.BG.getAllEnemyNum();
            if(num0 <= 30)
            {
               this.nowEODG.resume();
            }
         }
      }
      
      public function bodyAdd(b0:*) : *
      {
         var num0:int = 0;
         var xxx:* = undefined;
         if(this.nowEODG is EventOrderDefineGroup)
         {
            num0 = this.BG.getAllEnemyNum();
            if(num0 > 8)
            {
               this.nowEODG.pause();
            }
         }
         if(this.bossShowB)
         {
            ++this.enemyNumAffterBoss;
         }
          if(b0.type == "boss")
          {
             if(bossLifeArr.length > 0)
             {
                var bossLife0:Number = Number(bossLifeArr[Game.gameData.nowDifficult]);
                if(Game.LG.state == "union")
                {
                   bossLife0 = Number(bossLifeArr[0]) * [1,2,4,8][Game.gameData.giftData.getUnionBattleDifficulty()];
                }
                else if(isNaN(bossLife0))
                {
                   bossLife0 = Number(bossLifeArr[0]);
                }
                b0.define.maxLife = bossLife0;
                b0.define.mulLife();
             }
            if(bossAttackTurn.length > 0 && Boolean(b0.ai.hasOwnProperty("attackTurnArr")))
            {
               b0.ai.attackTurnArr = bossAttackTurn;
            }
             if(bossAttackHurt.length > 0 && Boolean(b0.ai.hasOwnProperty("attackHurtArr")))
             {
                if(Game.LG.state == "union")
                {
                   var unionHurtArr0:Array = [];
                   var unionHurtRa0:Number = [1,1.35,1.75,2.25][Game.gameData.giftData.getUnionBattleDifficulty()];
                   for each(var unionHurt0:String in bossAttackHurt)
                   {
                      unionHurtArr0.push(Number(unionHurt0) * unionHurtRa0);
                   }
                   b0.ai.attackHurtArr = unionHurtArr0;
                }
                else
                {
                   b0.ai.attackHurtArr = bossAttackHurt;
                }
             }
            xxx = 0;
         }
         this.otherCtrl.bodyAdd(b0);
      }
      
      public function levelTimer() : *
      {
         if(enabled)
         {
            this.otherCtrl.FTimer();
            storyOrder.FTimer();
            this.fleshEventOrder();
            super.FTimer();
         }
      }
   }
}

