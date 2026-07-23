package UI.arena
{
   import UI.ClickEvent;
   import UI.button.MoreStateButton;
   import UI.label.LabelBox;
   import UI.label.LabelCtrl;
   import UI.top.*;
   import com.adobe.serialization.json.JSON2;
   import com.adobe.test.json.JSON3;
   import data.StringToDefine;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.text.TextField;
   import gameAll.data.ArenaData;
   import gameAll.data.GameData;
   import gameAll.high.HighArena_All;
   import gameAll.high.HighDps_ExtraData;
   
   public class NewArenaUI extends Sprite
   {
      
      public var GD:GameData;
      
      public var label_arr:Array = ["high_arena","high_group","high","high_arms","high_car","high_player"];
      
      public var verticalLabel_arr:Array = [];
      
      public var nowLabel:String = "high";
      
      public var nowVerticalLabel:String = "top_dps";
      
      public var verticalLabel:LabelBox = new LabelBox();
      
      public var box:HighBox = new HighBox();
      
      public var arenaUI:ArenaUI = new ArenaUI();
      
      public var groupUI:Sprite;
      
      public var ranking_txt:TextField;
      
      public var tip:HighPlayerBox = new HighPlayerBox();
      
      public var labelCtrl:LabelCtrl = new LabelCtrl();
      
      public var arena_btn:SimpleButton;
      
      public var group_btn:SimpleButton;
      
      public var light_sp:Sprite;
      
      public function NewArenaUI()
      {
         super();
         this.init();
      }
      
      public function init() : *
      {
         this.GD = Game.gameData;
         this.labelCtrl.inData([this.arena_btn,this.group_btn],this.light_sp);
         this.labelCtrl.addEventListener(ClickEvent.ON_CLICK,this.newLabelClick);
         this.box.clickFun = this.btnClick;
         this.box.pageBox.maxPage = 4;
         this.box.setFace("newui/highTitleBar2","newui/highBar2",0,27,22,15);
         this.box.pageBox.y += 10;
         this.box.pageBox.x -= 10;
         this.box.x = 472;
         this.box.y = 63;
         this.groupUI.addChild(this.box);
         this.box.clickFun = this.btnClick;
         this.verticalLabel_arr = Game.gameDefine.high.verticalLabel_arr;
         this.verticalLabel.setLabelClass(MoreStateButton);
         this.groupUI.addChild(this.verticalLabel);
         this.verticalLabel.x = 329;
         this.verticalLabel.y = 58;
         this.verticalLabel.addEventListener(ClickEvent.ON_CLICK,this.verticalLabelClick);
         this.fleshVerticalLabel();
         this.groupUI.addChild(this.ranking_txt);
         addChild(this.arenaUI);
         this.arenaUI.mouseEnabled = false;
         this.mouseEnabled = false;
         addChild(this.tip);
         this.tip.visible = false;
         this.tip.x = 601;
         this.tip.y = 422;
      }
      
      public function fleshVerticalLabel() : *
      {
         this.verticalLabel.clear();
         this.verticalLabel_arr = Game.gameDefine.high.verticalLabel_arr2;
         this.verticalLabel.addLabel(this.verticalLabel_arr,45 * this.verticalLabel_arr.length,false,"group");
         this.nowVerticalLabel = this.verticalLabel.arr[0].text;
      }
      
      public function newLabelClick(e:*) : *
      {
         var label0:String = this.labelCtrl.nowLabel;
         this.showBox(label0);
      }
      
      public function panArena() : Boolean
      {
         return Game.gameData.level >= 24;
      }
      
      public function showBox(str0:*) : *
      {
         this.nowLabel = str0;
         this.labelCtrl.setChoose_byLabel(str0);
         this.groupUI.visible = false;
         this.arenaUI.visible = false;
         this.arenaUI.onlyGetTop = false;
         if(str0 == "group")
         {
            this.arenaUI.visible = false;
            this.groupUI.visible = true;
            this.showLabel(this.verticalLabel.nowLabel);
         }
         else if(str0 == "arena")
         {
            this.arenaUI.visible = true;
            this.arenaUI.fleshData();
            this.arenaUI.uploadScore();
         }
      }
      
      public function verticalLabelClick(event:ClickEvent) : *
      {
         this.showLabel(this.verticalLabel.nowLabel);
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
         else if(this.box.type == "top_defence")
         {
            obj0.score = Math.ceil(this.GD.maxDefence);
            obj0.extra = JSON2.encode(this.GD.getHighLife_ExtraData());
         }
         else if(this.box.type == "top_life")
         {
            obj0.score = Math.ceil(this.GD.maxLife);
            obj0.extra = JSON2.encode(this.GD.getHighLife_ExtraData());
         }
         else if(this.box.type == "top_level")
         {
            obj0.score = Math.ceil(this.GD.passData.plusAllStar());
            Game.testText.addTestText("所有星级：" + this.GD.passData.plusAllStar());
            obj0.extra = JSON2.encode(this.GD.getHighLife_ExtraData());
         }
         else if(this.box.type == "top_arms" || this.box.type == "top_sub")
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
         Game.high_api.submitScoreToRankLists([obj0],this.affter_uploadScore,this.noFun_uploadScore);
      }
      
      private function affter_uploadScore(tmpObj:Object) : *
      {
         this.getRankList(false);
      }
      
      public function noFun_uploadScore(errorShowB:Boolean = true) : *
      {
         if(errorShowB)
         {
         }
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
         this.box.setStyle("pk");
         if(this.box.nowPage == 0)
         {
            all_s = this.box.allScore;
            this.ranking_txt.htmlText = "战队总战斗力：" + StringToDefine.getFontColor(all_s + "","#FFFF00");
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
         var arenaData:ArenaData = null;
         var d0:HighArena_All = null;
         Game.testText.addTestText("--------------------------------");
         var str00:String = JSON3.encode(obj0);
         Game.testText.addTestText(str00);
         var gname0:String = Game.gameData.groupData.name;
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
            d0 = new HighArena_All();
            d0.inData_byObj(obj0);
            d0.rank = arenaData.nowRank;
            arenaData.arival = d0;
            Game.eventGroup.chosenLevel(0,"arena");
         }
      }
   }
}

