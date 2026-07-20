package body.hero
{
   import body.image.DisplayMotionDefine;
   import body.image.MultipleImage;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class HeroFlyImage extends Sprite
   {
      
      public var allImg:HeroCarImage;
      
      public var img:MultipleImage = new MultipleImage();
      
      public var arm:MovieClip;
      
      private var armsP:DisplayMotionDefine = new DisplayMotionDefine();
      
      public var carVislble:Boolean = true;
      
      public function HeroFlyImage()
      {
         super();
         addChild(this.img);
      }
      
      public function setArmMc(mc0:MovieClip) : *
      {
         this.arm = mc0;
         addChildAt(this.arm,0);
         this.stopArms();
      }
      
      public function inMouseXY(x0:Number, y0:Number) : Boolean
      {
         var a_tan:Number = NaN;
         var rightB:Boolean = x0 - this.armsP.x < 0;
         if(this.img.nowLabel == "stop")
         {
            this.fleshArmsPoint();
            a_tan = Math.atan2(y0 - this.armsP.y,x0 - this.armsP.x);
            if(rightB)
            {
               a_tan = -Math.atan2(y0 - this.armsP.y,x0 + this.armsP.x) - Math.PI;
            }
            this.arm.rotation = a_tan * 180 / Math.PI;
            this.arm.x = this.armsP.x;
            this.arm.y = this.armsP.y;
         }
         return !rightB;
      }
      
      private function fleshArmsPoint() : *
      {
         var mc0:* = undefined;
         var mc1:DisplayObject = null;
         this.armsP.alpha = 0;
         if(Boolean(this.img.nowMC))
         {
            mc0 = this.img.nowMC.mc;
            mc1 = mc0.getChildByName("armsPoint");
            if(Boolean(mc1))
            {
               this.armsP.x = mc1.x;
               this.armsP.y = mc1.y;
               this.armsP.rotation = mc1.rotation;
               this.armsP.alpha = 1;
            }
         }
      }
      
      public function playArms() : *
      {
         if(this.arm.currentFrame < 2)
         {
            this.arm.gotoAndPlay(2);
         }
      }
      
      public function stopArms() : *
      {
         this.arm.gotoAndStop(1);
      }
      
      public function imageTimer() : *
      {
         this.fleshArmsPoint();
         this.carVislble = true;
         visible = false;
         if(this.allImg.bodyState == "fly")
         {
            this.carVislble = false;
            visible = true;
            if(this.img.nowLabel == "toFly")
            {
               if(this.img.nowMC.currentFrame < 9)
               {
                  this.carVislble = true;
               }
            }
         }
         else
         {
            visible = false;
            if(this.img.nowLabel == "toStand")
            {
               if(this.img.nowMC.currentFrame < 16)
               {
                  visible = true;
                  this.carVislble = false;
               }
            }
         }
         if(this.img.nowLabel != "stop")
         {
            if(Boolean(this.arm))
            {
               this.arm.rotation = this.armsP.rotation;
               this.arm.x = this.armsP.x;
               this.arm.y = this.armsP.y;
               this.arm.alpha = this.armsP.alpha;
            }
         }
         this.img.imageTimer();
      }
   }
}

