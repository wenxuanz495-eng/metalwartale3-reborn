package UI.fase
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import gs.TweenLite;
   import gs.easing.Back;
   
   public class FaseUI extends Sprite
   {
      
      public var mc_good:MovieClip;
      
      public var logo:*;
      
      public var producer_btn:SimpleButton;
      
      public var startGame_btn:SimpleButton;
      
      public var continueGame_btn:SimpleButton;
      
      public var btnX:Array = [];
      
      public var producer_mc:*;
      
      public var btn_arr:Array;
      
      public var loader:LoaderBar;
      
      public var star:MeteorsEffect;
      
      public var tips:*;
      
      public var versionNumber_txt:TextField;
      
      public var tipsTimer:Timer = new Timer(10000);
      
      public var game0:FaceGameBox;
      
      public function FaseUI()
      {
         super();
         this.tips.visible = false;
         this.startGame_btn.visible = false;
         this.producer_btn.visible = false;
         this.continueGame_btn.visible = false;
         this.btnX = [this.continueGame_btn.y,this.startGame_btn.y,this.producer_btn.y];
         trace("btnX：" + this.btnX);
         this.producer_mc.visible = false;
         this.producer_btn.addEventListener(MouseEvent.CLICK,this.producerShow);
         this.producer_mc.return_btn.addEventListener(MouseEvent.CLICK,this.producerHide);
         this.clearLogo();
         this.tipsTimer.addEventListener(TimerEvent.TIMER,this.tipsTimerFun);
         var date:Date = new Date();
         this.mc_good.visible = false;
         if(date.day < 2 || date.day > 5)
         {
            this.mc_good.visible = true;
         }
      }
      
      public function showTips() : *
      {
         this.tips.visible = true;
         var arr0:Array = Game.allTips.arr;
         var str0:String = arr0[int(arr0.length * Math.random())];
         this.tips.txt.text = str0;
      }
      
      public function producerShow(e:*) : *
      {
         this.producer_mc.visible = true;
      }
      
      public function producerHide(e:*) : *
      {
         this.producer_mc.visible = false;
      }
      
      public function tipsTimerFun(e:*) : *
      {
         this.showTips();
      }
      
      public function showLoaderBar() : *
      {
         this.showTips();
         this.tipsTimer.start();
         this.startGame_btn.visible = false;
         this.producer_btn.visible = false;
         this.continueGame_btn.visible = false;
         TweenLite.to(this.loader,0.5,{
            "y":517,
            "ease":Back.easeOut
         });
         this.game0.visible = true;
         this.game0.startTime();
      }
      
      public function hideLoaderBar() : *
      {
         this.tipsTimer.stop();
         this.tips.visible = false;
         TweenLite.to(this.loader,0.5,{
            "y":585,
            "ease":Back.easeIn
         });
         this.game0.visible = false;
      }
      
      public function showPlayBtn(num:int = 2) : *
      {
         this.startGame_btn.visible = true;
         this.producer_btn.visible = true;
         this.continueGame_btn.visible = false;
         this.startGame_btn.y = this.btnX[0];
         this.producer_btn.y = this.btnX[2];
         if(num == 3)
         {
            this.continueGame_btn.y = this.btnX[0];
            this.startGame_btn.y = this.btnX[1];
            this.producer_btn.y = this.btnX[2];
            this.continueGame_btn.visible = true;
            this.startGame_btn.visible = false;
         }
      }
      
      public function clearLogo() : *
      {
         this.star.stopAll();
         this.visible = false;
         this.logo.visible = false;
         this.logo.gotoAndStop(this.logo.totalFrames);
         var xxx:* = this.logo.getChildByName("effect");
         if(xxx is MovieClip)
         {
            trace("");
            xxx.stop();
         }
         var xxx2:* = this.logo.getChildByName("effect2");
         if(xxx2 is MovieClip)
         {
            xxx2.stop();
         }
         trace("清除logo动画");
         this.logo.stop();
      }
      
      public function resumeLogo() : *
      {
         this.star.playAll();
         this.visible = true;
         this.logo.visible = true;
         this.logo.gotoAndStop(this.logo.totalFrames - 1);
         var xxx:* = this.logo.getChildByName("effect");
         if(xxx is MovieClip)
         {
            trace("找到动画了，播放他！！！");
            xxx.play();
         }
         var xxx2:* = this.logo.getChildByName("effect2");
         if(xxx2 is MovieClip)
         {
            xxx2.play();
         }
      }
      
      public function showLogo() : *
      {
         this.star.playAll();
         this.logo.visible = true;
         this.logo.gotoAndPlay(1);
         trace("播放logo动画");
      }
      
      public function StopGame() : void
      {
         this.game0.stopTime();
      }
   }
}

