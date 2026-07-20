package enemy.gundam
{
   public class GundamAnimation2
   {
      
      internal var BB:GundamBody2;
      
      public var state:String = "land";
      
      public var enabled:Boolean = true;
      
      public var moveCtrlB:Boolean = true;
      
      public var flipCtrlB:Boolean = true;
      
      public function GundamAnimation2(_BB:*)
      {
         super();
         this.BB = _BB;
      }
      
      public function flyCtrl() : *
      {
         var mot:* = this.BB.mot;
         var img:* = this.BB.img;
         img.toPlayLoop("fly");
      }
      
      public function landCtrl() : *
      {
         var mot:* = this.BB.mot;
         var img:* = this.BB.img;
         if(Boolean(mot.getFloorB()))
         {
            if(img.nowLabel != "__fly")
            {
               if(mot.vx0 == 0)
               {
                  img.toPlayLoop("stand");
               }
               else
               {
                  img.toPlayLoop("move");
               }
            }
         }
         this.flipCtrl();
      }
      
      protected function flipCtrl() : *
      {
         var mot:* = this.BB.mot;
         var img:* = this.BB.img;
         if(mot.state == "left")
         {
            img.flipToRight();
         }
         else if(mot.state == "right")
         {
            img.flipToLeft();
         }
      }
      
      public function animationTimer() : *
      {
         if(this.enabled)
         {
            if(!this.BB.img.shootB)
            {
               if(this.moveCtrlB)
               {
                  if(this.state == "fly")
                  {
                     this.flyCtrl();
                  }
                  else if(this.state == "land")
                  {
                     this.landCtrl();
                  }
               }
            }
            else if(this.state == "land")
            {
               this.BB.mot.toStop();
            }
         }
      }
   }
}

