package ctrl4399.view.components.shopModule
{
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.utils.Timer;
   
   public class NoticeModule extends Sprite
   {
      
      private var _wid:int = 460;
      
      private var _hei:int = 18;
      
      private var xspan:int = 100;
      
      private var noticeTxt:TextField;
      
      private var noticeTxt2:TextField;
      
      private var txtMask:Shape;
      
      private var txtSp:Sprite = new Sprite();
      
      private var timer:Timer;
      
      public function NoticeModule()
      {
         super();
         if(this.noticeTxt == null)
         {
            this.noticeTxt = this.initNoticeTxt();
         }
         if(this.noticeTxt2 == null)
         {
            this.noticeTxt2 = this.initNoticeTxt();
         }
         if(this.txtMask == null)
         {
            this.initMask();
         }
         this.txtSp.mask = this.txtMask;
         this.addChild(this.txtMask);
         this.txtSp.addChild(this.noticeTxt);
         this.addChild(this.txtSp);
      }
      
      private static function checkspace(param1:String) : String
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:String = "";
         var _loc3_:String = param1;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(_loc3_.charAt(_loc4_) != " ")
            {
               break;
            }
            _loc6_ = _loc4_ + 1;
            while(_loc6_ < _loc3_.length)
            {
               _loc2_ += _loc3_.charAt(_loc6_);
               _loc6_++;
            }
            _loc3_ = _loc2_;
            _loc2_ = "";
            _loc4_ = -1;
            _loc4_++;
         }
         var _loc5_:* = int(_loc3_.length - 1);
         while(_loc5_ >= 0)
         {
            if(_loc3_.charAt(_loc5_) != " ")
            {
               break;
            }
            _loc7_ = 0;
            while(_loc7_ < _loc5_)
            {
               _loc2_ += _loc3_.charAt(_loc7_);
               _loc7_++;
            }
            _loc3_ = _loc2_;
            _loc2_ = "";
            _loc5_--;
         }
         return _loc3_;
      }
      
      public function setPos(param1:Number, param2:Number) : void
      {
         this.x = Math.round(param1);
         this.y = Math.round(param2);
      }
      
      public function setConent(param1:String, param2:TextFormat = null) : void
      {
         if(param2 == null)
         {
            param2 = this.initTf();
         }
         this.noticeTxt.x = 0;
         this.noticeTxt.text = checkspace(param1);
         this.noticeTxt.setTextFormat(param2);
         if(this.noticeTxt.width > this.txtMask.width)
         {
            this.noticeTxt2.text = checkspace(param1);
            this.noticeTxt2.setTextFormat(param2);
            this.noticeTxt2.x = this.noticeTxt.x + this.noticeTxt.width + this.xspan;
            if(!this.txtSp.contains(this.noticeTxt2))
            {
               this.txtSp.addChild(this.noticeTxt2);
            }
            this.txtEffectFun();
         }
         else
         {
            if(this.txtSp.contains(this.noticeTxt2))
            {
               this.txtSp.removeChild(this.noticeTxt2);
            }
            this.stopTxtEffectFun();
         }
      }
      
      public function stopTxtEffectFun() : void
      {
         if(this.timer == null)
         {
            return;
         }
         if(this.timer.running)
         {
            this.timer.stop();
         }
         if(this.timer.hasEventListener(TimerEvent.TIMER))
         {
            this.timer.removeEventListener(TimerEvent.TIMER,this.onTimerHandler);
         }
      }
      
      public function clearFun() : void
      {
         this.stopTxtEffectFun();
         this.timer = null;
      }
      
      private function txtEffectFun() : void
      {
         if(this.timer == null)
         {
            this.timer = new Timer(100);
         }
         if(!this.timer.hasEventListener(TimerEvent.TIMER))
         {
            this.timer.addEventListener(TimerEvent.TIMER,this.onTimerHandler);
         }
         if(!this.timer.running)
         {
            this.timer.start();
         }
      }
      
      private function onTimerHandler(param1:TimerEvent = null) : void
      {
         if(this.noticeTxt2 == null || this.noticeTxt == null || this.txtSp == null || !this.txtSp.contains(this.noticeTxt2))
         {
            return;
         }
         this.noticeTxt.x -= 3;
         this.noticeTxt2.x -= 3;
         if(this.noticeTxt.x < -this.noticeTxt.width)
         {
            this.noticeTxt.x = this.noticeTxt2.x + this.noticeTxt2.width + this.xspan;
         }
         if(this.noticeTxt2.x < -this.noticeTxt2.width)
         {
            this.noticeTxt2.x = this.noticeTxt.x + this.noticeTxt.width + this.xspan;
         }
      }
      
      private function initTf() : TextFormat
      {
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.font = "宋体";
         _loc1_.color = 16777215;
         _loc1_.size = 13;
         _loc1_.kerning = true;
         _loc1_.letterSpacing = 1;
         return _loc1_;
      }
      
      private function initMask() : void
      {
         this.txtMask = new Shape();
         var _loc1_:Graphics = this.txtMask.graphics;
         _loc1_.clear();
         _loc1_.beginFill(0,1);
         _loc1_.drawRect(0,0,this._wid,this._hei);
         _loc1_.endFill();
      }
      
      private function initNoticeTxt() : TextField
      {
         var _loc1_:TextField = new TextField();
         _loc1_.height = this._hei;
         _loc1_.autoSize = TextFieldAutoSize.LEFT;
         _loc1_.mouseEnabled = false;
         _loc1_.mouseWheelEnabled = false;
         _loc1_.multiline = false;
         _loc1_.selectable = false;
         _loc1_.wordWrap = false;
         return _loc1_;
      }
   }
}

