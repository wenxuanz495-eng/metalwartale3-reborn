package gameAll.level
{
   public class Level_3_1 extends GhostLevel
   {
      
      public function Level_3_1()
      {
         super();
      }
      
      override public function bodyAdd(b0:*) : *
      {
         super.bodyAdd(b0);
         if(b0.type == "boss")
         {
            if(b0.define.name == "虎鲨坦克")
            {
               b0.ai.skill.randomSkill(5);
            }
            else if(b0.define.name == "防卫卫星")
            {
               b0.ai.skill.randomSkill(4);
            }
            else if(b0.define.name == "渗透者")
            {
               b0.ai.skill.randomSkill(3);
            }
            Game.uiGroup.gamingUI.bossBarTarget = null;
            Game.uiGroup.gamingUI.bossBarTarget = b0;
         }
      }
   }
}

