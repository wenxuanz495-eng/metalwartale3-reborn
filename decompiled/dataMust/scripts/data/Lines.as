package data
{
   public class Lines
   {
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      public var ra:Number = 0;
      
      public var w:Number = 0;
      
      public var len:Number = 900;
      
      public function Lines(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:Number = 900)
      {
         super();
         this.x = param1;
         this.y = param2;
         this.ra = param3;
         this.w = param4;
         this.len = param5;
      }
      
      public function clone() : Lines
      {
         return new Lines(this.x,this.y,this.ra,this.w,this.len);
      }
      
      public function toString() : String
      {
         return "x:" + this.x + ",y:" + this.y + ",ra:" + this.ra + ",w:" + this.w;
      }
   }
}

