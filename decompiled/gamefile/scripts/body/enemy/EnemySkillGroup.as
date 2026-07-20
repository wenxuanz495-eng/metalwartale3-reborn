package body.enemy
{
   import body.skill.SkillGroup;
   
   public class EnemySkillGroup extends SkillGroup
   {
      
      public function EnemySkillGroup()
      {
         super();
         fleshSkillLevel([1,1,1,1,1]);
      }
   }
}

