package UI.fase
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class FaceGameBox extends Sprite
   {
      
      public var spacecraft:FaceGameSpacecraft;
      
      public var gun:MovieClip;
      
      public var back_mc:Sprite;
      
      public var bulletArr:Array = [];
      
      public var num_txt:TextField;
      
      public var nowNum:int = 0;
      
      public function FaceGameBox()
      {
         super();
         this.gun.stop();
         this.gun.addEventListener(Event.ENTER_FRAME,this.timer);
         this.back_mc.addEventListener(MouseEvent.CLICK,this.click);
      }
      
      public function click(e:*) : *
      {
         if(this.gun.currentFrame == 1)
         {
            this.gun.gotoAndPlay(2);
            this.addBullet();
         }
      }
      
      public function addBullet() : *
      {
         var b0:FaceGameBullet = new FaceGameBullet();
         b0.stop();
         b0.x = this.gun.x;
         b0.y = this.gun.y;
         this.bulletArr.push(b0);
         this.addChild(b0);
      }
      
      public function bulletTimer() : *
      {
         var n:* = undefined;
         var b0:FaceGameBullet = null;
         var arr2:Array = [];
         for(n in this.bulletArr)
         {
            b0 = this.bulletArr[n];
            if(b0.die == 0)
            {
               b0.y -= 25;
               if(b0.y < -100)
               {
                  b0.die = 2;
                  b0.stop();
                  this.removeChild(b0);
               }
               else
               {
                  if(this.spacecraft.getHitRect().contains(b0.x,b0.y))
                  {
                     b0.die = 1;
                     b0.gotoAndPlay(2);
                     this.spacecraft.hurt();
                  }
                  arr2.push(b0);
               }
            }
            else if(b0.die == 1)
            {
               if(b0.currentFrame >= b0.totalFrames - 1)
               {
                  b0.die = 2;
                  b0.stop();
                  this.removeChild(b0);
               }
               else
               {
                  arr2.push(b0);
               }
            }
         }
         this.bulletArr.length = 0;
         this.bulletArr = arr2;
         if(this.spacecraft.currentFrame == 5)
         {
            ++this.nowNum;
         }
         this.num_txt.text = "已击杀" + this.nowNum + "只";
      }
      
      public function init() : *
      {
      }
      
      public function timer(e:*) : *
      {
         var n:* = undefined;
         var b0:FaceGameBullet = null;
         if(Game.uiGroup.faseUI.visible)
         {
            this.bulletTimer();
            this.spacecraft.timer();
            this.gun.x = mouseX;
         }
         else
         {
            if(this.bulletArr.length > 0)
            {
               for(n in this.bulletArr)
               {
                  b0 = this.bulletArr[n];
                  b0.stop();
                  this.removeChild(b0);
               }
               this.bulletArr.length = 0;
            }
            this.gun.gotoAndStop(1);
            this.spacecraft.gotoAndStop(1);
         }
      }
      
      public function stopTime() : void
      {
         this.gun.removeEventListener(Event.ENTER_FRAME,this.timer);
         this.back_mc.removeEventListener(MouseEvent.CLICK,this.click);
      }
      
      public function startTime() : void
      {
         this.gun.addEventListener(Event.ENTER_FRAME,this.timer);
         this.back_mc.addEventListener(MouseEvent.CLICK,this.click);
      }
   }
}

