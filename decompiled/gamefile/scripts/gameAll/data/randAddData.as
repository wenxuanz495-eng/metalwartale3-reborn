package gameAll.data
{
   import data.StringDate;
   import data.TextWay;
   
   public class randAddData
   {
      
      public var bag:int = 5;
      
      public var expCard:int = 2;
      
      private var _expTime:String = "";
      
      private var _life:String = "";
      
      private var _attack:String = "";
      
      private var _coin:String = "";
      
      public var expMul:int = 0;
      
      public var nowExpCard:int = 0;
      
      public var continueDays:int = 1;
      
      public var firstTimeDate:StringDate = new StringDate();
      
      public var getLoginGiftTime:StringDate = new StringDate();
      
      public var getRankGiftTime:StringDate = new StringDate();
      
      public var doubleExpTime:int = 0;
      
      public var lastLoginTime:StringDate = new StringDate();
      
      public var rankGiftB:Boolean = false;
      
      public var oldRecharged:int = 0;
      
      public var oldRecharged2:int = 0;
      
      public var oldRecharged_1:int = -1;
      
      public var oldRecharged2_1:int = -1;
      
      public var nameChangeNum:int = 1;
      
      public function randAddData()
      {
         super();
         this.lifeAdd = 0;
         this.attackAdd = 0;
         this.coin = 0;
         this.expTime = 0;
      }
      
      public function get lifeAdd() : Number
      {
         return Number(TextWay.getText(this._life));
      }
      
      public function set lifeAdd(v0:Number) : *
      {
         this._life = TextWay.toCode(String(v0));
      }
      
      public function get attackAdd() : Number
      {
         return Number(TextWay.getText(this._attack));
      }
      
      public function set attackAdd(v0:Number) : *
      {
         this._attack = TextWay.toCode(String(v0));
      }
      
      public function get coin() : Number
      {
         return Number(TextWay.getText(this._coin));
      }
      
      public function set coin(v0:Number) : *
      {
         this._coin = TextWay.toCode(String(v0));
      }
      
      public function get expTime() : Number
      {
         return Number(TextWay.getText(this._expTime));
      }
      
      public function set expTime(v0:Number) : *
      {
         this._expTime = TextWay.toCode(String(v0));
      }
      
      public function inData_byObj(obj:Object) : *
      {
         var n:* = undefined;
         var pro0:String = null;
         var pro_arr:Array = ["nowExpCard","doubleExpTime","continueDays"];
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            this[pro0] = obj[pro0];
         }
         this.firstTimeDate.inData_byObj(obj.firstTimeDate);
         this.getLoginGiftTime.inData_byObj(obj.getLoginGiftTime);
         this.getRankGiftTime.inData_byObj(obj.getRankGiftTime);
         if(obj.hasOwnProperty("lastLoginTime"))
         {
            this.lastLoginTime.inData_byObj(obj.lastLoginTime);
         }
         else
         {
            this.lastLoginTime.init();
         }
         if(obj.hasOwnProperty("rankGiftB"))
         {
            this.rankGiftB = obj.rankGiftB;
         }
         else
         {
            this.rankGiftB = false;
         }
         if(obj.hasOwnProperty("oldRecharged"))
         {
            this.oldRecharged = obj.oldRecharged;
         }
         else
         {
            this.oldRecharged = 0;
         }
         if(obj.hasOwnProperty("oldRecharged2"))
         {
            this.oldRecharged2 = obj.oldRecharged2;
         }
         else
         {
            this.oldRecharged2 = 0;
         }
         if(obj.hasOwnProperty("oldRecharged_1"))
         {
            this.oldRecharged_1 = obj.oldRecharged_1;
         }
         else
         {
            this.oldRecharged_1 = 0;
         }
         if(obj.hasOwnProperty("oldRecharged2_1"))
         {
            this.oldRecharged2_1 = obj.oldRecharged2_1;
         }
         else
         {
            this.oldRecharged2_1 = 0;
         }
         if(obj.hasOwnProperty("nameChangeNum"))
         {
            this.nameChangeNum = obj.nameChangeNum;
         }
         else
         {
            this.nameChangeNum = 1;
         }
      }
      
      public function inData_byLevel(lv0:int) : *
      {
         var n:* = undefined;
         var pro0:String = null;
         var pro_arr:Array = ["bag","expTime","expCard","coin","lifeAdd","attackAdd"];
         var arr0:Array = Game.gameDefine.rankAdd;
         var arr1:Array = arr0[lv0];
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            this[pro0] = arr1[n];
         }
      }
      
      public function newDayCtrl() : *
      {
         this.rankGiftB = false;
         this.initExpCard();
      }
      
      public function upDataInitAll() : *
      {
         this.initExpCard();
         this.getRankGiftTime.init();
         this.rankGiftB = false;
      }
      
      public function initExpCard() : *
      {
         this.nowExpCard = 0;
      }
      
      public function addDoubleExpTime(value0:int) : *
      {
         this.doubleExpTime += value0;
      }
      
      public function wasteTime() : *
      {
         if(this.doubleExpTime > 0)
         {
            --this.doubleExpTime;
            this.expMul = 1;
         }
         else
         {
            this.expMul = 0;
         }
      }
      
      public function getExpTime() : String
      {
         return "双倍经验时间：" + Math.ceil(this.doubleExpTime / 60) + "分钟";
      }
      
      public function getExpCardUseB() : Boolean
      {
         if(this.nowExpCard >= this.expCard && this.expCard != -1)
         {
            return false;
         }
         return true;
      }
      
      public function getExpCardNum() : int
      {
         if(this.expCard == -1)
         {
            return 10000000;
         }
         return this.expCard - this.nowExpCard;
      }
      
      public function getExpCard() : String
      {
         if(this.expCard == -1)
         {
            return "无限使用";
         }
         return this.expCard + "次";
      }
      
      public function get haveLoginB() : Boolean
      {
         var day0:int = this.getLoginGiftTime.compareDate(Game.timeDate.getSaveDate);
         if(day0 > 0)
         {
            return true;
         }
         return false;
      }
      
      public function get haveRankGiftB() : Boolean
      {
         var day0:int = this.getRankGiftTime.compareDate(Game.timeDate.getSaveDate);
         if(day0 > 0)
         {
            return true;
         }
         return false;
      }
      
      public function toString() : String
      {
         var n:* = undefined;
         var pro0:String = null;
         var pro_arr:Array = ["bag","expTime","expCard","coin","lifeAdd","attackAdd","nowExpCard","doubleExpTime","haveRankGiftB","haveLoginB","firstTimeDate","getLoginGiftTime","getRankGiftTime","lastLoginTime","continueDays"];
         var str0:String = "";
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            str0 += pro0 + ":" + this[pro0] + "\n";
         }
         return str0;
      }
   }
}

