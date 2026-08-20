package UI
{
   import UI._new.main._InfoUI;
   import UI.top.HighPlayerBox;
   import flash.display.Shape;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.KeyboardEvent;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.events.FocusEvent;
   import flash.geom.Point;
   import flash.net.SharedObject;
   import flash.net.URLLoader;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFieldType;
   import flash.ui.Keyboard;
   import flash.utils.Timer;
   
   public class AllBack extends Sprite
   {
      
      public var box:HighPlayerBox = new HighPlayerBox();
      
      public var carBack_mc:Sprite;
      
      public var info:_InfoUI = new _InfoUI();
      
      public var return_btn:SimpleButton;
      
      public var volume_off_btn:SimpleButton;
      
      public var volume_on_btn:SimpleButton;

      private var settings_btn:Sprite;

      private var settingsPanel:Sprite;

      private var sliderBars:Array = [];

      private var sliderKnobs:Array = [];

      private var sliderValues:Array = [];

      private var draggingSlider:int = -1;

      private var soundSettings:SharedObject;

      private var soundPage:Sprite;

      private var bgmCheck:Sprite;

      private var backupPromptCheck:Sprite;

      private var backupPromptEnabled:Boolean = true;

      private var keyPage:Sprite;

      private var playlistPage:Sprite;

      private var recommendedBGMCheck:Sprite;

      private var playlistContext:String = "main";

      private var playlistTrackPage:int = 0;

      private var playlistTrackButtons:Array = [];

      private var playlistPageText:TextField;

      private var playlistOverlay:Sprite;

      private var playlistScroll:int = 0;

      private var playlistOverlayRows:Array = [];

      private var playlistScrollThumb:Shape;

      private var playlistOverlayState:TextField;

      private var playlistOverlayRecommendedCheck:Sprite;

      private var playlistCustomBGMCheck:Sprite;

      private var draftMainPlaylist:Array = [];

      private var draftBattlePlaylist:Array = [];

      private var draftMainMode:String = "sequence";

      private var draftBattleMode:String = "random";

      private var playlistDraftDirty:Boolean = false;

      private var playlistDraftInitialized:Boolean = false;

      private var playlistProgressBar:Sprite;

      private var playlistProgressFill:Shape;

      private var playlistProgressText:TextField;

      private var playlistNowPlaying:TextField;

      private var playlistStatusTimer:Timer;

      private var playlistDuration:Number = 0;

      private var playlistView:String = "playlist";

      private var playlistPauseButton:Sprite;

      private var editingPlaylistID:String = "";

      private var playlistNameText:TextField;

      private var playlistMainUseCheck:Sprite;

      private var playlistBattleUseCheck:Sprite;

      private var playlistSelectedTracks:Array = [];

      private var playlistDragStartY:Number = 0;

      private var playlistDragCurrentY:Number = 0;

      private var playlistDragActive:Boolean = false;

      private var playlistDragGhost:Sprite;

      private var playlistDraggedTrackID:String = "";

      private var playlistScrollHandle:Sprite;

      private var playlistScrollDragStartY:Number = 0;

      private var playlistScrollDragStartHandleY:Number = 0;

      private var playlistVisibleTotal:int = 0;

      private var playlistThumbHeight:Number = 309;

      private var keyButtons:Array = [];

      private var keyActions:Array = ["moveLeft","moveRight","jump","interact","weapon0","weapon1","weapon2","weapon3","weapon4","weapon5","weapon6","weapon7","rocket","plasma","change","lighting","jumpSkill","menu"];

      private var keyLabels:Array = ["左移","右移","推进/跳跃","下降/传送","武器 1","武器 2","武器 3","武器 4","武器 5","武器 6","武器 7","武器 8","火箭推进器","等离子护盾","机甲","卫星闪电炮","反重力装置","菜单/设置"];

      private var capturingKey:int = -1;
      
      public function AllBack()
      {
         super();
         this.mouseEnabled = false;
      }
      
      public function init() : *
      {
         addChild(this.info);
         addChild(this.box);
         this.box.x = 482;
         this.box.y = 400;
         removeChild(this.carBack_mc);
         this.return_btn.addEventListener(MouseEvent.CLICK,this.returnClick);
         this.volume_off_btn.visible = false;
         this.volume_on_btn.visible = false;
         this.settings_btn = this.createSettingsButton();
         this.settings_btn.x = this.volume_on_btn.x;
         this.settings_btn.y = this.volume_on_btn.y;
         addChild(this.settings_btn);
         this.settingsPanel = this.createSettingsPanel();
         addChild(this.settingsPanel);
         this.playlistOverlay = this.createPlaylistOverlay();
         addChild(this.playlistOverlay);
         this.loadSoundSettings();
         this.loadKeySettings();
         Game.SG.loadBattleSounds();
      }
      
      public function fleshData() : *
      {
         this.box.flesh_byGameData(Game.gameData);
         this.info.fleshData();
         this.fleshVolumeBtn();
         this.fleshByGameState();
      }
      
      public function fleshByGameState() : *
      {
         if(Game.gameState == "no")
         {
            this.info.mouseChildren = true;
         }
         else
         {
            this.info.mouseChildren = false;
         }
      }
      
      public function hidePlayerBox() : *
      {
         this.box.visible = false;
         if(Boolean(this.carBack_mc.parent))
         {
            this.carBack_mc.parent.removeChild(this.carBack_mc);
         }
      }
      
      public function showPlayerBox() : *
      {
         this.box.visible = true;
         addChild(this.carBack_mc);
         addChild(this.box);
         this.box.flesh_byGameData(Game.gameData);
      }
      
      public function hideInfo() : *
      {
         this.info.visible = false;
      }
      
      public function showInfo() : *
      {
         this.info.visible = true;
         this.info.fleshData();
      }
      
      public function stopAll() : *
      {
         this.closeSettings();
      }
      
      public function playAll() : *
      {
      }
      
      public function returnClick(e:* = null) : *
      {
         Game.uiGroup.show("startGame");
      }
      
      public function volumeClick(e:* = null) : *
      {
         this.playlistOverlay.visible = false;
         this.settingsPanel.visible = !this.settingsPanel.visible;
         if(this.settingsPanel.visible)
         {
            Game.gameSprite.addChild(this.settingsPanel);
         }
      }

      public function openSoundSettings() : *
      {
         this.playlistOverlay.visible = false;
         this.settingsPanel.visible = true;
         Game.gameSprite.addChild(this.settingsPanel);
      }
      
      public function fleshVolumeBtn() : *
      {
         this.volume_off_btn.visible = false;
         this.volume_on_btn.visible = false;
      }

      private function createSettingsButton() : Sprite
      {
         var button:Sprite = new Sprite();
         var icon:Shape = new Shape();
         var i:int = 0;
         var angle:Number = 0;
         button.graphics.beginFill(263177,1);
         button.graphics.lineStyle(1,65535,1);
         button.graphics.drawRect(0,0,22,22);
         button.graphics.endFill();
         icon.graphics.lineStyle(3,65535,1);
         for(i = 0; i < 8; i++)
         {
            angle = Math.PI * i / 4;
            icon.graphics.moveTo(11 + Math.cos(angle) * 6,11 + Math.sin(angle) * 6);
            icon.graphics.lineTo(11 + Math.cos(angle) * 9,11 + Math.sin(angle) * 9);
         }
         icon.graphics.lineStyle(2,65535,1);
         icon.graphics.drawCircle(11,11,6);
         icon.graphics.drawCircle(11,11,2);
         button.addChild(icon);
         button.buttonMode = true;
         button.mouseChildren = false;
         button.addEventListener(MouseEvent.CLICK,this.volumeClick);
         return button;
      }

      private function createSettingsPanel() : Sprite
      {
         var panel:Sprite = new Sprite();
         var pattern:Shape = this.createHexPattern();
         var patternMask:Shape = new Shape();
         var titleBar:Shape = new Shape();
         var title:TextField = this.makeText("\u58f0\u97f3\u8bbe\u7f6e",22,16777215,true);
         var closeButton:Sprite = new Sprite();
         var resetButton:Sprite = this.createTextButton("\u6062\u590d\u9ed8\u8ba4",this.resetCurrentSettings);
         panel.x = 320;
         panel.y = 38;
         panel.graphics.beginFill(7,0.55);
         panel.graphics.drawRect(-320,-38,950,560);
         panel.graphics.endFill();
         panel.graphics.beginFill(202795,0.99);
         panel.graphics.lineStyle(3,65535,1);
         panel.graphics.drawRect(0,0,310,478);
         panel.graphics.endFill();
         panel.graphics.lineStyle(1,38272,1);
         panel.graphics.drawRect(9,48,292,420);
         panel.addChild(pattern);
         patternMask.graphics.beginFill(16777215,1);
         patternMask.graphics.drawRect(9,48,292,420);
         patternMask.graphics.endFill();
         panel.addChild(patternMask);
         pattern.mask = patternMask;
         titleBar.graphics.beginFill(35736,1);
         titleBar.graphics.moveTo(0,0);
         titleBar.graphics.lineTo(268,0);
         titleBar.graphics.lineTo(288,18);
         titleBar.graphics.lineTo(268,40);
         titleBar.graphics.lineTo(0,40);
         titleBar.graphics.lineTo(0,0);
         titleBar.graphics.endFill();
         panel.addChild(titleBar);
         title.x = 18;
         title.y = 7;
         panel.addChild(title);
         closeButton.graphics.beginFill(1973790,1);
         closeButton.graphics.lineStyle(1,65535,1);
         closeButton.graphics.drawRect(0,0,26,26);
         closeButton.graphics.endFill();
         closeButton.graphics.lineStyle(2,16777215,1);
         closeButton.graphics.moveTo(7,7);
         closeButton.graphics.lineTo(19,19);
         closeButton.graphics.moveTo(19,7);
         closeButton.graphics.lineTo(7,19);
         closeButton.x = 274;
         closeButton.y = 7;
         closeButton.buttonMode = true;
         closeButton.addEventListener(MouseEvent.CLICK,this.closeSettings);
         panel.addChild(closeButton);
         var soundTab:Sprite = this.createTextButton("\u58f0\u97f3",this.showSoundPage);
         var keyTab:Sprite = this.createTextButton("\u952e\u4f4d",this.showKeyPage);
         var playlistTab:Sprite = this.createTextButton("\u6b4c\u5355",this.showPlaylistPage);
         soundTab.x = 2;
         soundTab.y = 50;
         keyTab.x = 104;
         keyTab.y = 50;
         playlistTab.x = 206;
         playlistTab.y = 50;
         panel.addChild(soundTab);
         panel.addChild(keyTab);
         panel.addChild(playlistTab);
         this.soundPage = new Sprite();
         this.soundPage.addChild(this.createSlider(0,"\u97f3\u6548\u97f3\u91cf",105));
         this.soundPage.addChild(this.createSlider(1,"BGM \u97f3\u91cf",190));
         this.bgmCheck = this.createBGMCheck();
         this.bgmCheck.x = 24;
         this.bgmCheck.y = 280;
         this.soundPage.addChild(this.bgmCheck);
         this.backupPromptCheck = this.createBackupPromptCheck();
         this.backupPromptCheck.x = 24;
         this.backupPromptCheck.y = 330;
         this.soundPage.addChild(this.backupPromptCheck);
         panel.addChild(this.soundPage);
         this.keyPage = this.createKeyPage();
         panel.addChild(this.keyPage);
         this.playlistPage = this.createPlaylistPage();
         panel.addChild(this.playlistPage);
         resetButton.x = 104;
         resetButton.y = 426;
         panel.addChild(resetButton);
         panel.visible = false;
         return panel;
      }

      private function createKeyPage() : Sprite
      {
         var page:Sprite = new Sprite();
         var i:int = 0;
         var col:int = 0;
         var row:int = 0;
         var label:TextField = null;
         var button:Sprite = null;
         page.y = 88;
          for(i = 0; i < this.keyActions.length; i++)
          {
             col = i < 8 || i == 17 ? 0 : 1;
             row = i >= 16 ? 8 : i % 8;
            label = this.makeText(this.keyLabels[i],12,16777215,false);
            label.x = col * 145 + 8;
            label.y = row * 38;
            page.addChild(label);
            button = new Sprite();
            button.graphics.beginFill(1973790,1);
            button.graphics.lineStyle(1,65535,1);
            button.graphics.drawRect(0,0,68,25);
            button.graphics.endFill();
            button.x = col * 145 + 73;
            button.y = row * 38 - 2;
            button.name = String(i);
            button.buttonMode = true;
            button.addEventListener(MouseEvent.CLICK,this.beginKeyCapture);
            page.addChild(button);
            this.keyButtons[i] = button;
         }
         this.fleshKeyButtons();
         page.visible = false;
         return page;
      }

      private function showSoundPage(e:MouseEvent = null) : *
      {
         this.soundPage.visible = true;
         this.keyPage.visible = false;
         this.playlistPage.visible = false;
      }

      private function showKeyPage(e:MouseEvent = null) : *
      {
         this.soundPage.visible = false;
         this.keyPage.visible = true;
         this.playlistPage.visible = false;
         this.fleshKeyButtons();
      }

      private function showPlaylistPage(e:MouseEvent = null) : *
      {
         this.soundPage.visible = false;
         this.keyPage.visible = false;
         this.playlistPage.visible = false;
         this.settingsPanel.visible = false;
         Game.SG.ensureNamedPlaylists();
         if(this.editingPlaylistID == "") this.editingPlaylistID = Game.SG.mainPlaylistID;
         if(!this.playlistDraftInitialized)
         {
            this.draftMainPlaylist = Game.SG.mainPlaylist.concat();
            this.draftBattlePlaylist = Game.SG.battlePlaylist.concat();
            this.draftMainMode = Game.SG.mainPlaylistMode;
            this.draftBattleMode = Game.SG.battlePlaylistMode;
            this.playlistDraftDirty = false;
            this.playlistDraftInitialized = true;
         }
         this.playlistScroll = 0;
         this.playlistOverlay.visible = true;
         Game.gameSprite.addChild(this.playlistOverlay);
         this.refreshPlaylistOverlay();
      }

      private function createPlaylistOverlay() : Sprite
      {
         var overlay:Sprite = new Sprite();
         var panel:Shape = new Shape();
         var title:TextField = this.makeText("自定义 BGM 歌单",22,16777215,true);
         var backButton:Sprite = this.createOverlayButton("返回设置",104,this.backToSettings);
         var closeButton:Sprite = this.createOverlayButton("关闭",72,this.closeSettings);
         var mainButton:Sprite = this.createOverlayButton("主界面歌单",122,this.showOverlayMainPlaylist);
         var battleButton:Sprite = this.createOverlayButton("战斗歌单",122,this.showOverlayBattlePlaylist);
         var sequenceButton:Sprite = this.createOverlayButton("顺序",78,this.setOverlayPlaylistMode);
         var randomButton:Sprite = this.createOverlayButton("随机",78,this.setOverlayPlaylistMode);
         var singleButton:Sprite = this.createOverlayButton("单曲",78,this.setOverlayPlaylistMode);
         var saveButton:Sprite = this.createOverlayButton("保存歌单",104,this.savePlaylistDraft);
         var playlistViewButton:Sprite = this.createOverlayButton("当前歌单",92,this.showPlaylistOnly);
         var libraryViewButton:Sprite = this.createOverlayButton("开发者曲库",100,this.showPlaylistLibrary);
         var playerLibraryViewButton:Sprite = this.createOverlayButton("玩家曲库",92,this.showPlayerLibrary);
         var previousButton:Sprite = this.createOverlayButton("上一曲",62,this.playPreviousBGM);
         var nextButton:Sprite = this.createOverlayButton("下一曲",62,this.playNextBGM);
         var previousPlaylistButton:Sprite = this.createOverlayButton("<",34,this.selectPreviousPlaylist);
         var nextPlaylistButton:Sprite = this.createOverlayButton(">",34,this.selectNextPlaylist);
         var newPlaylistButton:Sprite = this.createOverlayButton("新建",58,this.createNewPlaylist);
         var openLibraryButton:Sprite = this.createOverlayButton("打开玩家曲库",112,this.openPlayerLibrary);
         var refreshLibraryButton:Sprite = this.createOverlayButton("刷新曲库",88,this.refreshPlayerLibrary);
         overlay.graphics.beginFill(7,0.72);
         overlay.graphics.drawRect(0,0,950,560);
         overlay.graphics.endFill();
         panel.graphics.beginFill(202795,0.99);
         panel.graphics.lineStyle(3,65535,1);
         panel.graphics.drawRect(0,0,820,516);
         panel.graphics.endFill();
         panel.graphics.lineStyle(1,38272,1);
         panel.graphics.drawRect(12,104,796,360);
         panel.x = 65;
         panel.y = 22;
         overlay.addChild(panel);
         title.x = 88;
         title.y = 34;
         overlay.addChild(title);
         previousPlaylistButton.x = 300;
         nextPlaylistButton.x = 500;
         newPlaylistButton.x = 540;
         previousPlaylistButton.y = nextPlaylistButton.y = newPlaylistButton.y = 32;
         overlay.addChild(previousPlaylistButton);
         overlay.addChild(nextPlaylistButton);
         overlay.addChild(newPlaylistButton);
         this.playlistNameText = this.makeText("",15,65535,true);
         this.playlistNameText.x = 342;
         this.playlistNameText.y = 37;
         this.playlistNameText.autoSize = TextFieldAutoSize.NONE;
         this.playlistNameText.width = 150;
         this.playlistNameText.height = 26;
         this.playlistNameText.maxChars = 18;
         this.playlistNameText.addEventListener(KeyboardEvent.KEY_DOWN,this.playlistNameKeyDown);
         this.playlistNameText.addEventListener(FocusEvent.FOCUS_OUT,this.commitPlaylistName);
         overlay.addChild(this.playlistNameText);
         backButton.x = 650;
         closeButton.x = 796;
         backButton.y = closeButton.y = 32;
         overlay.addChild(backButton);
         overlay.addChild(closeButton);
         this.playlistOverlayRecommendedCheck = this.createRecommendedBGMCheck();
         this.playlistOverlayRecommendedCheck.x = 88;
         this.playlistOverlayRecommendedCheck.y = 72;
         overlay.addChild(this.playlistOverlayRecommendedCheck);
         this.playlistCustomBGMCheck = this.createCustomPlaylistBGMCheck();
         this.playlistCustomBGMCheck.x = 88;
         this.playlistCustomBGMCheck.y = 510;
         overlay.addChild(this.playlistCustomBGMCheck);
         this.playlistMainUseCheck = this.createPlaylistUseCheck("主界面使用","main");
         this.playlistBattleUseCheck = this.createPlaylistUseCheck("战斗使用","battle");
         this.playlistMainUseCheck.x = 330;
         this.playlistBattleUseCheck.x = 456;
         this.playlistMainUseCheck.y = this.playlistBattleUseCheck.y = 72;
         overlay.addChild(this.playlistMainUseCheck);
         overlay.addChild(this.playlistBattleUseCheck);
         sequenceButton.name = "sequence";
         randomButton.name = "random";
         singleButton.name = "single";
         sequenceButton.x = 586;
         randomButton.x = 666;
         singleButton.x = 746;
         sequenceButton.y = randomButton.y = singleButton.y = 68;
         overlay.addChild(sequenceButton);
         overlay.addChild(randomButton);
         overlay.addChild(singleButton);
         playlistViewButton.x = 88;
         libraryViewButton.x = 184;
         playerLibraryViewButton.x = 288;
         playlistViewButton.y = libraryViewButton.y = 102;
         playerLibraryViewButton.y = 102;
         overlay.addChild(playlistViewButton);
         overlay.addChild(libraryViewButton);
         overlay.addChild(playerLibraryViewButton);
         openLibraryButton.x = 384;
         refreshLibraryButton.x = 500;
         openLibraryButton.y = refreshLibraryButton.y = 102;
         overlay.addChild(openLibraryButton);
         overlay.addChild(refreshLibraryButton);
         this.playlistNowPlaying = this.makeText("双击曲目立即播放",13,10079487,false);
         this.playlistNowPlaying.x = 596;
         this.playlistNowPlaying.y = 108;
         overlay.addChild(this.playlistNowPlaying);
         previousButton.x = 88;
         previousButton.y = 477;
         overlay.addChild(previousButton);
         this.playlistPauseButton = this.createOverlayButton("暂停",62,this.togglePlaylistPause);
         this.playlistPauseButton.x = 154;
         this.playlistPauseButton.y = 477;
         overlay.addChild(this.playlistPauseButton);
         nextButton.x = 220;
         nextButton.y = 477;
         overlay.addChild(nextButton);
         this.playlistProgressBar = new Sprite();
         this.playlistProgressBar.graphics.beginFill(1052688,1);
         this.playlistProgressBar.graphics.lineStyle(1,23295,1);
         this.playlistProgressBar.graphics.drawRect(0,0,358,10);
         this.playlistProgressBar.graphics.endFill();
         this.playlistProgressBar.x = 290;
         this.playlistProgressBar.y = 486;
         this.playlistProgressBar.buttonMode = true;
         this.playlistProgressBar.addEventListener(MouseEvent.CLICK,this.seekPlaylistProgress);
         overlay.addChild(this.playlistProgressBar);
         this.playlistProgressFill = new Shape();
         this.playlistProgressBar.addChild(this.playlistProgressFill);
         this.playlistProgressText = this.makeText("00:00 / 00:00",13,16777215,false);
         this.playlistProgressText.x = 660;
         this.playlistProgressText.y = 480;
         overlay.addChild(this.playlistProgressText);
         this.playlistOverlayState = this.makeText("",14,65535,false);
         this.playlistOverlayState.x = 330;
         this.playlistOverlayState.y = 510;
         overlay.addChild(this.playlistOverlayState);
         var libraryFormatHint:TextField = this.makeText("支持 MP3 / FLAC / WAV，导入后点击刷新曲库",12,10079487,false);
         libraryFormatHint.x = 430;
         libraryFormatHint.y = 532;
         libraryFormatHint.mouseEnabled = false;
         overlay.addChild(libraryFormatHint);
         saveButton.x = 758;
         saveButton.y = 504;
         overlay.addChild(saveButton);
         this.playlistScrollThumb = new Shape();
         overlay.addChild(this.playlistScrollThumb);
         this.playlistScrollHandle = new Sprite();
         this.playlistScrollHandle.mouseEnabled = false;
         overlay.addChild(this.playlistScrollHandle);
         overlay.addEventListener(MouseEvent.MOUSE_WHEEL,this.playlistOverlayMouseWheel);
         this.playlistStatusTimer = new Timer(500);
         this.playlistStatusTimer.addEventListener(TimerEvent.TIMER,this.pollPlaylistStatus);
         this.playlistStatusTimer.start();
         overlay.visible = false;
         return overlay;
      }

      private function createOverlayButton(label:String, width:Number, handler:Function) : Sprite
      {
         var button:Sprite = new Sprite();
         var text:TextField = this.makeText(label,14,16777215,false);
         button.graphics.beginFill(1973790,1);
         button.graphics.lineStyle(1,65535,1);
         button.graphics.drawRect(0,0,width,28);
         button.graphics.endFill();
         text.x = (width - text.width) / 2;
         text.y = 4;
         button.addChild(text);
         button.buttonMode = true;
         button.mouseChildren = false;
         button.addEventListener(MouseEvent.CLICK,handler);
         return button;
      }

      private function createPlaylistUseCheck(label:String, context:String) : Sprite
      {
         var button:Sprite = new Sprite();
         var text:TextField = this.makeText(label,14,16777215,false);
         button.graphics.beginFill(1973790,1);
         button.graphics.lineStyle(2,65535,1);
         button.graphics.drawRect(0,0,22,22);
         button.graphics.endFill();
         text.x = 30;
         text.y = 0;
         button.addChild(text);
         button.name = context;
         button.buttonMode = true;
         button.mouseChildren = false;
         button.addEventListener(MouseEvent.CLICK,this.assignEditingPlaylist);
         return button;
      }

      private function getEditingPlaylist() : Object
      {
         Game.SG.ensureNamedPlaylists();
         var playlist:Object = Game.SG.getNamedPlaylist(this.editingPlaylistID);
         if(playlist == null && Game.SG.playlistDefinitions.length > 0)
         {
            playlist = Game.SG.playlistDefinitions[0];
            this.editingPlaylistID = String(playlist.id);
         }
         return playlist;
      }

      private function refreshPlaylistOverlay() : *
      {
         var rows:Array = [];
         var editing:Object = this.getEditingPlaylist();
         var selected:Array = editing == null ? [] : editing.tracks as Array;
         var track:Object = null;
         var id:String = null;
         var i:int = 0;
         var row:Sprite = null;
         var label:TextField = null;
         var upButton:Sprite = null;
         var downButton:Sprite = null;
         var selectButton:Sprite = null;
         var orderInput:TextField = null;
         while(this.playlistOverlayRows.length > 0)
         {
            row = this.playlistOverlayRows.pop();
            if(row.parent != null) row.parent.removeChild(row);
         }
         if(this.playlistView == "playlist")
         {
            for each(id in selected)
            {
               track = this.findRecommendedTrack(id);
               if(track != null) rows.push({track:track,selected:true,index:rows.length});
            }
         }
         else
         {
            for each(track in Game.SG.recommendedCatalog)
            {
               if((this.playlistView == "player" && track.context == "player") || (this.playlistView == "library" && track.context != "player"))
               {
                  rows.push({track:track,selected:selected.indexOf(String(track.id)) >= 0,index:selected.indexOf(String(track.id))});
               }
            }
         }
         this.playlistScroll = Math.max(0,Math.min(Math.max(0,rows.length - 9),this.playlistScroll));
         for(i = this.playlistScroll; i < Math.min(rows.length,this.playlistScroll + 9); i++)
         {
            track = rows[i].track;
            row = new Sprite();
            row.graphics.beginFill(rows[i].selected ? 1332077 : 592396,0.96);
            row.graphics.lineStyle(1,rows[i].selected ? 65535 : 23295,1);
            row.graphics.drawRect(0,0,760,32);
            row.graphics.endFill();
            if(rows[i].selected)
            {
               row.graphics.lineStyle(3,16777215,1);
               row.graphics.moveTo(9,16);
               row.graphics.lineTo(14,22);
               row.graphics.lineTo(23,8);
            }
            var prefix:String = this.playlistView == "playlist" ? "" : (track.context == "player" ? "[玩家曲库] " : (track.context == "developer" ? "[开发者曲库] " : (track.context == "both" ? "[双场景默认] " : (track.context == "battle" ? "[战斗默认] " : "[主界面默认] "))));
            label = this.makeText(prefix + this.shortOverlayTrackName(String(track.group) + " | " + String(track.title)),13,16777215,false);
            label.x = this.playlistView == "playlist" ? 82 : 32;
            label.y = 6;
            label.mouseEnabled = false;
            row.addChild(label);
            row.x = 82;
            row.y = 132 + (i - this.playlistScroll) * 35;
            row.name = String(track.id);
            row.buttonMode = true;
            row.doubleClickEnabled = true;
            row.addEventListener(MouseEvent.DOUBLE_CLICK,this.playOverlayTrack);
            this.playlistOverlay.addChild(row);
            this.playlistOverlayRows.push(row);
            if(this.playlistView == "playlist")
            {
               orderInput = this.createPlaylistOrderInput(String(track.id),int(rows[i].index) + 1);
               orderInput.x = 32;
               orderInput.y = 4;
               row.addChild(orderInput);
            }
            if(this.playlistView == "playlist" && this.playlistSelectedTracks.indexOf(String(track.id)) >= 0)
            {
               this.drawPlaylistSelection(row,true);
            }
            selectButton = new Sprite();
            selectButton.graphics.beginFill(0,0);
            selectButton.graphics.drawRect(0,0,30,32);
            selectButton.graphics.endFill();
            selectButton.name = String(track.id);
            selectButton.buttonMode = true;
            selectButton.addEventListener(MouseEvent.CLICK,this.toggleOverlayTrack);
            row.addChild(selectButton);
            if(rows[i].selected && this.playlistView == "playlist")
            {
               upButton = this.createArrowButton(-1,String(track.id));
               downButton = this.createArrowButton(1,String(track.id));
               upButton.x = 680;
               downButton.x = 718;
               upButton.y = downButton.y = 3;
               row.addChild(upButton);
               row.addChild(downButton);
            }
         }
         this.drawPlaylistScroll(rows.length);
         this.refreshRecommendedBGMCheck();
         this.refreshOverlayRecommendedCheck();
         this.refreshCustomPlaylistBGMCheck();
         this.refreshPlaylistUseChecks();
         if(editing != null)
         {
            var canRename:Boolean = String(editing.id).indexOf("custom_") == 0;
            this.playlistNameText.type = canRename ? TextFieldType.INPUT : TextFieldType.DYNAMIC;
            this.playlistNameText.selectable = canRename;
            this.playlistNameText.background = canRename;
            this.playlistNameText.backgroundColor = 1973790;
            this.playlistNameText.border = canRename;
            this.playlistNameText.borderColor = 65535;
            if(stage == null || stage.focus != this.playlistNameText)
            {
               this.playlistNameText.text = canRename ? String(editing.name) : this.shortPlaylistName(String(editing.name));
            }
         }
         var modeName:String = editing == null ? "sequence" : String(editing.mode);
         if(modeName == "sequence") modeName = "顺序";
         else if(modeName == "random") modeName = "随机";
         else modeName = "单曲";
         var viewName:String = this.playlistView == "playlist" ? "当前歌单" : (this.playlistView == "player" ? "玩家曲库" : "开发者曲库");
         this.playlistOverlayState.text = viewName + " · " + modeName + " · 已选 " + selected.length + " 首 · " + (this.playlistDraftDirty ? "未保存" : "已保存");
      }

      private function shortPlaylistName(value:String) : String
      {
         return value.length > 18 ? value.substr(0,17) + "..." : value;
      }

      private function playlistNameKeyDown(e:KeyboardEvent) : *
      {
         if(e.keyCode == 13 && stage != null)
         {
            stage.focus = null;
            e.stopPropagation();
         }
      }

      private function commitPlaylistName(e:FocusEvent = null) : *
      {
         var playlist:Object = this.getEditingPlaylist();
         if(playlist == null || String(playlist.id).indexOf("custom_") != 0) return;
         var value:String = this.playlistNameText.text.replace(/^\s+|\s+$/g,"");
         if(value == "")
         {
            this.playlistNameText.text = String(playlist.name);
            return;
         }
         if(value == String(playlist.name)) return;
         playlist.name = value;
         this.playlistDraftDirty = true;
         this.saveSoundSettings();
         this.refreshPlaylistOverlay();
      }

      private function shortNowPlayingName(value:String) : String
      {
         return value.length > 24 ? value.substr(0,23) + "..." : value;
      }

      private function refreshPlaylistUseChecks() : *
      {
         this.drawPlaylistUseCheck(this.playlistMainUseCheck,Game.SG.mainPlaylistID == this.editingPlaylistID);
         this.drawPlaylistUseCheck(this.playlistBattleUseCheck,Game.SG.battlePlaylistID == this.editingPlaylistID);
      }

      private function drawPlaylistUseCheck(button:Sprite, checked:Boolean) : *
      {
         if(button == null) return;
         button.graphics.clear();
         button.graphics.beginFill(1973790,1);
         button.graphics.lineStyle(2,65535,1);
         button.graphics.drawRect(0,0,22,22);
         button.graphics.endFill();
         if(checked)
         {
            button.graphics.lineStyle(3,16777215,1);
            button.graphics.moveTo(4,11);
            button.graphics.lineTo(9,17);
            button.graphics.lineTo(19,5);
         }
      }

      private function findRecommendedTrack(id:String) : Object
      {
         var track:Object = null;
         for each(track in Game.SG.recommendedCatalog)
         {
            if(String(track.id) == id) return track;
         }
         return null;
      }

      private function twoDigit(value:int) : String
      {
         return value < 10 ? "0" + value : String(value);
      }

      private function shortOverlayTrackName(value:String) : String
      {
         return value.length > 46 ? value.substr(0,45) + "..." : value;
      }

      private function createPlaylistDragHandle(id:String) : Sprite
      {
         var handle:Sprite = new Sprite();
         handle.graphics.beginFill(1973790,1);
         handle.graphics.lineStyle(1,65535,1);
         handle.graphics.drawRect(0,0,34,26);
         handle.graphics.endFill();
         handle.graphics.lineStyle(2,16777215,1);
         handle.graphics.moveTo(8,8);
         handle.graphics.lineTo(26,8);
         handle.graphics.moveTo(8,13);
         handle.graphics.lineTo(26,13);
         handle.graphics.moveTo(8,18);
         handle.graphics.lineTo(26,18);
         handle.name = id;
         handle.buttonMode = true;
         handle.addEventListener(MouseEvent.MOUSE_DOWN,this.beginPlaylistDrag);
         return handle;
      }

      private function createPlaylistOrderInput(id:String, order:int) : TextField
      {
         var field:TextField = new TextField();
         field.defaultTextFormat = new TextFormat("_sans",13,16777215,true);
         field.type = TextFieldType.INPUT;
         field.selectable = true;
         field.background = true;
         field.backgroundColor = 1973790;
         field.border = true;
         field.borderColor = 65535;
         field.width = 42;
         field.height = 24;
         field.maxChars = 3;
         field.restrict = "0-9";
         field.text = String(order);
         field.name = id;
         field.addEventListener(KeyboardEvent.KEY_DOWN,this.playlistOrderKeyDown);
         field.addEventListener(FocusEvent.FOCUS_OUT,this.commitPlaylistOrder);
         return field;
      }

      private function playlistOrderKeyDown(e:KeyboardEvent) : *
      {
         if(e.keyCode == 13 && stage != null)
         {
            stage.focus = null;
            e.stopPropagation();
         }
      }

      private function commitPlaylistOrder(e:FocusEvent) : *
      {
         var field:TextField = e.currentTarget as TextField;
         var playlist:Object = this.getEditingPlaylist();
         if(field == null || playlist == null) return;
         var tracks:Array = playlist.tracks as Array;
         var oldIndex:int = tracks.indexOf(String(field.name));
         var requested:Number = Number(field.text);
         if(oldIndex < 0 || isNaN(requested) || requested < 1)
         {
            this.refreshPlaylistOverlay();
            return;
         }
         var targetIndex:int = Math.max(0,Math.min(tracks.length - 1,int(requested) - 1));
         if(targetIndex == oldIndex)
         {
            field.text = String(oldIndex + 1);
            return;
         }
         var id:String = String(tracks[oldIndex]);
         tracks.splice(oldIndex,1);
         tracks.splice(targetIndex,0,id);
         this.applyPlaylistDraft();
      }

      private function createArrowButton(direction:int, id:String) : Sprite
      {
         var button:Sprite = new Sprite();
         button.graphics.beginFill(1973790,1);
         button.graphics.lineStyle(1,65535,1);
         button.graphics.drawRect(0,0,30,26);
         button.graphics.endFill();
         button.graphics.lineStyle(2,16777215,1);
         if(direction < 0)
         {
            button.graphics.moveTo(8,17);
            button.graphics.lineTo(15,9);
            button.graphics.lineTo(22,17);
         }
         else
         {
            button.graphics.moveTo(8,9);
            button.graphics.lineTo(15,17);
            button.graphics.lineTo(22,9);
         }
         button.name = String(direction) + "|" + id;
         button.buttonMode = true;
         button.addEventListener(MouseEvent.CLICK,direction < 0 ? this.moveOverlayTrackUp : this.moveOverlayTrackDown);
         return button;
      }

      private function playlistOverlayMouseWheel(e:MouseEvent) : *
      {
         this.playlistScroll += e.delta < 0 ? 3 : -3;
         this.refreshPlaylistOverlay();
      }

      private function drawPlaylistScroll(total:int) : *
      {
         var maxScroll:int = Math.max(0,total - 9);
         var thumbHeight:Number = maxScroll == 0 ? 309 : Math.max(42,309 * 9 / total);
         var thumbY:Number = 132 + (maxScroll == 0 ? 0 : (309 - thumbHeight) * this.playlistScroll / maxScroll);
         this.playlistVisibleTotal = total;
         this.playlistThumbHeight = thumbHeight;
         this.playlistScrollThumb.graphics.clear();
         this.playlistScrollThumb.graphics.beginFill(1052688,1);
         this.playlistScrollThumb.graphics.drawRect(852,132,8,309);
         this.playlistScrollThumb.graphics.endFill();
         this.playlistScrollHandle.graphics.clear();
         this.playlistScrollHandle.graphics.beginFill(65535,1);
         this.playlistScrollHandle.graphics.drawRect(0,0,12,thumbHeight);
         this.playlistScrollHandle.graphics.endFill();
         this.playlistScrollHandle.x = 850;
         this.playlistScrollHandle.y = thumbY;
         this.playlistScrollHandle.visible = total > 9;
      }

      private function beginPlaylistScrollDrag(e:MouseEvent) : *
      {
         if(stage == null || this.playlistVisibleTotal <= 9) return;
         e.stopPropagation();
         this.playlistScrollDragStartY = e.stageY;
         this.playlistScrollDragStartHandleY = this.playlistScrollHandle.y;
         stage.addEventListener(MouseEvent.MOUSE_MOVE,this.movePlaylistScrollDrag);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.endPlaylistScrollDrag);
      }

      private function movePlaylistScrollDrag(e:MouseEvent) : *
      {
         var maxScroll:int = Math.max(0,this.playlistVisibleTotal - 9);
         var travel:Number = 309 - this.playlistThumbHeight;
         var handleY:Number = Math.max(132,Math.min(132 + travel,this.playlistScrollDragStartHandleY + e.stageY - this.playlistScrollDragStartY));
         this.playlistScroll = travel <= 0 ? 0 : int(Math.round(maxScroll * (handleY - 132) / travel));
         this.refreshPlaylistOverlay();
         e.updateAfterEvent();
      }

      private function endPlaylistScrollDrag(e:MouseEvent) : *
      {
         if(stage != null)
         {
            stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.movePlaylistScrollDrag);
            stage.removeEventListener(MouseEvent.MOUSE_UP,this.endPlaylistScrollDrag);
         }
      }

      private function beginPlaylistDrag(e:MouseEvent) : *
      {
         if(this.playlistView != "playlist" || stage == null) return;
         e.stopPropagation();
         var id:String = String(e.currentTarget.name);
         this.playlistSelectedTracks = [id];
         this.playlistDraggedTrackID = id;
         this.refreshVisiblePlaylistSelections();
         this.playlistDragStartY = e.stageY;
         this.playlistDragCurrentY = e.stageY;
         this.playlistDragActive = false;
         stage.addEventListener(MouseEvent.MOUSE_MOVE,this.movePlaylistDrag);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.endPlaylistDrag);
      }

      private function movePlaylistDrag(e:MouseEvent) : *
      {
         this.playlistDragCurrentY = e.stageY;
         if(!this.playlistDragActive && Math.abs(this.playlistDragCurrentY - this.playlistDragStartY) >= 5)
         {
            this.playlistDragActive = true;
            this.createPlaylistDragGhost();
         }
         if(this.playlistDragActive && this.playlistDragGhost != null)
         {
            var point:Point = this.playlistOverlay.globalToLocal(new Point(e.stageX,e.stageY));
            this.playlistDragGhost.y = Math.max(132,Math.min(428,point.y - 16));
         }
         e.updateAfterEvent();
      }

      private function endPlaylistDrag(e:MouseEvent) : *
      {
         if(stage != null)
         {
            stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.movePlaylistDrag);
            stage.removeEventListener(MouseEvent.MOUSE_UP,this.endPlaylistDrag);
            stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.movePlaylistScrollDrag);
            stage.removeEventListener(MouseEvent.MOUSE_UP,this.endPlaylistScrollDrag);
         }
         if(this.playlistDragActive) this.applyPlaylistDragOrder(e.stageX,e.stageY);
         if(this.playlistDragGhost != null && this.playlistDragGhost.parent != null) this.playlistDragGhost.parent.removeChild(this.playlistDragGhost);
         this.playlistDragGhost = null;
         this.playlistDragActive = false;
      }

      private function createPlaylistDragGhost() : *
      {
         var label:TextField = null;
         this.playlistDragGhost = new Sprite();
         this.playlistDragGhost.graphics.beginFill(1332077,0.9);
         this.playlistDragGhost.graphics.lineStyle(2,16776960,1);
         this.playlistDragGhost.graphics.drawRect(0,0,760,32);
         this.playlistDragGhost.graphics.endFill();
         label = this.makeText("移动 " + this.playlistSelectedTracks.length + " 首歌曲",13,16777215,true);
         label.x = 16;
         label.y = 6;
         this.playlistDragGhost.addChild(label);
         this.playlistDragGhost.x = 82;
         this.playlistDragGhost.mouseEnabled = false;
         this.playlistDragGhost.mouseChildren = false;
         this.playlistOverlay.addChild(this.playlistDragGhost);
      }

      private function applyPlaylistDragOrder(stageX:Number, stageY:Number) : *
      {
         var playlist:Object = this.getEditingPlaylist();
         if(playlist == null) return;
         var tracks:Array = playlist.tracks as Array;
         var moving:Array = [];
         var remaining:Array = [];
         var id:String = null;
         var i:int = 0;
         var removedBefore:int = 0;
         var point:Point = this.playlistOverlay.globalToLocal(new Point(stageX,stageY));
         var dropIndex:int = this.playlistScroll + int((point.y - 132 + 17) / 35);
         dropIndex = Math.max(0,Math.min(tracks.length,dropIndex));
         for(i = 0; i < tracks.length; i++)
         {
            id = String(tracks[i]);
            if(this.playlistSelectedTracks.indexOf(id) >= 0)
            {
               moving.push(id);
               if(i < dropIndex) removedBefore++;
            }
            else
            {
               remaining.push(id);
            }
         }
         dropIndex = Math.max(0,Math.min(remaining.length,dropIndex - removedBefore));
         for(i = 0; i < moving.length; i++) remaining.splice(dropIndex + i,0,moving[i]);
         tracks.splice(0,tracks.length);
         for each(id in remaining) tracks.push(id);
         this.applyPlaylistDraft();
      }

      private function refreshVisiblePlaylistSelections() : *
      {
         var row:Sprite = null;
         for each(row in this.playlistOverlayRows)
         {
            this.drawPlaylistSelection(row,this.playlistSelectedTracks.indexOf(String(row.name)) >= 0);
         }
      }

      private function drawPlaylistSelection(row:Sprite, selected:Boolean) : *
      {
         var old:Shape = row.getChildByName("playlistSelection") as Shape;
         if(old != null) row.removeChild(old);
         if(!selected) return;
         var border:Shape = new Shape();
         border.name = "playlistSelection";
         border.graphics.lineStyle(2,16776960,1);
         border.graphics.drawRect(1,1,758,30);
         border.mouseEnabled = false;
         row.addChild(border);
      }

      private function toggleOverlayTrack(e:MouseEvent) : *
      {
         e.stopPropagation();
         var id:String = String(e.currentTarget.name);
         var playlist:Object = this.getEditingPlaylist();
         if(playlist == null) return;
         var ids:Array = playlist.tracks as Array;
         var index:int = ids.indexOf(id);
         if(index >= 0) ids.splice(index,1); else ids.push(id);
         this.applyPlaylistDraft();
      }

      private function playOverlayTrack(e:MouseEvent) : *
      {
         if(e.target != e.currentTarget) return;
         e.stopPropagation();
         var id:String = String(e.currentTarget.name);
         var track:Object = this.findRecommendedTrack(id);
         Game.SG.playRecommendedTrack(id);
         if(track != null) this.playlistNowPlaying.text = "正在播放：" + this.shortNowPlayingName(String(track.title));
         this.pollPlaylistStatus();
      }

      private function pollPlaylistStatus(e:TimerEvent = null) : *
      {
         if(this.playlistOverlay == null || !this.playlistOverlay.visible) return;
         Game.SG.requestExternalBGMStatus(this.playlistStatusComplete);
      }

      private function playlistStatusComplete(e:Event) : *
      {
         var data:Object = null;
         var position:Number = 0;
         try
         {
            data = JSON.parse(URLLoader(e.currentTarget).data);
            position = Math.max(0,Number(data.position));
            this.playlistDuration = Math.max(0,Number(data.duration));
            this.drawPlaylistProgress(position,this.playlistDuration);
            this.setPlaylistPauseLabel(Boolean(data.paused));
            if(String(data.label) != "")
            {
               var track:Object = this.findRecommendedTrack(String(data.label));
               if(track != null) this.playlistNowPlaying.text = "正在播放：" + this.shortNowPlayingName(String(track.title));
            }
         }
         catch(error:Error)
         {
         }
      }

      private function drawPlaylistProgress(position:Number, duration:Number) : *
      {
         var ratio:Number = duration > 0 ? Math.max(0,Math.min(1,position / duration)) : 0;
         this.playlistProgressFill.graphics.clear();
         this.playlistProgressFill.graphics.beginFill(65535,1);
         this.playlistProgressFill.graphics.drawRect(0,0,358 * ratio,10);
         this.playlistProgressFill.graphics.endFill();
         this.playlistProgressText.text = this.formatPlaylistTime(position) + " / " + this.formatPlaylistTime(duration);
      }

      private function formatPlaylistTime(seconds:Number) : String
      {
         var total:int = Math.max(0,int(seconds));
         var minutes:int = int(total / 60);
         var remain:int = total % 60;
         return (minutes < 10 ? "0" : "") + minutes + ":" + (remain < 10 ? "0" : "") + remain;
      }

      private function seekPlaylistProgress(e:MouseEvent) : *
      {
         if(this.playlistDuration <= 0) return;
         Game.SG.seekExternalBGM(Math.max(0,Math.min(1,e.localX / 358)) * this.playlistDuration);
         this.pollPlaylistStatus();
      }

      private function togglePlaylistPause(e:MouseEvent = null) : *
      {
         var label:TextField = this.playlistPauseButton.numChildren > 0 ? this.playlistPauseButton.getChildAt(0) as TextField : null;
         if(label != null && label.text == "继续") Game.SG.resumeExternalBGM();
         else Game.SG.pauseExternalBGM();
      }

      private function setPlaylistPauseLabel(paused:Boolean) : *
      {
         if(this.playlistPauseButton == null) return;
         while(this.playlistPauseButton.numChildren > 0) this.playlistPauseButton.removeChildAt(0);
         var label:TextField = this.makeText(paused ? "继续" : "暂停",14,16777215,false);
         label.x = (62 - label.width) / 2;
         label.y = 4;
         this.playlistPauseButton.addChild(label);
      }

      private function playPreviousBGM(e:MouseEvent = null) : *
      {
         Game.SG.previousExternalBGM();
      }

      private function playNextBGM(e:MouseEvent = null) : *
      {
         Game.SG.nextExternalBGM();
      }

      private function moveOverlayTrackUp(e:MouseEvent) : *
      {
         e.stopPropagation();
         this.moveOverlayTrack(String(e.currentTarget.name).split("|")[1],-1);
      }

      private function moveOverlayTrackDown(e:MouseEvent) : *
      {
         e.stopPropagation();
         this.moveOverlayTrack(String(e.currentTarget.name).split("|")[1],1);
      }

      private function moveOverlayTrack(id:String, direction:int) : *
      {
         var playlist:Object = this.getEditingPlaylist();
         if(playlist == null) return;
         var ids:Array = playlist.tracks as Array;
         var index:int = ids.indexOf(id);
         var target:int = index + direction;
         if(index < 0 || target < 0 || target >= ids.length) return;
         ids.splice(index,1);
         ids.splice(target,0,id);
         this.applyPlaylistDraft();
      }

      private function showOverlayMainPlaylist(e:MouseEvent = null) : *
      {
         Game.SG.assignNamedPlaylist(this.editingPlaylistID,"main");
         this.playlistDraftDirty = true;
         this.refreshPlaylistOverlay();
      }

      private function showOverlayBattlePlaylist(e:MouseEvent = null) : *
      {
         Game.SG.assignNamedPlaylist(this.editingPlaylistID,"battle");
         this.playlistDraftDirty = true;
         this.refreshPlaylistOverlay();
      }

      private function showPlaylistOnly(e:MouseEvent = null) : *
      {
         this.playlistView = "playlist";
         this.playlistScroll = 0;
         this.refreshPlaylistOverlay();
      }

      private function showPlaylistLibrary(e:MouseEvent = null) : *
      {
         this.playlistView = "library";
         this.playlistScroll = 0;
         this.refreshPlaylistOverlay();
      }

      private function showPlayerLibrary(e:MouseEvent = null) : *
      {
         this.playlistView = "player";
         this.playlistScroll = 0;
         this.refreshPlaylistOverlay();
      }

      private function assignEditingPlaylist(e:MouseEvent) : *
      {
         Game.SG.assignNamedPlaylist(this.editingPlaylistID,String(e.currentTarget.name));
         this.playlistDraftDirty = true;
         this.refreshPlaylistOverlay();
      }

      private function selectPreviousPlaylist(e:MouseEvent = null) : *
      {
         this.selectPlaylistOffset(-1);
      }

      private function selectNextPlaylist(e:MouseEvent = null) : *
      {
         this.selectPlaylistOffset(1);
      }

      private function selectPlaylistOffset(offset:int) : *
      {
         var definitions:Array = Game.SG.playlistDefinitions;
         var i:int = 0;
         if(definitions.length == 0) return;
         for(i = 0; i < definitions.length; i++)
         {
            if(String(definitions[i].id) == this.editingPlaylistID) break;
         }
         i = (i + offset + definitions.length) % definitions.length;
         this.editingPlaylistID = String(definitions[i].id);
         this.playlistSelectedTracks = [];
         this.playlistScroll = 0;
         this.refreshPlaylistOverlay();
      }

      private function createNewPlaylist(e:MouseEvent = null) : *
      {
         var playlist:Object = Game.SG.createNamedPlaylist();
         this.editingPlaylistID = String(playlist.id);
         this.playlistSelectedTracks = [];
         this.playlistView = "library";
         this.playlistScroll = 0;
         this.playlistDraftDirty = true;
         this.refreshPlaylistOverlay();
      }

      private function openPlayerLibrary(e:MouseEvent = null) : *
      {
         Game.SG.openPlayerBGMLibrary();
      }

      private function refreshPlayerLibrary(e:MouseEvent = null) : *
      {
         Game.SG.refreshExternalBGMCatalog(this.refreshPlaylistOverlay);
      }

      private function setOverlayPlaylistMode(e:MouseEvent) : *
      {
         var playlist:Object = this.getEditingPlaylist();
         if(playlist == null) return;
         playlist.mode = String(e.currentTarget.name);
         this.applyPlaylistDraft();
      }

      private function applyPlaylistDraft() : *
      {
         var playlist:Object = this.getEditingPlaylist();
         if(playlist != null) Game.SG.updateNamedPlaylist(String(playlist.id),playlist.tracks as Array,String(playlist.mode));
         this.playlistDraftDirty = true;
         this.refreshPlaylistOverlay();
      }

      private function savePlaylistDraft(e:MouseEvent = null) : *
      {
         this.applyPlaylistDraft();
         this.playlistDraftDirty = false;
         this.saveSoundSettings();
         this.refreshPlaylistOverlay();
      }

      private function backToSettings(e:MouseEvent = null) : *
      {
         this.playlistOverlay.visible = false;
         this.settingsPanel.visible = true;
         Game.gameSprite.addChild(this.settingsPanel);
      }

      private function refreshOverlayRecommendedCheck() : *
      {
         if(this.playlistOverlayRecommendedCheck == null) return;
         this.playlistOverlayRecommendedCheck.graphics.clear();
         this.playlistOverlayRecommendedCheck.graphics.beginFill(1973790,1);
         this.playlistOverlayRecommendedCheck.graphics.lineStyle(2,65535,1);
         this.playlistOverlayRecommendedCheck.graphics.drawRect(0,0,22,22);
         this.playlistOverlayRecommendedCheck.graphics.endFill();
         if(Game.SG.recommendedBGMEnabled)
         {
            this.playlistOverlayRecommendedCheck.graphics.lineStyle(3,16777215,1);
            this.playlistOverlayRecommendedCheck.graphics.moveTo(4,11);
            this.playlistOverlayRecommendedCheck.graphics.lineTo(9,17);
            this.playlistOverlayRecommendedCheck.graphics.lineTo(19,5);
         }
      }

      private function createCustomPlaylistBGMCheck() : Sprite
      {
         var button:Sprite = new Sprite();
         var label:TextField = this.makeText("\u64ad\u653e\u73a9\u5bb6\u81ea\u5b9a\u4e49\u6b4c\u5355 BGM",15,16777215,false);
         button.graphics.beginFill(1973790,1);
         button.graphics.lineStyle(2,65535,1);
         button.graphics.drawRect(0,0,22,22);
         button.graphics.endFill();
         label.x = 34;
         label.y = -1;
         button.addChild(label);
         button.buttonMode = true;
         button.mouseChildren = false;
         button.addEventListener(MouseEvent.CLICK,this.toggleCustomPlaylistBGM);
         return button;
      }

      private function toggleCustomPlaylistBGM(e:MouseEvent = null) : *
      {
         Game.SG.setCustomPlaylistBGMEnabled(!Game.SG.customPlaylistBGMEnabled);
         this.refreshBGMCheck();
         this.refreshRecommendedBGMCheck();
         this.refreshOverlayRecommendedCheck();
         this.refreshCustomPlaylistBGMCheck();
         this.saveSoundSettings();
      }

      private function refreshCustomPlaylistBGMCheck() : *
      {
         if(this.playlistCustomBGMCheck == null) return;
         this.playlistCustomBGMCheck.graphics.clear();
         this.playlistCustomBGMCheck.graphics.beginFill(1973790,1);
         this.playlistCustomBGMCheck.graphics.lineStyle(2,65535,1);
         this.playlistCustomBGMCheck.graphics.drawRect(0,0,22,22);
         this.playlistCustomBGMCheck.graphics.endFill();
         if(Game.SG.customPlaylistBGMEnabled)
         {
            this.playlistCustomBGMCheck.graphics.lineStyle(3,16777215,1);
            this.playlistCustomBGMCheck.graphics.moveTo(4,11);
            this.playlistCustomBGMCheck.graphics.lineTo(9,17);
            this.playlistCustomBGMCheck.graphics.lineTo(19,5);
         }
      }

      private function createPlaylistPage() : Sprite
      {
         var page:Sprite = new Sprite();
         var mainButton:Sprite = this.createTextButton("主界面",this.showMainPlaylist);
         var battleButton:Sprite = this.createTextButton("战斗",this.showBattlePlaylist);
         var sequenceButton:Sprite = this.createTextButton("顺序",this.setPlaylistMode);
         var randomButton:Sprite = this.createTextButton("随机",this.setPlaylistMode);
         var singleButton:Sprite = this.createTextButton("单曲",this.setPlaylistMode);
         var previousButton:Sprite = this.createTextButton("上一页",this.previousTrackPage);
         var nextButton:Sprite = this.createTextButton("下一页",this.nextTrackPage);
         page.y = 88;
         this.recommendedBGMCheck = this.createRecommendedBGMCheck();
         this.recommendedBGMCheck.x = 10;
         page.addChild(this.recommendedBGMCheck);
         mainButton.x = 10;
         mainButton.y = 38;
         battleButton.x = 158;
         battleButton.y = 38;
         page.addChild(mainButton);
         page.addChild(battleButton);
         sequenceButton.name = "sequence";
         randomButton.name = "random";
         singleButton.name = "single";
         sequenceButton.x = 0;
         randomButton.x = 103;
         singleButton.x = 206;
         sequenceButton.y = randomButton.y = singleButton.y = 76;
         page.addChild(sequenceButton);
         page.addChild(randomButton);
         page.addChild(singleButton);
         previousButton.x = 10;
         previousButton.y = 333;
         nextButton.x = 188;
         nextButton.y = 333;
         page.addChild(previousButton);
         page.addChild(nextButton);
         this.playlistPageText = this.makeText("0/0",12,65535,false);
         this.playlistPageText.x = 137;
         this.playlistPageText.y = 340;
         page.addChild(this.playlistPageText);
         page.visible = false;
         return page;
      }

      private function createRecommendedBGMCheck() : Sprite
      {
         var button:Sprite = new Sprite();
         var label:TextField = this.makeText("播放开发者推荐 BGM",15,16777215,false);
         button.graphics.beginFill(1973790,1);
         button.graphics.lineStyle(2,65535,1);
         button.graphics.drawRect(0,0,22,22);
         button.graphics.endFill();
         label.x = 34;
         label.y = -1;
         button.addChild(label);
         button.buttonMode = true;
         button.mouseChildren = false;
         button.addEventListener(MouseEvent.CLICK,this.toggleRecommendedBGM);
         return button;
      }

      private function toggleRecommendedBGM(e:MouseEvent = null) : *
      {
         Game.SG.setRecommendedBGMEnabled(!Game.SG.recommendedBGMEnabled);
         this.refreshBGMCheck();
         this.refreshRecommendedBGMCheck();
         this.refreshOverlayRecommendedCheck();
         this.refreshCustomPlaylistBGMCheck();
         this.saveSoundSettings();
      }

      private function refreshRecommendedBGMCheck() : *
      {
         if(this.recommendedBGMCheck == null) return;
         this.recommendedBGMCheck.graphics.clear();
         this.recommendedBGMCheck.graphics.beginFill(1973790,1);
         this.recommendedBGMCheck.graphics.lineStyle(2,65535,1);
         this.recommendedBGMCheck.graphics.drawRect(0,0,22,22);
         this.recommendedBGMCheck.graphics.endFill();
         if(Game.SG.recommendedBGMEnabled)
         {
            this.recommendedBGMCheck.graphics.lineStyle(3,16777215,1);
            this.recommendedBGMCheck.graphics.moveTo(4,11);
            this.recommendedBGMCheck.graphics.lineTo(9,17);
            this.recommendedBGMCheck.graphics.lineTo(19,5);
         }
      }

      private function showMainPlaylist(e:MouseEvent = null) : *
      {
         this.playlistContext = "main";
         this.playlistTrackPage = 0;
         this.refreshPlaylistPage();
      }

      private function showBattlePlaylist(e:MouseEvent = null) : *
      {
         this.playlistContext = "battle";
         this.playlistTrackPage = 0;
         this.refreshPlaylistPage();
      }

      private function setPlaylistMode(e:MouseEvent) : *
      {
         var ids:Array = this.playlistContext == "battle" ? Game.SG.battlePlaylist : Game.SG.mainPlaylist;
         Game.SG.setPlaylist(this.playlistContext,ids,String(e.currentTarget.name));
         this.saveSoundSettings();
         this.refreshPlaylistPage();
      }

      private function refreshPlaylistPage() : *
      {
         var tracks:Array = [];
         var selected:Array = this.playlistContext == "battle" ? Game.SG.battlePlaylist : Game.SG.mainPlaylist;
         var track:Object = null;
         var button:Sprite = null;
         var label:TextField = null;
         var start:int = 0;
         var totalPages:int = 0;
         var i:int = 0;
         this.refreshRecommendedBGMCheck();
         while(this.playlistTrackButtons.length > 0)
         {
            button = this.playlistTrackButtons.pop();
            if(button.parent != null) button.parent.removeChild(button);
         }
         for each(track in Game.SG.recommendedCatalog)
         {
            if(track.context == this.playlistContext) tracks.push(track);
         }
         totalPages = Math.max(1,Math.ceil(tracks.length / 6));
         this.playlistTrackPage = Math.max(0,Math.min(totalPages - 1,this.playlistTrackPage));
         start = this.playlistTrackPage * 6;
         for(i = start; i < Math.min(start + 6,tracks.length); i++)
         {
            track = tracks[i];
            button = new Sprite();
            button.graphics.beginFill(1973790,0.9);
            button.graphics.lineStyle(1,65535,1);
            button.graphics.drawRect(0,0,284,31);
            button.graphics.endFill();
            if(selected.indexOf(String(track.id)) >= 0)
            {
               button.graphics.lineStyle(3,16777215,1);
               button.graphics.moveTo(7,15);
               button.graphics.lineTo(12,21);
               button.graphics.lineTo(21,8);
            }
            label = this.makeText(this.shortTrackName(String(track.group) + " | " + String(track.title)),12,16777215,false);
            label.x = 28;
            label.y = 6;
            button.addChild(label);
            button.x = 10;
            button.y = 112 + (i - start) * 35;
            button.name = String(track.id);
            button.buttonMode = true;
            button.mouseChildren = false;
            button.addEventListener(MouseEvent.CLICK,this.togglePlaylistTrack);
            this.playlistPage.addChild(button);
            this.playlistTrackButtons.push(button);
         }
         var modeName:String = this.playlistContext == "battle" ? Game.SG.battlePlaylistMode : Game.SG.mainPlaylistMode;
         var contextName:String = this.playlistContext == "battle" ? "战斗" : "主界面";
         if(modeName == "sequence") modeName = "顺序";
         else if(modeName == "random") modeName = "随机";
         else modeName = "单曲";
         this.playlistPageText.text = contextName + "·" + modeName + " " + String(this.playlistTrackPage + 1) + "/" + String(totalPages);
      }

      private function shortTrackName(value:String) : String
      {
         return value.length > 31 ? value.substr(0,30) + "..." : value;
      }

      private function togglePlaylistTrack(e:MouseEvent) : *
      {
         var id:String = String(e.currentTarget.name);
         var ids:Array = (this.playlistContext == "battle" ? Game.SG.battlePlaylist : Game.SG.mainPlaylist).concat();
         var index:int = ids.indexOf(id);
         var mode:String = this.playlistContext == "battle" ? Game.SG.battlePlaylistMode : Game.SG.mainPlaylistMode;
         if(index >= 0) ids.splice(index,1); else ids.push(id);
         Game.SG.setPlaylist(this.playlistContext,ids,mode);
         this.saveSoundSettings();
         this.refreshPlaylistPage();
      }

      private function previousTrackPage(e:MouseEvent = null) : *
      {
         --this.playlistTrackPage;
         this.refreshPlaylistPage();
      }

      private function nextTrackPage(e:MouseEvent = null) : *
      {
         ++this.playlistTrackPage;
         this.refreshPlaylistPage();
      }

      private function beginKeyCapture(e:MouseEvent) : *
      {
         this.capturingKey = int(e.currentTarget.name);
         this.keyButtons[this.capturingKey].alpha = 0.5;
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.captureKey);
      }

      private function captureKey(e:KeyboardEvent) : *
      {
         var action:String = null;
         var oldCode:int = 0;
         var i:int = 0;
         var code:int = int(e.keyCode);
         if(this.capturingKey < 0)
         {
            return;
         }
         if(!this.isSupportedBinding(code))
         {
            return;
         }
         action = this.keyActions[this.capturingKey];
         oldCode = Game.keysGroup.getBinding(action);
         for(i = 0; i < this.keyActions.length; i++)
         {
            var sameJumpPair:Boolean = (action == "jump" && this.keyActions[i] == "jumpSkill") || (action == "jumpSkill" && this.keyActions[i] == "jump");
            if(i != this.capturingKey && !sameJumpPair && Game.keysGroup.getBinding(this.keyActions[i]) == code)
            {
               Game.keysGroup.setBinding(this.keyActions[i],oldCode);
            }
         }
         Game.keysGroup.setBinding(action,code);
         stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.captureKey);
         this.keyButtons[this.capturingKey].alpha = 1;
         this.capturingKey = -1;
         this.fleshKeyButtons();
         this.refreshKeyHUD();
         this.saveKeySettings();
      }

      private function fleshKeyButtons() : *
      {
         var i:int = 0;
         var text:TextField = null;
         for(i = 0; i < this.keyButtons.length; i++)
         {
            while(this.keyButtons[i].numChildren > 0) this.keyButtons[i].removeChildAt(0);
            text = this.makeText(this.keyName(Game.keysGroup.getBinding(this.keyActions[i])),12,16777215,false);
            text.x = (68 - text.width) / 2;
            text.y = 4;
            this.keyButtons[i].addChild(text);
         }
      }

      private function keyName(code:int) : String
      {
         if(code == Keyboard.SPACE) return "SPACE";
         if(code == Keyboard.ESCAPE) return "ESC";
         if(code == Keyboard.LEFT) return "LEFT";
         if(code == Keyboard.RIGHT) return "RIGHT";
         if(code == Keyboard.UP) return "UP";
         if(code == Keyboard.DOWN) return "DOWN";
         if(code >= 96 && code <= 105) return "NUM " + String(code - 96);
         if(code >= 112 && code <= 123) return "F" + String(code - 111);
         if(code >= 65 && code <= 90) return String.fromCharCode(code);
         if(code >= 48 && code <= 57) return String.fromCharCode(code);
         if(code == 186) return ";";
         if(code == 187) return "=";
         if(code == 188) return ",";
         if(code == 189) return "-";
         if(code == 190) return ".";
         if(code == 191) return "/";
         if(code == 192) return "`";
         if(code == 219) return "[";
         if(code == 220) return "\\";
         if(code == 221) return "]";
         if(code == 222) return "'";
         return "KEY " + String(code);
      }

      private function isSupportedBinding(code:int) : Boolean
      {
         if(code == Keyboard.SPACE || code == Keyboard.ESCAPE) return true;
         if(code >= Keyboard.LEFT && code <= Keyboard.DOWN) return true;
         if(code >= 48 && code <= 57) return true;
         if(code >= 65 && code <= 90) return true;
         if(code >= 96 && code <= 123) return true;
         if(code >= 186 && code <= 192) return true;
         if(code >= 219 && code <= 222) return true;
         return false;
      }

      private function createHexPattern() : Shape
      {
         var pattern:Shape = new Shape();
         var row:int = 0;
         var column:int = 0;
         var radius:Number = 18;
         var centerX:Number = 0;
         var centerY:Number = 0;
         var angle:Number = 0;
         var pointX:Number = 0;
         var pointY:Number = 0;
         pattern.graphics.lineStyle(1,873464,0.42);
         for(row = 0; row < 17; row++)
         {
            centerY = 58 + row * 27;
            for(column = 0; column < 10; column++)
            {
               centerX = 12 + column * 32 + (row % 2) * 16;
               for(var side:int = 0; side <= 6; side++)
               {
                  angle = Math.PI / 3 * side;
                  pointX = centerX + Math.cos(angle) * radius;
                  pointY = centerY + Math.sin(angle) * radius;
                  if(side == 0)
                  {
                     pattern.graphics.moveTo(pointX,pointY);
                  }
                  else
                  {
                     pattern.graphics.lineTo(pointX,pointY);
                  }
               }
            }
         }
         return pattern;
      }

      private function createSlider(index:int, label:String, yPos:Number) : Sprite
      {
         var row:Sprite = new Sprite();
         var labelText:TextField = this.makeText(label,16,16777215,false);
         var valueText:TextField = this.makeText("100%",14,65535,false);
         var bar:Sprite = new Sprite();
         var knob:Sprite = new Sprite();
         row.y = yPos;
         labelText.x = 22;
         row.addChild(labelText);
         valueText.x = 239;
         row.addChild(valueText);
         bar.graphics.beginFill(1052688,1);
         bar.graphics.lineStyle(1,23295,1);
         bar.graphics.drawRect(0,-4,202,8);
         bar.graphics.endFill();
         bar.x = 24;
         bar.y = 38;
         bar.name = String(index);
         bar.buttonMode = true;
         bar.addEventListener(MouseEvent.MOUSE_DOWN,this.startSliderDrag);
         row.addChild(bar);
         knob.graphics.beginFill(65535,1);
         knob.graphics.lineStyle(2,16777215,1);
         knob.graphics.drawCircle(0,0,8);
         knob.graphics.endFill();
         knob.x = 202;
         knob.mouseEnabled = false;
         bar.addChild(knob);
         this.sliderBars[index] = bar;
         this.sliderKnobs[index] = knob;
         this.sliderValues[index] = valueText;
         return row;
      }

      private function createTextButton(label:String, handler:Function) : Sprite
      {
         var button:Sprite = new Sprite();
         var text:TextField = this.makeText(label,15,16777215,false);
         button.graphics.beginFill(1973790,1);
         button.graphics.lineStyle(1,65535,1);
         button.graphics.drawRect(0,0,102,30);
         button.graphics.endFill();
         text.x = (102 - text.width) / 2;
         text.y = 4;
         button.addChild(text);
         button.buttonMode = true;
         button.mouseChildren = false;
         button.addEventListener(MouseEvent.CLICK,handler);
         return button;
      }

      private function createBGMCheck() : Sprite
      {
         var button:Sprite = new Sprite();
         var label:TextField = this.makeText("\u64ad\u653e\u9ed8\u8ba4 BGM",16,16777215,false);
         button.graphics.beginFill(1973790,1);
         button.graphics.lineStyle(2,65535,1);
         button.graphics.drawRect(0,0,22,22);
         button.graphics.endFill();
         label.x = 34;
         label.y = -1;
         button.addChild(label);
         button.buttonMode = true;
         button.mouseChildren = false;
         button.addEventListener(MouseEvent.CLICK,this.toggleBGM);
         return button;
      }

      private function toggleBGM(e:MouseEvent = null) : *
      {
         Game.SG.setBGMEnabled(!Game.SG.bgmEnabled);
         this.refreshBGMCheck();
         this.refreshRecommendedBGMCheck();
         this.refreshOverlayRecommendedCheck();
         this.refreshCustomPlaylistBGMCheck();
         this.saveSoundSettings();
      }

      private function refreshBGMCheck() : *
      {
         if(this.bgmCheck == null)
         {
            return;
         }
         this.bgmCheck.graphics.clear();
         this.bgmCheck.graphics.beginFill(1973790,1);
         this.bgmCheck.graphics.lineStyle(2,65535,1);
         this.bgmCheck.graphics.drawRect(0,0,22,22);
         this.bgmCheck.graphics.endFill();
         if(Game.SG.bgmEnabled)
         {
            this.bgmCheck.graphics.lineStyle(3,16777215,1);
            this.bgmCheck.graphics.moveTo(4,11);
            this.bgmCheck.graphics.lineTo(9,17);
            this.bgmCheck.graphics.lineTo(19,5);
         }
      }

      private function createBackupPromptCheck() : Sprite
      {
         var button:Sprite = new Sprite();
         var label:TextField = this.makeText("进入地图前提示备份",16,16777215,false);
         button.graphics.beginFill(1973790,1);
         button.graphics.lineStyle(2,65535,1);
         button.graphics.drawRect(0,0,22,22);
         button.graphics.endFill();
         label.x = 34;
         label.y = -1;
         button.addChild(label);
         button.buttonMode = true;
         button.mouseChildren = false;
         button.addEventListener(MouseEvent.CLICK,this.toggleBackupPrompt);
         return button;
      }

      private function toggleBackupPrompt(e:MouseEvent = null) : *
      {
         this.backupPromptEnabled = !this.backupPromptEnabled;
         this.refreshBackupPromptCheck();
         this.saveSoundSettings();
      }

      private function refreshBackupPromptCheck() : *
      {
         if(this.backupPromptCheck == null)
         {
            return;
         }
         this.backupPromptCheck.graphics.clear();
         this.backupPromptCheck.graphics.beginFill(1973790,1);
         this.backupPromptCheck.graphics.lineStyle(2,65535,1);
         this.backupPromptCheck.graphics.drawRect(0,0,22,22);
         this.backupPromptCheck.graphics.endFill();
         if(this.backupPromptEnabled)
         {
            this.backupPromptCheck.graphics.lineStyle(3,16777215,1);
            this.backupPromptCheck.graphics.moveTo(4,11);
            this.backupPromptCheck.graphics.lineTo(9,17);
            this.backupPromptCheck.graphics.lineTo(19,5);
         }
      }

      public function getBackupPromptEnabled() : Boolean
      {
         return this.backupPromptEnabled;
      }

      private function makeText(value:String, size:int, color:uint, bold:Boolean) : TextField
      {
         var field:TextField = new TextField();
         field.defaultTextFormat = new TextFormat("_sans",size,color,bold);
         field.autoSize = TextFieldAutoSize.LEFT;
         field.selectable = false;
         field.text = value;
         return field;
      }

      private function startSliderDrag(e:MouseEvent) : *
      {
         this.draggingSlider = int(e.currentTarget.name);
         stage.addEventListener(MouseEvent.MOUSE_MOVE,this.moveSlider);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.stopSliderDrag);
         this.updateSliderFromStage(e.stageX,e.stageY);
      }

      private function moveSlider(e:MouseEvent) : *
      {
         this.updateSliderFromStage(e.stageX,e.stageY);
         e.updateAfterEvent();
      }

      private function stopSliderDrag(e:MouseEvent) : *
      {
         stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.moveSlider);
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.stopSliderDrag);
         this.draggingSlider = -1;
         this.saveSoundSettings();
      }

      private function updateSliderFromStage(stageX:Number, stageY:Number) : *
      {
         var bar:Sprite = this.sliderBars[this.draggingSlider];
         var point:Point = bar.globalToLocal(new Point(stageX,stageY));
         var value:Number = Math.max(0,Math.min(1,point.x / 202));
         this.setSliderValue(this.draggingSlider,value);
         this.applySoundSettings();
      }

      private function setSliderValue(index:int, value:Number) : *
      {
         value = Math.max(0,Math.min(1,value));
         this.sliderKnobs[index].x = value * 202;
         this.sliderValues[index].text = int(value * 100 + 0.5) + "%";
      }

      private function loadSoundSettings() : *
      {
         var masterValue:Number = Game.SG.masterVolume;
         var storedMaster:Number = -1;
         try
         {
            this.soundSettings = SharedObject.getLocal("metalWarTaleSettings");
            if(this.soundSettings.data.audioSettingsVersion === 2 && this.soundSettings.data.effectsVolume !== undefined)
            {
               storedMaster = Number(this.soundSettings.data.effectsVolume);
            }
            else if(this.soundSettings.data.masterVolume !== undefined)
            {
               storedMaster = Number(this.soundSettings.data.masterVolume);
            }
            if(storedMaster >= 0)
            {
               masterValue = int(this.soundSettings.data.audioSettingsVersion) < 4 ? storedMaster / Game.SG.baseOutputGain : storedMaster;
            }
            if(this.soundSettings.data.backupPromptEnabled !== undefined)
            {
               this.backupPromptEnabled = Boolean(this.soundSettings.data.backupPromptEnabled);
            }
         }
         catch(error:Error)
         {
            this.soundSettings = null;
         }
         this.setSliderValue(0,masterValue);
         this.setSliderValue(1,Game.SG.musicVolume);
         this.refreshBGMCheck();
         this.refreshRecommendedBGMCheck();
         this.refreshCustomPlaylistBGMCheck();
         this.refreshBackupPromptCheck();
         this.applySoundSettings();
         this.saveSoundSettings();
      }

      private function applySoundSettings() : *
      {
         Game.SG.setMasterVolume(this.sliderKnobs[0].x / 202);
         Game.SG.setMusicVolume(this.sliderKnobs[1].x / 202);
      }

      private function saveSoundSettings() : *
      {
         if(this.soundSettings == null)
         {
            return;
         }
         try
         {
            this.soundSettings.data.audioSettingsVersion = 8;
            this.soundSettings.data.masterVolume = this.sliderKnobs[0].x / 202;
            this.soundSettings.data.musicVolume = this.sliderKnobs[1].x / 202;
            this.soundSettings.data.bgmEnabled = Game.SG.bgmEnabled;
            this.soundSettings.data.recommendedBGMEnabled = Game.SG.recommendedBGMEnabled;
            this.soundSettings.data.customPlaylistBGMEnabled = Game.SG.customPlaylistBGMEnabled;
            this.soundSettings.data.playlistConfigured = Game.SG.getPlaylistConfigured();
            this.soundSettings.data.mainPlaylist = Game.SG.mainPlaylist.concat();
            this.soundSettings.data.battlePlaylist = Game.SG.battlePlaylist.concat();
            this.soundSettings.data.mainPlaylistMode = Game.SG.mainPlaylistMode;
            this.soundSettings.data.battlePlaylistMode = Game.SG.battlePlaylistMode;
            this.soundSettings.data.playlistDefinitions = Game.SG.playlistDefinitions.concat();
            this.soundSettings.data.mainPlaylistID = Game.SG.mainPlaylistID;
            this.soundSettings.data.battlePlaylistID = Game.SG.battlePlaylistID;
            this.soundSettings.data.backupPromptEnabled = this.backupPromptEnabled;
            this.soundSettings.flush();
         }
         catch(error:Error)
         {
         }
      }

      private function loadKeySettings() : *
      {
         var saved:Object = null;
         var i:int = 0;
         var savedCode:int = 0;
         Game.keysGroup.resetBindings();
         if(this.soundSettings != null && this.soundSettings.data.keyBindings != null)
         {
            saved = this.soundSettings.data.keyBindings;
            for(i = 0; i < this.keyActions.length; i++)
            {
               if(saved[this.keyActions[i]] !== undefined)
               {
                  savedCode = int(saved[this.keyActions[i]]);
                  if(this.isSupportedBinding(savedCode))
                  {
                     Game.keysGroup.setBinding(this.keyActions[i],savedCode);
                  }
               }
            }
         }
         this.fleshKeyButtons();
         this.refreshKeyHUD();
         this.saveKeySettings();
      }

      private function saveKeySettings() : *
      {
         var saved:Object = {};
         var i:int = 0;
         if(this.soundSettings == null) return;
         for(i = 0; i < this.keyActions.length; i++)
         {
            saved[this.keyActions[i]] = Game.keysGroup.getBinding(this.keyActions[i]);
         }
         this.soundSettings.data.keyBindings = saved;
         try
         {
            this.soundSettings.flush();
         }
         catch(error:Error)
         {
         }
      }

      private function resetCurrentSettings(e:MouseEvent = null) : *
      {
         if(this.keyPage.visible)
         {
            Game.keysGroup.resetBindings();
            this.fleshKeyButtons();
            this.refreshKeyHUD();
            this.saveKeySettings();
         }
         else if(this.playlistPage.visible)
         {
            this.resetPlaylistSettings();
         }
         else
         {
            this.resetSoundSettings();
         }
      }

      private function refreshKeyHUD() : *
      {
         if(Game.uiGroup != null && Game.uiGroup.gamingUI != null)
         {
            Game.uiGroup.gamingUI.fleshKeyLabels();
         }
      }

      private function resetSoundSettings(e:MouseEvent = null) : *
      {
         this.setSliderValue(0,0.7);
         this.setSliderValue(1,0.7);
         Game.SG.setBGMEnabled(false);
         Game.SG.setRecommendedBGMEnabled(true);
         this.backupPromptEnabled = true;
         this.refreshBGMCheck();
         this.refreshRecommendedBGMCheck();
         this.refreshCustomPlaylistBGMCheck();
         this.refreshBackupPromptCheck();
         this.applySoundSettings();
         this.saveSoundSettings();
      }

      private function resetPlaylistSettings() : *
      {
         var mainIDs:Array = [];
         var battleIDs:Array = [];
         var track:Object = null;
         var firstMainID:String = "";
         for each(track in Game.SG.recommendedCatalog)
         {
            if(track.context == "battle") battleIDs.push(String(track.id));
            else if(track.context == "main")
            {
               mainIDs.push(String(track.id));
               if(String(track.title) == "Halo,陣内一真 - 117") firstMainID = String(track.id);
            }
         }
         if(firstMainID != "")
         {
            mainIDs.splice(mainIDs.indexOf(firstMainID),1);
            mainIDs.unshift(firstMainID);
         }
         Game.SG.setPlaylist("main",mainIDs,"sequence");
         Game.SG.setPlaylist("battle",battleIDs,"random");
         Game.SG.playlistDefinitions = [];
         Game.SG.ensureNamedPlaylists();
         this.editingPlaylistID = Game.SG.mainPlaylistID;
         Game.SG.setRecommendedBGMEnabled(true);
         this.refreshBGMCheck();
         this.refreshPlaylistPage();
         this.saveSoundSettings();
      }

      private function closeSettings(e:MouseEvent = null) : *
      {
         if(stage != null)
         {
            stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.movePlaylistDrag);
            stage.removeEventListener(MouseEvent.MOUSE_UP,this.endPlaylistDrag);
         }
         if(this.playlistDragGhost != null && this.playlistDragGhost.parent != null) this.playlistDragGhost.parent.removeChild(this.playlistDragGhost);
         this.playlistDragGhost = null;
         this.playlistDragActive = false;
         if(this.capturingKey >= 0 && stage != null)
         {
            stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.captureKey);
            this.keyButtons[this.capturingKey].alpha = 1;
            this.capturingKey = -1;
         }
         this.settingsPanel.visible = false;
         if(this.playlistOverlay != null) this.playlistOverlay.visible = false;
      }

      public function isSettingsOpen() : Boolean
      {
         return (this.settingsPanel != null && this.settingsPanel.visible) || (this.playlistOverlay != null && this.playlistOverlay.visible);
      }

      public function closeSoundSettings() : *
      {
         this.closeSettings();
      }
   }
}

