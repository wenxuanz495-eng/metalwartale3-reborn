package body.motion
{
   public class SuspendGroundMotion extends SuspendMotion
   {
      
      public var BDG:BodyDofGroup = new BodyDofGroup();
      
      public function SuspendGroundMotion()
      {
         super();
      }
      
      protected function dofLimit() : *
      {
         if(this.BDG.dof[1].type > 0)
         {
            y0 -= this.BDG.dof[1].back - 1;
            if(vy >= 0)
            {
               vy = 0;
               ay = 0;
            }
         }
         if(this.BDG.dof[0].type == 1)
         {
            if(this.BDG.dof[0].back > 1)
            {
               y0 += this.BDG.dof[0].back - 1;
            }
            if(vy <= 0)
            {
               vy = 0;
               ay = 0;
            }
         }
         if(this.BDG.dof[2].type == 1)
         {
            if(this.BDG.dof[2].back > 1)
            {
               x0 += this.BDG.dof[2].back - 1;
            }
            vx = 0;
            ax = 0;
         }
         if(this.BDG.dof[3].type == 1)
         {
            if(this.BDG.dof[3].back > 1)
            {
               x0 -= this.BDG.dof[3].back - 1;
            }
            if(vx >= 0)
            {
               vx = 0;
               ax = 0;
            }
         }
      }
      
      override public function tweenCount() : *
      {
         super.tweenCount();
         this.dofLimit();
      }
   }
}

