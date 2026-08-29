package sound
{
   import flash.media.Sound;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.SharedObject;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class SoundGroup
   {
      
      public var arr:Array = [];
      
      public var arr2:Array = [];

      public var soundVolume:Number = 1;

      public var musicVolume:Number = 0.7;

      public var bgmEnabled:Boolean = true;

      public var recommendedBGMEnabled:Boolean = true;

      public var customPlaylistBGMEnabled:Boolean = false;

      public var recommendedCatalog:Array = [];

      public var mainPlaylist:Array = [];

      public var battlePlaylist:Array = [];

      public var mainPlaylistMode:String = "sequence";

      public var battlePlaylistMode:String = "random";

      public var playlistDefinitions:Array = [];

      public var mainPlaylistID:String = "developer_main";

      public var battlePlaylistID:String = "developer_battle";

      private var externalBGMReady:Boolean = false;

      private var externalBGMLabel:String = "";

      private var externalBGMOwner:OneMusic;

      private var externalBGMStopTimer:uint = 0;

      private var externalBGMGeneration:uint = 0;

      private var externalBGMCommandSeq:Number = 0;

      private var activeRecommendedPlaylistID:String = "";

      private var externalBGMSupported:Object;

      private var playlistConfigured:Boolean = false;

      private var catalogRefreshCallback:Function;

      public var masterVolume:Number = 0.7;

      public var baseOutputGain:Number = 0.09;

      public var bgmBoost:Number = 4.2;

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
         var initialVolume:Number = 0.7;
         var storedVolume:Number = -1;
         var settingsVersion:int = 0;
         super();
         this.externalBGMSupported = {
            "Cut_and_Run":true,
            "Decisions":true,
            "Finding_the_Balance":true,
            "Junkyard_Tribe":true,
            "Latin_Industries":true,
            "One_Sly_Move":true,
            "Presenterator":true,
            "Rocket":true,
            "Shiny_Tech":true,
            "Smash_Sketch":true
         };
         this.externalBGMRequest("/api/bgm/status",this.externalBGMStatusComplete);
         this.externalBGMRequest("/api/bgm/catalog",this.externalBGMCatalogComplete);
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
            if(settings.data.musicVolume !== undefined)
            {
               this.musicVolume = Math.max(0,Math.min(1,Number(settings.data.musicVolume)));
            }
            if(settings.data.bgmEnabled !== undefined)
            {
               this.bgmEnabled = Boolean(settings.data.bgmEnabled);
            }
            if(settings.data.recommendedBGMEnabled !== undefined)
            {
               this.recommendedBGMEnabled = Boolean(settings.data.recommendedBGMEnabled);
            }
            else
            {
               this.recommendedBGMEnabled = true;
               this.bgmEnabled = false;
            }
            if(settings.data.customPlaylistBGMEnabled !== undefined)
            {
               this.customPlaylistBGMEnabled = Boolean(settings.data.customPlaylistBGMEnabled);
               if(this.customPlaylistBGMEnabled)
               {
                  this.recommendedBGMEnabled = false;
                  this.bgmEnabled = false;
               }
            }
            if(settings.data.playlistConfigured === true)
            {
               this.playlistConfigured = true;
               if(settings.data.mainPlaylist is Array) this.mainPlaylist = settings.data.mainPlaylist.concat();
               if(settings.data.battlePlaylist is Array) this.battlePlaylist = settings.data.battlePlaylist.concat();
            }
            if(settings.data.mainPlaylistMode !== undefined) this.mainPlaylistMode = String(settings.data.mainPlaylistMode);
            if(settings.data.battlePlaylistMode !== undefined) this.battlePlaylistMode = String(settings.data.battlePlaylistMode);
            if(settings.data.playlistDefinitions is Array)
            {
               this.playlistDefinitions = settings.data.playlistDefinitions.concat();
               if(settings.data.mainPlaylistID !== undefined) this.mainPlaylistID = String(settings.data.mainPlaylistID);
               if(settings.data.battlePlaylistID !== undefined) this.battlePlaylistID = String(settings.data.battlePlaylistID);
               this.resolveNamedPlaylists();
            }
         }
         catch(error:Error)
         {
            initialVolume = 0.7;
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
         this.externalBGMSendVolume();
         for(n in this.arr2)
         {
            s0 = this.arr2[n];
            if(s0.SC != null)
            {
               s0.SC.soundTransform = new SoundTransform(this.getMusicGain());
            }
         }
      }

      public function setBGMEnabled(value:Boolean) : *
      {
         var n:* = undefined;
         var s0:OneMusic = null;
         this.bgmEnabled = value;
         if(value)
         {
            this.recommendedBGMEnabled = false;
            this.customPlaylistBGMEnabled = false;
         }
         if(this.externalBGMReady)
         {
            if(!value)
            {
               this.externalBGMRequest("/api/bgm/stop");
            }
            else if(this.externalBGMLabel != "")
            {
               this.externalBGMRequest("/api/bgm/play?label=" + encodeURIComponent(this.externalBGMLabel));
               this.externalBGMSendVolume();
            }
         }
         for(n in this.arr2)
         {
            s0 = this.arr2[n];
            if(s0.SC != null)
            {
               s0.SC.soundTransform = new SoundTransform(this.getMusicGain());
            }
         }
      }

      public function setRecommendedBGMEnabled(value:Boolean) : *
      {
         this.recommendedBGMEnabled = value;
         if(!value)
         {
            this.activeRecommendedPlaylistID = "";
         }
         if(value)
         {
            this.bgmEnabled = false;
            this.customPlaylistBGMEnabled = false;
         }
         this.restartCurrentExternalBGM();
      }

      public function setCustomPlaylistBGMEnabled(value:Boolean) : *
      {
         this.customPlaylistBGMEnabled = value;
         this.activeRecommendedPlaylistID = "";
         if(value)
         {
            this.bgmEnabled = false;
            this.recommendedBGMEnabled = false;
            if(this.externalBGMOwner != null) this.externalBGMOwner.stopFlashOnly();
            this.syncCurrentRecommendedPlaylist();
         }
         else if(this.externalBGMReady)
         {
            this.externalBGMRequest("/api/bgm/stop");
         }
      }

      private function playlistBGMEnabled() : Boolean
      {
         return this.recommendedBGMEnabled || this.customPlaylistBGMEnabled;
      }

      public function setPlaylist(context:String, ids:Array, mode:String) : *
      {
         this.playlistConfigured = true;
         if(context == "battle")
         {
            this.battlePlaylist = ids.concat();
            this.battlePlaylistMode = mode;
         }
         else
         {
            this.mainPlaylist = ids.concat();
            this.mainPlaylistMode = mode;
         }
         if(this.playlistBGMEnabled())
         {
            this.syncCurrentRecommendedPlaylist();
         }
      }

      public function ensureNamedPlaylists() : *
      {
         if(this.playlistDefinitions.length > 0)
         {
            this.resolveNamedPlaylists();
            return;
         }
         this.playlistDefinitions.push({id:"developer_main",name:"开发者主界面歌单",tracks:this.mainPlaylist.concat(),mode:this.mainPlaylistMode});
         this.playlistDefinitions.push({id:"developer_battle",name:"开发者战斗歌单",tracks:this.battlePlaylist.concat(),mode:this.battlePlaylistMode});
         this.mainPlaylistID = "developer_main";
         this.battlePlaylistID = "developer_battle";
         this.playlistConfigured = true;
         this.resolveNamedPlaylists();
      }

      public function getNamedPlaylist(id:String) : Object
      {
         var playlist:Object = null;
         for each(playlist in this.playlistDefinitions)
         {
            if(String(playlist.id) == id) return playlist;
         }
         return null;
      }

      public function createNamedPlaylist() : Object
      {
         this.ensureNamedPlaylists();
         var playlist:Object = {id:"custom_" + new Date().time,name:"自定义歌单 " + String(this.playlistDefinitions.length - 1),tracks:[],mode:"sequence"};
         this.playlistDefinitions.push(playlist);
         return playlist;
      }

      public function updateNamedPlaylist(id:String, tracks:Array, mode:String) : *
      {
         var playlist:Object = this.getNamedPlaylist(id);
         if(playlist == null) return;
         playlist.tracks = tracks.concat();
         playlist.mode = mode;
         this.resolveNamedPlaylists();
         this.syncCurrentRecommendedPlaylist();
      }

      public function assignNamedPlaylist(id:String, context:String) : *
      {
         if(this.getNamedPlaylist(id) == null) return;
         if(context == "battle") this.battlePlaylistID = id;
         else this.mainPlaylistID = id;
         this.resolveNamedPlaylists();
         this.syncCurrentRecommendedPlaylist();
      }

      private function syncCurrentRecommendedPlaylist() : *
      {
         // A named playlist is owned by the external player and does not need
         // an original Flash BGM label to become active.  Player-library tracks
         // are commonly previewed before the playlist is saved, so requiring
         // externalBGMLabel here left the saved playlist as a one-off preview.
         if(!this.playlistBGMEnabled() || !this.externalBGMReady) return;
         var context:String = Game.gameState == "gaming" ? "battle" : "main";
         var ids:Array = context == "battle" ? this.battlePlaylist : this.mainPlaylist;
         var mode:String = context == "battle" ? this.battlePlaylistMode : this.mainPlaylistMode;
         var playlistID:String = context == "battle" ? this.battlePlaylistID : this.mainPlaylistID;
         var playlist:Object = null;
         if(this.recommendedBGMEnabled)
         {
            playlist = this.getNamedPlaylist(context == "battle" ? "developer_battle" : "developer_main");
            if(playlist != null)
            {
               ids = (playlist.tracks as Array).concat();
               mode = String(playlist.mode);
               playlistID = String(playlist.id);
            }
         }
         if(this.customPlaylistBGMEnabled && playlistID.indexOf("custom_") != 0)
         {
            this.activeRecommendedPlaylistID = "";
            this.externalBGMRequest("/api/bgm/stop");
            return;
         }
         if(playlistID == "" || ids.length == 0) return;
         if(playlistID != "" && playlistID != this.activeRecommendedPlaylistID)
         {
            this.activeRecommendedPlaylistID = playlistID;
            this.externalBGMRequest("/api/bgm/playlist/start?context=" + context + "&mode=" + mode + "&tracks=" + ids.join(",") + "&force=1");
         }
         else
         {
            this.externalBGMRequest("/api/bgm/playlist/update?context=" + context + "&mode=" + mode + "&tracks=" + ids.join(","));
         }
         this.externalBGMSendVolume();
      }

      public function openPlayerBGMLibrary() : *
      {
         if(this.externalBGMReady) this.externalBGMRequest("/api/bgm/player-library/open");
      }

      public function refreshExternalBGMCatalog(complete:Function = null) : *
      {
         if(!this.externalBGMReady) return;
         this.catalogRefreshCallback = complete;
         this.externalBGMRequest("/api/bgm/catalog/rescan",this.externalBGMRescanComplete);
      }

      private function externalBGMRescanComplete(event:Event) : *
      {
         var data:Object = null;
         try
         {
            data = JSON.parse(URLLoader(event.currentTarget).data);
            this.recommendedCatalog = data.tracks as Array;
            if(this.recommendedCatalog == null) this.recommendedCatalog = [];
            this.migratePlaylistAliases();
         }
         catch(error:Error)
         {
         }
         if(this.catalogRefreshCallback != null)
         {
            var callback:Function = this.catalogRefreshCallback;
            this.catalogRefreshCallback = null;
            callback();
         }
      }

      private function resolveNamedPlaylists() : *
      {
         var main:Object = this.getNamedPlaylist(this.mainPlaylistID);
         var battle:Object = this.getNamedPlaylist(this.battlePlaylistID);
         if(main == null && this.playlistDefinitions.length > 0)
         {
            main = this.playlistDefinitions[0];
            this.mainPlaylistID = String(main.id);
         }
         if(battle == null && this.playlistDefinitions.length > 0)
         {
            battle = this.playlistDefinitions[0];
            this.battlePlaylistID = String(battle.id);
         }
         if(main != null)
         {
            this.mainPlaylist = (main.tracks as Array).concat();
            this.mainPlaylistMode = String(main.mode);
         }
         if(battle != null)
         {
            this.battlePlaylist = (battle.tracks as Array).concat();
            this.battlePlaylistMode = String(battle.mode);
         }
      }

      public function playRecommendedTrack(id:String) : *
      {
         if(!this.externalBGMReady) return;
         this.externalBGMRequest("/api/bgm/track/play?id=" + encodeURIComponent(id));
         this.externalBGMSendVolume();
      }

      public function seekExternalBGM(seconds:Number) : *
      {
         if(!this.externalBGMReady) return;
         this.externalBGMRequest("/api/bgm/seek?seconds=" + seconds);
      }

      public function requestExternalBGMStatus(complete:Function) : *
      {
         if(!this.externalBGMReady) return;
         this.externalBGMRequest("/api/bgm/status",complete);
      }

      public function pauseExternalBGM() : *
      {
         if(this.externalBGMReady) this.externalBGMRequest("/api/bgm/pause");
      }

      public function resumeExternalBGM() : *
      {
         if(this.externalBGMReady) this.externalBGMRequest("/api/bgm/resume");
      }

      public function previousExternalBGM() : *
      {
         if(this.externalBGMReady) this.externalBGMRequest("/api/bgm/previous");
      }

      public function nextExternalBGM() : *
      {
         if(this.externalBGMReady) this.externalBGMRequest("/api/bgm/next");
      }

      public function getPlaylistConfigured() : Boolean
      {
         return this.playlistConfigured;
      }

      public function getMusicGain() : Number
      {
         return this.bgmEnabled && !this.playlistBGMEnabled() ? this.musicVolume * this.bgmBoost : 0;
      }

      public function playExternalMusic(owner:OneMusic) : Boolean
      {
         if(owner == null)
         {
            return false;
         }
         this.externalBGMLabel = owner.label;
         this.externalBGMOwner = owner;
         if(this.playlistBGMEnabled())
         {
            if(!this.externalBGMReady || this.recommendedCatalog.length == 0)
            {
               return false;
            }
            owner.stopFlashOnly();
            this.playRecommendedPlaylist();
            return true;
         }
         if(!this.bgmEnabled)
         {
            owner.stopFlashOnly();
            if(this.externalBGMReady) this.externalBGMRequest("/api/bgm/stop");
            return true;
         }
         if(!this.externalBGMSupported[owner.label])
         {
            return false;
         }
         if(!this.externalBGMReady)
         {
            return false;
         }
         owner.stopFlashOnly();
         if(this.bgmEnabled)
         {
            this.externalBGMRequest("/api/bgm/play?label=" + encodeURIComponent(owner.label));
            this.externalBGMSendVolume();
         }
         return true;
      }

      public function stopExternalMusic(label:String) : Boolean
      {
         if(label != this.externalBGMLabel)
         {
            return false;
         }
         this.externalBGMOwner = null;
         this.externalBGMLabel = "";
         if(this.externalBGMReady && !this.playlistBGMEnabled())
         {
            this.scheduleExternalBGMStop();
         }
         return true;
      }

      private function beginExternalBGMPlayback() : *
      {
         ++this.externalBGMGeneration;
         if(this.externalBGMStopTimer != 0)
         {
            clearTimeout(this.externalBGMStopTimer);
            this.externalBGMStopTimer = 0;
         }
      }

      private function scheduleExternalBGMStop() : *
      {
         var generation:uint = ++this.externalBGMGeneration;
         if(this.externalBGMStopTimer != 0)
         {
            clearTimeout(this.externalBGMStopTimer);
         }
         this.externalBGMStopTimer = setTimeout(function():void
         {
            externalBGMStopTimer = 0;
            if(generation == externalBGMGeneration)
            {
               externalBGMRequest("/api/bgm/stop");
            }
         },150);
      }

      private function externalBGMStatusComplete(event:Event) : *
      {
         var data:Object = null;
         try
         {
            data = JSON.parse(URLLoader(event.currentTarget).data);
            this.externalBGMReady = Boolean(data.ready);
         }
         catch(error:Error)
         {
            this.externalBGMReady = false;
         }
         if(this.externalBGMReady && this.playlistBGMEnabled() && this.recommendedCatalog.length > 0)
         {
            if(this.externalBGMOwner != null) this.externalBGMOwner.stopFlashOnly();
            this.playRecommendedPlaylist();
         }
         else if(this.externalBGMReady && this.externalBGMOwner != null && this.externalBGMLabel == this.externalBGMOwner.label)
         {
            this.externalBGMOwner.stopFlashOnly();
            if(this.bgmEnabled)
            {
               this.externalBGMRequest("/api/bgm/play?label=" + encodeURIComponent(this.externalBGMLabel));
               this.externalBGMSendVolume();
            }
         }
      }

      private function externalBGMCatalogComplete(event:Event) : *
      {
         var data:Object = null;
         var track:Object = null;
         var item:Object = null;
         var mainDefaults:Array = [];
         var battleDefaults:Array = [];
         try
         {
            data = JSON.parse(URLLoader(event.currentTarget).data);
            this.recommendedCatalog = data.tracks as Array;
            if(this.recommendedCatalog == null) this.recommendedCatalog = [];
            if(!this.playlistConfigured)
            {
               for each(track in this.recommendedCatalog)
               {
                  if(Boolean(track.default_main) || track.default_main === undefined && track.context == "main") mainDefaults.push({id:String(track.id),order:int(track.main_order)});
                  if(Boolean(track.default_battle) || track.default_battle === undefined && track.context == "battle") battleDefaults.push({id:String(track.id),order:int(track.battle_order)});
               }
               mainDefaults.sortOn("order",Array.NUMERIC);
               battleDefaults.sortOn("order",Array.NUMERIC);
               for each(item in mainDefaults) this.mainPlaylist.push(String(item.id));
               for each(item in battleDefaults) this.battlePlaylist.push(String(item.id));
               if(this.playlistDefinitions.length > 0)
               {
                  var defaultMain:Object = this.getNamedPlaylist("developer_main");
                  var defaultBattle:Object = this.getNamedPlaylist("developer_battle");
                  if(defaultMain != null && (defaultMain.tracks as Array).length == 0) defaultMain.tracks = this.mainPlaylist.concat();
                  if(defaultBattle != null && (defaultBattle.tracks as Array).length == 0) defaultBattle.tracks = this.battlePlaylist.concat();
               }
            }
            this.migratePlaylistAliases();
         }
         catch(error:Error)
         {
            this.recommendedCatalog = [];
         }
         if(this.externalBGMReady && this.playlistBGMEnabled())
         {
            if(this.externalBGMOwner != null) this.externalBGMOwner.stopFlashOnly();
            this.playRecommendedPlaylist();
         }
         this.ensureNamedPlaylists();
      }

      private function migratePlaylistAliases() : *
      {
         this.mainPlaylist = this.migratePlaylistIDs(this.mainPlaylist);
         this.battlePlaylist = this.migratePlaylistIDs(this.battlePlaylist);
         var playlist:Object = null;
         for each(playlist in this.playlistDefinitions)
         {
            if(playlist.tracks is Array) playlist.tracks = this.migratePlaylistIDs(playlist.tracks as Array);
         }
      }

      private function migratePlaylistIDs(ids:Array) : Array
      {
         var result:Array = [];
         var id:String = null;
         var canonical:String = null;
         for each(id in ids)
         {
            canonical = this.canonicalRecommendedTrackID(id);
            if(result.indexOf(canonical) < 0) result.push(canonical);
         }
         return result;
      }

      private function canonicalRecommendedTrackID(id:String) : String
      {
         var track:Object = null;
         for each(track in this.recommendedCatalog)
         {
            if(String(track.id) == id || track.aliases is Array && (track.aliases as Array).indexOf(id) >= 0) return String(track.id);
         }
         return id;
      }

      private function playRecommendedPlaylist() : *
      {
         var context:String = Game.gameState == "gaming" ? "battle" : "main";
         var ids:Array = context == "battle" ? this.battlePlaylist : this.mainPlaylist;
         var mode:String = context == "battle" ? this.battlePlaylistMode : this.mainPlaylistMode;
         var playlistID:String = context == "battle" ? this.battlePlaylistID : this.mainPlaylistID;
         var playlist:Object = null;
         if(this.recommendedBGMEnabled)
         {
            playlist = this.getNamedPlaylist(context == "battle" ? "developer_battle" : "developer_main");
            if(playlist != null)
            {
               ids = (playlist.tracks as Array).concat();
               mode = String(playlist.mode);
               playlistID = String(playlist.id);
            }
         }
         if(this.customPlaylistBGMEnabled && playlistID.indexOf("custom_") != 0)
         {
            this.activeRecommendedPlaylistID = "";
            this.externalBGMRequest("/api/bgm/stop");
            return;
         }
         if(ids.length == 0)
         {
            this.activeRecommendedPlaylistID = "";
            this.externalBGMRequest("/api/bgm/stop");
            return;
         }
         if(playlistID != "" && playlistID == this.activeRecommendedPlaylistID)
         {
            this.externalBGMSendVolume();
            return;
         }
         this.activeRecommendedPlaylistID = playlistID;
         // Scene changes must not restart a player track that is still present
         // in the destination playlist. Explicit playlist edits use
         // syncCurrentRecommendedPlaylist(), which keeps force=1 semantics.
         this.externalBGMRequest("/api/bgm/playlist/start?context=" + context + "&mode=" + mode + "&tracks=" + ids.join(","));
         this.externalBGMSendVolume();
      }

      private function restartCurrentExternalBGM() : *
      {
         if(this.externalBGMOwner == null || !this.externalBGMReady)
         {
            return;
         }
         if(this.playlistBGMEnabled())
         {
            this.externalBGMOwner.stopFlashOnly();
            this.playRecommendedPlaylist();
         }
         else if(this.bgmEnabled && this.externalBGMSupported[this.externalBGMLabel])
         {
            this.externalBGMOwner.stopFlashOnly();
            this.externalBGMRequest("/api/bgm/play?label=" + encodeURIComponent(this.externalBGMLabel));
            this.externalBGMSendVolume();
         }
         else
         {
            this.externalBGMOwner.stopFlashOnly();
            this.externalBGMRequest("/api/bgm/stop");
         }
      }

      private function externalBGMSendVolume() : *
      {
         if(this.externalBGMReady)
         {
            this.externalBGMRequest("/api/bgm/volume?value=" + this.musicVolume);
         }
      }

      private function externalBGMRequest(path:String, complete:Function = null) : *
      {
         var orderedCommand:Boolean = path.indexOf("/api/bgm/play?") == 0 || path.indexOf("/api/bgm/playlist/start?") == 0 || path.indexOf("/api/bgm/track/play?") == 0 || path == "/api/bgm/stop";
         if(orderedCommand)
         {
            if(path.indexOf("/api/bgm/stop") != 0)
            {
               this.beginExternalBGMPlayback();
            }
            path += (path.indexOf("?") >= 0 ? "&" : "?") + "seq=" + this.nextExternalBGMCommandSeq();
         }
         var loader:URLLoader = new URLLoader();
         if(complete != null)
         {
            loader.addEventListener(Event.COMPLETE,complete,false,0,true);
         }
         loader.addEventListener(IOErrorEvent.IO_ERROR,this.externalBGMIgnoreError,false,0,true);
         try
         {
            loader.load(new URLRequest(path));
         }
         catch(error:Error)
         {
         }
      }

      private function externalBGMIgnoreError(event:IOErrorEvent) : *
      {
      }

      private function nextExternalBGMCommandSeq() : Number
      {
         var now:Number = new Date().time;
         if(now <= this.externalBGMCommandSeq)
         {
            now = this.externalBGMCommandSeq + 1;
         }
         this.externalBGMCommandSeq = now;
         return now;
      }
   }
}

