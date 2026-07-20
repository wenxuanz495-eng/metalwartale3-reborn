package gameAll.level
{
   public class Level_2_10 extends Levels
   {
      
      public var fabingB:Boolean = false;
      
      public function Level_2_10()
      {
         super();
      }
      
      override public function startLevel() : *
      {
         super.startLevel();
         this.fabingB = false;
         this.addUnit(0);
      }
      
      public function addUnit(num0:int) : *
      {
         var b0:* = undefined;
         var d_ra:Number = NaN;
         if(num0 == 0)
         {
            b0 = Game.BG.addEngineers();
            b0.setLevel(50);
            d_ra = Game.LG.filter.getDifficultRaNow();
            b0.define.maxLife = 5000000;
            b0.define.hurt_0 = 1000;
            b0.define.maxLife *= d_ra;
            b0.define.hurt_0 *= d_ra;
            b0.define.mulLife();
            b0.x = hero.img.x + 200 + Math.random() * 200;
            b0.y = hero.img.y;
         }
         b0.we_AI.enabled = true;
         b0.ai.hoverBody = hero;
         Game.BG.addLifeBar(b0,1);
      }
      
      override protected function hitAreaEvent(id0:String, isEventOrderDefineGroupB:Boolean = true) : *
      {
         var str0:* = undefined;
         super.hitAreaEvent(id0,isEventOrderDefineGroupB);
         if(id0 == "enemy1")
         {
            this.fabingB = true;
            str0 = Game.gameDefine.dialogue.text["k1_8_1"];
            Game.dialogboxGroup.showDialog(BG.weLand_arr[0],str0,null,4);
         }
      }
      
      override public function bodyDie(b0:*) : *
      {
         super.bodyDie(b0);
         if(b0.define.name == "工程兵")
         {
            Game.eventGroup.noUseRebirthCrystal();
         }
      }
      
      override public function unlockView() : *
      {
         var str0:* = undefined;
         super.unlockView();
         if(this.fabingB)
         {
            if(BG.weLand_arr.length >= 1)
            {
               str0 = Game.gameDefine.dialogue.text["k1_8_2"];
               Game.dialogboxGroup.showDialog(BG.weLand_arr[0],str0,null,3);
            }
         }
      }
   }
}

