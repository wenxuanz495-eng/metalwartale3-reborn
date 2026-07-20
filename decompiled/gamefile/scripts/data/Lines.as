package data
{
   public class Lines
   {
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      public var ra:Number = 0;
      
      public var w:Number = 0;
      
      public var len:Number = 900;
      
      public function Lines(_x0:Number = 0, _y0:Number = 0, _ra:Number = 0, _w:Number = 0, _len:Number = 900)
      {
         super();
         this.x = _x0;
         this.y = _y0;
         this.ra = _ra;
         this.w = _w;
         this.len = _len;
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

