package com.adobe.test.json
{
   public class JSON3
   {
      
      public function JSON3()
      {
         super();
      }
      
      public static function encode(o:Object) : String
      {
         return new JSONEncoder(o).getString();
      }
      
      public static function decode(s:String, strict:Boolean = true) : *
      {
         return new JSONDecoder(s).getValue();
      }
   }
}

