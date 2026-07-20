package gameAll.define.helper
{
   public class HelperDefine
   {
      
      public var label_arr:Array;
      
      public var help_arr:Array;
      
      public var day_arr:Array;
      
      public var strategy_arr:Array;
      
      public var live_arr:Array;
      
      public var notice_arr:Array;
      
      public function HelperDefine()
      {
         var _loc1_:Object = null;
         this.label_arr = ["helper_help","helper_day","helper_strategy"];
         this.help_arr = [];
         this.day_arr = [];
         this.strategy_arr = [];
         this.live_arr = [];
         this.notice_arr = [];
         super();
         _loc1_ = new Object();
         _loc1_.name = "arms";
         _loc1_.cnName = "武器";
         _loc1_.type = "help";
         this.help_arr.push(_loc1_);
         _loc1_ = new Object();
         _loc1_.name = "car";
         _loc1_.cnName = "车身";
         _loc1_.type = "help";
         this.help_arr.push(_loc1_);
         _loc1_ = new Object();
         _loc1_.name = "level";
         _loc1_.cnName = "关卡";
         _loc1_.type = "help";
         this.help_arr.push(_loc1_);
         _loc1_ = new Object();
         _loc1_.name = "skill";
         _loc1_.cnName = "技能";
         _loc1_.type = "help";
         this.help_arr.push(_loc1_);
         _loc1_ = new Object();
         _loc1_.name = "task";
         _loc1_.cnName = "任务";
         _loc1_.type = "day";
         this[_loc1_.type + "_arr"].push(_loc1_);
         _loc1_ = new Object();
         _loc1_.name = "extra";
         _loc1_.cnName = "副本";
         _loc1_.type = "day";
         this[_loc1_.type + "_arr"].push(_loc1_);
         _loc1_ = new Object();
         _loc1_.name = "gift";
         _loc1_.cnName = "礼包";
         _loc1_.type = "day";
         this[_loc1_.type + "_arr"].push(_loc1_);
         _loc1_ = new Object();
         _loc1_.name = "other";
         _loc1_.cnName = "其他";
         _loc1_.type = "day";
         this[_loc1_.type + "_arr"].push(_loc1_);
         _loc1_ = new Object();
         _loc1_.name = "exp";
         _loc1_.cnName = "经验";
         _loc1_.type = "strategy";
         this[_loc1_.type + "_arr"].push(_loc1_);
         _loc1_ = new Object();
         _loc1_.name = "coin";
         _loc1_.cnName = "金币";
         _loc1_.type = "strategy";
         this[_loc1_.type + "_arr"].push(_loc1_);
      }
   }
}

