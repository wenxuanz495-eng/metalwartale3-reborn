package gameAll.level
{
   public class Level_2_9 extends Levels
   {
      
      public var now_d:int = 0;
      
      public function Level_2_9()
      {
         super();
      }
      
      override public function startLevel() : *
      {
         super.startLevel();
         this.addUnit(0);
         this.addUnit(0);
         this.addUnit(1);
         this.addUnit(1);
      }
      
      public function addUnit(num0:int) : *
      {
         var b0:Object = null;
         if(num0 == 0)
         {
            b0 = Game.BG.addTank2("we");
            b0.setLevel(50);
            b0.define.maxLife = 250000;
            b0.define.hurt_0 = 10000;
            b0.x = hero.img.x + 200 + Math.random() * 200;
            b0.y = hero.img.y;
         }
         else
         {
            b0 = Game.BG.addFalconFighter("we");
            b0.setLevel(50);
            b0.define.maxLife = 300000;
            b0.define.hurt_0 = 15000;
            b0.x = hero.img.x + 200 + Math.random() * 200;
            b0.y = hero.img.y - 200 + Math.random() * 50;
         }
         var d_ra:Number = Game.LG.filter.getDifficultRaNow();
         b0.define.maxLife *= d_ra;
         b0.define.hurt_0 *= d_ra;
         b0.define.mulLife();
         b0.we_AI.enabled = true;
         b0.ai.hoverBody = hero;
         Game.BG.addLifeBar(b0,1);
         b0.img.colorF2 = Game.gameDefine.weEnemyColor;
         b0.img.hurtEffectHide();
         trace("坦克坐标：：：" + b0.img.x + "   " + b0.img.y);
      }
      
      override public function bodyAdd(b0:*) : *
      {
         var str0:String = null;
         super.bodyAdd(b0);
         if(b0.define.name == "蜘蛛炮台" || b0.define.name == "追踪者")
         {
            if(this.now_d == 0)
            {
               this.now_d = 1;
               str0 = Game.gameDefine.dialogue.text["k1_7_2"];
               Game.dialogboxGroup.showDialog(BG.weLand_arr[0],str0,null,3);
            }
         }
         else if(b0.define.name == "圣堂战机" || b0.define.name == "悬浮自动激光炮台")
         {
            if(this.now_d == 1)
            {
               this.now_d = 2;
               str0 = Game.gameDefine.dialogue.text["k1_7_4"];
               Game.dialogboxGroup.showDialog(BG.weAir_arr[0],str0,null,3);
            }
         }
      }
   }
}

