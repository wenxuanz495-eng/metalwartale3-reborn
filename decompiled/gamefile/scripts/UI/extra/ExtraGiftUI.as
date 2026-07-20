package UI.extra
{
   import UI.explore.ExploreIconBox;
   import UI.task.TaskIcon;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import gameAll.data.GameData;
   import goods.GoodsDefine;
   
   public class ExtraGiftUI extends Sprite
   {
      
      public var title_txt:TextField;
      
      public var buy_btn:SimpleButton;
      
      public var itemsBox:ExploreIconBox = new ExploreIconBox();
      
      public function ExtraGiftUI()
      {
         super();
         this.init();
      }
      
      public function init() : *
      {
         this.itemsBox.setLabelClass(TaskIcon);
         this.itemsBox.setNum(2,3,380,194);
         this.itemsBox.setTotalNum(6);
         this.itemsBox.x = 284;
         this.itemsBox.y = 158;
         this.addChild(this.itemsBox);
         this.buy_btn.addEventListener(MouseEvent.CLICK,this.getGift);
      }
      
      public function fleshData() : *
      {
         var arr4:Array = [];
         var giftArr0:Array = [];
         if(Game.uiGroup.extraUI.extraState == "extra")
         {
            giftArr0 = Game.gameData.extraData.getGiftArr();
         }
         else if(Game.uiGroup.extraUI.extraState == "weekExtra")
         {
            giftArr0 = Game.gameData.weekExtraData.getNowData().define.giftArr;
         }
         else if(Game.uiGroup.extraUI.extraState == "specialExtra")
         {
            giftArr0 = Game.gameData.specialExtraData.getNowData().giftArr;
         }
         arr4 = Game.goodsDefineGroup.getArr_byStrArr(giftArr0,Game.gameData.level,true);
         this.itemsBox.inData_byArr(arr4,true);
      }
      
      public function getGift(e:* = null) : *
      {
         var GD:GameData = Game.gameData;
         if(GD.materialsItems.getSurplus() < 4)
         {
            Game.uiGroup.checkTip.showCheck2("材料背包必须有4个以上空位才能领取奖励。",2,null,null,2);
         }
         else
         {
            this.affterGetGift();
         }
      }
      
      public function affterGetGift() : *
      {
         var n:* = undefined;
         var d0:GoodsDefine = null;
         var items0:* = undefined;
         var ig0:* = undefined;
         var affixLevel0:int = 0;
         var GD:GameData = Game.gameData;
         for(n in this.itemsBox.arr)
         {
            d0 = this.itemsBox.arr[n].itemsData;
            ig0 = GD[d0.type + "Items"];
            if(d0.type == "props" || d0.type == "materials")
            {
               if(d0.id == "GCoin_card_4")
               {
                  GD.addCoin(d0.price);
               }
               else if(d0.id == "achieve_card_3")
               {
                  GD.addAchieve(d0.price);
               }
               else if(d0.id == "exp_card_directly")
               {
                  GD.addExp(d0.price);
               }
               else
               {
                  affixLevel0 = 1;
                  if(Game.uiGroup.extraUI.extraState == "extra")
                  {
                     affixLevel0 = GD.extraData.getEnemyLevel() + 5 * GD.extraData.nowDiff;
                  }
                  else if(Game.uiGroup.extraUI.extraState == "weekExtra")
                  {
                     affixLevel0 = GD.weekExtraData.getNowData().define.level;
                  }
                  if(affixLevel0 < 0)
                  {
                     affixLevel0 = 0;
                  }
                  items0 = ig0.addItems(d0.id,d0.num,affixLevel0);
               }
            }
            else
            {
               items0 = ig0.addItems(d0.id,true);
            }
         }
         Game.uiGroup.checkTip.showTip("领取成功！",1);
         Game.SG.playSound("upgradeArms");
         Game.uiGroup.infoUI.fleshData();
         Game.uiGroup.leftUI.hideExtraGift();
         Game.eventGroup.gameWin();
      }
   }
}

