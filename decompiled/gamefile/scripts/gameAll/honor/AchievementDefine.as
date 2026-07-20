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
      
      public function getDefine(type0:String, name0:String) : AchievementOneDefine
      {
         var arr0:Array = null;
         var n:* = undefined;
         var d0:AchievementOneDefine = null;
         var arr_name0:String = type0 + "_arr";
         if(this.hasOwnProperty(arr_name0))
         {
            arr0 = this[arr_name0];
            for(n in arr0)
            {
               d0 = arr0[n];
               if(d0.name == name0)
               {
                  return d0;
               }
            }
         }
         return null;
      }
      
      public function getAllPoint() : Number
      {
         var n:* = undefined;
         var i:* = undefined;
         var d0:AchievementOneDefine = null;
         var num0:Number = 0;
         var arr0:Array = [this.lv_arr,this.dps_arr,this.enemy_arr,this.level_arr];
         for(n in arr0)
         {
            for(i in arr0[n])
            {
               d0 = arr0[n][i];
               num0 += d0.acValue;
            }
         }
         return num0;
      }
      
      private function add_lv() : *
      {
         var d0:AchievementOneDefine = null;
         var type0:String = "";
         var giftArr:Array = [];
         type0 = "lv";
         d0 = new AchievementOneDefine();
         d0.type = type0;
         d0.name = "lv_10";
         d0.cnName = "10级";
         d0.info = "人物等级到达10级";
         d0.must = "10";
         giftArr = [];
         d0.giftArr = giftArr;
         this[type0 + "_arr"].push(d0);
         d0 = new AchievementOneDefine();
         d0.type = type0;
         d0.name = "lv_20";
         d0.cnName = "20级";
         d0.info = "人物等级到达20级";
         d0.must = "20";
         giftArr = [];
         d0.giftArr = giftArr;
         this[type0 + "_arr"].push(d0);
         d0 = new AchievementOneDefine();
         d0.type = type0;
         d0.name = "lv_30";
         d0.cnName = "30级";
         d0.info = "人物等级到达30级";
         d0.must = "30";
         giftArr = [];
         d0.giftArr = giftArr;
         this[type0 + "_arr"].push(d0);
         d0 = new AchievementOneDefine();
         d0.type = type0;
         d0.name = "lv_40";
         d0.cnName = "40级";
         d0.info = "人物等级到达40级";
         d0.must = "40";
         giftArr = [];
         d0.giftArr = giftArr;
         this[type0 + "_arr"].push(d0);
         d0 = new AchievementOneDefine();
         d0.type = type0;
         d0.name = "lv_50";
         d0.cnName = "50级";
         d0.info = "人物等级到达50级";
         d0.must = "50";
         giftArr = [];
         d0.giftArr = giftArr;
         this[type0 + "_arr"].push(d0);
         d0 = new AchievementOneDefine();
         d0.type = type0;
         d0.name = "lv_60";
         d0.cnName = "60级";
         d0.info = "人物等级到达60级";
         d0.must = "60";
         giftArr = [];
         d0.giftArr = giftArr;
         this[type0 + "_arr"].push(d0);
         d0 = new AchievementOneDefine();
         d0.type = type0;
         d0.name = "lv_70";
         d0.cnName = "70级";
         d0.info = "人物等级到达70级";
         d0.honor = "lv_70";
         d0.must = "70";
         giftArr = [];
         d0.giftArr = giftArr;
         this[type0 + "_arr"].push(d0);
         d0 = new AchievementOneDefine();
         d0.type = type0;
         d0.name = "lv_80";
         d0.cnName = "80级";
         d0.info = "人物等级到达80级";
         d0.honor = "lv_80";
         d0.must = "80";
         giftArr = [];
         d0.giftArr = giftArr;
         this[type0 + "_arr"].push(d0);
         d0 = new AchievementOneDefine();
         d0.type = type0;
         d0.name = "lv_90";
         d0.cnName = "90级";
         d0.info = "人物等级到达90级";
         d0.honor = "lv_90";
         d0.must = "90";
         giftArr = [];
         d0.giftArr = giftArr;
         this[type0 + "_arr"].push(d0);
         d0 = new AchievementOneDefine();
         d0.type = type0;
         d0.name = "lv_95";
         d0.cnName = "95级";
         d0.info = "人物等级到达95级";
         d0.honor = "lv_95";
         d0.must = "95";
         giftArr = [];
         d0.giftArr = giftArr;
         this[type0 + "_arr"].push(d0);
      }
      
      private function add_dps() : *
      {
         var d0:AchievementOneDefine = null;
         var type0:String = "";
         var giftArr:Array = [];
         type0 = "dps";
         d0 = new AchievementOneDefine();
         d0.type = type0;
         d0.name = "dps_5000";
         d0.cnName = "战斗力五千";
         d0.info = "人物战斗力到达5000";
         d0.must = "5000";
         giftArr = [];
         d0.giftArr = giftArr;
         this[type0 + "_arr"].push(d0);
         d0 = new AchievementOneDefine();
         d0.type = type0;
         d0.name = "dps_1w";
         d0.cnName = "战斗力一万";
         d0.info = "人物战斗力到达10000";
         d0.must = "10000";
         giftArr = [];
         d0.giftArr = giftArr;
         this[type0 + "_arr"].push(d0);
         d0 = new AchievementOneDefine();
         d0.type = type0;
         d0.name = "dps_5w";
         d0.cnName = "战斗力五万";
         d0.info = "人物战斗力到达50000";
         d0.must = "50000";
         giftArr = [];
         d0.giftArr = giftArr;
         this[type0 + "_arr"].push(d0);
         d0 = new AchievementOneDefine();
         d0.type = type0;
         d0.name = "dps_10w";
         d0.cnName = "战斗力十万";
         d0.info = "人物战斗力到达100000";
         d0.must = "100000";
         giftArr = [];
         d0.giftArr = giftArr;
         this[type0 + "_arr"].push(d0);
         d0 = new AchievementOneDefine();
         d0.type = type0;
         d0.name = "dps_20w";
         d0.cnName = "战斗力二十万";
         d0.info = "人物战斗力到达200000";
         d0.must = "200000";
         giftArr = [];
         d0.giftArr = giftArr;
         this[type0 + "_arr"].push(d0);
         d0 = new AchievementOneDefine();
         d0.type = type0;
         d0.name = "dps_50w";
         d0.cnName = "战斗力五十万";
         d0.info = "人物战斗力到达500000";
         d0.must = "500000";
         giftArr = [];
         d0.giftArr = giftArr;
         this[type0 + "_arr"].push(d0);
         d0 = new AchievementOneDefine();
         d0.type = type0;
         d0.name = "dps_100w";
         d0.cnName = "战斗力一百万";
         d0.info = "人物战斗力到达1000000";
         d0.must = "1000000";
         giftArr = [];
         d0.giftArr = giftArr;
         this[type0 + "_arr"].push(d0);
         d0 = new AchievementOneDefine();
         d0.type = type0;
         d0.name = "dps_200w";
         d0.cnName = "战斗力两百万";
         d0.info = "人物战斗力到达2000000";
         d0.must = "2000000";
         giftArr = [];
         d0.giftArr = giftArr;
         this[type0 + "_arr"].push(d0);
         d0 = new AchievementOneDefine();
         d0.type = type0;
         d0.name = "dps_500w";
         d0.cnName = "战斗力五百万";
         d0.info = "人物战斗力到达5000000";
         d0.must = "5000000";
         giftArr = [];
         d0.giftArr = giftArr;
         this[type0 + "_arr"].push(d0);
         d0 = new AchievementOneDefine();
         d0.type = type0;
         d0.name = "dps_800w";
         d0.cnName = "战斗力八百万";
         d0.info = "人物战斗力到达8000000";
         d0.must = "8000000";
         giftArr = [];
         d0.giftArr = giftArr;
         this[type0 + "_arr"].push(d0);
         d0 = new AchievementOneDefine();
         d0.type = type0;
         d0.name = "dps_1000w";
         d0.cnName = "战斗力一千万";
         d0.info = "人物战斗力到达10000000";
         d0.must = "10000000";
         giftArr = [];
         d0.giftArr = giftArr;
         this[type0 + "_arr"].push(d0);
         d0 = new AchievementOneDefine();
         d0.type = type0;
         d0.name = "dps_2000w";
         d0.cnName = "战斗力两千万";
         d0.info = "人物战斗力到达20000000";
         d0.must = "20000000";
         giftArr = [];
         d0.giftArr = giftArr;
         this[type0 + "_arr"].push(d0);
      }
      
      private function add_enemy() : *
      {
         var d0:AchievementOneDefine = null;
         var type0:String = "";
         var giftArr:Array = [];
         type0 = "enemy";
         d0 = new AchievementOneDefine();
         d0.type = type0;
         d0.name = "enemy_1";
         d0.cnName = "击杀！一";
         d0.info = "击杀一只怪物";
         d0.must = "1";
         giftArr = [];
         d0.giftArr = giftArr;
         this[type0 + "_arr"].push(d0);
         d0 = new AchievementOneDefine();
         d0.type = type0;
         d0.name = "enemy_100";
         d0.cnName = "击杀！一百";
         d0.info = "击杀一百只怪物";
         d0.must = "100";
         giftArr = [];
         d0.giftArr = giftArr;
         this[type0 + "_arr"].push(d0);
         d0 = new AchievementOneDefine();
         d0.type = type0;
         d0.name = "enemy_1000";
         d0.cnName = "击杀！一千";
         d0.info = "击杀一千只怪物";
         d0.must = "1000";
         giftArr = [];
         d0.giftArr = giftArr;
         this[type0 + "_arr"].push(d0);
         d0 = new AchievementOneDefine();
         d0.type = type0;
         d0.name = "enemy_1w";
         d0.cnName = "击杀！一万";
         d0.info = "击杀一万只怪物";
         d0.must = "10000";
         giftArr = [];
         d0.giftArr = giftArr;
         this[type0 + "_arr"].push(d0);
         d0 = new AchievementOneDefine();
         d0.type = type0;
         d0.name = "enemy_10w";
         d0.cnName = "击杀！十万";
         d0.info = "击杀十万只怪物";
         d0.must = "100000";
         d0.honor = "enemy_10w";
         giftArr = [];
         d0.giftArr = giftArr;
         this[type0 + "_arr"].push(d0);
         d0 = new AchievementOneDefine();
         d0.type = type0;
         d0.name = "enemy_20w";
         d0.cnName = "击杀！二十万";
         d0.info = "击杀二十万只怪物";
         d0.must = "200000";
         d0.honor = "enemy_20w";
         giftArr = [];
         d0.giftArr = giftArr;
         this[type0 + "_arr"].push(d0);
         d0 = new AchievementOneDefine();
         d0.type = type0;
         d0.name = "enemy_30w";
         d0.cnName = "击杀！三十万";
         d0.info = "击杀三十万只怪物";
         d0.must = "300000";
         d0.honor = "enemy_30w";
         giftArr = [];
         d0.giftArr = giftArr;
         this[type0 + "_arr"].push(d0);
      }
      
      private function add_level() : *
      {
         var d0:AchievementOneDefine = null;
         var type0:String = "";
         var giftArr:Array = [];
         type0 = "level";
         d0 = new AchievementOneDefine();
         d0.type = type0;
         d0.name = "level_0";
         d0.cnName = "通关！南部战争（普通）";
         d0.info = "完成普通难度“第四章决战月都”";
         d0.must = "0_31";
         giftArr = [];
         d0.giftArr = giftArr;
         this[type0 + "_arr"].push(d0);
         d0 = new AchievementOneDefine();
         d0.type = type0;
         d0.name = "level_1";
         d0.cnName = "通关！南部战争（噩梦）";
         d0.info = "完成噩梦难度“第四章决战月都”";
         d0.must = "1_31";
         giftArr = [];
         d0.giftArr = giftArr;
         this[type0 + "_arr"].push(d0);
         d0 = new AchievementOneDefine();
         d0.type = type0;
         d0.name = "level_2";
         d0.cnName = "通关！南部战争（地狱）";
         d0.info = "完成地狱难度“第四章决战月都”";
         d0.must = "2_31";
         giftArr = [];
         d0.giftArr = giftArr;
         this[type0 + "_arr"].push(d0);
         d0 = new AchievementOneDefine();
         d0.type = type0;
         d0.name = "level_3";
         d0.cnName = "通关！南部战争（炼狱）";
         d0.info = "完成炼狱难度“第四章决战月都”";
         d0.must = "3_31";
         giftArr = [];
         d0.giftArr = giftArr;
         this[type0 + "_arr"].push(d0);
         d0 = new AchievementOneDefine();
         d0.type = type0;
         d0.name = "level_4";
         d0.cnName = "通关！决战先知（普通）";
         d0.info = "完成普通难度“第一章浴血奋战”";
         d0.must = "4_7";
         giftArr = [];
         d0.giftArr = giftArr;
         this[type0 + "_arr"].push(d0);
         d0 = new AchievementOneDefine();
         d0.type = type0;
         d0.name = "level_5";
         d0.cnName = "通关！决战先知（噩梦）";
         d0.info = "完成噩梦难度“第一章浴血奋战”";
         d0.must = "5_7";
         giftArr = [];
         d0.giftArr = giftArr;
         this[type0 + "_arr"].push(d0);
         d0 = new AchievementOneDefine();
         d0.type = type0;
         d0.name = "level_6";
         d0.cnName = "通关！决战先知（地狱）";
         d0.info = "完成地狱难度“第一章浴血奋战”";
         d0.must = "6_7";
         giftArr = [];
         d0.giftArr = giftArr;
         this[type0 + "_arr"].push(d0);
         d0 = new AchievementOneDefine();
         d0.type = type0;
         d0.name = "level_7";
         d0.cnName = "通关！决战先知（炼狱）";
         d0.info = "完成炼狱难度“第一章浴血奋战”";
         d0.must = "7_7";
         giftArr = [];
         d0.giftArr = giftArr;
         this[type0 + "_arr"].push(d0);
      }
   }
}

