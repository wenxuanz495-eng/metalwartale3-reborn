package body.bullet
{
   import body.image.SingleMovieclip;
   import effect.EffectSMC;
   
   public class LaserBody extends BulletBody
   {
      
      public var img:SingleMovieclip;
      
      public var hitEffectImg:EffectSMC = null;
      
      private var _ra:Number = 0;
      
      public var x0:Number = 0;
      
      public var y0:Number = 0;
      
      public function LaserBody(_imgB:Boolean)
      {
         super();
         imgB = _imgB;
      }
      
      override public function init(img0:SingleMovieclip, x00:Number, y00:Number, v0:Number, ra0:Number, vmax:Number, va:Number) : *
      {
         if(imgB)
         {
            this.img = img0;
            this.img.mc.rotation = ra0 * 180 / Math.PI;
            this.img.x = x00;
            this.img.y = y00;
         }
         this.x0 = x00;
         this.y0 = y00;
         this._ra = ra0;
         live_t = 0;
      }
      
      public function doEffect(_selfDie:Boolean = false) : *
      {
         if(specialType == "Stop_Laser")
         {
            if(!_selfDie)
            {
               SpecialAttack.Stop_Laser();
            }
         }
      }
      
      public function set x(value:Number) : *
      {
         if(imgB)
         {
            this.img.x = int(value);
         }
         this.x0 = value;
      }
      
      public function set y(value:Number) : *
      {
         if(imgB)
         {
            this.img.y = int(value);
         }
         this.y0 = value;
      }
      
      public function get ra() : Number
      {
         if(imgB)
         {
            return this.img.mc.rotation * Math.PI / 180;
         }
         return this._ra;
      }
   }
}

