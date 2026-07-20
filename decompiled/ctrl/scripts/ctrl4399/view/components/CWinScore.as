package ctrl4399.view.components
{
   import ctrl4399.proxy.MainProxy;
   import ctrl4399.proxy.ScoreProxy;
   import ctrl4399.strconst.AllConst;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.ui.Mouse;
   import frame4399.simplePureMvc.core.Facade;
   import org.heaven.impl.tot.Singleton;
   import org.hell.SetBox;
   
   public class CWinScore extends SetBox
   {
      
      private var scoreProxy:ScoreProxy;
      
      private var mainProxy:MainProxy;
      
      private var btnRestart:*;
      
      private var btnLog:*;
      
      private var logName:TextField;
      
      private var gameName:TextField;
      
      private var _score:int = 0;
      
      private var scoreTxt:TextField;
      
      private var desTxt:TextField;
      
      private var btnReg:Sprite;
      
      private var _facade:Facade;
      
      public function CWinScore()
      {
         var _loc4_:TextField = null;
         this.btnReg = new Sprite();
         super();
         this._facade = Facade.getInstance();
         this.mainProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_MAIN) as MainProxy;
         this.scoreProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_SCORE) as ScoreProxy;
         var _loc1_:Object = new Object();
         _loc1_.viewClass = Singleton.getClass(AllConst.SPC_ScoreView);
         _loc1_.contentViewClass = Singleton.getClass(AllConst.SPC_ScoreCont);
         _loc1_.tfd = new TextFormat();
         initSetBox("",_loc1_,null,this.checkBtnFun,null);
         titleHeight = 32;
         setStageSize(502,357);
         setBtnVisible();
         _loc4_ = new TextField();
         _loc4_.width = 444;
         _loc4_.height = 80;
         _loc4_.multiline = true;
         _loc4_.defaultTextFormat = new TextFormat("宋体",22,16089632,null,null,null,null,null,"center");
         _loc4_.text = "立即登录，与全球玩家PK！成绩永久有效哦";
         _loc4_.mouseEnabled = false;
         append(_loc4_,33,91);
         var _loc2_:Class = Singleton.getClass(AllConst.SPC_BTN_RESTART);
         var _loc3_:Class = Singleton.getClass(AllConst.SPC_BTN_PRE_LOG);
         this.btnLog = new _loc3_();
         this.btnRestart = new _loc2_();
         append(this.btnLog,268 - 30,288);
         append(this.btnRestart,110 - 30,288);
         this.scoreTxt = new TextField();
         this.scoreTxt.width = 180;
         this.scoreTxt.height = 63;
         this.scoreTxt.defaultTextFormat = new TextFormat("Arial",24,16089632,null,null,null,null,null,"center");
         this.scoreTxt.text = "";
         this.scoreTxt.mouseEnabled = false;
         append(this.scoreTxt,40,214);
         this.btnLog.addEventListener(MouseEvent.CLICK,this.__click);
         this.btnRestart.addEventListener(MouseEvent.CLICK,this.__click);
         _loc4_ = new TextField();
         _loc4_.width = 90;
         _loc4_.height = 30;
         _loc4_.defaultTextFormat = new TextFormat("宋体",15,12237498,null,null,true,null,null,"left");
         _loc4_.text = "新用户注册";
         _loc4_.mouseEnabled = false;
         this.btnReg.addChild(_loc4_);
         this.btnReg.buttonMode = true;
         this.btnReg.addEventListener(MouseEvent.CLICK,this.__click);
         append(this.btnReg,396 - 30,297);
         addEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler,false,0,true);
         addEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHanlder,false,0,true);
         addEventListener(MouseEvent.MOUSE_UP,this.mouseRollOverHandler,false,0,true);
         addEventListener(MouseEvent.MOUSE_DOWN,this.mouseRollOverHandler,false,0,true);
         this.mainProxy._isOpenScoreUI = false;
      }
      
      public function disPose() : void
      {
         super.closeHandler(new MouseEvent(MouseEvent.CLICK));
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
      
      public function showScore(param1:int) : void
      {
         this._score = param1;
         this.scoreTxt.text = param1.toString();
      }
      
      private function __click(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.btnLog:
               dispatchEvent(new Event("openLogWin"));
               break;
            case this.btnRestart:
               this.disPose();
               break;
            case this.btnReg:
               dispatchEvent(new Event("openRegWin"));
         }
      }
      
      private function checkBtnFun(param1:* = null, param2:int = -1) : void
      {
         if(param2 == 2)
         {
            this.mainProxy._isOpenScoreUI = false;
            if(!this.mainProxy.mouseVisible)
            {
               Mouse.hide();
            }
            removeEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler);
            removeEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHanlder);
            removeEventListener(MouseEvent.MOUSE_UP,this.mouseRollOverHandler);
            removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseRollOverHandler);
            this.btnLog.removeEventListener(MouseEvent.CLICK,this.__click);
            this.btnRestart.removeEventListener(MouseEvent.CLICK,this.__click);
            dispatchEvent(new Event(AllConst.CLOSE_BTN_CLICK));
         }
      }
   }
}

