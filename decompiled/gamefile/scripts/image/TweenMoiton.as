package image
{
   import data.INIT;
   
   public class TweenMoiton
   {
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      public var mx:Number = 0;
      
      public var my:Number = 0;
      
      public var vx:Number = 0;
      
      public var vy:Number = 0;
      
      public var ax:Number = 0;
      
      public var ay:Number = 0;
      
      public var max:Number = 0;
      
      public function TweenMoiton()
      {
         super();
         this.max = 500 / INIT.FPS;
      }
      
      public function init(x0:Number, y0:Number) : *
      {
         this.x = x0;
         this.y = y0;
         this.mx = this.x;
         this.my = this.y;
         this.vx = 0;
         this.vy = 0;
         this.ax = 0;
         this.ay = 0;
      }
      
      public function inData(mx0:Number, my0:Number) : *
      {
         this.mx = mx0;
         this.my = my0;
         var cx:Number = this.mx - this.x;
         var cy:Number = this.my - this.y;
         var cx0:Number = Math.abs(cx);
         var cy0:Number = Math.abs(cy);
         if(cx0 > 100)
         {
            this.vx = cx / cx0 * this.max;
         }
         else if(cx0 <= 100 && cx0 > 3)
         {
            this.vx = cx / 100 * this.max;
         }
         else
         {
            this.vx = 0;
         }
         if(cy0 > 100)
         {
            this.vy = cy / cy0 * this.max;
         }
         else if(cy0 <= 100 && cy0 > 3)
         {
            this.vy = cy / 100 * this.max;
         }
         else
         {
            this.vy = 0;
         }
         this.x += this.vx;
         this.y += this.vy;
      }
   }
}

