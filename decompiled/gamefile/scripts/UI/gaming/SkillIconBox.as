package UI.gaming
{
   import body.skill.*;
   import flash.display.Sprite;
   
   public class SkillIconBox extends Sprite
   {
      
      public var arr:Array = [];
      
      public function SkillIconBox()
      {
         super();
         this.initIcon();
      }
      
      public function initIcon() : *
      {
         var n:* = undefined;
         var d0:SkillDefine = null;
         var i0:SkillIcon = null;
         var skillG:SkillDefineGroup = Game.defineGroup.skill;
         var arr0:Array = skillG.arr;
         for(n in arr0)
         {
            d0 = arr0[n];
            i0 = new SkillIcon();
            if(d0.name != "jump")
            {
               i0.init(d0);
               i0.x = n * 67;
               i0.y = 0;
               addChild(i0);
            }
            this.arr.push(i0);
         }
      }
      
      public function fleshData() : *
      {
         var n:* = undefined;
         var i0:SkillIcon = null;
         var s0:OneSkill = null;
         var arr1:Array = Game.BG.hero.skill.dataArr;
         for(n in this.arr)
         {
            i0 = this.arr[n];
            s0 = arr1[n];
            i0.inData(s0);
         }
      }
   }
}

