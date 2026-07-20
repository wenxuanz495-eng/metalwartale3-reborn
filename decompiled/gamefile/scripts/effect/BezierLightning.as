package effect
{
   import data.Bezier;
   import flash.display.Shape;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   
   public class BezierLightning extends Shape
   {
      
      public var p0:Point = new Point();
      
      public var p2:Point = new Point();
      
      public var ra:Number = 0;
      
      public var range:int = 15;
      
      public var enabled:Boolean = false;
      
      public var lineColor:uint = 10152703;
      
      public var time:int = 0;
      
      public var _t:int = 0;
      
      public function BezierLightning(_lineColor:uint = 16777215, filterColor:uint = 35564)
      {
         super();
         this.lineColor = _lineColor;
         var glowing:GlowFilter = new GlowFilter(filterColor,1,10,10);
         this.filters = [glowing];
      }
      
      public function init() : *
      {
         if(this.enabled)
         {
            if(this._t > this.time)
            {
               this.Hide();
            }
            else
            {
               this.Draw();
               ++this._t;
            }
         }
      }
      
      private function Draw() : void
      {
         var arr0:Array = null;
         var x0:Number = NaN;
         var y0:Number = NaN;
         var ra0:Number = NaN;
         var ppxy:Number = NaN;
         var rx:* = undefined;
         var ry:* = undefined;
         graphics.clear();
         graphics.lineStyle(1,this.lineColor);
         graphics.moveTo(this.p0.x,this.p0.y);
         var len0:Number = 100 + 100 * Math.random();
         var p1:Point = new Point();
         p1.x = this.p0.x + Math.cos(this.ra) * len0;
         p1.y = this.p0.y + Math.sin(this.ra) * len0;
         var n:int = int(Bezier.init(this.p0,p1,this.p2,15));
         for(var i:int = 1; i < n; i++)
         {
            arr0 = Bezier.getAnchorPoint(i);
            x0 = Number(arr0[0]);
            y0 = Number(arr0[1]);
            ra0 = arr0[2] + Math.PI / 2;
            ppxy = Math.random() * this.range;
            rx = x0 + ppxy * Math.cos(ra0);
            ry = y0 + ppxy * Math.sin(ra0);
            graphics.lineTo(rx,ry);
         }
      }
      
      public function Show(_p0:Point, _p2:Point, _ra:Number, time0:Number = 0.1) : *
      {
         this.p0.x = _p0.x;
         this.p0.y = _p0.y;
         this.p2.x = _p2.x;
         this.p2.y = _p2.y;
         this.ra = _ra;
         this.time = time0 * 30;
         this.enabled = true;
         this.visible = true;
         this._t = 0;
      }
      
      public function clear() : *
      {
         graphics.clear();
      }
      
      public function Hide() : *
      {
         graphics.clear();
         this.enabled = false;
         this.visible = false;
      }
   }
}

