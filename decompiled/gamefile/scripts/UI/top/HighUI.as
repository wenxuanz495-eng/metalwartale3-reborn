package UI.top
{
   import UI.ClickEvent;
   import UI.button.MoreStateButton;
   import UI.label.LabelBox;
   import UI.label.LabelCtrl;
   import com.adobe.serialization.json.JSON2;
   import data.StringToDefine;
   import flash.display.Sprite;
   import flash.text.TextField;
   import gameAll.data.ArenaData;
   import gameAll.data.GameData;
   import gameAll.high.HighArena_All;
   import gameAll.high.HighDps_ExtraData;
   
   public class HighUI extends Sprite
   {
      
      public var GD:GameData;
      
      public var label_arr:Array = ["high_arena","high_group","high","high_arms","high_car","high_player"];
      
      public var verticalLabel_arr:Array = [];
      
      public var nowLabel:String = "high";
      
      public var nowVerticalLabel:String = "top_dps";
      
      public var switchLabel:LabelBox = new LabelBox();
      
      public var verticalLabel:LabelBox = new LabelBox();
      
      public var box:HighBox = new HighBox();
      
      public var ranking_txt:TextField;
      
      public var score_txt:TextField;
      
      public var armsBox:HighArmsUI = new HighArmsUI();
      
      public var carBox:HighCarUI = new HighCarUI();
      
      public var playerBox:HighPlayerUI = new HighPlayerUI();
      
      public var tip:HighPlayerBox = new HighPlayerBox();
      
      public var l_mc:*;
      
      public var labelCtrl:LabelCtrl = new LabelCtrl();
      
      public function HighUI()
      {
         super();
         this.init();
      }
      
      public function init() : *
      {
         this.GD = Game.gameData;
         this.labelCtrl.inData([this.l_mc.top_dps_btn,this.l_mc.top_level_btn,this.l_mc.top_defence_btn,this.l_mc.top_life_btn,this.l_mc.top_arms_btn,this.l_mc.top_sub_btn,this.l_mc.high_car_btn,this.l_mc.high_arms_btn],this.l_mc.light_sp);
         this.labelCtrl.addEventListener(ClickEvent.ON_CLICK,this.newLabelClick);
         this.switchLabel.visible = false;
         this.verticalLabel.visible = false;
         this.box.setFace("newui/highTitleBar1","newui/highBar1",0,42,28);
         this.box.x = 304;
         this.box.y = 60;
         addChild(this.box);
         this.box.clickFun = this.btnClick;
         this.switchLabel.setLabelClass(MoreStateButton,false);
         this.switchLabel.addLabel(this.label_arr,116 * this.label_arr.length,true,"label");
         addChild(this.switchLabel);
         this.switchLabel.addEventListener(ClickEvent.ON_CLICK,this.switchLabelClick);
         this.switchLabel.x = 192 + 10;
         this.switchLabel.y = 8 + 6;
         this.verticalLabel_arr = Game.gameDefine.high.verticalLabel_arr;
         this.verticalLabel.setLabelClass(MoreStateButton);
         addChild(this.verticalLabel);
         this.verticalLabel.x = 219;
         this.verticalLabel.y = 100;
         this.verticalLabel.addEventListener(ClickEvent.ON_CLICK,this.verticalLabelClick);
         addChild(this.tip);
         this.tip.visible = false;
         this.tip.x = 601;
         this.tip.y = 422;
         addChild(this.armsBox);
         addChild(this.carBox);
         addChild(this.playerBox);
         this.fleshVerticalLabel();
      }
      
      public function fleshVerticalLabel() : *
      {
         this.verticalLabel.clear();
         this.verticalLabel_arr = Game.gameDefine.high.verticalLabel_arr;
         this.verticalLabel.addLabel(this.verticalLabel_arr,35 * this.verticalLabel_arr.length,false,"explore");
         this.verticalLabel.arr[this.verticalLabel.arr.length - 1].visible = false;
         this.nowVerticalLabel = this.verticalLabel.arr[0].text;
      }
      
      public function switchLabelClick(e:*) : *
      {
         var label0:String = this.label_arr[e.index];
         if(label0 == "high_arena")
         {
            if(this.panArena())
            {
               this.showBox(label0);
            }
            else
            {
               Game.uiGroup.checkTip.showCheck2("只有25级的玩家才能进入竞技场。",2);
            }
         }
         else
         {
            this.showBox(label0);
         }
      }
      
      public function newLabelClick(e:*) : *
      {
         var label0:String = this.labelCtrl.nowLabel;
         if(label0.indexOf("high_") == 0)
         {
            this.showBox(label0);
         }
         else
         {
            this.showBox("high");
            this.showLabel(label0);
         }
      }
      
      public function panArena() : Boolean
      {
         return Game.gameData.level >= 24;
      }
      
      public function showBox(str0:*) : *
      {
         this.nowLabel = str0;
         this.switchLabel.showLabel_byLabel(str0);
         this.verticalLabel.visible = false;
         this.carBox.visible = false;
         this.playerBox.visible = false;
         this.armsBox.visible = false;
         this.box.visible = false;
         if(str0 == "high" || str0 == "high_group")
         {
            this.box.visible = true;
         }
         else if(str0 == "high_car")
         {
            this.carBox.visible = true;
         }
         else if(str0 == "high_player")
         {
            this.playerBox.visible = true;
         }
         else if(str0 == "high_arms")
         {
            this.armsBox.visible = true;
         }
      }
      
      public function verticalLabelClick(event:ClickEvent) : *
      {
         this.showLabel(this.verticalLabel.nowLabel);
      }
      
      public function openFlesh() : *
      {
         this.showLabel(this.nowVerticalLabel);
      }
      
      public function showLabel(str0:String) : *
      {
         this.nowVerticalLabel = str0;
         this.verticalLabel.showLabel_byLabel(str0);
         this.box.nowPage = 0;
         this.box.pageBox.fleshByTable(false);
         if(str0 == "top_pay")
         {
            Game.testText.addTestText("获取排行榜");
            this.getRankList(true);
         }
         else
         {
            this.uploadScore();
         }
      }
      
      private function uploadScore(e:* = null) : *
      {
         var ed0:HighDps_ExtraData = null;
         var group_name0:String = null;
         var extra0:Object = null;
         if(Game.gameData.username.indexOf("chj2test") >= 0)
         {
            return;
         }
         Game.uiGroup.loadingUI.show();
         this.box.type = this.nowVerticalLabel;
         this.box.fleshBaseData_byType();
         var obj0:Object = new Object();
         obj0.rId = this.box.id;
         obj0.score = 101;
         obj0.extra = JSON2.encode("");
         if(this.box.type == "top_dps")
         {
            obj0.score = Math.ceil(this.GD.getAllDps());
            ed0 = this.GD.getHighDps_ExtraData();
            obj0.extra = JSON2.encode(ed0);
            if(ed0.isZuobi(obj0.score))
            {
            }
            if(obj0.score > 100000000)
            {
               this.noFun_uploadScore(false);
               return;
            }
         }
         else if(this.box.type.indexOf("top_group") >= 0)
         {
            group_name0 = Game.gameDefine.high.verticalLabel_cn_arr2[this.verticalLabel.nowIndex];
            trace("目标战队：" + group_name0 + "  玩家战队：" + this.GD.groupData.name);
            if(this.GD.groupData.name.indexOf(group_name0) != 0)
            {
               this.noFun_uploadScore(false);
               return;
            }
            obj0.score = Math.ceil(this.GD.getAllDps());
            if(obj0.score <= 0)
            {
               obj0.score = 1;
            }
            obj0.extra = JSON2.encode(Game.gameData.getHighArena_ExtraData());
         }
         else
         {
            if(this.box.type == "top_defence")
            {
               return;
            }
            if(this.box.type == "top_life")
            {
               return;
            }
            if(this.box.type == "top_level")
            {
               return;
            }
            if(this.box.type == "top_arms" || this.box.type == "top_sub")
            {
               extra0 = this.GD.getNiubiArms(this.box.type);
               if(!Boolean(extra0))
               {
                  this.noFun_uploadScore(false);
                  return;
               }
               obj0.score = Math.ceil(extra0.dps);
               obj0.extra = JSON2.encode(extra0);
            }
            else if(this.box.type == "top_pay")
            {
            }
         }
         Game.high_api.submitScoreToRankLists([obj0],this.affter_uploadScore,this.noFun_uploadScore);
      }
      
      private function affter_uploadScore(tmpObj:Object) : *
      {
         this.score_txt.htmlText = "当前排名：" + StringToDefine.getFontColor(tmpObj.curRank,"#FFFF00");
         this.ranking_txt.htmlText = "当前成绩：" + StringToDefine.getFontColor(tmpObj.curScore,"#FFFF00");
         this.getRankList(false);
      }
      
      public function noFun_uploadScore(errorShowB:Boolean = true) : *
      {
         if(errorShowB)
         {
         }
         this.score_txt.htmlText = "当前排名：" + StringToDefine.getFontColor("？？？","#FFFF00");
         this.ranking_txt.htmlText = "当前成绩：" + StringToDefine.getFontColor("？？？","#FFFF00");
         this.getRankList(false);
      }
      
      public function uploadScorePay() : *
      {
         var obj0:Object = new Object();
         obj0.rId = Game.gameDefine.high.getAllObj("top_pay",Game.nowSaveIndex).id;
         obj0.extra = JSON2.encode("");
         obj0.score = Math.ceil(Game.payController2.getTrueTotalRecharged());
         obj0.extra = JSON2.encode(this.GD.getHighLife_ExtraData());
         if(obj0.score <= 10000000)
         {
            if(obj0.score > 0)
            {
               Game.uiGroup.loadingUI.show("上传排行榜成绩");
               Game.testText.addTestText("上传排行榜成绩:" + obj0.extra);
               Game.high_api.submitScoreToRankLists([obj0],this.affter_uploadScorePay,this.affter_uploadScorePay);
            }
         }
      }
      
      private function affter_uploadScorePay(tmpObj:* = null) : *
      {
         Game.uiGroup.loadingUI.hide();
      }
      
      public function getRankList(showLoadingB:Boolean = true) : *
      {
         if(showLoadingB)
         {
            Game.uiGroup.loadingUI.show();
         }
         this.box.type = this.nowVerticalLabel;
         this.box.fleshBaseData_byType();
         Game.testText.addTestText("获取排行榜，id：" + this.box.id);
         Game.high_api.getRankListsData(this.box.id,this.box.bar_arr.length,this.box.nowPage + 1,this.affter_getRankList,this.noFun);
      }
      
      private function affter_getRankList(dataAry:Array) : *
      {
         var all_s:Number = NaN;
         Game.uiGroup.loadingUI.hide();
         this.box.data_arr = dataAry;
         this.box.fleshData();
         if(this.nowLabel == "high_group")
         {
            this.box.setStyle("pk");
            if(this.box.nowPage == 0)
            {
               all_s = this.box.allScore;
               this.ranking_txt.htmlText = "战队总战斗力：" + StringToDefine.getFontColor(all_s + "","#FFFF00");
            }
         }
         else
         {
            this.box.setStyle("");
         }
      }
      
      public function noFun() : *
      {
         Game.uiGroup.loadingUI.hide();
      }
      
      public function hide(e:*) : *
      {
         Game.uiGroup.menu.show("main");
      }
      
      public function btnClick(obj0:Object) : *
      {
         var gname0:String = null;
         var arenaData:ArenaData = null;
         var d0:HighArena_All = null;
         if(this.nowLabel == "high_group")
         {
            gname0 = Game.gameData.groupData.name;
            if(gname0 == "" || gname0 == "无")
            {
               Game.uiGroup.checkTip.showCheck2("加入战队的玩家才能挑战此排行榜的对手。",2);
            }
            else if(Game.gameData.username == obj0.userName)
            {
               Game.uiGroup.checkTip.showCheck2("不能挑战自己。",2);
            }
            else if(Game.gameData.level < 24)
            {
               Game.uiGroup.checkTip.showCheck2("你的等级必须超过25级才能继续挑战。",2);
            }
            else if(Boolean(obj0))
            {
               Game.testText.addTestText("PK单位:" + obj0.userName);
               arenaData = Game.gameData.arenaData;
               if(arenaData.useNum > 0)
               {
                  d0 = new HighArena_All();
                  d0.inData_byObj(obj0);
                  d0.rank = arenaData.nowRank;
                  arenaData.arival = d0;
                  Game.eventGroup.chosenLevel(0,"arena");
               }
               else
               {
                  Game.uiGroup.checkTip.showCheck2("您的挑战次数已经使用完毕！",2);
               }
            }
         }
      }
   }
}

