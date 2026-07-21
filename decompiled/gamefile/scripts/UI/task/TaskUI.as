package UI.task
{
   import UI.ClickEvent;
   import UI.explore.ExploreIconBox;
   import UI.label.LabelCtrl;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import gameAll.NormalMustDefine;
   import gameAll.data.GameData;
   import gameAll.data.TaskData;
   import gameAll.data.challenge.ChallengeTaskData;
   import gameAll.data.collect.CollectTaskData;
   import gameAll.data.collect.WeekTaskData;
   import gameAll.define.OneTaskDefine;
   import goods.GoodsDefine;
   
   public class TaskUI extends Sprite
   {
      
      public static var labelArr:Array = ["normalTask","challengeTask","collectTask","weekTask"];
      
      public static var nameArr:Array = ["日常任务","挑战任务","收集任务","扫荡任务"];
      
      public var taskData:TaskData;
      
      public var cData:ChallengeTaskData;
      
      public var cData2:CollectTaskData;
      
      public var cData3:WeekTaskData;
      
      public var label_list:TaskLabelList;
      
      public var nowIndex:int = 0;
      
      public var label:String = "normalTask";
      
      public var description_txt:TextField;
      
      public var taskName_txt:TextField;
      
      public var taskNum_txt:TextField;
      
      public var itemsBox:ExploreIconBox = new ExploreIconBox();
      
      public var rewardSlider:Sprite;
      
      private var activeRewardSlider:Sprite;
      
      private var rewardTargets:Dictionary = new Dictionary(true);
      
      public var get_btn:SimpleButton;
      
      public var no_btn:SimpleButton;
      
      public var complete_btn:SimpleButton;
      
      public var giveup_btn:SimpleButton;
      
      public var gotoLevel_btn:SimpleButton;
      
      public var fleshList_btn:SimpleButton;
      
      public var upStar_btn:SimpleButton;
      
      public var upUseNum_btn:SimpleButton;
      
      public var no_unlock_btn:SimpleButton;
      
      public var challengeUI:ChallengeUI;
      
      public var collectUI:CollectTaskUI;
      
      public var weekUI:WeekTaskUI;
      
      public var con:Sprite = new Sprite();
      
      public var light_sp:Sprite;
      
      public var normalTask_btn:SimpleButton;
      
      public var challengeTask_btn:SimpleButton;
      
      public var collectTask_btn:SimpleButton;
      
      public var weekTask_btn:SimpleButton;
      
      public var labelCtrl:LabelCtrl = new LabelCtrl();
      
      private var cooldownTimer:Timer = new Timer(1000);
      
      public function TaskUI()
      {
         super();
         this.init();
      }
      
      public function init() : *
      {
         addChild(this.con);
         this.con.addChild(this.label_list);
         this.con.addChild(this.description_txt);
         this.con.addChild(this.taskName_txt);
         this.con.addChild(this.taskNum_txt);
         this.con.addChild(this.itemsBox);
         this.con.addChild(this.get_btn);
         this.con.addChild(this.no_btn);
         this.con.addChild(this.complete_btn);
         this.con.addChild(this.giveup_btn);
         this.con.addChild(this.gotoLevel_btn);
         this.con.addChild(this.fleshList_btn);
         this.con.addChild(this.upStar_btn);
         this.con.addChild(this.upUseNum_btn);
         this.con.addChild(this.no_unlock_btn);
         this.labelCtrl.inData([this.normalTask_btn,this.challengeTask_btn,this.collectTask_btn,this.weekTask_btn],this.light_sp);
         this.labelCtrl.addEventListener(ClickEvent.ON_CLICK,this.switchLabelClick);
         this.taskData = Game.gameData.taskData;
         this.cData = Game.gameData.challengeTaskData;
         this.cData2 = Game.gameData.collectTaskData;
         this.cData3 = Game.gameData.weekTaskData;
         this.challengeUI = new ChallengeUI();
         this.collectUI = new CollectTaskUI();
         this.weekUI = new WeekTaskUI();
         this.label_list.addEventListener(ClickEvent.ON_CLICK,this.labelClick);
         this.no_unlock_btn.mouseEnabled = false;
         this.no_unlock_btn.visible = false;
         this.itemsBox.setLabelClass(TaskIcon);
         this.itemsBox.setNum(2,2,381,128);
         this.itemsBox.setTotalNum(4);
         this.itemsBox.x = 490;
         this.itemsBox.y = 255;
         this.con.addChild(this.itemsBox);
         this.rewardSlider = this.createRewardSlider(this.itemsBox);
         this.rewardSlider.x = 490;
         this.rewardSlider.y = 390;
         this.con.addChild(this.rewardSlider);
         this.no_btn.mouseEnabled = false;
         this.get_btn.addEventListener(MouseEvent.CLICK,this.startOneTask);
         this.giveup_btn.addEventListener(MouseEvent.CLICK,this.giveupNowTask);
         this.complete_btn.addEventListener(MouseEvent.CLICK,this.getGift);
         this.upStar_btn.addEventListener(MouseEvent.CLICK,this.upStar);
         this.fleshList_btn.addEventListener(MouseEvent.CLICK,this.fleshList);
         this.upUseNum_btn.addEventListener(MouseEvent.CLICK,this.upUseNum);
         this.fleshList_btn.visible = false;
         this.upUseNum_btn.visible = false;
         this.gotoLevel_btn.addEventListener(MouseEvent.CLICK,this.gotoLevel);
         this.cooldownTimer.addEventListener(TimerEvent.TIMER,this.cooldownTick);
         this.cooldownTimer.start();
         addChild(this.challengeUI);
         this.challengeUI.init(this);
         this.challengeUI.visible = false;
         addChild(this.collectUI);
         this.collectUI.init(this);
         this.collectUI.visible = false;
         addChild(this.weekUI);
         this.weekUI.init(this);
         this.weekUI.visible = false;
      }
      
      public function switchLabelClick(event:ClickEvent) : *
      {
         this.showBox(this.labelCtrl.nowLabel);
      }
      
      public function showBox(str0:String) : *
      {
         var bbstr0:String = "";
         bbstr0 = this.panTaskingNow(str0);
         if(bbstr0 == "")
         {
            if(this.label != str0)
            {
               this.label = str0;
               this.showBox_break(this.label);
            }
         }
         else
         {
            if(bbstr0 != "no")
            {
               Game.uiGroup.checkTip.showCheck2(bbstr0,2);
            }
            this.showBox_break(this.label);
         }
      }
      
      private function showBox_break(str0:String) : *
      {
         this.labelCtrl.setChoose_byLabel(str0);
         this.challengeUI.visible = false;
         this.collectUI.visible = false;
         this.weekUI.visible = false;
         this.con.visible = false;
         if(str0 == "challengeTask")
         {
            this.challengeUI.visible = true;
         }
         else if(str0 == "collectTask")
         {
            this.collectUI.visible = true;
         }
         else if(str0 == "weekTask")
         {
            this.weekUI.visible = true;
         }
         else
         {
            this.con.visible = true;
         }
         this.label = str0;
      }
      
      public function fleshData_first() : *
      {
         this.fleshData();
         if(this.taskData.nowTask.state != "no")
         {
            this.showBox_break("normalTask");
         }
         else if(this.cData.nowTask != null)
         {
            this.showBox_break("challengeTask");
         }
         else if(this.cData2.nowTask != null)
         {
            this.showBox_break("collectTask");
         }
         else if(this.cData3.nowTask != null)
         {
            this.showBox_break("weekTask");
         }
      }
      
      public function fleshData(fleshGoodsB:Boolean = true) : *
      {
         var td0:OneTaskDefine = null;
         this.taskData.refreshCooldownTasks();
         this.fleshUseNum();
         td0 = this.taskData.getTask_byIndex(this.nowIndex);
         if(td0 != null && td0.state != "no")
         {
            this.gotoLevel_btn.alpha = 0.2;
            this.gotoLevel_btn.mouseEnabled = false;
            if(Game.gameData.isLevelUnlock(td0.targetDiff,td0.targetLevel))
            {
               this.gotoLevel_btn.alpha = 1;
               this.gotoLevel_btn.mouseEnabled = true;
            }
         }
         this.showTask_byIndex(this.nowIndex,fleshGoodsB);
         this.fleshNowTaskState();
      }
      
      public function fleshUseNum() : *
      {
         this.taskNum_txt.htmlText = "日常任务：单项冷却10分钟；5项全部完成时立即整组刷新。本任务挑战卡奖励冷却 " + this.taskData.getCardCooldownSeconds(this.nowIndex) + " 秒。";
      }
      
      public function panTaskingNow(label0:String) : String
      {
         if(this.label == label0)
         {
            return "no";
         }
         var nextName0:String = nameArr[labelArr.indexOf(label0)];
         var str0:String = "";
         if(label0 == "challengeTask")
         {
            if(Game.gameData.level < 6)
            {
               str0 = "人物等级到达7级才能开启" + nextName0 + "。";
            }
         }
         else if(label0 == "collectTask")
         {
            if(Game.gameData.level < 59)
            {
               str0 = "人物等级到达60级才能进行" + nextName0 + "。";
            }
         }
         return str0;
      }
      
      public function fleshNowTaskState() : *
      {
         var td0:OneTaskDefine = this.taskData.getTask_byIndex(this.nowIndex);
         this.label_list.setOneState(this.nowIndex,td0.state);
         this.label_list.showLabel(this.nowIndex);
         this.label_list.inData_byArr(this.taskData.getTrueTask5());
         this.fleshOtherBtn();
      }
      
      public function fleshOtherBtn() : *
      {
         var td0:OneTaskDefine = this.taskData.getTask_byIndex(this.nowIndex);
         if(td0.state == "no" && this.taskData.getGetTaskB())
         {
            this.fleshList_btn.alpha = 0.25;
            this.fleshList_btn.mouseEnabled = false;
            this.upStar_btn.alpha = 1;
            this.upStar_btn.mouseEnabled = true;
         }
         else
         {
            this.fleshList_btn.alpha = 0.25;
            this.fleshList_btn.mouseEnabled = false;
            this.upStar_btn.alpha = 0.25;
            this.upStar_btn.mouseEnabled = false;
         }
         if(this.taskData.otherLevel >= 4)
         {
            this.upStar_btn.alpha = 0.25;
            this.upStar_btn.mouseEnabled = false;
         }
      }
      
      public function showTask_byIndex(index0:int, fleshGoodsB:Boolean = true) : *
      {
         this.nowIndex = index0;
         var td0:OneTaskDefine = this.taskData.getTrueTask_byIndex(this.nowIndex);
         var diff_str:String = td0.getDiffString();
         var page_str:String = td0.getPageString();
         var level_str:String = td0.getLevelString();
         trace(td0);
         this.taskName_txt.htmlText = "击杀任意怪物" + this.getFontColor("（" + (td0.taskLevel + 1) + "级）","#00FFFF");
         var str0:String = "";
         str0 += "关卡：" + this.getFontColor(page_str + " > " + diff_str + " > " + level_str.replace(" ",""),"#00FFFF");
         var diff0:int = td0.targetDiff;
         var level0:int = td0.targetLevel;
         trace("当前任务：" + diff0 + "，" + level0);
         this.get_btn.alpha = 1;
         this.get_btn.mouseEnabled = true;
         if(!Game.gameData.isLevelUnlock(diff0,level0))
         {
            this.get_btn.alpha = 0.3;
            this.get_btn.mouseEnabled = false;
            str0 += this.getFontColor("（未解锁）","#FF0000");
         }
         str0 += "\n任务：" + this.getFontColor("击杀任意怪物 " + td0.getAllNum() + " 只","#00FFFF");
         if(td0.state == "ing")
         {
            str0 += this.getFontColor("（已击杀" + td0.completeNum + "只）","#FFFF00");
         }
         else if(td0.state == "complete")
         {
            str0 += this.getFontColor("（完成任务）","#FFFF00");
         }
         else if(td0.state == "over")
         {
            str0 += this.getFontColor("（任务已完成，冷却剩余 " + this.formatCooldown(this.taskData.getCooldownSeconds(this.nowIndex)) + "；5项全部完成可立即刷新）","#FF9900");
         }
         this.description_txt.htmlText = str0;
         var arr4:Array = Game.goodsDefineGroup.getArr_byStrArr(td0.giftArr,Game.gameData.level,true);
         if(this.taskData.canShowChallengeCard(this.nowIndex))
         {
            arr4 = arr4.concat(Game.goodsDefineGroup.getArr_byStrArr(["props,\t\t\telite_challenge_card,\t1"],Game.gameData.level,true));
         }
         if(fleshGoodsB)
         {
            this.itemsBox.inData_byArr(arr4,true);
            this.updateRewardSlider(this.rewardSlider,this.itemsBox);
         }
         if(td0.state == "no")
         {
            if(this.taskData.getGetTaskB())
            {
               this.showBtn("get");
            }
            else
            {
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
         else if(td0.state == "over")
         {
            this.setNoButtonText("任务已完成  " + this.formatCooldown(this.taskData.getCooldownSeconds(this.nowIndex)));
            this.showBtn("no");
         }
      }
      
      private function cooldownTick(e:TimerEvent) : *
      {
         if(this.stage == null || !this.visible)
         {
            return;
         }
         if(this.challengeUI.visible)
         {
            this.cData.refreshCooldownTasks();
            this.challengeUI.fleshData(false);
         }
         else if(this.collectUI.visible)
         {
            this.cData2.refreshCooldownTasks();
            this.collectUI.fleshData(false);
         }
         else if(this.con.visible)
         {
            this.fleshData(false);
         }
      }
      
      public function createRewardSlider(box:ExploreIconBox) : Sprite
      {
         var slider:Sprite = new Sprite();
         var track:Sprite = new Sprite();
         var knob:Sprite = new Sprite();
         track.graphics.beginFill(1194837,0.9);
         track.graphics.drawRoundRect(0,0,381,10,8,8);
         track.graphics.endFill();
         knob.graphics.beginFill(2218239,1);
         knob.graphics.drawRoundRect(0,-4,72,18,10,10);
         knob.graphics.endFill();
         slider.addChild(track);
         slider.addChild(knob);
         track.addEventListener(MouseEvent.MOUSE_DOWN,this.rewardSliderDown);
         knob.addEventListener(MouseEvent.MOUSE_DOWN,this.rewardSliderDown);
         this.rewardTargets[slider] = box;
         return slider;
      }
      
      public function updateRewardSlider(slider:Sprite, box:ExploreIconBox) : *
      {
         if(slider == null || box == null)
         {
            return;
         }
         this.rewardTargets[slider] = box;
         Sprite(slider.getChildAt(1)).x = 0;
         slider.alpha = box.totalPage > 1 ? 1 : 0.35;
         slider.mouseChildren = true;
         box.showPage(0,true,false);
      }
      
      private function rewardSliderDown(e:MouseEvent) : *
      {
         this.activeRewardSlider = e.currentTarget.parent as Sprite;
         this.moveRewardSlider();
         stage.addEventListener(MouseEvent.MOUSE_MOVE,this.rewardSliderMove);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.rewardSliderUp);
      }
      
      private function rewardSliderMove(e:MouseEvent) : *
      {
         this.moveRewardSlider();
         e.updateAfterEvent();
      }
      
      private function rewardSliderUp(e:MouseEvent) : *
      {
         stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.rewardSliderMove);
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.rewardSliderUp);
         this.activeRewardSlider = null;
      }
      
      private function moveRewardSlider() : *
      {
         var box:ExploreIconBox = null;
         var knob:Sprite = null;
         var maxX:Number = 0;
         var value:Number = 0;
         if(this.activeRewardSlider == null)
         {
            return;
         }
         box = this.rewardTargets[this.activeRewardSlider] as ExploreIconBox;
         if(box == null || box.totalPage <= 1)
         {
            return;
         }
         knob = this.activeRewardSlider.getChildAt(1) as Sprite;
         maxX = 381 - knob.width;
         value = Math.max(0,Math.min(maxX,this.activeRewardSlider.mouseX - knob.width / 2));
         knob.x = value;
         box.showPage(Math.round(value / maxX * (box.totalPage - 1)),true,false);
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
      
      public function startOneTask(e:* = null) : *
      {
         var td0:OneTaskDefine = this.taskData.getTask_byIndex(this.nowIndex);
         trace("开始任务：" + this.nowIndex);
         if(td0.state == "no")
         {
            this.taskData.startOneTask(this.nowIndex);
            this.fleshData();
            Game.SG.playSound("get_task");
         }
      }
      
      public function giveupNowTask(e:* = null) : *
      {
         Game.uiGroup.checkTip.showCheck("放弃任务会清空你已经击杀的怪物数量，你确定要放弃吗？",this.affterGiveupNowTask);
      }
      
      public function affterGiveupNowTask(e:* = null) : *
      {
         var td0:OneTaskDefine = this.taskData.getTask_byIndex(this.nowIndex);
         trace("开始任务：" + this.nowIndex);
         if(td0.state == "ing")
         {
            this.taskData.giveupTask(this.nowIndex);
            this.fleshData();
            Game.SG.playSound("giveUp_task");
         }
      }
      
      public function gotoLevel(e:* = null) : *
      {
         var page0:* = undefined;
         var td0:OneTaskDefine = this.taskData.getTask_byIndex(this.nowIndex);
         if(td0.state == "ing")
         {
            page0 = td0.getPageName();
            trace(td0.toString());
            this.gotoOneLevel(page0,td0.targetDiff % 4,td0.targetLevel);
         }
      }
      
      public function gotoOneLevel(lp0:String, diff0:int, level0:int) : *
      {
         Game.uiGroup.mainUI.taskUI.visible = false;
         Game.uiGroup.chooseLevelUI.gotoLevel(lp0,diff0,level0);
      }
      
      public function getGift(e:* = null) : *
      {
         var GD:GameData = Game.gameData;
         if(GD.materialsItems.getSurplus() < 2)
         {
            Game.uiGroup.checkTip.showCheck2("材料背包必须有2个以上空位才能领取奖励。",2,null,null,2);
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
         var td0:OneTaskDefine = this.taskData.getTask_byIndex(this.nowIndex);
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
                  affixLevel0 = td0.taskLevel - 4 + Math.random() * 5;
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
         var cardB:Boolean = this.taskData.finishTask(this.nowIndex);
         if(cardB)
         {
            Game.uiGroup.checkTip.showTip("本次日常任务获得1张精英副本挑战卡，奖励冷却30分钟！",1);
         }
         ++Game.gameData.challengeTaskData.extraNum;
         Game.gameData.livenessData.addTaskNum("task");
         this.fleshData();
         Game.uiGroup.infoUI.fleshData();
         Game.uiGroup.saveDataNoUI();
      }
      
      public function upStar(e:* = null) : *
      {
         var nmd0:NormalMustDefine = Game.gameDefine.getTaskUpStar_M(this.taskData.otherLevel);
         Game.uiGroup.checkTip.showMustCheck(nmd0,"升级所有任务星级，需要：",this.affterUpStar);
      }
      
      public function affterUpStar(e:* = null) : *
      {
         var nmd0:NormalMustDefine = Game.gameDefine.getTaskUpStar_M(this.taskData.otherLevel);
         Game.payController.decMCoin(nmd0.MCoin,this.affterUpStar2);
      }
      
      public function affterUpStar2(e:* = null) : *
      {
         Game.SG.playSound("useItems");
         this.taskData.upStar();
         this.fleshData();
      }
      
      public function fleshList(e:* = null) : *
      {
         var nmd0:NormalMustDefine = Game.gameDefine.getTaskFleshList_M();
         Game.uiGroup.checkTip.showMustCheck(nmd0,"刷新任务列表，需要：",this.affterFleshList);
      }
      
      public function affterFleshList(e:* = null) : *
      {
         var nmd0:NormalMustDefine = Game.gameDefine.getTaskFleshList_M();
         Game.payController.decMCoin(nmd0.MCoin,this.affterFleshList2);
      }
      
      public function affterFleshList2(e:* = null) : *
      {
         Game.SG.playSound("useItems");
         this.taskData.fleshTaskStr(true);
         this.fleshData();
      }
      
      public function upUseNum(e:* = null) : *
      {
         var nmd0:NormalMustDefine = Game.gameDefine.getTaskUpUseNum_M(this.taskData.maxNum);
         Game.uiGroup.checkTip.showMustCheck(nmd0,"提升任务次数，需要：",this.affterUpUseNum);
      }
      
      public function affterUpUseNum(e:* = null) : *
      {
         var nmd0:NormalMustDefine = Game.gameDefine.getTaskUpUseNum_M(this.taskData.maxNum);
         Game.payController.decMCoin(nmd0.MCoin,this.affterUpUseNum2);
      }
      
      public function affterUpUseNum2(e:* = null) : *
      {
         Game.SG.playSound("useItems");
         this.taskData.upUseNum();
         if(this.taskData.nowTask.state == "no")
         {
            this.fleshData();
         }
         else
         {
            this.fleshUseNum();
         }
      }
      
      public function showBtn(str0:String) : *
      {
         this.get_btn.visible = false;
         this.giveup_btn.visible = false;
         this.complete_btn.visible = false;
         this.no_btn.visible = false;
         this[str0 + "_btn"].visible = true;
         this.gotoLevel_btn.visible = this.giveup_btn.visible;
      }
      
      public function labelClick(event:ClickEvent) : *
      {
         var index0:int = event.index;
         this.label_list.showLabel(index0);
         this.showTask_byIndex(index0);
      }
      
      private function getFontColor(str:String, _color1:String = "#999999") : String
      {
         return "<font color=\'" + _color1 + "\'>" + str + "</font>";
      }
      
      public function hide(e:* = null) : *
      {
         Game.uiGroup.menu.show("main");
      }
   }
}

