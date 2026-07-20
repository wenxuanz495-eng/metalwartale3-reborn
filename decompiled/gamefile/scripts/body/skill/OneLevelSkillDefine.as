package body.skill
{
   import data.ClassProperty;
   
   public class OneLevelSkillDefine
   {
      
      public static var pro_arr:Array = [];
      
      public var level:int = 1;
      
      public var maxNum:int = 0;
      
      public var maxTime:Number = 0;
      
      public var recoveryTime:Number = 100000;
      
      public var coolingTime:Number = 100000;
      
      public var hurt:Number = 0;
      
      public var mustLevel:int = 1;
      
      public var mustGcoin:int = 0;
      
      public var mustMcoin:int = 0;
      
      public function OneLevelSkillDefine()
      {
         super();
      }
      
      public function inData_byXML(xml0:XML) : *
      {
         if(String(xml0.maxNum) != "")
         {
            this.maxNum = int(xml0.maxNum);
         }
         if(String(xml0.maxTime) != "")
         {
            this.maxTime = Number(xml0.maxTime);
         }
         if(String(xml0.recoveryTime) != "")
         {
            this.recoveryTime = Number(xml0.recoveryTime);
         }
         if(String(xml0.coolingTime) != "")
         {
            this.coolingTime = Number(xml0.coolingTime);
         }
         if(String(xml0.hurt) != "")
         {
            this.hurt = Number(xml0.hurt);
         }
         if(String(xml0.mustLevel) != "")
         {
            this.mustLevel = int(xml0.mustLevel);
         }
         if(String(xml0.mustGcoin) != "")
         {
            this.mustGcoin = Number(xml0.mustGcoin);
         }
         if(String(xml0.mustMcoin) != "")
         {
            this.mustMcoin = Number(xml0.mustMcoin);
         }
      }
      
      public function inData_byObj(obj0:Object) : *
      {
         ClassProperty.inData(this,obj0,pro_arr);
      }
      
      public function copy() : OneLevelSkillDefine
      {
         var d0:OneLevelSkillDefine = new OneLevelSkillDefine();
         d0.inData_byObj(this);
         return d0;
      }
   }
}

