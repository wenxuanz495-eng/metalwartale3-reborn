package UI.gift
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.getTimer;
   
   public class Prize51 extends Sprite
   {
      
      public var return_btn:SimpleButton;
      
      public var txt_xuehuacount:TextField;
      
      public var txt_icount_1:TextField;
      
      public var txt_icount_2:TextField;
      
      public var txt_icount_3:TextField;
      
      public var txt_icount_4:TextField;
      
      public var txt_icount_5:TextField;
      
      public var txt_icount_6:TextField;
      
      public var change_1:SimpleButton;
      
      public var change_2:SimpleButton;
      
      public var change_3:SimpleButton;
      
      public var mc_box:MovieClip;
      
      public var mc_light:MovieClip;
      
      private var _state:int = 0;
      
      public function Prize51()
      {
         super();
         this.mc_box.gotoAndStop(1);
         this.change_2.mouseEnabled = false;
         this.change_3.mouseEnabled = false;
         this.return_btn.addEventListener(MouseEvent.CLICK,this.hide);
         this.change_1.addEventListener(MouseEvent.CLICK,this.changePage);
         this.change_2.addEventListener(MouseEvent.CLICK,this.changePage);
         this.change_3.addEventListener(MouseEvent.CLICK,this.changePage);
         this.Init_1();
      }
      
      private function changePage(e:MouseEvent) : void
      {
         var name:String = e.currentTarget.name;
         var id:int = int(name.split("_")[1]);
         if(id == 1)
         {
            this.Init_1();
         }
         else if(id == 2)
         {
            this.Init_2();
         }
         else if(id == 3)
         {
            this.Init_3();
         }
      }
      
      private function Init_1() : void
      {
         this.mc_box.gotoAndStop(1);
         this.mc_light.x = this.change_1.x;
         this.mc_light.y = this.change_1.y;
         this.mc_box.btn_1.addEventListener(MouseEvent.CLICK,this.exchange1);
         this.mc_box.btn_2.addEventListener(MouseEvent.CLICK,this.exchange2);
         this.mc_box.btn_3.addEventListener(MouseEvent.CLICK,this.exchange3);
         this.mc_box.btn_4.addEventListener(MouseEvent.CLICK,this.exchange4);
         this.mc_box.btn_5.addEventListener(MouseEvent.CLICK,this.exchange5);
         this.mc_box.btn_6.addEventListener(MouseEvent.CLICK,this.exchange6);
         var hasc1:int = 1 - Game.gameData.giftData.GetPrize51ByID(1);
         this.mc_box["txt_icount_" + 1].text = hasc1 + "次";
         var hasc2:int = 1 - Game.gameData.giftData.GetPrize51ByID(2);
         this.mc_box["txt_icount_" + 2].text = hasc2 + "次";
         var hasc3:int = 4 - Game.gameData.giftData.GetPrize51ByID(3);
         this.mc_box["txt_icount_" + 3].text = hasc3 + "次";
         var hasc4:int = 4 - Game.gameData.giftData.GetPrize51ByID(4);
         this.mc_box["txt_icount_" + 4].text = hasc4 + "次";
         var hasc5:int = 4 - Game.gameData.giftData.GetPrize51ByID(5);
         this.mc_box["txt_icount_" + 5].text = hasc5 + "次";
         var hasc6:int = 4 - Game.gameData.giftData.GetPrize51ByID(6);
         this.mc_box["txt_icount_" + 6].text = hasc6 + "次";
      }
      
      private function Init_2() : void
      {
         this.mc_box.gotoAndStop(2);
         this.mc_light.x = this.change_2.x;
         this.mc_light.y = this.change_2.y;
         this.mc_box.btn2_1.addEventListener(MouseEvent.CLICK,this.getLogin);
         var hasc:int = 1 - Game.gameData.giftData.GetPrize51_2ByID(1);
         if(hasc <= 0)
         {
            this.mc_box.btn2_1.alpha = 0.3;
            this.mc_box.btn2_1.mouseEnabled = false;
         }
      }
      
      private function Init_3() : void
      {
         this.mc_light.x = this.change_3.x;
         this.mc_light.y = this.change_3.y;
         this.mc_box.gotoAndStop(3);
         this.mc_box.btn3_1.addEventListener(MouseEvent.CLICK,this.getCharge);
         this.mc_box.btn3_2.addEventListener(MouseEvent.CLICK,this.getCharge);
         this.mc_box.btn3_3.addEventListener(MouseEvent.CLICK,this.getCharge);
         this.mc_box.btn_pay.addEventListener(MouseEvent.CLICK,Game.uiGroup.pay);
         var hasc1:int = 1 - Game.gameData.giftData.GetPrize51_2ByID(2);
         var hasc2:int = 1 - Game.gameData.giftData.GetPrize51_2ByID(3);
         var hasc3:int = 1 - Game.gameData.giftData.GetPrize51_2ByID(4);
         if(hasc1 <= 0)
         {
            this.mc_box.btn3_1.alpha = 0.3;
            this.mc_box.btn3_1.mouseEnabled = false;
         }
         if(hasc2 <= 0)
         {
            this.mc_box.btn3_2.alpha = 0.3;
            this.mc_box.btn3_2.mouseEnabled = false;
         }
         if(hasc3 <= 0)
         {
            this.mc_box.btn3_3.alpha = 0.3;
            this.mc_box.btn3_3.mouseEnabled = false;
         }
      }
      
      private function getCharge(event:MouseEvent) : void
      {
         var name:String = event.currentTarget.name;
         var id:int = int(name.split("_")[1]);
         var giftArr:Array = [];
         var nowcharge:Number = Game.payController2.getTrueTotalRecharged() - Game.gameData.rankAdd.oldRecharged2;
         switch(id)
         {
            case 1:
               if(nowcharge < 1000)
               {
                  Game.uiGroup.checkTip.showCheck2("您当前版本充值数不足以领取该奖励,是否充值?",1,Game.uiGroup.pay);
                  return;
               }
               giftArr = ["GCoin,5000000,1","materials,red_crystal_9,1"];
               break;
            case 2:
               if(nowcharge < 2000)
               {
                  Game.uiGroup.checkTip.showCheck2("您当前版本充值数不足以领取该奖励,是否充值?",1,Game.uiGroup.pay);
                  return;
               }
               giftArr = ["GCoin,5000000,1","materials,yellow_crystal_9,1"];
               break;
            case 3:
               if(nowcharge < 3000)
               {
                  Game.uiGroup.checkTip.showCheck2("您当前版本充值数不足以领取该奖励,是否充值?",1,Game.uiGroup.pay);
                  return;
               }
               giftArr = ["GCoin,5000000,1","materials,green_crystal_9,1"];
         }
         Game.uiGroup.checkTip.showCheck2("领取成功!",1);
         Game.uiGroup.addGift_byArr(giftArr,true);
         Game.gameData.giftData.AddPrize51_2ByID(id + 1);
         this.init();
         this.Init_3();
      }
      
      protected function getLogin(event:MouseEvent) : void
      {
         var dNumber:* = Game.timeDate.getSaveDate.getDateClass().getTime() + getTimer();
         var ndate:Date = new Date(dNumber);
         if(ndate.month != 4 || ndate.date != 1)
         {
            Game.uiGroup.checkTip.showCheck2("五月一日才能领取登录奖励!",1);
            return;
         }
         var giftArr:Array = ["GCoin,5100000,1","props,rebirth_crystal,10","materials,red_crystal_5,4","materials,yellow_crystal_5,4","materials,purple_crystal_5,4","materials,green_crystal_5,4"];
         Game.uiGroup.checkTip.showCheck2("领取成功!",1);
         Game.uiGroup.addGift_byArr(giftArr,true);
         Game.gameData.giftData.AddPrize51_2ByID(1);
         this.init();
         this.Init_2();
      }
      
      protected function exchange1(event:MouseEvent) : void
      {
         this._state = 1;
         Game.uiGroup.checkTip.showCheck2("确定要兑换1个超合金原石吗?",1,this.exchange_2);
      }
      
      protected function exchange2(event:MouseEvent) : void
      {
         this._state = 2;
         Game.uiGroup.checkTip.showCheck2("确定要兑换1个稀有拆解器吗?",1,this.exchange_2);
      }
      
      protected function exchange3(event:MouseEvent) : void
      {
         this._state = 3;
         Game.uiGroup.checkTip.showCheck2("确定要兑换1个六级红色晶体吗?",1,this.exchange_2);
      }
      
      protected function exchange4(event:MouseEvent) : void
      {
         this._state = 4;
         Game.uiGroup.checkTip.showCheck2("确定要兑换1个六级黄色晶体吗?",1,this.exchange_2);
      }
      
      protected function exchange5(event:MouseEvent) : void
      {
         this._state = 5;
         Game.uiGroup.checkTip.showCheck2("确定要兑换1个六级绿色晶体吗?",1,this.exchange_2);
      }
      
      protected function exchange6(event:MouseEvent) : void
      {
         this._state = 6;
         Game.uiGroup.checkTip.showCheck2("确定要兑换1个六级紫色晶体吗?",1,this.exchange_2);
      }
      
      private function init() : void
      {
         var xuehua:int = Game.gameData.materialsItems.getNumByBase("ertongaixin");
         this.txt_xuehuacount.text = xuehua + "个";
      }
      
      protected function exchange_2() : void
      {
         var xuehua:int = Game.gameData.materialsItems.getNumByBase("ertongaixin");
         var hasc1:int = 0;
         switch(this._state)
         {
            case 1:
               hasc1 = 1 - Game.gameData.giftData.GetPrize51ByID(this._state);
               if(hasc1 <= 0)
               {
                  Game.uiGroup.checkTip.showCheck2("您今日兑换机会已经用完,明天再来吧!",1);
                  return;
               }
               if(xuehua < 50)
               {
                  Game.uiGroup.checkTip.showCheck2("您的儿童节爱心数量不足!",1);
                  return;
               }
               Game.gameData.propsItems.addItems("superalloyStone",1);
               Game.gameData.materialsItems.useItemsNum("ertongaixin",50);
               break;
            case 2:
               hasc1 = 1 - Game.gameData.giftData.GetPrize51ByID(this._state);
               if(hasc1 <= 0)
               {
                  Game.uiGroup.checkTip.showCheck2("您今日兑换机会已经用完,明天再来吧!",1);
                  return;
               }
               if(xuehua < 50)
               {
                  Game.uiGroup.checkTip.showCheck2("您的儿童节爱心数量不足!",1);
                  return;
               }
               Game.gameData.propsItems.addItems("disassemble_3",1);
               Game.gameData.materialsItems.useItemsNum("ertongaixin",50);
               break;
            case 3:
               hasc1 = 4 - Game.gameData.giftData.GetPrize51ByID(this._state);
               if(hasc1 <= 0)
               {
                  Game.uiGroup.checkTip.showCheck2("您今日兑换机会已经用完,明天再来吧!",1);
                  return;
               }
               if(xuehua < 50)
               {
                  Game.uiGroup.checkTip.showCheck2("您的儿童节爱心数量不足!",1);
                  return;
               }
               Game.gameData.materialsItems.addItems("red_crystal_6",1);
               Game.gameData.materialsItems.useItemsNum("ertongaixin",50);
               break;
            case 4:
               hasc1 = 4 - Game.gameData.giftData.GetPrize51ByID(this._state);
               if(hasc1 <= 0)
               {
                  Game.uiGroup.checkTip.showCheck2("您今日兑换机会已经用完,明天再来吧!",1);
                  return;
               }
               if(xuehua < 50)
               {
                  Game.uiGroup.checkTip.showCheck2("您的儿童节爱心数量不足!",1);
                  return;
               }
               Game.gameData.materialsItems.addItems("yellow_crystal_6",1);
               Game.gameData.materialsItems.useItemsNum("ertongaixin",50);
               break;
            case 5:
               hasc1 = 4 - Game.gameData.giftData.GetPrize51ByID(this._state);
               if(hasc1 <= 0)
               {
                  Game.uiGroup.checkTip.showCheck2("您今日兑换机会已经用完,明天再来吧!",1);
                  return;
               }
               if(xuehua < 50)
               {
                  Game.uiGroup.checkTip.showCheck2("您的儿童节爱心数量不足!",1);
                  return;
               }
               Game.gameData.materialsItems.addItems("green_crystal_6",1);
               Game.gameData.materialsItems.useItemsNum("ertongaixin",50);
               break;
            case 6:
               hasc1 = 4 - Game.gameData.giftData.GetPrize51ByID(this._state);
               if(hasc1 <= 0)
               {
                  Game.uiGroup.checkTip.showCheck2("您今日兑换机会已经用完,明天再来吧!",1);
                  return;
               }
               if(xuehua < 50)
               {
                  Game.uiGroup.checkTip.showCheck2("您的儿童节爱心数量不足!",1);
                  return;
               }
               Game.gameData.materialsItems.addItems("purple_crystal_6",1);
               Game.gameData.materialsItems.useItemsNum("ertongaixin",50);
         }
         Game.gameData.giftData.AddPrize51ByID(this._state);
         Game.uiGroup.checkTip.showCheck2("兑换成功!",1);
         this.init();
         this.Init_1();
      }
      
      public function hide(e:* = null) : *
      {
         visible = false;
      }
      
      public function show() : void
      {
         this.init();
         this.Init_1();
         this.visible = true;
      }
   }
}

