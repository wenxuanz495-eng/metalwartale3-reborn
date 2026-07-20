package UI.fase
{
   import body.motion.SuspendMotion;
   import data.INIT;
   import flash.display.MovieClip;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   
   public class FaceGameSpacecraft extends MovieClip
   {
      
      public var hurtValue:int = 0;
      
      public var die:int = 0;
      
      public var rect:Rectangle = new Rectangle(-102,-19,192,33);
      
      public var mot:SuspendMotion = new SuspendMotion();
      
      private var hurtTime:int = 0;
      
      public var hurt_t:int = 0;
      
      public var colorF:ColorTransform = new ColorTransform();
      
      public var colorF2:ColorTransform = null;
      
      public var baseV:Number = 0;
      
      public var now_t:Number = 0;
      
      public function FaceGameSpacecraft()
      {
         super();
         this.stop();
         this.mot.inData(90,90,1);
         this.init();
         this.baseV = this.mot.vxmax;
      }
      
      public function init() : *
      {
         this.gotoAndStop(1);
         this.hurtValue = 0;
         this.die = 0;
         this.mot.setX(1040);
         var my0:int = 200 - 100 + 200 * Math.random();
         this.mot.setY(my0);
         this.x = this.mot.x0;
         this.y = this.mot.y0;
         this.mot.toStopBreak();
      }
      
      public function getHitRect() : Rectangle
      {
         var rect0:Rectangle = this.rect.clone();
         if(scaleX < 0)
         {
            rect0.x = -(rect0.x + rect0.width);
         }
         rect0.x += this.x;
         rect0.y += this.y;
         return rect0;
      }
      
      public function hurt() : *
      {
         var num0:int = 0;
         trace("受伤！！！！");
         if(this.die == 0)
         {
            this.startHurtEffect();
            ++this.hurtValue;
            num0 = int(this.hurtValue / 3) + 1;
            if(this.hurtValue >= 12)
            {
               this.gotoAndPlay(num0);
               this.die = 1;
               this.mot.toStopBreak();
               if(Game.gameData.username != "")
               {
                  ++Game.gameData.giftData.killAirshipNum;
                  Game.testText.addTestText("添加到 killAirshipNum:" + Game.gameData.giftData.killAirshipNum);
               }
               else
               {
                  ++Game.gameData.giftData.temp_killAirshipNum;
                  Game.testText.addTestText("添加到 temp_killAirshipNum:" + Game.gameData.giftData.temp_killAirshipNum);
               }
            }
            else
            {
               this.gotoAndStop(num0);
            }
         }
      }
      
      public function motionTimer() : *
      {
         var mx0:int = 0;
         var my0:int = 0;
         if(this.mot.getGap() < 50)
         {
            mx0 = this.mot.x0 - 200;
            my0 = 200 - 100 + 200 * Math.random();
            this.mot.followPoint(mx0,my0);
         }
         this.mot.motionTimer();
         if(this.now_t > 2)
         {
            this.now_t = 0;
            this.mot.vxmax = this.baseV * (Math.random() * 1.7 + 0.3);
         }
         else
         {
            this.now_t += 1 / 30;
         }
      }
      
      public function startHurtEffect(_hurtTime:Number = 0.2) : *
      {
         if(this.hurt_t == -1 || this.hurt_t % 2 == 0)
         {
            this.hurt_t = 0;
         }
         else
         {
            this.hurt_t = 1;
         }
         this.hurtTime = _hurtTime * INIT.FPS;
      }
      
      public function stopHurtEffect() : *
      {
         this.hurtEffectHide();
         this.hurt_t = -1;
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
         this.transform.colorTransform = ct;
      }
      
      public function hurtEffectHide() : *
      {
         if(this.colorF2 == null)
         {
            this.transform.colorTransform = this.colorF;
         }
         else
         {
            this.transform.colorTransform = this.colorF2;
         }
      }
      
      public function timer() : *
      {
         this.x = this.mot.x0;
         this.y = this.mot.y0;
         if(this.die == 0)
         {
            this.motionTimer();
            if(this.mot.x0 < -188)
            {
               this.init();
            }
         }
         else if(this.currentFrame >= this.totalFrames - 1)
         {
            this.init();
         }
         if(this.hurt_t >= this.hurtTime)
         {
            this.stopHurtEffect();
         }
         else if(this.hurt_t < this.hurtTime && this.hurt_t >= 0)
         {
            if(this.hurt_t % 2 == 0)
            {
               this.hurtEffectShow();
            }
            else
            {
               this.hurtEffectHide();
            }
            ++this.hurt_t;
         }
      }
   }
}

