package body.motion
{
   import data.INIT;
   import data.Maths;
   
   public class SuspendMotion
   {
      
      public var type:String = "air";
      
      public var eVx:Number = 0;
      
      public var eVy:Number = 0;
      
      public var x0:Number = 0;
      
      public var y0:Number = 0;
      
      public var mx:Number = 0;
      
      public var my:Number = 0;
      
      public var vx:Number = 0;
      
      public var vy:Number = 0;
      
      public var ax:Number = 0;
      
      public var ay:Number = 0;
      
      private var recoilX:Number = 0;
      
      private var recoilValue:Number = 0;
      
      private var recoil_t:int = -1;
      
      public var tween_x:Number = 100;
      
      public var tween_y:Number = 100;
      
      public var vxmax:Number = 10;
      
      public var vymax:Number = 10;
      
      public var xAffectB:Boolean = true;
      
      public var ra:Number = 0;
      
      public var updated:Boolean = true;
      
      public function SuspendMotion()
      {
         super();
      }
      
      public function inData(_vx00:Number, _vy00:Number, tweenValue:Number, _jumpHeight:Number = 0, _jumpNum:int = 0) : *
      {
         this.vxmax = _vx00 / INIT.FPS;
         this.vymax = _vy00 / INIT.FPS;
         this.tween_x = 30 + 80 * tweenValue;
         this.tween_y = this.tween_x;
      }
      
      public function init(x00:Number, y00:Number) : *
      {
         this.x0 = x00;
         this.y0 = y00;
         this.mx = this.x0;
         this.my = this.y0;
         this.vx = 0;
         this.vy = 0;
         this.ax = 0;
         this.ay = 0;
      }
      
      public function inData_byOther(mot2:GroundMotion) : *
      {
         this.setX(mot2.x0);
         this.setY(mot2.y0);
         this.vx = mot2.vx;
         this.vy = mot2.vy;
         this.ax = mot2.ax;
         this.ay = mot2.ay;
         this.mx = mot2.mx;
         this.my = mot2.my;
      }
      
      public function setX(x00:Number) : *
      {
         this.x0 = x00;
         this.mx = this.x0;
      }
      
      public function setY(y00:Number) : *
      {
         this.y0 = y00;
         this.my = this.y0;
      }
      
      public function move(x00:Number, y00:Number) : *
      {
         this.x0 += x00;
         this.y0 += y00;
      }
      
      public function toStop() : *
      {
         this.stopFollow();
      }
      
      public function toStopBreak() : *
      {
         this.stopFollow();
         this.vx = 0;
         this.vy = 0;
      }
      
      public function setVx(value:Number) : *
      {
         this.vx = value;
      }
      
      public function followPoint(mx0:Number, my0:Number) : *
      {
         this.mx = mx0;
         this.my = my0;
      }
      
      public function setMX(mx0:Number) : *
      {
         this.mx = mx0;
      }
      
      public function setMY(my0:Number) : *
      {
         this.my = my0;
      }
      
      public function getGapX() : Number
      {
         return Math.abs(this.mx - this.x0);
      }
      
      public function getGapY() : Number
      {
         return Math.abs(this.my - this.y0);
      }
      
      public function getGap() : Number
      {
         return Maths.Long(this.mx - this.x0,this.my - this.y0);
      }
      
      public function stopFollow() : *
      {
         this.mx = this.x0;
         this.my = this.y0;
      }
      
      public function recoil(value:Number) : *
      {
         if(Math.abs(value) >= 1)
         {
            this.recoilValue = value;
            this.recoil_t = 0;
         }
      }
      
      private function recoilHandler() : *
      {
         if(this.recoil_t == 0)
         {
            ++this.recoil_t;
            this.recoilX = this.recoilValue;
         }
         else if(this.recoil_t == 1)
         {
            ++this.recoil_t;
            this.recoilX = -this.recoilValue / 3;
         }
         else if(this.recoil_t == 2)
         {
            ++this.recoil_t;
         }
         else if(this.recoil_t == 3)
         {
            ++this.recoil_t;
         }
         else if(this.recoil_t == 4)
         {
            this.recoilX = 0;
            this.recoil_t = -1;
            this.recoilValue = 0;
         }
      }
      
      public function tweenCount() : *
      {
         var cx:Number = this.mx - this.x0;
         var cy:Number = this.my - this.y0;
         var cx0:Number = Math.abs(cx);
         var cy0:Number = Math.abs(cy);
         if(cx0 > this.tween_x)
         {
            this.vx = cx / cx0 * this.vxmax;
         }
         else if(cx0 <= this.tween_x && cx0 > 3)
         {
            this.vx = cx / this.tween_x * this.vxmax;
         }
         else
         {
            this.vx = 0;
         }
         if(cy0 > this.tween_y)
         {
            this.vy = cy / cy0 * this.vymax;
         }
         else if(cy0 <= this.tween_y && cy0 > 3)
         {
            this.vy = cy / this.tween_y * this.vymax;
         }
         else
         {
            this.vy = 0;
         }
         if(this.xAffectB)
         {
            this.x0 += this.vx + this.eVx + this.recoilX;
         }
         else
         {
            this.x0 += this.eVx + this.recoilX;
         }
         this.y0 += this.vy;
      }
      
      public function motionTimer() : *
      {
         if(this.updated)
         {
            this.tweenCount();
            this.recoilHandler();
         }
      }
   }
}

