package
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class MeteorsEffect extends Sprite
   {
      
      public var arr:Array;
      
      public function MeteorsEffect()
      {
         var n:int = 0;
         var mc0:MovieClip = null;
         var len0:int = 0;
         this.arr = [];
         for(super(); n < 200; )
         {
            mc0 = Game.swfLoaderManager.getResource("main","me_mc");
            this.arr.push(mc0);
            mc0.rotation = 360 * Math.random();
            len0 = Math.random() * 120 + 10;
            mc0.x = 475 + Math.cos(mc0.rotation / 180 * Math.PI) * len0;
            mc0.y = 280 + Math.sin(mc0.rotation / 180 * Math.PI) * len0;
            mc0.gotoAndPlay(int(mc0.totalFrames * Math.random()) + 1);
            addChild(mc0);
            n++;
         }
         this.stopAll();
      }
      
      public function stopAll() : *
      {
         var n:* = undefined;
         for(n in this.arr)
         {
            this.arr[n].stop();
         }
      }
      
      public function playAll() : *
      {
         var n:* = undefined;
         for(n in this.arr)
         {
            this.arr[n].play();
         }
      }
   }
}

