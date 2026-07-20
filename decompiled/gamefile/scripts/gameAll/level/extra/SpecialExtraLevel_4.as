package gameAll.level.extra
{
   import flash.geom.Rectangle;
   import gameAll.level.Levels;
   import scene.OneSence;
   
   public class SpecialExtraLevel_4 extends Levels
   {
      
      public var maxEnemyNum:int = 18;
      
      public var failB:Boolean = false;
      
      public var lifeBall_t:Number = 0;
      
      public var boom_num:int = 0;
      
      public function SpecialExtraLevel_4()
      {
         super();
      }
      
      override public function startLevel() : *
      {
         super.startLevel();
         Game.uiGroup.gamingUI.timeLimit_txt.visible = true;
         this.failB = false;
         this.boom_num = 0;
      }
      
      public function fail() : *
      {
         this.failB = true;
         Game.uiGroup.gamingUI.timeLimit_txt.text = "怪物数量超出！闯关失败！ ";
         Game.eventGroup.noUseRebirthCrystal();
      }
      
      public function lifeBallTimer() : *
      {
         var rect0:Rectangle = null;
         var x0:int = 0;
         var y0:int = 0;
         var x1:int = 0;
         var y1:int = 0;
         var oneSence:OneSence = Game.oneScene;
         if(oneSence.lockB)
         {
            if(this.lifeBall_t >= 30)
            {
               this.lifeBall_t = 0;
               rect0 = oneSence.viewRangeRect2;
               x0 = rect0.x + 100 + (rect0.width - 100) * Math.random();
               y0 = Game.BGHit.getMinY(x0) - 1000;
               Game.itemsGroup.addAddBall("lifePer",0.34,x0,y0,Math.PI / 2);
               if(this.boom_num < 3 && Math.random() > 0.5)
               {
                  ++this.boom_num;
                  x1 = rect0.x + 100 + (rect0.width - 100) * Math.random();
                  y1 = Game.BGHit.getMinY(x1) - 1000;
                  Game.itemsGroup.addAddBall("clearEnemy",0.34,x1,y1,Math.PI / 2);
               }
            }
            else
            {
               this.lifeBall_t += 1 / 6;
            }
         }
      }
      
      override public function levelTimer() : *
      {
         if(enabled && !this.failB)
         {
            nowEnemyNum = Game.BG.getAllEnemyNum();
            if(nowEnemyNum >= this.maxEnemyNum)
            {
               this.fail();
            }
            else
            {
               Game.uiGroup.gamingUI.timeLimit_txt.visible = true;
               Game.uiGroup.gamingUI.timeLimit_txt.text = "怪物数量：" + nowEnemyNum;
            }
         }
         if(enabled)
         {
            this.lifeBallTimer();
         }
         super.levelTimer();
      }
   }
}

