package body.hero
{
   import body.image.MultipleImage;
   import data.Maths;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class HeroCarImage extends Sprite
   {
      
      public var light_mc:MovieClip = null;
      
      public var sp:Sprite = new Sprite();
      
      public var fly:HeroFlyImage = new HeroFlyImage();
      
      public var car:CarImage = new CarImage();
      
      public var arms:ArmsImage = new ArmsImage();
      
      public var plasmaShield:MultipleImage = new MultipleImage();
      
      public var bodyState:String = "stand";
      
      public var changeT:Number = 0;
      
      public var change_t:Number = -1;
      
      public var changeToStand:Function = null;
      
      public function HeroCarImage()
      {
         super();
         this.fly.allImg = this;
         this.sp.addChild(this.car);
         this.sp.addChild(this.arms);
         this.sp.addChild(this.fly);
         this.fly.visible = false;
         addChild(this.sp);
         this.plasmaShield.y = -30;
         this.addChild(this.plasmaShield);
      }
      
      public function otherGamingInit() : *
      {
         this.bodyState = "stand";
         this.change_t = -1;
         this.fly.img.goPlayOnce("stop");
         this.fly.visible = false;
         this.car.visible = true;
         this.arms.visible = true;
      }
      
      public function stopAll() : *
      {
         this.car.gotoAndStop(1);
         this.arms.gotoAndStop(1);
         this.plasmaShield.stop();
      }
      
      public function fleshGroupLight(bb0:Boolean) : *
      {
         if(bb0)
         {
            if(this.light_mc == null)
            {
               trace("添加光环！");
               this.light_mc = Game.swfLoaderManager.getResource("car","groupLight_effect");
               this.addChild(this.light_mc);
            }
         }
         else if(Boolean(this.light_mc))
         {
            trace("删除光环！");
            this.removeChild(this.light_mc);
            this.light_mc = null;
         }
      }
      
      public function clear() : *
      {
         this.car.rocket.clear();
         this.car.plasma.clear();
         this.plasmaShield.clear();
         this.car.clear();
         this.arms.clear();
      }
      
      public function ArmsFollowCar() : *
      {
         var p0:Point = this.car.armsPoint;
         this.arms.x = p0.x;
         this.arms.y = p0.y;
      }
      
      public function startHurtEffect(_hurtTime:Number = 0.2) : *
      {
         this.car.startHurtEffect(_hurtTime);
      }
      
      public function get shootPoint() : Point
      {
         var ra0:Number = NaN;
         var p0:Point = null;
         var x0:Number = 0;
         var y0:Number = 0;
         if(this.bodyState == "fly")
         {
            ra0 = this.fly.arm.rotation * Math.PI / 180;
            x0 = Math.cos(ra0) * 20 + this.fly.arm.x + this.fly.x;
            y0 = Math.sin(ra0) * 20 + this.fly.arm.y + this.fly.y;
            if(this.rightB)
            {
               return new Point(-x0 + this.x,y0 + this.y);
            }
            return new Point(x0 + this.x,y0 + this.y);
         }
         p0 = this.arms.shootPoint_rotation;
         x0 = p0.x;
         y0 = p0.y;
         if(this.rightB)
         {
            return new Point(-x0 + this.x - this.arms.x,y0 + this.y + this.arms.y);
         }
         return new Point(x0 + this.x + this.arms.x,y0 + this.y + this.arms.y);
      }
      
      public function get shootRa() : Number
      {
         var ra0:Number = 0;
         if(this.bodyState == "fly")
         {
            ra0 = this.fly.arm.rotation / 180 * Math.PI;
         }
         else
         {
            ra0 = this.arms.rotation / 180 * Math.PI;
         }
         if(this.rightB)
         {
            return -ra0 - Math.PI;
         }
         return ra0;
      }
      
      public function flipToLeft() : *
      {
         if(this.sp.scaleX != 1)
         {
            this.arms.rotation = Maths.An(Maths.flipRa_Y(Maths.Ra(this.arms.rotation)));
            this.sp.scaleX = 1;
         }
      }
      
      public function flipToRight() : *
      {
         if(this.sp.scaleX != -1)
         {
            this.arms.rotation = Maths.An(Maths.flipRa_Y(Maths.Ra(this.arms.rotation)));
            this.sp.scaleX = -1;
         }
      }
      
      public function get rightB() : Boolean
      {
         if(this.sp.scaleX > 0)
         {
            return false;
         }
         return true;
      }
      
      public function inMouseXY(x0:Number, y0:Number) : *
      {
         var rightB0:Boolean = false;
         var a_tan:Number = NaN;
         if(this.bodyState == "fly")
         {
            rightB0 = this.fly.inMouseXY(x0 - this.x,y0 - this.y);
            if(rightB0)
            {
               this.flipToLeft();
            }
            else
            {
               this.flipToRight();
            }
         }
         else
         {
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
      }
      
      public function pause() : *
      {
         this.car.pause();
         this.arms.pause();
         this.plasmaShield.pause();
      }
      
      public function resume() : *
      {
         this.car.resume();
         this.arms.resume();
         this.plasmaShield.resume();
      }
      
      public function changeState(str0:String, changeT0:Number = 0) : *
      {
         if(this.bodyState != str0)
         {
            if(str0 == "fly")
            {
               this.changeT = changeT0;
               this.change_t = 0;
               this.fly.img.goOnce_ToLoop("toFly","stop");
               this.plasmaShield.y = -100;
            }
            else
            {
               this.fly.img.goOnce_ToLoop("toStand","stop");
               this.plasmaShield.y = -30;
            }
            this.bodyState = str0;
         }
      }
      
      private function changeTimer() : *
      {
         if(this.change_t >= 0)
         {
            if(this.change_t >= this.changeT)
            {
               this.change_t = -1;
               if(this.changeToStand is Function)
               {
                  this.changeToStand();
               }
            }
            else
            {
               this.change_t += 1 / 30;
            }
         }
      }
      
      public function imageTimer() : *
      {
         this.changeTimer();
         this.fly.imageTimer();
         this.car.visible = this.fly.carVislble;
         this.arms.visible = this.fly.carVislble;
         this.car.imageTimer();
         this.car.rocket.imageTimer();
         this.car.plasma.imageTimer();
         this.plasmaShield.imageTimer();
         this.arms.imageTimer();
      }
   }
}

