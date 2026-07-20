package ctrl4399.view.components
{
   import ctrl4399.proxy.MainProxy;
   import ctrl4399.strconst.AllConst;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.ui.Mouse;
   import frame4399.simplePureMvc.core.Facade;
   import org.heaven.impl.tot.Singleton;
   import org.hell.SetBox;
   
   public class NetFailureUI extends SetBox
   {
      
      private var _btnTxt:TextField;
      
      private var _btnTxtFormat:TextFormat;
      
      private var _btn:SimpleButton;
      
      private var _facade:Facade = Facade.getInstance();
      
      private var mainProxy:MainProxy;
      
      private var _titleTxt:TextField;
      
      private var _showMode:int;
      
      public function NetFailureUI()
      {
         super();
         this.mainProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_MAIN) as MainProxy;
         var _loc1_:Class = Singleton.getClass(AllConst.SPC_NET_FAILURE_BTN);
         this._btn = new _loc1_() as SimpleButton;
         var _loc2_:Object = new Object();
         _loc2_.viewClass = Singleton.getClass(AllConst.SPC_NET_FAILURE_VIEW);
         _loc2_.contentViewClass = Singleton.getClass(AllConst.SPC_RegCont);
         _loc2_.tfd = new TextFormat();
         initSetBox("",_loc2_,null,this.checkBtnFun,null);
         setBtnVisible();
         this._btnTxt = new TextField();
         this.initBtnTxt();
         this._titleTxt = view["tmp"]["titleTxt"] as TextField;
         this._titleTxt.selectable = false;
         this._titleTxt.mouseWheelEnabled = false;
         view["tmp"]["btn"].visible = false;
         append(this._btn,view["tmp"]["btn"].x + view["tmp"].x,view["tmp"]["btn"].y + view["tmp"].y);
         append(this._btnTxt,this._btn.x,this._btn.y);
         setStageSize(502,402);
         moveCenter();
         this._btn.addEventListener(MouseEvent.CLICK,this.btnClickHandler,false,0,true);
         this._btn.visible = false;
         addEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler,false,0,true);
         addEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHanlder,false,0,true);
         addEventListener(MouseEvent.MOUSE_UP,this.mouseRollOverHandler,false,0,true);
         addEventListener(MouseEvent.MOUSE_DOWN,this.mouseRollOverHandler,false,0,true);
      }
      
      private function setBtn() : void
      {
         this._btn.width = this._btnTxt.width;
         this._btn.height = this._btnTxt.height;
         this._btn.x = (view["tmp"].width - this._btn.width) / 2;
         this._btn.y = view["tmp"]["btn"].y + view["tmp"].y + view.y;
         this._btnTxt.x = this._btn.x;
         this._btnTxt.y = this._btn.y;
      }
      
      public function getShowMode() : int
      {
         return this._showMode;
      }
      
      public function setShowMode(param1:int) : void
      {
         this._showMode = param1;
      }
      
      private function showLocalGetMode() : void
      {
         this._titleTxt.text = "读取本地存档";
         this._btnTxt.text = "读取本地存档";
         this._btnTxt.setTextFormat(this._btnTxtFormat,0,this._btnTxt.length);
         this.setBtn();
      }
      
      private function showLocalSaveMode() : void
      {
         this._titleTxt.text = "保存档案到本地";
         this._btnTxt.text = "本地存档";
         this._btnTxt.setTextFormat(this._btnTxtFormat,0,this._btnTxt.length);
         this.setBtn();
      }
      
      private function showNetMode() : void
      {
         this._titleTxt.text = "对不起,\n网络连接不上，你可以选择";
         this._btnTxt.text = "本地存档";
         this._btnTxt.setTextFormat(this._btnTxtFormat,0,this._btnTxt.length);
         this.setBtn();
      }
      
      public function showTitle(param1:String) : void
      {
         this._titleTxt.text = param1;
      }
      
      private function btnClickHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new Event(AllConst.BTN_DOWN));
      }
      
      private function mouseRollOverHandler(param1:MouseEvent = null) : void
      {
         this._facade.sendNotification(AllConst.SET_AS2_FOCUSMANAGER);
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
      
      private function initBtnTxt() : void
      {
         this._btnTxt = new TextField();
         this._btnTxt.selectable = false;
         this._btnTxt.mouseWheelEnabled = false;
         this._btnTxt.mouseEnabled = false;
         this._btnTxt.text = "";
         this._btnTxt.autoSize = TextFieldAutoSize.LEFT;
         this._btnTxtFormat = new TextFormat();
         this._btnTxtFormat.color = 0;
         this._btnTxtFormat.underline = true;
         this._btnTxtFormat.font = "宋体";
         this._btnTxtFormat.size = 24;
      }
      
      private function checkBtnFun(param1:* = null, param2:int = -1) : void
      {
      }
      
      public function disPose() : void
      {
         this.closeHandler(null);
      }
      
      override protected function closeHandler(param1:Event) : void
      {
         super.closeHandler(param1);
         if(!this.mainProxy.mouseVisible)
         {
            Mouse.hide();
         }
         if(this._btnTxt)
         {
            this._btnTxt = null;
         }
         if(this._btn)
         {
            this._btn.removeEventListener(MouseEvent.CLICK,this.btnClickHandler);
            this._btn = null;
         }
         removeEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHanlder);
         removeEventListener(MouseEvent.MOUSE_UP,this.mouseRollOverHandler);
         removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseRollOverHandler);
         dispatchEvent(new Event(AllConst.CLOSE_BTN_CLICK));
         trace("close");
      }
   }
}

