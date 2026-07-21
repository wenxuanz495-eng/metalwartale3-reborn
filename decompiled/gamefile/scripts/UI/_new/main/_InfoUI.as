package UI._new.main
{
   import UI.login.HeadBtn;
   import UI.main.InfoTipBox;
   import UI.main.InfoUI;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import gameAll.data.GameData;
   
   public class _InfoUI extends Sprite
   {
      
      public var GD:GameData;
      
      public var IsShow:Boolean = false;
      
      public var head_btn:HeadBtn;
      
      public var name_btn:SimpleButton;
      
      public var rank_btn:SimpleButton;
      
      public var arena_btn:SimpleButton;
      
      public var honor_btn:SimpleButton;
      
      public var level_txt:TextField;
      
      public var playerName_txt:TextField;
      
      public var baseInfo_txt:TextField;
      
      public var dps_txt:TextField;
      
      public var numInfo_txt:TextField;
      
      public var arena_txt:TextField;
      
      public var trainInfo_txt:TextField;
      
      public var Gcoin_txt:TextField;
      
      public var Mcoin_txt:TextField;
      
      public var pay_btn:SimpleButton;
      
      public var Gcoin_txt_arr:Array;
      
      public var Mcoin_txt_arr:Array;
      
      public var arena_txt_info:Array;
      
      public var baseInfo_txt_info:Array;
      
      public var numInfo_txt_info:Array;
      
      public var trainInfo_txt_info:Array;
      
      public var life_btn:SimpleButton;
      
      public var attack_btn:SimpleButton;
      
      public var sub_btn:SimpleButton;
      
      public var defence_btn:SimpleButton;
      
      public var btn_arr:Array;
      
      public var infoTip:InfoTipBox;
      
      public var info_mc:InfoUI;
      
      public function _InfoUI()
      {
         var n:* = undefined;
         var txt_arr0:Array = null;
         this.head_btn = new HeadBtn();
         this.Gcoin_txt_arr = ["Gcoin"];
         this.Mcoin_txt_arr = ["Mcoin"];
         this.arena_txt_info = ["dps"];
         this.baseInfo_txt_info = ["rank","honor","camp","group"];
         this.numInfo_txt_info = ["exp","achieve","life","defence"];
         this.trainInfo_txt_info = ["attackAdd","subAdd","lifeAdd","defenceAdd"];
         this.info_mc = new InfoUI();
         super();
         this.mouseEnabled = false;
         this.GD = Game.gameData;
         this.btn_arr = [this.life_btn,this.attack_btn,this.sub_btn,this.defence_btn];
         for(n in this.btn_arr)
         {
            this.btn_arr[n].addEventListener(MouseEvent.CLICK,this.trainBtnClick);
         }
         txt_arr0 = [this.Gcoin_txt,this.Mcoin_txt,this.playerName_txt,this.baseInfo_txt,this.dps_txt,this.numInfo_txt,this.arena_txt,this.trainInfo_txt,this.Gcoin_txt,this.Mcoin_txt];
         for(n in txt_arr0)
         {
            txt_arr0[n].addEventListener(MouseEvent.MOUSE_OVER,this.mouseOver);
            txt_arr0[n].addEventListener(MouseEvent.MOUSE_OUT,this.mouseOut);
            txt_arr0[n].addEventListener(MouseEvent.MOUSE_MOVE,this.mouseMove);
         }
         addChild(this.head_btn);
         this.head_btn.x = 17;
         this.head_btn.y = 43;
         this.pay_btn.addEventListener(MouseEvent.CLICK,this.gotoPay);
         this.head_btn.addEventListener(MouseEvent.CLICK,this.info_mc.btnClick2);
         this.head_btn.addEventListener(MouseEvent.ROLL_OVER,this.btnOver2);
         this.head_btn.addEventListener(MouseEvent.MOUSE_OUT,this.btnOut2);
         this.head_btn.addEventListener(MouseEvent.MOUSE_MOVE,this.btnMove2);
         this.name_btn.addEventListener(MouseEvent.CLICK,this.info_mc.btnClick2);
         this.name_btn.addEventListener(MouseEvent.ROLL_OVER,this.btnOver2);
         this.name_btn.addEventListener(MouseEvent.MOUSE_OUT,this.btnOut2);
         this.name_btn.addEventListener(MouseEvent.MOUSE_MOVE,this.btnMove2);
         this.rank_btn.addEventListener(MouseEvent.CLICK,this.info_mc.btnClick2);
         this.rank_btn.addEventListener(MouseEvent.ROLL_OVER,this.btnOver2);
         this.rank_btn.addEventListener(MouseEvent.MOUSE_OUT,this.btnOut2);
         this.rank_btn.addEventListener(MouseEvent.MOUSE_MOVE,this.btnMove2);
         this.honor_btn.addEventListener(MouseEvent.CLICK,this.info_mc.btnClick2);
         this.honor_btn.addEventListener(MouseEvent.ROLL_OVER,this.btnOver2);
         this.honor_btn.addEventListener(MouseEvent.MOUSE_OUT,this.btnOut2);
         this.honor_btn.addEventListener(MouseEvent.MOUSE_MOVE,this.btnMove2);
         this.arena_btn.addEventListener(MouseEvent.CLICK,this.info_mc.btnClick2);
         this.arena_btn.addEventListener(MouseEvent.ROLL_OVER,this.btnOver2);
         this.arena_btn.addEventListener(MouseEvent.MOUSE_OUT,this.btnOut2);
         this.arena_btn.addEventListener(MouseEvent.MOUSE_MOVE,this.btnMove2);
      }
      
      public function fleshData() : *
      {
         this.IsShow = true;
         this.head_btn.setText(this.GD.headLabel);
         this.level_txt.text = "LV." + (this.GD.level + 1);
         this.playerName_txt.text = this.GD.playerName;
         var base_str0:String = "";
         base_str0 += "军衔 " + this.GD.playerRank + "\n";
         base_str0 += "称号 " + this.GD.honorData.getNowHonorName() + "\n";
         this.baseInfo_txt.text = base_str0;
         this.dps_txt.text = "战斗力 " + Math.round(this.GD.getAllDps()) + "";
         var num_str0:String = "";
         num_str0 += "经验 " + int(this.GD.nowExp) + "/" + int(this.GD.maxExp) + "\n";
         num_str0 += "功勋 " + int(this.GD.allAchieve) + "/" + int(Game.gameDefine.getAllAchieve(this.GD.rankLevel)) + "\n";
         num_str0 += "耐久 " + Math.floor(this.GD.nowLife) + "/" + Math.floor(this.GD.maxLife) + "\n";
         num_str0 += "防御 " + int(this.GD.maxDefence);
         this.numInfo_txt.text = num_str0;
         if(this.GD.arenaData.nowRank == 0)
         {
            this.arena_txt.text = "进入竞技场获得排名";
         }
         else
         {
            this.arena_txt.text = "天梯 No." + this.GD.arenaData.nowRank;
         }
         var str3:String = "";
         var cheat:Boolean = false;
         if(this.GD.playerData.attackAdd.getPer() + this.GD.playerData.allAdd.getPer() + (this.GD.itemsAdd.attackAdd + this.GD.itemsAdd.allAdd) >= 1100 || this.GD.playerData.subAdd.getPer() + this.GD.playerData.allAdd.getPer() + (this.GD.itemsAdd.subAdd + this.GD.itemsAdd.allAdd) >= 1100 || this.GD.playerData.lifeAdd.getPer() + this.GD.playerData.allAdd.getPer() + (this.GD.itemsAdd.lifeAdd + this.GD.itemsAdd.allAdd) >= 1100 || this.GD.playerData.defenceAdd.getPer() + this.GD.playerData.allAdd.getPer() + (this.GD.itemsAdd.defenceAdd + this.GD.itemsAdd.allAdd) >= 1100)
         {
            cheat = true;
         }
         str3 += "射击 " + (this.GD.playerData.attackAdd.getPer() + this.GD.playerData.allAdd.getPer()) + "%";
         if(this.GD.itemsAdd.attackAdd > 0 || this.GD.itemsAdd.allAdd > 0 || this.GD.rankAdd.attackAdd > 0 || Game.uiGroup.unionUI.GetBuildAddByType(0) > 0)
         {
            str3 += this.getColor(" +" + this.getPer(this.GD.itemsAdd.attackAdd + this.GD.itemsAdd.allAdd + this.GD.rankAdd.attackAdd + Game.uiGroup.unionUI.GetBuildAddByType(0)),"#FFFF00") + "\n";
         }
         else
         {
            str3 += "\n";
         }
         str3 += "控制 " + (this.GD.playerData.subAdd.getPer() + this.GD.playerData.allAdd.getPer()) + "%";
         if(this.GD.itemsAdd.subAdd > 0 || this.GD.itemsAdd.allAdd > 0 || Game.uiGroup.unionUI.GetBuildAddByType(3) > 0)
         {
            str3 += this.getColor(" +" + this.getPer(this.GD.itemsAdd.subAdd + this.GD.itemsAdd.allAdd + Game.uiGroup.unionUI.GetBuildAddByType(3)),"#FFFF00") + "\n";
         }
         else
         {
            str3 += "\n";
         }
         str3 += "体能 " + (this.GD.playerData.lifeAdd.getPer() + this.GD.playerData.allAdd.getPer()) + "%";
         if(Boolean(this.GD.itemsAdd.lifeAdd > 0 || this.GD.itemsAdd.allAdd > 0) || Boolean(this.GD.rankAdd.lifeAdd) || Game.uiGroup.unionUI.GetBuildAddByType(1) > 0)
         {
            str3 += this.getColor(" +" + this.getPer(this.GD.itemsAdd.lifeAdd + this.GD.itemsAdd.allAdd + this.GD.rankAdd.lifeAdd + Game.uiGroup.unionUI.GetBuildAddByType(1)),"#FFFF00") + "\n";
         }
         else
         {
            str3 += "\n";
         }
         str3 += "防御 " + (this.GD.playerData.defenceAdd.getPer() + this.GD.playerData.allAdd.getPer()) + "%";
         if(this.GD.itemsAdd.defenceAdd > 0 || this.GD.itemsAdd.allAdd > 0 || Game.uiGroup.unionUI.GetBuildAddByType(2) > 0)
         {
            str3 += this.getColor(" +" + this.getPer(this.GD.itemsAdd.defenceAdd + this.GD.itemsAdd.allAdd + Game.uiGroup.unionUI.GetBuildAddByType(2)),"#FFFF00") + "\n";
         }
         else
         {
            str3 += "\n";
         }
         this.trainInfo_txt.htmlText = str3;
         this.Gcoin_txt.text = this.GD.GCoin + "";
         this.Mcoin_txt.text = this.GD.MCoin + "";
         if(cheat)
         {
            Game.uiGroup.zuobile("训练等级几率修改了！");
            Game.uiGroup.saveDataNoUI();
         }
      }
      
      private function getColor(str:String, _color1:String = "#999999") : String
      {
         return "<font color=\'" + _color1 + "\'>" + str + "</font>";
      }
      
      public function getPer(num0:Number) : String
      {
         return int(num0 * 100) + "%";
      }
      
      public function gotoPay(e:*) : *
      {
         Game.uiGroup.show("rank");
      }
      
      private function showTip(str0:String) : *
      {
         var bag00:int = 0;
         var GD:GameData = Game.gameData;
         var str1:String = "";
         if(str0 == "group")
         {
            str1 = "";
         }
         else if(str0 == "playerName")
         {
            str1 = "点击免费修改名称";
         }
         else if(str0 == "rank")
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
            str1 += "攻击训练加成：" + int(GD.rankAdd.attackAdd * 100) + "%";
            str1 += "体能训练加成：" + int(GD.rankAdd.lifeAdd * 100) + "%";
         }
         else if(str0 == "groupScore")
         {
            str1 = "你的竞技场排名";
         }
         else if(str0 == "GCoin")
         {
            str1 = this.getColor("G币获取加成：" + int((GD.itemsAdd.coin + GD.rankAdd.coin) * 100) + "%","#FFFF00");
         }
         else if(str0 == "MCoin")
         {
            str1 = this.getColor("通过充值获得M币\n1人民币=10M币","#FFFFFF");
         }
         else if(str0 == "life")
         {
            str1 = "基础耐久：" + int(GD.baseLife + GD.foreverLife);
            str1 += "\n车身耐久：" + int(GD.carLife);
            str1 += "\n军衔体能训练加成：" + int(GD.rankAdd.lifeAdd * 100) + "%";
            str1 += "\n附加耐久加成：" + int(GD.itemsAdd.life_max * 100) + "%";
            str1 += "\n附加耐久加成：" + int(GD.itemsAdd.life_value) + "点";
            str1 += "\n" + this.getColor("耐久回复速度：" + int(GD.itemsAdd.life_rate) + " 点/秒","#FFFF00");
         }
         else if(str0 == "defence")
         {
            str1 = "车身防御：" + int(GD.carDefence + GD.foreverDefence);
            str1 += "\n附加防御加成：" + int(GD.itemsAdd.defence_mul * 100) + "%";
            str1 += "\n附加防御加成：" + int(GD.itemsAdd.defence_max) + "点";
            str1 += "\n" + this.getColor("伤害减免率：" + int(GD.defenceHurtRedu * 100) + "%","#FFFF00");
         }
         else if(str0 == "exp")
         {
            str1 = this.getColor("经验获取加成：" + int(GD.itemsAdd.exp) + "点","#FFFF00");
         }
         else if(str0 == "achieve")
         {
            str1 += this.getColor("功勋获取加成：" + int(GD.itemsAdd.achieve * 100) + "%","#FFFF00") + "\n";
            str1 += "击杀精英怪或者充值M币可获得\n功勋值，进而提升军衔。";
         }
         else if(str0 == "lifeAdd")
         {
            str1 = "提升耐久加成" + GD.playerData.lifeAdd.getPer() + "%";
         }
         else if(str0 == "attackAdd")
         {
            str1 = "提升主武器攻击力加成" + GD.playerData.attackAdd.getPer() + "%";
         }
         else if(str0 == "subAdd")
         {
            str1 = "提升副武器攻击力加成" + GD.playerData.subAdd.getPer() + "%";
            str1 += "\n军衔攻击训练加成：" + int(GD.rankAdd.attackAdd * 100) + "%";
         }
         else if(str0 == "defenceAdd")
         {
            str1 = "提升防御加成" + GD.playerData.defenceAdd.getPer() + "%";
         }
         if(str1 != "")
         {
            this.infoTip.showText(str1);
         }
      }
      
      public function btnOver2(event:MouseEvent) : *
      {
         var str00:String = null;
         var str1:* = undefined;
         var bag00:int = 0;
         this.mouseMove(event);
         var GD:GameData = Game.gameData;
         if(event.target == this.name_btn)
         {
            str00 = "点击免费修改名称";
            this.infoTip.showText(str00);
         }
         else if(event.target == this.head_btn)
         {
            this.infoTip.showText("点击修改头像\n未解锁头像需要50000 G币");
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
            this.infoTip.showText(str1);
         }
         else if(event.target == this.honor_btn)
         {
            this.infoTip.showText("点击进入称号界面");
         }
         else if(event.target == this.arena_btn)
         {
            this.infoTip.showText("点击进入竞技场");
         }
      }
      
      public function btnOut2(event:MouseEvent) : *
      {
         this.infoTip.hide();
      }
      
      public function btnMove2(event:MouseEvent) : *
      {
         this.mouseMove(event);
      }
      
      private function trainBtnClick(e:*) : *
      {
         Game.uiGroup.gotoTrain_label(e.target.name.split("_btn")[0]);
      }
      
      private function mouseOver(e:MouseEvent) : *
      {
         this.mouseMove(e);
      }
      
      private function mouseOut(e:MouseEvent) : *
      {
         this.infoTip.hide();
      }
      
      private function mouseMove(e:MouseEvent) : *
      {
         var arr_name0:String = null;
         var arr0:Array = null;
         var index0:int = 0;
         var name0:String = null;
         this.infoTip.x = mouseX;
         this.infoTip.y = mouseY;
         if(e.target is TextField)
         {
            arr_name0 = e.target.name + "_info";
            if(this.hasOwnProperty(arr_name0))
            {
               arr0 = this[arr_name0];
               index0 = e.target.mouseY / 20;
               name0 = arr0[index0];
               if(!name0)
               {
                  name0 = arr0[arr0.length - 1];
               }
               this.showTip(name0);
            }
            else
            {
               this.infoTip.hide();
            }
         }
      }
   }
}

