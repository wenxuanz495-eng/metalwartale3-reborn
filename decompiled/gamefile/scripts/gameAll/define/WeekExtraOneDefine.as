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
      
      public function set maxLife(value0:Number) : *
      {
         this._maxLife = TextWay.toCode(String(value0));
      }
      
      public function get maxLife() : Number
      {
         return Number(TextWay.getText(this._maxLife));
      }
      
      public function set level(value0:Number) : *
      {
         this._level = TextWay.toCode(String(value0));
      }
      
      public function get level() : Number
      {
         return Number(TextWay.getText(this._level));
      }
      
      public function set giftArr(arr0:Array) : *
      {
         ExtraDefine.swapToCode(arr0);
         this._giftArr = arr0;
      }
      
      public function get giftArr() : Array
      {
         return ExtraDefine.swapToText(this._giftArr);
      }
      
      public function toString() : String
      {
         var i:* = undefined;
         var str0:String = "";
         var arr0:Array = ["id","level","maxLife"];
         for(i in arr0)
         {
            str0 += arr0[i] + ":" + this[arr0[i]] + "，";
         }
         return str0;
      }
   }
}

