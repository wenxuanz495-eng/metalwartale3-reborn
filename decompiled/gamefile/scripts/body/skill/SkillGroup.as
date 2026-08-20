package body.skill
{
   public class SkillGroup
   {
      
      public var BB:*;
      
      public var enabled:Boolean = true;
      
      public var dataObj:Object;
      
      public var dataArr:Array;
      
      public function SkillGroup()
      {
         var n:* = undefined;
         var d0:SkillDefine = null;
         var da0:OneSkill = null;
         this.dataObj = {};
         this.dataArr = [];
         super();
         var skillG:SkillDefineGroup = Game.defineGroup.skill;
         for(n in skillG.arr)
         {
            d0 = skillG.arr[n];
            da0 = new OneSkill();
            da0.define = d0;
            da0.index = n;
            da0.initData_byDefine(d0.getLevel(1));
            this.dataObj[d0.name] = da0;
            this.dataArr.push(da0);
            if(d0.name == "plasma")
            {
               da0.timeCloseFun = this.plasmaCloseFun;
            }
         }
      }
      
      public function initSkillState() : *
      {
         var n:* = undefined;
         var s0:OneSkill = null;
         for(n in this.dataArr)
         {
            s0 = this.dataArr[n];
            s0.initData_byDefine(s0.levelDefine);
         }
      }
      
      public function getSkill(name0:String) : OneSkill
      {
         return this.dataObj[name0];
      }
      
      public function fleshSkillLevel(arr0:Array) : *
      {
         var n:* = undefined;
         var d0:SkillDefine = null;
         var l_d0:OneLevelSkillDefine = null;
         var da0:OneSkill = null;
         var d_arr0:Array = Game.defineGroup.skill.arr;
         for(n in arr0)
         {
            d0 = d_arr0[n];
            l_d0 = d0.getLevel(arr0[n]);
            if(Boolean(l_d0))
            {
               da0 = this.dataArr[n];
               da0.initData_byDefine(l_d0);
            }
         }
      }
      
      public function setSkillNum(arr0:Array) : *
      {
         var n:* = undefined;
         var name0:String = null;
         var d0:OneLevelSkillDefine = null;
         var da0:OneSkill = null;
         var name_arr0:Array = ["jump","rocket","plasma"];
         for(n in arr0)
         {
            name0 = name_arr0[n];
            d0 = Game.defineGroup.skill.getOneLevelDefine(name0,arr0[n]);
            da0 = this.dataObj[name0];
            da0.initData_byDefine(d0);
         }
      }
      
      private function plasmaCloseFun() : *
      {
         this.BB.closePlasma();
      }
      
      public function skillTimer() : *
      {
         var n:* = undefined;
         var s0:OneSkill = null;
         if(this.enabled)
         {
            for(n in this.dataArr)
            {
               s0 = this.dataArr[n];
               if(s0.define.name == "jump")
               {
                  continue;
               }
               s0.skillTimer();
               if(s0.define.name == "change")
               {
                  s0.time_t = this.BB.img.change_t;
               }
            }
         }
      }
   }
}

