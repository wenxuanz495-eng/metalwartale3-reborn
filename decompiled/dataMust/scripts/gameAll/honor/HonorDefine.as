package gameAll.honor
{
   public class HonorDefine
   {
      
      public var honor_arr:Array;
      
      public var extra_arr:Array;
      
      public var ac:AchievementDefine;
      
      public function HonorDefine()
      {
         var _loc1_:OneHonorDefine = null;
         this.honor_arr = [];
         this.extra_arr = [];
         this.ac = new AchievementDefine();
         super();
         _loc1_ = new OneHonorDefine();
         _loc1_.name = "no";
         _loc1_.cnName = "无";
         _loc1_.pro = "无";
         _loc1_.condition = "无";
         _loc1_.add = [];
         this.honor_arr.push(_loc1_);
         _loc1_ = new OneHonorDefine();
         _loc1_.name = "superalloy_hero";
         _loc1_.cnName = "超合金英雄";
         _loc1_.pro = "射击训练加成5%";
         _loc1_.condition = "登录超合金战记2.5";
         _loc1_.add = ["attackAdd+0.05"];
         this.honor_arr.push(_loc1_);
         _loc1_ = new OneHonorDefine();
         _loc1_.name = "lv_70";
         _loc1_.cnName = "练级达人";
         _loc1_.pro = "无";
         _loc1_.condition = "完成“70级”成就后，领取对应奖励即可获得。";
         _loc1_.add = [];
         this.honor_arr.push(_loc1_);
         _loc1_ = new OneHonorDefine();
         _loc1_.name = "enemy_10w";
         _loc1_.cnName = "杀戮者";
         _loc1_.pro = "全能训练加成10%";
         _loc1_.condition = "完成“击杀！十万”成就后，领取对应奖励即可获得。";
         _loc1_.add = ["allAdd+0.10"];
         this.honor_arr.push(_loc1_);
         _loc1_ = new OneHonorDefine();
         _loc1_.name = "arena_0";
         _loc1_.cnName = "大师角斗士";
         _loc1_.pro = "全能训练加成10%";
         _loc1_.condition = "无";
         _loc1_.add = ["allAdd+0.10"];
         this.extra_arr.push(_loc1_);
         _loc1_ = new OneHonorDefine();
         _loc1_.name = "arena_1";
         _loc1_.cnName = "白金角斗士";
         _loc1_.pro = "控制训练加成10%";
         _loc1_.condition = "无";
         _loc1_.add = ["subAdd+0.10"];
         this.extra_arr.push(_loc1_);
         _loc1_ = new OneHonorDefine();
         _loc1_.name = "arena_2";
         _loc1_.cnName = "黄金角斗士";
         _loc1_.pro = "射击训练加成10%";
         _loc1_.condition = "无";
         _loc1_.add = ["attackAdd+0.10"];
         this.extra_arr.push(_loc1_);
         _loc1_ = new OneHonorDefine();
         _loc1_.name = "arena_3";
         _loc1_.cnName = "白银角斗士";
         _loc1_.pro = "体能训练加成10%";
         _loc1_.condition = "无";
         _loc1_.add = ["lifeAdd+0.10"];
         this.extra_arr.push(_loc1_);
         _loc1_ = new OneHonorDefine();
         _loc1_.name = "arena_4";
         _loc1_.cnName = "青铜角斗士";
         _loc1_.pro = "防御训练加成10%";
         _loc1_.condition = "无";
         _loc1_.add = ["defenceAdd+0.10"];
         this.extra_arr.push(_loc1_);
         _loc1_ = new OneHonorDefine();
         _loc1_.name = "arena_101";
         _loc1_.cnName = "战神";
         _loc1_.pro = "无";
         _loc1_.condition = "无";
         _loc1_.add = [];
         this.extra_arr.push(_loc1_);
         _loc1_ = new OneHonorDefine();
         _loc1_.name = "fighting_1";
         _loc1_.cnName = "初级征战达人";
         _loc1_.pro = "无";
         _loc1_.condition = "无";
         _loc1_.add = [];
         this.extra_arr.push(_loc1_);
         _loc1_ = new OneHonorDefine();
         _loc1_.name = "fighting_2";
         _loc1_.cnName = "中级征战达人";
         _loc1_.pro = "无";
         _loc1_.condition = "无";
         _loc1_.add = [];
         this.extra_arr.push(_loc1_);
         _loc1_ = new OneHonorDefine();
         _loc1_.name = "fighting_3";
         _loc1_.cnName = "高级征战达人";
         _loc1_.pro = "无";
         _loc1_.condition = "无";
         _loc1_.add = [];
         this.extra_arr.push(_loc1_);
         _loc1_ = new OneHonorDefine();
         _loc1_.name = "fighting_4";
         _loc1_.cnName = "超级征战达人";
         _loc1_.pro = "无";
         _loc1_.condition = "无";
         _loc1_.add = [];
         this.extra_arr.push(_loc1_);
         _loc1_ = new OneHonorDefine();
         _loc1_.name = "king_0";
         _loc1_.cnName = "霸主";
         _loc1_.pro = "无";
         _loc1_.condition = "无";
         _loc1_.add = [];
         this.extra_arr.push(_loc1_);
      }
      
      public function getDefine(param1:String) : OneHonorDefine
      {
         var _loc2_:* = undefined;
         var _loc3_:OneHonorDefine = null;
         for(_loc2_ in this.honor_arr)
         {
            _loc3_ = this.honor_arr[_loc2_];
            if(_loc3_.name == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function getExtraDefine(param1:String) : OneHonorDefine
      {
         var _loc2_:* = undefined;
         var _loc3_:OneHonorDefine = null;
         for(_loc2_ in this.extra_arr)
         {
            _loc3_ = this.extra_arr[_loc2_];
            if(_loc3_.name == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
   }
}

