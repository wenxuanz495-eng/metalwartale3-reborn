package UI.gaming
{
   import UI.button.PicButton;
   import UI.extra.ExtraGiftUI;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class LeftMenuUI extends Sprite
   {
      
      public var menu_btn:PicButton;
      
      public var toBag_btn:PicButton;
      
      public var shop_btn:PicButton;
      
      private var btn_arr:Array;
      
      public var fill_tip:MovieClip;
      
      public var volume_btn:PicButton;
      
      public var extraGift:ExtraGiftUI = new ExtraGiftUI();
      
      public var heroai_btn:PicButton;

      private var vipAutoToggle:Sprite;

      private var vipAutoText:TextField;
      
      public function LeftMenuUI()
      {
         super();
         this.fill_tip.stop();
      }
      
      public function init() : *
      {
         this.btn_arr = [this.menu_btn,this.toBag_btn,this.shop_btn];
         this.initBtn();
         this.fill_tip.visible = false;
         this.volume_btn.setText("volume_on");
         this.volume_btn.setBack("blue4");
         this.volume_btn.addEventListener(MouseEvent.CLICK,this.volumeClick);
         this.shop_btn.addEventListener(MouseEvent.CLICK,this.gotoShop);
         this.toBag_btn.addEventListener(MouseEvent.CLICK,this.gotoBag);
         addChildAt(this.extraGift,0);
         this.extraGift.visible = false;
         this.heroai_btn.noLabelB = true;
         this.heroai_btn.setText("start_heroai");
         this.heroai_btn.setBack("orange2");
         this.heroai_btn.addEventListener(MouseEvent.CLICK,this.heroai_click);
         this.initVipAutoToggle();
      }

      private function initVipAutoToggle() : *
      {
         this.vipAutoToggle = new Sprite();
         this.vipAutoToggle.buttonMode = true;
         this.vipAutoToggle.mouseChildren = false;
         this.vipAutoToggle.x = this.heroai_btn.x + this.heroai_btn.width + 6;
         this.vipAutoToggle.y = this.heroai_btn.y + (this.heroai_btn.height - 24) / 2;
         this.vipAutoToggle.addEventListener(MouseEvent.CLICK,this.vipAutoClick);
         this.vipAutoText = new TextField();
         this.vipAutoText.defaultTextFormat = new TextFormat("_sans",12,16777215,true);
         this.vipAutoText.width = 104;
         this.vipAutoText.height = 22;
         this.vipAutoText.y = 3;
         this.vipAutoText.selectable = false;
         this.vipAutoText.mouseEnabled = false;
         this.vipAutoToggle.addChild(this.vipAutoText);
         addChild(this.vipAutoToggle);
         this.vipAutoToggle.visible = false;
      }

      public function fleshVipAuto() : *
      {
         var enabled0:Boolean = Game.gameData.vipAideAutoB;
         this.vipAutoToggle.visible = this.heroai_btn.visible && this.heroai_btn.actived && Game.gameData.vipData.nowVip != "";
         this.vipAutoToggle.graphics.clear();
         this.vipAutoToggle.graphics.lineStyle(1,enabled0 ? 5025616 : 6710886,1);
         this.vipAutoToggle.graphics.beginFill(enabled0 ? 2384414 : 3355443,0.94);
         this.vipAutoToggle.graphics.drawRoundRect(0,0,104,24,6,6);
         this.vipAutoToggle.graphics.endFill();
         this.vipAutoText.text = enabled0 ? "连续托管：开" : "连续托管：关";
         this.vipAutoText.textColor = enabled0 ? 10092390 : 13421772;
      }

      private function vipAutoClick(e:MouseEvent) : *
      {
         Game.gameData.vipAideAutoB = !Game.gameData.vipAideAutoB;
         if(Game.gameData.vipAideAutoB)
         {
            if(this.heroai_btn.text == "start_heroai")
            {
               Game.eventGroup.startHeroAI();
               this.setHeroAI(false);
            }
         }
         else if(this.heroai_btn.text == "stop_heroai")
         {
            Game.eventGroup.stopHeroAI();
            this.setHeroAI(true);
         }
         this.fleshVipAuto();
         Game.uiGroup.saveDataNoUI();
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
            this.btn_arr[n].setBack("blue3");
            this.btn_arr[n].noLabelB = true;
         }
         this.shop_btn.setBack("orange3");
      }
      
      public function setHeroAI(bb0:Boolean) : *
      {
         if(bb0)
         {
            this.heroai_btn.setText("start_heroai");
         }
         else
         {
            this.heroai_btn.setText("stop_heroai");
         }
      }
      
      private function heroai_click(e:* = null) : *
      {
         if(this.heroai_btn.text == "start_heroai")
         {
            Game.eventGroup.startHeroAI();
            this.setHeroAI(false);
         }
         else
         {
            Game.gameData.vipAideAutoB = false;
            Game.eventGroup.stopHeroAI();
            this.setHeroAI(true);
            this.fleshVipAuto();
         }
      }
      
      private function affter_heroai_click() : *
      {
         if(this.heroai_btn.text == "start_heroai")
         {
            Game.eventGroup.startHeroAI();
            this.setHeroAI(false);
         }
         else
         {
            Game.eventGroup.stopHeroAI();
            this.setHeroAI(true);
         }
      }
      
      private function levelAiPan() : *
      {
         Game.eventGroup.pauseGame();
         var num0:int = Game.gameData.propsItems.getNumByBase("aide_card");
         if(num0 > 0)
         {
            Game.uiGroup.checkTip.showCheck2("是否使用1张副官卡？\n" + "剩余" + num0 + "副官卡。",1,this.useAidCard,this.levelAiGoBack);
         }
         else
         {
            Game.uiGroup.checkTip.showCheck2("是否使用1张副官卡？\n" + "剩余" + num0 + "副官卡。",5,this.gotoShop,this.levelAiGoBack);
         }
      }
      
      private function useAidCard() : *
      {
         Game.gameData.propsItems.useItemsNum("aide_card");
         Game.gameData.aideEnabled = true;
         Game.eventGroup.startHeroAI();
         this.setHeroAI(false);
         Game.eventGroup.resumeGame();
      }
      
      private function levelAiGoBack() : *
      {
         Game.eventGroup.resumeGame();
      }
      
      public function showExtraGift() : *
      {
         this.extraGift.visible = true;
         Game.SG.playSound("get_task");
         this.extraGift.fleshData();
         this.menu_btn.actived = false;
      }
      
      public function hideExtraGift() : *
      {
         this.extraGift.visible = false;
         this.menu_btn.actived = true;
      }
      
      public function hideBtn() : *
      {
         var n:* = undefined;
         for(n in this.btn_arr)
         {
            this.btn_arr[n].visible = false;
         }
      }
      
      public function showBtn() : *
      {
         var n:* = undefined;
         for(n in this.btn_arr)
         {
            this.btn_arr[n].visible = true;
         }
      }
      
      public function gotoShop(e:* = null) : *
      {
         Game.uiGroup.normalShopB = true;
         Game.eventGroup.pauseGame();
         Game.eventGroup.gotoShopRebirthCrystal();
      }
      
      public function volumeClick(e:*) : *
      {
         if(this.volume_btn.text == "volume_on")
         {
            this.volume_btn.setText("volume_off");
            Game.uiGroup.stopAllSound();
         }
         else
         {
            this.volume_btn.setText("volume_on");
            Game.uiGroup.openAllSound();
         }
      }
      
      public function gotoBag(e:*) : *
      {
         Game.eventGroup.pauseGame();
         Game.uiGroup.show("equip");
         var label0:String = Game.uiGroup._changeUI.bag.label.nowLabel;
         trace("背包表情：************" + label0);
         if(label0 != "car" && label0 != "materials")
         {
            Game.uiGroup._changeUI.bag.showLabel("materials");
         }
      }
   }
}

