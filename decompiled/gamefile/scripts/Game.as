package
{
   import UI.LoadingUI;
   import UI.TestTextUI;
   import UI.UIGroup;
   import UI.dialog.DialogboxGroup;
   import UI.fase.FaseUI;
   import UI.fase.LoaderBar;
   import body.define.DefineGroup;
   import body.enemy.EnemyHeroCtrl;
   import body.hero.HeroCarBody;
   import body.key.KeysGroup;
   import bodyGroup.BodyGroup;
   import bodyGroup.BodyGroupHit;
   import bodyGroup.BodyGroupRefresh;
   import data.Copyright;
   import data.StringDate;
   import effect.EffectGroup;
   import effect.text.RiseTextGroup;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.TimerEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.ui.Keyboard;
   import flash.ui.Mouse;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import gameAll.EventGroup;
   import gameAll.GameDefine;
   import gameAll.High_API;
   import gameAll.PayController;
   import gameAll.SeverTimeAPI;
   import gameAll.TaskCreater;
   import gameAll.TimeDateCtrl;
   import gameAll.api.Shop_API;
   import gameAll.api.Union_API;
   import gameAll.api.save.SaveAPI;
   import gameAll.data.GameData;
   import gameAll.define.NewDefineGroup;
   import gameAll.define.TipsDefine;
   import gameAll.level.LevelGroup;
   import gameAll.other.CheatingController;
   import flash.text.TextFormat;
   import gameAll.save.SaveController;
   import gameAll.sensitive.SensitiveWords;
   import goods.ExchangeDefine;
   import goods.GoodsDefineGroup;
   import goods.GrowGiftDefine;
   import goods.LeveLGiftDefine;
   import goods.StarGiftDefine;
   import goods.TurnTableDefine;
   import goods.UnionShopDefine;
   import image.BmpMovieClipManager;
   import image.GameSprite;
   import items.ItemsController;
   import items.ItemsDefineGroup;
   import items.ItemsGroup;
   import net.SWFLoaderManager;
   import net.TextLoaderManager;
   import other.XTimer;
   import scene.OneSence;
   import sound.OneMusic;
   import sound.SoundGroup;
   import test.Stats;
   import unit4399.events.PayEvent;
   import unit4399.events.RankListEvent;
   
   [SWF(frameRate="30",backgroundColor="#333333",width="960",height="560")]
   public class Game extends MovieClip
   {
      
      public static var stage0:Stage;
      
      public static var ME:Game;
      
      public static var faseUI:FaseUI;
      
      public static var testText:TestTextUI;
      
      public static var loadingUI:LoadingUI;
      
      public static var payController:PayController;
      
      public static var payController2:PayController;
      
      public static var high_api:High_API;
      
      public static var stageWidth:int = 960;
      
      public static var stageHeight:int = 560;
      
      public static var _4399_id:String = "20293";
      
      public static var _4399_function_ad_id:String = "92d6cef76cd06829e088932fe9fd819b";
      
      public static var _4399_function_store_id:String = "3885799f65acec467d97b4923caebaae";
      
      public static var _4399_function_score_id:String = "d8c8d4731a33a0a581edc746e73eadc7200";
      
      public static var _4399_function_payMoney_id:String = "10f73c09b41d9f41e761232f5f322f38";
      
      public static var serviceHold:* = null;
      
      public static var versionNumber:String = "3.5";
      
      public static var versionName:String = "超合金战记3.0";
      
      public static var allTips:TipsDefine = new TipsDefine();
      
      public static var textLoaderManager:TextLoaderManager = new TextLoaderManager();
      
      public static var swfLoaderManager:SWFLoaderManager = new SWFLoaderManager();
      
      public static var bmpMovieClipManager:BmpMovieClipManager = new BmpMovieClipManager();
      
      public static var saveController:SaveController = new SaveController();
      
      public static var SG:SoundGroup = new SoundGroup();
      
      public static var gameSprite:GameSprite = new GameSprite();
      
      public static var gameDefine:GameDefine = new GameDefine();
      
      public static var defineGroup:DefineGroup = new DefineGroup();
      
      public static var newDG:NewDefineGroup = new NewDefineGroup();
      
      public static var itemsDefineGroup:ItemsDefineGroup = new ItemsDefineGroup();
      
      public static var goodsDefineGroup:GoodsDefineGroup = new GoodsDefineGroup();
      
      public static var exchangeDefineGroup:ExchangeDefine = new ExchangeDefine();
      
      public static var levelGiftDefineGroup:LeveLGiftDefine = new LeveLGiftDefine();
      
      public static var turnTableDefineGroup:TurnTableDefine = new TurnTableDefine();
      
      public static var unionShopDefineGroup:UnionShopDefine = new UnionShopDefine();
      
      public static var startGiftDefineGroup:StarGiftDefine = new StarGiftDefine();
      
      public static var growGiftDefineGroup:GrowGiftDefine = new GrowGiftDefine();
      
      public static var gameData:GameData = new GameData();
      
      public static var IC:ItemsController = new ItemsController();
      
      public static var uiGroup:UIGroup = new UIGroup();
      
      public static var cheating:CheatingController = new CheatingController();

      // 【开发诊断工具】F2 帧率慢放（特效逐帧分析用），逻辑内联于本类；禁止随玩家包发行。
      public static var diagSlowMoSlowB:Boolean = false;

      public static var diagSlowMoBadge:TextField = null;

      public static var timeDate:TimeDateCtrl = new TimeDateCtrl();
      
      public static var severTime:SeverTimeAPI = new SeverTimeAPI();
      
      public static var taskCreater:TaskCreater = new TaskCreater();
      
      public static var union_api:Union_API = new Union_API();
      
      public static var save_api:SaveAPI = new SaveAPI();
      
      public static var shop_api:Shop_API = new Shop_API();
      
      public static var sensitiveWords:SensitiveWords = new SensitiveWords();
      
      public static var itemsGroup:ItemsGroup = new ItemsGroup();
      
      public static var textGroup:RiseTextGroup = new RiseTextGroup();
      
      public static var BG:BodyGroup = new BodyGroup();
      
      public static var BGRefresh:BodyGroupRefresh = new BodyGroupRefresh();
      
      public static var BGHit:BodyGroupHit = new BodyGroupHit();
      
      public static var enemyCtrl:EnemyHeroCtrl = new EnemyHeroCtrl();
      
      public static var eventGroup:EventGroup = new EventGroup();
      
      public static var EG:EffectGroup = new EffectGroup();
      
      public static var oneScene:OneSence = new OneSence();
      
      public static var LG:LevelGroup = new LevelGroup();
      
      public static var keysGroup:KeysGroup = new KeysGroup();
      
      public static var dialogboxGroup:DialogboxGroup = new DialogboxGroup();
      
      public static var gameState:* = "no";
      
      public static var saveExistB:Boolean = false;
      
      public static var gamingTimerB:Boolean = true;
      
      public static var severDateTarget:String = "getSaveDate";
      
      public static var severDateAffterFun:String = "";
      
      public static var testTimeAdjust:int = 0;
      
      private static var lastClientErrorMsg:String = "";
      
      private static var lastClientErrorAt:int = 0;
      
      public var mouseShowB:Boolean = true;
      
      internal var _4399_function_rankList_id:String = "69f52ab6eb1061853a761ee8c26324ae";
      
      internal var _4399_function_shop_id:String = "30ea6b51a23275df624b781c3eb43ac6";
      
      internal var _4399_function_union_id:String = "7c7a741b186b91e2975006321918345f";
      
      internal var MK:Stats = new Stats();
      
      internal var copyright:Copyright;
      
      public var timer5:XTimer = new XTimer(5);
      
      public var timer1:XTimer = new XTimer();
      
      public var music:OneMusic;
      
      private var loaderTarget:int = 0;

      private var levelResourceRetryCount:int = 0;

      private const MAX_LEVEL_RESOURCE_RETRIES:int = 2;
      
      public var logoMc:*;
      
      public var testShow_txt:TextField;
      
      public function Game()
      {
         super();
         if(Boolean(stage))
         {
            this.firstLoad();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.firstLoad);
         }
      }
      
      public static function get nowSaveIndex() : int
      {
         return gameData.nowSaveIndex;
      }
      
      public static function inTimeGetSaveDate(time00:String) : StringDate
      {
         var tar0:StringDate = timeDate["getSaveDate"];
         if(time00 != "")
         {
            tar0.inData_byStr(time00);
            tar0.date += testTimeAdjust;
         }
         else
         {
            tar0.inData_byObj(new StringDate());
         }
         return tar0;
      }
      
      public static function getNowLocalTime() : String
      {
         var date0:Date = new Date();
         var date1:StringDate = new StringDate();
         date1.inData_byObj(date0);
         return date1.getStr();
      }
      
      public static function getIsLoginB() : Boolean
      {
         return save_api.s4399.isLogin();
      }
      
      public static function clearGameData() : *
      {
         var gd:GameData = new GameData();
         gd.testAddArmsItems();
         replaceGameData(gd);
      }
      
      public static function replaceGameData(gd:Object) : *
      {
         if(Boolean(gd))
         {
            saveExistB = true;
            gameData.inData_byObj(gd,true);
         }
         else
         {
            clearGameData();
            saveExistB = false;
         }
         payController2.nowRecharged = 0;
         uiGroup.clearNew();
         eventGroup.fleshEquip();
         uiGroup.gameInit();
      }
      
      public static function zuobiTest() : *
      {
         gameData.isZuobi = false;
         gameData.zuobiStr = "";
      }
      
      public static function getTest() : Boolean
      {
         if(Boolean(gameDefine))
         {
            return gameDefine.getTestB();
         }
         return false;
      }
      
      public static function allowLoginB(name0:String) : Boolean
      {
         if(cheating.checkZuobi)
         {
            if(Boolean(gameDefine))
            {
               return gameDefine.accountLimit.pan(name0,getTest());
            }
            return true;
         }
         return true;
      }
      
      public static function reportClientError(kind:String, message:String, stack:String = "", extra:String = "") : *
      {
         var now:int = 0;
         var req:URLRequest = null;
         var loader:URLLoader = null;
         var body:String = null;
         try
         {
            if(message == null)
            {
               message = "";
            }
            if(stack == null)
            {
               stack = "";
            }
            if(kind == null || kind == "")
            {
               kind = "error";
            }
            now = getTimer();
            if(message == lastClientErrorMsg && now - lastClientErrorAt < 1500)
            {
               return;
            }
            lastClientErrorMsg = message;
            lastClientErrorAt = now;
            body = "{\"kind\":\"" + escapeClientLog(kind) + "\",\"message\":\"" + escapeClientLog(message) + "\",\"stack\":\"" + escapeClientLog(stack) + "\",\"extra\":\"" + escapeClientLog(extra) + "\",\"time\":" + now + "}";
            req = new URLRequest("api/client-log");
            req.method = URLRequestMethod.POST;
            req.contentType = "application/json; charset=utf-8";
            req.data = body;
            loader = new URLLoader();
            loader.addEventListener(IOErrorEvent.IO_ERROR,ignoreClientLog);
            loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,ignoreClientLog);
            loader.addEventListener(Event.COMPLETE,ignoreClientLog);
            loader.load(req);
         }
         catch(e:*)
         {
         }
      }
      
      private static function escapeClientLog(value:String) : String
      {
         if(value == null)
         {
            return "";
         }
         value = value.split("\\").join("\\\\");
         value = value.split("\"").join("\\\"");
         value = value.split("\r").join("\\r");
         value = value.split("\n").join("\\n");
         value = value.split("\t").join("\\t");
         if(value.length > 4000)
         {
            value = value.substr(0,4000);
         }
         return value;
      }
      
      private static function ignoreClientLog(e:Event = null) : *
      {
      }
      
      public function setHold(hold:*) : *
      {
         serviceHold = null;
         testText.addTestText("离线版已忽略网页服务对象。");
      }
      
      private function checkVersion() : void
      {
         gameDefine.nowLevel = 1;
         versionNumber = "11.3";
         TextLoaderManager.IsLocal = false;
      }
      
      protected function onTimer(event:TimerEvent) : void
      {
      }
      
      private function rightClickHandler(e:*) : *
      {
      }
      
      private function firstLoad(e:Event = null) : *
      {
         // Match Flash Player's “Show All” behavior by default so the full game
         // canvas is visible when the SWF starts, regardless of window size.
         stage.scaleMode = StageScaleMode.SHOW_ALL;
         if(e != null)
         {
            removeEventListener(Event.ADDED_TO_STAGE,this.init);
         }
         swfLoaderManager.addEventListener(Event.COMPLETE,this.affter_firstLoad);
         swfLoaderManager.addSWFLoader("swf/main910.swf","main","破坏物");
         swfLoaderManager.startLoad();
      }
      
      private function affter_firstLoad(e:Event) : *
      {
         swfLoaderManager.removeEventListener(Event.COMPLETE,this.affter_firstLoad);
         this.logoMc = swfLoaderManager.getResource("main","logo_mc");
         addChild(this.logoMc);
         this.init();
      }
      
      public function init(e:Event = null) : *
      {
         ME = this;
         // The loaded UI framework may reset the root stage to NO_SCALE;
         // apply the requested Flash Player “Show All” mode after it loads.
         stage.scaleMode = StageScaleMode.SHOW_ALL;
         this.checkVersion();
         payController = new PayController();
         payController2 = new PayController();
         high_api = new High_API();
         this.copyright = new Copyright(this);
         stage.stageFocusRect = false;
         this.installClientErrorReporting();
         this.logoMc.clickMc.addEventListener(MouseEvent.CLICK,this.gotoDuchy);
         stage0 = this.stage;
         addChildAt(gameSprite,0);
         this.MK.x = this.stage.stageWidth - 100;
         this.MK.visible = false;
         addChild(this.MK);
         loadingUI = new LoadingUI();
         addChild(loadingUI);
         loadingUI.hide();
         testText = new TestTextUI();
         addChild(testText);
         testText.visible = false;
         stage.addEventListener(KeyboardEvent.KEY_UP,this.keyUp);
         faseUI = new FaseUI();
         gameSprite.goHomeL.addChild(faseUI);
         uiGroup.faseUI = faseUI;
         faseUI.visible = true;
         faseUI.versionNumber_txt.text = "当前游戏版本：" + versionNumber;
         stage.addEventListener(KeyboardEvent.KEY_UP,cheating.cheating);
         // 【开发诊断工具】F2 帧率慢放（特效逐帧分析用）：按 F2 在 30fps 与 1fps 间切换，
         // 慢放时左上角显示固定标记。独立监听，不影响任何游戏按键逻辑；禁止随玩家包发行。
         stage.addEventListener(KeyboardEvent.KEY_UP,this.diagSlowMoToggle);
         diagSlowMoBadge = new TextField();
         diagSlowMoBadge.defaultTextFormat = new TextFormat("_sans",14,16724806,true);
         diagSlowMoBadge.text = "[DIAG SLOW-MO 1fps - F2]";
         diagSlowMoBadge.x = 8;
         diagSlowMoBadge.y = 8;
         diagSlowMoBadge.width = 260;
         diagSlowMoBadge.height = 22;
         diagSlowMoBadge.selectable = false;
         diagSlowMoBadge.mouseEnabled = false;
         diagSlowMoBadge.visible = false;
         addChild(diagSlowMoBadge);
         saveController.GAME = this;
         this.addSaveEvent();
         this.textLoad();
      }
      
      private function diagSlowMoToggle(event:KeyboardEvent) : *
      {
         if(event.keyCode != 113)
         {
            return;
         }
         diagSlowMoSlowB = !diagSlowMoSlowB;
         if(diagSlowMoSlowB)
         {
            stage.frameRate = 1;
            diagSlowMoBadge.visible = true;
         }
         else
         {
            stage.frameRate = 30;
            diagSlowMoBadge.visible = false;
         }
      }

      public function headLoadTimer(event:*) : *
      {
         var txt0:TextField = this.logoMc.loadMc.loadMc.loadMc;
         var baifen:Number = loaderInfo.bytesLoaded / loaderInfo.bytesTotal * 100;
         txt0.text = String(int(baifen)) + "%";
         if(baifen >= 100)
         {
            if(this.logoMc.currentLabel != "start")
            {
               if(this.logoMc.currentLabel == "play")
               {
                  this.removeEventListener(Event.ENTER_FRAME,this.headLoadTimer);
                  this.logoMc.continueBn.addEventListener(MouseEvent.CLICK,this.headToPlay);
                  this.headToPlay();
               }
               else
               {
                  this.logoMc.loadMc.visible = false;
                  this.logoMc.gotoAndPlay("start");
               }
            }
         }
      }
      
      public function headToPlay(event:* = null) : *
      {
         trace("播放");
         this.logoMc.continueBn.removeEventListener(MouseEvent.CLICK,this.headToPlay);
         this.logoMc.gotoAndPlay("play");
         this.addEventListener(Event.ENTER_FRAME,this.headPlayTimer);
      }
      
      public function headPlayTimer(event:*) : *
      {
         if(this.logoMc.currentFrame >= this.logoMc.totalFrames)
         {
            this.stage.quality = "high";
            this.removeEventListener(Event.ENTER_FRAME,this.headPlayTimer);
            this.textLoad();
         }
      }
      
      public function gotoDuchy(event:*) : *
      {
      }
      
      public function loaderShowTimer(event:*) : *
      {
         var loader0:LoaderBar = faseUI.loader;
         if(this.loaderTarget == 0)
         {
            loader0.setBaifen(textLoaderManager.baifenNum);
            loader0.setText("正在加载文本数据：" + int(textLoaderManager.baifenNum * 100) + "%");
         }
         else if(this.loaderTarget == 1)
         {
            loader0.setBaifen(swfLoaderManager.baifen);
            loader0.setText(swfLoaderManager.numText + "正在加载" + swfLoaderManager.stateText + "数据：" + swfLoaderManager.baifenText);
         }
      }
      
      internal function textLoad() : *
      {
         this.removeChild(this.logoMc);
         faseUI.showLoaderBar();
         this.loaderTarget = 0;
         faseUI.showLogo();
         this.addEventListener(Event.ENTER_FRAME,this.loaderShowTimer);
         if(TextLoaderManager.IsLocal)
         {
            textLoaderManager.addTextLoader("xml/skill.xml","skill");
            textLoaderManager.addTextLoader("xml/drop.xml","drop");
            textLoaderManager.addTextLoader("xml/arms61.xml","arms");
            textLoaderManager.addTextLoader("xml/car280.xml","car");
            textLoaderManager.addTextLoader("xml/carProperty.xml","carProperty");
            textLoaderManager.addTextLoader("xml/subCar.xml","subCar");
            textLoaderManager.addTextLoader("xml/subArms52.xml","subArms");
            textLoaderManager.addTextLoader("xml/enemy25.xml","enemy");
            textLoaderManager.addTextLoader("xml/enemyArms25.xml","enemyArms");
            textLoaderManager.addTextLoader("xml/scene.xml","scene");
            textLoaderManager.addTextLoader("xml/level280.xml","level");
            textLoaderManager.addTextLoader("xml/items260.xml","items");
            textLoaderManager.addTextLoader("xml/goods250.xml","goods");
            textLoaderManager.addTextLoader("xml/enemyData.xml","enemyData");
            textLoaderManager.addTextLoader("xml/dirtyWord.xml","dirtyWord");
            textLoaderManager.addTextLoader("xml/exchangeConfig.xml","exchangeConfig");
            textLoaderManager.addTextLoader("xml/dengjilibao.xml","dengjilibao");
            textLoaderManager.addTextLoader("xml/turntable.xml","turntable");
            textLoaderManager.addTextLoader("xml/unionshop.xml","unionshop");
            textLoaderManager.addTextLoader("xml/starconfig.xml","starconfig");
            textLoaderManager.addTextLoader("xml/growconfig.xml","growconfig");
            textLoaderManager.addEventListener(Event.COMPLETE,this.textLoader_complete);
            textLoaderManager.startLoad();
         }
         else
         {
            this.textLoader_complete(null);
         }
      }
      
      internal function textLoader_complete(e:Event) : *
      {
         textLoaderManager.removeEventListener(Event.COMPLETE,this.textLoader_complete);
         swfLoaderManager.addSWFLoader("swf/dataMust280.swf","dataMust","定义");
         swfLoaderManager.addSWFLoader("swf/ui/dialogbox450.swf","dialogbox","对话框");
         swfLoaderManager.addSWFLoader("swf/ui/VipUI470.swf","VipUI","UI");
         swfLoaderManager.addSWFLoader("swf/ui/DailySignUI460.swf","DailySignUI","UI");
         swfLoaderManager.addSWFLoader("swf/ui/HelperUI.swf","HelperUI","UI");
         swfLoaderManager.addSWFLoader("swf/ui/BookUI760.swf","BookUI","UI");
         swfLoaderManager.addSWFLoader("swf/ui/ConArmsUpgradeUI.swf","ConArmsUpgradeUI","UI");
         swfLoaderManager.addSWFLoader("swf/ui/PlayerTrainUI450.swf","PlayerTrainUI","UI");
         swfLoaderManager.addSWFLoader("swf/ui/GameOverUI490.swf","GameOverUI","UI");
         swfLoaderManager.addSWFLoader("swf/ui/PayActivityUI440.swf","PayActivityUI","UI");
         swfLoaderManager.addSWFLoader("swf/ui/union800.swf","union","UI");
         swfLoaderManager.addSWFLoader("swf/ui/LevelPic1100.swf","LevelPic","UI");
         swfLoaderManager.addSWFLoader("swf/scene/things.swf","things","破坏物");
         swfLoaderManager.addSWFLoader("swf/bullet.swf","bullet","子弹");
         swfLoaderManager.addSWFLoader("swf/ui/items1060.swf","itemsUI","物品");
         swfLoaderManager.addSWFLoader("swf/items/items.swf","items","物品");
         swfLoaderManager.addSWFLoader("swf/car1130.swf","car","战车");
         swfLoaderManager.addSWFLoader("swf/parts.swf","parts","配件");
         swfLoaderManager.addSWFLoader("swf/heroFly.swf","heroFly","配件");
         swfLoaderManager.addSWFLoader("swf/arms1100.swf","arms","主武器");
         swfLoaderManager.addSWFLoader("swf/sub1130.swf","sub","副武器");
         swfLoaderManager.addSWFLoader("swf/sub25.swf","sub25","2.5浮游战机外观");
         swfLoaderManager.addSWFLoader("swf/ui/sever1130.swf","sever","UI");
         swfLoaderManager.addSWFLoader("swf/ui/notice1130.swf","notice","UI");
         swfLoaderManager.addSWFLoader("swf/newui1130.swf","newui","UI");
         swfLoaderManager.addSWFLoader("swf/ui1120.swf","ui","UI");
         swfLoaderManager.addSWFLoader("swf/sound/sound.swf","sound","音效");
         swfLoaderManager.addSWFLoader("swf/music/Decisions.swf","Decisions","音效");
         swfLoaderManager.addEventListener(Event.COMPLETE,this.uiLoader_complete);
         swfLoaderManager.startLoad();
         this.loaderTarget = 1;
      }
      
      internal function uiLoader_complete(e:Event) : *
      {
         var xx:*;
         var xxx:*;
         var dgxx:DefineGroup;
         var d00:*;
         var soundMustData_swf:*;
         var soundArr:Array;
         var musicArr:Array;
         var hero0:HeroCarBody;
         var bootMsg:String;
         var bootStack:String;
         var testMc0:Sprite = null;
         swfLoaderManager.removeEventListener(Event.COMPLETE,this.uiLoader_complete);
         try
         {
            Game.reportClientError("boot-step","uiLoader_complete start");
            save_api.init();
            SG.addMusic(swfLoaderManager.getResource("Decisions","Decisions"),"Decisions");
            this.music = SG.getMusic("Decisions");
            if(this.music != null)
            {
               this.music.play(10000);
            }
            gameData.levelsMax = gameDefine.levelsMax;
            gameDefine.drop.inData_byXML(XML(textLoaderManager.getResource("drop").data));
            gameDefine.drop.test();
            defineGroup.addData_byXML(XML(textLoaderManager.getResource("arms").data),"arms");
            defineGroup.addData_byXML(XML(textLoaderManager.getResource("subArms").data),"subArms");
            defineGroup.addData_byXML(XML(textLoaderManager.getResource("enemyArms").data),"enemyArms");
            defineGroup.addCarData_byXML(XML(textLoaderManager.getResource("car").data));
            defineGroup.addEnemyName_byXML(XML(textLoaderManager.getResource("enemy").data));
            defineGroup.skill.inData_byXML(XML(textLoaderManager.getResource("skill").data));
            defineGroup.init();
            newDG.inCarData_byXML(XML(textLoaderManager.getResource("carProperty").data));
            newDG.car.test();
            xx = newDG;
            itemsDefineGroup.addData_byXML(XML(textLoaderManager.getResource("items").data));
            goodsDefineGroup.inData_byXML(XML(textLoaderManager.getResource("goods").data));
            exchangeDefineGroup.inData_byXML(XML(textLoaderManager.getResource("exchangeConfig").data));
            levelGiftDefineGroup.inData_byXML(XML(textLoaderManager.getResource("dengjilibao").data));
            turnTableDefineGroup.inData_byXML(XML(textLoaderManager.getResource("turntable").data));
            unionShopDefineGroup.inData_byXML(XML(textLoaderManager.getResource("unionshop").data));
            startGiftDefineGroup.inData_byXML(XML(textLoaderManager.getResource("starconfig").data));
            growGiftDefineGroup.inData_byXML(XML(textLoaderManager.getResource("growconfig").data));
            LG.inAllXML(XML(textLoaderManager.getResource("level").data));
            LG.filter.inEnemyData_byXML(XML(textLoaderManager.getResource("enemyData").data));
            xxx = LG;
            oneScene.inAllXML(XML(textLoaderManager.getResource("scene").data));
            goodsDefineGroup.init(itemsDefineGroup.addMaterialGift());
            dgxx = defineGroup;
            d00 = defineGroup.getArmsDefine("Twogun",0);
            sensitiveWords.init(XML(textLoaderManager.getResource("dirtyWord").data));
            uiGroup.init();
            IC.init();
            soundMustData_swf = swfLoaderManager.getResource("sound","MustSoundData");
            soundArr = null;
            musicArr = null;
            if(soundMustData_swf != null)
            {
               soundArr = soundMustData_swf.soundMustArr;
               musicArr = soundMustData_swf.musicMustArr;
            }
            if(soundArr == null)
            {
               soundArr = [];
            }
            if(musicArr == null)
            {
               musicArr = [];
            }
            SG.addMusicList(musicArr);
            SG.addSoundList(soundArr);
            BG.init();
            EG.init();
            BGRefresh.init();
            BGHit.init();
            dialogboxGroup.init();
            hero0 = BG.addHeroCarBody();
            eventGroup.init(this);
            itemsGroup.init();
            textGroup.init();
            uiGroup.extraUI.extraNameArr = LG.extraArr;
            uiGroup.extraUI.weekExtraNameArr = LG.weekExtraArr;
            uiGroup.extraUI.specialExtraNameArr = LG.specialExtraNameArr;
            Game.gameSprite.addChild(uiGroup.gamingUI.pointer);
            uiGroup.gamingUI.pointer.visible = false;
            this.addEventListener(Event.ENTER_FRAME,this.allTimer);
            bmpMovieClipManager.addResource(swfLoaderManager.getResource("sub","missile_bullet_smoke"),"sub","missile_bullet_smoke");
            bmpMovieClipManager.addResource(swfLoaderManager.getResource("sub","missile_bullet_smoke_0"),"sub","missile_bullet_smoke_0");
            bmpMovieClipManager.addResource(swfLoaderManager.getResource("arms","plasma_lv1_smoke"),"arms","plasma_lv1_smoke");
            bmpMovieClipManager.addResource(swfLoaderManager.getResource("arms","plasma_lv2_smoke"),"arms","plasma_lv2_smoke");
            bmpMovieClipManager.addResource(swfLoaderManager.getResource("arms","plasma_lv3_smoke"),"arms","plasma_lv3_smoke");
            bmpMovieClipManager.addResource(swfLoaderManager.getResource("arms","plasma_lv4_smoke"),"arms","plasma_lv4_smoke");
            bmpMovieClipManager.addResource(swfLoaderManager.getResource("arms","amplitude_lv1_smoke"),"arms","amplitude_lv1_smoke");
            bmpMovieClipManager.addResource(swfLoaderManager.getResource("arms","amplitude_lv2_smoke"),"arms","amplitude_lv2_smoke");
            bmpMovieClipManager.addResource(swfLoaderManager.getResource("arms","phaseTransfer_lv1_smoke"),"arms","phaseTransfer_lv1_smoke");
            bmpMovieClipManager.addResource(swfLoaderManager.getResource("arms","phaseTransfer_lv2_smoke"),"arms","phaseTransfer_lv2_smoke");
            bmpMovieClipManager.addResource(swfLoaderManager.getResource("arms","conBullet_smoke"),"arms","conBullet_smoke");
            bmpMovieClipManager.addResource(swfLoaderManager.getResource("sub","protonImpact_lv1_smoke"),"sub","protonImpact_lv1_smoke");
            bmpMovieClipManager.addResource(swfLoaderManager.getResource("sub","protonImpact_lv2_smoke"),"sub","protonImpact_lv2_smoke");
            bmpMovieClipManager.addResource(swfLoaderManager.getResource("arms","dragonHead_lv1_smoke"),"arms","dragonHead_lv1_smoke");
            bmpMovieClipManager.addResource(swfLoaderManager.getResource("arms","beelzebub_lv1_smoke"),"arms","beelzebub_lv1_smoke");
            bmpMovieClipManager.addResource(swfLoaderManager.getResource("arms","moumouGun_lv1_smoke"),"arms","moumouGun_lv1_smoke");
            bmpMovieClipManager.addResource(swfLoaderManager.getResource("sub","blueKnife_lv1_smoke"),"sub","blueKnife_lv1_smoke");
            bmpMovieClipManager.addResource(swfLoaderManager.getResource("heroFly","lighting"),"heroFly","lighting");
            SG.addSound(swfLoaderManager.getResource("heroFly","lighting_sound"),"lighting_sound");
            uiGroup.show("fase");
            faseUI.startGame_btn.addEventListener(MouseEvent.CLICK,this.faseNewGameClick);
            faseUI.continueGame_btn.addEventListener(MouseEvent.CLICK,this.faseContinueGameClick);
            this.removeEventListener(Event.ENTER_FRAME,this.loaderShowTimer);
            if(getTest())
            {
               testMc0 = swfLoaderManager.getResource("ui","testShowText");
               testMc0.x = stageWidth;
               testMc0.y = stageHeight;
               testMc0.mouseEnabled = false;
               this.addChild(testMc0);
            }
            save_api.game_init();
            Game.reportClientError("boot-step","uiLoader_complete done");
         }
         catch(bootErr:*)
         {
            bootMsg = "uiLoader_complete failed: " + bootErr;
            bootStack = "";
            try
            {
               if(bootErr != null && bootErr.hasOwnProperty("getStackTrace") && bootErr.getStackTrace is Function)
               {
                  bootStack = String(bootErr.getStackTrace());
               }
            }
            catch(e3:*)
            {
            }
            Game.reportClientError("boot-fail",bootMsg,bootStack);
            try
            {
               this.removeEventListener(Event.ENTER_FRAME,this.loaderShowTimer);
               faseUI.hideLoaderBar();
               uiGroup.show("fase");
            }
            catch(e4:*)
            {
            }
         }
      }
      
      public function addSaveEvent() : *
      {
         stage.addEventListener("multipleError",payController.multipleErrorHandler,false,0,true);
         stage.addEventListener("StoreStateEvent",payController.getStoreStateHandler,false,0,true);
         stage.addEventListener(PayEvent.LOG,payController.onPayEventHandler,false,0,true);
         stage.addEventListener("usePayApi",payController.onPayEventHandler,false,0,true);
         stage.addEventListener(PayEvent.INC_MONEY,payController.onPayEventHandler,false,0,true);
         stage.addEventListener(PayEvent.DEC_MONEY,payController.onPayEventHandler,false,0,true);
         stage.addEventListener(PayEvent.GET_MONEY,payController.onPayEventHandler,false,0,true);
         stage.addEventListener(PayEvent.PAY_MONEY,payController.onPayEventHandler,false,0,true);
         stage.addEventListener(PayEvent.PAY_ERROR,payController.onPayEventHandler,false,0,true);
         stage.addEventListener(PayEvent.PAIED_MONEY,payController2.onPayEventHandler,false,0,true);
         stage.addEventListener(PayEvent.RECHARGED_MONEY,payController2.onPayEventHandler,false,0,true);
         stage.addEventListener(RankListEvent.RANKLIST_ERROR,high_api.onRankListErrorHandler);
         stage.addEventListener(RankListEvent.RANKLIST_SUCCESS,high_api.onRankListSuccessHandler);
         shop_api.init(stage);
         union_api.init(stage);
         stage.addEventListener("serverTimeEvent",severTime.onGetServerTimeHandler);
      }
      
      public function getLocalB() : Boolean
      {
         return save_api.isLocal();
      }
      
      public function faseBtnShow() : *
      {
         loadingUI.hide();
         if(saveExistB)
         {
            faseUI.showPlayBtn(3);
            this.faseContinueGameClick(null);
         }
         else
         {
            faseUI.showPlayBtn();
            this.faseNewGameClick(null);
         }
      }
      
      public function faseNewGameClick(event:MouseEvent) : *
      {
         if(saveExistB)
         {
            uiGroup.checkTip.showCheck("开始新的游戏将覆盖原来的存档，是否继续？",this.startNewGame);
         }
         else
         {
            this.startNewGame();
         }
      }
      
      public function faseContinueGameClick(event:MouseEvent) : *
      {
         uiGroup.show("startGame");
         gameDefine.test2();
         uiGroup.mainUI.showLivenessUI();
      }
      
      public function startNewGame() : *
      {
         clearGameData();
         uiGroup.show("login");
      }
      
      public function chosenLevel(level0:int = 0) : *
      {
         this.closeLevel();
         gameState = "chosen";
         trace("选择关卡：" + level0 + "   当前状态：" + gameState);
         uiGroup.show("loader");
         LG.chosenLevel(level0);
         this.levelResourceRetryCount = 0;
         this.queueLevelResources();
      }

      private function queueLevelResources() : *
      {
         swfLoaderManager.addSWFLoader("swf/effect/levelUp.swf","levelUp","特效");
         swfLoaderManager.addSWFLoader("swf/effect/emp.swf","emp","特效");
         swfLoaderManager.addSWFLoader("swf/enemy/Spider.swf","Spider","敌人");
         swfLoaderManager.addSWFLoader("swf/enemy/SmallWarden.swf","SmallWarden","敌人");
         swfLoaderManager.addSWFLoader("swf/enemy/Satellite_small.swf","Satellite_small","敌人");
         var xxx:* = LG;
         swfLoaderManager.addSWFList_byURL("swf/enemy/",LG.level.enemyNameArr,"敌人");
         swfLoaderManager.addSWFLoader("swf/scene/" + LG.level.father + ".swf",LG.level.father,"场景");
         swfLoaderManager.addSWFLoader("swf/music/" + LG.level.musicLabel + ".swf",LG.level.musicLabel,"音乐");
         swfLoaderManager.addEventListener(Event.COMPLETE,this.swfLoader_complete);
         swfLoaderManager.addEventListener(SWFLoaderManager.CRITICAL_LOAD_FAILED,this.swfLoader_failed);
         swfLoaderManager.startLoad();
         this.loaderTarget = 1;
         faseUI.showLoaderBar();
         this.addEventListener(Event.ENTER_FRAME,this.loaderShowTimer);
      }
      
      internal function swfLoader_complete(e:Event) : *
      {
         swfLoaderManager.removeEventListener(Event.COMPLETE,this.swfLoader_complete);
         swfLoaderManager.removeEventListener(SWFLoaderManager.CRITICAL_LOAD_FAILED,this.swfLoader_failed);
         if(!this.validateLevelResources())
         {
            this.reloadInvalidLevelResources();
            return;
         }
         this.levelResourceRetryCount = 0;
         faseUI.hideLoaderBar();
         this.removeEventListener(Event.ENTER_FRAME,this.loaderShowTimer);
         this.startLevel();
      }

      internal function swfLoader_failed(e:Event) : *
      {
         swfLoaderManager.removeEventListener(Event.COMPLETE,this.swfLoader_complete);
         swfLoaderManager.removeEventListener(SWFLoaderManager.CRITICAL_LOAD_FAILED,this.swfLoader_failed);
         try{ reportClientError("level-resource-load","critical level resource load failed","",LG.level.sceneID); }catch(eLog:*){}
         this.reloadInvalidLevelResources();
      }

      private function validateLevelResources() : Boolean
      {
         var enemiesOK:Boolean = false;
         var sceneOK:Boolean = false;
         try
         {
            enemiesOK = BG.prewarmEnemyImages(LG.level.enemyNameArr);
            sceneOK = oneScene.validateSceneResource(LG.level.sceneID);
         }
         catch(error:Error)
         {
            try{ reportClientError("level-resource-validate","validation exception: " + error,"",LG.level.sceneID); }catch(eLog:*){}
            return false;
         }
         if(!enemiesOK || !sceneOK)
         {
            try{ reportClientError("level-resource-validate","enemy animations=" + enemiesOK + ", scene=" + sceneOK,"",LG.level.sceneID); }catch(eLog2:*){}
            return false;
         }
         return true;
      }

      private function reloadInvalidLevelResources() : *
      {
         var labels:Array = LG.level.enemyNameArr.concat(["Spider","SmallWarden","Satellite_small",LG.level.father,LG.level.musicLabel,"levelUp","emp"]);
         swfLoaderManager.stopLoad();
         swfLoaderManager.removeResourcesByLabels(labels);
         if(this.levelResourceRetryCount < this.MAX_LEVEL_RESOURCE_RETRIES)
         {
            ++this.levelResourceRetryCount;
            swfLoaderManager.stateText = "关卡资源校验失败";
            swfLoaderManager.baifenText = "正在原地重新加载（" + this.levelResourceRetryCount + "/" + this.MAX_LEVEL_RESOURCE_RETRIES + "）";
            setTimeout(this.queueLevelResources,200);
            return;
         }
         faseUI.hideLoaderBar();
         this.removeEventListener(Event.ENTER_FRAME,this.loaderShowTimer);
         gameState = "no";
         uiGroup.show("startGame");
         uiGroup.checkTip.showCheck("关卡资源无法实例化，已阻止进入关卡。是否原地重新加载？",this.retryLevelResourcesAfterPrompt);
      }

      private function retryLevelResourcesAfterPrompt() : *
      {
         this.levelResourceRetryCount = 0;
         gameState = "chosen";
         uiGroup.show("loader");
         faseUI.showLoaderBar();
         this.addEventListener(Event.ENTER_FRAME,this.loaderShowTimer);
         this.queueLevelResources();
      }
      
      public function startLevel() : *
      {
         var music_swf:* = undefined;
         gameState = "gaming";
         trace("开始关卡，  当前状态：" + gameState);
         var label0:String = LG.level.musicLabel;
         var music0:OneMusic = SG.getMusic(label0);
         if(music0 == null)
         {
            music_swf = swfLoaderManager.getResource(label0,label0);
            SG.addMusic(music_swf,label0);
         }
         this.timer5.addFun(LG.LevelGroupTimer);
         this.timer5.addFun(gameData.dataTimer);
         this.timer5.addFun(uiGroup.uiTimer);
         this.timer1.addFun(uiGroup.uiTimer2);
         this.timer1.addFun(BGRefresh.FTimer);
         this.timer1.addFun(BGHit.FTimer);
         this.timer1.addFun(EG.EGTimer);
         this.timer1.addFun(eventGroup.dieDelay.FTimer);
         this.timer1.addFun(oneScene.senceTimer);
         this.timer1.addFun(itemsGroup.itemsGroupTimer);
         this.timer1.addFun(dialogboxGroup.dialogTimer);
         this.timer1.addFun(textGroup.textTimer);
         this.timer1.addFun(keysGroup.KeyTimer);
         eventGroup.gamingInit();
         keysGroup.gamingInit();
         oneScene.changeSence(LG.level.sceneID);
         BGHit.updataHitRect();
         oneScene.addThings();
         dialogboxGroup.continueAllDialog();
         EG.gamingInit();
         this.stage.quality = "low";
         gameData.lifeRateB2 = true;
         eventGroup.modelType = "";
         eventGroup.must_startLevel();
         LG.startLevel();
         stage.addEventListener(KeyboardEvent.KEY_DOWN,keysGroup.keyDown);
         stage.addEventListener(KeyboardEvent.KEY_UP,keysGroup.keyUp);
         gameSprite.shootMouseL.addEventListener(MouseEvent.MOUSE_DOWN,this.GamingMClick);
         gameSprite.shootMouseL.addEventListener(MouseEvent.MOUSE_UP,this.GamingMUp);
         gameSprite.shootMouseL.addEventListener(MouseEvent.MOUSE_WHEEL,this.GamingMWheel);
         uiGroup.show("resumeGame");
      }
      
      public function closeLevel() : *
      {
         if(gameState != "no")
         {
            gameState = "no";
            this.timer5.clear();
            this.timer1.clear();
            LG.closeLevel();
            this.stage.quality = "high";
            dialogboxGroup.clearAllDialog();
            eventGroup.gamingOver();
            trace("关闭关卡，  当前状态：" + gameState);
            if(gameState != "chosen")
            {
               trace("清除游戏世界中的数据，  当前状态：" + gameState);
               oneScene.clear();
               BG.clearAllEnemy();
               EG.clearAllEffect();
               textGroup.clearAll();
               itemsGroup.clearAll();
               gameSprite.clearAll();
               stage.removeEventListener(KeyboardEvent.KEY_DOWN,keysGroup.keyDown);
               stage.removeEventListener(KeyboardEvent.KEY_UP,keysGroup.keyUp);
               gameSprite.shootMouseL.removeEventListener(MouseEvent.MOUSE_DOWN,this.GamingMClick);
               gameSprite.shootMouseL.removeEventListener(MouseEvent.MOUSE_UP,this.GamingMUp);
               gameSprite.shootMouseL.removeEventListener(MouseEvent.MOUSE_WHEEL,this.GamingMWheel);
            }
         }
      }
      
      public function hideMouse() : *
      {
         uiGroup.gamingUI.pointer.visible = true;
         Mouse.hide();
         this.mouseShowB = false;
      }
      
      public function showMouse() : *
      {
         Mouse.show();
         uiGroup.gamingUI.pointer.visible = false;
         this.mouseShowB = true;
      }
      
      internal function GamingMClick(e:*) : *
      {
         var hero:HeroCarBody = BG.hero;
         if(hero is HeroCarBody)
         {
            if(hero.noAttack_t == -1 && hero.getCtrlB())
            {
               hero.attackAll();
            }
         }
      }
      
      internal function GamingMUp(e:*) : *
      {
         var hero:HeroCarBody = BG.hero;
         if(hero is HeroCarBody)
         {
            hero.attack.stopLoop();
            hero.SG.stopAll();
         }
      }
      
      internal function GamingMMove(e:*) : *
      {
      }

      internal function GamingMWheel(e:MouseEvent) : *
      {
         var direction:int = e.delta > 0 ? -1 : 1;
         var start:int = gameData.nowArmsIndex;
         var site:int = start;
         var count:int = 0;
         if(gameState != "gaming" || !gamingTimerB)
         {
            return;
         }
         while(count < 8)
         {
            site = (site + direction + 8) % 8;
            if(gameData.armsItems.getEquipBySite(site) != null)
            {
               eventGroup.changArms(site);
               return;
            }
            count++;
         }
      }
      
      public function allTimer(event:Event) : *
      {
         var hero:HeroCarBody = null;
         if(gamingTimerB)
         {
            this.timer5.FTimer();
            this.timer1.FTimer();
            hero = BG.hero;
            if(gameState == "gaming")
            {
               if(!(stage.focus is TextField) || TextField(stage.focus).type != TextFieldType.INPUT)
               {
                  stage.focus = stage;
               }
               if(hero.getCtrlB())
               {
                  hero.inMouseXY(gameSprite.gameL.mouseX,gameSprite.gameL.mouseY);
               }
               var mouseOffsetX:Number = (gameSprite.shootMouseL.mouseX - stageWidth / 2) * 0.45;
               var mouseOffsetY:Number = (gameSprite.shootMouseL.mouseY - stageHeight / 2) * 0.35;
               oneScene.inTargetMiddleMouse(hero.img.x,hero.img.y - 120,mouseOffsetX,mouseOffsetY);
               LG.level.hitArea(hero.img.x,hero.img.y);
            }
         }
      }
      
      internal function keyUp(event:KeyboardEvent) : *
      {
         if(event.keyCode == keysGroup.getBinding("menu"))
         {
            if(uiGroup.allback.isSettingsOpen())
            {
               uiGroup.allback.closeSoundSettings();
            }
            else if(gameState == "gaming")
            {
               if(uiGroup.menuUI.visible)
               {
                  uiGroup.show("resumeGame");
               }
               else
               {
                  uiGroup.show("menu");
               }
            }
            else
            {
               uiGroup.allback.openSoundSettings();
            }
            return;
         }
         if(!getTest())
         {
            return;
         }
         if(event.keyCode != Keyboard.M)
         {
            if(event.keyCode == Keyboard.P)
            {
               if(this.MK.visible)
               {
                  this.MK.visible = false;
               }
               else
               {
                  this.MK.visible = true;
               }
               if(gameState == "gaming")
               {
                  if(uiGroup.gamingUI.testTxt.visible)
                  {
                     uiGroup.gamingUI.testTxt.visible = false;
                  }
                  else
                  {
                     uiGroup.gamingUI.testTxt.visible = true;
                  }
               }
               else if(testText.visible)
               {
                  testText.visible = false;
               }
               else
               {
                  testText.visible = true;
                  testText.flesh();
               }
            }
            else if(event.keyCode == Keyboard.LEFTBRACKET)
            {
               uiGroup.allback.stopAll();
               uiGroup.chipEditorUI.visible = !uiGroup.chipEditorUI.visible;
            }
            else if(event.keyCode != Keyboard.Y)
            {
               if(event.keyCode != Keyboard.U)
               {
                  if(event.keyCode == Keyboard.I)
                  {
                  }
               }
            }
         }
      }
      
      private function installClientErrorReporting() : *
      {
         try
         {
            if(this.loaderInfo != null && this.loaderInfo.hasOwnProperty("uncaughtErrorEvents"))
            {
               this.loaderInfo["uncaughtErrorEvents"].addEventListener("uncaughtError",this.onUncaughtClientError);
            }
         }
         catch(e:*)
         {
         }
         Game.reportClientError("boot","client error reporting ready");
      }
      
      private function onUncaughtClientError(e:*) : *
      {
         var err:* = undefined;
         var msg:String = "";
         var stack:String = "";
         try
         {
            if(e != null && e.hasOwnProperty("error"))
            {
               err = e.error;
            }
            if(err != null)
            {
               msg = String(err);
               if(err.hasOwnProperty("getStackTrace") && err.getStackTrace is Function)
               {
                  stack = String(err.getStackTrace());
               }
               else if(err.hasOwnProperty("message"))
               {
                  msg = String(err.message);
               }
            }
            else
            {
               msg = String(e);
            }
            Game.reportClientError("uncaught",msg,stack);
            if(e != null && e.hasOwnProperty("preventDefault"))
            {
               e.preventDefault();
            }
         }
         catch(e2:*)
         {
         }
      }
   }
}

