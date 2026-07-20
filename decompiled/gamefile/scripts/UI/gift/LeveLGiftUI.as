package UI.gift
{
   import UI.ClickEvent;
   import UI.button.SountoScrollBar;
   import UI.explore.ExploreIconBox;
   import UI.label.LabelBox;
   import UI.task.TaskIcon;
   import data.StringToDefine;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import gameAll.data.CarItemsData;
   import gameAll.data.GameData;
   import gameAll.data.car.CarDataCreator;
   import goods.GoodsDefine;
   import goods.LevelGiftData;
   
   public class LeveLGiftUI extends Sprite
   {
      
      public var taskName_txt:TextField;
      
      public var MCoin_txt:TextField;
      
      public var buy_btn:SimpleButton;
      
      public var chongzhi_btn:SimpleButton;
      
      public var noBuy_btn:*;
      
      public var sBar:SountoScrollBar;
      
      public var itemsBox:ExploreIconBox = new ExploreIconBox();
      
      public var switchLabel:LabelBox = new LabelBox();
      
      public var listCover_mc:Sprite;
      
      public var dingzhi_mc:MovieClip;
      
      public var return_btn:SimpleButton;
      
      private var isfirst:Boolean = false;
      
      public function LeveLGiftUI()
      {
         super();
         this.itemsBox.setLabelClass(TaskIcon);
         this.itemsBox.setNum(2,4,380,256);
         this.itemsBox.setTotalNum(8);
         this.itemsBox.x = 402;
         this.itemsBox.y = 114;
         this.addChild(this.itemsBox);
         this.buy_btn.addEventListener(MouseEvent.CLICK,this.getGift);
         this.chongzhi_btn.addEventListener(MouseEvent.CLICK,this.chongzhi);
         this.switchLabel.setLabelClass(PayGiftBtn);
         this.dingzhi_mc.stop();
         this.dingzhi_mc.visible = false;
         this.init();
         this.return_btn.addEventListener(MouseEvent.CLICK,this.close);
      }
      
      public function init() : *
      {
         var n:LevelGiftData = null;
         var pay_arr:Array = Game.levelGiftDefineGroup.getItemArrCopy();
         var name_arr:Array = [];
         for each(n in pay_arr)
         {
            name_arr.push(n.Name);
         }
         this.switchLabel.addLabel(name_arr,30 * name_arr.length,false,"new_pay");
         this.switchLabel.x = 267;
         this.switchLabel.y = 180;
         addChild(this.switchLabel);
         this.switchLabel.addEventListener(ClickEvent.ON_CLICK,this.labelClick);
         addChild(this.sBar);
         this.sBar.setHigh(252);
         this.sBar.setTarget(this.switchLabel);
         this.switchLabel.mask = this.listCover_mc;
         this.buy_btn.addEventListener(MouseEvent.CLICK,this.getGift);
         addChild(this.dingzhi_mc);
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
         Game.uiGroup.mainUI.allGiftUI.hide();
         Game.uiGroup.show("rank");
      }
      
      public function showPay(index0:int) : *
      {
         var mustM:int = 0;
         var n:* = undefined;
         var lgd:LevelGiftData = null;
         var arr:Array = null;
         var j:int = 0;
         var giftid:String = null;
         var idf:GoodsDefine = null;
         var gd0:GoodsDefine = null;
         var levelGiftArr:Array = Game.levelGiftDefineGroup.getItemArrCopy();
         var giftArr:Array = [];
         for(var i:int = 0; i < levelGiftArr.length; i++)
         {
            lgd = levelGiftArr[i];
            arr = [];
            giftArr.push(arr);
            for(j = 0; j < lgd.Group.length; j++)
            {
               giftid = lgd.Group[j];
               idf = Game.goodsDefineGroup.GetGoodsByName(giftid);
               if(Boolean(idf))
               {
                  arr.push(idf.type + "," + idf.id + "," + lgd.Num[j]);
               }
            }
         }
         var pay_arr:Array = Game.levelGiftDefineGroup.getItemConditionArr();
         var arr0:Array = giftArr[index0];
         var ccolor:Array = ["red","yellow","purple","green"];
         var num00:int = index0 % 4;
         var color0:String = ccolor[num00];
         var arr1:Array = Game.goodsDefineGroup.getArr_byStrArr(arr0,Game.gameData.level,true,color0,"yellow");
         this.itemsBox.inData_byArr(arr1);
         var unlock:int = Game.gameData.giftData.getLevelUnlock(index0);
         mustM = int(pay_arr[index0]);
         var nowM:int = Game.gameData.level + 1;
         this.MCoin_txt.htmlText = "当前等级：" + StringToDefine.getFontColor(nowM + " 级","#FFFF00");
         if(mustM > nowM)
         {
            this.showBtn(2);
         }
         else if(unlock == 0)
         {
            this.showBtn(0);
         }
         else
         {
            this.showBtn(1);
         }
         var bagNum0:int = int(Game.gameDefine.gift.payBagMust[index0]);
         if(bagNum0 <= 0)
         {
            this.dingzhi_mc.visible = true;
            if(mustM > nowM)
            {
               this.dingzhi_mc.gotoAndStop(-bagNum0 * 5 + 2);
            }
            else
            {
               this.dingzhi_mc.gotoAndStop(-bagNum0 * 5 + 1);
            }
         }
         else
         {
            this.dingzhi_mc.visible = false;
         }
         var all_M:int = 0;
         for(n in arr1)
         {
            gd0 = arr1[n];
            all_M += gd0.Mprice * gd0.num;
         }
         this.taskName_txt.htmlText = "";
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
            this.noBuy_btn.txt.text = "已领取";
         }
         else if(num0 == 2)
         {
            this.noBuy_btn.visible = true;
            this.noBuy_btn.txt.text = "未满足条件，不能领取";
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
         var bagNum0:int = Game.levelGiftDefineGroup.getNeedBag(index0);
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
                  if(items0 is CarItemsData)
                  {
                     CarDataCreator.setExchangeData(items0,9,d0.define.itemsData.color);
                  }
               }
            }
            Game.uiGroup.checkTip.showTip("领取成功！",1);
            Game.SG.playSound("upgradeArms");
            Game.gameData.giftData.setLevelUnlock(index0);
            this.fleshData();
         }
      }
      
      public function show() : void
      {
         this.visible = true;
         if(this.isfirst == false)
         {
            this.showPay(0);
            this.isfirst = true;
         }
      }
      
      public function hide(isclear:Boolean = false) : *
      {
         if(isclear)
         {
            this.showPay(0);
            this.isfirst = false;
            this.switchLabel.nowIndex = 0;
            this.switchLabel.showState(0);
         }
         visible = false;
      }
      
      public function close(e:* = null) : *
      {
         this.hide();
      }
   }
}

