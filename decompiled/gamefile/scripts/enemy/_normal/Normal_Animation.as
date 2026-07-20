package enemy._normal
{
   public class Normal_Animation
   {
      
      internal var img:*;
      
      internal var mot:*;
      
      public var enabled:Boolean = true;
      
      public var moveCtrlB:Boolean = true;
      
      public var flipCtrlB:Boolean = true;
      
      public function Normal_Animation(_img:*, _mot:*)
      {
         super();
         this.img = _img;
         this.mot = _mot;
      }
      
      public function animationTimer() : *
      {
         if(this.enabled)
         {
            if(this.moveCtrlB)
            {
            }
            if(this.flipCtrlB)
            {
            }
         }
      }
   }
}

