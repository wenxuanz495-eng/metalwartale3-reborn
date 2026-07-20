package gameAll.vip
{
   public class VipDefine
   {
      
      public var arr:Array;
      
      public function VipDefine()
      {
         var d0:OneVipDefine = null;
         this.arr = [];
         super();
         var giftArr:Array = [];
         d0 = new OneVipDefine();
         d0.name = "vipCard_0";
         d0.cnName = "VIP体验卡";
         d0.honor = "体验VIP";
         d0.expAdd = 0.1;
         d0.achieveAdd = 0.2;
         d0.all_pro = 0.1;
         d0.durationTime = 0.01;
         giftArr = [];
         giftArr.push("GCoin,\t\t50000,\t\t\t1");
         giftArr.push("achieve,\t\t100,\t\t\t1");
         d0.giftArr = giftArr;
         this.arr.push(d0);
         d0 = new OneVipDefine();
         d0.name = "vipCard_11";
         d0.cnName = "青铜VIP·终身";
         d0.honor = "青铜VIP";
         d0.expAdd = 0.1;
         d0.achieveAdd = 0.2;
         d0.all_pro = 0.1;
         d0.durationTime = 7;
         giftArr = [];
         giftArr.push("GCoin,\t\t50000,\t\t\t1");
         giftArr.push("achieve,\t\t100,\t\t\t1");
         giftArr.push("props,\tsuperalloyStone,\t1");
         d0.giftArr = giftArr;
         this.arr.push(d0);
         d0 = new OneVipDefine();
         d0.name = "vipCard_12";
         d0.cnName = "白银VIP·终身";
         d0.honor = "白银VIP";
         d0.expAdd = 0.2;
         d0.achieveAdd = 0.3;
         d0.all_pro = 0.15;
         d0.durationTime = 15;
         giftArr = [];
         giftArr.push("GCoin,\t\t100000,\t\t\t1");
         giftArr.push("achieve,\t\t200,\t\t\t1");
         giftArr.push("props,\tsuperalloyStone,\t3");
         giftArr.push("props,\tsuperalloyStone,\t1");
         giftArr.push("props,\tsuperalloyStone,\t1");
         d0.giftArr = giftArr;
         this.arr.push(d0);
         d0 = new OneVipDefine();
         d0.name = "vipCard_13";
         d0.cnName = "黄金VIP·终身";
         d0.honor = "黄金VIP";
         d0.expAdd = 0.3;
         d0.achieveAdd = 0.5;
         d0.all_pro = 0.2;
         d0.durationTime = 30;
         giftArr = [];
         giftArr.push("GCoin,\t\t200000,\t\t\t1");
         giftArr.push("achieve,\t\t500,\t\t\t1");
         giftArr.push("props,\tsuperalloyStone,\t6");
         giftArr.push("props,\tsuperalloyStone,\t1");
         giftArr.push("props,\tsuperalloyStone,\t1");
         giftArr.push("props,\tsuperalloyStone,\t1");
         giftArr.push("props,\tsuperalloyStone,\t1");
         giftArr.push("props,\tsuperalloyStone,\t1");
         d0.giftArr = giftArr;
         this.arr.push(d0);
         d0 = new OneVipDefine();
         d0.name = "vipCard_14";
         d0.cnName = "钻石VIP·终身";
         d0.honor = "钻石VIP";
         d0.expAdd = 0.5;
         d0.achieveAdd = 1;
         d0.all_pro = 0.5;
         d0.durationTime = 10000;
         giftArr = [];
         giftArr.push("GCoin,\t\t500000,\t\t\t1");
         giftArr.push("achieve,\t\t1000,\t\t\t1");
         giftArr.push("props,\tsuperalloyStone,\t12");
         giftArr.push("props,\tsuperalloyStone,\t1");
         giftArr.push("props,\tsuperalloyStone,\t1");
         giftArr.push("props,\tsuperalloyStone,\t1");
         giftArr.push("props,\tsuperalloyStone,\t1");
         giftArr.push("props,\tsuperalloyStone,\t1");
         giftArr.push("props,\tsuperalloyStone,\t1");
         giftArr.push("props,\tsuperalloyStone,\t1");
         giftArr.push("props,\tsuperalloyStone,\t1");
         giftArr.push("props,\tsuperalloyStone,\t1");
         giftArr.push("props,\tsuperalloyStone,\t1");
         giftArr.push("props,\tsuperalloyStone,\t1");
         d0.giftArr = giftArr;
         this.arr.push(d0);
      }
      
      public function getDefine(name0:String) : *
      {
         var n:* = undefined;
         var d0:* = undefined;
         for(n in this.arr)
         {
            d0 = this.arr[n];
            if(d0.name == name0)
            {
               return d0;
            }
         }
         return null;
      }
   }
}

