package ctrl4399.view.components
{
   import ctrl4399.proxy.MainProxy;
   import ctrl4399.strconst.AllConst;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.ui.Mouse;
   import flash.utils.Timer;
   import frame4399.simplePureMvc.core.Facade;
   
   public class LogSuccView extends MovieClip
   {
      
      public var dirMc:MovieClip;
      
      public var headMc:MovieClip;
      
      public var lsMc:MovieClip;
      
      public var ltBtn:SimpleButton;
      
      public var outBtn:SimpleButton;
      
      private var mainProxy:MainProxy;
      
      private var _facade:Facade = Facade.getInstance();
      
      public var wid:int = 0;
      
      public var hei:int = 0;
      
      private var moveSpan:int = 0;
      
      private var target:Number = 0;
      
      private var moveCloseSpan:int = 0;
      
      private var nTxt:TextField;
      
      private var tipTxt:TextField;
      
      private var maskSp:Shape;
      
      private var isCreated:Boolean = false;
      
      private var showAreaSp:Sprite;
      
      private var timer:Timer;
      
      private var isInArea:Boolean = false;
      
      private var isOverPanel:Boolean = false;
      
      public function LogSuccView()
      {
         super();
         this.mainProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_MAIN) as MainProxy;
         this.nTxt = new TextField();
         this.nTxt.defaultTextFormat = new TextFormat("宋体",13,16777215,null,null,null,null,null,"left");
         this.nTxt.wordWrap = false;
         this.nTxt.multiline = false;
         this.nTxt.autoSize = "left";
         this.nTxt.selectable = false;
         this.nTxt.x = 8;
         this.nTxt.y = 14;
         this.nTxt.addEventListener(MouseEvent.ROLL_OVER,this.showtip);
         this.nTxt.addEventListener(MouseEvent.ROLL_OUT,this.hidetip);
         this.nTxt.addEventListener(MouseEvent.MOUSE_MOVE,this.movetip);
         this.tipTxt = new TextField();
         this.tipTxt.defaultTextFormat = new TextFormat("宋体",13,0,null,null,null,null,null,"left");
         this.tipTxt.wordWrap = false;
         this.tipTxt.multiline = false;
         this.tipTxt.autoSize = "left";
         this.tipTxt.selectable = false;
         this.tipTxt.border = true;
         this.tipTxt.background = true;
         this.tipTxt.backgroundColor = 16777164;
         this.tipTxt.visible = false;
         this.dirMc.gotoAndStop(1);
         this.dirMc.mouseChildren = false;
         this.dirMc.mouseEnabled = false;
         this.headMc.buttonMode = true;
         this.headMc.addEventListener(MouseEvent.CLICK,this.onMovePanelHandler);
         this.outBtn.addEventListener(MouseEvent.CLICK,this.onLogOutHandler);
         this.ltBtn.addEventListener(MouseEvent.CLICK,this.onLinkToLtHandler);
         addEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler,false,0,true);
         addEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHanlder,false,0,true);
         addEventListener(MouseEvent.MOUSE_UP,this.mouseRollOverHandler,false,0,true);
         addEventListener(MouseEvent.MOUSE_DOWN,this.mouseRollOverHandler,false,0,true);
         this.timer = new Timer(2000,1);
         this.timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onMovePanelHandler);
         this.y = 100;
         addEventListener(MouseEvent.MOUSE_OVER,this.mouseOverHandler,false,0,true);
         addEventListener(MouseEvent.MOUSE_OUT,this.mouseOutHandler,false,0,true);
         if(this.mainProxy.realStage)
         {
            this.mainProxy.realStage.addEventListener(Event.MOUSE_LEAVE,this.mouseOutHandler,false,0,true);
         }
      }
      
      private function showtip(param1:MouseEvent) : void
      {
         this.tipTxt.x = param1.stageX + 15;
         this.tipTxt.y = param1.stageY + 20;
         this.tipTxt.visible = true;
      }
      
      private function hidetip(param1:MouseEvent) : void
      {
         this.tipTxt.visible = false;
      }
      
      private function movetip(param1:MouseEvent) : void
      {
         this.tipTxt.x = param1.stageX + 15;
         this.tipTxt.y = param1.stageY + 20;
      }
      
      private function mouseOverHandler(param1:Event) : void
      {
         this.isOverPanel = true;
         if(this.timer)
         {
            this.timer.stop();
         }
      }
      
      private function mouseOutHandler(param1:Event) : void
      {
         this.isOverPanel = false;
         if(this.timer)
         {
            this.timer.reset();
            this.timer.start();
         }
      }
      
      private function onLinkToLtHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = "https://stat.api.4399.com/group.php?gameid=" + this.mainProxy.gameID;
         navigateToURL(new URLRequest(_loc2_),"_blank");
      }
      
      private function mouseRollOverHandler(param1:MouseEvent = null) : void
      {
         if(!this.mainProxy.mouseVisible)
         {
            Mouse.show();
         }
      }
      
      private function mouseRollOutHanlder(param1:MouseEvent = null) : void
      {
         if(!this.mainProxy.mouseVisible)
         {
            Mouse.hide();
         }
      }
      
      private function onMovePanelHandler(param1:*) : void
      {
         if(this.timer)
         {
            this.timer.stop();
            this.timer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onMovePanelHandler);
            this.timer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onClosePanelHandler);
            this.timer = null;
         }
         removeEventListener(Event.ENTER_FRAME,this.onMoveCloseHandler);
         if(this.dirMc.currentFrame == 1)
         {
            this.dirMc.gotoAndStop(2);
            this.moveSpan = -10;
            this.target = -(this.width - 35);
         }
         else
         {
            this.dirMc.gotoAndStop(1);
            this.moveSpan = 10;
            this.target = 0;
         }
         addEventListener(Event.ENTER_FRAME,this.onMoveThisFun);
      }
      
      private function onMoveThisFun(param1:Event) : void
      {
         this.x += (this.target - this.x) * 0.4;
         if(this.moveSpan < 0 && this.x <= this.target + 0.5 || this.moveSpan > 0 && this.x >= this.target - 0.5)
         {
            this.x = this.target;
            removeEventListener(Event.ENTER_FRAME,this.onMoveThisFun);
            if(this.moveSpan < 0 && this.timer == null)
            {
               this.timer = new Timer(3000,1);
               this.timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onClosePanelHandler);
               if(!this.isOverPanel)
               {
                  this.timer.start();
               }
            }
            if(this.moveSpan > 0 && this.timer == null)
            {
               this.timer = new Timer(2000,1);
               this.timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onMovePanelHandler);
               if(!this.isOverPanel)
               {
                  this.timer.start();
               }
            }
         }
      }
      
      private function onRollOverHandler(param1:MouseEvent = null) : void
      {
         if(this.x != -this.width)
         {
            return;
         }
         this.moveCloseSpan = 10;
         this.target = this.x + 35;
         addEventListener(Event.ENTER_FRAME,this.onMoveCloseHandler);
      }
      
      private function onMoveCloseHandler(param1:Event) : void
      {
         this.x += (this.target - this.x) * 0.2;
         if(this.moveCloseSpan < 0 && this.x <= this.target + 0.5 || this.moveCloseSpan > 0 && this.x >= this.target - 0.5)
         {
            this.x = this.target;
            removeEventListener(Event.ENTER_FRAME,this.onMoveCloseHandler);
            if(this.timer == null)
            {
               this.timer = new Timer(3000,1);
               this.timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onClosePanelHandler);
               if(!this.isOverPanel)
               {
                  this.timer.start();
               }
            }
            else
            {
               this.timer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onClosePanelHandler);
               this.timer = null;
            }
         }
      }
      
      private function onClosePanelHandler(param1:TimerEvent) : void
      {
         this.moveCloseSpan = -10;
         this.target = -this.width;
         addEventListener(Event.ENTER_FRAME,this.onMoveCloseHandler);
      }
      
      private function onLogOutHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new Event("userLogOutEvent"));
      }
      
      public function setNameFun(param1:String, param2:String) : void
      {
         if(this.nTxt == null)
         {
            return;
         }
         this.nTxt.htmlText = "欢迎你：" + "<a href=\'https://u.4399.com/user/info\' target=\'_blank\'><u>" + param1 + "</u></a>";
         this.tipTxt.text = param2;
         if(this.nTxt.width > this.lsMc.width - 25)
         {
            this.lsMc.width = this.nTxt.width - 17;
            if(this.lsMc.width < 109)
            {
               this.lsMc.width = 109;
            }
         }
         this.headMc.x = this.lsMc.x + this.lsMc.width;
         this.dirMc.x = this.headMc.x + 38;
         this.ltBtn.x = int((this.lsMc.width - this.outBtn.width - this.ltBtn.width + 20) * 0.5) + 5;
         this.outBtn.x = this.ltBtn.x + this.ltBtn.width + 5;
         this.ltBtn.y = int(this.nTxt.y + this.nTxt.height) + 2;
         this.outBtn.y = this.ltBtn.y + 2;
         if(!this.contains(this.nTxt))
         {
            addChild(this.nTxt);
         }
         if(!this.parent.contains(this.tipTxt))
         {
            this.parent.addChild(this.tipTxt);
         }
         if(!this.isCreated)
         {
            this.isCreated = true;
            if(this.maskSp == null)
            {
               this.maskSp = new Shape();
            }
            this.maskSp.graphics.clear();
            this.maskSp.graphics.beginFill(0,1);
            this.maskSp.graphics.drawRect(0,0,this.width,this.height);
            this.maskSp.graphics.endFill();
            this.maskSp.y = this.y;
            if(Boolean(this.parent) && !this.parent.contains(this.maskSp))
            {
               this.parent.addChild(this.maskSp);
            }
            this.mask = this.maskSp;
         }
         this.x = -this.width;
         this.target = 0;
         addEventListener(Event.ENTER_FRAME,this.onInitShowHandler);
      }
      
      private function onInitShowHandler(param1:Event) : void
      {
         this.x += (this.target - this.x) * 0.4;
         if(this.x >= this.target - 0.5)
         {
            this.x = this.target;
            removeEventListener(Event.ENTER_FRAME,this.onInitShowHandler);
            if(stage.mouseX >= 0 && stage.mouseX <= this.width && stage.mouseY >= this.y && stage.mouseY <= this.y + this.height)
            {
               this.isOverPanel = true;
            }
            else
            {
               this.isOverPanel = false;
            }
            addEventListener(Event.ENTER_FRAME,this.onCheckMousePosHandler);
            if(this.timer)
            {
               this.timer.reset();
               if(!this.isOverPanel)
               {
                  this.timer.start();
               }
            }
         }
      }
      
      private function onCheckMousePosHandler(param1:Event) : void
      {
         if(stage.mouseX > 130 || stage.mouseX < 0 || stage.mouseY < 0 || stage.mouseY > this.y * 2 + this.height)
         {
            this.isInArea = true;
            return;
         }
         if(!this.isInArea)
         {
            return;
         }
         this.isInArea = false;
         this.onRollOverHandler();
      }
      
      public function disPose() : void
      {
         this.isCreated = false;
         if(Boolean(this.maskSp) && Boolean(this.parent) && this.parent.contains(this.maskSp))
         {
            this.parent.removeChild(this.maskSp);
            this.maskSp = null;
         }
         this.isInArea = false;
         removeEventListener(Event.ENTER_FRAME,this.onCheckMousePosHandler);
         removeEventListener(Event.ENTER_FRAME,this.onInitShowHandler);
         removeEventListener(Event.ENTER_FRAME,this.onMoveCloseHandler);
         removeEventListener(Event.ENTER_FRAME,this.onMoveThisFun);
         if(this.nTxt)
         {
            this.nTxt.removeEventListener(MouseEvent.ROLL_OVER,this.showtip);
            this.nTxt.removeEventListener(MouseEvent.ROLL_OUT,this.hidetip);
            this.nTxt.removeEventListener(MouseEvent.MOUSE_MOVE,this.movetip);
         }
         if(Boolean(this.parent) && this.parent.contains(this.tipTxt))
         {
            this.parent.removeChild(this.tipTxt);
         }
         if(this.timer)
         {
            this.timer.stop();
            this.timer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onMovePanelHandler);
            this.timer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onClosePanelHandler);
            this.timer = null;
         }
         if(this.headMc)
         {
            this.headMc.removeEventListener(MouseEvent.CLICK,this.onMovePanelHandler);
            this.headMc = null;
         }
         if(this.outBtn)
         {
            this.outBtn.removeEventListener(MouseEvent.CLICK,this.onLogOutHandler);
            this.outBtn = null;
         }
         if(this.ltBtn)
         {
            this.ltBtn.removeEventListener(MouseEvent.CLICK,this.onLinkToLtHandler);
            this.ltBtn = null;
         }
         removeEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHanlder);
         removeEventListener(MouseEvent.MOUSE_UP,this.mouseRollOverHandler);
         removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseRollOverHandler);
         removeEventListener(MouseEvent.MOUSE_OVER,this.mouseOverHandler);
         removeEventListener(MouseEvent.MOUSE_OVER,this.mouseOutHandler);
         if(this.mainProxy.realStage)
         {
            this.mainProxy.realStage.removeEventListener(Event.MOUSE_LEAVE,this.mouseOutHandler);
         }
      }
   }
}

