package UI.gameover
{
   import UI.button.PicButton;
   import data.StringToDefine;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import gs.TweenLite;
   import gs.easing.Back;
   
   public class GameOverUI extends Sprite
   {
      
      public var continueGame_btn:PicButton = new PicButton();
      
      public var restart_btn:PicButton = new PicButton();

      public var txt1:TextField;
      
      public var txt2:TextField;
      
      public var title_mc:MovieClip;
      
      public var cardUI:FlipCardUI;
      
      public function GameOverUI()
      {
         super();
         this.init();
      }
      
      public function init() : *
      {
         this.title_mc.stop();
         this.cardUI = new FlipCardUI();
         this.cardUI.visible = false;
         this.cardUI.x = Game.stageWidth / 2;
         this.cardUI.y = Game.stageHeight / 2;
         this.continueGame_btn.setBack("new_orange");
         this.continueGame_btn.x = 480;
         this.continueGame_btn.y = 412;
         addChild(this.continueGame_btn);
         this.restart_btn.setBack("new_blue");
         this.restart_btn.x = 480;
         this.restart_btn.y = 450;
         addChild(this.restart_btn);
      }
      
      public function winShow(levelState0:String = "normal") : *
      {
         this.cardUI.visible = false;
         this.restart_btn.visible = true;
         this.txt2.visible = false;
         var isoneB:Boolean = false;
         if(levelState0 == "normal")
         {
            if(Game.gameData.nowGameLevel == 0 && Game.gameData.newLevelData.levelPack == "p1")
            {
               isoneB = true;
            }
            this.title_mc.gotoAndStop(1);
            this.continueGame_btn.setText("gonextcontinue");
            this.restart_btn.setText("restartLevel");
            if(Game.gameData.nowGameLevel >= 999 || isoneB)
            {
               this.restart_btn.visible = false;
               this.txt2.visible = false;
            }
            else
            {
               this.txt2.visible = true;
            }
         }
         else if(levelState0 == "extra" || levelState0 == "specialExtra")
         {
            this.title_mc.gotoAndStop(1);
            this.continueGame_btn.setText("returnExtra");
            this.restart_btn.setText("restartExtra");
            Game.uiGroup.saveDataNoUI();
         }
         else if(levelState0 == "weekExtra")
         {
            this.title_mc.gotoAndStop(1);
            this.continueGame_btn.setText("returnExtra");
            Game.uiGroup.saveDataNoUI();
            this.restart_btn.visible = false;
         }
         else if(levelState0 == "arena")
         {
            this.continueGame_btn.setText("returnArena");
            this.restart_btn.visible = false;
         }
         else if(levelState0 == "union")
         {
            this.continueGame_btn.setText("gounion");
            this.restart_btn.visible = false;
         }
         if((levelState0 == "normal" || levelState0 == "extra" || levelState0 == "specialExtra" || levelState0 == "arena" || levelState0 == "union") && !isoneB)
         {
            this.cardUI.visible = true;
            this.cardUI.alpha = 0;
            this.cardUI.scaleX = 0.8;
            this.cardUI.scaleY = 0.8;
            TweenLite.to(this.cardUI,0.5,{
               "alpha":1,
               "scaleX":1,
               "scaleY":1,
               "ease":Back.easeOut
            });
            this.cardUI.flipStart_init(levelState0);
         }
         else if(isoneB)
         {
            Game.eventGroup.toTutorial();
         }
      }
      
      public function failShow(levelState0:String = "normal") : *
      {
         this.winShow(levelState0);
         this.cardUI.visible = false;
         this.title_mc.gotoAndStop(2);
         this.txt2.visible = false;
         if(levelState0 == "arena")
         {
            Game.uiGroup.saveDataNoUI();
         }
      }
      
      public function setText(_coin:int, _exp:int, _achieve:int, _killNum:int, _time:Number, _hitRate:String) : *
      {
         var str0:String = "";
         str0 += "获得G币：" + _coin + "\n";
         str0 += "获得功勋：" + _achieve + "\n";
         str0 += "杀敌数：" + _killNum + "\n";
         str0 += "命中率：" + _hitRate + "\n";
         str0 += "游戏时间：" + StringToDefine.getTimeStr(_time);
         this.txt1.text = str0;
      }
      
      public function setArenaText(_score:int, _exp:int, _achieve:int, _killNum:int, _time:Number, _hitRate:String) : *
      {
         var str0:String = "";
         str0 += StringToDefine.getFontColor("获得竞技场积分：" + _score,"#FFFF00") + "\n";
         str0 += "获得功勋：" + _achieve + "\n";
         str0 += "杀敌数：" + _killNum + "\n";
         str0 += "游戏时间：" + StringToDefine.getTimeStr(_time);
         this.txt1.htmlText = str0;
      }
      
      public function setGroupText(time0:Number, hitRate:Number, nowHurtNum0:Number) : int
      {
         var arr0:Array = Game.gameDefine.getStatistics(time0,hitRate,nowHurtNum0);
         trace("被击中次数：" + arr0);
         var str0:String = "";
         str0 += "时间得分：" + arr0[0] + "\n";
         str0 += "技巧得分：" + arr0[2] + "\n";
         str0 += "总得分：" + arr0[3] + "\n";
         str0 += "评价：" + arr0[4] + "\n";
         this.txt2.text = str0;
         trace("设置txt2文本：" + str0);
         return arr0[3];
      }
   }
}

