package body.image
{
   import data.INIT;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   
   public class MoreImage extends Sprite
   {
      
      public var mc_arr:Array = new Array();
      
      private var hurtTime:int = 0;
      
      public var hurt_t:int = 0;
      
      public var isPlaying:Boolean = false;
      
      public var nowIndex:int = -1;
      
      public var nowMC:SingleMovieclip = null;
      
      private var endStopB:Boolean = false;
      
      private var loopFirstFrame:int = 1;
      
      private var loopTime:Number = 0;
      
      public var loop_t:Number = -1;
      
      public function MoreImage()
      {
         super();
      }
      
      public function get nowLabel() : String
      {
         if(this.nowIndex >= 0)
         {
            return this.mc_arr[this.nowIndex].label;
         }
         return null;
      }
      
      public function addMC(mc0:*, label0:String) : *
      {
         this.mc_arr.push(new SingleMovieclip(mc0,label0));
      }
      
      public function addSingleMovieclip(mc0:SingleMovieclip) : *
      {
         this.mc_arr.push(mc0);
         if(this.mc_arr.length > 1)
         {
            this.showMC(this.mc_arr[0].label);
         }
      }
      
      public function showMC(label0:String) : *
      {
         var mc0:SingleMovieclip = null;
         var index0:int = this.getIndex_byLabel(label0);
         if(index0 >= 0)
         {
            mc0 = this.mc_arr[index0];
            if(this.nowIndex != index0)
            {
               this.clearNowMC();
               this.nowIndex = index0;
               this.nowMC = mc0;
               this.adjustPosition(label0);
               addChildAt(mc0.mc,0);
               this.isPlaying = false;
            }
         }
      }
      
      protected function adjustPosition(label0:String) : *
      {
      }
      
      public function stop() : *
      {
         var mc0:SingleMovieclip = null;
         if(this.nowIndex >= 0)
         {
            mc0 = this.mc_arr[this.nowIndex];
            mc0.stop();
            this.isPlaying = false;
         }
      }
      
      public function gotoAndStop(_num:int) : *
      {
         var mc0:SingleMovieclip = null;
         if(this.nowIndex >= 0)
         {
            mc0 = this.mc_arr[this.nowIndex];
            mc0.gotoAndStop(_num);
            this.isPlaying = false;
         }
      }
      
      public function play() : *
      {
         var mc0:SingleMovieclip = null;
         if(this.nowIndex >= 0)
         {
            mc0 = this.mc_arr[this.nowIndex];
            mc0.play();
            this.isPlaying = true;
         }
      }
      
      public function playOnce() : *
      {
         this.gotoAndStop(2);
         this.play();
         this.endStopB = true;
      }
      
      public function playLoop(_loopFirstFrame:int = 1, _loopTime:Number = 0) : *
      {
         this.play();
         this.endStopB = false;
         this.loopFirstFrame = _loopFirstFrame;
         if(_loopTime > 0)
         {
            this.loopTime = _loopTime;
            this.loop_t = 0;
         }
      }
      
      private function animationEnd_Timer() : *
      {
         var mc0:* = undefined;
         if(this.nowIndex >= 0)
         {
            mc0 = this.mc_arr[this.nowIndex].mc;
            if(mc0.currentFrame == mc0.totalFrames && this.isPlaying)
            {
               if(this.endStopB)
               {
                  this.mc_arr[this.nowIndex].gotoAndStop(1);
                  this.isPlaying = false;
               }
               else
               {
                  this.mc_arr[this.nowIndex].gotoAndPlay(this.loopFirstFrame);
                  this.isPlaying = true;
               }
            }
         }
      }
      
      private function clearNowMC() : *
      {
         var mc0:SingleMovieclip = null;
         if(this.nowIndex >= 0)
         {
            mc0 = this.mc_arr[this.nowIndex];
            mc0.gotoAndStop(1);
            this.removeChild(mc0.mc);
         }
      }
      
      public function clearAllMC() : *
      {
         var n:* = undefined;
         var n2:int = 0;
         for(n in this.mc_arr)
         {
            this.mc_arr[n].gotoAndStop(1);
         }
         for(n2 = 0; n2 <= this.numChildren - 1; n2++)
         {
            this.removeChildAt(0);
         }
      }
      
      protected function getMC_byLabel(label0:String) : SingleMovieclip
      {
         var n:* = undefined;
         var mc0:SingleMovieclip = null;
         for(n in this.mc_arr)
         {
            if(this.mc_arr[n].label == label0)
            {
               return this.mc_arr[n];
            }
         }
         return mc0;
      }
      
      protected function getIndex_byLabel(label0:String) : int
      {
         var n:* = undefined;
         var index0:int = -1;
         for(n in this.mc_arr)
         {
            if(Boolean(this.mc_arr[n]) && this.mc_arr[n].label == label0)
            {
               return int(n);
            }
         }
         return index0;
      }
      
      protected function getMC_byIndex(index0:int) : SingleMovieclip
      {
         if(index0 >= 0)
         {
            return this.mc_arr[index0];
         }
         return null;
      }
      
      public function getNowMC() : SingleMovieclip
      {
         return this.getMC_byIndex(this.nowIndex);
      }
      
      public function flipToLeft() : *
      {
         if(this.scaleX != 1)
         {
            this.scaleX = 1;
         }
      }
      
      public function flipToRight() : *
      {
         if(this.scaleX != -1)
         {
            this.scaleX = -1;
         }
      }
      
      public function get rightB() : Boolean
      {
         if(this.scaleX > 0)
         {
            return false;
         }
         return true;
      }
      
      public function startHurtEffect(_hurtTime:Number = 0.2) : *
      {
         if(this.hurt_t == -1 || this.hurt_t % 2 == 0)
         {
            this.hurt_t = 0;
         }
         else
         {
            this.hurt_t = 1;
         }
         this.hurtTime = _hurtTime * INIT.FPS;
      }
      
      public function stopHurtEffect() : *
      {
         this.hurtEffectHide();
         this.hurt_t = -1;
      }
      
      private function hurtEffectShow(redB:Boolean = false) : *
      {
         var ct:ColorTransform = null;
         var c0:Number = 0.7;
         var c1:int = c0 * 255;
         if(redB)
         {
            ct = new ColorTransform(c0,c0,c0,1,c1,0,0,0);
         }
         else
         {
            ct = new ColorTransform(c0,c0,c0,1,c1,c1,c1,0);
         }
         this.transform.colorTransform = ct;
      }
      
      public function hurtEffectHide() : *
      {
         this.transform.colorTransform = new ColorTransform();
      }
      
      public function pause() : *
      {
         if(this.nowIndex >= 0)
         {
            this.getNowMC().pause();
         }
      }
      
      public function resume() : *
      {
         if(this.nowIndex >= 0)
         {
            this.getNowMC().resume();
         }
      }
      
      public function clear() : *
      {
         var n:* = undefined;
         for(n in this.mc_arr)
         {
            if(this.mc_arr[n] is SingleMovieclip)
            {
               this.mc_arr[n].clear();
            }
         }
      }
      
      public function imageTimer() : *
      {
         this.animationEnd_Timer();
         if(this.hurt_t >= this.hurtTime)
         {
            this.stopHurtEffect();
         }
         else if(this.hurt_t < this.hurtTime && this.hurt_t >= 0)
         {
            if(this.hurt_t % 2 == 0)
            {
               this.hurtEffectShow();
            }
            else
            {
               this.hurtEffectHide();
            }
            ++this.hurt_t;
         }
         if(this.loop_t >= this.loopTime)
         {
            this.loop_t = -1;
            this.gotoAndStop(1);
         }
         else if(this.loop_t < this.loopTime && this.loop_t >= 0)
         {
            this.loop_t += 1 / INIT.FPS;
         }
      }
   }
}

