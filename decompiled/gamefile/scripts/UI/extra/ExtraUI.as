package UI.extra
{
   import UI.ClickEvent;
   import UI.label.LabelCtrl;
   import UI.main.InfoTipBox;
   import UI.page.PageBox;
   import data.StringToDefine;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import gameAll.data.ExtraData;
   import gameAll.data.SpecialExtraData;
   import gameAll.data.weekExtra.WeekExtraData;
   import gameAll.define.SpecialExtraOneDefine;
   
   public class ExtraUI extends Sprite
   {
      
      internal var name_arr:Array = ["extra","weekExtra","specialExtra"];
      
      public var extraNameArr:Array = [];
      
      public var weekExtraNameArr:Array = [];
      
      public var specialExtraNameArr:Array = [];
      
      public var extraData:ExtraData;
      
      public var weekExtraData:WeekExtraData;
      
      public var specialExtraData:SpecialExtraData;
      
      public var pageBox:PageBox;
      
      public var levelBox:ExtraBtnBox = new ExtraBtnBox();
      
      public var tipBox:InfoTipBox;
      
      public var cover_mc:Sprite;
      
      public var nowIndex:int = 0;
      
      public var extra_btn:SimpleButton;
      
      public var weekExtra_btn:SimpleButton;
      
      public var specialExtra_btn:SimpleButton;
      
      public var light_sp:Sprite;
      
      public var labelCtrl:LabelCtrl = new LabelCtrl();
      
      public var extraState:String = "extra";
      
      public function ExtraUI()
      {
         super();
         this.levelBox.setLabelClass(ExtraBtn);
         this.levelBox.setNum(6,3,918,340);
         this.levelBox.setTotalNum(ExtraData.maxLevel);
         this.levelBox.x = 22;
         this.levelBox.y = 118;
         addChild(this.levelBox);
         this.pageBox.table = this.levelBox;
         this.pageBox.setTotalPage(this.levelBox.totalPage);
         this.levelBox.addEventListener(ClickEvent.ON_CLICK,this.levelClick);
         this.levelBox.addEventListener(ClickEvent.ON_OVER,this.levelOver);
         this.levelBox.addEventListener(ClickEvent.ON_OUT,this.levelOut);
         this.levelBox.addEventListener(ClickEvent.ON_MOVE,this.levelMove);
         this.tipBox = new InfoTipBox();
         addChild(this.tipBox);
         this.tipBox.hide();
         this.init();
         this.labelCtrl.inData([this.extra_btn,this.weekExtra_btn,this.specialExtra_btn],this.light_sp);
         this.labelCtrl.addEventListener(ClickEvent.ON_CLICK,this.labelClick);
      }
      
      public function init() : *
      {
         this.extraData = Game.gameData.extraData;
         this.weekExtraData = Game.gameData.weekExtraData;
         this.specialExtraData = Game.gameData.specialExtraData;
      }
      
      public function fleshData() : *
      {
         this.levelBox.hideAllNum();
         if(this.extraState == "extra")
         {
            this.fleshExtraData();
         }
         else if(this.extraState == "weekExtra")
         {
            this.fleshWeekExtraData();
         }
         else if(this.extraState == "specialExtra")
         {
            this.levelBox.setAllState2(this.specialExtraData.getUnlockArr());
            this.levelBox.setNumArr(this.specialExtraData.getNumArr());
            this.levelBox.playTween();
         }
      }
      
      public function fleshExtraData() : *
      {
         this.extraData.nowDiff = 0;
         this.extraData.fleshUnlock();
         this.levelBox.setAllState2(this.extraData.allState[this.extraData.nowDiff]);
         this.levelBox.playTween();
      }
      
      public function fleshWeekExtraData() : *
      {
         this.levelBox.setAllState2(this.weekExtraData.getUnlockArr());
         this.levelBox.playTween();
      }
      
      private function difficultClick(event:ClickEvent) : *
      {
         this.extraData.nowDiff = event.index;
         this.fleshExtraData();
      }
      
      private function levelClick(event:ClickEvent) : *
      {
         var arr3:Array = null;
         var sd0:SpecialExtraOneDefine = null;
         var index0:int = int(event.goal.index);
         var state0:int = 0;
         this.nowIndex = index0;
         if(this.extraState == "extra")
         {
            if(this.extraData.isLevelCooling(index0))
            {
               Game.uiGroup.checkTip.showCheck("该精英副本正在冷却，剩余 " + this.extraData.getLevelCooldownSeconds(index0) + " 秒。仍可进入，但不会消耗挑战卡，也不会获得场内掉落、固定奖励和翻牌奖励。是否继续？",this.gotoExtraNoReward);
               return;
            }
            state0 = int(this.extraData.allState[this.extraData.nowDiff][index0]);
            if(state0 == 1)
            {
               this.extraData.currentRunRewardB = true;
               this.gotoExtra();
            }
            else if(state0 == 2 || state0 == 3)
            {
               if(this.extraData.hasFirstFree(index0))
               {
                  this.extraData.useFirstFree(index0);
                  Game.uiGroup.checkTip.showTip("使用该精英副本今日免费挑战机会。",1);
                  this.gotoExtra();
               }
               else if(this.extraData.useChallengeCard())
               {
                  Game.uiGroup.checkTip.showTip("已消耗1张精英副本挑战卡。",1);
                  this.gotoExtra();
               }
               else
               {
                  Game.uiGroup.checkTip.showCheck("没有精英副本挑战卡。仍可进入，但不会获得场内掉落、固定奖励和翻牌奖励。是否继续？",this.gotoExtraNoReward);
               }
            }
         }
         else if(this.extraState == "weekExtra")
         {
            state0 = int(this.weekExtraData.getUnlockArr()[index0]);
            if(state0 == 1)
            {
               this.gotoExtra();
            }
            else if(state0 == 2)
            {
               Game.uiGroup.checkTip.showCheck2("玩家副本冷却中，剩余 " + this.weekExtraData.getCooldownSeconds(index0) + " 秒。",2);
            }
         }
         else if(this.extraState == "specialExtra")
         {
            arr3 = this.specialExtraData.arr;
            if(index0 <= arr3.length - 1)
            {
               sd0 = this.specialExtraData.arr[index0];
               trace(sd0);
               if(this.specialExtraData.getCooldownSeconds(index0) > 0)
               {
                  Game.uiGroup.checkTip.showCheck2("特殊副本冷却中，剩余 " + this.specialExtraData.getCooldownSeconds(index0) + " 秒。",2);
               }
               else if(sd0.nowNum > 0)
               {
                  this.gotoExtra();
               }
               else
               {
                  Game.uiGroup.checkTip.showCheck2("今日该副本的重玩次数使用完毕！",2);
               }
            }
         }
         this.tipBox.hide();
      }
      
      public function restartExtraPayOrder() : *
      {
         Game.payController.decMCoin(Game.gameData.extraData.getRestart_M().MCoin,this.restartExtraPayOrder2);
      }
      
      public function restartExtraPayOrder2() : *
      {
         Game.uiGroup.restartExtraCtrl();
         this.gotoExtra();
      }
      
      private function gotoExtra() : *
      {
         Game.eventGroup.chosenLevel(this.nowIndex,this.extraState);
      }
      
      private function gotoExtraNoReward(e:* = null) : *
      {
         this.extraData.useNoReward();
         this.gotoExtra();
      }
      
      private function levelOver(event:ClickEvent) : *
      {
         var color0:String = null;
         var arr4:Array = null;
         var str5:String = null;
         var mustLevel0:int = 0;
         var giftArr0:Array = [];
         var num0:String = "0";
         var str0:String = "";
         if(this.extraState == "extra")
         {
            mustLevel0 = this.extraData.getMustLevel(this.extraData.nowDiff,event.index);
            if(this.extraData.allState[this.extraData.nowDiff][event.index] == 1)
            {
               num0 = "1";
            }
            giftArr0 = Game.gameDefine.extra.getGift(this.extraData.nowDiff,event.index);
         }
         else if(this.extraState == "weekExtra")
         {
            mustLevel0 = this.weekExtraData.getMustLevel(event.index);
            if(event.index <= this.weekExtraData.arr.length - 1)
            {
               if(!this.weekExtraData.arr[event.index].winB)
               {
                  num0 = "无限";
               }
               giftArr0 = this.weekExtraData.arr[event.index].define.giftArr;
            }
         }
         else if(this.extraState == "specialExtra")
         {
            mustLevel0 = this.specialExtraData.getMustLevel(event.index);
            if(event.index <= this.specialExtraData.arr.length - 1)
            {
               num0 = String(this.specialExtraData.arr[event.index].nowNum);
               giftArr0 = this.specialExtraData.arr[event.index].giftArr;
            }
         }
         if(mustLevel0 >= 998)
         {
            str0 += StringToDefine.getFontColor("暂未开放","#FFFF00");
         }
         else
         {
            if(this.extraState == "weekExtra")
            {
               str0 += StringToDefine.getFontColor("玩家副本的BOSS血量会记录\n在存档中，玩家再次进入每\n周副本，BOSS的血量将是上\n一次战败时BOSS的血量。","#FF00FF") + "\n";
            }
            else if(this.extraState == "specialExtra")
            {
               if(Boolean(this.specialExtraData.arr[event.index]))
               {
                  str0 += StringToDefine.getFontColor(this.specialExtraData.arr[event.index].info,"#FF00FF") + "\n";
               }
            }
            str0 += "解锁等级： " + StringToDefine.getFontColor(String(mustLevel0 + 1),"#FFFF00") + " 级";
            color0 = "#FFFF00";
            if(num0 == "0")
            {
               color0 = "#FF0000";
            }
            str0 += "\n" + "今日剩余次数： " + StringToDefine.getFontColor(num0,color0) + " 次";
            if(this.extraState == "extra")
            {
               str0 += "\n今日免费次数：" + (this.extraData.hasFirstFree(event.index) ? "1次" : "已使用");
               str0 += "\n挑战卡：" + Game.gameData.propsItems.getNumByBase("elite_challenge_card") + "张";
               if(this.extraData.isLevelCooling(event.index))
               {
                  str0 += "\n" + StringToDefine.getFontColor("冷却剩余：" + this.extraData.getLevelCooldownSeconds(event.index) + "秒（期间无奖励）","#FF9900");
               }
            }
            if(this.extraState != "extra")
            {
               if(this.extraState == "specialExtra")
               {
                  str0 += "\n" + StringToDefine.getFontColor("（副本通关后剩余次数清零）","#00FF00");
               }
            }
            arr4 = Game.goodsDefineGroup.getArr_byStrArr(giftArr0,Game.gameData.level,true);
            str5 = Game.goodsDefineGroup.switchArr_toStr(arr4,true);
            if(this.extraState == "specialExtra" && event.index == 6)
            {
               str5 = "每坚持15秒获得10点功勋";
            }
            str0 += StringToDefine.getFontColor("\n奖励：","#FFFF00") + str5;
         }
         this.tipBox.showText(str0);
         this.levelMove();
      }
      
      private function levelMove(event:ClickEvent = null) : *
      {
         this.tipBox.x = mouseX - this.tipBox.width;
         this.tipBox.y = mouseY + 20;
         if(this.tipBox.height + this.tipBox.y + 100 > Game.stageHeight)
         {
            this.tipBox.y = Game.stageHeight - 100 - this.tipBox.height;
         }
         if(this.tipBox.x < 20)
         {
            this.tipBox.x = 20;
         }
      }
      
      private function levelOut(event:ClickEvent) : *
      {
         this.tipBox.hide();
      }
      
      public function showLabel(str0:String) : *
      {
         this.extraState = str0;
         this.labelCtrl.setChoose_byLabel(str0);
         this.levelBox.setName(this[str0 + "NameArr"]);
         this.levelBox.setPicFirst(str0);
         this.fleshData();
      }
      
      private function labelClick(event:*) : *
      {
         this.showLabel(this.labelCtrl.nowLabel);
      }
   }
}

