package UI.gaming
{
   import UI.login.HeadBtn;
   import data.StringToDefine;
   import flash.display.Sprite;
   import flash.text.TextField;
   import gameAll.data.GameData;
   import gameAll.high.HighArena_All;
   import gs.TweenLite;
   import gs.easing.Bounce;
   
   public class ArenaGamingUI extends Sprite
   {
      
      public var head1_btn:HeadBtn;
      
      public var head2_btn:HeadBtn;
      
      public var boss1_bar:LifeBar2;
      
      public var boss2_bar:LifeBar2;
      
      public var time_txt:TextField;
      
      public var txt_mc:*;
      
      public var black_mc:Sprite;
      
      public var boss:* = null;
      
      public function ArenaGamingUI()
      {
         super();
         this.time_txt = this.txt_mc.time_txt;
         this.boss1_bar.skillTxt.visible = false;
         this.boss1_bar.nameTxt.textColor = 16777215;
         this.boss2_bar.direction = 1;
         this.boss2_bar.skillTxt.visible = false;
         this.boss2_bar.nameTxt.textColor = 16777215;
      }
      
      public function setBoss(_boss:*) : *
      {
         this.boss = _boss;
         var GD:GameData = Game.gameData;
         var arival:HighArena_All = Game.gameData.arenaData.arival;
         this.boss2_bar.nameTxt.htmlText = "<font color=\'#00FF00\' size=\'-2\'>Lv" + arival.extra.lv + "</font> " + StringToDefine.getFontColor(arival.extra.name,"#FFFFFF");
         this.head2_btn.txt_mc.gotoAndStop(arival.extra.head);
         this.boss1_bar.nameTxt.htmlText = StringToDefine.getFontColor(GD.playerName,"#FFFFFF") + " <font color=\'#00FF00\' size=\'-2\'>Lv" + (GD.level + 1) + "</font>";
         this.head1_btn.txt_mc.gotoAndStop(GD.headLabel);
      }
      
      public function fleshBar() : *
      {
         var arival:HighArena_All = null;
         var GD:GameData = Game.gameData;
         if(Boolean(this.boss))
         {
            arival = Game.gameData.arenaData.arival;
            this.boss2_bar.inData(this.boss.define.nowLife,this.boss.define.maxLife);
            if(this.boss.die != 0)
            {
               this.boss2_bar.inData(0,this.boss.define.maxLife);
               this.boss = null;
            }
         }
         this.boss1_bar.inData(GD.nowLife,GD.maxLife);
      }
      
      public function showNumber(num:int) : *
      {
         this.time_txt.text = num + "";
         this.txt_mc.scaleX = 0.6;
         this.txt_mc.scaleY = 0.6;
         this.txt_mc.alpha = 0;
         TweenLite.to(this.txt_mc,0.3,{
            "scaleX":1,
            "scaleY":1,
            "alpha":1,
            "ease":Bounce.easeOut
         });
         Game.SG.playSound("arena_time");
      }
      
      public function showGo() : *
      {
         this.time_txt.text = "GO!";
         this.txt_mc.scaleX = 0.6;
         this.txt_mc.scaleY = 0.6;
         this.txt_mc.alpha = 0;
         TweenLite.to(this.txt_mc,0.3,{
            "scaleX":1,
            "scaleY":1,
            "alpha":1,
            "ease":Bounce.easeOut,
            "onComplete":this.hideGo
         });
         Game.SG.playSound("arena_go");
      }
      
      public function hideGo() : *
      {
         TweenLite.to(this.txt_mc,0.3,{
            "scaleX":0.5,
            "scaleY":0.5,
            "alpha":0,
            "delay":0.5
         });
      }
      
      public function showFail() : *
      {
         this.time_txt.text = "失败";
         this.txt_mc.scaleX = 0.6;
         this.txt_mc.scaleY = 0.6;
         this.txt_mc.alpha = 0;
         TweenLite.to(this.txt_mc,0.3,{
            "scaleX":1,
            "scaleY":1,
            "alpha":1,
            "ease":Bounce.easeOut
         });
         Game.SG.playSound("arena_fail");
         Game.uiGroup.addGift_byArr(["props,\tjustice_badge,\t\t1"],true,-1,false);
      }
      
      public function showWin() : *
      {
         this.time_txt.text = "胜利";
         this.txt_mc.scaleX = 0.6;
         this.txt_mc.scaleY = 0.6;
         this.txt_mc.alpha = 0;
         TweenLite.to(this.txt_mc,0.3,{
            "scaleX":1,
            "scaleY":1,
            "alpha":1,
            "ease":Bounce.easeOut
         });
         Game.SG.playSound("arena_win");
         this.black_mc.visible = true;
         Game.uiGroup.addGift_byArr(["props,\tjustice_badge,\t\t2"],true,-1,false);
      }
   }
}

