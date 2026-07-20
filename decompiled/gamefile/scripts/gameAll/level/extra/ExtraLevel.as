package gameAll.level.extra
{
   import flash.geom.Rectangle;
   import gameAll.level.Levels;
   import scene.OneSence;
   
   public class ExtraLevel extends Levels
   {
      
      public var lifeBall_t:Number = 0;
      
      public var nowExtraBoss:* = null;
      
      public function ExtraLevel()
      {
         super();
      }
      
      override public function startLevel() : *
      {
         super.startLevel();
         Game.gameData.setLife(1,"mul");
      }
      
      public function lifeBallTimer() : *
      {
         var rect0:Rectangle = null;
         var x0:int = 0;
         var y0:int = 0;
         var oneSence:OneSence = Game.oneScene;
         if(oneSence.lockB)
         {
            if(this.lifeBall_t >= 30)
            {
               this.lifeBall_t = 0;
               rect0 = oneSence.viewRangeRect2;
               x0 = rect0.x + 100 + (rect0.width - 100) * Math.random();
               y0 = Game.BGHit.getMinY(x0) - 1000;
               Game.itemsGroup.addAddBall("lifePer",Game.gameData.getLifePer(),x0,y0,Math.PI / 2);
            }
            else
            {
               this.lifeBall_t += 1 / 6;
            }
         }
      }
      
      override public function bodyAdd(b0:*) : *
      {
         super.bodyAdd(b0);
         if(this.nowExtraBoss != null)
         {
            this.nowExtraBoss.extraSkill.bodyAdd(b0);
         }
         if(b0.type == "boss")
         {
            this.nowExtraBoss = b0;
         }
      }
      
      override public function bodyDie(b0:*) : *
      {
         var level0:int = 0;
         var chipArr0:Array = null;
         var chipName0:String = null;
         super.bodyDie(b0);
         if(this.nowExtraBoss != null)
         {
            this.nowExtraBoss.extraSkill.bodyDie(b0);
            level0 = Game.LG.index;
            if(b0.type == "boss" || b0.define.name == "女妖战机")
            {
               if(Math.random() < 0.1)
               {
                  chipArr0 = [];
                  if(level0 == 2)
                  {
                     chipArr0 = ["ben","zhui"];
                  }
                  else if(level0 == 6)
                  {
                     chipArr0 = ["jing","zu"];
                  }
                  else if(level0 == 11)
                  {
                     chipArr0 = ["zhen","lie"];
                  }
                  if(chipArr0.length > 0)
                  {
                     chipName0 = chipArr0[int(chipArr0.length * Math.random())] + "_purple_chip";
                     Game.itemsGroup.dropAppointItems(this.nowExtraBoss,chipName0,3);
                  }
               }
            }
         }
      }
      
      override public function clear() : *
      {
         this.nowExtraBoss = null;
         super.clear();
      }
      
      override public function exitEvent() : *
      {
         if(this.nowExtraBoss != null)
         {
            if(this.nowExtraBoss.die > 0)
            {
               super.exitEvent();
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

