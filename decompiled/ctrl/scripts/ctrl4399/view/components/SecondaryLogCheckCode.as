package ctrl4399.view.components
{
   import ctrl4399.proxy.SecondaryProxy;
   import ctrl4399.strconst.AllConst;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   import frame4399.simplePureMvc.core.Facade;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol132")]
   public class SecondaryLogCheckCode extends MovieClip
   {
      
      private var stageHold:*;
      
      private var _regCheck:TextField;
      
      private var checkMap:Sprite;
      
      private var changMap:Sprite;
      
      private var imgWid:int = 70;
      
      private var imgHei:int = 30;
      
      private var _secondaryProxy:SecondaryProxy;
      
      public function SecondaryLogCheckCode()
      {
         super();
         if(this.checkMap == null)
         {
            this.checkMap = new Sprite();
         }
         this.checkMap.x = 133;
         this.checkMap.y = -1;
         if(!this.contains(this.checkMap))
         {
            this.addChild(this.checkMap);
         }
         if(this.changMap == null)
         {
            this.changMap = new Sprite();
         }
         var _loc1_:TextField = new TextField();
         _loc1_.defaultTextFormat = new TextFormat("宋体",15,12237498,null,null,true);
         _loc1_.mouseEnabled = false;
         _loc1_.selectable = false;
         _loc1_.autoSize = "left";
         _loc1_.wordWrap = false;
         _loc1_.multiline = false;
         _loc1_.text = "看不清，换一张";
         this.changMap.addChild(_loc1_);
         this.changMap.buttonMode = true;
         this.changMap.focusRect = false;
         this.changMap.addEventListener(MouseEvent.CLICK,this.__changMap);
         this.changMap.x = this.checkMap.x + this.checkMap.width + 10;
         this.changMap.y = this.checkMap.y + (this.checkMap.height - this.changMap.height) * 0.5;
         if(!this.contains(this.changMap))
         {
            this.addChild(this.changMap);
         }
         if(this._regCheck == null)
         {
            this._regCheck = new TextField();
         }
         this._regCheck.name = "_regCheck";
         this._regCheck.defaultTextFormat = new TextFormat("宋体",15);
         this._regCheck.width = 150;
         this._regCheck.height = 22;
         this._regCheck.type = TextFieldType.INPUT;
         this._regCheck.restrict = "0-9A-Za-z";
         this._regCheck.text = "";
         this._regCheck.maxChars = 4;
         this._regCheck.tabEnabled = true;
         this._regCheck.tabIndex = 0;
         this._regCheck.x = 70;
         this._regCheck.y = 4;
         if(!this.contains(this._regCheck))
         {
            this.addChild(this._regCheck);
         }
         this.addEventListener(FocusEvent.FOCUS_IN,this.onFocusInHandler);
      }
      
      private function onFocusInHandler(param1:FocusEvent) : void
      {
         if(this.stageHold != null)
         {
            this.stageHold.focus = this._regCheck;
         }
      }
      
      public function setStage(param1:*) : void
      {
         this.stageHold = param1;
      }
      
      public function getCheckTxt() : String
      {
         return this._regCheck.text;
      }
      
      public function setCheckTxt(param1:String = "") : void
      {
         this._regCheck.text = param1;
      }
      
      private function __changMap(param1:MouseEvent) : void
      {
         if(this.stageHold != null)
         {
            this.stageHold.focus = this._regCheck;
         }
         this.getCheckMap();
      }
      
      private function get secondaryProxy() : SecondaryProxy
      {
         if(!this._secondaryProxy)
         {
            this._secondaryProxy = Facade.getInstance().retrieveProxy(AllConst.PROXY_NAME_SECONDARY) as SecondaryProxy;
         }
         return this._secondaryProxy;
      }
      
      public function getCheckMap() : void
      {
         var urlReq:URLRequest;
         var l:Loader = null;
         var fun:Function = null;
         fun = function(param1:Event):void
         {
            if(param1.type != "complete")
            {
               return;
            }
            while(checkMap.numChildren > 0)
            {
               checkMap.removeChildAt(0);
            }
            var _loc2_:* = l.content;
            if(_loc2_ == null)
            {
               return;
            }
            _loc2_.width = imgWid;
            _loc2_.height = imgHei;
            checkMap.addChild(_loc2_);
            if(changMap == null)
            {
               return;
            }
            changMap.x = checkMap.x + checkMap.width + 5;
            changMap.y = checkMap.y + (checkMap.height - changMap.height) * 0.5;
         };
         l = new Loader();
         var variables:URLVariables = new URLVariables();
         variables.captcha_key = this.secondaryProxy.captcha_key;
         urlReq = new URLRequest(AllConst.URL_SECONDARY_CHECK_CODE + "&" + Math.random());
         urlReq.data = variables;
         urlReq.method = "POST";
         l.contentLoaderInfo.addEventListener(Event.COMPLETE,fun);
         l.load(urlReq);
      }
      
      public function setVisible(param1:Boolean) : void
      {
         this.visible = param1;
      }
      
      public function setPos(param1:int, param2:int) : void
      {
         this.x = param1;
         this.y = param2;
      }
   }
}

