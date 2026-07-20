package UI.task
{
   import UI.ClickEvent;
   import UI.button.SountoScrollBar;
   import UI.explore.ExploreIconBox;
   import data.TextWay;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import gameAll.NormalMustDefine;
   import gameAll.data.GameData;
   import gameAll.data.collect.CollectTaskDefine;
   import gameAll.data.collect.WeekTaskData;
   import goods.GoodsDefine;
   
   public class WeekTaskUI extends Sprite
   {
      
      public var cData:WeekTaskData;
      
      public var nowIndex:int = 0;
      
      public var list:ChallengeLabelList = new ChallengeLabelList();
      
      public var description_txt:TextField;
      
      public var taskName_txt:TextField;
      
      public var taskNum_txt:TextField;
      
      public var itemsBox:ExploreIconBox = new ExploreIconBox();
      
      public var get_btn:SimpleButton;
      
      public var no_btn:*;
      
      public var complete_btn:SimpleButton;
      
      public var giveup_btn:SimpleButton;
      
      public var buy_btn:SimpleButton;
      
      public var sBar:SountoScrollBar;
      
      public var listCover:Sprite;
      
      public var taskUI:TaskUI;
      
      public function WeekTaskUI()
      {
         super();
      }
      
      public function init(_taskUI:*) : *
      {
         this.taskUI = _taskUI;
         this.cData = Game.gameData.weekTaskData;
         this.list.addEventListener(ClickEvent.ON_CLICK,this.labelClick);
         this.list.setLabelClass(ChallengeLabel);
         this.list.x = 185;
         this.list.y = 162;
         this.sBar.swapToTask();
         this.sBar.targetY = this.list.y;
         this.sBar.setHigh(240);
         this.sBar.setHigh(this.listCover.height);
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
         this.no_btn.txt.text = "该任务本周次数使用完毕";
         this.get_btn.addEventListener(MouseEvent.CLICK,this.startOneTask);
         this.giveup_btn.addEventListener(MouseEvent.CLICK,this.giveupNowTask);
         this.complete_btn.addEventListener(MouseEvent.CLICK,this.getGift);
         this.buy_btn.addEventListener(MouseEvent.CLICK,this.upUseNum);
      }
      
      public function fleshData() : *
      {
         this.fleshList();
         this.showTask_byIndex(this.list.arr[0].itemsData.index);
      }
      
      public function labelClick(event:ClickEvent) : *
      {
         this.nowIndex = event.goal.itemsData.index;
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
         str0 += "关卡：" + this.getFontColor("任意关卡","#00FFFF");
         str0 += "\n任务：" + this.getFontColor("杀死 " + td0.targetNum + " 个敌人再来找我！","#00FFFF");
         if(td0.state == "ing")
         {
            num00 = this.cData.nowNum;
            str0 += this.getFontColor("（已杀死" + num00 + "个）","#FFFF00");
         }
         else if(td0.state == "complete")
         {
            str0 += this.getFontColor("（完成任务）","#FFFF00");
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
         this.fleshList();
         this.sBar.setTarget(this.list,false);
      }
      
      public function fleshList() : *
      {
         var n:* = undefined;
         var cd0:CollectTaskDefine = null;
         var minLv0:int = 0;
         var maxLv0:int = 0;
         var h_lv0:int = 0;
         var list_arr0:Array = [];
         if(Boolean(this.cData.nowTask))
         {
            list_arr0.push(this.cData.nowTask);
         }
         else
         {
            for(n in this.cData.arr)
            {
               cd0 = this.cData.arr[n];
               minLv0 = int(cd0.targetItems.split("_")[1]) - 1;
               maxLv0 = int(cd0.targetItems.split("_")[2]) - 1;
               h_lv0 = Game.gameData.level;
               if(h_lv0 >= minLv0 && h_lv0 <= maxLv0)
               {
                  list_arr0.push(cd0);
               }
            }
         }
         this.list.inData_byArr(list_arr0);
         this.list.showState(0);
         if(!this.cData.buyB && this.list.arr[0].itemsData.state == "over")
         {
            this.buy_btn.mouseEnabled = true;
            this.buy_btn.alpha = 1;
         }
         else
         {
            this.buy_btn.mouseEnabled = false;
            this.buy_btn.alpha = 0.3;
         }
      }
      
      public function upUseNum(e:* = null) : *
      {
         var m0:Number = Number(TextWay.getText(Game.gameDefine.taskDefine.weekMustM));
         var nd0:NormalMustDefine = new NormalMustDefine();
         nd0.MCoin = m0;
         Game.uiGroup.checkTip.showMustCheck(nd0,"购买一次任务次数，需要：",this.affterUpUseNum);
      }
      
      public function affterUpUseNum(e:* = null) : *
      {
         var m0:Number = Number(TextWay.getText(Game.gameDefine.taskDefine.weekMustM));
         Game.payController.decMCoin(m0,this.affterUpUseNum2);
      }
      
      public function affterUpUseNum2(e:* = null) : *
      {
         Game.SG.playSound("useItems");
         this.cData.buyB = true;
         this.cData.newWeekCtrl();
         this.fleshData();
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
         var td0:CollectTaskDefine = this.cData.nowTask;
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
         var i:int = 0;
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
                  affixLevel0 = Game.gameData.level;
                  if(affixLevel0 < 0)
                  {
                     affixLevel0 = 0;
                  }
                  if(d0.id.indexOf("_chip") > 0)
                  {
                     for(i = 0; i < d0.num; i++)
                     {
                        trace("词缀等级：" + affixLevel0);
                        items0 = ig0.addItems(d0.id,1,affixLevel0);
                     }
                  }
                  else
                  {
                     items0 = ig0.addItems(d0.id,d0.num,affixLevel0);
                  }
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
         Game.uiGroup.saveDataNoUI();
      }
      
      public function giveupNowTask(e:* = null) : *
      {
         Game.uiGroup.checkTip.showCheck("你确定要放弃吗？\n放弃之后将清空之前杀死的怪物数量！",this.affterGiveupNowTask);
      }
      
      public function affterGiveupNowTask(e:* = null) : *
      {
         var td0:CollectTaskDefine = this.cData.nowTask;
         if(td0 != null)
         {
            this.cData.giveupNowTask();
            this.fleshData();
            Game.SG.playSound("giveUp_task");
         }
      }
   }
}

