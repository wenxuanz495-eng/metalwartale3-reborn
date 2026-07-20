package ctrl4399.view.components
{
   import ctrl4399.proxy.MainProxy;
   import ctrl4399.strconst.AllConst;
   import ctrl4399.view.components.styleConst.StyleClass;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.ui.Keyboard;
   import flash.ui.Mouse;
   import frame4399.simplePureMvc.core.Facade;
   import org.heaven.impl.tot.Singleton;
   import org.hell.SetBox;
   
   public class SecondaryLogUI extends SetBox
   {
      
      private static const DEFAULT_USER_NAME:String = "请输入4399帐号";
      
      private static const DEFAULT_PASSWORD:String = "请输入密码";
      
      private var _mainProxy:MainProxy;
      
      private var btn_log:SimpleButton;
      
      private var checkCode:SecondaryLogCheckCode;
      
      public var tmp:MovieClip;
      
      private var forgetPwdSp:Sprite;
      
      private var txt_title:TextField;
      
      private var txt_userName:TextField;
      
      private var txt_password:TextField;
      
      private var txt_check_log_info:TextField;
      
      private var txt_checkCode_Info:TextField;
      
      private var checkspace:Function = StyleClass.checkspace;
      
      private var _isShowBox:Boolean = true;
      
      private var _isShowCheckCode:Boolean = false;
      
      private var _userName:String = "";
      
      private var _password:String = "";
      
      private var _loginHandle:Function;
      
      public function SecondaryLogUI()
      {
         super();
         var _loc1_:Object = new Object();
         _loc1_.viewClass = Singleton.getClass(AllConst.SPC_SecondaryLogView);
         _loc1_.contentViewClass = Singleton.getClass(AllConst.SPC_RegCont);
         _loc1_.tfd = new TextFormat();
         initSetBox("",_loc1_,null,this.checkBtnFun,null);
         titleHeight = 32;
         setStageSize(502,357);
         setBtnVisible();
         this.tmp = view["tmp"] as MovieClip;
         var _loc2_:Class = Singleton.getClass(AllConst.SPC_BTN_PRE_LOG);
         this.btn_log = new _loc2_() as SimpleButton;
         this.btn_log.focusRect = false;
         append(this.btn_log,173,this.tmp.y + 124);
         this.btn_log.addEventListener(MouseEvent.CLICK,this.clickHandle);
         this.forgetPwdSp = new Sprite();
         var _loc3_:TextField = new TextField();
         _loc3_.autoSize = TextFieldAutoSize.LEFT;
         _loc3_.wordWrap = false;
         _loc3_.multiline = false;
         _loc3_.text = "忘记密码？";
         _loc3_.textColor = 12237498;
         var _loc4_:TextFormat = new TextFormat();
         _loc4_.align = TextFormatAlign.LEFT;
         _loc4_.font = "宋体";
         _loc4_.size = 15;
         _loc4_.underline = true;
         _loc3_.setTextFormat(_loc4_);
         this.forgetPwdSp.addChild(_loc3_);
         this.forgetPwdSp.tabChildren = this.forgetPwdSp.tabEnabled = false;
         this.forgetPwdSp.mouseChildren = false;
         this.forgetPwdSp.buttonMode = true;
         this.forgetPwdSp.addEventListener(MouseEvent.CLICK,this.clickForgetPwdHandle);
         append(this.forgetPwdSp,this.btn_log.x + this.btn_log.width + 5,this.btn_log.y + (this.btn_log.height - this.forgetPwdSp.height) * 0.5);
         this.txt_title = new TextField();
         this.txt_title.multiline = false;
         this.txt_title.autoSize = "left";
         this.txt_title.wordWrap = false;
         this.txt_title.defaultTextFormat = new TextFormat("宋体",13,16777215);
         this.txt_title.text = "次账号登录后可进行本地双人游戏";
         this.txt_title.selectable = false;
         addToBg(this.txt_title,144,8);
         this.txt_userName = new TextField();
         this.txt_userName.defaultTextFormat = new TextFormat("宋体",15);
         this.txt_userName.width = 195;
         this.txt_userName.height = 22;
         this.txt_userName.maxChars = 30;
         this.txt_userName.type = TextFieldType.INPUT;
         this.txt_userName.text = DEFAULT_USER_NAME;
         this.txt_userName.tabEnabled = true;
         this.txt_userName.tabIndex = 0;
         this.txt_userName.addEventListener(FocusEvent.FOCUS_IN,this.focusInHandle);
         this.txt_userName.addEventListener(FocusEvent.FOCUS_OUT,this.focusOutHandle);
         this.txt_password = new TextField();
         this.txt_password.defaultTextFormat = new TextFormat("宋体",15);
         this.txt_password.width = 195;
         this.txt_password.height = 22;
         this.txt_password.maxChars = 20;
         this.txt_password.type = TextFieldType.INPUT;
         this.txt_password.text = DEFAULT_PASSWORD;
         this.txt_password.tabEnabled = true;
         this.txt_password.tabIndex = 0;
         addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandle);
         this.txt_password.addEventListener(FocusEvent.FOCUS_IN,this.focusInHandle);
         this.txt_password.addEventListener(FocusEvent.FOCUS_OUT,this.focusOutHandle);
         var _loc5_:int = 173;
         var _loc6_:int = 58;
         append(this.txt_userName,_loc5_,this.tmp.y + 14);
         append(this.txt_password,_loc5_,this.tmp.y + 14 + _loc6_);
         this.txt_check_log_info = new TextField();
         this.txt_check_log_info.defaultTextFormat = new TextFormat("宋体",15,16711680,null,null,null,null,null,"right");
         this.txt_check_log_info.text = "用户名或密码错误";
         this.txt_check_log_info.width = 180;
         this.txt_check_log_info.height = 22;
         this.txt_check_log_info.maxChars = 20;
         this.txt_check_log_info.mouseEnabled = false;
         this.txt_check_log_info.tabEnabled = false;
         append(this.txt_check_log_info,198,this.txt_userName.y + 28);
         this.txt_check_log_info.visible = false;
         this.txt_checkCode_Info = new TextField();
         this.txt_checkCode_Info.defaultTextFormat = new TextFormat("宋体",15,16711680);
         this.txt_checkCode_Info.width = 150;
         this.txt_checkCode_Info.height = 22;
         this.txt_checkCode_Info.maxChars = 20;
         this.txt_checkCode_Info.text = "请输入验证码";
         this.txt_checkCode_Info.mouseEnabled = false;
         this.txt_checkCode_Info.tabEnabled = false;
         append(this.txt_checkCode_Info,285,this.txt_password.y + 28);
         this.txt_checkCode_Info.visible = false;
         this.checkCode = new SecondaryLogCheckCode();
         this.checkCode.setStage(this.mainProxy.realStage);
         this.checkCode.setVisible(false);
         this.checkCode.tabEnabled = true;
         this.checkCode.tabChildren = true;
         this.checkCode.tabIndex = 0;
         this.checkCode.focusRect = false;
         append(this.checkCode,106,this.btn_log.y);
         addEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler,false,0,true);
         addEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHanlder,false,0,true);
         addEventListener(MouseEvent.MOUSE_UP,this.mouseRollOverHandler,false,0,true);
         addEventListener(MouseEvent.MOUSE_DOWN,this.mouseRollOverHandler,false,0,true);
         closeBtn.tabEnabled = false;
         closeBtnDownFunc = this.closeBox;
         this.hideBox();
      }
      
      public function get mainProxy() : MainProxy
      {
         if(!this._mainProxy)
         {
            this._mainProxy = Facade.getInstance().retrieveProxy(AllConst.PROXY_NAME_MAIN) as MainProxy;
         }
         return this._mainProxy;
      }
      
      public function get isShowBox() : Boolean
      {
         return this._isShowBox;
      }
      
      public function get isShowCheckCode() : Boolean
      {
         return this._isShowCheckCode;
      }
      
      public function set isShowCheckCode(param1:Boolean) : void
      {
         this._isShowCheckCode = param1;
      }
      
      public function set loginHandle(param1:Function) : void
      {
         this._loginHandle = param1;
      }
      
      private function mouseRollOutHanlder(param1:MouseEvent) : void
      {
         if(!this.mainProxy.mouseVisible)
         {
            Mouse.hide();
         }
      }
      
      private function mouseRollOverHandler(param1:MouseEvent = null) : void
      {
         Facade.getInstance().sendNotification(AllConst.SET_AS2_FOCUSMANAGER);
         if(!this.mainProxy.mouseVisible)
         {
            Mouse.show();
         }
      }
      
      private function clickHandle(param1:MouseEvent) : void
      {
         this.secondaryLogHandle();
      }
      
      private function keyDownHandle(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ENTER)
         {
            this.secondaryLogHandle();
         }
      }
      
      private function secondaryLogHandle() : void
      {
         var _loc1_:String = null;
         if(this.isInputTxt())
         {
            _loc1_ = "";
            if(Boolean(this.checkCode) && this.checkCode.visible)
            {
               _loc1_ = this.checkCode.getCheckTxt();
            }
            trace("---次账号登录---");
            trace("账号:" + this._userName);
            trace("密码:" + this._password);
            trace("验证码:" + _loc1_);
            trace("----------------");
            if(this._loginHandle is Function)
            {
               this._loginHandle(this._userName,this._password,_loc1_);
            }
            else
            {
               trace("缺少登录回调");
            }
         }
      }
      
      private function focusInHandle(param1:FocusEvent) : void
      {
         var _loc2_:TextField = param1.target as TextField;
         if(_loc2_ == this.txt_userName && this.checkspace(_loc2_.text) == DEFAULT_USER_NAME)
         {
            _loc2_.text = "";
            _loc2_.textColor = 0;
         }
         else if(_loc2_ == this.txt_password && this.checkspace(_loc2_.text) == DEFAULT_PASSWORD)
         {
            _loc2_.text = "";
            _loc2_.textColor = 0;
            _loc2_.displayAsPassword = true;
         }
      }
      
      private function focusOutHandle(param1:FocusEvent) : void
      {
         var _loc2_:TextField = param1.target as TextField;
         if(this.checkspace(_loc2_.text) == "")
         {
            if(_loc2_ == this.txt_userName)
            {
               _loc2_.text = DEFAULT_USER_NAME;
               _loc2_.textColor = 16711680;
            }
            else if(_loc2_ == this.txt_password)
            {
               _loc2_.text = DEFAULT_PASSWORD;
               _loc2_.textColor = 16711680;
               _loc2_.displayAsPassword = false;
            }
         }
      }
      
      private function clickForgetPwdHandle(param1:MouseEvent) : void
      {
         navigateToURL(new URLRequest(AllConst.URL_GET_SECONDARY_PWD),"_blank");
      }
      
      private function checkBtnFun(param1:* = null, param2:int = -1) : void
      {
         if(param2 == 2)
         {
            this._isShowBox = false;
            if(!this.mainProxy.mouseVisible)
            {
               Mouse.hide();
            }
         }
      }
      
      private function closeBox() : void
      {
         trace("--closeBox--");
      }
      
      private function showCheckCode() : void
      {
         if(this._isShowCheckCode == this.checkCode.visible)
         {
            return;
         }
         if(this._isShowCheckCode)
         {
            this.btn_log.y = this.checkCode.y + 50;
         }
         else
         {
            this.btn_log.y = this.checkCode.y;
         }
         this.checkCode.setVisible(this._isShowCheckCode);
         this.forgetPwdSp.y = this.btn_log.y + (this.btn_log.height - this.forgetPwdSp.height) * 0.5;
      }
      
      private function isInputTxt() : Boolean
      {
         var _loc1_:Boolean = false;
         this._userName = this.checkspace(this.txt_userName.text);
         this._password = this.checkspace(this.txt_password.text);
         if(Boolean(this.checkCode) && Boolean(this.checkCode.visible) && this.checkCode.getCheckTxt() == "")
         {
            this.txt_checkCode_Info.text = "请输入验证码";
            this.txt_checkCode_Info.visible = true;
            this.txt_check_log_info.visible = false;
            return false;
         }
         if(this._userName == "" || this._userName == DEFAULT_USER_NAME || this._password == "" || this._password == DEFAULT_PASSWORD)
         {
            if(this._userName == "" || this._userName == DEFAULT_USER_NAME)
            {
               this.txt_userName.text = DEFAULT_USER_NAME;
               this.txt_userName.textColor = 16711680;
            }
            if(this._password == "" || this._password == DEFAULT_PASSWORD)
            {
               this.txt_password.displayAsPassword = false;
               this.txt_password.text = DEFAULT_PASSWORD;
               this.txt_password.textColor = 16711680;
            }
            _loc1_ = false;
         }
         else if(this._userName == this.mainProxy.userName)
         {
            this.txt_check_log_info.text = "不可重复登录同一账号";
            this.txt_check_log_info.visible = true;
            _loc1_ = false;
         }
         else
         {
            this.txt_password.displayAsPassword = true;
            this.txt_password.textColor = 0;
            this.txt_userName.textColor = 0;
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function showBox() : void
      {
         this.showCheckCode();
         if(this.checkCode.visible)
         {
            this.checkCode.getCheckMap();
         }
         if(this._isShowBox)
         {
            return;
         }
         this._isShowBox = true;
         this.txt_check_log_info.visible = false;
         this.txt_checkCode_Info.visible = false;
         moveCenter();
         show();
         draggable = true;
         this.txt_userName.text = DEFAULT_USER_NAME;
         this.txt_userName.textColor = 0;
         this.txt_password.displayAsPassword = false;
         this.txt_password.text = DEFAULT_PASSWORD;
         this.txt_password.textColor = 0;
         this.checkCode.setCheckTxt();
      }
      
      public function hideBox() : void
      {
         if(!this._isShowBox)
         {
            return;
         }
         hide();
         this._isShowBox = false;
         if(!this.mainProxy.mouseVisible)
         {
            Mouse.hide();
         }
      }
      
      public function setCheckLogInfo(param1:String) : void
      {
         this.txt_checkCode_Info.visible = false;
         switch(param1)
         {
            case AllConst.MVC_SECONDARY_COM_ERROR:
               this.txt_check_log_info.text = "登录失败,请重试";
               break;
            case AllConst.MVC_SECONDARY_IP_ERROR:
               this.txt_check_log_info.text = "IP被锁定";
               break;
            case AllConst.MVC_SECONDARY_LOG_ERROR:
               this.txt_check_log_info.text = "用户名或密码错误";
               break;
            case AllConst.MVC_SECONDARY_USERLOCKED_ERROR:
               this.txt_check_log_info.text = "帐号出售中,限制登录";
         }
         this.txt_check_log_info.visible = true;
      }
      
      public function setCheckCodeInfo() : void
      {
         if(this.checkCode.visible)
         {
            this.txt_checkCode_Info.text = "验证码出错了";
            this.txt_check_log_info.visible = false;
            this.txt_checkCode_Info.visible = true;
         }
      }
   }
}

