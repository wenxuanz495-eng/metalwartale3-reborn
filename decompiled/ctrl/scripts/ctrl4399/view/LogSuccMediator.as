package ctrl4399.view
{
   import ctrl4399.proxy.MainProxy;
   import ctrl4399.strconst.AllConst;
   import ctrl4399.view.components.styleConst.StyleClass;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.ui.Mouse;
   import frame4399.simplePureMvc.core.Facade;
   import frame4399.simplePureMvc.core.Notification;
   import frame4399.simplePureMvc.interfaces.IMediator;
   import frame4399.simplePureMvc.mediator.Mediator;
   
   public class LogSuccMediator extends Mediator implements IMediator
   {
      
      private var app:*;
      
      private var logSuccView:LogSuccView;
      
      private var logSucTipMc:LogSucTipMc;
      
      private var logOutTipMc:LogOutTipMc;
      
      private var mainProxy:MainProxy;
      
      private var _facade:Facade = Facade.getInstance();
      
      private var logName:TextField;
      
      private var logSp:Sprite;
      
      private var childrenNum:int = 0;
      
      private var bgSp:Sprite;
      
      public function LogSuccMediator(param1:String, param2:Object)
      {
         super(param1);
         this.app = param2;
         this.mainProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_MAIN) as MainProxy;
      }
      
      override public function listNotificationInterests() : Array
      {
         return [AllConst.MVC_LOGOUT,AllConst.MVC_LOG_SUCCESS,AllConst.MVC_SHOW_LOGOUTTIP];
      }
      
      override public function handleNotification(param1:Notification) : void
      {
         switch(param1.getName())
         {
            case AllConst.MVC_LOGOUT:
               this.closeLogSuccUi();
               break;
            case AllConst.MVC_LOG_SUCCESS:
               this.openLogSuccUi();
               break;
            case AllConst.MVC_LOG_TIP:
               this.openLogTip();
               break;
            case AllConst.MVC_SHOW_LOGOUTTIP:
               this.openIsLogOutTipUi();
         }
      }
      
      private function openLogSuccUi() : void
      {
         if(this.logSuccView == null)
         {
            this.logSuccView = new LogSuccView();
         }
         if(Boolean(this.app) && !this.app.contains(this.logSuccView))
         {
            this.app.addChild(this.logSuccView);
         }
         if(!this.logSuccView.hasEventListener("userLogOutEvent"))
         {
            this.logSuccView.addEventListener("userLogOutEvent",this.onLogOutHandler);
         }
         this.logSuccView.setNameFun(this.mainProxy.userNickName,this.mainProxy.userType);
         this.openLogTip();
      }
      
      private function openLogTip() : void
      {
         if(!this.mainProxy._isMedalLog)
         {
            if(this.logSucTipMc == null)
            {
               this.logSucTipMc = new LogSucTipMc();
            }
            if(this.mainProxy.userNickName != null)
            {
               if(this.logName == null)
               {
                  this.logName = new TextField();
                  this.logName.defaultTextFormat = new TextFormat("宋体",13,16777215);
                  this.logName.selectable = false;
                  this.logName.autoSize = TextFieldAutoSize.LEFT;
                  this.logName.multiline = false;
                  this.logName.wordWrap = false;
                  this.logName.styleSheet = StyleClass.userNameLinkStyle();
               }
               this.logName.htmlText = "欢迎回来: <a href=\'https://u.4399.com/user/info\' target=\'_blank\'>" + this.mainProxy.userNickName + "</a>";
               if(this.logSp == null)
               {
                  this.logSp = new Sprite();
               }
               if(!this.logSp.contains(this.logName))
               {
                  this.logSp.addChild(this.logName);
               }
               if(Boolean(this.logSucTipMc) && !this.logSucTipMc.contains(this.logSp))
               {
                  this.logName.x = int((this.logSucTipMc.width - this.logSp.width) * 0.5);
                  this.logName.y = 8;
               }
            }
            if(Boolean(this.app) && Boolean(this.app.gameSizeObj))
            {
               this.logSucTipMc.x = int((int(this.app.gameSizeObj.gameInitWid) - this.logSucTipMc.width) * 0.5);
               this.logSucTipMc.y = int((int(this.app.gameSizeObj.gameInitHei) - this.logSucTipMc.height) * 0.5);
            }
            else if(this.mainProxy.realStage)
            {
               this.logSucTipMc.x = int((this.mainProxy.realStage.stageWidth - this.logSucTipMc.width) * 0.5);
               this.logSucTipMc.y = int((this.mainProxy.realStage.stageHeight - this.logSucTipMc.height) * 0.5);
            }
            if(Boolean(this.app) && !this.app.contains(this.logSucTipMc))
            {
               this.app.addChild(this.logSucTipMc);
            }
            this.logSucTipMc.gotoAndPlay(2);
            if(this.logSp)
            {
               this.logSp.visible = true;
            }
         }
         if(Boolean(this.app) && Boolean(this.app.parent) && this.app.parent.getChildAt(this.app) != this.app.parent.numChildren - 1)
         {
            this.app.parent.addChild(this.app);
         }
         if(Boolean(this.app) && !this.app.hasEventListener(Event.ENTER_FRAME))
         {
            this.app.addEventListener(Event.ENTER_FRAME,this.onThisTopHandler);
         }
      }
      
      private function onThisTopHandler(param1:Event) : void
      {
         if(Boolean(this.app) && Boolean(this.app.parent) && int(this.app.parent.numChildren) != this.childrenNum)
         {
            this.app.parent.addChild(this.app);
            this.childrenNum = int(this.app.parent.numChildren);
         }
         if(Boolean(this.logSucTipMc) && Boolean(this.logSp) && this.logSucTipMc.currentLabel == "gone")
         {
            this.logSp.visible = false;
         }
         if(Boolean(this.logSucTipMc && this.logSp) && Boolean(!this.logSucTipMc.contains(this.logSp)) && this.logSucTipMc.currentLabel == "show")
         {
            this.logSucTipMc.addChild(this.logSp);
         }
      }
      
      private function openIsLogOutTipUi() : void
      {
         if(this.logOutTipMc == null)
         {
            this.logOutTipMc = new LogOutTipMc();
         }
         this.creatBgShp();
         this.creatTipFun(this.logOutTipMc);
      }
      
      private function creatTipFun(param1:MovieClip) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(Boolean(this.app) && Boolean(this.app.gameSizeObj))
         {
            param1.x = int((int(this.app.gameSizeObj.gameInitWid) - param1.width) * 0.5);
            param1.y = int((int(this.app.gameSizeObj.gameInitHei) - param1.height) * 0.5);
         }
         else if(this.mainProxy.realStage)
         {
            param1.x = int((this.mainProxy.realStage.stageWidth - param1.width) * 0.5);
            param1.y = int((this.mainProxy.realStage.stageHeight - param1.height) * 0.5);
         }
         if(Boolean(this.app) && !this.app.contains(param1))
         {
            this.app.addChild(param1);
         }
         if(Boolean(this.app) && Boolean(this.app.parent))
         {
            if(this.bgSp)
            {
               this.app.parent.addChild(this.bgSp);
            }
            this.app.parent.addChild(this.app);
         }
         if(!param1.hasEventListener(MouseEvent.CLICK))
         {
            param1.addEventListener(MouseEvent.CLICK,this.onMouseEventHandler);
         }
         if(!param1.hasEventListener(MouseEvent.ROLL_OVER))
         {
            param1.addEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler,false,0,true);
            param1.addEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHanlder,false,0,true);
            param1.addEventListener(MouseEvent.MOUSE_UP,this.mouseRollOverHandler,false,0,true);
            param1.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseRollOverHandler,false,0,true);
         }
      }
      
      private function creatBgShp() : void
      {
         if(this.mainProxy.realStage == null)
         {
            return;
         }
         if(this.bgSp == null)
         {
            this.bgSp = new Sprite();
            this.bgSp.graphics.clear();
            this.bgSp.graphics.beginFill(0,0);
            this.bgSp.graphics.drawRect(0,0,this.mainProxy.realStage.stageWidth,this.mainProxy.realStage.stageHeight);
            this.bgSp.graphics.endFill();
         }
      }
      
      private function onLogOutHandler(param1:Event) : void
      {
         this.openIsLogOutTipUi();
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
      
      private function onMouseEventHandler(param1:MouseEvent) : void
      {
         if(Boolean(this.app) && Boolean(this.app.parent))
         {
            if(this.bgSp)
            {
               this.app.parent.addChild(this.bgSp);
            }
            this.app.parent.addChild(this.app);
         }
         var _loc2_:String = param1.target.name;
         if(_loc2_ == "suerBtn")
         {
            if(this.mainProxy)
            {
               this.mainProxy.reqLogOut();
            }
         }
         else if(_loc2_ == "cancelBtn")
         {
            if(Boolean(this.bgSp) && Boolean(this.app) && Boolean(this.app.parent) && Boolean(this.app.parent.contains(this.bgSp)))
            {
               this.app.parent.removeChild(this.bgSp);
            }
            this.bgSp = null;
            if(this.mainProxy)
            {
               this.mainProxy.isOutOp = false;
            }
            if(this.logOutTipMc != null)
            {
               this.logOutTipMc.removeEventListener(MouseEvent.CLICK,this.onMouseEventHandler);
               this.logOutTipMc.removeEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler);
               this.logOutTipMc.removeEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHanlder);
               this.logOutTipMc.removeEventListener(MouseEvent.MOUSE_UP,this.mouseRollOverHandler);
               this.logOutTipMc.removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseRollOverHandler);
               if(Boolean(this.app) && Boolean(this.app.contains(this.logOutTipMc)))
               {
                  this.app.removeChild(this.logOutTipMc);
               }
               this.logOutTipMc = null;
               this.mouseRollOutHanlder();
            }
         }
      }
      
      private function closeLogSuccUi() : void
      {
         if(Boolean(this.bgSp) && Boolean(this.app) && Boolean(this.app.parent) && Boolean(this.app.parent.contains(this.bgSp)))
         {
            this.app.parent.removeChild(this.bgSp);
         }
         this.bgSp = null;
         if(this.app)
         {
            this.app.removeEventListener(Event.ENTER_FRAME,this.onThisTopHandler);
         }
         if(this.logSuccView != null)
         {
            this.logSuccView.removeEventListener("userLogOutEvent",this.onLogOutHandler);
            if(Boolean(this.app) && Boolean(this.app.contains(this.logSuccView)))
            {
               this.app.removeChild(this.logSuccView);
            }
            this.logSuccView.disPose();
            this.logSuccView = null;
         }
         if(this.logSucTipMc != null)
         {
            if(Boolean(this.app) && Boolean(this.app.contains(this.logSucTipMc)))
            {
               this.app.removeChild(this.logSucTipMc);
            }
            this.logSucTipMc = null;
         }
         if(this.logOutTipMc != null)
         {
            this.logOutTipMc.removeEventListener(MouseEvent.CLICK,this.onMouseEventHandler);
            this.logOutTipMc.removeEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler);
            this.logOutTipMc.removeEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHanlder);
            this.logOutTipMc.removeEventListener(MouseEvent.MOUSE_UP,this.mouseRollOverHandler);
            this.logOutTipMc.removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseRollOverHandler);
            if(Boolean(this.app) && Boolean(this.app.contains(this.logOutTipMc)))
            {
               this.app.removeChild(this.logOutTipMc);
            }
            this.logOutTipMc = null;
            this.mouseRollOutHanlder();
         }
      }
   }
}

