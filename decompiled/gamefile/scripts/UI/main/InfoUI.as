package UI.main
{
   import UI.login.HeadBtn;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import gameAll.data.GameData;
   import gs.TweenLite;
   import gs.easing.Strong;
   
   public class InfoUI extends Sprite
   {
      
      public var level_txt:TextField;
      
      public var txt1:TextField;
      
      public var txt2:TextField;
      
      public var txt3:TextField;
      
      public var txt4:TextField;
      
      public var group_txt:TextField;
      
      public var tipBox:InfoTipBox;
      
      public var cover_mc:Sprite;
      
      public var addEffect_txt:TextField;
      
      public var life_btn:SimpleButton;
      
      public var attack_btn:SimpleButton;
      
      public var sub_btn:SimpleButton;
      
      public var defence_btn:SimpleButton;
      
      public var btn_arr:Array;
      
      public var rankArr:Array;
      
      public var head_btn:HeadBtn;
      
      public var name_btn:SimpleButton;
      
      public var rank_btn:SimpleButton;
      
      public var honor_btn:SimpleButton;
      
      public var gotoShop_btn:SimpleButton;
      
      public var pay_btn:SimpleButton;
      
      public var pk_btn:SimpleButton;
      
      public var getTop_btn:SimpleButton;
      
      public var random_btn:SimpleButton;
      
      public var top_txt:TextField;
      
      public function InfoUI()
      {
         var n:* = undefined;
         this.rankArr = ["group","groupScore","GCoin","MCoin","dps","lifeMax","defence","exp","achieve","lifeAdd","attackAdd","subAdd","defenceAdd"];
         super();
         this.pay_btn.addEventListener(MouseEvent.CLICK,this.toPay);
         this.gotoShop_btn.addEventListener(MouseEvent.CLICK,Game.uiGroup.gotoPropsShop);
         this.pk_btn.addEventListener(MouseEvent.CLICK,this.pkClick);
         this.mouseEnabled = false;
         this.addEffect_txt.visible = false;
         this.btn_arr = [this.life_btn,this.attack_btn,this.sub_btn,this.defence_btn];
         for(n in this.btn_arr)
         {
            this.btn_arr[n].addEventListener(MouseEvent.CLICK,this.btnClick);
         }
         this.cover_mc.addEventListener(MouseEvent.MOUSE_MOVE,this.MMove);
         this.cover_mc.addEventListener(MouseEvent.MOUSE_OUT,this.MOut);
         this.head_btn.addEventListener(MouseEvent.CLICK,this.btnClick2);
         this.head_btn.addEventListener(MouseEvent.ROLL_OVER,this.btnOver2);
         this.head_btn.addEventListener(MouseEvent.MOUSE_OUT,this.btnOut2);
         this.head_btn.addEventListener(MouseEvent.MOUSE_MOVE,this.btnMove2);
         this.name_btn.addEventListener(MouseEvent.CLICK,this.btnClick2);
         this.name_btn.addEventListener(MouseEvent.ROLL_OVER,this.btnOver2);
         this.name_btn.addEventListener(MouseEvent.MOUSE_OUT,this.btnOut2);
         this.name_btn.addEventListener(MouseEvent.MOUSE_MOVE,this.btnMove2);
         this.rank_btn.addEventListener(MouseEvent.CLICK,this.btnClick2);
         this.rank_btn.addEventListener(MouseEvent.ROLL_OVER,this.btnOver2);
         this.rank_btn.addEventListener(MouseEvent.MOUSE_OUT,this.btnOut2);
         this.rank_btn.addEventListener(MouseEvent.MOUSE_MOVE,this.btnMove2);
         this.honor_btn.addEventListener(MouseEvent.CLICK,this.btnClick2);
         this.honor_btn.addEventListener(MouseEvent.ROLL_OVER,this.btnOver2);
         this.honor_btn.addEventListener(MouseEvent.MOUSE_OUT,this.btnOut2);
         this.honor_btn.addEventListener(MouseEvent.MOUSE_MOVE,this.btnMove2);
         this.getTop_btn.addEventListener(MouseEvent.CLICK,this.getTopClick);
         this.random_btn.addEventListener(MouseEvent.CLICK,this.randomClick);
      }
      
      public function toPay(e:*) : *
      {
         Game.uiGroup.show("rank");
      }
      
      public function pkClick(event:MouseEvent) : *
      {
         trace("上传成绩");
         Game.uiGroup.highUI.showBox("high");
         Game.uiGroup.highUI.nowVerticalLabel = "top_dps";
         Game.uiGroup.show("high");
      }
      
      public function getTopClick(event:MouseEvent) : *
      {
         Game.uiGroup.newArenaUI.arenaUI.onlyGetTop = true;
         Game.uiGroup.newArenaUI.arenaUI.uploadScore();
      }
      
      public function randomClick(event:MouseEvent) : *
      {
         if(Game.gameData.arenaData.useNum > 0)
         {
            Game.uiGroup.newArenaUI.arenaUI.randomB = true;
            Game.uiGroup.newArenaUI.arenaUI.onlyGetTop = false;
            Game.uiGroup.show("main_arena");
         }
         else
         {
            Game.uiGroup.checkTip.showCheck2("天梯挑战次数已用完！",2);
         }
      }
      
      public function btnClick(event:MouseEvent) : *
      {
         var n:* = undefined;
         var btn:* = undefined;
         for(n in this.btn_arr)
         {
            btn = this.btn_arr[n];
            if(btn == event.target)
            {
               Game.uiGroup.gotoTrain(n + 3);
            }
         }
      }
      
      public function btnClick2(event:MouseEvent) : *
      {
         var name0:String = event.target.name;
         if(name0 == "name_btn")
         {
            if(Game.gameData.rankAdd.nameChangeNum > 0)
            {
               this.showChangeName();
            }
            else if(Game.gameData.MCoin < 5)
            {
               Game.uiGroup.checkTip.showCheck2("修改昵称需要5M币，\nM币不足，无法修改。",2);
            }
            else
            {
               Game.uiGroup.checkTip.showCheck2("修改昵称需要5M币，要继续吗？",1,this.showChangeName);
            }
         }
         else if(event.target is HeadBtn)
         {
            trace("修改头像！！");
            if(Game.gameData.MCoin < 10)
            {
               Game.uiGroup.checkTip.showCheck2("修改头像需要10M币，\nM币不足，无法修改。",2);
            }
            else
            {
               Game.uiGroup.checkTip.showCheck2("修改头像需要10M币，要继续吗？",1,this.showChangeHead);
            }
         }
         else if(name0 == "rank_btn")
         {
            Game.uiGroup.show("rank");
         }
         else if(name0 == "honor_btn")
         {
            Game.uiGroup.show("achievement");
            Game.uiGroup.mainUI.honorUI.showLabel("have");
         }
         else if(name0 == "arena_btn")
         {
            Game.uiGroup.show("arena");
         }
      }
      
      private function showChangeHead() : *
      {
         Game.uiGroup.loginUI.visible = true;
         Game.uiGroup.loginUI.showBox("head");
         trace("修改头像，需要消耗10M币。");
      }
      
      private function showChangeName() : *
      {
         Game.uiGroup.checkTip.showInputText("输入名称：",Game.gameData.playerName,this.affter_showChangeName);
         trace("修改名称");
      }
      
      private function affter_showChangeName() : *
      {
         if(Game.gameData.rankAdd.nameChangeNum > 0)
         {
            this.changeNameYes();
            --Game.gameData.rankAdd.nameChangeNum;
         }
         else
         {
            Game.payController.decMCoin(5,this.changeNameYes);
         }
      }
      
      public function changeNameYes() : *
      {
         Game.gameData.playerName = Game.sensitiveWords.encode(Game.uiGroup.checkTip.input_txt.text);
         this.fleshData();
      }
      
      public function changeHeadYes() : *
      {
      }
      
      public function btnOver2(event:MouseEvent) : *
      {
         var str00:String = null;
         var str1:* = undefined;
         var bag00:int = 0;
         var GD:GameData = Game.gameData;
         if(event.target == this.name_btn)
         {
            str00 = "点击修改名称\n需要消耗5M币";
            if(Game.gameData.rankAdd.nameChangeNum > 0)
            {
               str00 += "\n" + this.getColor("你有" + Game.gameData.rankAdd.nameChangeNum + "次免费修改的机会","#FFFF00");
            }
            this.tipBox.showText(str00);
         }
         else if(event.target == this.head_btn)
         {
            this.tipBox.showText("点击修改头像\n需要消耗10M币");
         }
         else if(event.target == this.rank_btn)
         {
            str1 = "军衔等级：" + (GD.rankLevel + 1) + "\n";
            bag00 = GD.rankAdd.bag;
            if(GD.rankLevel == 0)
            {
               bag00 = 0;
            }
            str1 += "背包数量增加：" + bag00 + "\n";
            str1 += "额外获取的经验倍数：" + GD.rankAdd.expTime * 100 + "%" + "\n";
            str1 += "金币获取提升：" + int(GD.rankAdd.coin * 100) + "%" + "\n";
            str1 += "体能训练加成：" + int(GD.rankAdd.lifeAdd * 100) + "%";
            str1 += "射击训练加成：" + int(GD.rankAdd.attackAdd * 100) + "%";
            this.tipBox.showText(str1);
         }
         else if(event.target == this.honor_btn)
         {
            this.tipBox.showText("点击进入称号界面");
         }
      }
      
      public function btnOut2(event:MouseEvent) : *
      {
         this.tipBox.hide();
      }
      
      public function btnMove2(event:MouseEvent) : *
      {
         this.tipBox.x = this.mouseX - 10 - this.tipBox.width;
         this.tipBox.y = this.mouseY + 10;
         if(this.tipBox.y > 460 - this.tipBox.height)
         {
            this.tipBox.y = 460 - this.tipBox.height;
         }
      }
      
      public function setAllBtnNo() : *
      {
         var n:* = undefined;
         for(n in this.btn_arr)
         {
            this.btn_arr[n].mouseEnabled = false;
            this.btn_arr[n].alpha = 0.4;
         }
         this.pay_btn.mouseEnabled = false;
         this.pay_btn.alpha = 0.4;
         this.gotoShop_btn.mouseEnabled = false;
         this.gotoShop_btn.alpha = 0.4;
         this.pk_btn.alpha = 0.4;
      }
      
      public function setAllBtnYes() : *
      {
         var n:* = undefined;
         for(n in this.btn_arr)
         {
            this.btn_arr[n].mouseEnabled = true;
            this.btn_arr[n].alpha = 1;
         }
         this.pay_btn.mouseEnabled = true;
         this.pay_btn.alpha = 1;
         this.gotoShop_btn.mouseEnabled = true;
         this.gotoShop_btn.alpha = 1;
         this.pk_btn.alpha = 1;
      }
      
      public function fleshTop() : *
      {
         var GD:GameData = null;
         GD = Game.gameData;
         if(GD.level < 24)
         {
            this.getTop_btn.visible = true;
            this.getTop_btn.alpha = 0.3;
            this.getTop_btn.mouseEnabled = false;
            this.random_btn.visible = false;
            this.top_txt.text = "等级不足";
         }
         else if(GD.arenaData.nowRank == 0)
         {
            this.getTop_btn.visible = true;
            this.getTop_btn.alpha = 1;
            this.getTop_btn.mouseEnabled = true;
            this.random_btn.visible = false;
            this.top_txt.text = "？？？";
         }
         else
         {
            this.getTop_btn.visible = false;
            this.random_btn.visible = true;
            this.top_txt.text = "第" + GD.arenaData.nowRank + "名";
         }
      }
      
      public function fleshData() : *
      {
         Game.uiGroup.allback.info.fleshData();
         var GD:GameData = Game.gameData;
         this.level_txt.text = "" + (GD.level + 1);
         this.group_txt.text = GD.groupData.name;
         this.fleshTop();
         var str1:String = "";
         str1 += GD.playerName + "\n";
         str1 += "军衔：" + GD.playerRank + "\n";
         if(Boolean(GD.honorData.getNowDefine()))
         {
            str1 += "称号：" + GD.honorData.getNowDefine().cnName;
         }
         else
         {
            str1 += "称号：无";
         }
         this.txt1.text = str1;
         this.head_btn.setText(GD.headLabel);
         var str4:String = "";
         str4 += String(GD.GCoin) + " G币\n";
         str4 += String(GD.MCoin) + " M币\n";
         var dps00:Number = GD.getAllDps();
         str4 += this.getColor(String(dps00),"#FFFF00");
         if(dps00 > 500000000)
         {
            Game.uiGroup.zuobile("dps大于50000w");
         }
         this.txt4.htmlText = str4;
         var str2:String = "";
         str2 += Math.floor(GD.nowLife) + "/" + Math.floor(GD.maxLife) + "\n";
         str2 += int(GD.maxDefence) + "\n";
         str2 += int(GD.nowExp) + "/" + int(GD.maxExp) + "\n";
         str2 += GD.allAchieve + "/" + Game.gameDefine.getAllAchieve(GD.rankLevel) + "\n";
         this.txt2.htmlText = str2;
         var str3:String = "";
         str3 += GD.playerData.lifeAdd.getPer() + GD.playerData.allAdd.getPer() + "%";
         if(GD.itemsAdd.lifeAdd > 0 || GD.itemsAdd.allAdd > 0 || GD.rankAdd.lifeAdd > 0)
         {
            str3 += this.getColor(" +" + this.getPer(GD.itemsAdd.lifeAdd + GD.itemsAdd.allAdd + GD.rankAdd.lifeAdd),"#FFFF00") + "\n";
         }
         else
         {
            str3 += "\n";
         }
         str3 += GD.playerData.attackAdd.getPer() + GD.playerData.allAdd.getPer() + "%";
         if(GD.itemsAdd.attackAdd > 0 || GD.itemsAdd.allAdd > 0 || GD.rankAdd.attackAdd > 0)
         {
            str3 += this.getColor(" +" + this.getPer(GD.itemsAdd.attackAdd + GD.itemsAdd.allAdd + GD.rankAdd.attackAdd),"#FFFF00") + "\n";
         }
         else
         {
            str3 += "\n";
         }
         str3 += GD.playerData.subAdd.getPer() + GD.playerData.allAdd.getPer() + "%";
         if(GD.itemsAdd.subAdd > 0 || GD.itemsAdd.allAdd > 0)
         {
            str3 += this.getColor(" +" + this.getPer(GD.itemsAdd.subAdd + GD.itemsAdd.allAdd),"#FFFF00") + "\n";
         }
         else
         {
            str3 += "\n";
         }
         str3 += GD.playerData.defenceAdd.getPer() + GD.playerData.allAdd.getPer() + "%";
         if(GD.itemsAdd.defenceAdd > 0 || GD.itemsAdd.allAdd > 0)
         {
            str3 += this.getColor(" +" + this.getPer(GD.itemsAdd.defenceAdd + GD.itemsAdd.allAdd),"#FFFF00") + "\n";
         }
         else
         {
            str3 += "\n";
         }
         this.txt3.htmlText = str3;
      }
      
      public function showAddEffect(str0:String, targetStr:String, color0:uint = 16776960, soundB:Boolean = true) : *
      {
         if(soundB)
         {
            Game.SG.playSound("useItems");
         }
         this.addEffect_txt.visible = true;
         this.addEffect_txt.textColor = color0;
         this.addEffect_txt.text = str0;
         this.addEffect_txt.y = 77 + this.getIndexInArr(targetStr) * (238 - 77) / 7;
         this.addEffect_txt.alpha = 1;
         this.addEffect_txt.scaleX = 1.3;
         this.addEffect_txt.scaleY = 1.3;
         TweenLite.to(this.addEffect_txt,0.5,{
            "alpha":0,
            "scaleX":1,
            "scaleY":1,
            "ease":Strong.easeIn
         });
      }
      
      private function getIndexInArr(str0:String) : int
      {
         var n:* = undefined;
         for(n in this.rankArr)
         {
            if(str0 == this.rankArr[n])
            {
               return n;
            }
         }
         return -10000;
      }
      
      private function MMove(event:MouseEvent) : *
      {
         var index0:int = int(event.target.mouseY / (int(191 - 168)));
         this.showTip(index0);
         this.tipBox.x = this.mouseX - 10 - this.tipBox.width;
         this.tipBox.y = this.mouseY + 10;
         if(this.tipBox.y > 400 - this.tipBox.height)
         {
            this.tipBox.y = 400 - this.tipBox.height;
         }
      }
      
      private function btnOver(event:MouseEvent) : *
      {
         var n:* = undefined;
         var btn:* = undefined;
         for(n in this.btn_arr)
         {
            btn = this.btn_arr[n];
            if(btn == event.target)
            {
               this.showTip(n + 6);
            }
         }
      }
      
      private function showTip(index0:int) : *
      {
         var GD:GameData = null;
         var str0:String = null;
         var str1:String = null;
         this.tipBox.hide();
         if(index0 < this.rankArr.length && index0 >= 0)
         {
            GD = Game.gameData;
            str0 = this.rankArr[index0];
            str1 = "";
            if(str0 == "group")
            {
               str1 = "";
               this.tipBox.showText(str1);
            }
            else if(str0 == "groupScore")
            {
               str1 = "你的竞技场排名";
               this.tipBox.showText(str1);
            }
            else if(str0 == "GCoin")
            {
               str1 = this.getColor("G币获取加成：" + int((GD.itemsAdd.coin + GD.rankAdd.coin) * 100) + "%","#FFFF00");
               this.tipBox.showText(str1);
            }
            else if(str0 == "MCoin")
            {
               str1 = this.getColor("通过充值获得M币\n1人民币=10M币","#FFFFFF");
               this.tipBox.showText(str1);
            }
            else if(str0 == "lifeMax")
            {
               str1 = "基础耐久：" + (int(GD.baseLife + GD.foreverLife));
               str1 += "\n车身耐久：" + int(GD.carLife);
               str1 += "\n军衔耐久加成：" + int(GD.rankAdd.lifeAdd * 100) + "%";
               str1 += "\n芯片耐久加成：" + int(GD.itemsAdd.life_max * 100) + "%";
               str1 += "\n" + this.getColor("耐久回复速度：" + int(GD.itemsAdd.life_rate) + " 点/秒","#FFFF00");
               this.tipBox.showText(str1);
            }
            else if(str0 == "defence")
            {
               str1 = "车身防御：" + (int(GD.carDefence + GD.foreverDefence));
               str1 += "\n芯片防御加成：" + int(GD.itemsAdd.defence_max) + "点";
               str1 += "\n" + this.getColor("伤害减免率：" + int(GD.defenceHurtRedu * 100) + "%","#FFFF00");
               this.tipBox.showText(str1);
            }
            else if(str0 == "exp")
            {
               str1 = this.getColor("经验获取加成：" + int(GD.itemsAdd.exp) + "点","#FFFF00");
               this.tipBox.showText(str1);
            }
            else if(str0 == "achieve")
            {
               str1 += this.getColor("功勋获取加成：" + int(GD.itemsAdd.achieve * 100) + "%","#FFFF00") + "\n";
               str1 += "击杀精英怪或者充值M币可获得\n功勋值，进而提升军衔。";
               this.tipBox.showText(str1);
            }
            else if(str0 == "lifeAdd")
            {
               this.tipBox.showText("提升耐久加成" + GD.playerData.lifeAdd.getPer() + "%");
            }
            else if(str0 == "attackAdd")
            {
               this.tipBox.showText("提升主武器攻击力加成" + GD.playerData.attackAdd.getPer() + "%");
            }
            else if(str0 == "subAdd")
            {
               this.tipBox.showText("提升副武器攻击力加成" + GD.playerData.subAdd.getPer() + "%");
            }
            else if(str0 == "defenceAdd")
            {
               this.tipBox.showText("提升防御加成" + GD.playerData.defenceAdd.getPer() + "%");
            }
         }
      }
      
      private function MOut(event:MouseEvent) : *
      {
         this.tipBox.hide();
      }
      
      private function getColor(str:String, _color1:String = "#999999") : String
      {
         return "<font color=\'" + _color1 + "\'>" + str + "</font>";
      }
      
      public function getPer(num0:Number) : String
      {
         return int(num0 * 100) + "%";
      }
   }
}

