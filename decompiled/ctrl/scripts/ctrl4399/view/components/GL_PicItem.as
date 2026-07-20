package ctrl4399.view.components
{
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol332")]
   public class GL_PicItem extends MovieClip
   {
      
      private static const DEFAULT_GAME_NAME:String = "游戏名称";
      
      private static const MAX_CHAR_LEN:int = 13;
      
      public var noPicMc:MovieClip;
      
      public var picMc:MovieClip;
      
      public var waitMc:MovieClip;
      
      public var gnTxt:TextField;
      
      public var url:String;
      
      private var txtMask:Shape;
      
      private var marqueeTimer:Timer;
      
      public var isCanMoved:Boolean = false;
      
      private var txtSpan:int = -1;
      
      public function GL_PicItem()
      {
         super();
         this.noPicMc.visible = false;
         this.createGameNameTf();
         this.createTextMask();
      }
      
      private function createGameNameTf() : void
      {
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.font = "宋体";
         _loc1_.size = 13;
         _loc1_.color = 10066329;
         _loc1_.align = TextFieldAutoSize.LEFT;
         this.gnTxt = new TextField();
         this.gnTxt.defaultTextFormat = _loc1_;
         this.gnTxt.multiline = false;
         this.gnTxt.wordWrap = false;
         this.gnTxt.height = 17;
         this.gnTxt.autoSize = TextFieldAutoSize.LEFT;
         this.gnTxt.text = DEFAULT_GAME_NAME;
         this.addChild(this.gnTxt);
      }
      
      private function createTextMask() : void
      {
         if(this.txtMask == null)
         {
            this.txtMask = new Shape();
         }
         this.txtMask.graphics.clear();
         this.txtMask.graphics.beginFill(16711680,0.3);
         this.txtMask.graphics.drawRect(0,0,80,this.gnTxt.height + 1);
         this.txtMask.graphics.endFill();
         this.txtMask.x = int(this.picMc.x + (this.picMc.width - this.txtMask.width) * 0.5);
         this.txtMask.y = int(this.picMc.y + this.picMc.height);
         this.addChild(this.txtMask);
         this.gnTxt.mask = this.txtMask;
         this.changeXpos();
      }
      
      internal function setGameNameText(param1:String) : void
      {
         this.gnTxt.text = param1 == "" ? DEFAULT_GAME_NAME : param1;
         if(this.getStringLength(param1) > MAX_CHAR_LEN)
         {
            this.isCanMoved = true;
            this.addEventListener(MouseEvent.MOUSE_OVER,this.onPicSpMouseOver);
            this.addEventListener(MouseEvent.MOUSE_OUT,this.onPicSpMouseOut);
         }
         this.changeXpos();
      }
      
      private function onPicSpMouseOver(param1:MouseEvent) : *
      {
         this.startMoveText();
      }
      
      private function onPicSpMouseOut(param1:MouseEvent) : *
      {
         this.stopMove();
      }
      
      internal function getStringLength(param1:String) : Number
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeMultiByte(param1,"gb2312");
         return _loc2_.length;
      }
      
      private function changeXpos() : void
      {
         if(this.getStringLength(this.gnTxt.text) > MAX_CHAR_LEN)
         {
            this.gnTxt.x = this.txtMask.x;
         }
         else
         {
            this.gnTxt.x = int(this.txtMask.x + (this.txtMask.width - this.gnTxt.width) / 2);
         }
         this.gnTxt.y = this.txtMask.y;
      }
      
      internal function startMoveText() : void
      {
         if(!this.isCanMoved)
         {
            return;
         }
         if(this.marqueeTimer == null)
         {
            this.marqueeTimer = new Timer(130);
            this.marqueeTimer.addEventListener(TimerEvent.TIMER,this.onStartMoveTextHandler);
         }
         this.marqueeTimer.start();
      }
      
      internal function stopMove() : void
      {
         if(!this.isCanMoved)
         {
            return;
         }
         if(this.marqueeTimer != null && this.marqueeTimer.running)
         {
            this.marqueeTimer.reset();
            this.marqueeTimer.stop();
         }
         this.changeXpos();
      }
      
      private function onStartMoveTextHandler(param1:TimerEvent) : void
      {
         if(this.txtSpan < 0 && this.gnTxt.x + this.gnTxt.width <= this.txtMask.x + this.txtMask.width)
         {
            this.txtSpan *= -1;
         }
         else if(this.txtSpan > 0 && this.gnTxt.x >= this.txtMask.x)
         {
            this.txtSpan *= -1;
         }
         this.gnTxt.x += this.txtSpan;
      }
      
      internal function stopAndRemoveMoveText() : void
      {
         if(this.isCanMoved)
         {
            this.isCanMoved = false;
            if(this.marqueeTimer != null)
            {
               if(this.marqueeTimer.running)
               {
                  this.marqueeTimer.stop();
               }
               this.marqueeTimer.removeEventListener(TimerEvent.TIMER,this.onStartMoveTextHandler);
               this.marqueeTimer = null;
            }
         }
      }
   }
}

