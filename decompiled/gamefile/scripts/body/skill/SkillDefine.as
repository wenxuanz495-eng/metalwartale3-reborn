package body.skill
{
   public class SkillDefine
   {
      
      public var index:int = 0;
      
      public var name:String = "";
      
      public var cnName:String = "";
      
      public var skillType:String = "time";
      
      public var effectDescribe:String = "";
      
      public var key:String = "SPACE";
      
      public var keyEvent:String = "clickOpen";
      
      public var maxLevel:int = 0;
      
      public var arr:Array = [];
      
      public var defaultDefine:OneLevelSkillDefine = new OneLevelSkillDefine();
      
      public function SkillDefine()
      {
         super();
      }
      
      public function inData_byXML(xml0:XML) : *
      {
         var n:* = undefined;
         var d0:OneLevelSkillDefine = null;
         this.name = String(xml0.child("name"));
         this.cnName = String(xml0.cnName);
         this.maxLevel = int(xml0.maxLevel);
         this.key = String(xml0.key);
         this.keyEvent = String(xml0.keyEvent);
         this.skillType = String(xml0.skillType);
         this.effectDescribe = String(xml0.effectDescribe);
         this.defaultDefine.inData_byXML(xml0["default"][0]);
         if(this.skillType == "number")
         {
            this.defaultDefine.coolingTime = this.defaultDefine.recoveryTime;
         }
         var level_xml0:* = xml0.level;
         for(n in level_xml0)
         {
            d0 = this.defaultDefine.copy();
            d0.level = int(n) + 1;
            if(this.skillType == "number")
            {
               d0.coolingTime = d0.recoveryTime;
            }
            d0.inData_byXML(level_xml0[n]);
            this.arr.push(d0);
         }
      }
      
      public function getLevel(lv0:int) : OneLevelSkillDefine
      {
         var d0:OneLevelSkillDefine = null;
         if(lv0 > this.maxLevel)
         {
            return null;
         }
         if(lv0 - 1 < 0)
         {
            return new OneLevelSkillDefine();
         }
         d0 = this.arr[lv0 - 1];
         if(Boolean(d0))
         {
            return d0;
         }
         return this.defaultDefine;
      }
      
      public function getEffectDescribe_level(lv0:int) : String
      {
         var d0:OneLevelSkillDefine = this.getLevel(lv0);
         if(Boolean(d0))
         {
            if(lv0 <= 0)
            {
               return "无";
            }
            return this.getEffectDescribe(d0);
         }
         return "已经是最高等级";
      }
      
      public function getEffectDescribe(d0:OneLevelSkillDefine) : String
      {
         var n:* = undefined;
         var str1:String = null;
         var arr0:Array = this.effectDescribe.split("\"");
         var str0:String = "";
         for(n in arr0)
         {
            str1 = arr0[n];
            if(n % 2 == 0)
            {
               str0 += str1;
            }
            else
            {
               str0 += d0[str1];
            }
         }
         return str0.replace("\\n ","\n");
      }
   }
}

