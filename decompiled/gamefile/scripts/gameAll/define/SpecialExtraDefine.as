package gameAll.define
{
   public class SpecialExtraDefine
   {
      
      public var arr:Array;
      
      public var weekLevelArr:Array;
      
      public function SpecialExtraDefine()
      {
         var d0:SpecialExtraOneDefine = null;
         this.arr = [];
         this.weekLevelArr = [10,999,10,10,10,10,10,35,35,35,1,999,999,999,999,999,999,999,999,999];
         super();
         var giftArr0:Array = [];
         d0 = new SpecialExtraOneDefine();
         d0.maxNum = 3;
         d0.nowNum = d0.maxNum;
         d0.info = "碰到敌人的每颗子弹都将扣\n除你34%的血量！并且该关卡\n限制等离子护盾使用次数。";
         giftArr0 = [];
         giftArr0.push("materials,\tsuperalloy_X,\t\t10");
         d0.giftArr = giftArr0;
         this.arr.push(d0);
         d0 = new SpecialExtraOneDefine();
         d0.maxNum = 3;
         d0.nowNum = d0.maxNum;
         d0.info = "地图正在制作中，\n每种技能都限制使用次数，\n无法使用复活水晶。";
         giftArr0 = [];
         giftArr0.push("achieve,\t\t100,\t\t1");
         d0.giftArr = giftArr0;
         this.arr.push(d0);
         d0 = new SpecialExtraOneDefine();
         d0.maxNum = 1;
         d0.nowNum = d0.maxNum;
         d0.info = "限时闯关！在规定时间\n内完成副本才能胜利！";
         giftArr0 = [];
         giftArr0.push("exp,\t\t\t100000,\t\t\t1");
         d0.giftArr = giftArr0;
         this.arr.push(d0);
         d0 = new SpecialExtraOneDefine();
         d0.maxNum = 1;
         d0.nowNum = d0.maxNum;
         d0.info = "必须保证当前怪物数量不\n超过18只，否则失败！";
         giftArr0 = [];
         giftArr0.push("GCoin,\t\t\t200000,\t\t\t1");
         d0.giftArr = giftArr0;
         this.arr.push(d0);
         d0 = new SpecialExtraOneDefine();
         d0.maxNum = 3;
         d0.nowNum = d0.maxNum;
         d0.info = "不管自己和敌人，受到对\n方的伤害即死。进入副本\n护盾和副武器将失效，同\n时只能使用小黄豆武器。";
         giftArr0 = [];
         giftArr0.push("materials,\tsuperalloy_X,\t\t15");
         d0.giftArr = giftArr0;
         this.arr.push(d0);
         d0 = new SpecialExtraOneDefine();
         d0.maxNum = 3;
         d0.nowNum = d0.maxNum;
         d0.info = "天空会掉落金币和红色炸\n弹，尽可能收集金币，千\n万记得躲开红色炸弹！";
         giftArr0 = [];
         giftArr0.push("props,\tdisassemble,\t\t1");
         d0.giftArr = giftArr0;
         this.arr.push(d0);
         d0 = new SpecialExtraOneDefine();
         d0.maxNum = 1;
         d0.nowNum = d0.maxNum;
         d0.info = "在敌人的疯狂自爆下尽可能\n坚持下来，技能和复活水晶\n无效。奖励会根据坚持的时\n间进行计算，每多坚持15\n秒增加10点功勋值，玩家最\n多获得150点功勋。";
         giftArr0 = [];
         giftArr0.push("achieve,\t\t100,\t\t1");
         d0.giftArr = giftArr0;
         this.arr.push(d0);
         d0 = new SpecialExtraOneDefine();
         d0.maxNum = 1;
         d0.nowNum = d0.maxNum;
         d0.info = "努力杀死100个高经验的\n敌人。";
         giftArr0 = [];
         d0.giftArr = giftArr0;
         this.arr.push(d0);
         d0 = new SpecialExtraOneDefine();
         d0.maxNum = 1;
         d0.nowNum = d0.maxNum;
         d0.info = "努力杀死100个金币掉落\n概率很高的敌人。";
         giftArr0 = [];
         d0.giftArr = giftArr0;
         this.arr.push(d0);
         d0 = new SpecialExtraOneDefine();
         d0.maxNum = 1;
         d0.nowNum = d0.maxNum;
         d0.info = "努力杀死100个材料掉落\n概率很高的敌人。";
         giftArr0 = [];
         d0.giftArr = giftArr0;
         this.arr.push(d0);
         d0 = new SpecialExtraOneDefine();
         d0.maxNum = 1;
         d0.nowNum = d0.maxNum;
         d0.info = "异世界的裂口正在不断扩大，必须想办法阻挡住他们！";
         giftArr0 = [];
         giftArr0.push("props,superalloyStone,2");
         d0.giftArr = giftArr0;
         this.arr.push(d0);
      }
      
      public function getMustLevel(index0:int) : int
      {
         return this.weekLevelArr[index0] - 1;
      }
   }
}

