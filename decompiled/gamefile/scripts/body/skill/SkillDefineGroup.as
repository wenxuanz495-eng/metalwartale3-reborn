package body.skill
{
   import data.ClassProperty;
   
   public class SkillDefineGroup
   {
      
      public var obj:Object = {};
      
      public var arr:Array = [];
      
      public function SkillDefineGroup()
      {
         super();
         OneLevelSkillDefine.pro_arr = ClassProperty.getProArr(new OneLevelSkillDefine());
      }
      
      public function inData_byXML(xml0:XML) : *
      {
         var n:* = undefined;
         var d0:SkillDefine = null;
         var skill_xml0:* = xml0.skill;
         for(n in skill_xml0)
         {
            d0 = new SkillDefine();
            d0.index = n;
            d0.inData_byXML(skill_xml0[n]);
            this.obj[d0.name] = d0;
            this.arr.push(d0);
         }
      }
      
      public function getDefine(name0:String) : SkillDefine
      {
         return this.obj[name0];
      }
      
      public function getOneLevelDefine(name0:String, lv0:int) : OneLevelSkillDefine
      {
         var d0:SkillDefine = this.getDefine(name0);
         if(Boolean(d0))
         {
            return d0.getLevel(lv0);
         }
         if(name0 == "jump")
         {
            return d0.getLevel(2);
         }
         return null;
      }
   }
}

