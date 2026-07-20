package gameAll.define
{
   import data.TextWay;
   
   public class SpecialExtraOneDefine
   {
      
      private var _nowNum:String = "";
      
      private var _maxNum:String = "";
      
      private var _giftArr:Array = [];
      
      public var info:String = "";
      
      public function SpecialExtraOneDefine()
      {
         super();
      }
      
      public function inData_byDefine(param1:Object) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:String = null;
         var _loc2_:Array = ["nowNum","maxNum","giftArr","info"];
         for(_loc3_ in _loc2_)
         {
            _loc4_ = _loc2_[_loc3_];
            this[_loc4_] = param1[_loc4_];
         }
      }
      
      public function set maxNum(param1:Number) : *
      {
         this._maxNum = TextWay.toCode(String(param1));
      }
      
      public function get maxNum() : Number
      {
         return Number(TextWay.getText(this._maxNum));
      }
      
      public function set nowNum(param1:Number) : *
      {
         this._nowNum = TextWay.toCode(String(param1));
      }
      
      public function get nowNum() : Number
      {
         return Number(TextWay.getText(this._nowNum));
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
   }
}

