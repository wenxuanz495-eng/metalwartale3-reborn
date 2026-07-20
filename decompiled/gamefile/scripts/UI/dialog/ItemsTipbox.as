package UI.dialog
{
   import data.Maths;
   import fl.motion.Color;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import gs.TweenLite;
   import gs.easing.Strong;
   
   public class ItemsTipbox extends MovieClip
   {
      
      private var x1:int = 34;
      
      private var x2:int = 129;
      
      private var y1:int = 36;
      
      private var y2:int = 167;
      
      public var sp:Sprite = new Sprite();
      
      public var mx:Number = 0;
      
      public var my:Number = 0;
      
      public var arr:Array = [];
      
      public var bmpArr:Array = [];
      
      private var _w:int = 0;
      
      private var _h:int = 0;
      
      private var mw:int = 0;
      
      private var mh:int = 0;
      
      private var ct:Color = new Color();
      
      private var text:TextField = new TextField();
      
      private var str:String = "";
      
      private var targetSp:*;
      
      public var label:String = "";
      
      public var px:Number = 0;
      
      public var py:Number = 0;
      
      private var line0:Shape = new Shape();
      
      private var linePoint:Point = new Point();
      
      public function ItemsTipbox()
      {
         super();
         addChild(this.line0);
         addChild(this.sp);
         this.mouseChildren = false;
         this.mouseEnabled = false;
      }
      
      public function init() : *
      {
         this.line0.visible = false;
      }
      
      public function showDialog(_targetSp:*, _focusSp:*, _x0:int, _y0:int, xState:int = -1, yState:int = -1) : *
      {
         var _mx:* = 0;
         var _my:* = 0;
         if(yState == -1)
         {
            if(_y0 < 250)
            {
               _my = 0;
            }
            else
            {
               _y0 += _focusSp.height;
               _my = 1;
            }
         }
         else if(yState == 0)
         {
            _my = 0;
         }
         else
         {
            _y0 += _focusSp.height;
            _my = 1;
         }
         if(xState == -1)
         {
            if(_x0 < Game.stageWidth / 2)
            {
               _mx = 0;
               _x0 += _focusSp.width;
            }
            else
            {
               _mx = 1;
            }
         }
         else if(xState == 0)
         {
            _mx = 0;
            _x0 += _focusSp.width;
         }
         else
         {
            _mx = 1;
         }
         this.show(_targetSp,_x0,_y0,_mx,_my);
      }
      
      private function show(_targetSp:*, _x0:int, _y0:int, _mx:Number = 0, _my:Number = 0, _linePoint:Point = null) : *
      {
         this.visible = true;
         TweenLite.killTweensOf(this.ct);
         TweenLite.killTweensOf(this);
         TweenLite.killTweensOf(this.sp);
         x = _x0;
         y = _y0;
         this.mx = _mx;
         this.my = _my;
         this.targetSp = _targetSp;
         var rect0:Rectangle = this.targetSp.getRect(this.targetSp);
         var w0:int = rect0.width + 25;
         var h0:int = rect0.height + 25;
         if(h0 + y > 460 && _my == 0)
         {
            y = 460 - h0;
         }
         else if(y - h0 < 10 && _my == 1)
         {
            y = 10 + h0;
         }
         this.hideText();
         this.show2(w0,h0);
         this.linePoint = _linePoint;
      }
      
      private function drawLine() : *
      {
         var gh:Graphics = null;
         var pointA:Point = null;
         var pointB:Point = null;
         var pointC:Point = null;
         if(this.linePoint is Point)
         {
            gh = this.line0.graphics;
            gh.clear();
            pointA = new Point(5 * Maths.Pn(-this.linePoint.x),0);
            pointB = new Point(-5 * Maths.Pn(-this.linePoint.x),0);
            pointC = this.linePoint;
            gh.beginFill(124155,0.7);
            gh.moveTo(pointA.x,pointA.y);
            gh.lineTo(pointB.x,pointB.y);
            gh.lineTo(pointC.x,pointC.y);
            gh.lineTo(pointA.x,pointA.y);
         }
      }
      
      private function show2(w0:int, h0:int) : *
      {
         this.sp.visible = true;
         this.fleshSize();
         this.mw = w0;
         this.mh = h0;
         this.alpha = 0;
         this.w = this.mw;
         this.h = this.mh;
         TweenLite.to(this,0.2,{
            "alpha":1,
            "onStart":this.tweenToAlpha
         });
      }
      
      private function tweenToH() : *
      {
         TweenLite.to(this,0.1,{
            "h":this.mh,
            "ease":Strong.easeOut,
            "onComplete":this.tweenToAlpha
         });
      }
      
      private function tweenToAlpha() : *
      {
         this.targetSp.alpha = 0;
         TweenLite.to(this.targetSp,0.2,{"alpha":1});
         this.drawLine();
         this.showText();
      }
      
      private function useColor() : *
      {
         this.sp.transform.colorTransform = this.ct;
      }
      
      public function hide() : *
      {
         TweenLite.killTweensOf(this.ct);
         TweenLite.killTweensOf(this);
         TweenLite.killTweensOf(this.sp);
         this.hideText();
         this.visible = false;
         this.line0.graphics.clear();
      }
      
      public function set w(value:int) : *
      {
         this._w = value;
         this.fleshSize();
      }
      
      public function set h(value:int) : *
      {
         this._h = value;
         this.fleshSize();
      }
      
      public function get w() : int
      {
         return this._w;
      }
      
      public function get h() : int
      {
         return this._h;
      }
      
      private function showText() : *
      {
         this.targetSp.visible = true;
         this.targetSp.x = 10 + this.x + this.sp.x;
         this.targetSp.y = 10 + this.y + this.sp.y;
      }
      
      private function hideText() : *
      {
         if(this.targetSp != null)
         {
            this.targetSp.visible = false;
         }
      }
      
      public function inBackData(sp0:*) : *
      {
         var n:* = undefined;
         var bmp00:Bitmap = null;
         var rect0:Rectangle = sp0.getRect(sp0);
         var x3:int = rect0.width;
         var y3:int = rect0.height;
         var bmp0:BitmapData = new BitmapData(rect0.width,rect0.height,true,0);
         bmp0.draw(sp0);
         this.arr[0] = new BitmapData(this.x1,this.y1,true,0);
         this.arr[0].copyPixels(bmp0,new Rectangle(0,0,this.x1,this.y1),new Point());
         this.arr[1] = new BitmapData(this.x2 - this.x1,this.y1,true,0);
         this.arr[1].copyPixels(bmp0,new Rectangle(this.x1,0,this.x2 - this.x1,this.y1),new Point());
         this.arr[2] = new BitmapData(x3 - this.x2,this.y1,true,0);
         this.arr[2].copyPixels(bmp0,new Rectangle(this.x2,0,x3 - this.x2,this.y1),new Point());
         this.arr[3] = new BitmapData(this.x1,this.y2 - this.y1,true,0);
         this.arr[3].copyPixels(bmp0,new Rectangle(0,this.y1,this.x1,this.y2 - this.y1),new Point());
         this.arr[4] = new BitmapData(this.x2 - this.x1,this.y2 - this.y1,true,0);
         this.arr[4].copyPixels(bmp0,new Rectangle(this.x1,this.y1,this.x2 - this.x1,this.y2 - this.y1),new Point());
         this.arr[5] = new BitmapData(x3 - this.x2,this.y2 - this.y1,true,0);
         this.arr[5].copyPixels(bmp0,new Rectangle(this.x2,this.y1,x3 - this.x2,this.y2 - this.y1),new Point());
         this.arr[6] = new BitmapData(this.x1,y3 - this.y2,true,0);
         this.arr[6].copyPixels(bmp0,new Rectangle(0,this.y2,this.x1,y3 - this.y2),new Point());
         this.arr[7] = new BitmapData(this.x2 - this.x1,y3 - this.y2,true,0);
         this.arr[7].copyPixels(bmp0,new Rectangle(this.x1,this.y2,this.x2 - this.x1,y3 - this.y2),new Point());
         this.arr[8] = new BitmapData(x3 - this.x2,y3 - this.y2,true,0);
         this.arr[8].copyPixels(bmp0,new Rectangle(this.x2,this.y2,x3 - this.x2,y3 - this.y2),new Point());
         for(n in this.arr)
         {
            bmp00 = new Bitmap(this.arr[n],"auto",false);
            this.bmpArr[n] = bmp00;
            this.sp.addChild(this.bmpArr[n]);
         }
         this._w = 100;
         this._h = 100;
         this.fleshSize();
      }
      
      public function fleshSize() : *
      {
         var w0:int = this._w;
         var h0:int = this._h;
         var w1:int = w0 - this.bmpArr[0].width - this.bmpArr[2].width;
         if(w1 < 0)
         {
            this.sp.scaleX = w0 / (this.bmpArr[0].width + this.bmpArr[2].width);
            w1 = 0;
         }
         else
         {
            this.sp.scaleX = 1;
         }
         var h1:int = h0 - this.bmpArr[0].height - this.bmpArr[6].height;
         if(h1 < 0)
         {
            this.sp.scaleY = h0 / (this.bmpArr[0].height + this.bmpArr[6].height);
            h1 = 0;
         }
         else
         {
            this.sp.scaleY = 1;
         }
         this.bmpArr[0].x = 0;
         this.bmpArr[0].y = 0;
         this.bmpArr[1].x = this.bmpArr[0].width;
         this.bmpArr[1].y = 0;
         this.bmpArr[1].width = w1;
         this.bmpArr[2].x = this.bmpArr[1].x + this.bmpArr[1].width;
         this.bmpArr[2].y = 0;
         this.bmpArr[3].x = 0;
         this.bmpArr[3].y = this.bmpArr[0].height;
         this.bmpArr[3].height = h1;
         this.bmpArr[4].x = this.bmpArr[0].width;
         this.bmpArr[4].y = this.bmpArr[0].height;
         this.bmpArr[4].width = w1;
         this.bmpArr[4].height = h1;
         this.bmpArr[5].x = this.bmpArr[1].x + this.bmpArr[1].width;
         this.bmpArr[5].y = this.bmpArr[0].height;
         this.bmpArr[5].height = h1;
         this.bmpArr[6].x = 0;
         this.bmpArr[6].y = this.bmpArr[3].y + this.bmpArr[3].height;
         this.bmpArr[7].x = this.bmpArr[0].width;
         this.bmpArr[7].y = this.bmpArr[3].y + this.bmpArr[3].height;
         this.bmpArr[7].width = w1;
         this.bmpArr[8].x = this.bmpArr[1].x + this.bmpArr[1].width;
         this.bmpArr[8].y = this.bmpArr[3].y + this.bmpArr[3].height;
         this.sp.x = int(-(this.bmpArr[0].width + this.bmpArr[1].width + this.bmpArr[2].width) * this.sp.scaleX * this.mx);
         this.sp.y = int(-(this.bmpArr[0].height + this.bmpArr[3].height + this.bmpArr[6].height) * this.sp.scaleY * this.my);
      }
      
      public function clear() : *
      {
         TweenLite.killTweensOf(this.ct);
         TweenLite.killTweensOf(this);
         TweenLite.killTweensOf(this.sp);
         this.line0.graphics.clear();
         this.visible = false;
      }
   }
}

