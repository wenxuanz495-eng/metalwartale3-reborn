package data
{
   public class Maths
   {
      
      public static var pi:Number = Math.PI;
      
      public function Maths()
      {
         super();
      }
      
      public static function PanZero(xx:Number) : *
      {
         if(xx == 0)
         {
            xx = 0.0001;
         }
      }
      
      public static function Pn(xx:Number) : *
      {
         if(xx == 0)
         {
            return 0;
         }
         return xx / Math.abs(xx);
      }
      
      public static function PanSame(n1:Number, n2:Number) : *
      {
         if(Pn(n1) == Pn(n2))
         {
            return true;
         }
         return false;
      }
      
      public static function Pow(xx:Number, yy:Number) : *
      {
         return Math.pow(xx,yy);
      }
      
      public static function Abs(xx:Number) : *
      {
         return Math.abs(xx);
      }
      
      public static function Abs2(xx:Number) : *
      {
         return (xx ^ xx >> 31) - (xx >> 31);
      }
      
      public static function Ra(an:Number) : *
      {
         return an * 180 / Math.PI;
      }
      
      public static function An(ra:Number) : *
      {
         return ra / 180 * Math.PI;
      }
      
      public static function Tan2(yy:Number, xx:Number) : *
      {
         return Math.atan2(yy,xx);
      }
      
      public static function Long(xx:Number, yy:Number) : *
      {
         return Math.sqrt(xx * xx + yy * yy);
      }
      
      public static function Any(vy:Number, dd:Number) : *
      {
         return vy * Math.sin(dd);
      }
      
      public static function Anx(vx:Number, dd:Number) : *
      {
         return vx * Math.cos(dd);
      }
      
      public static function Vi(v1:Number, d1:Number, v2:Number, d2:Number) : Object
      {
         var newo:Object = new Object();
         var vx:* = Anx(v1,d1) + Anx(v2,d2);
         var vy:* = Any(v1,d1) + Any(v2,d2);
         newo.vx = vx;
         newo.vy = vy;
         newo.d0 = Tan2(vy,vx);
         newo.v0 = Long(vx,vy);
         return newo;
      }
      
      public static function FengJ(v:Number, d:Number, dc:Number) : Object
      {
         var newo:Object = new Object();
         var vc:* = v * Math.cos(d - dc);
         newo.vc_fang = vc;
         newo.dc_fang = dc;
         newo.dc = ZhunV(vc,dc);
         newo.vc = Abs(vc);
         newo.de = ZhunJ(dc + LineVsJ(d,dc) * pi / 2);
         newo.ve = Abs(v * Math.sin(d - dc));
         return newo;
      }
      
      public static function ZhunJ(d:Number) : *
      {
         return (d + pi + 1000 * pi) % (2 * pi) - pi;
      }
      
      public static function ZhunV(v:Number, d:Number) : *
      {
         if(v >= 0)
         {
            return d;
         }
         return ZhunJ(d + pi);
      }
      
      public static function flipRa_Y(ra:Number) : *
      {
         return -ra - Math.PI;
      }
      
      public static function flipRa(ra:Number, ra0:Number) : *
      {
         return ra - (ra - ra0) * 2;
      }
      
      public static function LineVsJ(d:Number, ld:Number) : int
      {
         var lj:* = Math.sin(d - ld);
         return Pn(lj);
      }
      
      public static function J_J(d1:Number, d2:Number) : *
      {
         var jj:* = J_J2(d1,d2);
         if(jj > pi)
         {
            return 2 * pi - jj;
         }
         return jj;
      }
      
      public static function J_J_Ra(d1:Number, d2:Number) : *
      {
         var jj:* = J_J2(An(d1),An(d2));
         if(jj > pi)
         {
            return Ra(2 * pi - jj);
         }
         return Ra(jj);
      }
      
      public static function J_J2(d1:Number, d2:Number) : *
      {
         return ZhunJ2(d1 - d2);
      }
      
      public static function ZhunJ2(d:Number) : *
      {
         return (d + 1000 * pi) % (2 * pi);
      }
   }
}

