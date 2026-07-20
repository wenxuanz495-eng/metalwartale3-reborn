package gameAll.honor
{
   public class HonorDefine
   {
      
      public var honor_arr:Array;
      
      public var extra_arr:Array;
      
      public var ac:AchievementDefine;
      
      public function HonorDefine()
      {
         var d0:OneHonorDefine = null;
         this.honor_arr = [];
         this.extra_arr = [];
         this.ac = new AchievementDefine();
         super();
         d0 = new OneHonorDefine();
         d0.name = "no";
         d0.cnName = "无";
         d0.pro = "无";
         d0.condition = "无";
         d0.add = [];
         this.honor_arr.push(d0);
         d0 = new OneHonorDefine();
         d0.name = "superalloy_hero";
         d0.cnName = "超合金英雄";
         d0.pro = "射击训练加成5%";
         d0.condition = "登录超合金战记3.0";
         d0.add = ["attackAdd+0.05"];
         this.honor_arr.push(d0);
         d0 = new OneHonorDefine();
         d0.name = "mb_100000";
         d0.cnName = "骨灰级死忠粉";
         d0.pro = "纪念性称号";
         d0.condition = "历史累计获得100000 M币";
         d0.add = [];
         this.honor_arr.push(d0);
         d0 = new OneHonorDefine();
         d0.name = "lv_70";
         d0.cnName = "练级达人";
         d0.pro = "无";
         d0.condition = "完成“70级”成就后，领取对应奖励即可获得。";
         d0.add = [];
         this.honor_arr.push(d0);
         d0 = new OneHonorDefine();
         d0.name = "enemy_10w";
         d0.cnName = "杀戮者";
         d0.pro = "全能训练加成10%";
         d0.condition = "完成“击杀！十万”成就后，领取对应奖励即可获得。";
         d0.add = ["allAdd+0.10"];
         this.honor_arr.push(d0);
         d0 = new OneHonorDefine();
         d0.name = "arena_0";
         d0.cnName = "大师角斗士";
         d0.pro = "全能训练加成10%";
         d0.condition = "无";
         d0.add = ["allAdd+0.10"];
         this.extra_arr.push(d0);
         d0 = new OneHonorDefine();
         d0.name = "arena_1";
         d0.cnName = "白金角斗士";
         d0.pro = "控制训练加成10%";
         d0.condition = "无";
         d0.add = ["subAdd+0.10"];
         this.extra_arr.push(d0);
         d0 = new OneHonorDefine();
         d0.name = "arena_2";
         d0.cnName = "黄金角斗士";
         d0.pro = "射击训练加成10%";
         d0.condition = "无";
         d0.add = ["attackAdd+0.10"];
         this.extra_arr.push(d0);
         d0 = new OneHonorDefine();
         d0.name = "arena_3";
         d0.cnName = "白银角斗士";
         d0.pro = "体能训练加成10%";
         d0.condition = "无";
         d0.add = ["lifeAdd+0.10"];
         this.extra_arr.push(d0);
         d0 = new OneHonorDefine();
         d0.name = "arena_4";
         d0.cnName = "青铜角斗士";
         d0.pro = "防御训练加成10%";
         d0.condition = "无";
         d0.add = ["defenceAdd+0.10"];
         this.extra_arr.push(d0);
         d0 = new OneHonorDefine();
         d0.name = "arena_101";
         d0.cnName = "战神";
         d0.pro = "无";
         d0.condition = "无";
         d0.add = [];
         this.extra_arr.push(d0);
         d0 = new OneHonorDefine();
         d0.name = "fighting_1";
         d0.cnName = "初级征战达人";
         d0.pro = "无";
         d0.condition = "无";
         d0.add = [];
         this.extra_arr.push(d0);
         d0 = new OneHonorDefine();
         d0.name = "fighting_2";
         d0.cnName = "中级征战达人";
         d0.pro = "无";
         d0.condition = "无";
         d0.add = [];
         this.extra_arr.push(d0);
         d0 = new OneHonorDefine();
         d0.name = "fighting_3";
         d0.cnName = "高级征战达人";
         d0.pro = "无";
         d0.condition = "无";
         d0.add = [];
         this.extra_arr.push(d0);
         d0 = new OneHonorDefine();
         d0.name = "fighting_4";
         d0.cnName = "超级征战达人";
         d0.pro = "无";
         d0.condition = "无";
         d0.add = [];
         this.extra_arr.push(d0);
         d0 = new OneHonorDefine();
         d0.name = "king_0";
         d0.cnName = "霸主";
         d0.pro = "无";
         d0.condition = "无";
         d0.add = [];
         this.extra_arr.push(d0);
         d0 = new OneHonorDefine();
         d0.name = "star_0";
         d0.cnName = "明星成员";
         d0.pro = "全能训练+10%";
         d0.condition = "无";
         d0.add = ["allAdd+0.10"];
         this.extra_arr.push(d0);
      }
      
      public function getDefine(name0:String) : OneHonorDefine
      {
         var n:* = undefined;
         var d0:OneHonorDefine = null;
         for(n in this.honor_arr)
         {
            d0 = this.honor_arr[n];
            if(d0.name == name0)
            {
               return d0;
            }
         }
         return null;
      }
      
      public function getExtraDefine(name0:String) : OneHonorDefine
      {
         var n:* = undefined;
         var d0:OneHonorDefine = null;
         for(n in this.extra_arr)
         {
            d0 = this.extra_arr[n];
            if(d0.name == name0)
            {
               return d0;
            }
         }
         return null;
      }
   }
}

