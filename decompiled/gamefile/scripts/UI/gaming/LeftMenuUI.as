package UI.gaming
{
   import UI.button.PicButton;
   import UI.extra.ExtraGiftUI;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
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
         var heroButtonBounds0:Rectangle = this.heroai_btn.back.getBounds(this);
         this.vipAutoToggle = new Sprite();
         this.vipAutoToggle.buttonMode = true;
         this.vipAutoToggle.mouseChildren = false;
         this.vipAutoToggle.x = heroButtonBounds0.x;
         this.vipAutoToggle.y = heroButtonBounds0.bottom + 6;
         this.vipAutoToggle.graphics.beginFill(0,0);
         this.vipAutoToggle.graphics.drawRect(0,0,114,36);
         this.vipAutoToggle.graphics.endFill();
         this.addVipAutoImage("ui/auto-level/button-normal.png","normal");
         this.addVipAutoImage("ui/auto-level/button-selected.png","selected");
         this.vipAutoToggle.addEventListener(MouseEvent.CLICK,this.vipAutoClick);
         this.vipAutoText = new TextField();
         var textFormat0:TextFormat = new TextFormat("_sans",14,16777215,true);
         textFormat0.align = "center";
         this.vipAutoText.defaultTextFormat = textFormat0;
         this.vipAutoText.width = 114;
         this.vipAutoText.height = 24;
         this.vipAutoText.y = 7;
         this.vipAutoText.selectable = false;
         this.vipAutoText.mouseEnabled = false;
         this.vipAutoToggle.addChild(this.vipAutoText);
         addChild(this.vipAutoToggle);
         this.vipAutoToggle.visible = false;
      }

      private function addVipAutoImage(path0:String, role0:String) : *
      {
         var loader0:Loader = new Loader();
         loader0.name = role0;
         loader0.mouseEnabled = false;
         loader0.contentLoaderInfo.addEventListener(Event.COMPLETE,this.vipAutoImageComplete);
         loader0.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.vipAutoImageError);
         this.vipAutoToggle.addChild(loader0);
         loader0.load(new URLRequest(path0));
      }

      private function vipAutoImageComplete(e:Event) : *
      {
         var loader0:Loader = e.target.loader as Loader;
         loader0.content.width = 114;
         loader0.content.height = 36;
         this.fleshVipAuto();
      }

      private function vipAutoImageError(e:IOErrorEvent) : *
      {
      }

      public function fleshVipAuto() : *
      {
         var enabled0:Boolean = Game.gameData.vipAideAutoB;
         this.vipAutoToggle.visible = this.heroai_btn.visible && this.heroai_btn.actived && Game.gameData.vipData.nowVip != "";
         var child0:DisplayObject = null;
         var i0:int = 0;
         while(i0 < this.vipAutoToggle.numChildren)
         {
            child0 = this.vipAutoToggle.getChildAt(i0);
            if(child0.name == "normal") child0.visible = !enabled0;
            if(child0.name == "selected") child0.visible = enabled0;
            i0++;
         }
         this.vipAutoText.text = enabled0 ? "连续托管：开" : "连续托管：关";
         this.vipAutoText.textColor = 16777215;
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
         Game.uiGroup.allback.openSoundSettings();
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

