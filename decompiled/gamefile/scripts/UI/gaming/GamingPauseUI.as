package UI.gaming
{
   import UI.button.PicButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
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
      
      public function GamingPauseUI()
      {
         super();
      }
      
      public function init() : *
      {
         this.btn_arr = [this.resumeGame_btn,this.restartLevel_btn,this.overLevel_btn];
         this.resumeGame_btn.setBack("orange1");
         this.initBtn();
         this.settings_btn = this.createSettingsButton();
         var resumePoint:Point = this.globalToLocal(this.resumeGame_btn.parent.localToGlobal(new Point(this.resumeGame_btn.x,this.resumeGame_btn.y)));
         var overPoint:Point = this.globalToLocal(this.overLevel_btn.parent.localToGlobal(new Point(this.overLevel_btn.x,this.overLevel_btn.y)));
         this.settings_btn.x = resumePoint.x;
         this.settings_btn.y = overPoint.y + this.overLevel_btn.height + 8;
         addChild(this.settings_btn);
      }

      private function createSettingsButton() : Sprite
      {
         var button:Sprite = new Sprite();
         var label:TextField = new TextField();
         var width0:Number = this.resumeGame_btn.width;
         if(width0 < 120) width0 = 160;
         button.graphics.beginFill(263177,1);
         button.graphics.lineStyle(2,65535,1);
         button.graphics.drawRect(0,0,width0,30);
         button.graphics.endFill();
         label.defaultTextFormat = new TextFormat("_sans",14,16777215,false);
         label.autoSize = TextFieldAutoSize.LEFT;
         label.selectable = false;
         label.mouseEnabled = false;
         label.text = "设置";
         label.x = (width0 - label.width) / 2;
         label.y = 5;
         button.addChild(label);
         button.buttonMode = true;
         button.mouseChildren = false;
         button.addEventListener(MouseEvent.CLICK,this.openSettings);
         return button;
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

