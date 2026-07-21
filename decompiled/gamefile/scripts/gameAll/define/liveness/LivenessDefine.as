package gameAll.define.liveness
{
   import data.TextWay;
   import gameAll.define.ExtraDefine;
   
   public class LivenessDefine
   {
      
      public var arr:Array;
      
      public var taskArr:Array;
      
      public var firstArms:String = "lightKnife_lv1";
      
      public var firstCar:Array;
      
      public var novice_giftBox:Array;
      
      public var grow_giftBox:Array;
      
      private var _must_M:String;
      
      public function LivenessDefine()
      {
         var d0:LivenessGiftDefine = null;
         var d1:LivenessTaskDefine = null;
         this.arr = [];
         this.taskArr = [];
         this.firstCar = ["intercessor","intercessor","intercessor","intercessor","intercessor","intercessor","intercessor","intercessor","intercessor"];
         this.novice_giftBox = [];
         this.grow_giftBox = [];
         this._must_M = TextWay.toCode("449");
         super();
         var giftArr0:Array = [];
         d0 = new LivenessGiftDefine();
         d0.mustValue = 20;
         giftArr0 = [];
         giftArr0.push("GCoin,\t\t100000,\t\t\t1");
         giftArr0.push("materials,\tsuperalloy_X,\t\t20");
         d0.giftArr = giftArr0;
         this.arr.push(d0);
         d0 = new LivenessGiftDefine();
         d0.mustValue = 40;
         giftArr0 = [];
         giftArr0.push("GCoin,\t\t200000,\t\t\t1");
         giftArr0.push("materials,\tsuperalloy_X,\t\t30");
         d0.giftArr = giftArr0;
         this.arr.push(d0);
         d0 = new LivenessGiftDefine();
         d0.mustValue = 60;
         giftArr0 = [];
         giftArr0.push("GCoin,\t300000,\t\t1");
         giftArr0.push("props,\tdisassemble,\t10");
         d0.giftArr = giftArr0;
         this.arr.push(d0);
         d0 = new LivenessGiftDefine();
         d0.mustValue = 80;
         giftArr0 = [];
         giftArr0.push("props,\tjustice_badge,\t5");
         giftArr0.push("props,\tdisassemble_2,\t10");
         d0.giftArr = giftArr0;
         this.arr.push(d0);
         d0 = new LivenessGiftDefine();
         d0.mustValue = 100;
         giftArr0 = [];
         giftArr0.push("props,\tdisassemble_3,\t10");
         giftArr0.push("props,\tsuperalloyStone,\t10");
         d0.giftArr = giftArr0;
         this.arr.push(d0);
         d1 = new LivenessTaskDefine();
         d1.id = "login";
         d1.name = "登录超合金战记";
         d1.must = 1;
         d1.gift = 5;
         d1.index = this.taskArr.length;
         this.taskArr.push(d1);
         d1 = new LivenessTaskDefine();
         d1.id = "normal_level";
         d1.name = "胜利完成普通关卡";
         d1.must = 10;
         d1.gift = 20;
         d1.index = this.taskArr.length;
         this.taskArr.push(d1);
         d1 = new LivenessTaskDefine();
         d1.id = "extra";
         d1.name = "挑战普通副本";
         d1.must = 3;
         d1.gift = 10;
         d1.index = this.taskArr.length;
         this.taskArr.push(d1);
         d1 = new LivenessTaskDefine();
         d1.id = "special_extra";
         d1.name = "挑战特殊副本";
         d1.must = 2;
         d1.gift = 5;
         d1.index = this.taskArr.length;
         this.taskArr.push(d1);
         d1 = new LivenessTaskDefine();
         d1.id = "task";
         d1.name = "完成每日任务";
         d1.must = 10;
         d1.gift = 30;
         d1.index = this.taskArr.length;
         this.taskArr.push(d1);
         d1 = new LivenessTaskDefine();
         d1.id = "challenge_task";
         d1.name = "完成挑战任务";
         d1.must = 5;
         d1.gift = 30;
         d1.index = this.taskArr.length;
         this.taskArr.push(d1);
         this.novice_giftBox.push("achieve,\t\t10000,\t\t\t1");
         this.novice_giftBox.push("materials,\tthorn_1,\t\t200");
         this.novice_giftBox.push("materials,\tbuncher_1,\t\t200");
         this.novice_giftBox.push("materials,\tboom_1,\t\t200");
         this.novice_giftBox.push("materials,\tthorn_2,\t\t200");
         this.novice_giftBox.push("materials,\tbuncher_2,\t\t200");
         this.novice_giftBox.push("materials,\tboom_2,\t\t200");
         this.novice_giftBox.push("materials,\tsuperalloy,\t1000");
         this.novice_giftBox.push("materials,\tsuperalloy_Z,\t500");
         this.novice_giftBox.push("GCoin,\t\t10000000,\t\t1");
         this.grow_giftBox.push("GCoin,\t10000000,\t\t\t\t5");
         this.grow_giftBox.push("props,\texp_card_3,\t\t\t5");
         this.grow_giftBox.push("props,\texp_card_double,\t\t5");
         this.grow_giftBox.push("arms,\tamplitude_lv1,\t\t1");
         this.grow_giftBox.push("sub,\t\thighEnergy_lv1,\t\t1");
         this.grow_giftBox.push("materials,red_crystal_8,\t\t2");
         this.grow_giftBox.push("materials,green_crystal_8,\t2");
         this.grow_giftBox.push("materials,yellow_crystal_8,\t2");
         ExtraDefine.swapToCode(this.novice_giftBox);
         ExtraDefine.swapToCode(this.grow_giftBox);
      }
      
      public function getFirstCar(id0:int) : *
      {
         return this.firstCar[id0];
      }
      
      public function getTaskDefine_byId(id0:String) : LivenessTaskDefine
      {
         var n:* = undefined;
         var d0:LivenessTaskDefine = null;
         for(n in this.taskArr)
         {
            d0 = this.taskArr[n];
            if(d0.id == id0)
            {
               return d0;
            }
         }
         return null;
      }
      
      public function getGift_byName(name0:String) : Array
      {
         if(this.hasOwnProperty(name0))
         {
            return ExtraDefine.swapToText(this[name0]);
         }
         return null;
      }
      
      public function getNewGift() : Array
      {
         return ExtraDefine.swapToText(this.novice_giftBox);
      }
      
      public function getUpgradeGift() : Array
      {
         return ExtraDefine.swapToText(this.grow_giftBox);
      }
      
      public function getMustM() : int
      {
         return int(TextWay.getText(this._must_M));
      }
   }
}

