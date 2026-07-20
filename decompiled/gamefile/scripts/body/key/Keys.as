package body.key
{
   public class Keys
   {
      
      public var code:int = 0;
      
      public var label:String = "";
      
      public var s:String = "";
      
      public function Keys(_code:int)
      {
         super();
         this.code = _code;
      }
      
      public function get state() : String
      {
         if(this.s == "down" || this.s == "downing")
         {
            return "downing";
         }
         return "uping";
      }
      
      public function toing() : *
      {
         if(this.s == "down")
         {
            this.s = "downing";
         }
         else if(this.s == "up")
         {
            this.s = "uping";
         }
      }
   }
}

