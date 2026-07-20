package scene.things
{
   import flash.display.MovieClip;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   import image.ShakeMotion;
   
   public class ThingsBody
   {
      
      public var x0:int = 0;
      
      public var y0:int = 0;
      
      public var img:MovieClip;
      
      public var hitRect0:Rectangle;
      
      public var hitHurtB:int = 0;
      
      public var die:* = 0;
      
      public var AAHD:ThingsAAHD = new ThingsAAHD();
      
      public var shake:ShakeMotion = new ShakeMotion();
      
      public var define:ThingsDefine = new ThingsDefine();
      
      public var color_t:int = -1;
      
      public var colorF:ColorTransform = new ColorTransform();
      
      public var _hitNum:int = 0;
      
      public function ThingsBody()
      {
         super();
      }
      
      public function setImg(mc0:MovieClip) : *
      {
         this.img = mc0;
         this.img.stop();
         this.hitRect0 = mc0.getRect(mc0);
         this.AAHD.hurtRectArr = [this.hitRect0];
      }
      
      public function set hitNum(value:int) : *
      {
         this._hitNum = value;
         if(this._hitNum % 2 >= 1)
         {
            if(this.img.currentFrame >= this.img.totalFrames)
            {
               this.die = 1;
            }
            else
            {
               this.img.nextFrame();
            }
         }
         this.fleshRect();
      }
      
      public function get hitNum() : int
      {
         return this._hitNum;
      }
      
      public function toDie() : *
      {
         this.die = 2;
         this.img.visible = false;
         this.img.stop();
         this.hitHurtB = 1;
      }
      
      public function fleshRect() : *
      {
         this.hitRect0 = this.img.getRect(this.img);
         var rect0:Rectangle = this.hitRect0.clone();
         rect0.x += this.img.x;
         rect0.y += this.img.y;
         this.AAHD.hurtRectArr = [rect0];
      }
      
      public function set x(num0:int) : *
      {
         this.img.x = num0;
         var rect0:Rectangle = this.hitRect0.clone();
         rect0.x += this.img.x;
         rect0.y += this.img.y;
         this.AAHD.hurtRectArr = [rect0];
      }
      
      public function set y(num0:int) : *
      {
         this.img.y = num0;
         var rect0:Rectangle = this.hitRect0.clone();
         rect0.x += this.img.x;
         rect0.y += this.img.y;
         this.AAHD.hurtRectArr = [rect0];
      }
      
      public function hurtEffectShow(redB:Boolean = false) : *
      {
         var ct:ColorTransform = null;
         var c0:Number = 0.7;
         var c1:int = c0 * 255;
         if(redB)
         {
            ct = new ColorTransform(c0,c0,c0,1,c1,0,0,0);
         }
         else
         {
            ct = new ColorTransform(c0,c0,c0,1,c1,c1,c1,0);
         }
         this.img.transform.colorTransform = ct;
         this.color_t = 1;
      }
      
      public function hurtEffectHide() : *
      {
         this.img.transform.colorTransform = this.colorF;
      }
      
      public function get x() : int
      {
         return this.img.x;
      }
      
      public function get y() : int
      {
         return this.img.y;
      }
      
      public function bodyTimer() : *
      {
         if(this.color_t > 0)
         {
            --this.color_t;
         }
         else if(this.color_t == 0)
         {
            this.hurtEffectHide();
            this.color_t = -1;
         }
      }
   }
}

