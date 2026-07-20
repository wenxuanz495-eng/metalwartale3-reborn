package UI.shop
{
   import UI.ClickEvent;
   import UI.label.LabelCtrl;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import gameAll.data.GameData;
   import goods.GoodsDefine;
   import goods.GoodsDefineGroup;
   
   public class ShopUI extends Sprite
   {
      
      public var return_btn:SimpleButton;
      
      public var GDG:GoodsDefineGroup;
      
      public var GD:GameData;
      
      public var switchLabel:LabelCtrl = new LabelCtrl();
      
      public var normal_btn:SimpleButton;
      
      public var exchange_btn:SimpleButton;
      
      public var light_sp:Sprite;
      
      public var btn_pay:SimpleButton;
      
      public var shopBox:OneShopUI = new OneShopUI();
      
      public var exchangeBox:OneExchangeUI = new OneExchangeUI();
      
      public var Gprice_txt:TextField;
      
      public var Mprice_txt:TextField;
      
      public var Xprice_txt:TextField;
      
      public var Yprice_txt:TextField;
      
      public var Jprice_txt:TextField;
      
      public var gotoBackState:String = "return";
      
      public var allBox:Array = [];
      
      public function ShopUI()
      {
         super();
         this.mouseEnabled = false;
         this.switchLabel.inData([this.normal_btn,this.exchange_btn],this.light_sp);
         this.switchLabel.addEventListener(ClickEvent.ON_CLICK,this.labelClick);
         addChild(this.shopBox);
         addChild(this.exchangeBox);
         this.allBox = [this.shopBox];
         this.btn_pay.addEventListener(MouseEvent.CLICK,Game.uiGroup.pay);
         this.return_btn.addEventListener(MouseEvent.CLICK,this.returnClick);
      }
      
      public function init() : *
      {
         var n:* = undefined;
         this.GDG = Game.goodsDefineGroup;
         this.GD = Game.gameData;
         for(n in this.allBox)
         {
            this.allBox[n].init();
         }
         this.exchangeBox.init();
         this.showBox(0);
         this.fleshAll();
      }
      
      public function onlyShowRebirthCrystal() : *
      {
         this.showBox(0);
         this.shopBox.showBox(1);
         this.gotoBackState = "bagToMenu_shop";
         Game.uiGroup.menu.visible = false;
      }
      
      public function showAll() : *
      {
         this.gotoBackState = "return";
      }
      
      public function clearAll() : *
      {
         this.showBox(0);
         this.shopBox.clearAll();
         this.exchangeBox.clearAll();
      }
      
      public function fleshAll() : *
      {
         this.shopBox.fleshAll();
      }
      
      private function gotoChange(event:MouseEvent) : *
      {
         Game.uiGroup.gotoChange(this.getNowShopLabel());
      }
      
      public function getNowShopLabel() : String
      {
         var box0:* = undefined;
         var n:* = undefined;
         for(n in this.allBox)
         {
            if(Boolean(this.allBox[n].visible))
            {
               box0 = this.allBox[n];
            }
         }
         if(Boolean(box0))
         {
            return box0.switchLabel.nowLabel;
         }
         return "car";
      }
      
      public function fleshPrice() : *
      {
         this.shopBox.fleshPrice();
         this.exchangeBox.fleshPrice();
      }
      
      public function fleshPlayerMoney() : *
      {
         var gd0:GoodsDefine = Game.gameData.getNowGoodsDefine();
         this.Gprice_txt.text = gd0.price + "";
         this.Mprice_txt.text = gd0.Mprice + "";
         this.Xprice_txt.text = gd0.Xprice + "";
         this.Yprice_txt.text = gd0.Yprice + "";
         this.Jprice_txt.text = gd0.Jprice + "";
      }
      
      public function showBox(num:int) : *
      {
         var n:* = undefined;
         var beforeLabel0:String = this.getNowShopLabel();
         this.switchLabel.setChoose(num);
         for(n in this.allBox)
         {
            this.allBox[n].visible = false;
         }
         if(num == 1)
         {
            this.exchangeBox.visible = true;
            this.exchangeBox.showBox_byLabel();
         }
         else
         {
            this.exchangeBox.visible = false;
            this.allBox[num].visible = true;
            this.allBox[num].showBox_byLabel(beforeLabel0);
         }
      }
      
      private function labelClick(event:ClickEvent) : *
      {
         this.showBox(event.index);
      }
      
      private function returnClick(e:* = null) : *
      {
         if(this.gotoBackState == "return")
         {
            Game.uiGroup.show("startGame");
         }
         else
         {
            Game.uiGroup.show(this.gotoBackState);
         }
      }
   }
}

