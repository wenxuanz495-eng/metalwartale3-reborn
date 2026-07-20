package effect
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.filters.DisplacementMapFilter;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   public class Shock extends Sprite
   {
      
      private var _target:Sprite;
      
      private var _show:Sprite;
      
      private var _offsets:Array;
      
      private var _offsetX:int;
      
      private var _offsetY:int;
      
      private var _glow:GlowFilter;
      
      private var _seed:Number;
      
      private var _bd:BitmapData;
      
      private var _show_bd:BitmapData;
      
      private var _spark_bd:BitmapData;
      
      private var _timer:Timer;
      
      public function Shock()
      {
         super();
         this._offsetX = 2;
         this._offsetY = 2;
         this._glow = new GlowFilter(6750207,1,1,1,100,1,false,true);
         this._timer = new Timer(50);
         this._timer.addEventListener(TimerEvent.TIMER,this.timerHandler);
      }
      
      private function timerHandler(event:TimerEvent) : void
      {
         var offset:Point = null;
         var filter:DisplacementMapFilter = null;
         for each(offset in this._offsets)
         {
            offset.x -= -this._offsetX;
            offset.y += this._offsetY;
         }
         this._show_bd.perlinNoise(10,20,2,this._seed,true,true,1,true,this._offsets);
         filter = new DisplacementMapFilter(this._show_bd,new Point(),1,1,16,16,"color");
         this._spark_bd.applyFilter(this._bd,this._bd.rect,new Point(),this._glow);
         this._spark_bd.applyFilter(this._spark_bd,this._bd.rect,new Point(),filter);
      }
      
      public function set target(value:Sprite) : void
      {
         this._target = value;
      }
      
      public function start() : void
      {
         var offsetY:int = 0;
         var w:int = 0;
         var bounds:Rectangle = this._target.getBounds(this._target);
         var offsetX:int = 20;
         offsetY = 20;
         w = bounds.width + offsetX;
         var h:int = bounds.height + offsetY;
         bounds.x -= offsetX * 0.5;
         bounds.y -= offsetY * 0.5;
         this._show = new Sprite();
         this._show.x = this._target.x;
         this._show.y = this._target.y;
         addChild(this._show);
         var holder:Sprite = new Sprite();
         holder.x = bounds.x;
         holder.y = bounds.y;
         this._show.addChild(holder);
         this._bd = new BitmapData(w,h,true,0);
         this._spark_bd = new BitmapData(w,h,true,0);
         this._bd.draw(this._target,new Matrix(1,0,0,1,-bounds.x,-bounds.y));
         var spark_bp:Bitmap = new Bitmap();
         spark_bp.bitmapData = this._spark_bd;
         holder.addChild(spark_bp);
         this._offsets = new Array();
         for(var i:int = 0; i < 4; i++)
         {
            this._offsets.push(new Point());
         }
         this._seed = Math.round(Math.random() * 10);
         this._show_bd = new BitmapData(w,h);
         var glow2:GlowFilter = new GlowFilter(65535,0.6,6,6,2,1,false,false);
         var glow3:GlowFilter = new GlowFilter(6711039,0.8,8,8,3,1,false,false);
         this._target.filters = [glow2];
         holder.blendMode = "screen";
         holder.filters = [glow2,glow3];
         this._timer.start();
      }
      
      public function end() : void
      {
         if(this._timer.running)
         {
            this._timer.stop();
         }
      }
      
      public function clear() : *
      {
         this._timer.stop();
         this._timer.removeEventListener(TimerEvent.TIMER,this.timerHandler);
      }
   }
}

