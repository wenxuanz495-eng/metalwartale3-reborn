package UI.dialog
{
   import data.Maths;
   import fl.motion.Color;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.Graphics;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import gs.TweenLite;
   import gs.easing.Bounce;
   import gs.easing.Strong;
   
   public class Dialogbox extends MovieClip
   {
      
      public var refreshB:Boolean = true;
      
      private var x1:int = 42;
      
      private var x2:int = 90;
      
      private var y1:int = 41;
      
      private var y2:int = 56;
      
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
      
      private var type_t:int = -1;
      
      private var showTime:int = 150;
      
      private var show_t:int = -1;
      
      internal var showSp:MovieClip;
      
      internal var hideSp:MovieClip;
      
      internal var loopSp:MovieClip;
      
      public var label:String = "";
      
      public var addB:Boolean = false;
      
      public var followBody:*;
      
      public var px:Number = 0;
      
      public var py:Number = 0;
      
      private var line0:Shape = new Shape();
      
      private var linePoint:Point = new Point();
      
      public function Dialogbox()
      {
         super();
         addChild(this.line0);
         addChild(this.sp);
      }
      
      public function init() : *
      {
         if(this.addB)
         {
         }
         this.addB = true;
      }
      
      public function show(con:DisplayObjectContainer, text0:String, _x0:int, _y0:int, _mx:Number = 0, _my:Number = 0, _followBody:* = null, _time:Number = 5, _width:int = -1, _linePoint:Point = null) : *
      {
         this.visible = true;
         TweenLite.killTweensOf(this.ct);
         TweenLite.killTweensOf(this);
         TweenLite.killTweensOf(this.sp);
         this.followBody = _followBody;
         if(this.parent != con)
         {
            con.addChild(this);
         }
         this.showSp.gotoAndPlay(2);
         this.hideText();
         this.str = text0;
         if(this.followBody != null)
         {
            this.px = _x0;
            this.py = _y0;
            x = this.followBody.MX + _x0;
            y = this.followBody.MY + _y0;
         }
         else
         {
            x = _x0;
            y = _y0;
         }
         this.mx = _mx;
         this.my = _my;
         this.showTime = _time * 30;
         this.show_t = 0;
         var lenx:Number = Math.sqrt(this.str.length);
         var w0:int = lenx * 18 + 50;
         if(_width > w0)
         {
            w0 = _width;
         }
         var h0:int = lenx * 12 + 30;
         this.show2(w0,h0);
         this.linePoint = _linePoint;
         this.init();
         var gh:Graphics = this.line0.graphics;
         gh.clear();
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
         if(this._h < 20)
         {
            this._w = 5;
            this._h = 10;
         }
         this.fleshSize();
         this.ct.brightness = 1;
         this.useColor();
         this.mw = w0;
         this.mh = h0;
         this.sp.alpha = 1;
         TweenLite.to(this.ct,0.2,{
            "brightness":0,
            "ease":Bounce.easeIn,
            "onComplete":this.tweenShow
         });
      }
      
      private function tweenShow() : *
      {
         if(this._h < 20)
         {
            this._h = 2;
         }
         TweenLite.to(this,0.2,{
            "w":this.mw,
            "ease":Strong.easeOut,
            "onComplete":this.tweenToH
         });
         this.ct.brightness = 1;
         this.useColor();
      }
      
      private function tweenToH() : *
      {
         TweenLite.to(this,0.2,{
            "h":this.mh,
            "ease":Strong.easeOut,
            "onComplete":this.tweenToAlpha
         });
      }
      
      private function tweenToAlpha() : *
      {
         TweenLite.to(this.ct,0.2,{
            "brightness":0,
            "onUpdate":this.useColor
         });
         TweenLite.to(this.sp,0.2,{
            "alpha":0.8,
            "ease":Strong.easeOut
         });
         this.drawLine();
         this.showText();
      }
      
      private function useColor() : *
      {
         this.sp.transform.colorTransform = this.ct;
      }
      
      public function hide() : *
      {
         this.hideSp.gotoAndPlay(2);
         this.ct.brightness = 1;
         this.useColor();
         this.mw = 5;
         this.mh = 2;
         this.hideText();
         TweenLite.to(this,0.2,{
            "h":this.mh,
            "ease":Strong.easeOut,
            "onComplete":this.tweenToH2
         });
         this.line0.graphics.clear();
      }
      
      private function tweenToH2() : *
      {
         TweenLite.to(this,0.2,{
            "w":this.mw,
            "ease":Strong.easeOut,
            "delay":0.05,
            "onComplete":this.tweenToAlpha2
         });
      }
      
      private function tweenToAlpha2() : *
      {
         this.sp.visible = false;
         this.addB = false;
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
         this.text.text = "";
         this.type_t = 0;
         this.text.x = this.sp.x + 13;
         this.text.y = this.sp.y + 13;
         this.text.width = this.sp.width - 20;
         this.text.height = this.sp.height - 20;
         this.text.visible = true;
         this.loopSp.gotoAndPlay(2);
      }
      
      private function hideText() : *
      {
         this.loopSp.gotoAndStop(1);
         this.text.visible = false;
         this.text.text = "";
      }
      
      public function inSoundData(_showSound:*, _hideSound:*, _loop:*) : *
      {
      }
      
      public function inBackData(sp0:*) : *
      {
         var n:* = undefined;
         var bmp00:Bitmap = null;
         this.text = sp0.txt;
         sp0.removeChild(sp0.txt);
         this.text.text = "";
         addChild(this.text);
         this.showSp = sp0.showSp;
         this.hideSp = sp0.hideSp;
         this.loopSp = sp0.loopSp;
         sp0.removeChild(sp0.showSp);
         sp0.removeChild(sp0.hideSp);
         sp0.removeChild(sp0.loopSp);
         sp0.showSp.stop();
         sp0.hideSp.stop();
         sp0.loopSp.stop();
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
         this._w = 5;
         this._h = 10;
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
         this.followBody = null;
         this.line0.graphics.clear();
         this.showSp.gotoAndStop(1);
         this.hideSp.gotoAndStop(1);
         this.loopSp.gotoAndStop(1);
         this.show_t = -1;
         this.type_t = -1;
         this._w = 5;
         this._h = 10;
         this.visible = false;
         this.fleshSize();
      }
      
      public function timer() : *
      {
         if(this.refreshB)
         {
            if(this.type_t >= 0)
            {
               this.type_t = 0;
               if(this.text.length < this.str.length)
               {
                  this.text.appendText(this.str.substr(this.text.length,1));
                  this.loopSp.play();
               }
               else
               {
                  this.loopSp.gotoAndStop(1);
                  this.type_t = -1;
               }
            }
            else if(this.type_t >= 0)
            {
               ++this.type_t;
            }
            if(this.show_t >= this.showTime)
            {
               this.hide();
               this.show_t = -1;
            }
            else if(this.show_t >= 0)
            {
               if(this.followBody != null)
               {
                  x = this.followBody.MX + this.px;
                  y = this.followBody.MY + this.py;
               }
               ++this.show_t;
            }
         }
      }
   }
}

