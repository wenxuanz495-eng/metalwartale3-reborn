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
         var _loc1_:LivenessGiftDefine = null;
         var _loc3_:LivenessTaskDefine = null;
         this.arr = [];
         this.taskArr = [];
         this.firstCar = ["dragonRoars2","dragonRoars2","dragonRoars"];
         this.novice_giftBox = [];
         this.grow_giftBox = [];
         this._must_M = TextWay.toCode("449");
         super();
         var _loc2_:Array = [];
         _loc1_ = new LivenessGiftDefine();
         _loc1_.mustValue = 20;
         _loc2_ = [];
         _loc2_.push("GCoin,\t50000,\t\t1");
         _loc2_.push("materials,\tsuperalloy_X,\t\t10");
         _loc1_.giftArr = _loc2_;
         this.arr.push(_loc1_);
         _loc1_ = new LivenessGiftDefine();
         _loc1_.mustValue = 40;
         _loc2_ = [];
         _loc2_.push("GCoin,\t50000,\t\t1");
         _loc2_.push("materials,\tsuperalloy_X,\t\t10");
         _loc1_.giftArr = _loc2_;
         this.arr.push(_loc1_);
         _loc1_ = new LivenessGiftDefine();
         _loc1_.mustValue = 60;
         _loc2_ = [];
         _loc2_.push("GCoin,\t100000,\t\t1");
         _loc2_.push("materials,\tsuperalloy_X,\t\t30");
         _loc1_.giftArr = _loc2_;
         this.arr.push(_loc1_);
         _loc1_ = new LivenessGiftDefine();
         _loc1_.mustValue = 80;
         _loc2_ = [];
         _loc2_.push("GCoin,\t100000,\t\t1");
         _loc2_.push("props,\tdisassemble,\t\t1");
         _loc1_.giftArr = _loc2_;
         this.arr.push(_loc1_);
         _loc1_ = new LivenessGiftDefine();
         _loc1_.mustValue = 100;
         _loc2_ = [];
         _loc2_.push("props,\tdisassemble,\t\t1");
         _loc2_.push("props,\tjustice_badge,\t\t1");
         _loc1_.giftArr = _loc2_;
         this.arr.push(_loc1_);
         _loc3_ = new LivenessTaskDefine();
         _loc3_.id = "login";
         _loc3_.name = "登录超合金战记2.5";
         _loc3_.must = 1;
         _loc3_.gift = 20;
         _loc3_.index = this.taskArr.length;
         this.taskArr.push(_loc3_);
         _loc3_ = new LivenessTaskDefine();
         _loc3_.id = "normal_level";
         _loc3_.name = "胜利完成普通关卡";
         _loc3_.must = 5;
         _loc3_.gift = 40;
         _loc3_.index = this.taskArr.length;
         this.taskArr.push(_loc3_);
         _loc3_ = new LivenessTaskDefine();
         _loc3_.id = "extra";
         _loc3_.name = "挑战普通副本";
         _loc3_.must = 1;
         _loc3_.gift = 10;
         _loc3_.index = this.taskArr.length;
         this.taskArr.push(_loc3_);
         _loc3_ = new LivenessTaskDefine();
         _loc3_.id = "special_extra";
         _loc3_.name = "挑战特殊副本";
         _loc3_.must = 1;
         _loc3_.gift = 10;
         _loc3_.index = this.taskArr.length;
         this.taskArr.push(_loc3_);
         _loc3_ = new LivenessTaskDefine();
         _loc3_.id = "task";
         _loc3_.name = "完成每日任务";
         _loc3_.must = 2;
         _loc3_.gift = 30;
         _loc3_.index = this.taskArr.length;
         this.taskArr.push(_loc3_);
         _loc3_ = new LivenessTaskDefine();
         _loc3_.id = "challenge_task";
         _loc3_.name = "完成挑战任务";
         _loc3_.must = 1;
         _loc3_.gift = 10;
         _loc3_.index = this.taskArr.length;
         this.taskArr.push(_loc3_);
         this.novice_giftBox.push("achieve,\t3000,\t\t\t1");
         this.novice_giftBox.push("materials,\tthorn_1,\t\t150");
         this.novice_giftBox.push("materials,\tbuncher_1,\t\t200");
         this.novice_giftBox.push("materials,\tboom_1,\t\t\t100");
         this.novice_giftBox.push("materials,\tsuperalloy,\t\t450");
         this.novice_giftBox.push("materials,\tsuperalloy_Z,\t100");
         this.novice_giftBox.push("GCoin,\t1000000,\t\t1");
         this.grow_giftBox.push("props,\texp_card_3,\t\t5");
         this.grow_giftBox.push("props,\texp_card_double,5");
         this.grow_giftBox.push("arms,\tamplitude_lv1,\t\t1");
         this.grow_giftBox.push("sub,\t\thighEnergy_lv1,\t\t1");
         ExtraDefine.swapToCode(this.novice_giftBox);
         ExtraDefine.swapToCode(this.grow_giftBox);
      }
      
      public function getFirstCar(param1:int) : *
      {
         return this.firstCar[param1];
      }
      
      public function getTaskDefine_byId(param1:String) : LivenessTaskDefine
      {
         var _loc2_:* = undefined;
         var _loc3_:LivenessTaskDefine = null;
         for(_loc2_ in this.taskArr)
         {
            _loc3_ = this.taskArr[_loc2_];
            if(_loc3_.id == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function getGift_byName(param1:String) : Array
      {
         if(this.hasOwnProperty(param1))
         {
            return ExtraDefine.swapToText(this[param1]);
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

