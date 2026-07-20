package ctrl4399.view.components
{
   import ctrl4399.proxy.MainProxy;
   import ctrl4399.strconst.AllConst;
   import ctrl4399.view.components.styleConst.StyleClass;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.ui.Mouse;
   import frame4399.simplePureMvc.core.Facade;
   import org.heaven.impl.tot.Singleton;
   import org.hell.SetBox;
   
   public class CWinLogScore extends SetBox
   {
      
      private var mainProxy:MainProxy;
      
      private var _facade:Facade = Facade.getInstance();
      
      private var logName:TextField;
      
      private var currentScore:TextField;
      
      private var sortPanel:*;
      
      private var btnLogout:Sprite = new Sprite();
      
      private var btnRestart:*;
      
      private var btnSort:*;
      
      private var desTxt:TextField;
      
      private var preData:Array;
      
      private var gameName:TextField;
      
      private var _emptyTip:Sprite;
      
      private var _showTipTxt:TextField;
      
      public function CWinLogScore()
      {
         super();
         this.mainProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_MAIN) as MainProxy;
         var _loc1_:Object = new Object();
         _loc1_.viewClass = Singleton.getClass(AllConst.SPC_LogScoreView);
         _loc1_.contentViewClass = Singleton.getClass(AllConst.SPC_LogScoreCont);
         _loc1_.tfd = new TextFormat();
         initSetBox("",_loc1_,null,this.checkBtnFun,null);
         titleHeight = 32;
         setStageSize(502,357);
         setBtnVisible();
         this.desTxt = new TextField();
         this.desTxt.width = 444;
         this.desTxt.height = 80;
         this.desTxt.multiline = true;
         this.desTxt.defaultTextFormat = new TextFormat("宋体",22,16089632,null,null,null,null,null,"center");
         this.desTxt.text = "咳…咳…再接再砺！";
         this.desTxt.mouseEnabled = false;
         append(this.desTxt,33,83);
         this.logName = new TextField();
         this.logName.defaultTextFormat = new TextFormat("宋体",13,16777215);
         this.logName.text = "未登录";
         this.logName.selectable = false;
         this.logName.autoSize = TextFieldAutoSize.LEFT;
         this.logName.multiline = false;
         this.logName.wordWrap = false;
         if(this.mainProxy.userNickName != null)
         {
            this.logName.styleSheet = StyleClass.userNameLinkStyle();
            this.logName.htmlText = "欢迎回来: <a href=\'https://u.4399.com/user/info\' target=\'_blank\'>" + this.mainProxy.userNickName + "</a>";
         }
         var _loc2_:TextField = new TextField();
         _loc2_.defaultTextFormat = new TextFormat("宋体",13,16777215);
         _loc2_.htmlText = "(<u>退出</u>)";
         _loc2_.mouseEnabled = false;
         _loc2_.autoSize = TextFieldAutoSize.LEFT;
         _loc2_.multiline = false;
         _loc2_.wordWrap = false;
         this.btnLogout.addChild(_loc2_);
         this.btnLogout.buttonMode = true;
         this.btnLogout.addEventListener(MouseEvent.CLICK,this.__click);
         addToBg(this.logName,int((502 - this.logName.width - this.btnLogout.width - 40) * 0.5) + 40,8);
         addToBg(this.btnLogout,Math.ceil(this.logName.x + this.logName.width) - 5,8);
         var _loc3_:Class = Singleton.getClass(AllConst.SPC_TxtPanel);
         this.sortPanel = new _loc3_();
         append(this.sortPanel,240,193);
         this.sortPanel["_0_0"].mouseEnabled = false;
         this.sortPanel["_0_1"].mouseEnabled = false;
         this.sortPanel["_0_2"].mouseEnabled = false;
         this.sortPanel["_1_0"].mouseEnabled = false;
         this.sortPanel["_1_1"].mouseEnabled = false;
         this.sortPanel["_1_2"].mouseEnabled = false;
         this.sortPanel["_2_0"].mouseEnabled = false;
         this.sortPanel["_2_1"].mouseEnabled = false;
         this.sortPanel["_2_2"].mouseEnabled = false;
         this.currentScore = new TextField();
         this.currentScore.width = 220;
         this.currentScore.height = 100;
         this.currentScore.defaultTextFormat = new TextFormat("宋体",40,16764006,true,null,null,null,null,"center");
         this.currentScore.text = "";
         this.currentScore.mouseEnabled = false;
         append(this.currentScore,20,210);
         var _loc4_:Class = Singleton.getClass(AllConst.SPC_BTN_RESTART);
         var _loc5_:Class = Singleton.getClass(AllConst.SPC_BTN_TOP);
         this.btnSort = new _loc5_();
         this.btnRestart = new _loc4_();
         append(this.btnSort,268,298);
         append(this.btnRestart,110,298);
         var _loc6_:Class = Singleton.getClass(AllConst.EMPTY_TIP);
         this._emptyTip = new _loc6_() as Sprite;
         append(this._emptyTip,view.width / 2,view.height / 2);
         this._emptyTip.visible = false;
         this._showTipTxt = this._emptyTip["title"] as TextField;
         this._showTipTxt.selectable = false;
         this._showTipTxt.mouseEnabled = false;
         this._emptyTip.mouseChildren = false;
         this._emptyTip.mouseEnabled = false;
         this._showTipTxt.mouseWheelEnabled = false;
         this._showTipTxt.wordWrap = false;
         this.btnSort.addEventListener(MouseEvent.CLICK,this.__click);
         this.btnRestart.addEventListener(MouseEvent.CLICK,this.__click);
         addEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler,false,0,true);
         addEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHanlder,false,0,true);
         addEventListener(MouseEvent.MOUSE_UP,this.mouseRollOverHandler,false,0,true);
         addEventListener(MouseEvent.MOUSE_DOWN,this.mouseRollOverHandler,false,0,true);
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
      
      private function __click(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.btnSort:
               this.disPose();
               this._facade.sendNotification(AllConst.MVC_SORT_REQUEST);
               break;
            case this.btnRestart:
               this.disPose();
               break;
            case this.btnLogout:
               this.logOutHandler();
         }
      }
      
      private function logOutHandler() : void
      {
         this.mainProxy.loginOut();
      }
      
      public function disPose() : void
      {
         super.closeHandler(new MouseEvent(MouseEvent.CLICK));
      }
      
      private function showDesTxt(param1:String) : void
      {
         if(param1)
         {
            this.desTxt.text = param1;
         }
      }
      
      public function showUserInfo(param1:Array) : void
      {
         this._emptyTip.visible = false;
         this.sortPanel["_0_0"].text = "";
         this.sortPanel["_0_1"].text = "";
         this.sortPanel["_0_2"].text = "";
         this.sortPanel["_1_0"].text = "";
         this.sortPanel["_1_1"].text = "";
         this.sortPanel["_1_2"].text = "";
         this.sortPanel["_2_0"].text = "";
         this.sortPanel["_2_1"].text = "";
         this.sortPanel["_2_2"].text = "";
         var _loc2_:Array = param1;
         if(param1 == null)
         {
            return;
         }
         this.currentScore.text = _loc2_[0];
         this.showDesTxt(_loc2_[6]);
         var _loc3_:int = int(_loc2_[7]);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            switch(int(_loc4_ / 4))
            {
               case 0:
                  trace("i = " + _loc4_);
                  (this.sortPanel["_0_0"] as TextField).defaultTextFormat = this.txtFormat(_loc2_[_loc4_ + 8]);
                  this.sortPanel["_0_0"].text = _loc2_[_loc4_ + 9];
                  (this.sortPanel["_0_1"] as TextField).defaultTextFormat = this.txtFormat(_loc2_[_loc4_ + 8]);
                  this.sortPanel["_0_1"].text = _loc2_[_loc4_ + 10];
                  (this.sortPanel["_0_2"] as TextField).defaultTextFormat = this.txtFormat(_loc2_[_loc4_ + 8]);
                  this.sortPanel["_0_2"].text = _loc2_[_loc4_ + 11] + "分";
                  break;
               case 1:
                  (this.sortPanel["_1_0"] as TextField).defaultTextFormat = this.txtFormat(_loc2_[_loc4_ + 8]);
                  this.sortPanel["_1_0"].text = _loc2_[_loc4_ + 9];
                  (this.sortPanel["_1_1"] as TextField).defaultTextFormat = this.txtFormat(_loc2_[_loc4_ + 8]);
                  this.sortPanel["_1_1"].text = _loc2_[_loc4_ + 10];
                  (this.sortPanel["_1_2"] as TextField).defaultTextFormat = this.txtFormat(_loc2_[_loc4_ + 8]);
                  this.sortPanel["_1_2"].text = _loc2_[_loc4_ + 11] + "分";
                  break;
               case 2:
                  (this.sortPanel["_2_0"] as TextField).defaultTextFormat = this.txtFormat(_loc2_[_loc4_ + 8]);
                  this.sortPanel["_2_0"].text = _loc2_[_loc4_ + 9];
                  (this.sortPanel["_2_1"] as TextField).defaultTextFormat = this.txtFormat(_loc2_[_loc4_ + 8]);
                  this.sortPanel["_2_1"].text = _loc2_[_loc4_ + 10];
                  (this.sortPanel["_2_2"] as TextField).defaultTextFormat = this.txtFormat(_loc2_[_loc4_ + 8]);
                  this.sortPanel["_2_2"].text = _loc2_[_loc4_ + 11] + "分";
            }
            _loc4_ += 4;
         }
      }
      
      public function showTip(param1:String, param2:Boolean = false) : void
      {
         if(this._emptyTip == null)
         {
            return;
         }
         this._emptyTip.visible = true;
         if(!param2)
         {
            this._showTipTxt.text = param1;
         }
         else
         {
            this._showTipTxt.htmlText = param1;
         }
      }
      
      private function txtFormat(param1:String) : TextFormat
      {
         var _loc2_:uint = 0;
         if(param1 == this.mainProxy.userID)
         {
            _loc2_ = 3381504;
         }
         else
         {
            _loc2_ = 10066329;
         }
         return new TextFormat("",14,_loc2_,null,null,null,null,null,"center");
      }
      
      private function checkBtnFun(param1:* = null, param2:int = -1) : void
      {
         if(param2 == 2)
         {
            trace("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1");
            if(this.btnSort != null)
            {
               this.btnSort.removeEventListener(MouseEvent.CLICK,this.__click);
               this.btnSort = null;
            }
            if(this.btnRestart != null)
            {
               this.btnRestart.removeEventListener(MouseEvent.CLICK,this.__click);
               this.btnRestart = null;
            }
            this.btnLogout.removeEventListener(MouseEvent.CLICK,this.__click);
            removeEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler);
            removeEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHanlder);
            removeEventListener(MouseEvent.MOUSE_UP,this.mouseRollOverHandler);
            removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseRollOverHandler);
            if(!this.mainProxy.mouseVisible)
            {
               Mouse.hide();
            }
            trace("%%%%%%%%%%%%%%%%%%%%%%%%");
            dispatchEvent(new Event(AllConst.CLOSE_BTN_CLICK));
         }
      }
   }
}

