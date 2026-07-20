package enemy.AI
{
   public class EnemySkill
   {
      
      public static var normalSkillName:Array = ["Clear_Energy","Hurt_Back","Strong_Defence","Skill_Laser","Strong_Hurt","Life_Reply","Strong_Life","Mines_Boom","Energy_Boom","Skill_Drop","Skill_Follow","Skill_Curve","Plasma"];
      
      public static var allName:Array = ["UnableAttack_Missile","Skill_Drop2","Skill_Laser2","Reduce_Missile","Fiexd_Mines","Forever_Lighting","Mines_Boom_2","Slow_Missile","Hurt_Back","Strong_Defence","Skill_Laser","Strong_Hurt","Life_Reply","Strong_Life","Mines_Boom","Energy_Boom","Skill_Drop","Skill_Follow","Skill_Curve","Plasma","BackPlasma"];
      
      public static var allCn:Array = ["缴械","随机落弹2","定向激光","减速球","定时地雷","闪电球","碾压者布雷","究极慢速导弹","伤害反弹","高能护甲","激光爆发","狂暴","自我复原","坚毅","布雷","能量爆发","弹性榴弹","跟踪弹","大型导弹","护盾","反弹护盾"];
      
      public static var allCD:Array = [15,4,5,20,5,1,2,10,100,100,4,100,3,100,4,2.5,4,5,5,3,3];
      
      public var baba:*;
      
      public var showSkillB:Boolean = true;
      
      public var strArr:Array = [];
      
      public var arr:Array = [];
      
      public var hurtBack:Number = 0;
      
      public var hurtDefence:Number = 0;
      
      public function EnemySkill(_baba:*)
      {
         super();
         this.baba = _baba;
      }
      
      public function clear() : *
      {
         this.hurtBack = 0;
         this.hurtDefence = 0;
         this.arr.length = 0;
      }
      
      public function randomSkill(num:int, noPlasmaB:Boolean = false) : *
      {
         var n:* = undefined;
         var ran0:int = 0;
         var arr2:Array = [];
         if(Boolean(this.getSkill_byLabel("BackPlasma")))
         {
            noPlasmaB = true;
         }
         var allName2:Array = [];
         for(n in normalSkillName)
         {
            allName2.push(normalSkillName[n]);
         }
         if(noPlasmaB)
         {
            allName2.pop();
         }
         for(var m:int = 0; m < num; m++)
         {
            if(allName2.length == 0)
            {
               break;
            }
            ran0 = Math.random() * allName2.length;
            arr2.push(allName2[ran0]);
            allName2.splice(ran0,1);
         }
         this.setSkillArr(arr2);
         return arr2;
      }
      
      public function setSkillArr(arr0:Array) : *
      {
         var n:* = undefined;
         var sd0:EnemySkillDefine = null;
         this.strArr = arr0;
         this.clear();
         for(n in arr0)
         {
            sd0 = new EnemySkillDefine(this.baba);
            sd0.label = arr0[n];
            this.arr.push(sd0);
            sd0.maxCD = int((Math.random() * 1 + allCD[allName.indexOf(sd0.label)]) * 30);
            sd0.nowCD = sd0.maxCD / 5 * 4;
            if(sd0.label == "Strong_Life")
            {
               sd0[sd0.label]();
               sd0.enabled = false;
            }
            else if(sd0.label == "Strong_Hurt")
            {
               sd0[sd0.label]();
               sd0.enabled = false;
            }
            else if(sd0.label == "Strong_Defence")
            {
               this.hurtDefence = 0.3;
               sd0.enabled = false;
            }
            else if(sd0.label == "Hurt_Back")
            {
               this.hurtBack = 0.03;
               sd0.enabled = false;
            }
         }
      }
      
      public function closeSkill(label0:String) : *
      {
         var sd0:EnemySkillDefine = this.getSkill_byLabel(label0);
         if(sd0 is EnemySkillDefine)
         {
            sd0.closeSkill();
         }
      }
      
      public function openSkill(label0:String) : *
      {
         var sd0:EnemySkillDefine = this.getSkill_byLabel(label0);
         if(sd0 is EnemySkillDefine)
         {
            sd0.openSkill();
         }
      }
      
      public function setMulHurt(label0:String, mulHurt0:Number) : *
      {
         var sd0:EnemySkillDefine = this.getSkill_byLabel(label0);
         if(sd0 is EnemySkillDefine)
         {
            sd0.mulHurt = mulHurt0;
         }
      }
      
      public function getSkill_byLabel(label0:String) : EnemySkillDefine
      {
         var n:* = undefined;
         var sd0:EnemySkillDefine = null;
         for(n in this.arr)
         {
            sd0 = this.arr[n];
            if(sd0.label == label0)
            {
               return sd0;
            }
         }
         return null;
      }
      
      public function getCn() : String
      {
         var n:* = undefined;
         var f0:int = 0;
         var str0:String = " ";
         if(!this.showSkillB)
         {
            return "";
         }
         for(n in this.strArr)
         {
            f0 = allName.indexOf(this.strArr[n]);
            if(f0 >= 0)
            {
               str0 += allCn[f0] + " ";
            }
         }
         return str0;
      }
      
      public function clearPlasma() : *
      {
         var n:* = undefined;
         var sd0:EnemySkillDefine = null;
         for(n in this.arr)
         {
            sd0 = this.arr[n];
            sd0.clearPlasma();
         }
      }
      
      public function skillTimer() : *
      {
         var n:* = undefined;
         var sd0:EnemySkillDefine = null;
         for(n in this.arr)
         {
            sd0 = this.arr[n];
            if(sd0.enabled)
            {
               sd0.happen();
            }
            if(sd0.label == "Plasma" || sd0.label == "BackPlasma")
            {
               if(sd0.plasma_mc != null)
               {
                  sd0.plasma_mc.x = this.baba.MX;
                  sd0.plasma_mc.y = this.baba.MY;
               }
            }
         }
      }
   }
}

