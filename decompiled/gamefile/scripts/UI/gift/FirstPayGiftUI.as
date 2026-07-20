package UI.gift
{
   import UI.icon.ItemsArmsIcon;
   import UI.icon.ItemsCarIcon;
   import body.define.OneArmsDefine;
   import body.hero.CarDefine;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import gameAll.data.ArmsItemsData;
   import gameAll.data.CarItemsData;
   import gameAll.data.car.CarDataCreator;
   
   public class FirstPayGiftUI extends Sprite
   {
      
      public var carIcon:ItemsCarIcon = new ItemsCarIcon();
      
      public var armsIcon:ItemsArmsIcon = new ItemsArmsIcon();
      
      public var getGift_btn:SimpleButton;
      
      public var return_btn:SimpleButton;
      
      public function FirstPayGiftUI()
      {
         super();
         addChild(this.carIcon);
         this.carIcon.x = 238;
         this.carIcon.y = 250;
         addChild(this.armsIcon);
         this.armsIcon.x = 564;
         this.armsIcon.y = 277;
         this.getGift_btn.addEventListener(MouseEvent.CLICK,this.getFirstGift);
         this.return_btn.addEventListener(MouseEvent.CLICK,this.hide);
      }
      
      public function show(e:* = null) : *
      {
         Game.payController2.getTotalRecharged(this.fleshData);
         this.visible = true;
      }
      
      public function hide(e:* = null) : *
      {
         this.visible = false;
      }
      
      public function fleshData() : *
      {
         var d1:OneArmsDefine = Game.defineGroup.getAD_byStr(Game.gameDefine.liveness.firstArms);
         var d2:CarDefine = Game.defineGroup.getCarDefine(Game.gameDefine.liveness.getFirstCar(Game.nowSaveIndex));
         this.armsIcon.clearData();
         this.armsIcon.inData_byDefine(d1);
         this.carIcon.clearData();
         this.carIcon.inData_byDefine(d2);
         var mcoin:int = Game.payController2.getTrueTotalRecharged();
         if(Game.gameData.livenessData.firstGetB || mcoin < 50)
         {
            this.getGift_btn.mouseEnabled = false;
            this.getGift_btn.alpha = 0.4;
         }
         else
         {
            this.getGift_btn.mouseEnabled = true;
            this.getGift_btn.alpha = 1;
         }
      }
      
      public function getFirstGift(event:MouseEvent = null) : *
      {
         var aid0:ArmsItemsData = null;
         var cid:CarItemsData = null;
         var d1:OneArmsDefine = Game.defineGroup.getAD_byStr(Game.gameDefine.liveness.firstArms);
         var d2:CarDefine = Game.defineGroup.getCarDefine(Game.gameDefine.liveness.getFirstCar(Game.nowSaveIndex));
         if(Game.gameData.carItems.getSurplus() > 0)
         {
            aid0 = Game.gameData.armsItems.getItemsByBase(d1.id,false);
            if(aid0 == null)
            {
               Game.gameData.armsItems.addItems(d1.getLabel());
            }
            cid = Game.gameData.carItems.addItems(d2.id);
            CarDataCreator.setExchangeData(cid,9,"green");
            Game.uiGroup.checkTip.showTip("领取成功！",1);
            Game.SG.playSound("upgradeArms");
            Game.gameData.livenessData.firstGetB = true;
            this.fleshData();
         }
         else
         {
            Game.uiGroup.checkTip.showCheck2("车库没有剩余的车位了！",2);
         }
      }
   }
}

