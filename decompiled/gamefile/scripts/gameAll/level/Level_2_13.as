package gameAll.level
{
   public class Level_2_13 extends Levels
   {
      
      public function Level_2_13()
      {
         super();
      }
      
      override public function bodyAdd(b0:*) : *
      {
         super.bodyAdd(b0);
         if(b0.type == "boss")
         {
            b0.ai.skill.randomSkill(3,true);
            Game.uiGroup.gamingUI.bossBarTarget = null;
            Game.uiGroup.gamingUI.bossBarTarget = b0;
            b0.define.exp *= 0.5;
         }
      }
   }
}

