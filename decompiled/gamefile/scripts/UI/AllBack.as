package UI
{
   import UI._new.main._InfoUI;
   import UI.top.HighPlayerBox;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.media.SoundMixer;
   
   public class AllBack extends Sprite
   {
      
      public var box:HighPlayerBox = new HighPlayerBox();
      
      public var carBack_mc:Sprite;
      
      public var info:_InfoUI = new _InfoUI();
      
      public var return_btn:SimpleButton;
      
      public var volume_off_btn:SimpleButton;
      
      public var volume_on_btn:SimpleButton;
      
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
         this.volume_off_btn.addEventListener(MouseEvent.CLICK,this.volumeClick);
         this.volume_on_btn.addEventListener(MouseEvent.CLICK,this.volumeClick);
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
         if(e.target.name == "volume_on_btn")
         {
            Game.uiGroup.stopAllSound();
         }
         else
         {
            Game.uiGroup.openAllSound();
         }
         this.fleshVolumeBtn();
      }
      
      public function fleshVolumeBtn() : *
      {
         if(SoundMixer.soundTransform.volume > 0)
         {
            this.volume_off_btn.visible = false;
            this.volume_on_btn.visible = true;
         }
         else
         {
            this.volume_off_btn.visible = true;
            this.volume_on_btn.visible = false;
         }
      }
   }
}

