package body.hero
{
   import body.image.MaskArmsImage;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class SubImage extends Sprite
   {
      
      public var car:SubCarImage = new SubCarImage();
      
      public var arms:MaskArmsImage = new MaskArmsImage();
      
      public var beforeP:Point = new Point();
      
      public var leaveB:Boolean = false;
      
      public function SubImage()
      {
         super();
         this.arms.useMask();
         addChild(this.car);
         addChild(this.arms);
      }
      
      public function stopAll() : *
      {
         this.car.gotoAndStop(1);
         this.arms.gotoAndStop(1);
      }
      
      public function clear() : *
      {
         this.car.clear();
         this.arms.clear();
      }
      
      public function ArmsFollowCar() : *
      {
         var p0:Point = this.car.armsPoint;
         this.arms.x = p0.x;
         this.arms.y = p0.y;
      }
      
      public function leaveWorld() : *
      {
         if(!this.leaveB)
         {
            this.beforeP.x = x;
            this.beforeP.y = y;
            this.leaveB = true;
         }
      }
      
      public function returnWorld() : *
      {
         x = this.beforeP.x;
         y = this.beforeP.y;
         this.leaveB = false;
      }
      
      public function get shootPoint() : Point
      {
         var p0:Point = this.arms.shootPoint_rotation;
         var x0:Number = p0.x;
         var y0:Number = p0.y;
         if(this.rightB)
         {
            return new Point(-x0 + this.x - this.arms.x,y0 + this.y + this.arms.y);
         }
         return new Point(x0 + this.x + this.arms.x,y0 + this.y + this.arms.y);
      }
      
      public function get shootRa() : Number
      {
         var ra0:Number = this.arms.rotation / 180 * Math.PI;
         if(this.rightB)
         {
            return -ra0 - Math.PI;
         }
         return ra0;
      }
      
      public function flipToLeft() : *
      {
         if(this.scaleX != 1)
         {
            this.scaleX = 1;
         }
      }
      
      public function flipToRight() : *
      {
         if(this.scaleX != -1)
         {
            this.scaleX = -1;
         }
      }
      
      public function get rightB() : Boolean
      {
         if(this.scaleX > 0)
         {
            return false;
         }
         return true;
      }
      
      public function inMouseXY(x0:Number, y0:Number) : *
      {
         var a_tan:Number = NaN;
         if(this.rightB)
         {
            a_tan = -Math.atan2(y0 - this.arms.y - this.y,x0 + this.arms.x - this.x) - Math.PI;
         }
         else
         {
            a_tan = Math.atan2(y0 - this.arms.y - this.y,x0 - this.arms.x - this.x);
         }
         this.arms.rotation = a_tan * 180 / Math.PI;
      }
      
      public function pause() : *
      {
         this.car.pause();
         this.arms.pause();
      }
      
      public function resume() : *
      {
         this.car.play();
         this.arms.resume();
      }
      
      public function imageTimer() : *
      {
         this.car.imageTimer();
         this.arms.imageTimer();
      }
   }
}

