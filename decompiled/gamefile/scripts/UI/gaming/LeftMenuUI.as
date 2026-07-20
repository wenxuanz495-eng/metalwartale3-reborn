package UI.gaming
{
   import UI.button.PicButton;
   import UI.extra.ExtraGiftUI;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
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
            Game.eventGroup.stopHeroAI();
            this.setHeroAI(true);
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

