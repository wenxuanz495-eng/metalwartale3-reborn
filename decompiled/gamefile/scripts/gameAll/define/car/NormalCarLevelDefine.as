package gameAll.define.car
{
   import data.TextWay;
   
   public class NormalCarLevelDefine
   {
      
      public var _life:String = "0";
      
      public var _defence:String = "0";
      
      public var _price:String = "0";
      
      public function NormalCarLevelDefine()
      {
         super();
      }
      
      public function inData_byXML(xml0:XML) : *
      {
         this.life = Number(xml0.life);
         this.defence = Number(xml0.defence);
         this.price = Number(xml0.price);
      }
      
      public function get life() : Number
      {
         return Number(TextWay.getText(this._life));
      }
      
      public function set life(v0:Number) : *
      {
         this._life = TextWay.toCode(String(v0));
      }
      
      public function get defence() : Number
      {
         return Number(TextWay.getText(this._defence));
      }
      
      public function set defence(v0:Number) : *
      {
         this._defence = TextWay.toCode(String(v0));
      }
      
      public function get price() : Number
      {
         return Number(TextWay.getText(this._price));
      }
      
      public function set price(v0:Number) : *
      {
         this._price = TextWay.toCode(String(v0));
      }
   }
}

