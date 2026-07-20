package UI.gift
{
   import body.hero.CarDefine;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import gameAll.data.ArmsItemsData;
   import gameAll.data.CarItemsData;
   import gameAll.data.car.CarDataCreator;
   import goods.GoodsDefine;
   
   public class SnowExchange extends Sprite
   {
      
      public var return_btn:SimpleButton;
      
      public var txt_yuanshicount:TextField;
      
      public var txt_xuehuacount:TextField;
      
      public var btn_1:SimpleButton;
      
      public var btn_2:SimpleButton;
      
      public var btn_3:SimpleButton;
      
      public var btn_4:SimpleButton;
      
      public var btn_5:SimpleButton;
      
      public var btn_6:SimpleButton;
      
      public function SnowExchange()
      {
         super();
         this.return_btn.addEventListener(MouseEvent.CLICK,this.hide);
         this.btn_1.addEventListener(MouseEvent.CLICK,this.exchange1);
         this.btn_2.addEventListener(MouseEvent.CLICK,this.exchange2);
         this.btn_3.addEventListener(MouseEvent.CLICK,this.exchange3);
         this.btn_4.addEventListener(MouseEvent.CLICK,this.exchange4);
         this.btn_5.addEventListener(MouseEvent.CLICK,this.exchange5);
         this.btn_6.addEventListener(MouseEvent.CLICK,this.exchange6);
      }
      
      protected function exchange2(event:MouseEvent) : void
      {
         Game.uiGroup.checkTip.showCheck2("确定要兑换1个超合金原石吗?",1,this.exchange_2);
      }
      
      protected function exchange1(event:MouseEvent) : void
      {
         Game.uiGroup.checkTip.showCheck2("确定要兑换武器 2013 吗?",1,this.exchange_1);
      }
      
      protected function exchange3(event:MouseEvent) : void
      {
         Game.uiGroup.checkTip.showCheck2("确定要兑换战车踏雪S1 吗?",1,this.exchange_3);
      }
      
      private function exchange_3() : void
      {
         this.getCar("taxues1",20);
      }
      
      protected function exchange4(event:MouseEvent) : void
      {
         Game.uiGroup.checkTip.showCheck2("确定要兑换战车踏雪S2 吗?",1,this.exchange_4);
      }
      
      private function exchange_4() : void
      {
         this.getCar("taxues2",40);
      }
      
      protected function exchange5(event:MouseEvent) : void
      {
         Game.uiGroup.checkTip.showCheck2("确定要兑换战车踏雪S3 吗?",1,this.exchange_5);
      }
      
      private function exchange_5() : void
      {
         this.getCar("taxues3",80);
      }
      
      protected function exchange6(event:MouseEvent) : void
      {
         Game.uiGroup.checkTip.showCheck2("确定要兑换战车踏雪S4 吗?",1,this.exchange_6);
      }
      
      private function exchange_6() : void
      {
         this.getCar("taxues4",100);
      }
      
      private function getCar(id:String, snownum:int) : void
      {
         var cid:CarItemsData = null;
         var xuehua:int = Game.gameData.materialsItems.getNumByBase("xuehua");
         if(xuehua < snownum)
         {
            Game.uiGroup.checkTip.showCheck2("您的雪花数量不足!",1);
            return;
         }
         var d2:CarDefine = Game.defineGroup.getCarDefine(id);
         if(Game.gameData.carItems.getSurplus() > 0)
         {
            cid = Game.gameData.carItems.addItems(d2.id);
            CarDataCreator.setExchangeData(cid,9,"yellow");
            Game.uiGroup.checkTip.showTip("领取成功！",1);
            Game.SG.playSound("upgradeArms");
            Game.gameData.materialsItems.useItemsNum("xuehua",snownum);
            this.init();
         }
         else
         {
            Game.uiGroup.checkTip.showCheck2("车库没有剩余的车位了！",2);
         }
      }
      
      private function init() : void
      {
         var xuehua:int = Game.gameData.materialsItems.getNumByBase("xuehua");
         this.txt_xuehuacount.text = xuehua + "个";
         var hasc:int = 4 - Game.gameData.giftData.GetSnowYuanshiCount();
         this.txt_yuanshicount.text = hasc + "次";
      }
      
      protected function exchange_2() : void
      {
         var xuehua:int = Game.gameData.materialsItems.getNumByBase("xuehua");
         if(xuehua < 5)
         {
            Game.uiGroup.checkTip.showCheck2("您的雪花数量不足!",1);
            return;
         }
         var hasc1:int = 4 - Game.gameData.giftData.GetSnowYuanshiCount();
         if(hasc1 <= 0)
         {
            Game.uiGroup.checkTip.showCheck2("您今日兑换机会已经用完,明天再来吧!",1);
            return;
         }
         Game.gameData.propsItems.addItems("superalloyStone",1);
         Game.gameData.materialsItems.useItemsNum("xuehua",5);
         Game.gameData.giftData.AddSnowYuanshi();
         Game.uiGroup.checkTip.showCheck2("恭喜你兑换到1个超合金原石!",1);
         this.init();
      }
      
      protected function exchange_1() : void
      {
         var xuehua:int = Game.gameData.materialsItems.getNumByBase("xuehua");
         if(xuehua < 50)
         {
            Game.uiGroup.checkTip.showCheck2("您的雪花数量不足!",1);
            return;
         }
         var gd2:GoodsDefine = Game.goodsDefineGroup.GetGoodsByName("2013");
         var trueID:String = gd2.id.split("_")[0];
         var aid0:ArmsItemsData = Game.gameData.armsItems.getItemsByBase(trueID,false);
         if(aid0 is ArmsItemsData)
         {
            Game.uiGroup.checkTip.showCheck2("你已经拥有该武器,不能再次兑换!",1);
            return;
         }
         Game.uiGroup.checkTip.showCheck2("恭喜你获得了武器:2013!",1);
         Game.uiGroup.addGift_byArr([gd2],true,-1,false);
         Game.gameData.materialsItems.useItemsNum("xuehua",50);
         this.init();
      }
      
      public function hide(e:* = null) : *
      {
         visible = false;
      }
      
      public function show() : void
      {
         this.init();
         this.visible = true;
      }
   }
}

