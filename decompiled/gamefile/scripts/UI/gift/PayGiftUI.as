package UI.gift
{
   import UI.ClickEvent;
   import UI.button.SountoScrollBar;
   import UI.explore.ExploreIconBox;
   import UI.label.LabelBox;
   import UI.task.TaskIcon;
   import data.StringToDefine;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import gameAll.data.GameData;
   import goods.GoodsDefine;
   
   public class PayGiftUI extends Sprite
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
      
      private var legacyTextFixed:Boolean = false;
      
      public function PayGiftUI()
      {
         super();
         this.noBuy_btn.mouseEnabled = false;
         this.itemsBox.setLabelClass(TaskIcon);
         this.itemsBox.setNum(2,4,380,256);
         this.itemsBox.setTotalNum(8);
         this.itemsBox.x = 402;
         this.itemsBox.y = 114;
         this.addChild(this.itemsBox);
         this.buy_btn.addEventListener(MouseEvent.CLICK,this.getGift);
         this.chongzhi_btn.visible = false;
         this.chongzhi_btn.mouseEnabled = false;
         this.switchLabel.setLabelClass(PayGiftBtn);
         this.dingzhi_mc.stop();
         this.dingzhi_mc.visible = false;
         this.init();
         this.return_btn.addEventListener(MouseEvent.CLICK,this.close);
      }
      
      public function init() : *
      {
         var n:* = undefined;
         var pay_arr:Array = Game.gameDefine.gift.pay_arr;
         var name_arr:Array = [];
         for(n in pay_arr)
         {
            name_arr.push("累计获得 " + pay_arr[n] + " M币");
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
         if(!this.legacyTextFixed && this.parent is DisplayObjectContainer)
         {
            this.replaceLegacyText(this.parent as DisplayObjectContainer);
            this.legacyTextFixed = true;
         }
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
         var nowM:int = 0;
         var n:* = undefined;
         var gd0:GoodsDefine = null;
         var pay_arr:Array = Game.gameDefine.gift.pay_arr;
         var arr0:Array = Game.gameDefine.gift.payGift[index0];
         var ccolor:Array = ["red","yellow","purple","green"];
         var num00:int = index0 % 4;
         var color0:String = ccolor[num00];
         var arr1:Array = Game.goodsDefineGroup.getArr_byStrArr(arr0,Game.gameData.level,true,color0);
         this.itemsBox.inData_byArr(arr1);
         var unlock:int = Game.gameData.giftData.getUnlock(index0);
         var mustM:int = int(pay_arr[index0]);
         nowM = int(Game.gameData.totalEarnedMCoin);
         this.MCoin_txt.htmlText = "历史累计获得：" + StringToDefine.getFontColor(nowM + " M币","#FFFF00");
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
         this.taskName_txt.htmlText = "历史累计获得 " + StringToDefine.getFontColor(mustM + "","#FFFF00") + " M币，即可领取本档礼包";
         if(index0 == pay_arr.length - 1)
         {
            this.taskName_txt.htmlText += "，并解锁纪念称号“骨灰级死忠粉”";
         }
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
         var bagNum0:int = int(Game.gameDefine.gift.payBagMust[index0]);
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
                     m = 0;
                     while(m < totalNum0)
                     {
                        affixLevel0 = GD.level - 4 + Math.random() * 11;
                        if(affixLevel0 < 0)
                        {
                           affixLevel0 = 0;
                        }
                        items0 = ig0.addItems(d0.id,1,affixLevel0);
                        m++;
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
            if(index0 == Game.gameDefine.gift.pay_arr.length - 1 && Game.gameData.honorData.getData("mb_100000") == null)
            {
               Game.gameData.honorData.addHonor("mb_100000");
               Game.uiGroup.checkTip.showCheck2("已获得纪念称号：骨灰级死忠粉",2,null,null,2);
            }
            Game.gameData.giftData.setUnlock(index0);
            Game.uiGroup.saveDataNoUI();
            this.fleshData();
         }
      }
      
      public function hide(e:* = null) : *
      {
         visible = false;
      }
      
      public function close(e:* = null) : *
      {
         Game.uiGroup.show("startGame");
      }
      
      private function replaceLegacyText(container:DisplayObjectContainer) : void
      {
         var i:int = 0;
         var child:DisplayObject = null;
         var field:TextField = null;
         while(i < container.numChildren)
         {
            child = container.getChildAt(i);
            if(child is TextField)
            {
               field = child as TextField;
               if(field.text.indexOf("累计充值值礼包") >= 0)
               {
                  field.text = field.text.replace("累计充值值礼包","累计MB礼包");
               }
               if(field.text.indexOf("累计充值礼包") >= 0)
               {
                  field.text = field.text.replace("累计充值礼包","累计MB礼包");
               }
               if(field.text.indexOf("累计充值奖励") >= 0)
               {
                  field.text = field.text.replace("累计充值奖励","累计MB礼包");
               }
               if(field.text.indexOf("1元=10M币") >= 0)
               {
                  field.text = field.text.replace("1元=10M币","");
               }
            }
            else if(child is DisplayObjectContainer)
            {
               this.replaceLegacyText(child as DisplayObjectContainer);
            }
            i++;
         }
      }
   }
}

