package enemy._die
{
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   
   public class DieDelay
   {
      
      public var b0:* = null;
      
      public var lighting_mc:MovieClip;
      
      public var max_t:int = 6000;
      
      public var tt:int = 0;
      
      public function DieDelay()
      {
         super();
      }
      
      public function addLighting() : *
      {
         this.b0.img.addChild(this.lighting_mc);
         var rect0:Rectangle = this.b0.define.hitRect;
         this.lighting_mc.scaleX = rect0.width / this.lighting_mc.width * 1.3;
         this.lighting_mc.scaleY = rect0.height / this.lighting_mc.height * 1.3;
         this.lighting_mc.x = rect0.x + rect0.width / 2;
         this.lighting_mc.y = rect0.y + rect0.height / 2;
         this.lighting_mc.play();
      }
      
      public function toDie() : *
      {
         this.tt = this.max_t + 1;
      }
   }
}

