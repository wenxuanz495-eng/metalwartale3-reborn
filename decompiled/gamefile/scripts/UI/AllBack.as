package UI
{
   import UI._new.main._InfoUI;
   import UI.top.HighPlayerBox;
   import flash.display.Shape;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.KeyboardEvent;
   import flash.geom.Point;
   import flash.net.SharedObject;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.ui.Keyboard;
   
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

      private var keyPage:Sprite;

      private var keyButtons:Array = [];

      private var keyActions:Array = ["moveLeft","moveRight","jump","interact","weapon0","weapon1","weapon2","weapon3","weapon4","weapon5","weapon6","weapon7","rocket","plasma","change","lighting","menu"];

      private var keyLabels:Array = ["左移","右移","推进/跳跃","下降/传送","武器 1","武器 2","武器 3","武器 4","武器 5","武器 6","武器 7","武器 8","火箭推进器","等离子护盾","机甲","卫星闪电炮","菜单/设置"];

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
         this.settingsPanel.visible = !this.settingsPanel.visible;
         if(this.settingsPanel.visible)
         {
            Game.gameSprite.addChild(this.settingsPanel);
         }
      }

      public function openSoundSettings() : *
      {
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
         soundTab.x = 34;
         soundTab.y = 50;
         keyTab.x = 170;
         keyTab.y = 50;
         panel.addChild(soundTab);
         panel.addChild(keyTab);
         this.soundPage = new Sprite();
         this.soundPage.addChild(this.createSlider(0,"\u4e3b\u97f3\u91cf",120));
         panel.addChild(this.soundPage);
         this.keyPage = this.createKeyPage();
         panel.addChild(this.keyPage);
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
            col = i < 8 || i == 16 ? 0 : 1;
            row = i == 16 ? 8 : i % 8;
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
      }

      private function showKeyPage(e:MouseEvent = null) : *
      {
         this.soundPage.visible = false;
         this.keyPage.visible = true;
         this.fleshKeyButtons();
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
            if(i != this.capturingKey && Game.keysGroup.getBinding(this.keyActions[i]) == code)
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
         }
         catch(error:Error)
         {
            this.soundSettings = null;
         }
         this.setSliderValue(0,masterValue);
         this.applySoundSettings();
         this.saveSoundSettings();
      }

      private function applySoundSettings() : *
      {
         Game.SG.setMasterVolume(this.sliderKnobs[0].x / 202);
      }

      private function saveSoundSettings() : *
      {
         if(this.soundSettings == null)
         {
            return;
         }
         try
         {
            this.soundSettings.data.audioSettingsVersion = 4;
            this.soundSettings.data.masterVolume = this.sliderKnobs[0].x / 202;
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
         this.setSliderValue(0,0.5);
         this.applySoundSettings();
         this.saveSoundSettings();
      }

      private function closeSettings(e:MouseEvent = null) : *
      {
         if(this.capturingKey >= 0 && stage != null)
         {
            stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.captureKey);
            this.keyButtons[this.capturingKey].alpha = 1;
            this.capturingKey = -1;
         }
         this.settingsPanel.visible = false;
      }

      public function isSettingsOpen() : Boolean
      {
         return this.settingsPanel != null && this.settingsPanel.visible;
      }

      public function closeSoundSettings() : *
      {
         this.closeSettings();
      }
   }
}

