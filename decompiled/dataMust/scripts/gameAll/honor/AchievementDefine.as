package gameAll.honor
{
   public class AchievementDefine
   {
      
      public var bigNameArr:Array = ["normal","war"];
      
      public var bigCnNameArr:Array = ["普通成就","战斗成就","任务成就","副本成就"];
      
      public var normalListArr:Array = [["lv","等级"],["dps","战斗力"]];
      
      public var warListArr:Array = [["enemy","杀怪"],["level","关卡"]];
      
      public var taskListArr:Array = [["task","每日任务"],["challenge","挑战任务"],["collect","收集任务"]];
      
      public var extraListArr:Array = [["extra","副本"]];
      
      public var lv_arr:Array = [];
      
      public var dps_arr:Array = [];
      
      public var enemy_arr:Array = [];
      
      public var level_arr:Array = [];
      
      public function AchievementDefine()
      {
         super();
         this.add_lv();
         this.add_dps();
         this.add_enemy();
         this.add_level();
      }
      
      public function getDefine(param1:String, param2:String) : AchievementOneDefine
      {
         var _loc4_:Array = null;
         var _loc5_:* = undefined;
         var _loc6_:AchievementOneDefine = null;
         var _loc3_:String = param1 + "_arr";
         if(this.hasOwnProperty(_loc3_))
         {
            _loc4_ = this[_loc3_];
            for(_loc5_ in _loc4_)
            {
               _loc6_ = _loc4_[_loc5_];
               if(_loc6_.name == param2)
               {
                  return _loc6_;
               }
            }
         }
         return null;
      }
      
      public function getAllPoint() : Number
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:AchievementOneDefine = null;
         var _loc1_:Number = 0;
         var _loc2_:Array = [this.lv_arr,this.dps_arr,this.enemy_arr,this.level_arr];
         for(_loc3_ in _loc2_)
         {
            for(_loc4_ in _loc2_[_loc3_])
            {
               _loc5_ = _loc2_[_loc3_][_loc4_];
               _loc1_ += _loc5_.acValue;
            }
         }
         return _loc1_;
      }
      
      private function add_lv() : *
      {
         var _loc1_:AchievementOneDefine = null;
         var _loc2_:String = "";
         var _loc3_:Array = [];
         _loc2_ = "lv";
         _loc1_ = new AchievementOneDefine();
         _loc1_.type = _loc2_;
         _loc1_.name = "lv_10";
         _loc1_.cnName = "10级";
         _loc1_.info = "人物等级到达10级";
         _loc1_.must = "10";
         _loc3_ = [];
         _loc1_.giftArr = _loc3_;
         this[_loc2_ + "_arr"].push(_loc1_);
         _loc1_ = new AchievementOneDefine();
         _loc1_.type = _loc2_;
         _loc1_.name = "lv_20";
         _loc1_.cnName = "20级";
         _loc1_.info = "人物等级到达20级";
         _loc1_.must = "20";
         _loc3_ = [];
         _loc1_.giftArr = _loc3_;
         this[_loc2_ + "_arr"].push(_loc1_);
         _loc1_ = new AchievementOneDefine();
         _loc1_.type = _loc2_;
         _loc1_.name = "lv_30";
         _loc1_.cnName = "30级";
         _loc1_.info = "人物等级到达30级";
         _loc1_.must = "30";
         _loc3_ = [];
         _loc1_.giftArr = _loc3_;
         this[_loc2_ + "_arr"].push(_loc1_);
         _loc1_ = new AchievementOneDefine();
         _loc1_.type = _loc2_;
         _loc1_.name = "lv_40";
         _loc1_.cnName = "40级";
         _loc1_.info = "人物等级到达40级";
         _loc1_.must = "40";
         _loc3_ = [];
         _loc1_.giftArr = _loc3_;
         this[_loc2_ + "_arr"].push(_loc1_);
         _loc1_ = new AchievementOneDefine();
         _loc1_.type = _loc2_;
         _loc1_.name = "lv_50";
         _loc1_.cnName = "50级";
         _loc1_.info = "人物等级到达50级";
         _loc1_.must = "50";
         _loc3_ = [];
         _loc1_.giftArr = _loc3_;
         this[_loc2_ + "_arr"].push(_loc1_);
         _loc1_ = new AchievementOneDefine();
         _loc1_.type = _loc2_;
         _loc1_.name = "lv_60";
         _loc1_.cnName = "60级";
         _loc1_.info = "人物等级到达60级";
         _loc1_.must = "60";
         _loc3_ = [];
         _loc1_.giftArr = _loc3_;
         this[_loc2_ + "_arr"].push(_loc1_);
         _loc1_ = new AchievementOneDefine();
         _loc1_.type = _loc2_;
         _loc1_.name = "lv_70";
         _loc1_.cnName = "70级";
         _loc1_.info = "人物等级到达70级";
         _loc1_.honor = "lv_70";
         _loc1_.must = "70";
         _loc3_ = [];
         _loc1_.giftArr = _loc3_;
         this[_loc2_ + "_arr"].push(_loc1_);
      }
      
      private function add_dps() : *
      {
         var _loc1_:AchievementOneDefine = null;
         var _loc2_:String = "";
         var _loc3_:Array = [];
         _loc2_ = "dps";
         _loc1_ = new AchievementOneDefine();
         _loc1_.type = _loc2_;
         _loc1_.name = "dps_5000";
         _loc1_.cnName = "战斗力五千";
         _loc1_.info = "人物战斗力到达5000";
         _loc1_.must = "5000";
         _loc3_ = [];
         _loc1_.giftArr = _loc3_;
         this[_loc2_ + "_arr"].push(_loc1_);
         _loc1_ = new AchievementOneDefine();
         _loc1_.type = _loc2_;
         _loc1_.name = "dps_1w";
         _loc1_.cnName = "战斗力一万";
         _loc1_.info = "人物战斗力到达10000";
         _loc1_.must = "10000";
         _loc3_ = [];
         _loc1_.giftArr = _loc3_;
         this[_loc2_ + "_arr"].push(_loc1_);
         _loc1_ = new AchievementOneDefine();
         _loc1_.type = _loc2_;
         _loc1_.name = "dps_5w";
         _loc1_.cnName = "战斗力五万";
         _loc1_.info = "人物战斗力到达50000";
         _loc1_.must = "50000";
         _loc3_ = [];
         _loc1_.giftArr = _loc3_;
         this[_loc2_ + "_arr"].push(_loc1_);
         _loc1_ = new AchievementOneDefine();
         _loc1_.type = _loc2_;
         _loc1_.name = "dps_10w";
         _loc1_.cnName = "战斗力十万";
         _loc1_.info = "人物战斗力到达100000";
         _loc1_.must = "100000";
         _loc3_ = [];
         _loc1_.giftArr = _loc3_;
         this[_loc2_ + "_arr"].push(_loc1_);
         _loc1_ = new AchievementOneDefine();
         _loc1_.type = _loc2_;
         _loc1_.name = "dps_20w";
         _loc1_.cnName = "战斗力二十万";
         _loc1_.info = "人物战斗力到达200000";
         _loc1_.must = "200000";
         _loc3_ = [];
         _loc1_.giftArr = _loc3_;
         this[_loc2_ + "_arr"].push(_loc1_);
         _loc1_ = new AchievementOneDefine();
         _loc1_.type = _loc2_;
         _loc1_.name = "dps_50w";
         _loc1_.cnName = "战斗力五十万";
         _loc1_.info = "人物战斗力到达500000";
         _loc1_.must = "500000";
         _loc3_ = [];
         _loc1_.giftArr = _loc3_;
         this[_loc2_ + "_arr"].push(_loc1_);
         _loc1_ = new AchievementOneDefine();
         _loc1_.type = _loc2_;
         _loc1_.name = "dps_100w";
         _loc1_.cnName = "战斗力一百万";
         _loc1_.info = "人物战斗力到达1000000";
         _loc1_.must = "1000000";
         _loc3_ = [];
         _loc1_.giftArr = _loc3_;
         this[_loc2_ + "_arr"].push(_loc1_);
         _loc1_ = new AchievementOneDefine();
         _loc1_.type = _loc2_;
         _loc1_.name = "dps_200w";
         _loc1_.cnName = "战斗力两百万";
         _loc1_.info = "人物战斗力到达2000000";
         _loc1_.must = "2000000";
         _loc3_ = [];
         _loc1_.giftArr = _loc3_;
         this[_loc2_ + "_arr"].push(_loc1_);
      }
      
      private function add_enemy() : *
      {
         var _loc1_:AchievementOneDefine = null;
         var _loc2_:String = "";
         var _loc3_:Array = [];
         _loc2_ = "enemy";
         _loc1_ = new AchievementOneDefine();
         _loc1_.type = _loc2_;
         _loc1_.name = "enemy_1";
         _loc1_.cnName = "击杀！一";
         _loc1_.info = "击杀一只怪物";
         _loc1_.must = "1";
         _loc3_ = [];
         _loc1_.giftArr = _loc3_;
         this[_loc2_ + "_arr"].push(_loc1_);
         _loc1_ = new AchievementOneDefine();
         _loc1_.type = _loc2_;
         _loc1_.name = "enemy_100";
         _loc1_.cnName = "击杀！一百";
         _loc1_.info = "击杀一百只怪物";
         _loc1_.must = "100";
         _loc3_ = [];
         _loc1_.giftArr = _loc3_;
         this[_loc2_ + "_arr"].push(_loc1_);
         _loc1_ = new AchievementOneDefine();
         _loc1_.type = _loc2_;
         _loc1_.name = "enemy_1000";
         _loc1_.cnName = "击杀！一千";
         _loc1_.info = "击杀一千只怪物";
         _loc1_.must = "1000";
         _loc3_ = [];
         _loc1_.giftArr = _loc3_;
         this[_loc2_ + "_arr"].push(_loc1_);
         _loc1_ = new AchievementOneDefine();
         _loc1_.type = _loc2_;
         _loc1_.name = "enemy_1w";
         _loc1_.cnName = "击杀！一万";
         _loc1_.info = "击杀一万只怪物";
         _loc1_.must = "10000";
         _loc3_ = [];
         _loc1_.giftArr = _loc3_;
         this[_loc2_ + "_arr"].push(_loc1_);
         _loc1_ = new AchievementOneDefine();
         _loc1_.type = _loc2_;
         _loc1_.name = "enemy_10w";
         _loc1_.cnName = "击杀！十万";
         _loc1_.info = "击杀十万只怪物";
         _loc1_.must = "100000";
         _loc1_.honor = "enemy_10w";
         _loc3_ = [];
         _loc1_.giftArr = _loc3_;
         this[_loc2_ + "_arr"].push(_loc1_);
      }
      
      private function add_level() : *
      {
         var _loc1_:AchievementOneDefine = null;
         var _loc2_:String = "";
         var _loc3_:Array = [];
         _loc2_ = "level";
         _loc1_ = new AchievementOneDefine();
         _loc1_.type = _loc2_;
         _loc1_.name = "level_0";
         _loc1_.cnName = "通关！南部战争（普通）";
         _loc1_.info = "完成普通难度“第四章决战月都”";
         _loc1_.must = "0_31";
         _loc3_ = [];
         _loc1_.giftArr = _loc3_;
         this[_loc2_ + "_arr"].push(_loc1_);
         _loc1_ = new AchievementOneDefine();
         _loc1_.type = _loc2_;
         _loc1_.name = "level_1";
         _loc1_.cnName = "通关！南部战争（噩梦）";
         _loc1_.info = "完成噩梦难度“第四章决战月都”";
         _loc1_.must = "1_31";
         _loc3_ = [];
         _loc1_.giftArr = _loc3_;
         this[_loc2_ + "_arr"].push(_loc1_);
         _loc1_ = new AchievementOneDefine();
         _loc1_.type = _loc2_;
         _loc1_.name = "level_2";
         _loc1_.cnName = "通关！南部战争（地狱）";
         _loc1_.info = "完成地狱难度“第四章决战月都”";
         _loc1_.must = "2_31";
         _loc3_ = [];
         _loc1_.giftArr = _loc3_;
         this[_loc2_ + "_arr"].push(_loc1_);
         _loc1_ = new AchievementOneDefine();
         _loc1_.type = _loc2_;
         _loc1_.name = "level_3";
         _loc1_.cnName = "通关！南部战争（炼狱）";
         _loc1_.info = "完成炼狱难度“第四章决战月都”";
         _loc1_.must = "3_31";
         _loc3_ = [];
         _loc1_.giftArr = _loc3_;
         this[_loc2_ + "_arr"].push(_loc1_);
         _loc1_ = new AchievementOneDefine();
         _loc1_.type = _loc2_;
         _loc1_.name = "level_4";
         _loc1_.cnName = "通关！决战先知（普通）";
         _loc1_.info = "完成普通难度“第一章浴血奋战”";
         _loc1_.must = "4_7";
         _loc3_ = [];
         _loc1_.giftArr = _loc3_;
         this[_loc2_ + "_arr"].push(_loc1_);
         _loc1_ = new AchievementOneDefine();
         _loc1_.type = _loc2_;
         _loc1_.name = "level_5";
         _loc1_.cnName = "通关！决战先知（噩梦）";
         _loc1_.info = "完成噩梦难度“第一章浴血奋战”";
         _loc1_.must = "5_7";
         _loc3_ = [];
         _loc1_.giftArr = _loc3_;
         this[_loc2_ + "_arr"].push(_loc1_);
         _loc1_ = new AchievementOneDefine();
         _loc1_.type = _loc2_;
         _loc1_.name = "level_6";
         _loc1_.cnName = "通关！决战先知（地狱）";
         _loc1_.info = "完成地狱难度“第一章浴血奋战”";
         _loc1_.must = "6_7";
         _loc3_ = [];
         _loc1_.giftArr = _loc3_;
         this[_loc2_ + "_arr"].push(_loc1_);
         _loc1_ = new AchievementOneDefine();
         _loc1_.type = _loc2_;
         _loc1_.name = "level_7";
         _loc1_.cnName = "通关！决战先知（炼狱）";
         _loc1_.info = "完成炼狱难度“第一章浴血奋战”";
         _loc1_.must = "7_7";
         _loc3_ = [];
         _loc1_.giftArr = _loc3_;
         this[_loc2_ + "_arr"].push(_loc1_);
      }
   }
}

