package UI.gift
{
   import UI.ClickEvent;
   import UI.button.SountoScrollBar;
   import UI.explore.ExploreIconBox;
   import UI.label.LabelBox;
   import UI.task.TaskIcon;
   import data.StringToDefine;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import gameAll.data.GameData;
   import goods.GoodsDefine;
   
   public class OnePayGiftUI extends Sprite
   {
      
      public var taskName_txt:TextField;
      
      public var useNum_txt:TextField;
      
      public var buy_btn:SimpleButton;
      
      public var chongzhi_btn:SimpleButton;
      
      public var noBuy_btn:*;
      
      public var sBar:SountoScrollBar;
      
      public var itemsBox:ExploreIconBox = new ExploreIconBox();
      
      public var switchLabel:LabelBox = new LabelBox();
      
      public var listCover_mc:Sprite;
      
      public function OnePayGiftUI()
      {
         super();
         this.noBuy_btn.mouseEnabled = false;
         this.itemsBox.setLabelClass(TaskIcon);
         this.itemsBox.setNum(2,4,380,256);
         this.itemsBox.setTotalNum(8);
         this.itemsBox.x = 402;
         this.itemsBox.y = 99;
         this.addChild(this.itemsBox);
         this.buy_btn.addEventListener(MouseEvent.CLICK,this.getGift);
         this.chongzhi_btn.addEventListener(MouseEvent.CLICK,this.chongzhi);
         this.switchLabel.setLabelClass(PayGiftBtn);
         this.init();
      }
      
      public function init() : *
      {
         var n:* = undefined;
         var pay_arr:Array = Game.gameDefine.gift.onePay_arr;
         var name_arr:Array = [];
         for(n in pay_arr)
         {
            name_arr.push("一次充值满 " + pay_arr[n] + " M币");
         }
         this.switchLabel.addLabel(name_arr,35 * name_arr.length,false);
         this.switchLabel.x = 231;
         this.switchLabel.y = 150 + 18;
         addChild(this.switchLabel);
         this.switchLabel.addEventListener(ClickEvent.ON_CLICK,this.labelClick);
         addChild(this.sBar);
         this.sBar.setHigh(252);
         this.sBar.setTarget(this.switchLabel);
         this.switchLabel.mask = this.listCover_mc;
         this.buy_btn.addEventListener(MouseEvent.CLICK,this.getGift);
      }
      
      public function fleshData() : *
      {
         this.showPay(this.switchLabel.nowIndex);
      }
      
      public function labelClick(event:ClickEvent) : *
      {
         this.showPay(event.index);
      }
      
      public function chongzhi(e:* = null) : *
      {
         Game.uiGroup.mainUI.allGiftUI.visible = false;
         Game.uiGroup.show("rank");
      }
      
      public function chooseLabel(index0:int) : *
      {
         this.switchLabel.showState(index0);
         this.showPay(index0);
      }
      
      public function showPay(index0:int) : *
      {
         var n:* = undefined;
         var mustM:int = 0;
         var gd0:GoodsDefine = null;
         var pay_arr:Array = Game.gameDefine.gift.onePay_arr;
         var arr0:Array = Game.gameDefine.gift.onePayGift[index0];
         var ccolor:Array = ["red","yellow","purple","green"];
         var num00:int = index0 % 4;
         var color0:String = ccolor[num00];
         var arr1:Array = Game.goodsDefineGroup.getArr_byStrArr(arr0,Game.gameData.level,true,color0);
         this.itemsBox.inData_byArr(arr1);
         var getNum0:int = Game.gameData.giftData.getOneUnlock(index0);
         this.useNum_txt.htmlText = "该礼包还可领取\n" + "<font color=\'FFFF00\'>" + getNum0 + "</font> 次";
         if(getNum0 > 0)
         {
            this.showBtn(0);
         }
         else
         {
            this.showBtn(1);
         }
         var all_M:int = 0;
         for(n in arr1)
         {
            gd0 = arr1[n];
            all_M += gd0.Mprice * gd0.num;
         }
         mustM = int(pay_arr[index0]);
         this.taskName_txt.htmlText = "一次性充值满 " + StringToDefine.getFontColor(mustM + "","#FFFF00") + " M币，即送价值 " + StringToDefine.getFontColor(all_M + "","#FFFF00") + " M币的礼包";
      }
      
      public function showBtn(num0:int) : *
      {
         this.buy_btn.visible = false;
         this.noBuy_btn.visible = false;
         if(num0 == 0)
         {
            this.buy_btn.visible = true;
         }
         else if(num0 == 1)
         {
            this.noBuy_btn.visible = true;
            this.noBuy_btn.txt.text = "领取奖励";
         }
      }
      
      public function getGift(e:* = null) : *
      {
         var n:* = undefined;
         var d0:GoodsDefine = null;
         var items0:* = undefined;
         var ig0:* = undefined;
         var totalNum0:int = 0;
         var m:int = 0;
         var affixLevel0:int = 0;
         var GD:GameData = Game.gameData;
         var index0:int = this.switchLabel.nowIndex;
         var bagNum0:int = 1;
         if(GD.materialsItems.getSurplus() < bagNum0)
         {
            Game.uiGroup.checkTip.showCheck2("材料背包必须有" + bagNum0 + "个以上空位才能领取奖励。",2);
         }
         else
         {
            for(n in this.itemsBox.arr)
            {
               d0 = this.itemsBox.arr[n].itemsData;
               ig0 = GD[d0.type + "Items"];
               if(d0.type == "props" || d0.type == "materials")
               {
                  if(d0.id.indexOf("_chip") > 0)
                  {
                     totalNum0 = d0.num;
                     for(m = 0; m < totalNum0; m++)
                     {
                        affixLevel0 = GD.level - 4 + Math.random() * 11;
                        if(affixLevel0 < 0)
                        {
                           affixLevel0 = 0;
                        }
                        items0 = ig0.addItems(d0.id,1,affixLevel0);
                     }
                  }
                  else
                  {
                     items0 = ig0.addItems(d0.id,d0.num);
                  }
               }
               else
               {
                  items0 = ig0.addItems(d0.id,true);
               }
            }
            Game.uiGroup.checkTip.showTip("领取成功！",1);
            Game.SG.playSound("upgradeArms");
            Game.gameData.giftData.getGiftOneUnlock(index0);
            this.fleshData();
         }
      }
      
      public function hide(e:* = null) : *
      {
         visible = false;
      }
   }
}

