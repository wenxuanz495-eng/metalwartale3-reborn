package body.hero
{
   public class HeroCarAnimation
   {
      
      internal var img:CarImage;
      
      internal var mot:*;
      
      public var enabled:Boolean = true;
      
      public function HeroCarAnimation(_image:CarImage, _motion:*)
      {
         super();
         this.img = _image;
         this.mot = _motion;
      }
      
      protected function ActionCtrl() : *
      {
         if(Boolean(this.mot.getFloorB()))
         {
            if(Math.abs(this.mot.vx) > 0.1)
            {
               this.img.play();
            }
            else
            {
               this.img.stop();
            }
         }
      }
      
      public function animationTimer() : *
      {
         if(this.enabled)
         {
            this.ActionCtrl();
         }
      }
   }
}

