package body.hero
{
   import body.image.MoreImage;
   import body.image.SingleMovieclip;
   import flash.geom.Point;
   
   public class ArmsImage extends MoreImage
   {
      
      public function ArmsImage()
      {
         super();
      }
      
      public function get shootPoint_migration() : Point
      {
         var mc0:SingleMovieclip = getNowMC();
         return new Point(mc0.shootPoint.x + mc0.mc.x,mc0.shootPoint.y + mc0.mc.y);
      }
      
      public function get shootPoint_rotation() : Point
      {
         var p0:Point = this.shootPoint_migration;
         var ra:Number = Math.atan2(p0.y,p0.x) + rotation / 180 * Math.PI;
         var l0:Number = p0.length;
         var x0:Number = Math.cos(ra) * l0;
         var y0:Number = Math.sin(ra) * l0;
         return new Point(x0,y0);
      }
      
      public function get shootPoint() : Point
      {
         var p0:Point = this.shootPoint_rotation;
         return new Point(p0.x + x,p0.y + y);
      }

      public function get laserPoint_migration() : Point
      {
         var mc0:SingleMovieclip = getNowMC();
         if(mc0.laserPoint == null)
         {
            return this.shootPoint_migration;
         }
         return new Point(mc0.laserPoint.x + mc0.mc.x,mc0.laserPoint.y + mc0.mc.y);
      }

      public function get laserPoint_rotation() : Point
      {
         var p0:Point = this.laserPoint_migration;
         var ra:Number = Math.atan2(p0.y,p0.x) + rotation / 180 * Math.PI;
         var l0:Number = p0.length;
         var x0:Number = Math.cos(ra) * l0;
         var y0:Number = Math.sin(ra) * l0;
         return new Point(x0,y0);
      }

      public function get laserPoint() : Point
      {
         var p0:Point = this.laserPoint_rotation;
         return new Point(p0.x + x,p0.y + y);
      }
      
      override protected function adjustPosition(label0:String) : *
      {
         var index0:int = getIndex_byLabel(label0);
         var mc0:SingleMovieclip = mc_arr[index0];
         var p0:Point = mc0.basePoint;
         mc0.mc.x = -p0.x;
         mc0.mc.y = -p0.y;
      }
      
      public function inMouseXY(x0:Number, y0:Number) : *
      {
         var a_tan:Number = NaN;
         a_tan = Math.atan2(y0 - this.y,x0 - this.x);
         this.rotation = a_tan * 180 / Math.PI;
      }
   }
}

