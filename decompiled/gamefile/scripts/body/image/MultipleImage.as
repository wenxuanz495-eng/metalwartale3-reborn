package body.image
{
   import UI.gaming.HeadTitle;
   import body.attack.AttackHitData;
   import body.attack.AttackHitDataGroup;
   import bodyGroup.BodyDefine;
   import data.INIT;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import hit.HitPointGroup;
   import image.ShakeMotion;
   
   public class MultipleImage extends Sprite
   {
      
      public var lighting_mc:MovieClip;
      
      public var shake:ShakeMotion;
      
      public var headTitle:HeadTitle;
      
      public var refleshB:Boolean = true;
      
      public var mc_arr:Array = new Array();
      
      private var hurtTime:int = 0;
      
      public var hurt_t:int = 0;
      
      private var endTimerB:Boolean = false;
      
      public var AOG:AnimationOrderGroup = new AnimationOrderGroup();
      
      private var isPlaying:Boolean = false;
      
      private var nowIndex:int = -1;
      
      public var nowMC:SingleMovieclip = null;
      
      public var colorF:ColorTransform = new ColorTransform();
      
      public var colorF2:ColorTransform = null;
      
      public var ordelLabel:String = "";
      
      public var level:int = 0;
      
      public function MultipleImage()
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
      }
      
      public function showAll() : *
      {
         var index0:int = (this.nowIndex + 1) % this.mc_arr.length;
         var label0:String = this.mc_arr[index0].label;
         this.gotoAndPlay(label0);
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
      
      public function gotoAndPlay(label0:String, _endTimerB:Boolean = false, checkSameB:Boolean = true) : *
      {
         var index0:int = 0;
         if(this.nowLabel != label0 || !checkSameB)
         {
            this.endTimerB = _endTimerB;
            this.clearNowMC();
            index0 = this.getIndex_byLabel(label0);
            if(index0 >= 0)
            {
               this.gotoAndPlayIndex(index0);
            }
         }
      }
      
      public function gotoAndPlayIndex(index0:int) : *
      {
         var mc0:SingleMovieclip = null;
         if(this.mc_arr.length > index0)
         {
            this.nowIndex = index0;
            mc0 = this.mc_arr[index0];
            this.nowMC = mc0;
            if(mc0 == null)
            {
               return;
            }
            mc0.gotoAndPlay(1);
            addChildAt(mc0.mc,0);
            this.isPlaying = true;
         }
      }
      
      public function goPlayLoop(label0:String) : *
      {
         this.gotoAndPlay(label0);
      }
      
      public function goPlayLoop_break(label0:String) : *
      {
         this.gotoAndPlay(label0,false,false);
      }
      
      public function goPlayOnce(label0:String) : *
      {
         this.AOG.addNewOrder([new AnimationOrder(label0,1)]);
         this.doOrder_fromAOG();
      }
      
      public function waitPlayLoop(label0:String) : *
      {
         this.AOG.addNewOrder([new AnimationOrder(label0)]);
         this.endTimerB = true;
      }
      
      public function toPlayLoop(label0:String) : *
      {
         var toLabel:String = null;
         var f0:int = 0;
         if(this.ordelLabel != label0)
         {
            this.ordelLabel = label0;
            toLabel = BodyDefine.getToLabel(this.nowLabel,label0);
            f0 = this.getIndex_byLabel(toLabel);
            if(f0 == -1)
            {
               if(this.isToLabel())
               {
                  this.waitPlayLoop(label0);
               }
               else
               {
                  this.goPlayLoop(label0);
               }
            }
            else
            {
               this.goOnce_ToLoop(toLabel,label0);
            }
         }
      }
      
      private function isToLabel() : Boolean
      {
         var f0:int = this.nowLabel.indexOf("__");
         if(f0 == -1)
         {
            return false;
         }
         return true;
      }
      
      public function goOnce_ToLoop(label0:String, label1:String, checkSameB:Boolean = true) : *
      {
         this.AOG.addNewOrder([new AnimationOrder(label0,1),new AnimationOrder(label1)]);
         this.doOrder_fromAOG(checkSameB);
      }
      
      public function testPlay() : *
      {
         this.AOG.add([["attack1",1],["attack2",1],["attack3",1],["breath",0]]);
         this.doOrder_fromAOG();
      }
      
      private function animationEnd_Timer() : *
      {
         var mc0:* = undefined;
         if(this.nowIndex >= 0)
         {
            mc0 = this.mc_arr[this.nowIndex].mc;
            if(mc0.currentFrame == mc0.totalFrames && this.isPlaying)
            {
               this.AOG.setData_AnimationEnd();
               this.doOrder_fromAOG();
            }
         }
      }
      
      private function doOrder_fromAOG(checkSameB:Boolean = true) : *
      {
         var ao:AnimationOrder = this.AOG.getAnimationOrder();
         if(ao != null)
         {
            this.gotoAndPlay(ao.label,true,checkSameB);
         }
         else
         {
            this.stop();
         }
      }
      
      protected function clearNowMC() : *
      {
         var mc0:SingleMovieclip = null;
         var xxxd:* = undefined;
         if(this.nowIndex >= 0)
         {
            mc0 = this.mc_arr[this.nowIndex];
            mc0.gotoAndStop(1);
            if(mc0.mc.parent != this)
            {
               xxxd = 0;
               xxxd += 0;
            }
            else
            {
               this.removeChild(mc0.mc);
            }
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
      
      public function getHitPointArr() : Array
      {
         var sm0:SingleMovieclip = null;
         var cf:int = 0;
         var arr1:Array = null;
         var arr0:Array = null;
         if(this.nowIndex >= 0)
         {
            sm0 = this.getMC_byIndex(this.nowIndex);
            if(sm0.hpg is HitPointGroup)
            {
               cf = sm0.currentFrame;
               arr1 = sm0.hpg.arr[cf - 1];
               if(arr1.length > 0)
               {
                  arr0 = arr1;
               }
            }
         }
         return arr0;
      }
      
      public function getHitEffectName() : String
      {
         var sm0:SingleMovieclip = null;
         var cf:int = 0;
         var arr1:Array = null;
         var str:String = "";
         if(this.nowIndex >= 0)
         {
            sm0 = this.getMC_byIndex(this.nowIndex);
            if(sm0.hpg is HitPointGroup)
            {
               cf = sm0.currentFrame;
               arr1 = sm0.hpg.effectArr;
               str = arr1[cf - 1];
            }
         }
         return str;
      }
      
      public function get attackB() : Boolean
      {
         var f0:int = 0;
         var str:String = this.nowLabel;
         if(str is String)
         {
            f0 = str.indexOf("attack");
            if(f0 >= 0)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get shootB() : Boolean
      {
         var f0:int = 0;
         var str:String = this.nowLabel;
         if(str is String)
         {
            f0 = str.indexOf("shoot");
            if(f0 >= 0)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get dieB() : Boolean
      {
         var f0:int = 0;
         var str:String = this.nowLabel;
         if(str is String)
         {
            f0 = str.indexOf("die");
            if(f0 >= 0)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get lastFrameB() : Boolean
      {
         var mc0:* = undefined;
         if(this.nowIndex >= 0)
         {
            mc0 = this.mc_arr[this.nowIndex].mc;
            if(mc0.currentFrame == mc0.totalFrames)
            {
               return true;
            }
         }
         return false;
      }
      
      private function getMC_byLabel(label0:String) : SingleMovieclip
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
      
      public function getIndex_byLabel(label0:String) : int
      {
         var n:* = undefined;
         var index0:int = -1;
         for(n in this.mc_arr)
         {
            if(this.mc_arr[n].label == label0)
            {
               return int(n);
            }
         }
         return index0;
      }
      
      private function getMC_byIndex(index0:int) : SingleMovieclip
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
            if(Boolean(this.headTitle))
            {
               this.headTitle.scaleX = 1;
            }
         }
      }
      
      public function flipToRight() : *
      {
         if(this.scaleX != -1)
         {
            this.scaleX = -1;
            if(Boolean(this.headTitle))
            {
               this.headTitle.scaleX = -1;
            }
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
      
      public function hurtEffectShow(redB:Boolean = false) : *
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
         if(this.colorF2 == null)
         {
            this.transform.colorTransform = this.colorF;
         }
         else
         {
            this.transform.colorTransform = this.colorF2;
         }
      }
      
      public function showGlowEffect(_color:uint = 39423) : *
      {
         var f0:GlowFilter = new GlowFilter(_color,1,30,30,1,1,true);
         this.filters = [f0];
      }
      
      public function hideGlowEffect() : *
      {
         this.filters = [];
      }
      
      public function addAttackData(ahdg:AttackHitDataGroup) : *
      {
         var n:* = undefined;
         var smc:SingleMovieclip = null;
         var label0:String = null;
         if(ahdg is AttackHitDataGroup)
         {
            for(n in this.mc_arr)
            {
               smc = this.mc_arr[n];
               if(smc != null)
               {
                  label0 = smc.label;
                  smc.attackData = ahdg.getAttackHitDataGroup(label0);
               }
            }
         }
      }
      
      public function setMulHurt(label0:String, value0:Number) : *
      {
         var smc0:SingleMovieclip = this.getMC_byLabel(label0);
         if(smc0 is SingleMovieclip)
         {
            if(smc0.attackData is AttackHitDataGroup)
            {
               smc0.attackData.setMulHurt(value0);
            }
         }
      }
      
      public function setHurt_byLabel(label0:String, value0:Number, hurt_0_B:Boolean = true) : *
      {
         var smc0:SingleMovieclip = this.getMC_byLabel(label0);
         if(smc0 is SingleMovieclip)
         {
            if(smc0.attackData is AttackHitDataGroup)
            {
               smc0.attackData.setHurt(value0,hurt_0_B);
            }
         }
      }
      
      public function get endFrameB() : Boolean
      {
         return this.nowMC.endFrameB;
      }
      
      public function getAttackData() : AttackHitData
      {
         var mc0:SingleMovieclip = this.nowMC;
         if(mc0 == null)
         {
            return null;
         }
         var ad:AttackHitDataGroup = mc0.attackData;
         if(ad is AttackHitDataGroup)
         {
            if(ad.arr[mc0.currentFrame] != null)
            {
            }
            return ad.arr[mc0.currentFrame];
         }
         return null;
      }
      
      public function setLevel(num:int) : *
      {
      }
      
      public function pause() : *
      {
         var smc0:SingleMovieclip = this.getNowMC();
         if(smc0 is SingleMovieclip)
         {
            smc0.pause();
         }
      }
      
      public function resume() : *
      {
         var smc0:SingleMovieclip = this.getNowMC();
         if(smc0 is SingleMovieclip)
         {
            smc0.resume();
         }
      }
      
      public function clear() : *
      {
         var n:* = undefined;
         for(n in this.mc_arr)
         {
            this.mc_arr[n].clear();
         }
         if(Boolean(this.lighting_mc))
         {
            this.lighting_mc.stop();
         }
      }
      
      public function imageTimer() : *
      {
         if(this.endTimerB)
         {
            this.animationEnd_Timer();
         }
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
         if(Boolean(this.shake) && Boolean(this.lighting_mc))
         {
            if(this.lighting_mc.currentFrame == 1)
            {
               this.shake.startShake(30,1,Math.random() * 10,-2,2,0.5,"random");
            }
         }
      }
   }
}

