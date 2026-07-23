package effect
{
   import flash.display.DisplayObjectContainer;
   import image.BmpMovieClipManager;
   import net.SWFLoaderManager;
   
   public class EffectGroup
   {
      
      public var arr:Array = new Array();
      
      private var swfLoaderManager:SWFLoaderManager;
      
      private var bmpMovieClipManager:BmpMovieClipManager;
      
      public var lightning:BezierLightning = new BezierLightning();
      
      public var lightning2:BezierLightning = new BezierLightning(16776960,16711680);
      
      public var lightning3:BezierLightning = new BezierLightning(11992953,65280);
      
      public function EffectGroup()
      {
         super();
      }
      
      public function init() : *
      {
         this.bmpMovieClipManager = Game.bmpMovieClipManager;
         this.swfLoaderManager = Game.swfLoaderManager;
      }
      
      public function gamingInit() : *
      {
         Game.gameSprite.effectL.addChild(this.lightning);
         Game.gameSprite.effectL.addChild(this.lightning2);
         Game.gameSprite.effectL.addChild(this.lightning3);
      }
      
      public function addShock(sp0:*) : *
      {
         var shock:Shock = new Shock();
      }
      
      public function addEffect(father0:String, label0:String, doc:DisplayObjectContainer, x0:Number = 0, y0:Number = 0, ra:Number = 0, bmpB:Boolean = false) : EffectSMC
      {
         var smc:EffectSMC = null;
         if(bmpB)
         {
            smc = this.addEffectInMC(this.bmpMovieClipManager.getSingleMovieclip(father0,label0).mc,father0,label0,doc,x0,y0,ra,bmpB);
         }
         else
         {
            smc = this.addEffectInMC(this.swfLoaderManager.getResource(father0,label0),father0,label0,doc,x0,y0,ra,bmpB);
         }
         return smc;
      }
      
      public function addEffectInMC(mc0:*, father0:String, label0:String, doc:DisplayObjectContainer, x0:Number = 0, y0:Number = 0, ra:Number = 0, bmpB:Boolean = false) : EffectSMC
      {
         var smc:EffectSMC = null;
         if(label0 == "")
         {
            label0 = "sub/noBullet";
         }
         smc = new EffectSMC(mc0,label0,father0);
         this.arr.unshift(smc);
         smc.mc.x = x0;
         smc.mc.y = y0;
         smc.mc.rotation = ra / Math.PI * 180;
         doc.addChild(smc.mc);
         smc._isPlaying = true;
         if(label0 == "boom_effect")
         {
            Game.SG.playBattleBoom();
         }
         else if(label0 == "electric_effect")
         {
            Game.SG.playDeathElectric();
         }
         else if(label0 == "thingsBoom" || label0 == "thingsBoom2")
         {
            Game.SG.playEnvironmentBreak();
         }
         if(Game.gamingTimerB)
         {
            smc.play();
         }
         return smc;
      }

      public function pauseAllEffect() : *
      {
         var n:* = undefined;
         var smc:EffectSMC = null;
         for(n in this.arr)
         {
            smc = this.arr[n];
            smc.pause();
         }
      }
      
      public function resumeAllEffect() : *
      {
         var n:* = undefined;
         var smc:EffectSMC = null;
         for(n in this.arr)
         {
            smc = this.arr[n];
            smc.resume();
         }
      }
      
      public function clearAllEffect() : *
      {
         var n:* = undefined;
         var smc:EffectSMC = null;
         var _mc:* = undefined;
         for(n in this.arr)
         {
            smc = this.arr[n];
            _mc = smc.mc;
            smc.clear();
            _mc.parent.removeChild(_mc);
         }
         this.arr.length = 0;
      }
      
      public function EGTimer() : *
      {
         var n:* = undefined;
         var smc:EffectSMC = null;
         var _mc:* = undefined;
         var arr0:Array = new Array();
         for(n in this.arr)
         {
            smc = this.arr[n];
            if(smc.endFrameB)
            {
               smc.die = 2;
               smc.stop();
               _mc = smc.mc;
               smc.clear();
               _mc.parent.removeChild(_mc);
            }
            else
            {
               arr0.push(smc);
            }
         }
         this.arr = arr0;
         this.lightning.init();
         this.lightning2.init();
         this.lightning3.init();
      }
   }
}

