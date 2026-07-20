package gameAll.level.extra
{
   import gameAll.level.Levels;
   
   public class JuneExtraLevel extends Levels
   {
      
      public function JuneExtraLevel()
      {
         super();
      }
      
      override public function startLevel() : *
      {
         super.startLevel();
         Game.uiGroup.saveDataNoUI();
      }
      
      override public function bodyAdd(b0:*) : *
      {
         var lv0:int = 0;
         super.bodyAdd(b0);
         if(b0.type == "boss")
         {
            lv0 = Game.gameData.level + 1;
            b0.define.level = Game.gameData.level;
            b0.define.maxLife = Game.LG.filter.getEnemyLevelDefine(lv0 - 1).baseLife;
            trace("b0.define.level：" + b0.define.level);
            trace("b0.define.maxLife：" + b0.define.maxLife);
            if(lv0 < 49)
            {
               b0.define.maxLife *= 100;
            }
            else if(lv0 < 59)
            {
               b0.define.maxLife *= 150;
            }
            else if(lv0 < 69)
            {
               b0.define.maxLife *= 200;
            }
            else if(lv0 < 79)
            {
               b0.define.maxLife *= 500;
            }
            else
            {
               b0.define.maxLife *= 800;
            }
            trace("b0.define.maxLife：" + b0.define.maxLife);
            b0.define.mulLife();
         }
      }
      
      override public function bodyDie(b0:*) : *
      {
         var chipArr0:Array = null;
         var level0:int = 0;
         var lv0:int = 0;
         var chipName0:String = null;
         super.bodyDie(b0);
         if(b0.type == "boss")
         {
            if(Math.random() <= 0.1)
            {
               chipArr0 = [];
               level0 = b0.define.level + 1;
               lv0 = level0;
               if(lv0 < 39)
               {
                  chipArr0 = ["ben","zhui"];
               }
               else if(lv0 < 59)
               {
                  chipArr0 = ["jing","zu"];
               }
               else if(lv0 < 79)
               {
                  chipArr0 = ["zhen","lie"];
               }
               else if(lv0 < 99)
               {
                  chipArr0 = ["nu","kuang"];
               }
               if(chipArr0.length > 0)
               {
                  chipName0 = chipArr0[int(chipArr0.length * Math.random())] + "_purple_chip";
                  Game.itemsGroup.dropAppointItems(b0,chipName0,3);
               }
            }
         }
      }
   }
}

