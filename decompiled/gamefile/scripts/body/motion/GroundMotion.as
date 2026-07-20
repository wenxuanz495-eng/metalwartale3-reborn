package body.motion
{
   import data.INIT;
   import data.Maths;
   
   public class GroundMotion
   {
      
      public var type:String = "land";
      
      public var BDG:BodyDofGroup = new BodyDofGroup();
      
      public var x0:Number = 0;
      
      public var y0:Number = 0;
      
      public var mx:Number = 0;
      
      public var my:Number = 0;
      
      public var toTargetB:Boolean = false;
      
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
      
      public var vymax:Number = 33.333333333333336;
      
      public var vxmax_Fi:Number = 3.3333333333333335;
      
      public var vymax_Fi:Number = 33.333333333333336;
      
      public var F_G:Number = 2;
      
      public var F_F:Number = 1;
      
      public var F_AIR:Number = this.F_F / 2;
      
      public var F_I:Number = this.F_F * 2;
      
      public var fi:Number = 0;
      
      public var ff:Number = 0;
      
      public var fg:Number = 0;
      
      public var eVx:Number = 0;
      
      public var eVy:Number = 0;
      
      public var JUMP_H:Number = 100;
      
      public var JUMP_VY:Number = Math.sqrt(2 * this.JUMP_H * this.F_G);
      
      public var jumpNow:int = 0;
      
      public var jumpNum:int = 1;
      
      protected var _floorB:Boolean = false;
      
      public var updated:Boolean = true;
      
      private var delayFun:Function;
      
      public var delayT:Number = -100;
      
      public var delayTime:Number = 0;
      
      public var state:String = "stop";
      
      public var viewB:Boolean = false;
      
      public function GroundMotion()
      {
         super();
      }
      
      public function inData(_vx00:Number, _vy00:Number, tweenValue:Number, _jumpHeight:Number, _jumpNum:int) : *
      {
         this.vxmax_Fi = _vx00 / INIT.FPS;
         this.vymax_Fi = _vy00 / INIT.FPS;
         this.F_F *= 2 - tweenValue;
         this.F_I = this.F_F * 2;
         this.F_AIR = this.F_F / 2;
         this.JUMP_H = _jumpHeight;
         this.JUMP_VY = Math.sqrt(2 * this.JUMP_H * this.F_G);
         this.jumpNum = _jumpNum;
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
      
      public function inData_byOther(mot2:SuspendMotion) : *
      {
         this.x0 = mot2.x0;
         this.y0 = mot2.y0;
         this.vx0 = mot2.vx;
         this.vy0 = mot2.vy;
         this.ax = mot2.ax;
         this.ay = mot2.ay;
         this.mx = mot2.mx;
         this.my = mot2.my;
      }
      
      public function moveToLeft() : *
      {
         this.fi = -this.F_I;
         this.state = "left";
      }
      
      public function moveToRight() : *
      {
         this.fi = this.F_I;
         this.state = "right";
      }
      
      public function toJump() : *
      {
         ++this.jumpNow;
         this.vy0 = -this.JUMP_VY;
         this.delayT = -100;
      }
      
      public function delayToJump() : *
      {
         if(this.delayT < 0)
         {
            this.delayFun = this.toJump;
            this.delayT = 0;
         }
      }
      
      public function toStop() : *
      {
         this.fi = 0;
         this.state = "stop";
      }
      
      public function toStopBreak() : *
      {
         this.stopFollow();
         this.toStop();
         this.vx0 = 0;
         this.vy0 = 0;
         this.ff = 0;
         this.eVx = 0;
         this.eVy = 0;
      }
      
      public function getFloorB() : Boolean
      {
         if(this.BDG.dof[1].type > 0)
         {
            return true;
         }
         return false;
      }
      
      public function getGapX() : Number
      {
         return Math.abs(this.mx - this.x0);
      }
      
      public function getGapY() : Number
      {
         return Math.abs(this.my - this.y0);
      }
      
      public function getGap() : Number
      {
         return Maths.Long(this.mx - this.x0,this.my - this.y0);
      }
      
      protected function dofLimit() : *
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
      
      protected function forceLimit() : *
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
      
      protected function count() : *
      {
         this.vx0 += this.ax;
         this.vy0 += this.ay;
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
      
      protected function recoilHandler() : *
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
      
      protected function delayHandler() : *
      {
         if(this.delayT >= 0)
         {
            if(this.delayT >= this.delayTime)
            {
               this.delayFun();
               this.delayFun = null;
               this.delayT = -100;
            }
            else
            {
               this.delayT += 1 / INIT.FPS;
            }
         }
      }
      
      public function followPoint(px:Number, py:Number) : *
      {
         this.mx = px;
         this.my = py;
         this.toTargetB = true;
      }
      
      public function stopFollow() : *
      {
         this.toTargetB = false;
         this.mx = this.x0;
         this.my = this.y0;
         this.toStop();
      }
      
      public function toTargetTimer() : *
      {
         var cx:Number = NaN;
         var cy:Number = NaN;
         if(this.toTargetB)
         {
            cx = this.mx - this.x0;
            cy = this.my - this.y0;
            if(Math.abs(cx) < 5)
            {
               this.toTargetB = false;
               this.toStop();
            }
            else if(cx > 0)
            {
               this.moveToRight();
            }
            else if(cx < 0)
            {
               this.moveToLeft();
            }
         }
      }
      
      public function getJumpConditionB() : Boolean
      {
         if((this.BDG.dof[2].type == 1 || this.BDG.dof[3].type == 1) && this.delayT < 0)
         {
            if(this.vy0 >= 0 && this.jumpNow < this.jumpNum)
            {
               return true;
            }
            return false;
         }
         return false;
      }
      
      public function motionTimer() : *
      {
         if(this.updated)
         {
            this.forceLimit();
            this.count();
            this.delayHandler();
            this.recoilHandler();
            this.toTargetTimer();
            if(this.getFloorB())
            {
               if(!this._floorB)
               {
                  this.jumpNow = 0;
               }
            }
            this._floorB = this.getFloorB();
         }
      }
   }
}

