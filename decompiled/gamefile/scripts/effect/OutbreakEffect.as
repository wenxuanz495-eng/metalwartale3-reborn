package effect
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class OutbreakEffect extends MovieClip
   {
      
      public var tweenB:Boolean = false;
      
      public var timeFun:Function;
      
      public var target_mc:*;
      
      public var target_width:int = 10;
      
      public var target_height:int = 10;
      
      public var tt:Number = 0;
      
      public var bitmap:Bitmap = new Bitmap();
      
      public var bmp:BitmapData = new BitmapData(10,10);
      
      public var bmpBackup:BitmapData = new BitmapData(10,10);
      
      public var colorF1:ColorTransform = new ColorTransform(2,2,2,0.4);
      
      public var colorF2:ColorTransform = new ColorTransform(1,1,1,0.9);
      
      public var bmpMatrix:Matrix = new Matrix();
      
      public var bmpRect:Rectangle = new Rectangle();
      
      public var bmpPoint:Point = new Point();
      
      public function OutbreakEffect()
      {
         super();
      }
      
      public function init(mc0:*, w0:int, h0:int) : *
      {
         this.target_mc = mc0;
         this.target_width = w0;
         this.target_height = h0;
         addChildAt(this.bitmap,0);
         this.addEventListener(Event.ENTER_FRAME,this.timer);
      }
      
      public function start(x0:int, y0:int) : *
      {
         this.clear();
         this.bmp = new BitmapData(this.target_width,this.target_height,true,0);
         this.bmpBackup = this.bmp.clone();
         this.bitmap.bitmapData = this.bmp;
         this.bmpRect = new Rectangle(0,0,this.bmp.width,this.bmp.height);
         this.bmpBackup.draw(this.target_mc,null,this.colorF1);
         this.bmpMatrix = new Matrix();
         this.bmpMatrix.tx -= x0;
         this.bmpMatrix.ty -= y0;
         this.bmpMatrix.scale(1.06,1.06);
         this.bmpMatrix.tx += x0;
         this.bmpMatrix.ty += y0;
         this.tweenB = true;
      }
      
      public function stopAll() : *
      {
         this.tweenB = false;
      }
      
      public function clear() : *
      {
         this.stopAll();
         this.bmp.dispose();
         this.bmpBackup.dispose();
      }
      
      public function timer(e:*) : *
      {
         var bmp1:BitmapData = null;
         var matrix0:Matrix = null;
         if(this.tweenB)
         {
            this.tt += 1 / 15;
            if(this.tt >= Math.PI * 2)
            {
               this.tt = 0;
            }
            bmp1 = this.bmp.clone();
            this.bmp.copyPixels(this.bmpBackup,this.bmpRect,this.bmpPoint);
            matrix0 = this.bmpMatrix.clone();
            matrix0.tx += Math.sin(this.tt) * 1;
            matrix0.ty += Math.cos(this.tt) * 1;
            this.bmp.draw(bmp1,matrix0,this.colorF2,BlendMode.ADD,null,true);
            if(this.timeFun is Function)
            {
               this.timeFun();
            }
         }
      }
   }
}

