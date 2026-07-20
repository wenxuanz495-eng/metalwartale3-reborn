package gameAll.level.extra
{
   import data.StringToDefine;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import gameAll.level.Levels;
   
   public class VipExtraLevel extends Levels
   {
      
      public var orderB:Boolean = true;
      
      public var isShowBossB:Boolean = false;
      
      public var now_t:Number = 0;
      
      public var nowNum:int = 0;
      
      public function VipExtraLevel()
      {
         super();
      }
      
      override public function startLevel() : *
      {
         super.startLevel();
         this.orderB = true;
         this.now_t = 0;
         Game.uiGroup.gamingUI.timeLimit_txt.visible = true;
      }
      
      public function enemyOrder() : *
      {
         var x0:Number = NaN;
         var rect0:Rectangle = null;
         var rect1:Rectangle = null;
         var minX0:int = 0;
         var maxX0:int = 0;
         this.now_t += 1 / 6;
         if(this.now_t > 15)
         {
            this.now_t = 15;
         }
         var num0:int = Game.BG.getHurtEnemyNum();
         if(this.orderB)
         {
            if(this.nowNum >= 20)
            {
               this.nowNum = 0;
               this.orderB = false;
            }
            else
            {
               x0 = hero.mot.x0;
               rect0 = Game.oneScene.moveRectArr2[0];
               rect1 = Game.oneScene.moveRectArr2[1];
               minX0 = 0;
               maxX0 = 0;
               if(Boolean(rect0))
               {
                  minX0 = rect0.x + rect0.width + 1000;
               }
               else
               {
                  minX0 = Game.oneScene.viewRangeRect2.x + 1000;
               }
               if(Boolean(rect1))
               {
                  maxX0 = rect1.x - 1000;
               }
               else
               {
                  maxX0 = Game.oneScene.viewRangeRect2.x + Game.oneScene.viewRangeRect2.width - 1000;
               }
               trace("############## moveRectArr2:" + Game.oneScene.moveRectArr2);
               if(x0 < minX0 + 800)
               {
                  x0 = minX0 + 800;
               }
               else if(x0 > maxX0 - 800)
               {
                  x0 = maxX0 - 800;
               }
               trace("############## min" + minX0);
               trace("############## max" + maxX0);
               trace("##############" + x0);
               Game.LG.doOrder_byID("enemy" + int(Math.random() * 10),new Point(x0));
               if(!this.isShowBossB)
               {
                  this.isShowBossB = true;
                  Game.LG.doOrder_byID("boss" + int(Math.random() * 6),new Point(x0));
               }
               ++this.nowNum;
            }
         }
         if(num0 <= 0 && this.now_t >= 15)
         {
            this.orderB = true;
            this.now_t = 0;
            hero.ai.reStartAI();
         }
      }
      
      public function timeTimer() : *
      {
         var tt0:Number = NaN;
         if(enabled)
         {
            tt0 = Game.gameData.vipData.mapTime;
            if(tt0 > 0)
            {
               tt0 -= 1 / 6;
            }
            else
            {
               tt0 = -100;
               exitEvent();
               Game.uiGroup.show("vip");
            }
            Game.uiGroup.gamingUI.timeLimit_txt.visible = true;
            Game.uiGroup.gamingUI.timeLimit_txt.text = "剩余时间 " + StringToDefine.getTimeStr(tt0);
            Game.gameData.vipData.mapTime = tt0;
         }
      }
      
      override public function bodyDie(b0:*) : *
      {
         var chipArr0:Array = null;
         var level0:int = 0;
         var chipName0:String = null;
         super.bodyDie(b0);
         if(b0.type == "boss")
         {
            if(Math.random() <= 0.2)
            {
               chipArr0 = [];
               level0 = int(b0.define.level);
               if(level0 >= 59)
               {
                  chipArr0 = ["zhen","lie"];
               }
               else if(level0 >= 39)
               {
                  chipArr0 = ["jing","zu"];
               }
               else if(level0 >= 19)
               {
                  chipArr0 = ["ben","zhui"];
               }
               if(chipArr0.length > 0)
               {
                  chipName0 = chipArr0[int(chipArr0.length * Math.random())] + "_purple_chip";
                  Game.itemsGroup.dropAppointItems(b0,chipName0,3);
               }
            }
         }
      }
      
      override public function levelTimer() : *
      {
         this.timeTimer();
         this.enemyOrder();
         super.levelTimer();
      }
   }
}

