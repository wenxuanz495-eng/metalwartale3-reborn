package enemy.twogun
{
   import enemy.AI.EnemySkillDefine;
   import enemy.AI.Enemy_AI;
   
   public class Twogun_AI extends Enemy_AI
   {
      
      public var nowArmsIndex:int = 0;
      
      public var skill_list:Array = [0,0,3,0,0,2,0,4,0,1];
      
      public var nowIndex:int = 0;
      
      public function Twogun_AI(_baba:*)
      {
         super(_baba);
      }
      
      override protected function attackOrder() : *
      {
         super.attackOrder();
         trace("当前攻击命令：" + this.nowArmsIndex);
         if(this.nowArmsIndex == 4)
         {
            baba.define.addLifePer(0.1);
            trace("补血！！！！！");
         }
         var d0:EnemySkillDefine = skill.getSkill_byLabel("Plasma");
         if(!d0)
         {
            skill.setSkillArr(["Plasma"]);
            d0 = skill.getSkill_byLabel("Plasma");
            d0.maxCD = 15 * 30;
         }
      }
      
      override protected function attackOver() : *
      {
         this.nowIndex = (this.nowIndex + 1) % this.skill_list.length;
         var index0:int = int(this.skill_list[this.nowIndex]);
         baba.armsDefine.inData(armsName,index0);
         this.nowArmsIndex = index0;
         if(index0 == 0 || index0 == 3)
         {
            if(Math.random() < 0.5)
            {
               baba.armsDefine.hurtArr = [9999999999];
               trace("启动绝杀！！！");
            }
         }
         baba.img.goPlayLoop("stand");
         super.attackOver();
      }
      
      override protected function reachTarget() : *
      {
         followFilp();
         baba.mot.stopFollow();
      }
      
      override public function attackAI() : *
      {
         super.attackAI();
         var d0:EnemySkillDefine = skill.getSkill_byLabel("Plasma");
         skill.hurtBack = 0;
         baba.hitHurtB = 0;
         skill.hurtDefence = 0;
         if(plasmaB)
         {
            skill.hurtBack = 1;
            skill.hurtDefence = 1;
         }
      }
   }
}

