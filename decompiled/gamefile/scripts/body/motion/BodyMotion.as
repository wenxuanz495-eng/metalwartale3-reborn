package body.motion
{
   import data.INIT;
   import data.Maths;
   
   public class BodyMotion
   {
      
      public static var MOVE_VX:Number = 200 / INIT.FPS * 1.5;
      
      public var type:String = "land";
      
      public var BDG:BodyDofGroup = new BodyDofGroup();
      
      public var x0:Number = 0;
      
      public var y0:Number = 0;
      
      public var w0:Number = 100;
      
      public var h0:Number = 200;
      
      public var vx:Number = 0;
      
      public var vy:Number = 0;
      
      public var vx0:Number = 0;
      
      public var vy0:Number = 0;
      
      public var ax:Number = 0;
      
      public var ay:Number = 0;
      
      private var recoilX:Number = 0;
      
      private var recoilValue:Number = 0;
      
      private var recoil_t:int = -1;
      
      public var xAffectB:Boolean = true;
      
      public var vxmax:Number = 33.333333333333336;
      
      public var vymax:Number = 16.666666666666668;
      
      public var vxmax_Fi:Number = MOVE_VX;
      
      public var vymax_Fi:Number = 16.666666666666668;
      
      public var baseVxmax_Fi:Number = MOVE_VX;
      
      public var baseVymax_Fi:Number = 16.666666666666668;
      
      public var reduceMul:Number = 1;
      
      public var reduce_t:Number = 0;
      
      public var reduce_Max:Number = 0;
      
      public var F_G:Number = 2;
      
      public var F_F:Number = 0.6666666666666666;
      
      public var F_AIR:Number = this.F_F / 2;
      
      public var F_I:Number = this.F_F * 4;
      
      public var fi:Number = 0;
      
      public var ff:Number = 0;
      
      public var fg:Number = 0;
      
      public var eVx:Number = 0;
      
      public var eVy:Number = 0;
      
      public var JUMP_H:Number = 100;
      
      public var JUMP_VY:Number = Math.sqrt(2 * this.JUMP_H * this.F_G);
      
      public var jumpNow:int = 0;
      
      public var jumpNum:int = 10;

      // Counts only airborne extra jumps; the ground jump is intentionally excluded.
      public var airJumpNow:int = 0;
      
      private var _floorB:Boolean = false;
      
      public var updated:Boolean = true;
      
      private var delayFun:Function;
      
      private var delayT:Number = -100;
      
      public var viewB:Boolean = false;
      
      public function BodyMotion()
      {
         super();
      }
      
      public function move(x00:Number, y00:Number) : *
      {
         this.x0 += x00;
         this.y0 += y00;
      }
      
      public function setVx(value:Number) : *
      {
         this.vx0 = value;
      }
      
      public function flesh_F_I() : *
      {
         this.F_AIR = this.F_F / 2;
         this.F_I = this.F_F * 4;
      }
      
      public function moveToLeft() : *
      {
         this.fi = -this.F_I;
      }
      
      public function moveToRight() : *
      {
         this.fi = this.F_I;
      }
      
      public function toJump() : *
      {
         ++this.jumpNow;
         this.vy0 = -this.JUMP_VY;
      }

      public function toAirJump() : *
      {
         ++this.airJumpNow;
         this.vy0 = -this.JUMP_VY;
      }

      public function toAirGravity() : *
      {
         ++this.airJumpNow;
         this.vy0 = -this.JUMP_VY;
      }

      public function toLimitedAirJump(limit0:int = 4) : Boolean
      {
         if(this.getFloorB())
         {
            this.toJump();
            return true;
         }
         if(this.airJumpNow >= limit0)
         {
            this.vy0 = this.vymax_Fi;
            return false;
         }
         this.toAirGravity();
         return true;
      }
      
      public function delayToJump(tt:Number) : *
      {
         this.delayFun = this.toJump;
         this.delayT = tt;
      }
      
      public function toStop() : *
      {
         this.fi = 0;
      }
      
      public function getFloorB() : Boolean
      {
         if(this.BDG.dof[1].type > 0)
         {
            return true;
         }
         return false;
      }
      
      private function dofLimit() : *
      {
         this.fg = this.F_G;
         if(this.BDG.dof[1].type > 0)
         {
            this.y0 -= this.BDG.dof[1].back - 1;
            if(this.vy >= 0)
            {
               this.vy0 = 0;
               this.vy = 0;
               this.ay = 0;
            }
            this.fg = 0;
         }
         if(this.BDG.dof[0].type == 1)
         {
            if(this.BDG.dof[0].back > 1)
            {
               this.y0 += this.BDG.dof[0].back - 1;
            }
            if(this.vy <= 0)
            {
               this.vy0 = 0;
               this.vy = 0;
               this.ay = 0;
            }
         }
         if(this.BDG.dof[2].type == 1)
         {
            if(this.BDG.dof[2].back > 1)
            {
               this.x0 += this.BDG.dof[2].back - 1;
            }
            if(this.vx <= 0)
            {
               this.vx0 = 0;
               this.vx = 0;
               this.ax = 0;
            }
         }
         if(this.BDG.dof[3].type == 1)
         {
            if(this.BDG.dof[3].back > 1)
            {
               this.x0 -= this.BDG.dof[3].back - 1;
            }
            if(this.vx >= 0)
            {
               this.vx0 = 0;
               this.vx = 0;
               this.ax = 0;
            }
         }
      }
      
      private function forceLimit() : *
      {
         if(this.getFloorB())
         {
            this.ff = -this.F_F * Maths.Pn(this.vx);
         }
         else
         {
            this.ff = -this.F_F * Maths.Pn(this.vx) / 3;
         }
         if(Maths.Abs(this.vx) <= Maths.Abs(this.ff))
         {
            this.ff = -this.vx;
         }
         this.ay = this.fg;
         this.ax = this.fi + this.ff;
      }
      
      private function count() : *
      {
         this.vx0 += this.ax;
         this.vy0 += this.ay;
         this.vxmax_Fi = this.baseVxmax_Fi * this.reduceMul;
         this.vymax_Fi = this.baseVymax_Fi;
         if(this.vx0 > this.vxmax_Fi)
         {
            this.vx0 = this.vxmax_Fi;
         }
         else if(this.vx0 < -this.vxmax_Fi)
         {
            this.vx0 = -this.vxmax_Fi;
         }
         if(this.vy0 > this.vymax_Fi)
         {
            this.vy0 = this.vymax_Fi;
         }
         else if(this.vy0 < -this.vymax_Fi)
         {
            this.vy0 = -this.vymax_Fi;
         }
         if(this.xAffectB)
         {
            this.vx = this.vx0 + this.eVx;
         }
         else
         {
            this.vx = this.eVx;
         }
         this.vy = this.vy0 + this.eVy;
         if(this.vx > this.vxmax)
         {
            this.vx = this.vxmax;
         }
         else if(this.vx < -this.vxmax)
         {
            this.vx = -this.vxmax;
         }
         if(this.vy > this.vymax)
         {
            this.vy = this.vymax;
         }
         else if(this.vy < -this.vymax)
         {
            this.vy = -this.vymax;
         }
         this.dofLimit();
         this.x0 += this.vx + this.recoilX;
         this.y0 += this.vy;
      }
      
      public function recoil(value:Number) : *
      {
         if(Math.abs(value) >= 1)
         {
            this.recoilValue = value;
            this.recoil_t = 0;
         }
      }
      
      private function recoilHandler() : *
      {
         if(this.recoil_t == 0)
         {
            ++this.recoil_t;
            this.recoilX = this.recoilValue;
         }
         else if(this.recoil_t == 1)
         {
            ++this.recoil_t;
            this.recoilX = -this.recoilValue / 3;
         }
         else if(this.recoil_t == 2)
         {
            ++this.recoil_t;
         }
         else if(this.recoil_t == 3)
         {
            ++this.recoil_t;
         }
         else if(this.recoil_t == 4)
         {
            this.recoilX = 0;
            this.recoil_t = -1;
            this.recoilValue = 0;
         }
      }
      
      public function setReduceMul(_mul0:Number, _time:Number) : *
      {
         this.reduceMul = _mul0;
         this.reduce_Max = _time;
         this.reduce_t = 0;
         trace("减速：" + this.reduceMul + "  " + this.reduce_Max);
      }
      
      private function delayHandler() : *
      {
         if(this.delayT > 0)
         {
            this.delayT -= 1 / INIT.FPS;
         }
         else if(this.delayT != -100)
         {
            this.delayFun();
            this.delayFun = null;
            this.delayT = -100;
         }
      }
      
      private function reduceHandler() : *
      {
         if(this.reduce_t >= this.reduce_Max)
         {
            this.reduceMul = 1;
         }
         else
         {
            this.reduce_t += 1 / INIT.FPS;
         }
      }
      
      public function motionTimer() : *
      {
         if(this.updated)
         {
            this.forceLimit();
            this.count();
            this.delayHandler();
            this.recoilHandler();
            this.reduceHandler();
            if(this.getFloorB())
            {
               if(!this._floorB)
               {
                  this.jumpNow = 0;
                  this.airJumpNow = 0;
               }
            }
            this._floorB = this.getFloorB();
         }
      }
   }
}

