package gameAll.level
{
   public class Level_3_16 extends Levels
   {
      
      public var enemy6B:Boolean = false;
      
      public function Level_3_16()
      {
         super();
      }
      
      override public function startLevel() : *
      {
         super.startLevel();
         this.enemy6B = false;
      }
      
      override public function bodyAdd(b0:*) : *
      {
         super.bodyAdd(b0);
         if(b0.type == "champion" && this.enemy6B)
         {
            if(b0.define.name == "狂热者")
            {
               b0.define.maxLife = 0.3 * 100000000;
               b0.ai.skill.setSkillArr(["Strong_Defence","Skill_Laser","Strong_Hurt","Hurt_Back"]);
            }
            else if(b0.define.name == "投掷者")
            {
               b0.define.maxLife = 0.2 * 100000000;
               b0.ai.skill.setSkillArr(["EMP_5","Energy_Boom","Plasma","Mines_Boom"]);
            }
            else if(b0.define.name == "巡天者")
            {
               b0.define.maxLife = 0.4 * 100000000;
               b0.ai.skill.setSkillArr(["Life_Reply","Skill_Curve","Skill_Follow","Skill_Drop"]);
            }
            b0.define.mulLife();
            Game.uiGroup.gamingUI.bossBarTarget = null;
            Game.uiGroup.gamingUI.bossBarTarget = b0;
         }
      }
      
      override protected function hitAreaEvent(id0:String, isEventOrderDefineGroupB:Boolean = true) : *
      {
         super.hitAreaEvent(id0,isEventOrderDefineGroupB);
         if(id0 == "enemy6")
         {
            this.enemy6B = true;
         }
      }
   }
}

