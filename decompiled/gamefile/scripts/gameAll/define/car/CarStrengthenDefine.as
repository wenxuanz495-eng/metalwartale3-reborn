package gameAll.define.car
{
   import data.TextWay;
   
   public class CarStrengthenDefine
   {
      
      private var _lifeMul:String = "0";
      
      private var _defenceMul:String = "0";
      
      private var _superalloy_X:String = "0";
      
      private var _superalloy_Y:String = "0";
      
      private var _successRate:String = "0";
      
      public function CarStrengthenDefine()
      {
         super();
      }
      
      public function inData_byXML(xml0:XML) : *
      {
         this.lifeMul = Number(xml0.lifeMul);
         this.defenceMul = Number(xml0.defenceMul);
         this.superalloy_X = Number(xml0.superalloy_X);
         this.superalloy_Y = Number(xml0.superalloy_Y);
         this.successRate = Number(xml0.successRate);
      }
      
      public function get lifeMul() : Number
      {
         return Number(TextWay.getText(this._lifeMul));
      }
      
      public function set lifeMul(v0:Number) : *
      {
         this._lifeMul = TextWay.toCode(String(v0));
      }
      
      public function get defenceMul() : Number
      {
         return Number(TextWay.getText(this._defenceMul));
      }
      
      public function set defenceMul(v0:Number) : *
      {
         this._defenceMul = TextWay.toCode(String(v0));
      }
      
      public function get superalloy_X() : Number
      {
         return Number(TextWay.getText(this._superalloy_X));
      }
      
      public function set superalloy_X(v0:Number) : *
      {
         this._superalloy_X = TextWay.toCode(String(v0));
      }
      
      public function get superalloy_Y() : Number
      {
         return Number(TextWay.getText(this._superalloy_Y));
      }
      
      public function set superalloy_Y(v0:Number) : *
      {
         this._superalloy_Y = TextWay.toCode(String(v0));
      }
      
      public function get successRate() : Number
      {
         return Number(TextWay.getText(this._successRate));
      }
      
      public function set successRate(v0:Number) : *
      {
         this._successRate = TextWay.toCode(String(v0));
      }
   }
}

