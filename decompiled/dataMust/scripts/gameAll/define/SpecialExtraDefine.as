package gameAll.define
{
   public class SpecialExtraDefine
   {
      
      public var arr:Array;
      
      public var weekLevelArr:Array;
      
      public function SpecialExtraDefine()
      {
         var _loc1_:SpecialExtraOneDefine = null;
         this.arr = [];
         this.weekLevelArr = [10,10,10,10,10,10,10,35,35,35,999,999,999,999,999];
         super();
         var _loc2_:Array = [];
         _loc1_ = new SpecialExtraOneDefine();
         _loc1_.maxNum = 3;
         _loc1_.nowNum = _loc1_.maxNum;
         _loc1_.info = "碰到敌人的每颗子弹都将扣\n除你34%的血量！并且该关卡\n限制等离子护盾使用次数。";
         _loc2_ = [];
         _loc2_.push("materials,\tsuperalloy_X,\t\t10");
         _loc1_.giftArr = _loc2_;
         this.arr.push(_loc1_);
         _loc1_ = new SpecialExtraOneDefine();
         _loc1_.maxNum = 3;
         _loc1_.nowNum = _loc1_.maxNum;
         _loc1_.info = "地面间有缝隙，掉落即死，\n每种技能都限制使用次数，\n无法使用复活水晶。";
         _loc2_ = [];
         _loc2_.push("achieve,\t\t100,\t\t1");
         _loc1_.giftArr = _loc2_;
         this.arr.push(_loc1_);
         _loc1_ = new SpecialExtraOneDefine();
         _loc1_.maxNum = 1;
         _loc1_.nowNum = _loc1_.maxNum;
         _loc1_.info = "限时闯关！在规定时间\n内完成副本才能胜利！";
         _loc2_ = [];
         _loc2_.push("exp,\t\t\t100000,\t\t\t1");
         _loc1_.giftArr = _loc2_;
         this.arr.push(_loc1_);
         _loc1_ = new SpecialExtraOneDefine();
         _loc1_.maxNum = 1;
         _loc1_.nowNum = _loc1_.maxNum;
         _loc1_.info = "必须保证当前怪物数量不\n超过18只，否则失败！";
         _loc2_ = [];
         _loc2_.push("GCoin,\t\t\t200000,\t\t\t1");
         _loc1_.giftArr = _loc2_;
         this.arr.push(_loc1_);
         _loc1_ = new SpecialExtraOneDefine();
         _loc1_.maxNum = 3;
         _loc1_.nowNum = _loc1_.maxNum;
         _loc1_.info = "不管自己和敌人，受到对\n方的伤害即死。进入副本\n护盾和副武器将失效，同\n时只能使用小黄豆武器。";
         _loc2_ = [];
         _loc2_.push("materials,\tsuperalloy_X,\t\t15");
         _loc1_.giftArr = _loc2_;
         this.arr.push(_loc1_);
         _loc1_ = new SpecialExtraOneDefine();
         _loc1_.maxNum = 3;
         _loc1_.nowNum = _loc1_.maxNum;
         _loc1_.info = "天空会掉落金币和红色炸\n弹，尽可能收集金币，千\n万记得躲开红色炸弹！";
         _loc2_ = [];
         _loc2_.push("props,\tdisassemble,\t\t1");
         _loc1_.giftArr = _loc2_;
         this.arr.push(_loc1_);
         _loc1_ = new SpecialExtraOneDefine();
         _loc1_.maxNum = 1;
         _loc1_.nowNum = _loc1_.maxNum;
         _loc1_.info = "在敌人的疯狂自爆下尽可能\n坚持下来，技能和复活水晶\n无效。奖励会根据坚持的时\n间进行计算，每多坚持15\n秒增加10点功勋值，玩家最\n多获得150点功勋。";
         _loc2_ = [];
         _loc2_.push("achieve,\t\t100,\t\t1");
         _loc1_.giftArr = _loc2_;
         this.arr.push(_loc1_);
         _loc1_ = new SpecialExtraOneDefine();
         _loc1_.maxNum = 1;
         _loc1_.nowNum = _loc1_.maxNum;
         _loc1_.info = "努力杀死100个高经验的\n敌人。";
         _loc2_ = [];
         _loc1_.giftArr = _loc2_;
         this.arr.push(_loc1_);
         _loc1_ = new SpecialExtraOneDefine();
         _loc1_.maxNum = 1;
         _loc1_.nowNum = _loc1_.maxNum;
         _loc1_.info = "努力杀死100个金币掉落\n概率很高的敌人。";
         _loc2_ = [];
         _loc1_.giftArr = _loc2_;
         this.arr.push(_loc1_);
         _loc1_ = new SpecialExtraOneDefine();
         _loc1_.maxNum = 1;
         _loc1_.nowNum = _loc1_.maxNum;
         _loc1_.info = "努力杀死100个材料掉落\n概率很高的敌人。";
         _loc2_ = [];
         _loc1_.giftArr = _loc2_;
         this.arr.push(_loc1_);
      }
      
      public function getMustLevel(param1:int) : int
      {
         return this.weekLevelArr[param1] - 1;
      }
   }
}

