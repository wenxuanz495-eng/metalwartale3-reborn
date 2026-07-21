package items
{
   public class FloatingMotion
   {
      
      public var x0:Number = 0;
      
      public var y0:Number = 0;
      
      public var vxmax:Number = 20;
      
      public var vymax:Number = 20;
      
      private var y1:Number = 0;
      
      public var range:Number = 5;
      
      private var tt:Number = 0;
      
      public var F_G:Number = 1;
      
      public var vp0:Number = 0.1;
      
      public var y2:Number = 0;
      
      public var vx:Number = 0;
      
      public var vy:Number = 0;
      
      public var ax:Number = 0;
      
      public var ay:Number = 0;
      
      public var ra:Number = 0;
      
      public var minY:Number = 0;
      
      public var updated:Boolean = true;
      
      public var jumpNum:int = 0;
      
      public function FloatingMotion()
      {
         super();
      }
      
      public function settleForMagnet() : *
      {
         this.vx = 0;
         this.vy = 0;
         this.ay = 0;
         this.jumpNum = 3;
         this.range = 0;
      }

      public function shoot(v0:Number, ra0:Number) : *
      {
         this.vx = Math.cos(ra0) * v0;
         this.vy = Math.sin(ra0) * v0;
         this.ay = this.F_G;
      }
      
      private function hitY() : *
      {
         var minY2:* = undefined;
         if(this.y2 > this.minY)
         {
            if(this.jumpNum > 2)
            {
               this.vy = 0;
               this.ay = 0;
               this.vx = 0;
               this.y2 = this.minY;
            }
            else
            {
               minY2 = Game.BGHit.getMinY(this.x0) - 20;
               if(minY2 <= this.minY)
               {
                  if(this.vy > 0.5)
                  {
                     this.vy = -this.vy / 2;
                     this.vx /= 2;
                     ++this.jumpNum;
                  }
                  else
                  {
                     this.vy = 0;
                     this.ay = 0;
                     this.vx = 0;
                     this.jumpNum = 3;
                  }
                  this.y2 = minY2;
               }
               this.minY = minY2;
            }
         }
         if(Math.abs(this.vx) <= 0.1)
         {
            this.vx = 0;
         }
      }
      
      public function motionTimer() : *
      {
         this.tt += this.vp0;
         if(this.tt >= 100 * Math.PI)
         {
            this.tt = 0;
         }
         this.y1 = Math.sin(this.tt) * this.range;
         this.vy += this.ay;
         if(this.vx > this.vxmax)
         {
            this.vx = this.vxmax;
         }
         else if(this.vx < -this.vxmax)
         {
            this.vx = -this.vxmax;
         }
         if(this.vy > this.vymax)
         {
            this.vy = this.vymax;
         }
         else if(this.vy < -this.vymax)
         {
            this.vy = -this.vymax;
         }
         this.y2 += this.vy;
         this.x0 += this.vx;
         this.y0 = this.y1 + this.y2;
         this.hitY();
      }
   }
}

