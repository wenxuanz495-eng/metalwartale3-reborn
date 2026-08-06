package UI.main
{
   import UI.button.SountoScrollBar;
   import UI.items.ItemsBox;
   import flash.display.Shape;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import gameAll.data.GiftData;
   
   public class PayActivityUI extends Sprite
   {
      
      public var return_btn:SimpleButton;
      
      public var pay_btn:SimpleButton;
      
      public var giftBox:ItemsBox = new ItemsBox();
      
      public var sBar:SountoScrollBar = new SountoScrollBar();
      
      public var con:Sprite;
      
      public var context:PayActivityContext = new PayActivityContext();
      
      public var coverShape:Shape = new Shape();
      
      public function PayActivityUI()
      {
         super();
         this.return_btn.addEventListener(MouseEvent.CLICK,this.hide);
      }
      
      public function show2(e:* = null) : *
      {
         this.show();
      }
      
      public function fleshData() : *
      {
         var gd0:GiftData = Game.gameData.giftData;
         this.context.getGift2_btn.visible = !gd0.nationalDayPayB;
         this.context.getGift3_btn.visible = !gd0.nationalDayGiftB;
         var pay0:Number = Game.payController2.getTrueTotalRecharged() - Game.gameData.rankAdd.oldRecharged2;
         this.context.txt2.text = "当前版本累计充值：" + pay0;
         if(pay0 > 879)
         {
            this.context.getGift2_btn.mouseEnabled = true;
            this.context.getGift2_btn.alpha = 1;
         }
         else
         {
            this.context.getGift2_btn.mouseEnabled = false;
            this.context.getGift2_btn.alpha = 0.4;
         }
         var num0:int = gd0.killAirshipNum;
         this.context.txt3.text = "击杀个数：" + num0;
         if(num0 > 0)
         {
            this.context.getGift1_btn.mouseEnabled = true;
            this.context.getGift1_btn.alpha = 1;
         }
         else
         {
            this.context.getGift1_btn.mouseEnabled = false;
            this.context.getGift1_btn.alpha = 0.4;
         }
      }
      
      public function getGift(e:* = null) : *
      {
         var gd0:GiftData = Game.gameData.giftData;
         if(e.target == this.context.getGift1_btn)
         {
            this.affter_getGift(e);
         }
         else if(e.target == this.context.getGift2_btn)
         {
            if(Game.gameData.materialsItems.getSurplus() >= 3)
            {
               this.affter_getGift(e);
            }
            else
            {
               Game.uiGroup.checkTip.showCheck2("材料背包必须剩余3个空位才能领取奖励。",2);
            }
         }
         else if(e.target == this.context.getGift3_btn)
         {
            if(Game.gameData.materialsItems.getSurplus() >= 1)
            {
               this.affter_getGift(e);
            }
            else
            {
               Game.uiGroup.checkTip.showCheck2("材料背包必须剩余1个空位才能领取奖励。",2);
            }
         }
      }
      
      private function affter_getGift(e:* = null) : *
      {
         var num0:int = 0;
         var gd0:GiftData = Game.gameData.giftData;
         if(e.target == this.context.getGift1_btn)
         {
            if(gd0.haveSuperNum >= 10)
            {
               Game.uiGroup.checkTip.showCheck2("兑换个数超过10个，不能兑换了。",2);
               return;
            }
            if(gd0.killAirshipNum > 0)
            {
               num0 = gd0.killAirshipNum;
               if(num0 > 10 - gd0.haveSuperNum)
               {
                  num0 = 10 - gd0.haveSuperNum;
               }
               Game.gameData.propsItems.addItems("superalloyStone",num0);
               gd0.haveSuperNum += num0;
               gd0.killAirshipNum -= num0;
            }
            Game.uiGroup.checkTip.showTip("兑换成功！",1);
            Game.SG.playSound("upgradeArms");
            this.fleshData();
            return;
         }
         if(e.target == this.context.getGift2_btn)
         {
            Game.IC.addPurpleChip_byLevel(Game.gameData.level);
            Game.IC.addPurpleChip_byLevel(Game.gameData.level);
            Game.uiGroup.addGift_byArr(Game.gameDefine.gift.getPay10(),true);
            gd0.nationalDayPayB = true;
         }
         else if(e.target == this.context.getGift3_btn)
         {
            Game.uiGroup.addGift_byArr(Game.gameDefine.gift.getGift10(),true);
            gd0.nationalDayGiftB = true;
         }
         Game.uiGroup.saveDataNoUI();
         this.fleshData();
      }
      
      public function pay(e:*) : *
      {
         Game.uiGroup.pay();
      }
      
      public function show(e:* = null) : *
      {
         this.fleshData();
         this.visible = true;
      }
      
      public function hide(e:* = null) : *
      {
         this.visible = false;
      }
   }
}

