package effect
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.BlurFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class GhostingEffectBMC extends Sprite
   {
      
      private var bmpArr:Array = new Array();
      
      private var bmp:Bitmap = new Bitmap();
      
      private var rect:Rectangle;
      
      public var isPlaying:Boolean = false;
      
      public var currentFrame:int;
      
      public var totalFrames:int;
      
      public var label:String = "";
      
      public var father:String = "";
      
      public var speed:int = 1;
      
      private var now_s:int = 0;
      
      private var timemc:MovieClip = new MovieClip();
      
      public function GhostingEffectBMC()
      {
         super();
      }
      
      public function Switch(mc:DisplayObject, flipB:Boolean = false) : *
      {
         var rect0:Rectangle = mc.getRect(mc);
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
         rect0.x -= 20;
         rect0.width += 20;
         var mix:Matrix = new Matrix();
         if(flipB)
         {
            mix.scale(-1,1);
            mix.tx = rect0.width + rect0.x;
            rect0.x = -(rect0.width + rect0.x);
         }
         else
         {
            mix.tx = -rect0.x;
         }
         this.rect = rect0;
         mix.ty = -rect0.y;
         var bmp0:BitmapData = new BitmapData(rect0.width,rect0.height,true,0);
         bmp0.draw(mc,mix);
         this.createAnimation(bmp0,8);
      }
      
      protected function createAnimation(bmp0:BitmapData, len0:int) : *
      {
         var bmp1:BitmapData = null;
         var rect0:Rectangle = new Rectangle(0,0,bmp0.width,bmp0.height);
         var np:Point = new Point();
         var bf:BlurFilter = new BlurFilter(6,0);
         this.bmpArr[0] = bmp0;
         for(var n:int = 1; n < len0; n++)
         {
            bmp1 = new BitmapData(bmp0.width,bmp0.height,true,0);
            bmp1.applyFilter(this.bmpArr[n - 1],rect0,np,bf);
            bmp1.colorTransform(rect0,new ColorTransform(1,1,1,1 - n / len0 * 0.9));
            this.bmpArr[n] = bmp1;
         }
         this.bmpArr.shift();
         this.init();
      }
      
      private function init() : *
      {
         this.bmp.x = this.rect.x;
         this.bmp.y = this.rect.y;
         addChild(this.bmp);
         this.currentFrame = 0;
         this.totalFrames = this.bmpArr.length;
         this.gotoAndStop(1);
         this.timemc.addEventListener(Event.ENTER_FRAME,this.TT);
      }
      
      public function copy() : GhostingEffectBMC
      {
         var ge:GhostingEffectBMC = new GhostingEffectBMC();
         ge.rect = this.rect;
         ge.bmpArr = this.bmpArr;
         ge.init();
         return ge;
      }
      
      public function dispose() : *
      {
         var n:* = undefined;
         for(n in this.bmpArr)
         {
            this.bmpArr[n].dispose();
         }
         this.killMe();
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
      }
      
      public function killMe() : *
      {
         this.stop();
         this.isPlaying = false;
         this.bmpArr = null;
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
                  if(this.currentFrame > this.totalFrames)
                  {
                     this.currentFrame = 1;
                  }
                  else
                  {
                     ++this.currentFrame;
                  }
                  bmp0 = this.bmpArr[this.currentFrame - 1];
                  this.bmp.bitmapData = bmp0;
               }
            }
            ++this.now_s;
         }
      }
   }
}

