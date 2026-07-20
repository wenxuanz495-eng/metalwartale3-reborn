package data
{
   import flash.geom.Point;
   
   public class Bezier
   {
      
      private static var p0:Point;
      
      private static var p1:Point;
      
      private static var p2:Point;
      
      private static var step:uint;
      
      private static var ax:int;
      
      private static var ay:int;
      
      private static var bx:int;
      
      private static var by:int;
      
      private static var A:Number;
      
      private static var B:Number;
      
      private static var C:Number;
      
      private static var total_length:Number;
      
      public function Bezier()
      {
         super();
      }
      
      private static function s(t:Number) : Number
      {
         return Math.sqrt(A * t * t + B * t + C);
      }
      
      private static function L(t:Number) : Number
      {
         var temp1:Number = Math.sqrt(C + t * (B + A * t));
         var temp2:Number = 2 * A * t * temp1 + B * (temp1 - Math.sqrt(C));
         var temp3:Number = Math.log(B + 2 * Math.sqrt(A) * Math.sqrt(C));
         var temp4:Number = Math.log(B + 2 * A * t + 2 * Math.sqrt(A) * temp1);
         var temp5:Number = 2 * Math.sqrt(A) * temp2;
         var temp6:Number = (B * B - 4 * A * C) * (temp3 - temp4);
         return (temp5 + temp6) / (8 * Math.pow(A,1.5));
      }
      
      private static function InvertL(t:Number, l:Number) : Number
      {
         var t2:Number = NaN;
         var t1:Number = t;
         do
         {
            t2 = t1 - (L(t1) - l) / s(t1);
            if(Math.abs(t1 - t2) < 0.000001)
            {
               break;
            }
            t1 = t2;
         }
         while(true);
         return t2;
      }
      
      public static function init($p0:Point, $p1:Point, $p2:Point, $speed:Number) : uint
      {
         p0 = $p0;
         p1 = $p1;
         p2 = $p2;
         ax = p0.x - 2 * p1.x + p2.x;
         ay = p0.y - 2 * p1.y + p2.y;
         bx = 2 * p1.x - 2 * p0.x;
         by = 2 * p1.y - 2 * p0.y;
         A = 4 * (ax * ax + ay * ay);
         B = 4 * (ax * bx + ay * by);
         C = bx * bx + by * by;
         total_length = L(1);
         step = Math.floor(total_length / $speed);
         if(total_length % $speed > $speed / 2)
         {
            ++step;
         }
         return step;
      }
      
      public static function getAnchorPoint(nIndex:Number) : Array
      {
         var t:Number = NaN;
         var l:Number = NaN;
         var xx:Number = NaN;
         var yy:Number = NaN;
         var Q0:Point = null;
         var Q1:Point = null;
         var dx:Number = NaN;
         var dy:Number = NaN;
         var radians:Number = NaN;
         var degrees:Number = NaN;
         if(nIndex >= 0 && nIndex <= step)
         {
            t = nIndex / step;
            l = t * total_length;
            t = InvertL(t,l);
            xx = (1 - t) * (1 - t) * p0.x + 2 * (1 - t) * t * p1.x + t * t * p2.x;
            yy = (1 - t) * (1 - t) * p0.y + 2 * (1 - t) * t * p1.y + t * t * p2.y;
            Q0 = new Point((1 - t) * p0.x + t * p1.x,(1 - t) * p0.y + t * p1.y);
            Q1 = new Point((1 - t) * p1.x + t * p2.x,(1 - t) * p1.y + t * p2.y);
            dx = Q1.x - Q0.x;
            dy = Q1.y - Q0.y;
            radians = Math.atan2(dy,dx);
            degrees = radians;
            return new Array(xx,yy,degrees);
         }
         return [];
      }
   }
}

