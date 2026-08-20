package gameAll.data
{
   import UI.helper.HelperContextBarDefine;
   import body.skill.OneLevelSkillDefine;
   import body.skill.SkillDefine;
   import data.StringToDefine;
   import data.TextWay;
   
   public class PlayerData
   {
      
      public var lifeAdd:TrainAddData = new TrainAddData();
      
      public var attackAdd:TrainAddData = new TrainAddData();
      
      public var subAdd:TrainAddData = new TrainAddData();
      
      public var defenceAdd:TrainAddData = new TrainAddData();
      
      public var allAdd:TrainAddData = new TrainAddData();
      
      public var skillArr:Array = [];
      
      public function PlayerData()
      {
         super();
         this.setFullSkillArr([0,0,0,0,0]);
         this.lifeAdd.baseItems = "blue_capsule";
         this.lifeAdd.cnName = "体能训练";
         this.lifeAdd.upgradeB = true;
         this.attackAdd.baseItems = "red_capsule";
         this.attackAdd.cnName = "射击训练";
         this.attackAdd.upgradeB = true;
         this.subAdd.baseItems = "yellow_capsule";
         this.subAdd.cnName = "控制训练";
         this.subAdd.upgradeB = true;
         this.defenceAdd.baseItems = "green_capsule";
         this.defenceAdd.cnName = "防御训练";
         this.defenceAdd.upgradeB = true;
         this.allAdd.upgradeB = true;
         this.allAdd.cnName = "全能训练";
         this.allAdd.type = "all";
      }
      
      public function init() : *
      {
         this.initSkillArr();
         this.lifeAdd.init();
         this.attackAdd.init();
         this.subAdd.init();
         this.defenceAdd.init();
         this.allAdd.init();
      }
      
      public function inData_byObj(obj:*) : *
      {
         var n:* = undefined;
         var pro0:String = null;
         var d_arr0:Array = null;
         var str0:String = null;
         var skill0:SkillDefine = null;
         var pro_arr:Array = ["allAdd","lifeAdd","attackAdd","subAdd","defenceAdd"];
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            this[pro0].inData_byObj(obj[pro0]);
         }
         this.skillArr = [];
         if(Boolean(obj.hasOwnProperty("skillArr")))
         {
            d_arr0 = Game.defineGroup.skill.arr;
            for(n in d_arr0)
            {
               skill0 = d_arr0[n];
               str0 = obj.skillArr[n];
               if(Boolean(str0))
               {
                  this.skillArr.push(str0);
               }
               else
               {
                  this.skillArr.push(TextWay.toCode("0"));
               }
            }
         }
         else
         {
            this.initSkillArr();
            if(Boolean(obj.hasOwnProperty("jumpAdd")))
            {
               this.setSkillLevel("rocket",obj.rocketAdd.level);
               this.setSkillLevel("plasma",obj.plasmaAdd.level);
            }
         }
      }
      
      private function initSkillArr() : *
      {
         var n:* = undefined;
         var skill0:SkillDefine = null;
         var d_arr0:Array = Game.defineGroup.skill.arr;
         this.skillArr = [];
         for(n in d_arr0)
         {
            skill0 = d_arr0[n];
            this.skillArr.push(TextWay.toCode("0"));
         }
      }
      
      public function getFullSkillArr() : Array
      {
         var n:* = undefined;
         var arr1:Array = [];
         for(n in this.skillArr)
         {
            arr1.push(int(TextWay.getText(this.skillArr[n])));
         }
         return arr1;
      }
      
      public function setFullSkillArr(arr0:Array) : *
      {
         var n:* = undefined;
         for(n in arr0)
         {
            this.skillArr[n] = TextWay.toCode(arr0[n]);
         }
      }
      
      public function getSkillLevel(name0:String) : int
      {
         var d0:SkillDefine = Game.defineGroup.skill.obj[name0];
         var index0:int = d0.index;
         return this.getFullSkillArr()[index0];
      }
      
      public function setSkillLevel(name0:String, lv0:int) : *
      {
         var d0:SkillDefine = Game.defineGroup.skill.obj[name0];
         var index0:int = d0.index;
         this.skillArr[index0] = TextWay.toCode(String(lv0));
      }
      
      public function skillLevelUp(name0:String) : *
      {
         var d0:SkillDefine = Game.defineGroup.skill.obj[name0];
         var index0:int = d0.index;
         var lv0:int = int(TextWay.getText(this.skillArr[index0]));
         trace("升级技能：" + name0 + "   lv:" + lv0);
         trace("最大等级：" + d0.maxLevel);
         if(lv0 < d0.maxLevel)
         {
            this.skillArr[index0] = TextWay.toCode(String(lv0 + 1));
         }
         trace("升级后：" + this.getFullSkillArr());
      }
      
      public function upLevelTo50() : *
      {
         var n:* = undefined;
         var add0:TrainAddData = null;
         var m:int = 0;
         var pro_arr:Array = ["lifeAdd","attackAdd","subAdd","defenceAdd"];
         for(n in pro_arr)
         {
            add0 = this[pro_arr[n]];
            for(m = 0; m < 50; m++)
            {
               add0.levelUp();
            }
         }
      }
      
      public function zuobiPan() : Boolean
      {
         var n:* = undefined;
         var _loc3_:TrainAddData = null;
         return false;
      }
      
      public function getHelperContextBarDefine() : Array
      {
         var n:* = undefined;
         var d0:SkillDefine = null;
         var lv0:int = 0;
         var l_d0:OneLevelSkillDefine = null;
         var hd0:HelperContextBarDefine = null;
         var name0:String = null;
         var darr:Array = [];
         var arr0:Array = Game.defineGroup.skill.arr;
         for(n in arr0)
         {
            d0 = arr0[n];
            if(d0.name != "jump")
            {
               lv0 = int(TextWay.getText(this.skillArr[n]));
               l_d0 = d0.getLevel(lv0);
               if(l_d0.mustLevel <= Game.gameData.level + 1 && lv0 < d0.maxLevel)
               {
                  hd0 = new HelperContextBarDefine();
                  name0 = d0.name;
                  hd0.title = "技能学习";
                  hd0.context = "可学习新技能：" + StringToDefine.getFontColor(d0.cnName + "第" + (lv0 + 1) + "级","#FFFF00");
                  hd0.iconLabel = "parts/" + name0 + "_lv" + (lv0 > 11 ? 12 : lv0 + 1);
                  hd0.gotoTarget = "skill/" + name0;
                  darr.push(hd0);
               }
            }
         }
         return darr;
      }
   }
}

