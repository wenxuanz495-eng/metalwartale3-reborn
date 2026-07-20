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
         var obj:Object = null;
         this.label_arr = ["helper_help","helper_day","helper_strategy"];
         this.help_arr = [];
         this.day_arr = [];
         this.strategy_arr = [];
         this.live_arr = [];
         this.notice_arr = [];
         super();
         obj = new Object();
         obj.name = "arms";
         obj.cnName = "武器";
         obj.type = "help";
         this.help_arr.push(obj);
         obj = new Object();
         obj.name = "car";
         obj.cnName = "车身";
         obj.type = "help";
         this.help_arr.push(obj);
         obj = new Object();
         obj.name = "level";
         obj.cnName = "关卡";
         obj.type = "help";
         this.help_arr.push(obj);
         obj = new Object();
         obj.name = "skill";
         obj.cnName = "技能";
         obj.type = "help";
         this.help_arr.push(obj);
         obj = new Object();
         obj.name = "task";
         obj.cnName = "任务";
         obj.type = "day";
         this[obj.type + "_arr"].push(obj);
         obj = new Object();
         obj.name = "extra";
         obj.cnName = "副本";
         obj.type = "day";
         this[obj.type + "_arr"].push(obj);
         obj = new Object();
         obj.name = "gift";
         obj.cnName = "礼包";
         obj.type = "day";
         this[obj.type + "_arr"].push(obj);
         obj = new Object();
         obj.name = "other";
         obj.cnName = "其他";
         obj.type = "day";
         this[obj.type + "_arr"].push(obj);
         obj = new Object();
         obj.name = "exp";
         obj.cnName = "经验";
         obj.type = "strategy";
         this[obj.type + "_arr"].push(obj);
         obj = new Object();
         obj.name = "coin";
         obj.cnName = "金币";
         obj.type = "strategy";
         this[obj.type + "_arr"].push(obj);
      }
   }
}

