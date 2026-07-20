package image
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class BmpMovieClip extends Sprite
   {
      
      private var bmpArr:Array = new Array();
      
      private var rectArr:Array = new Array();
      
      private var bmp:Bitmap;
      
      public var isPlaying:Boolean = true;
      
      public var currentFrame:int;
      
      public var totalFrames:int;
      
      public var label:String = "";
      
      public var father:String = "";
      
      public var speed:int = 1;
      
      private var now_s:int = 0;
      
      private var timemc:MovieClip = new MovieClip();
      
      public function BmpMovieClip(in_mc:MovieClip = null)
      {
         super();
         if(in_mc is MovieClip)
         {
            this.Switch(in_mc);
            this.setData_byRect(this.rectArr[0]);
         }
      }
      
      protected function Switch(mc:MovieClip) : *
      {
         var n:int = 0;
         var f0:int = 0;
         var yushu:int = 0;
         var f_l1:String = null;
         var f1:int = 0;
         var rect0:Rectangle = null;
         var mix:Matrix = null;
         var bmp0:BitmapData = null;
         this.totalFrames = mc.totalFrames;
         this.currentFrame = 1;
         mc.gotoAndStop(1);
         var f_l:String = mc.currentFrameLabel;
         var fps:int = 1;
         if(f_l != null)
         {
            f0 = f_l.indexOf("fps_");
            if(f0 != -1)
            {
               fps = int(f_l.substr(4));
               trace("fps:" + fps);
            }
         }
         for(n = 0; n <= this.totalFrames - 1; n++)
         {
            mc.gotoAndStop(n + 1);
            yushu = n % fps;
            f_l1 = mc.currentLabel;
            if(f_l1 is String)
            {
               f1 = f_l1.indexOf("fps1");
            }
            if(yushu == 0 || f1 >= 0)
            {
               rect0 = mc.getRect(mc);
               if(rect0.width == 0)
               {
                  rect0.width = 1;
               }
               if(rect0.height == 0)
               {
                  rect0.height = 1;
               }
               rect0.x = this.getInt(rect0.x);
               rect0.y = this.getInt(rect0.y);
               rect0.width = this.getInt(rect0.width);
               rect0.height = this.getInt(rect0.height);
               mix = new Matrix();
               mix.tx = -rect0.x;
               mix.ty = -rect0.y;
               bmp0 = new BitmapData(rect0.width,rect0.height,true,0);
               bmp0.draw(mc,mix);
               this.bmpArr[n] = bmp0;
               this.rectArr[n] = rect0;
            }
            else
            {
               this.bmpArr[n] = this.bmpArr[n - 1];
               this.rectArr[n] = this.rectArr[n - 1];
            }
         }
      }
      
      private function setData_byRect(rect:Rectangle) : *
      {
         this.bmp = new Bitmap();
         this.bmp.x = rect.x;
         this.bmp.y = rect.y;
         addChild(this.bmp);
         this.timemc.addEventListener(Event.ENTER_FRAME,this.TT);
      }
      
      private function getInt(num:Number) : int
      {
         var num0:int = int(num);
         var _num:int = num0;
         if(num0 > 0)
         {
            if(num0 < num)
            {
               _num = num0 + 1;
            }
         }
         else if(num0 > num)
         {
            _num = num0 - 1;
         }
         return _num;
      }
      
      public function copy() : BmpMovieClip
      {
         var newBmp:BmpMovieClip = new BmpMovieClip();
         newBmp.bmpArr = this.bmpArr;
         newBmp.rectArr = this.rectArr;
         newBmp.currentFrame = 1;
         newBmp.totalFrames = this.totalFrames;
         newBmp.setData_byRect(this.rectArr[0]);
         newBmp.gotoAndStop(1);
         return newBmp;
      }
      
      public function stop() : *
      {
         this.isPlaying = false;
      }
      
      public function play() : *
      {
         this.isPlaying = true;
      }
      
      public function gotoAndPlay(num:int) : *
      {
         var num0:int = num;
         if(num < 0 || num > this.totalFrames)
         {
            num = 1;
         }
         this.currentFrame = num0;
         this.isPlaying = true;
      }
      
      public function gotoAndStop(num:int) : *
      {
         var num0:int = num;
         if(num < 0 || num > this.totalFrames)
         {
            num = 1;
         }
         this.currentFrame = num0;
         this.isPlaying = false;
         var bmp0:BitmapData = this.bmpArr[this.currentFrame - 1];
         this.bmp.bitmapData = bmp0;
         this.bmp.x = this.rectArr[this.currentFrame - 1].x;
         this.bmp.y = this.rectArr[this.currentFrame - 1].y;
      }
      
      public function getMemorys() : Number
      {
         var n:* = undefined;
         var bmp0:BitmapData = null;
         var mm:Number = 0;
         for(n in this.bmpArr)
         {
            bmp0 = this.bmpArr[n];
            mm += bmp0.width * bmp0.height * 4 / 1000000;
         }
         return mm;
      }
      
      public function killMe() : *
      {
         this.stop();
         this.isPlaying = false;
         this.bmpArr = null;
         this.rectArr = null;
         this.bmp = null;
         this.timemc.removeEventListener(Event.ENTER_FRAME,this.TT);
      }
      
      private function TT(e:Event) : *
      {
         var bmp0:BitmapData = null;
         if(this.isPlaying)
         {
            if(this.now_s % this.speed == 0)
            {
               this.now_s = 0;
               if(this.bmpArr.length > 0)
               {
                  if(this.currentFrame >= this.totalFrames)
                  {
                     this.currentFrame = 1;
                  }
                  else
                  {
                     ++this.currentFrame;
                  }
                  bmp0 = this.bmpArr[this.currentFrame - 1];
                  this.bmp.x = this.rectArr[this.currentFrame - 1].x;
                  this.bmp.y = this.rectArr[this.currentFrame - 1].y;
                  this.bmp.bitmapData = bmp0;
               }
            }
            ++this.now_s;
         }
      }
   }
}

