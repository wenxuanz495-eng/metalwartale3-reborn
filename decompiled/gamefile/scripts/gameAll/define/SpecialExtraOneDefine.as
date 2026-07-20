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
      
      public function inData_byDefine(obj:Object) : *
      {
         var n:* = undefined;
         var pro0:String = null;
         var pro_arr:Array = ["nowNum","maxNum","giftArr","info"];
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            this[pro0] = obj[pro0];
         }
      }
      
      public function set maxNum(value0:Number) : *
      {
         this._maxNum = TextWay.toCode(String(value0));
      }
      
      public function get maxNum() : Number
      {
         return Number(TextWay.getText(this._maxNum));
      }
      
      public function set nowNum(value0:Number) : *
      {
         this._nowNum = TextWay.toCode(String(value0));
      }
      
      public function get nowNum() : Number
      {
         return Number(TextWay.getText(this._nowNum));
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
   }
}

