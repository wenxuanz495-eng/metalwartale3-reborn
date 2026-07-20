package body.image
{
   import body.attack.AttackHitDataGroup;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import hit.HitPointGroup;
   import image.BmpMovieClip;
   
   public class SingleMovieclip
   {
      
      public var mc:*;
      
      public var label:String;
      
      public var father:String;
      
      public var currentLabels:Array;
      
      public var rect:Rectangle;
      
      public var _isPlaying:Boolean = false;
      
      public var hpg:HitPointGroup;
      
      public var armsPoint:Point;
      
      public var rocketPoint:Point;
      
      public var plasmaPoint:Point;
      
      public var basePoint:Point;
      
      public var shootPoint:Point;
      
      public var attackData:AttackHitDataGroup;
      
      public function SingleMovieclip(mc0:*, label0:String, father0:String = "")
      {
         super();
         this.mc = mc0;
         this.mc.stop();
         this.label = label0;
         this.father = father0;
      }
      
      public function get isPlaying() : Boolean
      {
         return this._isPlaying;
      }
      
      public function isMC() : Boolean
      {
         if(this.mc is MovieClip)
         {
            return true;
         }
         return false;
      }
      
      public function set x(value:Number) : *
      {
         this.mc.x = value;
      }
      
      public function set y(value:Number) : *
      {
         this.mc.y = value;
      }
      
      public function get x() : Number
      {
         return this.mc.x;
      }
      
      public function get y() : Number
      {
         return this.mc.y;
      }
      
      public function stop() : *
      {
         this.mc.stop();
         this._isPlaying = false;
      }
      
      public function play() : *
      {
         this.mc.play();
         this._isPlaying = true;
      }
      
      public function gotoAndPlay(num:int) : *
      {
         this.mc.gotoAndPlay(num);
         this._isPlaying = true;
      }
      
      public function gotoAndStop(num:int) : *
      {
         this.mc.gotoAndStop(num);
         this._isPlaying = false;
      }
      
      public function get currentFrame() : int
      {
         return this.mc.currentFrame;
      }
      
      public function get totalFrames() : int
      {
         return this.mc.totalFrames;
      }
      
      public function pause() : *
      {
         this.mc.stop();
      }
      
      public function resume() : *
      {
         if(this._isPlaying)
         {
            this.mc.play();
         }
      }
      
      public function clear() : *
      {
         this.stop();
         if(this.mc is BmpMovieClip)
         {
            this.mc.killMe();
         }
      }
      
      public function get endFrameB() : Boolean
      {
         if(this.mc.currentFrame == this.mc.totalFrames)
         {
            return true;
         }
         return false;
      }
   }
}

