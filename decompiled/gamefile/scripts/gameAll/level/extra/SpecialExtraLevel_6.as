package gameAll.level.extra
{
   import body.attack.ArmsAttack;
   import body.define.OneArmsDefine;
   import data.StringToDefine;
   import flash.geom.Point;
   import gameAll.level.Level_2_5;
   import gameAll.order.EventOrderDefineGroup;
   import items.ItemsBody;
   import scene.OneSence;
   
   public class SpecialExtraLevel_6 extends Level_2_5
   {
      
      public var coinNum0:int = 0;
      
      public var coin_t:Number = 0;
      
      public var lifePer_t:Number = 0;
      
      public var nobody:* = null;
      
      public function SpecialExtraLevel_6()
      {
         super();
         failText = "通关";
      }
      
      override public function startLevel() : *
      {
         super.startLevel();
         allowRebirthCrystalNum = -1;
         this.nobody = BG.addAirLaserFort();
         this.nobody.x = -10000;
         this.nobody.y = -10000;
         this.coin_t = 0;
         now_t = 3 * 60;
      }
      
      override public function getTimeLimitText() : String
      {
         return "坚持 " + StringToDefine.getTimeStr(now_t) + " 通关";
      }
      
      override public function closeLevel() : *
      {
         super.closeLevel();
         this.nobody = null;
      }
      
      public function lifeBallTimer() : *
      {
         var money0:int = 0;
         var items0:ItemsBody = null;
         var d0:OneArmsDefine = null;
         var oneSence:OneSence = Game.oneScene;
         var p0:Point = new Point();
         if(oneSence.lockB)
         {
            this.coin_t += 1 / 6;
            this.lifePer_t += 1 / 6;
            if(this.coin_t >= 0.4)
            {
               this.coin_t = 0;
               p0 = oneSence.getCloseFloorRandomPoint();
               money0 = 100;
               if(Math.random() <= 1 / 15)
               {
                  money0 = 1000;
               }
               items0 = Game.itemsGroup.addAddBall("money",money0,p0.x,p0.y - 500,Math.PI / 2,true,false);
               items0.mot.vymax = 100 / 30;
               items0.mot.vxmax = 200 / 30;
               ++this.coinNum0;
               if(this.coinNum0 >= 15)
               {
                  this.coinNum0 = 0;
                  d0 = Game.defineGroup.getArmsDefine("CoinSpace_Missile",0,"enemyArms");
                  p0 = new Point(hero.img.x,hero.img.y);
                  ArmsAttack.shoot(d0,this.nobody,new Point(p0.x,p0.y - 500),Math.PI / 2);
               }
            }
         }
      }
      
      override public function fail() : *
      {
         failB = true;
         Game.uiGroup.gamingUI.timeLimit_txt.text = failText;
         Game.eventGroup.killAllNormalEnemy();
         var d0:EventOrderDefineGroup = nowEODG;
         if(Boolean(d0))
         {
            d0.pause();
         }
         unlockView();
      }
      
      override public function timeTimer() : *
      {
         var oneSence:OneSence = null;
         if(enabled && !failB)
         {
            if(now_t < 0)
            {
               now_t = 0;
               this.fail();
            }
            else
            {
               oneSence = Game.oneScene;
               if(oneSence.lockB)
               {
                  now_t -= 1 / 6;
               }
            }
            Game.uiGroup.gamingUI.timeLimit_txt.visible = true;
            Game.uiGroup.gamingUI.timeLimit_txt.text = this.getTimeLimitText();
         }
      }
      
      override public function levelTimer() : *
      {
         if(enabled)
         {
            this.lifeBallTimer();
            super.levelTimer();
         }
      }
   }
}

