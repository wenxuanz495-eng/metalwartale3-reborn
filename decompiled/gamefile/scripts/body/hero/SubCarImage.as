package body.hero
{
   import body.image.MoreImage;
   import body.image.SingleMovieclip;
   import flash.geom.Point;
   
   public class SubCarImage extends MoreImage
   {
      
      public function SubCarImage()
      {
         super();
      }
      
      public function get armsPoint() : Point
      {
         var mc0:SingleMovieclip = getNowMC();
         return new Point(mc0.armsPoint.x + mc0.mc.x,mc0.armsPoint.y + mc0.mc.y);
      }
      
      override protected function adjustPosition(label0:String) : *
      {
      }
   }
}

