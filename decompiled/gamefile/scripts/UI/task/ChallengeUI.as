package UI.task
{
   import UI.ClickEvent;
   import UI.button.SountoScrollBar;
   import UI.explore.ExploreIconBox;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import gameAll.data.GameData;
   import gameAll.data.challenge.ChallengeTaskData;
   import gameAll.data.challenge.ChallengeTaskDefine;
   import gameAll.level.LevelsDefine;
   import goods.GoodsDefine;
   
   public class ChallengeUI extends Sprite
   {
      
      public var cData:ChallengeTaskData;
      
      public var nowIndex:int = 0;
      
      public var list:ChallengeLabelList = new ChallengeLabelList();
      
      public var description_txt:TextField;
      
      public var taskName_txt:TextField;
      
      public var taskNum_txt:TextField;
      
      public var itemsBox:ExploreIconBox = new ExploreIconBox();
      
      public var get_btn:SimpleButton;
      
      public var no_btn:SimpleButton;
      
      public var complete_btn:SimpleButton;
      
      public var giveup_btn:SimpleButton;
      
      public var gotoLevel_btn:SimpleButton;
      
      public var sBar:SountoScrollBar;
      
      public var listCover:Sprite;
      
      public var taskUI:TaskUI;
      
      public function ChallengeUI()
      {
         super();
      }
      
      public function init(_taskUI:*) : *
      {
         this.taskUI = _taskUI;
         this.cData = Game.gameData.challengeTaskData;
         this.list.addEventListener(ClickEvent.ON_CLICK,this.labelClick);
         this.list.setLabelClass(ChallengeLabel);
         this.list.x = 185;
         this.list.y = 162;
         this.sBar.swapToTask();
         this.sBar.targetY = this.list.y;
         this.sBar.setHigh(243);
         addChild(this.list);
         this.list.mask = this.listCover;
         addChild(this.sBar);
         this.itemsBox.setLabelClass(TaskIcon);
         this.itemsBox.setNum(2,2,381,128);
         this.itemsBox.setTotalNum(4);
         this.itemsBox.x = 490;
         this.itemsBox.y = 255;
         this.addChild(this.itemsBox);
         this.no_btn.mouseEnabled = false;
         this.get_btn.addEventListener(MouseEvent.CLICK,this.startOneTask);
         this.giveup_btn.addEventListener(MouseEvent.CLICK,this.giveupNowTask);
         this.complete_btn.addEventListener(MouseEvent.CLICK,this.getGift);
         this.gotoLevel_btn.addEventListener(MouseEvent.CLICK,this.gotoLevel);
      }
      
      public function fleshData() : *
      {
         if(this.cData.nowTask != null)
         {
            this.nowIndex = this.cData.nowTask.index;
         }
         this.showTask_byIndex(this.nowIndex);
      }
      
      public function labelClick(event:ClickEvent) : *
      {
         this.nowIndex = event.index;
         this.showTask_byIndex(this.nowIndex);
      }
      
      public function showTask_byIndex(index0:int, fleshGoodsB:Boolean = true) : *
      {
         this.nowIndex = index0;
         var td0:ChallengeTaskDefine = this.cData.getTrueTask_byIndex(this.nowIndex);
         var d0:LevelsDefine = Game.LG.filter.getBeforeLevel(td0.targetDiff,td0.targetLevel);
         var diff_str:String = td0.getDiffString();
         var page_str:String = d0.packName;
         var level_str:String = d0.name;
         this.taskName_txt.htmlText = "击杀" + td0.enemyName;
         var str0:String = "";
         str0 += "关卡：" + this.getFontColor(page_str + " > " + diff_str + " > " + level_str.replace(" ",""),"#00FFFF");
         var diff0:int = td0.targetDiff;
         var level0:int = td0.targetLevel;
         this.get_btn.alpha = 1;
         this.get_btn.mouseEnabled = true;
         if(!Game.gameData.isBeforeLevelUnlock(diff0,level0))
         {
            this.get_btn.alpha = 0.3;
            this.get_btn.mouseEnabled = false;
            str0 += this.getFontColor("（关卡未解锁）","#FF0000");
         }
         str0 += "\n任务：" + this.getFontColor("击杀“" + td0.enemyName + "” 1 只","#00FFFF");
         if(td0.state == "ing")
         {
            str0 += this.getFontColor("（进行中）","#FFFF00");
         }
         else if(td0.state == "complete")
         {
            str0 += this.getFontColor("（完成任务）","#FFFF00");
         }
         if(td0.getRequest() != "")
         {
            str0 += "\n要求：" + this.getFontColor(td0.getRequest(),"#FF66FF");
         }
         this.description_txt.htmlText = str0;
         var arr4:Array = Game.goodsDefineGroup.getArr_byStrArr(td0.getGiftArr(),Game.gameData.level,true);
         if(fleshGoodsB)
         {
            this.itemsBox.inData_byArr(arr4,true);
         }
         if(td0.state == "no")
         {
            this.showBtn("get");
         }
         else if(td0.state == "over")
         {
            this.showBtn("no");
         }
         else if(td0.state == "ing")
         {
            this.showBtn("giveup");
         }
         else if(td0.state == "complete")
         {
            this.showBtn("complete");
         }
         this.gotoLevel_btn.alpha = 1;
         this.gotoLevel_btn.mouseEnabled = true;
         this.list.inData_byArr(this.cData.arr);
         this.sBar.setTarget(this.list,false);
         if(td0.getNowB())
         {
            this.list.showLabel(index0,true);
         }
         else
         {
            this.list.showLabel(index0,false);
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
      
      private function getFontColor(str:String, _color1:String = "#999999") : String
      {
         return "<font color=\'" + _color1 + "\'>" + str + "</font>";
      }
      
      public function gotoLevel(e:* = null) : *
      {
         var page0:* = undefined;
         var td0:ChallengeTaskDefine = this.cData.nowTask;
         if(td0 != null)
         {
            td0 = td0.getNewDefine();
            page0 = td0.getPageName();
            Game.uiGroup.mainUI.taskUI.visible = false;
            Game.uiGroup.chooseLevelUI.gotoLevel(page0,td0.targetDiff % 4,td0.targetLevel);
         }
      }
      
      public function startOneTask(e:* = null) : *
      {
         var td0:ChallengeTaskDefine = this.cData.nowTask;
         if(td0 == null)
         {
            this.cData.startOneTask(this.nowIndex);
            this.fleshData();
            Game.SG.playSound("get_task");
         }
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
         this.cData.getGiftNowTask();
         this.fleshData();
         Game.uiGroup.infoUI.fleshData();
      }
      
      public function giveupNowTask(e:* = null) : *
      {
         Game.uiGroup.checkTip.showCheck("你确定要放弃吗？\n放弃之后今日将不能进行此任务了。",this.affterGiveupNowTask);
      }
      
      public function affterGiveupNowTask(e:* = null) : *
      {
         var td0:ChallengeTaskDefine = this.cData.nowTask;
         if(td0 != null)
         {
            this.cData.giveupNowTask();
            this.fleshData();
            Game.SG.playSound("giveUp_task");
         }
      }
   }
}

