package body.bullet
{
   import data.INIT;
   import data.Maths;
   import flash.geom.Point;
   
   public class OneBulletMotion
   {
      
      public var x0:Number = 0;
      
      public var y0:Number = 0;
      
      public var mx:Number = 0;
      
      public var my:Number = 0;
      
      private var followB:Boolean = false;
      
      public var v0:Number = 0;
      
      public var vx:Number = 0;
      
      public var vy:Number = 0;
      
      public var a0:Number = 0;
      
      public var vmax:Number = 100;
      
      public var ra:Number = 0;
      
      public var vra:Number = 0;
      
      public var ara:Number = 0;
      
      public var regular_vra:Number = 0;
      
      public var vraMax:Number = 0.16666666666666666;
      
      public var followVra:Number = 1;
      
      public var F_G:Number = 1.6666666666666667;
      
      public var fg:Number = 0;
      
      public var gravity:Number = 0;
      
      public var followWay:String = "missile";
      
      public var updated:Boolean = true;
      
      public function OneBulletMotion()
      {
         super();
      }
      
      public function setInit(x00:Number, y00:Number, v00:Number, ra0:Number, _vmax:Number, _va:Number) : *
      {
         this.x0 = x00;
         this.y0 = y00;
         this.v0 = v00;
         this.ra = ra0;
         this.vmax = _vmax;
         this.a0 = _va / INIT.FPS;
      }
      
      public function startFollow(mx0:Number, my0:Number) : *
      {
         this.mx = mx0;
         this.my = my0;
         this.followB = true;
      }
      
      public function stopFollow() : *
      {
         this.followB = false;
         this.vra = 0;
      }
      
      public function getTailPoint(len0:Number) : Point
      {
         var cx:Number = len0 * Math.cos(this.ra);
         var cy:Number = len0 * Math.sin(this.ra);
         return new Point(this.x0 - cx,this.y0 - cy);
      }
      
      public function bounce(ra00:Number, _bounce:Number) : *
      {
         if(_bounce < 0)
         {
            this.y0 -= 3;
            this.updated = false;
         }
         else if(Maths.J_J(ra00,this.ra) > Math.PI / 2)
         {
            this.ra = Maths.flipRa(this.ra + Math.PI,ra00);
            this.v0 *= _bounce;
         }
      }
      
      private function followCount() : *
      {
         var cs:Number = NaN;
         var tra:Number = Math.atan2(this.my - this.y0,this.mx - this.x0);
         var cra:Number = tra - this.ra;
         if(this.followWay == "missile")
         {
            cs = Maths.Long(this.mx - this.x0,this.my - this.y0);
            if(cs < 200)
            {
               this.vra = Math.sin(cra) * this.vraMax * this.followVra * (250 - cs) / 50;
            }
            else
            {
               this.vra = Math.sin(cra) * this.vraMax * this.followVra;
            }
         }
         else if(this.followWay == "normal")
         {
            this.vra = Math.sin(cra) * this.vraMax * this.followVra;
         }
      }
      
      private function count() : *
      {
         this.fg = this.F_G * this.gravity;
         this.vra += this.ara;
         this.ra += this.vra;
         this.v0 += this.a0;
         if(this.v0 > this.vmax)
         {
            this.v0 = this.vmax;
         }
         else if(this.v0 < -this.vmax)
         {
            this.v0 = -this.vmax;
         }
         this.vx = Math.cos(this.ra) * this.v0;
         this.vy = Math.sin(this.ra) * this.v0 + this.fg;
         this.v0 = Maths.Long(this.vx,this.vy);
         this.ra = Math.atan2(this.vy,this.vx);
         this.x0 += this.vx;
         this.y0 += this.vy;
      }
      
      public function motionTimer() : *
      {
         if(this.updated)
         {
            if(this.followB)
            {
               this.followCount();
            }
            this.count();
         }
      }
      
      public function count2(d:Number) : *
      {
         this.v0 *= d;
         if(this.v0 > this.vmax)
         {
            this.v0 = this.vmax;
         }
         else if(this.v0 < -this.vmax)
         {
            this.v0 = -this.vmax;
         }
         this.vx = Math.cos(this.ra) * this.v0;
         this.vy = Math.sin(this.ra) * this.v0 + this.fg;
         this.v0 = Maths.Long(this.vx,this.vy);
         this.ra = Math.atan2(this.vy,this.vx);
         this.x0 += this.vx;
         this.y0 += this.vy;
      }
      
      public function getNextBulletPoint(d:Number) : Point
      {
         var mot:OneBulletMotion = new OneBulletMotion();
         mot = new OneBulletMotion();
         mot.a0 = this.a0;
         mot.ara = this.ara;
         mot.F_G = this.F_G;
         mot.fg = this.fg;
         mot.followVra = this.followVra;
         mot.followWay = this.followWay;
         mot.gravity = this.gravity;
         mot.mx = this.mx;
         mot.my = this.my;
         mot.ra = this.ra;
         mot.regular_vra = this.regular_vra;
         mot.updated = this.updated;
         mot.v0 = this.v0;
         mot.vmax = this.vmax;
         mot.vra = this.vra;
         mot.vraMax = this.vraMax;
         mot.vx = this.vx;
         mot.vy = this.vy;
         mot.x0 = this.x0;
         mot.y0 = this.y0;
         mot.count2(d);
         return new Point(mot.x0,mot.y0);
      }
   }
}

