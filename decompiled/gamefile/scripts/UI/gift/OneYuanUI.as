package UI.gift
{
   import UI.explore.ExploreIconBox;
   import UI.task.TaskIcon;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import gameAll.data.GameData;
   import goods.GoodsDefine;
   
   public class OneYuanUI extends Sprite
   {
      
      public var buy_btn:SimpleButton;
      
      public var noBuy_btn:SimpleButton;
      
      public var itemsBox:ExploreIconBox = new ExploreIconBox();
      
      public var title_txt:TextField;
      
      public function OneYuanUI()
      {
         super();
         this.noBuy_btn.mouseEnabled = false;
         this.itemsBox.setLabelClass(TaskIcon);
         this.itemsBox.setNum(2,3,380,194);
         this.itemsBox.setTotalNum(6);
         this.itemsBox.x = 260;
         this.itemsBox.y = 128;
         this.addChild(this.itemsBox);
         this.buy_btn.addEventListener(MouseEvent.CLICK,this.getGift);
      }
      
      public function fleshData() : *
      {
         var n:* = undefined;
         var gd0:GoodsDefine = null;
         if(Game.gameData.giftData.oneYuanB)
         {
            this.noBuy_btn.visible = true;
            this.buy_btn.visible = false;
         }
         else
         {
            this.noBuy_btn.visible = false;
            this.buy_btn.visible = true;
         }
         var ccolor:Array = ["red","yellow","purple","green"];
         var num00:int = Game.timeDate.getSaveDate.date % 4;
         var color0:String = ccolor[num00];
         var arr5:Array = Game.goodsDefineGroup.getArr_byStrArr(Game.gameDefine.gift.oneYuan_arr,Game.gameData.level,true,color0);
         this.itemsBox.inData_byArr(arr5);
         var all_M:int = 0;
         for(n in arr5)
         {
            gd0 = arr5[n];
            all_M += gd0.Mprice * gd0.num;
         }
         this.title_txt.htmlText = "仅需20M币，即可获得以下价值<font color=\'#FFFF00\'>" + all_M + "</font>M币的物品";
      }
      
      public function getGift(e:* = null) : *
      {
         var GD:GameData = Game.gameData;
         if(GD.MCoin < 20)
         {
            Game.uiGroup.checkTip.showCheck2("M币不足，请充值！",4,null,null,2);
         }
         else if(GD.materialsItems.getSurplus() < 3)
         {
            Game.uiGroup.checkTip.showCheck2("材料背包必须有3个以上空位才能领取奖励。",2,null,null,2);
         }
         else
         {
            Game.payController.decMCoin(20,this.affterGetGift);
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
               affixLevel0 = GD.level - 4 + Math.random() * 11;
               if(affixLevel0 < 0)
               {
                  affixLevel0 = 0;
               }
               items0 = ig0.addItems(d0.id,d0.num,affixLevel0);
            }
            else
            {
               items0 = ig0.addItems(d0.id,true);
            }
         }
         Game.uiGroup.checkTip.showTip("购买成功！",1);
         Game.SG.playSound("upgradeArms");
         GD.giftData.oneYuanB = true;
         this.fleshData();
         Game.uiGroup.infoUI.fleshData();
      }
      
      public function hide(e:* = null) : *
      {
         visible = false;
      }
   }
}

