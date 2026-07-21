package UI.arena
{
   import UI.ClickEvent;
   import UI.login.HeadBtn;
   import UI.top.HighPlayerBox;
   import com.adobe.serialization.json.JSON2;
   import data.TextWay;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.getTimer;
   import gameAll.data.ArenaData;
   import gameAll.data.GameData;
   import gameAll.define.other.Normal_HighDefine;
   import gameAll.high.HighArena_All;
   import gameAll.high.HighArena_ExtraData;
   
   public class ArenaUI extends Sprite
   {
      
      public var head_btn:HeadBtn = new HeadBtn();
      
      public var arenaData:ArenaData;
      
      public var bar_arr:Array = [];
      
      public var name_txt:TextField;
      
      public var dps_txt:TextField;
      
      public var level_txt:TextField;
      
      public var other_txt:TextField;
      
      public var other2_txt:TextField;
      
      public var high_txt:TextField;
      
      public var num_txt:TextField;
      
      public var score_txt:TextField;
      
      public var addNum_btn:SimpleButton;
      
      public var auto_btn:SimpleButton;
      
      public var noAuto_btn:SimpleButton;
      
      public var highDefine:Normal_HighDefine;
      
      public var highBox:Normal_HighBox;
      
      public var mustM0:String = "";
      
      public var onlyGetTop:Boolean = false;
      
      public var randomB:Boolean = false;
      
      private var arenaNum:int = 15;

      private var localOpponents:Array = [];

      private var lastCooldownFlesh:int = 0;
      
      public function ArenaUI()
      {
         super();
         this.arenaData = Game.gameData.arenaData;
         this.addTenArival();
         this.highBox = new Normal_HighBox(ArenaHighBar,this.arenaNum);
         addChild(this.highBox);
         this.highBox.x = 623;
         this.highBox.y = 97;
         this.highDefine = Game.gameDefine.high.getDefine_byType("top_arena");
         this.highBox.define = this.highDefine;
         this.highBox.pageBox.visible = false;
         this.highBox.pageBox.maxPage = 1;
         // Do NOT generate local opponents during UI construction.
         // At boot time the player may have no equipped car yet; that used to freeze loading at "音效数据 100%".
         this.localOpponents = [];
         this.highBox.data_arr = [];
         this.addNum_btn.addEventListener(MouseEvent.CLICK,this.addNumFun);
         this.mustM0 = TextWay.toCode("10");
         this.highBox.addEventListener(ClickEvent.ON_OVER,this.barOver);
         this.highBox.addEventListener(ClickEvent.ON_OUT,this.barOut);
         this.highBox.addEventListener(ClickEvent.ON_MOVE,this.barMove);
         this.highBox.addEventListener(ClickEvent.ON_CLICK,this.barClick2);
         this.auto_btn.addEventListener(MouseEvent.CLICK,this.autoClick);
         this.noAuto_btn.addEventListener(MouseEvent.CLICK,this.noAutoClick);
         addChild(this.head_btn);
         this.head_btn.x = 198;
         this.head_btn.y = 55;
         this.addEventListener(Event.ENTER_FRAME,this.cooldownTimer);
      }

      private function refreshLocalOpponents() : *
      {
         this.localOpponents = this.arenaData.getLocalOpponents();
         this.highBox.data_arr = this.localOpponents;
         this.fleshOpponentStates();
      }

      private function getQuickOpponents() : Array
      {
         var available:Array = [];
         var cooling:Array = [];
         var obj0:Object = null;
         for each(obj0 in this.localOpponents)
         {
            if(this.arenaData.getBotCooldown(String(obj0.userName)) > 0)
            {
               cooling.push(obj0);
            }
            else
            {
               available.push(obj0);
            }
         }
         available = available.concat(cooling);
         if(available.length > 10)
         {
            available.splice(10,available.length - 10);
         }
         return available;
      }

      private function cooldownText(remain:Number) : String
      {
         var seconds:int = Math.ceil(remain / 1000);
         var minutes:int = int(seconds / 60);
         seconds %= 60;
         return "冷却 " + minutes + ":" + (seconds < 10 ? "0" : "") + seconds;
      }

      private function fleshOpponentStates() : *
      {
         if(this.localOpponents == null)
         {
            this.localOpponents = [];
         }
         var n:* = undefined;
         var bar0:ArenArivalBar = null;
         var highBar:ArenaHighBar = null;
         var obj0:Object = null;
         var remain:Number = NaN;
         this.highBox.fleshData();
         this.setBarData(this.getQuickOpponents());
         for(n in this.bar_arr)
         {
            bar0 = this.bar_arr[n];
            obj0 = bar0.itemsData;
            remain = obj0 == null ? 0 : this.arenaData.getBotCooldown(String(obj0.userName));
            bar0._btn.mouseEnabled = this.arenaData.useNum > 0 && remain <= 0;
            bar0._btn.alpha = bar0._btn.mouseEnabled ? 1 : 0.35;
            if(remain > 0)
            {
               bar0._txt.text = this.cooldownText(remain);
            }
         }
         for(n in this.highBox.bar_arr)
         {
            highBar = this.highBox.bar_arr[n];
            obj0 = this.highBox.data_arr[n];
            remain = obj0 == null ? 0 : this.arenaData.getBotCooldown(String(obj0.userName));
            highBar._btn.mouseEnabled = this.arenaData.useNum > 0 && remain <= 0;
            highBar._btn.alpha = highBar._btn.mouseEnabled ? 1 : 0.35;
            if(remain > 0 && highBar.t4 != null)
            {
               highBar.t4.text = this.cooldownText(remain);
            }
         }
      }

      private function cooldownTimer(event:Event) : *
      {
         if(!this.visible || getTimer() - this.lastCooldownFlesh < 1000)
         {
            return;
         }
         this.lastCooldownFlesh = getTimer();
         this.fleshOpponentStates();
      }
      
      public function addNumFun(e:*) : *
      {
         if(this.arenaData.buyNum >= 5)
         {
            Game.uiGroup.checkTip.showCheck2("今日购买次数已经用完,请明天再来挑战",2);
            return;
         }
         Game.uiGroup.checkTip.showCheck2("你要花费 10 M币获得额外3次挑战机会吗？",1,this.yes_addNumFun);
      }
      
      private function yes_addNumFun() : *
      {
         if(Game.gameData.MCoin < 10)
         {
            Game.uiGroup.checkTip.showCheck2("您的M币不足！",2);
         }
         else
         {
            Game.payController.decMCoin(int(TextWay.getText(this.mustM0)),this.yes_addNum);
         }
      }
      
      private function yes_addNum() : *
      {
         this.arenaData.addUseNum();
         this.fleshData();
      }
      
      public function getTest() : Array
      {
         var d0:HighArena_All = null;
         var arr0:Array = [];
         for(var i:int = 0; i < this.highBox.bar_arr.length; i++)
         {
            d0 = new HighArena_All();
            d0.rank = i + 1;
            d0.score = 2000 - i * 100;
            d0.userName = "sountoone";
            d0.extra = new HighArena_ExtraData();
            arr0.push(d0.getObj());
         }
         return arr0;
      }
      
      private function addTenArival() : *
      {
         var bar0:ArenArivalBar = null;
         for(var i:int = 0; i < 10; i++)
         {
            bar0 = new ArenArivalBar();
            bar0.addEventListener(ClickEvent.ON_CLICK,this.barClick);
            this.bar_arr.push(bar0);
            bar0.x = 197 + (527 - 445) * (i % 5);
            bar0.y = 248 + (348 - 233) * int(i / 5);
            addChild(bar0);
         }
      }
      
      public function addMouseOverOut(fun1:Function, fun2:Function) : *
      {
         var n:* = undefined;
         var bar0:ArenArivalBar = null;
         for(n in this.bar_arr)
         {
            bar0 = this.bar_arr[n];
            bar0.addEventListener(ClickEvent.ON_OVER,fun1);
            bar0.addEventListener(ClickEvent.ON_OUT,fun2);
         }
      }
      
      public function fleshData() : *
      {
         var GD:GameData = Game.gameData;
         this.refreshLocalOpponents();
         this.name_txt.text = GD.playerName;
         this.dps_txt.text = "战斗力：" + Math.round(GD.getAllDps());
         this.level_txt.text = "LV." + (GD.level + 1);
         GD.arenaData.nickname + "\n" + (GD.level + 1) + "级";
         var base_str0:String = "";
         base_str0 += "军衔 " + GD.playerRank + "\n";
         base_str0 += "称号 " + GD.honorData.getNowHonorName() + "\n";
         base_str0 += "阵营 " + "无" + "\n";
         base_str0 += "战斗 " + GD.groupData.name;
         this.other_txt.htmlText = base_str0;
         var num_str0:String = "";
         num_str0 += "积分 " + GD.arenaData.score + "\n";
         num_str0 += "连胜 " + GD.arenaData.streakNum + "场\n";
         num_str0 += "耐久 " + Math.floor(GD.nowLife) + "/" + Math.floor(GD.maxLife) + "\n";
         num_str0 += "防御 " + int(GD.maxDefence);
         this.other2_txt.htmlText = num_str0;
         this.num_txt.text = GD.arenaData.useNum + "";
         if(GD.arenaData.useNum > 0)
         {
            this.setBtnState(0);
         }
         else
         {
            this.setBtnState(1);
         }
         this.fleshAuto();
      }
      
      public function fleshAuto() : *
      {
         var GD:GameData = Game.gameData;
         this.auto_btn.visible = false;
         this.noAuto_btn.visible = false;
         if(GD.vipData.nowVip != "")
         {
            if(this.arenaData.autoFightingB)
            {
               this.noAuto_btn.visible = true;
            }
            else
            {
               this.auto_btn.visible = true;
               this.auto_btn.mouseEnabled = true;
               this.auto_btn.alpha = 1;
            }
         }
         else
         {
            this.auto_btn.visible = true;
            this.auto_btn.mouseEnabled = false;
            this.auto_btn.alpha = 0.4;
         }
      }
      
      public function setBarData(arr0:Array) : *
      {
         var n:* = undefined;
         var d0:HighArena_All = null;
         var bar0:ArenArivalBar = null;
         for(n in arr0)
         {
            d0 = new HighArena_All();
            d0.inData_byObj(arr0[n]);
            bar0 = this.bar_arr[n];
            if(Boolean(bar0))
            {
               bar0.inData_byObject(d0);
            }
         }
      }
      
      public function setBtnState(num0:int) : *
      {
         var n:* = undefined;
         var bar0:ArenArivalBar = null;
         for(n in this.bar_arr)
         {
            bar0 = this.bar_arr[n];
            if(num0 == 0 && bar0.itemsData != null && this.arenaData.getBotCooldown(String(bar0.itemsData.userName)) <= 0)
            {
               bar0._btn.mouseEnabled = true;
               bar0._btn.alpha = 1;
            }
            else
            {
               bar0._btn.mouseEnabled = false;
               bar0._btn.alpha = 0.3;
            }
         }
      }
      
      private function autoClick(event:*) : *
      {
         this.arenaData.autoFightingB = true;
         this.fleshAuto();
      }
      
      private function noAutoClick(event:*) : *
      {
         this.arenaData.autoFightingB = false;
         this.fleshAuto();
      }
      
      private function barClick(event:ClickEvent) : *
      {
         this.startLocalChallenge(event.target.itemsData);
      }
      
      private function gotoRandomBar() : *
      {
         var available:Array = [];
         var obj0:Object = null;
         for each(obj0 in this.localOpponents)
         {
            if(this.arenaData.getBotCooldown(String(obj0.userName)) <= 0)
            {
               available.push(obj0);
            }
         }
         if(available.length == 0)
         {
            Game.uiGroup.checkTip.showCheck2("当前所有竞技场对手都在冷却中。",2);
            return;
         }
         this.startLocalChallenge(available[int(available.length * Math.random())]);
      }

      private function startLocalChallenge(obj0:*) : *
      {
         var d0:HighArena_All = null;
         if(this.arenaData.useNum <= 0)
         {
            Game.uiGroup.checkTip.showCheck2("今日竞技场挑战次数已经用完。",2);
            return;
         }
         if(obj0 == null)
         {
            return;
         }
         d0 = obj0 is HighArena_All ? obj0 : new HighArena_All();
         if(!(obj0 is HighArena_All))
         {
            d0.inData_byObj(obj0);
         }
         if(this.arenaData.getBotCooldown(d0.userName) > 0)
         {
            Game.uiGroup.checkTip.showCheck2("该竞技场对手正在冷却中。",2);
            this.fleshOpponentStates();
            return;
         }
         this.arenaData.arival = d0;
         Game.eventGroup.chosenLevel(0,"arena");
      }
      
      public function uploadScore(e:* = null) : *
      {
         this.refreshLocalOpponents();
         this.high_txt.text = "本地";
         this.arenaData.nowRank = 0;
         Game.uiGroup.loadingUI.hide();
         if(this.randomB)
         {
            this.randomB = false;
            this.gotoRandomBar();
         }
      }
      
      private function affter_uploadScore(tmpObj:Object) : *
      {
         this.uploadScore();
         return;
         this.high_txt.text = tmpObj.curRank;
         var id0:int = int(this.highDefine.id_arr[Game.nowSaveIndex]);
         this.arenaData.nowRank = tmpObj.curRank;
         trace("输入排名：" + this.arenaData.nowRank);
         Game.uiGroup.infoUI.fleshTop();
         if(!this.onlyGetTop)
         {
            if(tmpObj.curRank > 9989)
            {
               Game.high_api.getRankListsData(id0,11,905,this.affter_getRankLists);
            }
            else
            {
               Game.high_api.getRankListByOwn(id0,Game.nowSaveIndex,11,this.affter_getRankLists);
            }
         }
         else
         {
            this.onlyGetTop = false;
            Game.uiGroup.loadingUI.hide();
         }
      }
      
      private function noFun_uploadScore(errorShowB:Boolean = true) : *
      {
         Game.uiGroup.loadingUI.hide();
         this.randomB = false;
      }
      
      private function affter_getRankLists(dataAry:Array) : *
      {
         this.refreshLocalOpponents();
         Game.uiGroup.loadingUI.hide();
         return;
         var n:* = undefined;
         var obj0:* = undefined;
         for(n in dataAry)
         {
            obj0 = dataAry[n];
            if(obj0.userName == Game.gameData.username)
            {
               dataAry.splice(n,1);
               break;
            }
         }
         if(dataAry.length > 10)
         {
            dataAry.splice(10,1000);
         }
         this.setBarData(dataAry);
         this.highBox.getRankList(false);
         Game.testText.addTestText("randomB:" + this.randomB);
         if(this.randomB)
         {
            this.randomB = false;
            this.gotoRandomBar();
         }
      }
      
      public function barOut(event:ClickEvent) : *
      {
         var tip0:HighPlayerBox = Game.uiGroup.highUI.tip;
         tip0.visible = false;
      }
      
      public function barOver(event:ClickEvent) : *
      {
         var index0:int = event.index;
         var tip0:HighPlayerBox = Game.uiGroup.highUI.tip;
         tip0.visible = true;
         var d0:* = JSON2.decode(this.highBox.data_arr[index0].extra);
         if(Boolean(d0.hasOwnProperty("head")))
         {
            tip0.flesh_byArena(d0);
         }
         this.barMove();
      }
      
      public function barMove(e:* = null) : *
      {
         var tip0:HighPlayerBox = Game.uiGroup.highUI.tip;
         var x0:* = Game.gameSprite.mouseX - 80;
         if(x0 < 300)
         {
            x0 = 300;
         }
         tip0.x = x0;
         tip0.y = Game.gameSprite.mouseY + 50;
      }
      
      public function barClick2(e:ClickEvent) : *
      {
         this.startLocalChallenge(this.highBox.data_arr[e.goal.index]);
         return;
         var d0:HighArena_All = null;
         if(this.arenaData.useNum > 0)
         {
            trace("e.goal.index:" + e.goal.index);
            d0 = new HighArena_All();
            d0.inData_byObj(this.highBox.data_arr[e.goal.index]);
            this.arenaData.arival = d0;
            Game.eventGroup.chosenLevel(0,"arena");
         }
         else
         {
            Game.uiGroup.checkTip.showCheck2("您的挑战次数已经使用完毕！",2);
         }
      }
   }
}

