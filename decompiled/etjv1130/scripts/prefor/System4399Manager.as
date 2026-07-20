package prefor
{
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.StageAlign;
   import flash.display.StageScaleMode;
   import flash.events.DataEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.system.Security;
   import flash.utils.ByteArray;
   import flash.utils.clearTimeout;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import org.bytearray.gif.events.GIFPlayerEvent;
   import org.bytearray.gif.player.GIFPlayer;
   import org.events.EngineEvent;
   import unit4399.events.SaveEvent;
   import unit4399.road.loader.LoaderManager;
   import unit4399.singleTimer.SingleTimer;
   
   public class System4399Manager extends MovieClip
   {
      
      private var gameID:String = "100018385";
      
      private var PRE_WIDTH:int = 960;
      
      private var PRE_HEIGHT:int = 560;
      
      private var isShowLog:Boolean = true;
      
      private var addUnion:Boolean = true;
      
      private var addRankList:Boolean = true;
      
      private var addMedal:Boolean = false;
      
      private var addShop:Boolean = true;
      
      private var addAdv:Boolean = true;
      
      private var addScore:Boolean = true;
      
      private var addStore:Boolean = true;
      
      private var addGameList:Boolean = false;
      
      private var addPayMoney:Boolean = true;
      
      private var addSecondary:Boolean = false;
      
      private var BaseFile:Class = System4399Manager_BaseFile;
      
      private var _4399Gif:Class = System4399Manager__4399Gif;
      
      private var PreBgFile:Class;
      
      private var gameBg:*;
      
      private var _gifUrl:String = "http://cdn.comment.4399pk.com/control/zwsf2-3.gif";
      
      private var _gifPlayer:GIFPlayer;
      
      private var urlCtrl:String = "http://cdn.comment.4399pk.com/control/ctrl_mo_v5.swf?200";
      
      private var ctrl:*;
      
      private var app:*;
      
      private var loadOK:Boolean = false;
      
      private var advEndShow:Boolean = false;
      
      private var advShowFalg:Boolean = false;
      
      private var __width:int = 0;
      
      private var __height:int = 0;
      
      private var preLoader:Pre918Loader;
      
      private var preBg:Sprite;
      
      private var bgColor:uint = 0;
      
      private var preCount:Number = 0;
      
      private var urlAdvSWf:String = "http://cdn.comment.4399pk.com/control/A4399dv_base.swf?200";
      
      private var adv:*;
      
      private var _cryTimer:SingleTimer;
      
      private var _cryID:int;
      
      private var _barTimer:SingleTimer;
      
      private var _curID:int;
      
      private var _advTimer:SingleTimer;
      
      private var _advID_forTime:int;
      
      private var _getLoadTimer:SingleTimer;
      
      private var _loadTimeID:int;
      
      private var laodCacheFlag:Boolean = false;
      
      private var loadGameUseTime:int = 0;
      
      private const INTEGRAL_MODE:String = "integralMode";
      
      private const SAVE_MODE:String = "saveMode";
      
      private const CHALLENGE_MODE:String = "challengeMode";
      
      private const GAMElIST_MODE:String = "gameListMode";
      
      private const PAYMONEY_MODE:String = "payMoney";
      
      private const SHOP_MODE:String = "shopMode";
      
      private const MEDAL_MODE:String = "medalMode";
      
      private const RANKLIST_MODE:String = "rankListMode";
      
      private const UNION_MODE:String = "unionMode";
      
      private const SECONDARY_MODE:String = "secondaryMode";
      
      private var secondOverLoad:Boolean = false;
      
      private var _isShowAd:Boolean = false;
      
      private var advType:String = "-1";
      
      private var _bgLoader:Loader;
      
      private var nowWid:int;
      
      private var nowHei:int;
      
      private var repeatCount:int = 0;
      
      private var resInfoUrl:String = "http://stat.api.4399.com/flash_ctrl_version.xml";
      
      private var _isRun:Boolean;
      
      private const adEffTime:int = 1000;
      
      private var _adShowOldTime:int;
      
      private var _adShowRunIndex:int;
      
      private var _isShowAdBol:Boolean;
      
      private var _completeFunc:Function;
      
      private var _runArrList:Array;
      
      private var _showInc:int;
      
      private var m_checkLoaded:uint;
      
      private const CHECK_TIME:Number = 0.1;
      
      private var initOnce:Boolean = false;
      
      private var _adStart:Boolean;
      
      private var _bgLoadComplete:Boolean;
      
      private var _isHitAdv:Boolean;
      
      public function System4399Manager()
      {
         super();
         Security.allowDomain("*");
         Security.allowInsecureDomain("*");
         this.addEventListener("##crygameok##",this._cryGameOK);
         stage.addEventListener("##no_base##",this._no_baseXML);
         stage.addEventListener("##adv_start_show##",this._adv_start_show);
         stage.addEventListener("##no_adv_startgame##",this._no_adv_startgame);
         this.addEventListener(Event.ENTER_FRAME,this.onResizeHandler);
         stage.scaleMode = StageScaleMode.SHOW_ALL;
         stage.align = StageAlign.TOP_LEFT;
         stop();
         this.__width = this.PRE_WIDTH;
         this.__height = this.PRE_HEIGHT;
         this.nowWid = this.PRE_WIDTH;
         this.nowHei = this.PRE_HEIGHT;
         Pre918Loader.dimension = [this.PRE_WIDTH,this.PRE_HEIGHT];
         this.preBg = new Sprite();
         this.preBg.graphics.beginFill(this.bgColor,1);
         this.preBg.graphics.drawRect(0,0,Pre918Loader.dimension[0],Pre918Loader.dimension[1]);
         this.preBg.graphics.endFill();
         addChild(this.preBg);
         this.loadResInfo();
      }
      
      private function loadResInfo() : void
      {
         this.resInfoUrl = this.resInfoUrl + "?ran=" + Math.random() * 100000;
         LoaderManager.loadBytes(this.resInfoUrl,this.loadResInfoHandler);
      }
      
      private function loadResInfoHandler(param1:Event) : void
      {
         var _loc3_:* = undefined;
         if(param1.type != Event.COMPLETE)
         {
            if(this.repeatCount < 2)
            {
               ++this.repeatCount;
               this.loadResInfo();
               return;
            }
         }
         this.repeatCount = 0;
         var _loc2_:XML = XML(param1.target.data);
         if(_loc2_)
         {
            for(_loc3_ in _loc2_.info)
            {
               switch(String(_loc2_.info[_loc3_].@resName))
               {
                  case "zwsf":
                     this._gifUrl = String(_loc2_.info[_loc3_]);
                     break;
                  case "ctrl_v5":
                     this.urlCtrl = String(_loc2_.info[_loc3_]);
                     break;
                  case "ads":
                     this.urlAdvSWf = String(_loc2_.info[_loc3_]);
               }
            }
         }
         this.executeCode();
      }
      
      private function executeCode() : void
      {
         this.getGameLoadingFun();
         this.getBgPng();
         this.preLoader = new Pre918Loader();
         stage.addChild(this.preLoader);
         this._barTimer = SingleTimer.getInstance();
         this._barTimer.runInterval = 500;
         this._curID = this._barTimer.addTask(500,1000,this,this.barTimeShow);
         LoaderManager.setup();
         this.getBgMov();
         LoaderManager.loadDisplay(this.urlAdvSWf,this.getAdvSwf);
         var _loc1_:SaveEvent = new SaveEvent("ss",null);
         loaderInfo.addEventListener(Event.COMPLETE,this.gameLoadFromCache);
         this.gameLoadFromCache();
      }
      
      private function onResizeHandler(param1:Event = null) : void
      {
         if(stage.stageWidth >= this.__width && stage.stageHeight >= this.__height)
         {
            if(this.preLoader)
            {
               this.preLoader.resizeFun(1,1);
            }
            this.resizeMc(this._gifPlayer,1,1);
            this.resizeMc(this._bgLoader,1,1);
            return;
         }
         var _loc2_:Number = 2 - stage.stageWidth / this.__width;
         var _loc3_:Number = 2 - stage.stageHeight / this.__height;
         _loc2_ = Number(_loc2_.toFixed(2));
         _loc3_ = Number(_loc3_.toFixed(2));
         if(_loc2_ > _loc3_)
         {
            _loc3_ = _loc2_;
         }
         else
         {
            _loc2_ = _loc3_;
         }
         if(this.preLoader)
         {
            this.preLoader.resizeFun(_loc2_ + 0.1,_loc3_ + 0.1);
         }
         this.resizeMc(this._gifPlayer,_loc2_,_loc3_);
         this.resizeMc(this._bgLoader,_loc2_,_loc3_);
      }
      
      private function resizeMc(param1:DisplayObject, param2:Number, param3:Number) : void
      {
         if(param1 == null || param1.scaleX == param2 && param1.scaleY == param3)
         {
            return;
         }
         var _loc4_:Number = param1.width;
         var _loc5_:Number = param1.height;
         param1.scaleX = param2;
         param1.scaleY = param3;
         if(this.contains(param1))
         {
            param1.x -= (param1.width - _loc4_) * 0.5;
            param1.y -= (param1.height - _loc5_) * 0.5;
         }
      }
      
      private function getBgMov() : void
      {
         this._4399preOver(null);
      }
      
      private function getGameLoadingFun() : void
      {
         if(!this.isShowLog)
         {
            return;
         }
         if(this._gifPlayer == null)
         {
            this._gifPlayer = new GIFPlayer();
            this._gifPlayer.addEventListener(GIFPlayerEvent.COMPLETE,this.gifLoadCompleteHandler,false,0,true);
            this._gifPlayer.addEventListener(IOErrorEvent.IO_ERROR,this.gifLoadFaulitHandler,false,0,true);
            this._gifPlayer.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.gifLoadFaulitHandler,false,0,true);
            this._gifPlayer.load(new URLRequest(this._gifUrl));
         }
      }
      
      private function gifLoadCompleteHandler(param1:GIFPlayerEvent) : void
      {
         if(this._gifPlayer == null)
         {
            return;
         }
         this._gifPlayer.x = int(this.__width) / 2 - 110;
         this._gifPlayer.y = int(this.__height) / 2 - 50;
         addChild(this._gifPlayer);
         if(this.adv)
         {
            this.swapChildren(this.adv,this._gifPlayer);
         }
         this.delGifListener();
      }
      
      private function gifLoadFaulitHandler(param1:Event) : void
      {
         this.delGifListener();
         this.delGifFun();
      }
      
      private function delGifFun() : void
      {
         if(this._gifPlayer != null)
         {
            this._gifPlayer.dispose();
            if(contains(this._gifPlayer))
            {
               removeChild(this._gifPlayer);
            }
            this._gifPlayer = null;
         }
      }
      
      private function delGifListener() : void
      {
         if(this._gifPlayer != null)
         {
            this._gifPlayer.removeEventListener(GIFPlayerEvent.COMPLETE,this.gifLoadCompleteHandler);
            this._gifPlayer.removeEventListener(IOErrorEvent.IO_ERROR,this.gifLoadFaulitHandler);
            this._gifPlayer.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.gifLoadFaulitHandler);
         }
      }
      
      private function getAdvSwf(param1:Loader, param2:Event) : void
      {
         if(param2.type == "complete")
         {
            this.adv = param1.content;
            addChild(this.adv);
            this.adv.base = new XML(new this.BaseFile());
            this.adv.gameid = this.gameID;
            if(this._isShowAd)
            {
               this.doShowAdv();
            }
         }
      }
      
      private function _4399preOver(param1:Event = null) : void
      {
         this._isShowAd = true;
         if(this.adv)
         {
            this.doShowAdv();
         }
      }
      
      private function doShowAdv() : void
      {
         this.adv.showAdv();
         this.startShowAdEff([this.adv],true);
      }
      
      private function startShowAdEff(param1:Array, param2:Boolean, param3:Function = null) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:DisplayObject = null;
         this._isShowAdBol = param2;
         this._completeFunc = param3;
         this._runArrList = param1;
         var _loc4_:int = 0;
         if(!this._isRun)
         {
            this._isRun = true;
            if(this._isShowAdBol)
            {
               _loc4_ = 0;
            }
            else
            {
               _loc4_ = 1;
            }
            _loc6_ = int(this._runArrList.length);
            _loc5_ = 0;
            while(_loc5_ < _loc6_)
            {
               _loc7_ = this._runArrList[_loc5_] as DisplayObject;
               _loc7_.alpha = _loc4_;
               _loc5_++;
            }
            this._showInc = 0;
            this._adShowRunIndex = 0;
            this._adShowOldTime = getTimer();
            stage.addEventListener(Event.ENTER_FRAME,this.showAdEff);
         }
      }
      
      private function showAdEff(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:DisplayObject = null;
         var _loc7_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc2_:int = getTimer() - this._adShowOldTime;
         var _loc3_:Number = _loc2_ / 75 * 0.05;
         _loc5_ = int(this._runArrList.length);
         var _loc8_:Boolean = false;
         if(_loc2_ >= 4500)
         {
            _loc8_ = true;
         }
         if(this._isShowAdBol && _loc3_ >= 1)
         {
            _loc8_ = true;
         }
         if(!this._isShowAdBol && _loc3_ >= 1)
         {
            _loc8_ = true;
         }
         if(this._isShowAdBol)
         {
            _loc7_ = _loc3_;
            if(_loc8_)
            {
               _loc9_ = 1;
            }
         }
         else
         {
            _loc7_ = 1 - _loc3_;
            if(_loc8_)
            {
               _loc9_ = 0;
            }
         }
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = this._runArrList[_loc4_] as DisplayObject;
            if(_loc8_)
            {
               _loc6_.alpha = _loc9_;
            }
            else
            {
               _loc6_.alpha = _loc7_;
            }
            _loc4_++;
         }
         if(_loc8_)
         {
            stage.removeEventListener(Event.ENTER_FRAME,this.showAdEff);
            this._isRun = false;
            if(this._completeFunc != null)
            {
               this._completeFunc();
            }
         }
      }
      
      private function __barTimeShow_for_gameFromCache(param1:int, param2:Array = null) : void
      {
         this.preLoader.setProgress(param1,25);
         if(param1 == 20)
         {
            this.initApplication();
         }
      }
      
      private function __barTimeShow_for_gameFromNet() : void
      {
         this.advEndShow = true;
         if(this.loadOK)
         {
            this.initApplication();
         }
      }
      
      private function progressHandle(param1:ProgressEvent) : void
      {
         this.preLoader._setProgress(Number(param1.bytesLoaded / param1.bytesTotal) - 0.1);
      }
      
      private function gameLoadFromCache(param1:Event = null) : void
      {
         if(loaderInfo.bytesLoaded < loaderInfo.bytesTotal)
         {
            this.m_checkLoaded = setTimeout(this.gameLoadFromCache,this.CHECK_TIME * 1000);
            return;
         }
         clearTimeout(this.m_checkLoaded);
         this.loadOK = true;
         this.loadGameUseTime = getTimer();
         if(loaderInfo.hasEventListener(ProgressEvent.PROGRESS))
         {
            loaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.progressHandle);
         }
         loaderInfo.removeEventListener(Event.COMPLETE,this.gameLoadFromCache);
         if(this.loadGameUseTime < 1500)
         {
            this.laodCacheFlag = true;
         }
         if(this.advEndShow)
         {
            this.initApplication();
         }
      }
      
      private function barTimeShow(param1:int, param2:Array = null) : void
      {
         this.preLoader.setProgress(param1,1000);
         if(param1 == 20)
         {
            this._barTimer.delTask(this._curID);
            this.errorFun();
         }
      }
      
      private function initApplication() : void
      {
         if(!this.initOnce)
         {
            LoaderManager.loadDisplay(this.urlCtrl,this.getCtrl);
            this.initOnce = true;
            return;
         }
      }
      
      private function getCtrl(param1:Loader, param2:Event) : void
      {
         if(param2.type == "complete")
         {
            this.ctrl = param1.content;
            this.ctrl.advType = this.advType;
         }
         addEventListener(Event.ENTER_FRAME,this.initGame);
      }
      
      private function initGame(param1:Event) : void
      {
         var _loc2_:* = undefined;
         if(framesLoaded == totalFrames)
         {
            removeEventListener(Event.ENTER_FRAME,this.initGame);
            nextFrame();
            _loc2_ = getDefinitionByName("L4399Main") as Class;
            this.app = new _loc2_(this);
            stage.addChild(this.app);
            this.app.visible = false;
            this._cryTimer = SingleTimer.getInstance();
            this._cryID = this._cryTimer.addTask(500,20,this,this._showLastBar);
            this.preCount = this.preLoader.preCount;
         }
      }
      
      private function _showLastBar(param1:int, param2:Array = null) : void
      {
         this.preLoader._setProgress(this.preCount + 0.003 * param1);
         if(param1 == 20)
         {
            this.removeEventListener("##crygameok##",this._cryGameOK);
            this._cryTimer.delTask(this._cryID);
            if(this.adv)
            {
               this.adv.disposeAll();
            }
            this.preLoader._setProgress(1);
            this.lastFun();
         }
      }
      
      private function _cryGameOK(param1:Event) : void
      {
         var e:Event = param1;
         this._cryTimer.delTask(this._cryID);
         this.preLoader._setProgress(1);
         setTimeout(function():void
         {
            lastFun();
         },300);
      }
      
      private function intoGame() : void
      {
         var _loc1_:Object = null;
         var _loc2_:ByteArray = null;
         var _loc3_:XML = null;
         stage.addChild(this.app);
         this.app.visible = true;
         stage.removeEventListener("##no_base##",this._no_baseXML);
         stage.removeEventListener("##adv_start_show##",this._adv_start_show);
         stage.removeEventListener("##no_adv_startgame##",this._no_adv_startgame);
         if(this.ctrl)
         {
            stage.dispatchEvent(new EngineEvent("xctrl",this.ctrl));
            stage.addChild(this.ctrl);
            _loc1_ = new Object();
            _loc1_[this.CHALLENGE_MODE] = false;
            _loc1_[this.INTEGRAL_MODE] = this.addScore;
            _loc1_[this.SAVE_MODE] = this.addStore;
            _loc1_[this.GAMElIST_MODE] = this.addGameList;
            _loc1_[this.PAYMONEY_MODE] = this.addPayMoney;
            _loc1_[this.SHOP_MODE] = this.addShop;
            _loc1_[this.MEDAL_MODE] = this.addMedal;
            _loc1_[this.RANKLIST_MODE] = this.addRankList;
            _loc1_[this.UNION_MODE] = this.addUnion;
            _loc1_[this.SECONDARY_MODE] = this.addSecondary;
            _loc2_ = new this.BaseFile();
            _loc3_ = XML(_loc2_.readUTFBytes(_loc2_.bytesAvailable));
            this.ctrl.setStyle(this.gameID,_loc1_,_loc3_);
            if(this.addStore && !this.addScore)
            {
               this.ctrl.setMenuVisible(false);
            }
         }
      }
      
      private function lastFun() : void
      {
         this.hitAd();
      }
      
      private function _adv_start_show(param1:*) : void
      {
         var _loc2_:String = null;
         var _loc3_:Array = null;
         this.delGifFun();
         this._adStart = true;
         if(param1 is DataEvent)
         {
            _loc2_ = String(param1.data);
            _loc3_ = _loc2_.split("|");
            if(_loc3_.length != 3)
            {
               this.advType = "999";
            }
            else
            {
               this.advType = _loc3_[0].toString();
            }
         }
         else
         {
            this.advType = "999";
         }
         this.preLoader.showText();
         this.delgameBg();
         this._barTimer.delTask(this._curID);
         this._advTimer = SingleTimer.getInstance();
         if(this.laodCacheFlag)
         {
            this._advID_forTime = this._advTimer.addTask(500,20,this,this.__barTimeShow_for_gameFromCache);
         }
         else if(this.loadOK)
         {
            this._advID_forTime = this._advTimer.addTask(500,20,this,this.__barTimeShow_for_gameFromCache);
         }
         else
         {
            loaderInfo.addEventListener(ProgressEvent.PROGRESS,this.progressHandle);
            setTimeout(this.__barTimeShow_for_gameFromNet,10000);
         }
      }
      
      private function delgameBg() : void
      {
         if(this.gameBg != null)
         {
            if(contains(this.gameBg))
            {
               removeChild(this.gameBg);
            }
            this.gameBg = null;
         }
      }
      
      private function _no_adv_startgame(param1:Event) : void
      {
         this.errorFun();
      }
      
      private function _no_baseXML(param1:Event) : void
      {
         this.errorFun();
      }
      
      private function errorFun() : void
      {
         this.delgameBg();
         this._barTimer.delTask(this._curID);
         if(this.loadOK)
         {
            this.initApplication();
         }
         else
         {
            loaderInfo.addEventListener(ProgressEvent.PROGRESS,this.progressHandle);
            this.advEndShow = true;
         }
      }
      
      private function hitAd() : void
      {
         this._isHitAdv = true;
         if(this._bgLoadComplete)
         {
            this.doHitAdv();
         }
      }
      
      private function runShowLog() : void
      {
         if(this.adv != null)
         {
            this.adv.visible = false;
         }
         this.preLoader.visible = false;
         if(this.adv)
         {
            if(contains(this.adv))
            {
               removeChild(this.adv);
            }
            this.adv.disposeAll();
            this.adv = null;
         }
         if(this.isShowLog)
         {
            this.startShowAdEff([this._bgLoader],true,this.showLogFunc);
         }
         else
         {
            this.runHitLogFinish();
         }
      }
      
      private function showLogFunc() : void
      {
         setTimeout(this.runHitLog,1000);
      }
      
      private function runHitLog() : void
      {
         this.startShowAdEff([this._bgLoader,this.preBg],false,this.runHitLogFinish);
      }
      
      private function runHitLogFinish() : void
      {
         removeEventListener(Event.ENTER_FRAME,this.onResizeHandler);
         stage.removeChild(this.preLoader);
         this.preLoader = null;
         if(this._bgLoader != null)
         {
            this._bgLoader.visible = false;
            if(contains(this._bgLoader))
            {
               removeChild(this._bgLoader);
            }
            this._bgLoader.unload();
            this._bgLoader = null;
         }
         if(this.preBg != null)
         {
            this.preBg.visible = false;
            if(contains(this.preBg))
            {
               removeChild(this.preBg);
            }
            this.preBg = null;
         }
         this.intoGame();
      }
      
      private function getBgPng() : void
      {
         this._bgLoader = new Loader();
         this._bgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.bgLogLoadComplete);
         this._bgLoader.loadBytes(new this._4399Gif() as ByteArray);
      }
      
      private function bgLogLoadComplete(param1:Event) : void
      {
         this._bgLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.bgLogLoadComplete);
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(this.__width) / 2 - 110;
         _loc3_ = int(this.__height) / 2 - 50;
         this._bgLoader.x = _loc2_;
         this._bgLoader.y = _loc3_;
         this._bgLoader.alpha = 0;
         addChild(this._bgLoader);
         this._bgLoadComplete = true;
         if(this._isHitAdv)
         {
            this.doHitAdv();
         }
      }
      
      private function doHitAdv() : void
      {
         this.delGifFun();
         stage.addChildAt(this.app,0);
         this.app.visible = true;
         if(this._adStart)
         {
            if(this.isShowLog)
            {
               this.startShowAdEff([this.adv],false,this.runShowLog);
            }
            else
            {
               this.startShowAdEff([this.adv,this.preBg],false,this.runShowLog);
            }
         }
         else if(this.isShowLog)
         {
            this.runShowLog();
         }
         else
         {
            this.startShowAdEff([this.preBg],false,this.runShowLog);
         }
      }
   }
}

