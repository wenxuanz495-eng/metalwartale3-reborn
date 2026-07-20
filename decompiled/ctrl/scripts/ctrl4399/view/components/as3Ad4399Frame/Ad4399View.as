package ctrl4399.view.components.as3Ad4399Frame
{
   import flash.display.AVM1Movie;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import flash.net.LocalConnection;
   import flash.net.URLRequest;
   import flash.system.Security;
   import unit4399.road.loader.LoaderManager;
   
   public class Ad4399View extends Sprite
   {
      
      public static const SEND_NAME:String = "_ADV_AS2";
      
      public static const REV_NAME:String = "_ADV_AS3";
      
      public static const AD_URL:String = "https://cdn.comment.4399pk.com/control/gameList_a4399d.swf";
      
      public static const MAX_LINK_TIME:int = 3;
      
      public static const MAX_LOAD_TIME:int = 2;
      
      public static const MAX_LOAD_TIMEOUT:int = 8;
      
      public static const SEND_MOTHED:String = "receiveHandler";
      
      private var _myBtnUp:Sprite;
      
      private var _myBtnDown:Sprite;
      
      private var _myBtnLeft:Sprite;
      
      private var _myBtnRight:Sprite;
      
      private var _loader:Loader;
      
      private var _urlRequest:URLRequest;
      
      private var _lc:LocalConnection;
      
      private var _revName:String;
      
      private var _sendName:String;
      
      private var _curLinkTime:int;
      
      private var _linkNum:uint;
      
      private var _adAVM1:AVM1Movie;
      
      private var _restLoadADAS2Times:int;
      
      private var _timeoutId:uint;
      
      private var _loadADAS2Failed:Boolean = false;
      
      private var _adObj:Object;
      
      private var _isLoad:Boolean;
      
      private var _isSet:Boolean;
      
      private var _isConnect:Boolean;
      
      public function Ad4399View()
      {
         super();
         if(stage == null)
         {
            addEventListener(Event.ADDED_TO_STAGE,this.init);
         }
         else
         {
            this.init();
         }
      }
      
      public function receiveHandler(param1:Object) : void
      {
         if(param1 == null || param1.func == null)
         {
            return;
         }
         this[param1.func](param1.param);
      }
      
      private function loadAdError(param1:Array = null) : void
      {
         trace("广告加载失败");
      }
      
      private function loadAdOK(param1:Array = null) : void
      {
         trace("广告加载成功");
         trace("_loader.width = " + this._loader.width + "          _loder.height = " + this._loader.height);
      }
      
      private function connect(param1:Array = null) : void
      {
         trace("@@@@@@@@@@@@@@@@@@@@@@@");
         this._isConnect = true;
         if(this._isSet)
         {
            trace(this._adObj.pubWidth);
            this.sendHandler({
               "func":"loadAd",
               "param":[this._adObj]
            });
         }
      }
      
      public function loadAs2Ad(param1:Object) : void
      {
         this._isSet = true;
         this._adObj = param1;
         if(this._isLoad)
         {
            this.doLoad();
         }
      }
      
      private function doLoad() : void
      {
         LoaderManager.loadDisplay(AD_URL,this.loadAdCompleteHandler);
      }
      
      private function init(param1:Event = null) : void
      {
         Security.allowDomain("http://googleads.g.doubleclick.net");
         Security.allowInsecureDomain("http://googleads.g.doubleclick.net");
         if(param1 != null)
         {
            removeEventListener(Event.ADDED_TO_STAGE,this.init);
         }
         addEventListener(Event.REMOVED_FROM_STAGE,this.removeHandler);
         this._isLoad = true;
         if(this._isSet)
         {
            this.doLoad();
         }
      }
      
      private function loadAdCompleteHandler(param1:Loader, param2:Event) : void
      {
         if(param2.type != "complete")
         {
            return;
         }
         if(!this.tryLinkAs2())
         {
            ++this._curLinkTime;
            if(this._curLinkTime >= MAX_LINK_TIME)
            {
               this.loadAdError();
               return;
            }
         }
         else
         {
            this._adAVM1 = param1.content as AVM1Movie;
            if(this._adAVM1 == null)
            {
               this.loadAdError();
               return;
            }
            (this._adAVM1 as Object)["opaqueBackground"] = this._linkNum;
            addChild(param1);
            trace("^^^^^^^^&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
            this._loader = param1;
            trace(param1);
         }
      }
      
      private function tryLinkAs2() : Boolean
      {
         try
         {
            if(this._lc == null)
            {
               this._lc = new LocalConnection();
            }
            this._lc.allowDomain("*");
            this._lc.allowInsecureDomain("*");
            this._linkNum = this.createNum();
            this._sendName = Ad4399View.SEND_NAME + this._linkNum;
            this._revName = Ad4399View.REV_NAME + this._linkNum;
            this._lc.connect(this._revName);
            this._lc.client = this;
         }
         catch(e:Error)
         {
            return false;
         }
         return true;
      }
      
      private function loadAdprogressHandler(param1:ProgressEvent) : void
      {
         trace(param1.bytesLoaded + "     " + param1.bytesTotal);
      }
      
      private function createNum() : uint
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc1_ = Math.random() * 255;
         _loc2_ = Math.random() * 255;
         _loc3_ = Math.random() * 255;
         return uint(_loc1_ << 16 | _loc2_ << 8 | _loc3_);
      }
      
      private function removeHandler(param1:Event) : void
      {
         trace("移除---------------REMOVED_FROM_STAGE");
         removeEventListener(Event.REMOVED_FROM_STAGE,this.removeHandler);
         this.sendHandler({"func":"disPos"});
         if(this._lc != null)
         {
            this._lc.close();
            this._lc = null;
         }
      }
      
      private function sendHandler(param1:Object) : void
      {
         if(this._lc == null || !this._isConnect)
         {
            return;
         }
         this._lc.send(this._sendName,SEND_MOTHED,param1);
      }
   }
}

