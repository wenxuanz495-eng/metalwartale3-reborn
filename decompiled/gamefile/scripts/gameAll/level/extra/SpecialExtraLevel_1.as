package gameAll.level.extra
{
   import flash.geom.Rectangle;
   import gameAll.level.Levels;
   import scene.OneSence;
   
   public class SpecialExtraLevel_1 extends Levels
   {
      
      public var plamsaUseNum:int = 0;
      
      public var plamsaUseMaxNum:int = 3;
      
      public var lifeBall_t:Number = 0;
      
      public var superAttack_t:Number = -1;
      
      public function SpecialExtraLevel_1()
      {
         super();
      }
      
      override public function startLevel() : *
      {
         super.startLevel();
         Game.gameData.lifeRateB2 = false;
         Game.eventGroup.modelType = "die";
         this.superAttack_t = -1;
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
               x1 = rect0.x + 100 + (rect0.width - 100) * Math.random();
               y1 = Game.BGHit.getMinY(x1) - 1000;
               Game.itemsGroup.addAddBall("superAttack",0.34,x1,y1,Math.PI / 2);
            }
            else
            {
               this.lifeBall_t += 1 / 6;
            }
         }
         if(this.superAttack_t > 0)
         {
            this.superAttack_t -= 1 / 6;
         }
         else if(this.superAttack_t <= 0 && this.superAttack_t > -1)
         {
            this.no_superAttack();
            this.superAttack_t = -1;
         }
      }
      
      public function getUsePlamsaB() : Boolean
      {
         return this.plamsaUseNum < this.plamsaUseMaxNum;
      }
      
      public function set_superAttack() : *
      {
         var n:* = undefined;
         var i:* = undefined;
         var b0:* = undefined;
         this.superAttack_t = 10;
         var arr0:Array = Game.BG.enemy_arr;
         for(n in arr0)
         {
            for(i in arr0[n])
            {
               b0 = arr0[n][i];
               if(Boolean(b0.ai.hasOwnProperty("skill")))
               {
                  b0.ai.skill.hurtDefence = -1;
               }
            }
         }
      }
      
      public function no_superAttack() : *
      {
         var n:* = undefined;
         var i:* = undefined;
         var b0:* = undefined;
         var arr0:Array = Game.BG.enemy_arr;
         for(n in arr0)
         {
            for(i in arr0[n])
            {
               b0 = arr0[n][i];
               if(Boolean(b0.ai.hasOwnProperty("skill")))
               {
                  b0.ai.skill.hurtDefence = 0;
               }
            }
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

