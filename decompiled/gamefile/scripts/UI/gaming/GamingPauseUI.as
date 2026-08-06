package UI.gaming
{
   import UI.button.PicButton;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class GamingPauseUI extends Sprite
   {
      
      public var resumeGame_btn:PicButton;
      
      public var restartLevel_btn:PicButton;
      
      public var overLevel_btn:PicButton;
      
      private var btn_arr:Array;

      private var settings_btn:Sprite;

      private var settingsButtonWidth:Number = 160;
      
      public function GamingPauseUI()
      {
         super();
      }
      
      public function init() : *
      {
         this.btn_arr = [this.resumeGame_btn,this.restartLevel_btn,this.overLevel_btn];
         this.resumeGame_btn.setBack("orange1");
         this.initBtn();
         var resumeBounds0:Rectangle = this.resumeGame_btn.back.getBounds(this);
         var overBounds0:Rectangle = this.overLevel_btn.back.getBounds(this);
         this.settingsButtonWidth = resumeBounds0.width;
         this.settings_btn = this.createSettingsButton();
         this.settings_btn.x = resumeBounds0.x;
         this.settings_btn.y = overBounds0.bottom + 8;
         addChild(this.settings_btn);
      }

      private function createSettingsButton() : Sprite
      {
         var button:Sprite = new Sprite();
         var label:TextField = new TextField();
         button.graphics.beginFill(0,0);
         button.graphics.drawRect(0,0,this.settingsButtonWidth,36);
         button.graphics.endFill();
         this.addSettingsImage(button,"ui/pause-settings/button-normal.png","normal");
         this.addSettingsImage(button,"ui/pause-settings/button-hover.png","hover");
         label.defaultTextFormat = new TextFormat("_sans",14,16777215,false,null,null,null,null,"center");
         label.width = this.settingsButtonWidth;
         label.height = 24;
         label.selectable = false;
         label.mouseEnabled = false;
         label.text = "设置";
         label.y = 7;
         button.addChild(label);
         button.buttonMode = true;
         button.mouseChildren = false;
         button.addEventListener(MouseEvent.MOUSE_OVER,this.settingsOver);
         button.addEventListener(MouseEvent.MOUSE_OUT,this.settingsOut);
         button.addEventListener(MouseEvent.CLICK,this.openSettings);
         return button;
      }

      private function addSettingsImage(button0:Sprite, path0:String, role0:String) : *
      {
         var loader0:Loader = new Loader();
         loader0.name = role0;
         loader0.mouseEnabled = false;
         loader0.contentLoaderInfo.addEventListener(Event.COMPLETE,this.settingsImageComplete);
         loader0.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.settingsImageError);
         button0.addChild(loader0);
         loader0.load(new URLRequest(path0));
      }

      private function settingsImageComplete(e:Event) : *
      {
         var loader0:Loader = e.target.loader as Loader;
         loader0.content.width = this.settingsButtonWidth;
         loader0.content.height = 36;
         loader0.visible = loader0.name == "normal";
      }

      private function settingsImageError(e:IOErrorEvent) : *
      {
      }

      private function settingsOver(e:MouseEvent) : *
      {
         this.setSettingsState(true);
      }

      private function settingsOut(e:MouseEvent) : *
      {
         this.setSettingsState(false);
      }

      private function setSettingsState(over0:Boolean) : *
      {
         var child0:DisplayObject = null;
         var i0:int = 0;
         while(i0 < this.settings_btn.numChildren)
         {
            child0 = this.settings_btn.getChildAt(i0);
            if(child0.name == "normal") child0.visible = !over0;
            if(child0.name == "hover") child0.visible = over0;
            i0++;
         }
      }

      private function openSettings(e:MouseEvent) : *
      {
         Game.uiGroup.allback.openSoundSettings();
      }
      
      private function initBtn() : *
      {
         var n:* = undefined;
         var name0:String = null;
         for(n in this.btn_arr)
         {
            name0 = this.btn_arr[n].name;
            name0 = name0.split("_btn")[0];
            this.btn_arr[n].setText(name0);
         }
      }
      
      public function setState(levelState0:String = "normal") : *
      {
         var inLevel:Boolean = Game.gameState == "gaming";
         this.restartLevel_btn.actived = true;
         this.overLevel_btn.actived = true;
         if(levelState0 == "normal")
         {
            this.restartLevel_btn.setText("restartLevel");
            this.overLevel_btn.setText("overLevel");
            if(Game.gameData.nowGameLevel >= 999)
            {
               this.restartLevel_btn.noLabelB = true;
               this.restartLevel_btn.actived = false;
            }
            else
            {
               this.restartLevel_btn.actived = true;
            }
         }
         else if(levelState0 == "extra" || levelState0 == "weekExtra" || levelState0 == "specialExtra")
         {
            this.restartLevel_btn.setText("restartExtra");
            this.overLevel_btn.setText("closeExtra");
         }
         else if(levelState0 == "arena")
         {
            this.restartLevel_btn.noLabelB = true;
            this.restartLevel_btn.actived = false;
         }
         if(!inLevel)
         {
            this.restartLevel_btn.actived = false;
            this.overLevel_btn.actived = false;
         }
      }
   }
}

