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
      
      public function set mustValue(param1:int) : *
      {
         this._mustValue = TextWay.toCode(String(param1));
      }
      
      public function get mustValue() : int
      {
         return int(TextWay.getText(this._mustValue));
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

