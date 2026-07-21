package UI.task
{
   import UI.ClickEvent;
   import UI.button.SountoScrollBar;
   import UI.explore.ExploreIconBox;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import gameAll.data.GameData;
   import gameAll.data.collect.CollectTaskData;
   import gameAll.data.collect.CollectTaskDefine;
   import goods.GoodsDefine;
   
   public class CollectTaskUI extends Sprite
   {
      
      public var cData:CollectTaskData;
      
      public var nowIndex:int = 0;
      
      public var list:ChallengeLabelList = new ChallengeLabelList();
      
      public var description_txt:TextField;
      
      public var taskName_txt:TextField;
      
      public var taskNum_txt:TextField;
      
      public var itemsBox:ExploreIconBox = new ExploreIconBox();
      
      public var rewardSlider:Sprite;
      
      public var get_btn:SimpleButton;
      
      public var no_btn:*;
      
      public var complete_btn:SimpleButton;
      
      public var giveup_btn:SimpleButton;
      
      public var sBar:SountoScrollBar;
      
      public var listCover:Sprite;
      
      public var taskUI:TaskUI;
      
      public function CollectTaskUI()
      {
         super();
      }
      
      public function init(_taskUI:*) : *
      {
         this.taskUI = _taskUI;
         this.cData = Game.gameData.collectTaskData;
         this.list.addEventListener(ClickEvent.ON_CLICK,this.labelClick);
         this.list.setLabelClass(ChallengeLabel);
         this.list.x = 185;
         this.list.y = 162;
         this.sBar.swapToTask();
         this.sBar.targetY = this.list.y;
         this.sBar.setHigh(240);
         addChild(this.list);
         this.list.mask = this.listCover;
         addChild(this.sBar);
         this.itemsBox.setLabelClass(TaskIcon);
         this.itemsBox.setNum(2,2,381,128);
         this.itemsBox.setTotalNum(4);
         this.itemsBox.x = 490;
         this.itemsBox.y = 255;
         this.addChild(this.itemsBox);
         this.rewardSlider = this.taskUI.createRewardSlider(this.itemsBox);
         this.rewardSlider.x = 490;
         this.rewardSlider.y = 390;
         this.addChild(this.rewardSlider);
         this.no_btn.mouseEnabled = false;
         this.get_btn.addEventListener(MouseEvent.CLICK,this.startOneTask);
         this.giveup_btn.addEventListener(MouseEvent.CLICK,this.giveupNowTask);
         this.complete_btn.addEventListener(MouseEvent.CLICK,this.getGift);
      }
      
      public function fleshData(fleshGoodsB:Boolean = true) : *
      {
         this.cData.fleshAllNowNum();
         this.showTask_byIndex(this.nowIndex,fleshGoodsB);
      }
      
      public function labelClick(event:ClickEvent) : *
      {
         this.nowIndex = event.index;
         this.showTask_byIndex(this.nowIndex);
      }
      
      public function showTask_byIndex(index0:int, fleshGoodsB:Boolean = true) : *
      {
         var num00:int = 0;
         this.nowIndex = index0;
         var td0:CollectTaskDefine = this.cData.getTrueTask_byIndex(this.nowIndex);
         var cnName0:String = td0.targetItems;
         this.taskName_txt.htmlText = td0.getTitle();
         var str0:String = "";
         this.taskNum_txt.text = "收集/扫荡任务可同时接取；领取后可立即再次接取；剩余：" + this.formatCooldown(this.cData.getCooldownSeconds(this.nowIndex)) + "。";
         str0 += "关卡：" + this.getFontColor("“第六章-第九章”任意关卡","#00FFFF");
         str0 += "\n任务：" + this.getFontColor("收集“" + td0.cnItems + "” " + td0.targetNum + " 个","#00FFFF");
         if(td0.state == "ing")
         {
            num00 = Game.gameData.materialsItems.getRealNumByBase(td0.targetItems);
            str0 += this.getFontColor("（已收集" + num00 + "个）","#FFFF00");
         }
         else if(td0.state == "complete")
         {
            str0 += this.getFontColor("（完成任务）","#FFFF00");
         }
         else if(td0.state == "over")
         {
            str0 += this.getFontColor("（任务已完成，可再次接取）","#00FF99");
         }
         this.description_txt.htmlText = str0;
         var arr4:Array = Game.goodsDefineGroup.getArr_byStrArr(td0.getGiftArr(),Game.gameData.level,true);
         if(this.cData.canShowChallengeCard(this.nowIndex))
         {
            arr4 = arr4.concat(Game.goodsDefineGroup.getArr_byStrArr(["props,\t\t\telite_challenge_card,\t1"],Game.gameData.level,true));
         }
         if(fleshGoodsB)
         {
            this.itemsBox.inData_byArr(arr4,true);
            this.taskUI.updateRewardSlider(this.rewardSlider,this.itemsBox);
         }
         if(td0.state == "no")
         {
            this.showBtn("get");
         }
         else if(td0.state == "over")
         {
            if(this.cData.canStart(this.nowIndex))
            {
               this.showBtn("get");
            }
            else
            {
               this.setNoButtonText("任务已完成  " + this.formatCooldown(this.cData.getCooldownSeconds(this.nowIndex)));
               this.showBtn("no");
            }
         }
         else if(td0.state == "ing")
         {
            this.showBtn("giveup");
         }
         else if(td0.state == "complete")
         {
            this.showBtn("complete");
         }
         this.list.inData_byArr(this.cData.arr);
         this.sBar.setTarget(this.list,false);
         this.list.showLabel(index0,false);
      }
      
      private function setNoButtonText(value:String) : *
      {
         this.setStateText(this.no_btn.upState,value);
         this.setStateText(this.no_btn.overState,value);
         this.setStateText(this.no_btn.downState,value);
         this.setStateText(this.no_btn.hitTestState,value);
      }
      
      private function setStateText(target:DisplayObject, value:String) : *
      {
         var container:DisplayObjectContainer = null;
         var i:int = 0;
         if(target is TextField)
         {
            TextField(target).text = value;
         }
         else if(target is DisplayObjectContainer)
         {
            container = target as DisplayObjectContainer;
            i = 0;
            while(i < container.numChildren)
            {
               this.setStateText(container.getChildAt(i),value);
               i++;
            }
         }
      }
      
      private function formatCooldown(seconds0:int) : String
      {
         var seconds:int = Math.max(0,seconds0);
         var minutes:int = int(seconds / 60);
         var remain:int = seconds % 60;
         return minutes + ":" + (remain < 10 ? "0" : "") + remain;
      }
      
      public function showBtn(str0:String) : *
      {
         this.get_btn.visible = false;
         this.giveup_btn.visible = false;
         this.complete_btn.visible = false;
         this.no_btn.visible = false;
         this[str0 + "_btn"].visible = true;
      }
      
      private function getFontColor(str:String, _color1:String = "#999999") : String
      {
         return "<font color=\'" + _color1 + "\'>" + str + "</font>";
      }
      
      public function startOneTask(e:* = null) : *
      {
         var td0:CollectTaskDefine = this.cData.getTrueTask_byIndex(this.nowIndex);
         if(td0 != null && td0.state == "no")
         {
            this.cData.startOneTask(this.nowIndex);
            this.fleshData();
            Game.SG.playSound("get_task");
         }
      }
      
      public function getGift(e:* = null) : *
      {
         var GD:GameData = Game.gameData;
         if(GD.materialsItems.getSurplus() < 1)
         {
            Game.uiGroup.checkTip.showCheck2("材料背包必须有1个以上空位才能领取奖励。",2,null,null,2);
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
                  affixLevel0 = d0.affixLevel;
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
         var currentTask:CollectTaskDefine = this.cData.getTrueTask_byIndex(this.nowIndex);
         if(Boolean(currentTask))
         {
            GD.materialsItems.useItemsNumReal(currentTask.targetItems,-1);
         }
         if(this.cData.tryGrantChallengeCard(this.nowIndex))
         {
            Game.uiGroup.checkTip.showTip("收集任务额外获得1张精英副本挑战卡！",1);
         }
         this.cData.getGiftTask(this.nowIndex);
         this.fleshData();
         Game.uiGroup.infoUI.fleshData();
         Game.uiGroup.saveDataNoUI();
      }
      
      public function giveupNowTask(e:* = null) : *
      {
         Game.uiGroup.checkTip.showCheck("你确定要放弃吗？\n放弃之后将清空之前收集到的物品！",this.affterGiveupNowTask);
      }
      
      public function affterGiveupNowTask(e:* = null) : *
      {
         var td0:CollectTaskDefine = this.cData.getTrueTask_byIndex(this.nowIndex);
         if(td0 != null && td0.getNowB())
         {
            Game.gameData.materialsItems.useItemsNumReal(td0.targetItems,100000);
            this.cData.giveupTask(this.nowIndex);
            this.fleshData();
            Game.SG.playSound("giveUp_task");
         }
      }
   }
}

