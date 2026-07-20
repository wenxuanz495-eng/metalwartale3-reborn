package ctrl4399.view.components.as3Ad4399Frame
{
   import ctrl4399.strconst.AllConst;
   import flash.display.Loader;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import org.bytearray.gif.events.GIFPlayerEvent;
   import org.bytearray.gif.player.GIFPlayer;
   
   public class ADContent extends Sprite
   {
      
      private var _loader:Loader;
      
      private var _gifPlayer:GIFPlayer;
      
      private var _gifUrl:String;
      
      private var _gifClickUrl:String;
      
      private var _wid:Number;
      
      private var _hei:Number;
      
      private var _isInit:Boolean;
      
      private var _isSetData:Boolean;
      
      private var _gifClickURLRequest:URLRequest;
      
      private var _gameid:String;
      
      public function ADContent()
      {
         super();
         if(stage)
         {
            this.init();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.init);
         }
      }
      
      public static function setCenter(param1:Number, param2:Number, param3:Number, param4:Number, param5:Boolean = false) : Array
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         if(param1 <= param3 && param2 <= param4 && !param5)
         {
            _loc6_ = param1;
            _loc7_ = param2;
            _loc8_ = 1;
         }
         else if(param1 / param3 > param2 / param4)
         {
            _loc8_ = param3 / param1;
            _loc6_ = param3;
            _loc7_ = _loc8_ * param2;
         }
         else
         {
            _loc8_ = param4 / param2;
            _loc6_ = _loc8_ * param1;
            _loc7_ = param4;
         }
         return [_loc6_,_loc7_,_loc8_];
      }
      
      private function init(param1:Event = null) : void
      {
         if(param1 != null)
         {
            removeEventListener(Event.ADDED_TO_STAGE,this.init);
         }
         this._isInit = true;
         if(this._isSetData)
         {
            this.doSetData();
         }
      }
      
      public function setData(param1:String, param2:String, param3:Number, param4:Number, param5:String) : void
      {
         this._gameid = param5;
         if(param1 == AllConst.URL_GAME_LIST_DEFAULT_AD)
         {
            this._gifClickUrl = AllConst.URL_GAME_LIST_DEFAULT_AD_REDICT;
         }
         else
         {
            this._gifClickUrl = param2 + "&r=" + this._gameid;
         }
         this._gifUrl = param1;
         this._wid = param3;
         this._hei = param4;
         this._gifClickURLRequest = new URLRequest(this._gifClickUrl);
         this._isSetData = true;
         if(this._isInit)
         {
            this.doSetData();
         }
      }
      
      private function doSetData() : void
      {
         var _loc1_:Shape = null;
         _loc1_ = this.drawShape(this._wid,this._hei);
         addChild(_loc1_);
         if(this._gifUrl.toLowerCase().lastIndexOf(".gif") != -1)
         {
            if(this._gifPlayer == null)
            {
               this._gifPlayer = new GIFPlayer();
               this._gifPlayer.addEventListener(GIFPlayerEvent.COMPLETE,this.gifLoadCompleteHandler,false,0,true);
               this._gifPlayer.addEventListener(IOErrorEvent.IO_ERROR,this.gifLoadFaulitHandler,false,0,true);
               this._gifPlayer.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.gifLoadFaulitHandler,false,0,true);
               this._gifPlayer.load(new URLRequest(this._gifUrl));
               addChild(this._gifPlayer);
            }
         }
         else if(this._loader == null)
         {
            this._loader = new Loader();
            this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadCompleteHandler,false,0,true);
            this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.loadFaiuteHandler,false,0,true);
            this._loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.gifLoadFaulitHandler,false,0,true);
            this._loader.load(new URLRequest(this._gifUrl));
            addChild(this._loader);
         }
         mouseChildren = false;
         mouseEnabled = true;
         buttonMode = true;
         addEventListener(MouseEvent.CLICK,this.clickAdHandler,false,0,true);
      }
      
      private function loadCompleteHandler(param1:Event) : void
      {
      }
      
      private function loadFaiuteHandler(param1:Event) : void
      {
      }
      
      private function clickAdHandler(param1:MouseEvent) : void
      {
         try
         {
            navigateToURL(this._gifClickURLRequest,"_blank");
         }
         catch(e:Error)
         {
         }
      }
      
      private function gifLoadCompleteHandler(param1:GIFPlayerEvent) : void
      {
      }
      
      private function gifLoadFaulitHandler(param1:Event) : void
      {
      }
      
      private function delListener() : void
      {
         if(this._gifPlayer != null)
         {
            this._gifPlayer.removeEventListener(GIFPlayerEvent.COMPLETE,this.gifLoadCompleteHandler);
            this._gifPlayer.removeEventListener(IOErrorEvent.IO_ERROR,this.gifLoadFaulitHandler);
            this._gifPlayer.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.gifLoadFaulitHandler);
         }
         if(this._loader != null)
         {
            this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.loadCompleteHandler);
            this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.loadFaiuteHandler);
            this._loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.gifLoadFaulitHandler);
         }
      }
      
      private function drawShape(param1:Number, param2:Number) : Shape
      {
         var _loc3_:Shape = null;
         _loc3_ = new Shape();
         _loc3_.graphics.beginFill(0,0);
         _loc3_.graphics.drawRect(0,0,param1,param2);
         _loc3_.graphics.endFill();
         return _loc3_;
      }
      
      public function dispose() : void
      {
         this.delListener();
         if(this._gifPlayer != null)
         {
            this._gifPlayer.dispose();
            if(contains(this._gifPlayer))
            {
               removeChild(this._gifPlayer);
            }
            this._gifPlayer = null;
         }
         if(this._loader != null)
         {
            if(contains(this._loader))
            {
               removeChild(this._loader);
            }
            this._loader = null;
         }
         removeEventListener(MouseEvent.CLICK,this.clickAdHandler);
      }
   }
}

