package gameAll.vip
{
   import data.TextWay;
   import gameAll.define.ExtraDefine;
   
   public class OneVipDefine
   {
      
      public var name:String = "";
      
      public var cnName:String = "";
      
      public var levelID:String = "";
      
      public var honor:String = "";
      
      private var _giftArr:Array = [];
      
      private var _expAdd:String = "";
      
      private var _achieveAdd:String = "";
      
      private var _all_pro:String = "";
      
      private var _buffTime:String = "";
      
      private var _durationTime:String = "";
      
      public function OneVipDefine()
      {
         super();
         this.buffTime = 90 * 60;
      }
      
      public function set giftArr(arr0:Array) : *
      {
         this._giftArr = arr0;
         ExtraDefine.swapToCode(this._giftArr);
      }
      
      public function get giftArr() : Array
      {
         return ExtraDefine.swapToText(this._giftArr);
      }
      
      public function set expAdd(str0:Number) : *
      {
         this._expAdd = TextWay.toCode(String(str0));
      }
      
      public function get expAdd() : Number
      {
         return Number(TextWay.getText(this._expAdd));
      }
      
      public function set achieveAdd(str0:Number) : *
      {
         this._achieveAdd = TextWay.toCode(String(str0));
      }
      
      public function get achieveAdd() : Number
      {
         return Number(TextWay.getText(this._achieveAdd));
      }
      
      public function set all_pro(str0:Number) : *
      {
         this._all_pro = TextWay.toCode(String(str0));
      }
      
      public function get all_pro() : Number
      {
         return Number(TextWay.getText(this._all_pro));
      }
      
      public function set buffTime(str0:Number) : *
      {
         this._buffTime = TextWay.toCode(String(str0));
      }
      
      public function get buffTime() : Number
      {
         return Number(TextWay.getText(this._buffTime));
      }
      
      public function set durationTime(str0:Number) : *
      {
         this._durationTime = TextWay.toCode(String(str0));
      }
      
      public function get durationTime() : Number
      {
         return Number(TextWay.getText(this._durationTime));
      }
   }
}

