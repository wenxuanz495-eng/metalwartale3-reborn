package enemy.charger
{
   import enemy.AI.EnemySkillDefine;
   import enemy.AI.ExtraSkill;
   
   public class Charger_ExtraSkill extends ExtraSkill
   {
      
      public function Charger_ExtraSkill(_baba:*)
      {
         super(_baba);
      }
      
      override public function init() : *
      {
         super.init();
         skill.setSkillArr(["EMP_5","Slow_Missile","Plasma"]);
         skill.closeSkill("Slow_Missile");
         skill.closeSkill("Plasma");
      }
      
      public function phase_1() : *
      {
         var _loc1_:EnemySkillDefine = null;
      }
      
      public function phase_2() : *
      {
         var _loc1_:EnemySkillDefine = null;
      }
      
      public function phase_3() : *
      {
      }
   }
}

