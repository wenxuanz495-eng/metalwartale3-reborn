package sound
{
   import flash.media.Sound;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   import flash.net.SharedObject;
   import flash.net.URLRequest;
   
   public class SoundGroup
   {
      
      public var arr:Array = [];
      
      public var arr2:Array = [];

      public var soundVolume:Number = 1;

      public var musicVolume:Number = 1;

      public var masterVolume:Number = 0.5;

      public var baseOutputGain:Number = 0.09;

      public var bgmBoost:Number = 3.85;

      public var effectsVolume:Number = 1;

      public var battleVolume:Number = 1;

      public var deathExplosionVolume:Number = 1;

      private var battleBoomSound:Sound;

      private var deathElectricSound:Sound;

      private var deathDelayElectricSound:Sound;

      private var environmentBreakSound:Sound;
      
      public function SoundGroup()
      {
         var settings:SharedObject = null;
         var initialVolume:Number = 0.5;
         var storedVolume:Number = -1;
         var settingsVersion:int = 0;
         super();
         try
         {
            settings = SharedObject.getLocal("metalWarTaleSettings");
            settingsVersion = int(settings.data.audioSettingsVersion);
            if(settings.data.audioSettingsVersion === 2 && settings.data.effectsVolume !== undefined)
            {
               storedVolume = Number(settings.data.effectsVolume);
            }
            else if(settings.data.masterVolume !== undefined)
            {
               storedVolume = Number(settings.data.masterVolume);
            }
            if(storedVolume >= 0)
            {
               initialVolume = settingsVersion < 4 ? storedVolume / this.baseOutputGain : storedVolume;
            }
         }
         catch(error:Error)
         {
            initialVolume = 0.5;
         }
         this.setMasterVolume(initialVolume);
      }
      
      public function addSoundList(labelArr:Array) : *
      {
         var n:* = undefined;
         var label0:String = null;
         for(n in labelArr)
         {
            label0 = labelArr[n];
            this.addSound(Game.swfLoaderManager.getResource("sound",label0),label0);
         }
      }
      
      public function addMusicList(labelArr:Array) : *
      {
         var n:* = undefined;
         var label0:String = null;
         for(n in labelArr)
         {
            label0 = labelArr[n];
            this.addMusic(Game.swfLoaderManager.getResource("sound",label0),label0);
         }
      }
      
      public function addSound(_sound:Sound, _label:String) : *
      {
         if(_sound == null)
         {
            trace("跳过空音效：" + _label);
            return;
         }
         var s0:OneSound = new OneSound(_sound,_label);
         this.arr.push(s0);
      }
      
      public function playSound(_label:String) : *
      {
         var s0:OneSound = this.getSound(_label);
         if(s0 is OneSound)
         {
            s0.play();
         }
      }
      
      public function getSound(_label:String) : OneSound
      {
         var n:* = undefined;
         var s0:OneSound = null;
         for(n in this.arr)
         {
            s0 = this.arr[n];
            if(s0.label == _label)
            {
               return s0;
            }
         }
         trace("没找到音效：" + _label);
         return null;
      }
      
      public function addMusic(_sound:Sound, _label:String) : *
      {
         if(_sound == null)
         {
            trace("跳过空音乐：" + _label);
            return;
         }
         var s0:OneMusic = new OneMusic(_sound,_label);
         this.arr2.push(s0);
      }
      
      public function playMusic(_label:String) : OneMusic
      {
         var s0:OneMusic = this.getMusic(_label);
         if(s0 is OneMusic)
         {
            s0.play();
            return s0;
         }
         return null;
      }
      
      public function stopMusic(_label:String) : *
      {
         var s0:OneMusic = this.getMusic(_label);
         if(s0 is OneMusic)
         {
            s0.stop();
         }
      }
      
      public function getMusic(_label:String) : OneMusic
      {
         var n:* = undefined;
         var s0:OneMusic = null;
         for(n in this.arr2)
         {
            s0 = this.arr2[n];
            if(s0.label == _label)
            {
               return s0;
            }
         }
         trace("没找到音效：" + _label);
         return null;
      }
      
      public function stopAllMusic() : *
      {
         var n:* = undefined;
         var s0:OneMusic = null;
         for(n in this.arr2)
         {
            s0 = this.arr2[n];
            s0.stop();
         }
      }

      public function setSoundVolume(value:Number) : *
      {
         var n:* = undefined;
         var s0:OneSound = null;
         this.soundVolume = Math.max(0,Math.min(1,value));
         for(n in this.arr)
         {
            s0 = this.arr[n];
            if(s0.SC != null)
            {
               s0.SC.soundTransform = new SoundTransform(this.effectsVolume * this.soundVolume);
            }
         }
      }

      public function setMasterVolume(value:Number) : *
      {
         this.masterVolume = Math.max(0,Math.min(1,value));
         SoundMixer.soundTransform = new SoundTransform(this.masterVolume * this.baseOutputGain);
      }

      public function setEffectsVolume(value:Number) : *
      {
         var n:* = undefined;
         var s0:OneSound = null;
         this.effectsVolume = Math.max(0,Math.min(1,value));
         Game.gameSprite.soundTransform = new SoundTransform(this.effectsVolume);
         for(n in this.arr)
         {
            s0 = this.arr[n];
            if(s0.SC != null)
            {
               s0.SC.soundTransform = new SoundTransform(this.effectsVolume * this.soundVolume);
            }
         }
      }

      public function setBattleVolume(value:Number) : *
      {
         this.battleVolume = Math.max(0,Math.min(1,value));
         Game.gameSprite.gamingL.soundTransform = new SoundTransform(this.battleVolume);
      }

      public function setDeathExplosionVolume(value:Number) : *
      {
         this.deathExplosionVolume = Math.max(0,Math.min(1,value));
      }

      public function loadBattleSounds() : *
      {
         if(this.battleBoomSound != null)
         {
            return;
         }
         this.battleBoomSound = new Sound();
         this.battleBoomSound.load(new URLRequest("swf/battle_boom.mp3"));
         this.deathElectricSound = new Sound();
         this.deathElectricSound.load(new URLRequest("swf/death_electric.mp3"));
         this.deathDelayElectricSound = new Sound();
         this.deathDelayElectricSound.load(new URLRequest("swf/death_delay_electric.mp3"));
         this.environmentBreakSound = new Sound();
         this.environmentBreakSound.load(new URLRequest("swf/environment_break.mp3"));
      }

      public function playBattleBoom() : *
      {
         if(this.battleBoomSound == null)
         {
            this.loadBattleSounds();
         }
         try
         {
            this.battleBoomSound.play(0,1,new SoundTransform(this.effectsVolume * this.deathExplosionVolume));
         }
         catch(error:Error)
         {
         }
      }

      public function playDeathElectric() : *
      {
         this.playDeathSound(this.deathElectricSound);
      }

      public function playDeathDelayElectric() : *
      {
         this.playDeathSound(this.deathDelayElectricSound);
      }

      public function playEnvironmentBreak() : *
      {
         this.playDeathSound(this.environmentBreakSound);
      }

      private function playDeathSound(sound:Sound) : *
      {
         if(sound == null)
         {
            this.loadBattleSounds();
            return;
         }
         try
         {
            sound.play(0,1,new SoundTransform(this.effectsVolume * this.deathExplosionVolume));
         }
         catch(error:Error)
         {
         }
      }

      public function setMusicVolume(value:Number) : *
      {
         var n:* = undefined;
         var s0:OneMusic = null;
         this.musicVolume = Math.max(0,Math.min(1,value));
         for(n in this.arr2)
         {
            s0 = this.arr2[n];
            if(s0.SC != null)
            {
               s0.SC.soundTransform = new SoundTransform(this.musicVolume * this.bgmBoost);
            }
         }
      }
   }
}

