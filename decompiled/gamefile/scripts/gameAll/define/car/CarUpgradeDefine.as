package gameAll.define.car
{
   import data.TextWay;
   
   public class CarUpgradeDefine
   {
      
      private var _M:String = "0";
      
      public function CarUpgradeDefine()
      {
         super();
      }
      
      public function inData_byXML(xml0:XML) : *
      {
         this.M = Number(xml0.M);
      }
      
      public function get M() : Number
      {
         return Number(TextWay.getText(this._M));
      }
      
      public function set M(v0:Number) : *
      {
         this._M = TextWay.toCode(String(v0));
      }
   }
}

