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
      
      public function set giftArr(param1:Array) : *
      {
         this._giftArr = param1;
         ExtraDefine.swapToCode(this._giftArr);
      }
      
      public function get giftArr() : Array
      {
         return ExtraDefine.swapToText(this._giftArr);
      }
      
      public function set expAdd(param1:Number) : *
      {
         this._expAdd = TextWay.toCode(String(param1));
      }
      
      public function get expAdd() : Number
      {
         return Number(TextWay.getText(this._expAdd));
      }
      
      public function set achieveAdd(param1:Number) : *
      {
         this._achieveAdd = TextWay.toCode(String(param1));
      }
      
      public function get achieveAdd() : Number
      {
         return Number(TextWay.getText(this._achieveAdd));
      }
      
      public function set all_pro(param1:Number) : *
      {
         this._all_pro = TextWay.toCode(String(param1));
      }
      
      public function get all_pro() : Number
      {
         return Number(TextWay.getText(this._all_pro));
      }
      
      public function set buffTime(param1:Number) : *
      {
         this._buffTime = TextWay.toCode(String(param1));
      }
      
      public function get buffTime() : Number
      {
         return Number(TextWay.getText(this._buffTime));
      }
      
      public function set durationTime(param1:Number) : *
      {
         this._durationTime = TextWay.toCode(String(param1));
      }
      
      public function get durationTime() : Number
      {
         return Number(TextWay.getText(this._durationTime));
      }
   }
}

