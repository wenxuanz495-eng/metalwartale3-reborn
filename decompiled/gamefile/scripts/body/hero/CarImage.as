package body.hero
{
   import body.image.MoreImage;
   import body.image.SingleMovieclip;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class CarImage extends MoreImage
   {
      
      public var rocket:MoreImage = new MoreImage();
      
      public var plasma:MoreImage = new MoreImage();
      
      public function CarImage()
      {
         super();
         this.addChild(this.rocket);
         this.addChild(this.plasma);
         this.plasma.visible = false;
      }
      
      public function get armsPoint() : Point
      {
         var mc0:SingleMovieclip = getNowMC();
         return new Point(mc0.armsPoint.x + mc0.mc.x,mc0.armsPoint.y + mc0.mc.y);
      }
      
      public function get rocketPoint() : Point
      {
         var mc0:SingleMovieclip = getNowMC();
         return mc0.rocketPoint;
      }
      
      public function get plasmaPoint() : Point
      {
         var mc0:SingleMovieclip = getNowMC();
         return mc0.plasmaPoint;
      }
      
      override protected function adjustPosition(label0:String) : *
      {
         var index0:int = getIndex_byLabel(label0);
         var mc0:SingleMovieclip = mc_arr[index0];
         var r0:Rectangle = mc0.rect;
         mc0.mc.x = -r0.width / 2 - r0.x;
         mc0.mc.y = -r0.height - r0.y;
         var p0:Point = this.rocketPoint;
         var p1:Point = this.plasmaPoint;
         this.rocket.x = p0.x;
         this.rocket.y = p0.y;
         this.plasma.x = p1.x;
         this.plasma.y = p1.y;
      }
   }
}

