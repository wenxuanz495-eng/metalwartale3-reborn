package UI.main
{
   import UI._new.main._MainUI;
   import UI.exchange.DouwaUI;
   import UI.gift.AllGiftUI;
   import UI.gift.FirstPayGiftUI;
   import UI.gift.GrowGiftUI;
   import UI.gift.LeveLGiftUI;
   import UI.gift.LivenessUI;
   import UI.gift.PayEntityGift;
   import UI.gift.Prize51;
   import UI.gift.SnowExchange;
   import UI.gift.ViewGameTurntable;
   import UI.honor.HonorUI;
   import UI.rank.RankGiftUI;
   import UI.task.TaskUI;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import gameAll.data.GameData;
   
   public class MainUI extends Sprite
   {
      
      public var notice_mc:NoticeUI = new NoticeUI();
      
      public var gettingUI:GettingUI = new GettingUI();
      
      public var livenessUI:LivenessUI;
      
      public var honorUI:HonorUI;
      
      public var taskUI:TaskUI = new TaskUI();
      
      public var allGiftUI:AllGiftUI = new AllGiftUI();
      
      public var douwa_mc:DouwaUI = new DouwaUI();
      
      public var xuehua_mc:SnowExchange = new SnowExchange();
      
      public var mc_51:Prize51 = new Prize51();
      
      public var grow_mc:GrowGiftUI = new GrowGiftUI();
      
      public var conChooseUI:ConChooseUI;
      
      public var payActivityUI:PayActivityUI = new PayActivityUI();
      
      public var rankGiftUI:RankGiftUI = new RankGiftUI();
      
      public var firstPayUI:FirstPayGiftUI = new FirstPayGiftUI();
      
      public var entityGift:PayEntityGift = new PayEntityGift();
      
      public var levelGift:LeveLGiftUI = new LeveLGiftUI();
      
      public var turntable:ViewGameTurntable = new ViewGameTurntable();
      
      public var _main:_MainUI = new _MainUI();
      
      public var isSended:Boolean = false;
      
      public var isSendInt:int = 0;
      
      public var isSendInt2:int = 0;
      
      public function MainUI()
      {
         super();
         this.init();
         this.mouseEnabled = false;
      }
      
      public function init() : *
      {
         addChild(this.notice_mc);
         addChild(this.douwa_mc);
         addChild(this.xuehua_mc);
         addChild(this.mc_51);
         addChild(this.grow_mc);
         this.notice_mc.return_btn.addEventListener(MouseEvent.CLICK,this.hideNotice);
         Game.gameSprite.topUIL.addChild(this.taskUI);
         this.taskUI.visible = false;
         addChild(this.allGiftUI);
         this.allGiftUI.visible = false;
         this.livenessUI = new LivenessUI();
         addChild(this.livenessUI);
         this.livenessUI.visible = false;
         this.honorUI = new HonorUI();
         Game.gameSprite.topUIL.addChild(this.honorUI);
         addChild(this.conChooseUI);
         this.conChooseUI.visible = false;
         addChild(this.payActivityUI);
         this.payActivityUI.visible = false;
         addChild(this.rankGiftUI);
         this.rankGiftUI.visible = false;
         addChild(this.firstPayUI);
         this.firstPayUI.visible = false;
         addChild(this.entityGift);
         this.entityGift.visible = false;
         addChild(this.levelGift);
         this.levelGift.visible = false;
         addChild(this.turntable);
         this.turntable.visible = false;
         addChildAt(this._main,0);
         this._main.initEvent(this);
         this.hideAll();
         this.startSaveDelay();
      }
      
      public function sendGiftOldPlayer() : void
      {
         var text:String = null;
         var day:int = Game.timeDate.lastLoginToGet2();
         if(this.isSended == false && this.isSendInt == 0 && this.isSendInt2 == 0 && day >= 30)
         {
            text = "";
            text += "<font color=\'#00E200\'>" + "大型G币卡×10" + "</font>,";
            text += "<font color=\'#00E200\'>" + "双倍经验卡×10" + "</font>,";
            text += "<font color=\'#00E200\'>" + "大型功勋卡×10" + "</font>,\n";
            text += "<font color=\'#00E200\'>" + "五级晶体每种2个" + "</font>,";
            text += "<font color=\'#00E200\'>" + "拆解器×10" + "</font>";
            Game.uiGroup.checkTip.showCheck2("好久不见,我们为你准备了一些礼物防止你被别人落下太远!不要偷懒哦!\n" + text,2,this.getOldGift);
            this.isSended = true;
            ++this.isSendInt;
            --this.isSendInt2;
         }
      }
      
      private function getOldGift() : void
      {
         Game.uiGroup.addGift_byArr(Game.gameDefine.gift.getOldGift(),false);
      }
      
      public function fleshData() : *
      {
         this._main.fleshData();
      }
      
      public function showGiftExchange(e:* = null) : *
      {
         this.douwa_mc.visible = true;
      }
      
      public function showXuehuaExchange(e:* = null) : *
      {
         this.xuehua_mc.show();
      }
      
      public function showGift_51(e:* = null) : *
      {
         this.mc_51.show();
      }
      
      public function showGrow(e:* = null) : *
      {
         this.grow_mc.Show();
      }
      
      public function volumeClick(e:*) : *
      {
      }
      
      public function showHonor(e:* = null, label0:String = "ac") : *
      {
         this.honorUI.visible = true;
         this.honorUI.showLabel(label0);
         if(this.honorUI.ac.labelList.small_arr.length == 0)
         {
            this.honorUI.ac.labelList.chooseLabel(0,0);
         }
         this.hide();
      }
      
      public function showTurnTableUI(e:* = null) : *
      {
         this.turntable.show();
      }
      
      public function showLevelGiftUI(e:* = null) : *
      {
         this.levelGift.show();
      }
      
      public function showPayEntityGiftUI(e:* = null) : *
      {
         this.entityGift.show2();
      }
      
      public function showPayActivityUI(e:* = null) : *
      {
         this.payActivityUI.show2();
      }
      
      public function showVip(e:* = null) : *
      {
         Game.uiGroup.show("vip");
      }
      
      public function showDailySign(e:* = null) : *
      {
         Game.uiGroup.show("dailySign");
      }
      
      public function showHelper(e:* = null) : *
      {
         Game.uiGroup.show("helper");
      }
      
      public function showNotice(e:* = null) : *
      {
         this.notice_mc.visible = true;
         this.notice_mc.fleshData();
      }
      
      public function hideNotice(e:* = null) : *
      {
         this.notice_mc.visible = false;
      }
      
      public function showTask(e:* = null) : *
      {
         this.taskUI.visible = true;
         this.taskUI.fleshData_first();
         this.taskUI.challengeUI.fleshData();
         this.taskUI.collectUI.fleshData();
         this.taskUI.weekUI.fleshData();
         this.hide();
      }
      
      public function showConChooseUI(e:* = null) : *
      {
         this.conChooseUI.show20();
      }
      
      public function showRankGift(e:* = null) : *
      {
         this.rankGiftUI.visible = true;
         this.rankGiftUI.fleshData();
      }
      
      public function hideRankGift(e:* = null) : *
      {
         this.rankGiftUI.visible = false;
      }
      
      public function rankGiftPan(e:* = null) : *
      {
         this.showRankGift();
      }
      
      public function showAllGift(e:* = null) : *
      {
         Game.payController2.getTotalRecharged(this.affterShowAllGift);
      }
      
      public function affterShowAllGift() : *
      {
         this.allGiftUI.visible = true;
         this.allGiftUI.fleshData();
      }
      
      public function gotoBBS(e:* = null) : *
      {
         navigateToURL(new URLRequest("http://my.4399.com/forums-mtag-tagid-81243.html"),"_blank");
      }
      
      public function startSaveDelay() : *
      {
         this._main.startSaveDelay();
      }
      
      public function startGettingPan(e:* = null) : *
      {
         Game.payController2.getTotalRecharged(this.getNowTime_affterTotalRecharged);
      }
      
      private function getNowTime_affterTotalRecharged() : *
      {
         this.showGettingUI();
      }
      
      public function hideAll() : *
      {
         this.hideNotice();
         this.livenessUI.visible = false;
         this.taskUI.visible = false;
         this.allGiftUI.visible = false;
         this.douwa_mc.hide();
         this.xuehua_mc.hide();
         this.mc_51.hide();
         this.grow_mc.Hide();
         this.honorUI.hide();
         this.conChooseUI.visible = false;
         this.payActivityUI.visible = false;
         this.hideRankGift();
         this.firstPayUI.hide();
         this.allGiftUI.hide();
      }
      
      public function hide() : *
      {
         this.visible = false;
         Game.uiGroup.allback.hideInfo();
         Game.uiGroup.allback.hidePlayerBox();
      }
      
      public function showGettingUI(event:* = null) : *
      {
      }
      
      public function showLivenessUI(event:* = null) : *
      {
         this.livenessUI.visible = true;
         this.livenessUI.fleshData();
         this.payActivityUI.fleshData();
      }
      
      public function getNewGift(event:* = null) : *
      {
         var num1:int = 0;
         var num2:int = 0;
         var GD:GameData = Game.gameData;
         if(GD.newGiftNumber < GD.NOW_GIFT_NUMBER)
         {
            num1 = GD.materialsItems.getSurplus();
            num2 = GD.propsItems.getSurplus();
            if(num1 >= 5 && num2 >= 1)
            {
               this.getNewGift2();
            }
            else if(num1 < 5)
            {
               Game.uiGroup.checkTip.showCheck2("材料背包至少需要5个空位才能领取此奖励。",2,null,null,2);
            }
            else if(num2 < 1)
            {
               Game.uiGroup.checkTip.showCheck2("道具背包至少需要1个空位才能领取此奖励。",2,null,null,2);
            }
         }
      }
      
      public function getNewGift2() : *
      {
         var GD:GameData = Game.gameData;
         var str0:String = "您获得了：\n200000G币，2个复活水晶，6个超合金Z\n50个超合金，3种武器合成材料各30个";
         GD.newGiftNumber = GD.NOW_GIFT_NUMBER;
         GD.addCoin(200000);
         GD.materialsItems.addItems("superalloy_Z",6);
         GD.materialsItems.addItems("superalloy",50);
         GD.propsItems.addItems("rebirth_crystal",2);
         GD.materialsItems.addItems("buncher_1",30);
         GD.materialsItems.addItems("boom_1",30);
         GD.materialsItems.addItems("thorn_1",30);
         Game.uiGroup.checkTip.showCheck2(str0,2,null,null,1);
         Game.SG.playSound("upgradeArms");
      }
      
      public function FTimer1s() : *
      {
         this._main.FTimer1s();
         if(Game.gameData.groupData.isZuobi())
         {
            Game.uiGroup.zuobile("修改了游戏中的数值！");
         }
      }
   }
}

