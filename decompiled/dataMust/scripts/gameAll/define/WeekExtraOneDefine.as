package gameAll.define
{
   import data.TextWay;
   
   public class WeekExtraOneDefine
   {
      
      public var id:String = "";
      
      public var name:String = "";
      
      private var _level:String = "";
      
      private var _maxLife:String = "";
      
      public var skillNum:Array = [1,1,1];
      
      public var armsArr:Array = ["soya_lv1"];
      
      public var subArr:Array = ["lightningBall_lv1"];
      
      public var carLabel:String = "lambo";
      
      private var _giftArr:Array = [];
      
      public function WeekExtraOneDefine()
      {
         super();
         this.maxLife = 0;
         this.level = 0;
      }
      
      public function set maxLife(param1:Number) : *
      {
         this._maxLife = TextWay.toCode(String(param1));
      }
      
      public function get maxLife() : Number
      {
         return Number(TextWay.getText(this._maxLife));
      }
      
      public function set level(param1:Number) : *
      {
         this._level = TextWay.toCode(String(param1));
      }
      
      public function get level() : Number
      {
         return Number(TextWay.getText(this._level));
      }
      
      public function set giftArr(param1:Array) : *
      {
         ExtraDefine.swapToCode(param1);
         this._giftArr = param1;
      }
      
      public function get giftArr() : Array
      {
         return ExtraDefine.swapToText(this._giftArr);
      }
      
      public function toString() : String
      {
         var _loc3_:* = undefined;
         var _loc1_:String = "";
         var _loc2_:Array = ["id","level","maxLife"];
         for(_loc3_ in _loc2_)
         {
            _loc1_ += _loc2_[_loc3_] + ":" + this[_loc2_[_loc3_]] + "，";
         }
         return _loc1_;
      }
   }
}

