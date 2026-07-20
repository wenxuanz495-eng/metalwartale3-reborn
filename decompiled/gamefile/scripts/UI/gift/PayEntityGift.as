package UI.gift
{
   import UI.ClickEvent;
   import UI.button.SountoScrollBar;
   import UI.label.LabelCtrl;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class PayEntityGift extends Sprite
   {
      
      public var sBar:SountoScrollBar = new SountoScrollBar();
      
      public var listCover_mc:DisplayObject;
      
      public var btn_pay:DisplayObject;
      
      public var light_1:DisplayObject;
      
      public var light_2:DisplayObject;
      
      public var light_3:DisplayObject;
      
      public var light_4:DisplayObject;
      
      public var mc_img:MovieClip;
      
      public var return_btn:SimpleButton;
      
      public var light_sp:Sprite;
      
      public var switchLabel:LabelCtrl = new LabelCtrl();
      
      public function PayEntityGift()
      {
         super();
         this.sBar.x = 789;
         this.sBar.y = 86;
         addChild(this.sBar);
         this.sBar.setHigh(355);
         this.sBar.setTarget(this.mc_img);
         this.mc_img.mask = this.listCover_mc;
         this.switchLabel.inData([this.light_1,this.light_2,this.light_3,this.light_4],this.light_sp);
         this.switchLabel.addEventListener(ClickEvent.ON_CLICK,this.labelClick);
         this.return_btn.addEventListener(MouseEvent.CLICK,this.onReturn);
         this.btn_pay.addEventListener(MouseEvent.CLICK,Game.uiGroup.pay);
      }
      
      protected function labelClick(event:ClickEvent) : void
      {
         this.mc_img.gotoAndStop(event.index + 1);
      }
      
      protected function onReturn(event:MouseEvent) : void
      {
         this.visible = false;
      }
      
      public function show2(e:* = null) : *
      {
         Game.payController2.getTotalRecharged(this.fleshData,this.fleshData);
         this.show();
      }
      
      private function fleshData() : void
      {
         var pay0:Number = Game.payController2.getTrueTotalRecharged() - Game.gameData.rankAdd.oldRecharged2_1;
      }
      
      public function show(e:* = null) : *
      {
         this.visible = true;
      }
   }
}

