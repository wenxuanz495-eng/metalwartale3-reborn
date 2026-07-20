package gameAll.define.liveness
{
   import data.TextWay;
   import gameAll.define.ExtraDefine;
   
   public class LivenessGiftDefine
   {
      
      private var _mustValue:String = "";
      
      private var _giftArr:Array = [];
      
      public function LivenessGiftDefine()
      {
         super();
      }
      
      public function set mustValue(num0:int) : *
      {
         this._mustValue = TextWay.toCode(String(num0));
      }
      
      public function get mustValue() : int
      {
         return int(TextWay.getText(this._mustValue));
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

