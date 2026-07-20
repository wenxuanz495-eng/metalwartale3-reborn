package gameAll.define.liveness
{
   import data.TextWay;
   
   public class LivenessTaskDefine
   {
      
      public var index:int = 0;
      
      public var id:String = "";
      
      public var name:String = "";
      
      private var _must:String = "";
      
      private var _gift:String = "";
      
      public function LivenessTaskDefine()
      {
         super();
      }
      
      public function set must(param1:int) : *
      {
         this._must = TextWay.toCode(String(param1));
      }
      
      public function get must() : int
      {
         return int(TextWay.getText(this._must));
      }
      
      public function set gift(param1:int) : *
      {
         this._gift = TextWay.toCode(String(param1));
      }
      
      public function get gift() : int
      {
         return int(TextWay.getText(this._gift));
      }
   }
}

