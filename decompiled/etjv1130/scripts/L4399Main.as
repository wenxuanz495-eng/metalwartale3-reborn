package
{
   import com.adobe.serialization.json.JSONAPI;
   import flash.display.AVM1Movie;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.AsyncErrorEvent;
   import flash.events.DataEvent;
   import flash.events.Event;
   import flash.events.StatusEvent;
   import flash.net.LocalConnection;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.Security;
   import flash.utils.ByteArray;
   import flash.utils.getQualifiedClassName;
   import org.events.EngineEvent;
   import unit4399.events.MedalEvent;
   import unit4399.events.PayEvent;
   import unit4399.events.RankListEvent;
   import unit4399.events.SaveEvent;
   import unit4399.events.ShopEvent;
   
   public class L4399Main extends Sprite
   {
      
      public static var ctrl:*;
      
      private static const gamefile:Class = L4399Main_gamefile;
      
      public static const SEND_NAME:String = "AS2_4399";
      
      public static const REV_NAME:String = "AS3_4399";
      
      private var gameid:String = "100018385";
      
      private var game_key:String = "";
      
      private var game_storekey:String = "_4399_store_key";
      
      private var tempArray:Array = new Array();
      
      private var gameHold:Sprite = new Sprite();
      
      private var game:* = null;
      
      private var _loader:Loader;
      
      private var _loaderContext:LoaderContext;
      
      private var _decryption:Decryption;
      
      private var pre:*;
      
      private var joinStr:String = "";
      
      private var incMoneyObj:Object;
      
      private var decMoneyObj:Object;
      
      private var decMoneyStatisticObj:Object;
      
      private var getTotalPaiedObj:Object;
      
      private var getTotalRechargedObj:Object;
      
      private var getBalanceObj:Object;
      
      private var payMoneyObj:Object;
      
      private var stObj:Object;
      
      internal var curScore:int = -1;
      
      internal var totalScore:int = -1;
      
      private var _openSaveUIObj:Object;
      
      private var _getDataObj:Object;
      
      private var _getListObj:Object;
      
      private var _saveDataObj:Object;
      
      private var _lc:LocalConnection;
      
      private var _linkNum:uint;
      
      private var _sendName:String;
      
      private var _revName:String;
      
      private var _isConnect:Boolean = false;
      
      private var _password:String = "qwertyuiopasdfghjlzxcvbnm";
      
      private var _isLoadAs2:Boolean = false;
      
      private var _isLoadCtrl:Boolean = false;
      
      private var _mouseVisible:Boolean = true;
      
      public function L4399Main(param1:*)
      {
         super();
         Security.allowDomain("*");
         Security.allowInsecureDomain("*");
         this.pre = param1;
         addEventListener(Event.ADDED_TO_STAGE,this.init4399);
      }
      
      private function init4399(param1:Event = null) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.init4399);
         stage.addEventListener(MedalEvent.MEDAL_RESTARTGAME,this.onMedalRestartGameHandler);
         stage.addEventListener("xctrl",this.getCtrl);
         this.addChild(this.gameHold);
         this.getGameContent();
      }
      
      private function onMedalRestartGameHandler(param1:MedalEvent) : void
      {
         this.sendHandler({
            "func":"otherProcessFunc",
            "param":[param1.type,param1.data]
         });
      }
      
      private function getGameContent() : void
      {
         this._loaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         this._loader = new Loader();
         this._loader.loadBytes(new gamefile() as ByteArray,this._loaderContext);
         this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.assetLoaded,false,0,true);
      }
      
      private function assetLoaded(param1:Event) : void
      {
         var flexNameArr:Array;
         var isFind:Boolean;
         var i:int = 0;
         var len:int = 0;
         var event:Event = param1;
         this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.assetLoaded);
         this.game = event.target.content;
         flexNameArr = getQualifiedClassName(this.game).split("_");
         isFind = false;
         len = int(flexNameArr.length);
         i = 0;
         while(i < len)
         {
            if(flexNameArr[i] == "mx")
            {
               if(len - i >= 3)
               {
                  if(flexNameArr[i + 1] == "managers" && flexNameArr[i + 2] == "SystemManager")
                  {
                     isFind = true;
                     break;
                  }
               }
            }
            i++;
         }
         if(isFind)
         {
            addChild(this._loader);
            this.game.addEventListener("applicationComplete",this.onAppComplete);
         }
         else if(this.game is AVM1Movie)
         {
            this._password = loaderInfo.url;
            this.tryLinkAs2();
            this._isLoadAs2 = true;
            if(this._isLoadCtrl)
            {
               ctrl["mainHandler"] = this;
            }
         }
         else
         {
            try
            {
               this.game.setHold(this);
            }
            catch(e:Error)
            {
            }
            this.gameHold.addChild(this.game as DisplayObject);
            this.pre.dispatchEvent(new Event("##crygameok##"));
         }
      }
      
      private function onAppComplete(param1:Event = null) : void
      {
         var e:Event = param1;
         this.game = this._loader.content as MovieClip;
         try
         {
            this.game.application.setHold(this);
         }
         catch(e:Error)
         {
         }
         this.gameHold.addChild(this.game as DisplayObject);
         this.pre.dispatchEvent(new Event("##crygameok##"));
      }
      
      private function decryptionComplete(param1:Event) : void
      {
         this._loaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         this._loader = new Loader();
         this._loader.loadBytes(this._decryption.gameBtyeArr,this._loaderContext);
         this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.assetLoaded,false,0,true);
      }
      
      private function tryLinkAs2() : void
      {
         if(this.createLc())
         {
         }
         (this.game as Object).opaqueBackground = this._linkNum;
         addChild(this._loader);
         stage.addEventListener(SaveEvent.SAVE_GET,this.saveProcess);
         stage.addEventListener(SaveEvent.SAVE_SET,this.saveProcess);
         stage.addEventListener(SaveEvent.SAVE_LIST,this.saveProcess);
         stage.addEventListener("getDataExcep",this.saveProcess);
         stage.addEventListener("netSaveError",this.netSaveErrorHandler);
         stage.addEventListener("netGetError",this.netGetErrorHandler);
         stage.addEventListener("logreturn",this.saveProcess);
         stage.addEventListener("saveBackIndex",this.saveProcess);
         stage.addEventListener("multipleError",this.multipleErrorHandler);
         stage.addEventListener("StoreStateEvent",this.getStoreStateHandler);
         stage.addEventListener(PayEvent.DEC_MONEY,this.payProcess);
         stage.addEventListener(PayEvent.INC_MONEY,this.payProcess);
         stage.addEventListener(PayEvent.GET_MONEY,this.payProcess);
         stage.addEventListener(PayEvent.PAY_MONEY,this.payProcess);
         stage.addEventListener(PayEvent.PAY_ERROR,this.payProcess);
         stage.addEventListener(PayEvent.PAIED_MONEY,this.payProcess);
         stage.addEventListener(PayEvent.RECHARGED_MONEY,this.payProcess);
         stage.addEventListener(PayEvent.LOG,this.payProcess);
         stage.addEventListener("usePayApi",this.payProcess);
         stage.addEventListener(ShopEvent.SHOP_ERROR,this.shopProcess);
         stage.addEventListener(ShopEvent.SHOP_DEL_SUCC,this.shopProcess);
         stage.addEventListener(ShopEvent.SHOP_GET_PACKAGEINFO,this.shopProcess);
         stage.addEventListener(ShopEvent.SHOP_UPDATE_EXTEND,this.shopProcess);
         stage.addEventListener(ShopEvent.SHOP_ADDFREE_SUCC,this.shopProcess);
         stage.addEventListener(ShopEvent.SHOP_UPDATEPRO_SUCC,this.shopProcess);
         stage.addEventListener(ShopEvent.SHOP_GET_FREEPACKAGEINFO,this.shopProcess);
         stage.addEventListener(ShopEvent.SHOP_GET_PAYPACKAGEINFO,this.shopProcess);
         stage.addEventListener(ShopEvent.SHOP_GET_TYPENOTICE,this.shopProcess);
         stage.addEventListener(ShopEvent.SHOP_ADD_SUCC,this.shopProcess);
         stage.addEventListener(ShopEvent.SHOP_MODIFY_EX,this.shopProcess);
         stage.addEventListener(ShopEvent.SHOP_CLEARITEMS_EXTYPE,this.shopProcess);
         stage.addEventListener(ShopEvent.SHOP_ERROR_ND,this.shopProcess);
         stage.addEventListener(ShopEvent.SHOP_BUY_ND,this.shopProcess);
         stage.addEventListener(ShopEvent.SHOP_GET_LIST,this.shopProcess);
         stage.addEventListener(RankListEvent.RANKLIST_ERROR,this.rankListProcess);
         stage.addEventListener(RankListEvent.RANKLIST_SUCCESS,this.rankListProcess);
         stage.addEventListener("userLoginOut",this.onLoginOutHandler);
         stage.addEventListener("serverTimeEvent",this.onGetServerTimerHandler);
         stage.addEventListener("MVC_CLOSE_PANEL",this.closePanelHandler);
         this.pre.dispatchEvent(new Event("##crygameok##"));
      }
      
      private function onLoginOutHandler(param1:Event) : void
      {
         this.sendHandler({
            "func":"userLoginOut",
            "param":null
         });
      }
      
      private function closePanelHandler(param1:DataEvent) : void
      {
         this.sendHandler({
            "func":"closePanel",
            "param":param1.data
         });
      }
      
      private function asyncErrorHandler(param1:AsyncErrorEvent) : void
      {
      }
      
      private function statusEventHandler(param1:StatusEvent) : void
      {
      }
      
      private function createLc() : Boolean
      {
         try
         {
            if(this._lc == null)
            {
               this._lc = new LocalConnection();
               this._lc.addEventListener(AsyncErrorEvent.ASYNC_ERROR,this.asyncErrorHandler,false,0,true);
               this._lc.addEventListener(StatusEvent.STATUS,this.statusEventHandler,false,0,true);
            }
            this._linkNum = this.createNum();
            this._sendName = SEND_NAME + this._linkNum;
            this._revName = REV_NAME + this._linkNum;
            this._lc.connect(this._revName);
            this._lc.client = this;
         }
         catch(e:Error)
         {
            return false;
         }
         return true;
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
      
      public function receiveHandler(param1:Object) : void
      {
         var _loc2_:Array = null;
         if(param1 == null || param1.func == null || param1.func == undefined)
         {
            return;
         }
         var _loc3_:String = param1.func as String;
         switch(_loc3_)
         {
            case "openIntegralWin":
               this.showRefer(param1.param);
               break;
            case "openSortWin":
               this.showSort();
               break;
            case "connect":
               this.connect();
               break;
            case "joinDataFun":
               if(param1.param != null && param1.param != undefined)
               {
                  _loc2_ = param1.param as Array;
                  if(_loc2_ == null)
                  {
                     return;
                  }
                  this.joinDataFun(_loc2_[0],_loc2_[1],_loc2_[2],_loc2_[3],_loc2_[4]);
               }
               break;
            case "saveData":
               if(param1.param != null && param1.param != undefined)
               {
                  _loc2_ = param1.param as Array;
                  if(_loc2_ == null)
                  {
                     return;
                  }
                  this.saveData(_loc2_[0],_loc2_[1],_loc2_[2],_loc2_[3]);
               }
               break;
            case "getData":
               if(param1.param != null && param1.param != undefined)
               {
                  _loc2_ = param1.param as Array;
                  if(_loc2_ == null)
                  {
                     return;
                  }
                  this.getData(_loc2_[0],_loc2_[1]);
               }
               break;
            case "getList":
               _loc2_ = param1.param as Array;
               if(_loc2_ == null)
               {
                  return;
               }
               this.openSaveUI(_loc2_[0],_loc2_[1]);
               break;
            case "getListData":
               this.getList();
               break;
            case "getStoreState":
               this.getStoreState();
               break;
            case "testCtrl":
               this.testCtrl(int(param1.param));
               break;
            case "showLogPanel":
               this.showLogPanel();
               break;
            case "isLog":
               this.isLog;
               break;
            case "setMouseVisible":
               this.setMouseVisible(param1.param);
               break;
            case "showGameList":
               this.showGameList();
               break;
            case "incMoney":
               _loc2_ = param1.param as Array;
               if(_loc2_ == null)
               {
                  break;
               }
               this.incMoney(int(_loc2_[0]));
               break;
            case "decMoney":
               _loc2_ = param1.param as Array;
               if(_loc2_ == null)
               {
                  break;
               }
               this.decMoney(int(_loc2_[0]));
               break;
            case "getBalance":
               this.getBalance();
               break;
            case "payMoney":
               _loc2_ = param1.param as Array;
               if(_loc2_ == null)
               {
                  break;
               }
               this.payMoney(int(_loc2_[0]));
               break;
            case "paiedMoney":
               this.getTotalPaiedFun(param1.param);
               break;
            case "rechargedMoney":
               this.getTotalRechargedFun(param1.param);
               break;
            case "userLogOut":
               this.userLogOut();
               break;
            case "showShopUi":
               this.showShopUi();
               break;
            case "getPackageInfoFun":
               _loc2_ = param1.param as Array;
               if(_loc2_ == null)
               {
                  break;
               }
               this.getPackageInfoFun(_loc2_[0],_loc2_[1],_loc2_[2],_loc2_[3],_loc2_[4]);
               break;
            case "consumeItemFun":
               _loc2_ = param1.param as Array;
               if(_loc2_ == null)
               {
                  break;
               }
               this.consumeItemFun(_loc2_[0]);
               break;
            case "getShopItemsFun":
               _loc2_ = param1.param as Array;
               if(_loc2_ == null)
               {
                  break;
               }
               this.getShopItemsFun(_loc2_[0],_loc2_[1]);
               break;
            case "getFreePacInfoFun":
               _loc2_ = param1.param as Array;
               if(_loc2_ == null)
               {
                  break;
               }
               this.getFreePacInfoFun(_loc2_[0],_loc2_[1],_loc2_[2]);
               break;
            case "removeItemsFun":
               _loc2_ = param1.param as Array;
               this.removeItemsFun(_loc2_[0],_loc2_[1]);
               break;
            case "addItemsFun":
               _loc2_ = param1.param as Array;
               this.addItemsFun(_loc2_[0],_loc2_[1]);
               break;
            case "updateItemProFun":
               _loc2_ = param1.param as Array;
               this.updateItemProFun(_loc2_[0],_loc2_[1]);
               break;
            case "setExFlagFun":
               _loc2_ = param1.param as Array;
               this._exValue = _loc2_;
               break;
            case "getPayPacInfoFun":
               _loc2_ = param1.param as Array;
               if(_loc2_ == null)
               {
                  break;
               }
               this.getPayPacInfoFun(_loc2_[0],_loc2_[1],_loc2_[2]);
               break;
            case "buyProFun":
               _loc2_ = param1.param as Array;
               if(_loc2_ == null)
               {
                  break;
               }
               this.buyProFun(_loc2_[0],_loc2_[1],_loc2_[2]);
               break;
            case "modifyExFun":
               _loc2_ = param1.param as Array;
               if(_loc2_ == null)
               {
                  break;
               }
               this.modifyExFun(_loc2_[0],_loc2_[1],_loc2_[2]);
               break;
            case "clearItemsByExTypeFun":
               _loc2_ = param1.param as Array;
               if(_loc2_ == null)
               {
                  break;
               }
               this.clearItemsByExTypeFun(_loc2_[0],_loc2_[1],_loc2_[2]);
               break;
            case "getServerTime":
               this.getServerTime();
               break;
            case "changeScore":
               this.changeScore(int(param1.param));
               break;
            case "submitScore":
               this.submitScore(int(param1.param));
               break;
            case "getOneRankInfo":
               _loc2_ = param1.param as Array;
               this.getOneRankInfo(_loc2_[0],_loc2_[1]);
               break;
            case "getRankListByOwn":
               _loc2_ = param1.param as Array;
               this.getRankListByOwn(_loc2_[0],_loc2_[1],_loc2_[2]);
               break;
            case "submitScoreToRankLists":
               _loc2_ = param1.param as Array;
               this.submitScoreToRankLists(_loc2_[0],_loc2_[1]);
               break;
            case "getRankListsData":
               _loc2_ = param1.param as Array;
               this.getRankListsData(_loc2_[0],_loc2_[1],_loc2_[2]);
               break;
            case "getUserData":
               _loc2_ = param1.param as Array;
               this.getUserData(_loc2_[0],_loc2_[1]);
               break;
            case "getShopList":
               this.getShopList();
               break;
            case "buyPropNd":
               this.buyPropNd(param1.param);
         }
      }
      
      private function connect() : void
      {
         this._isConnect = true;
      }
      
      private function sendHandler(param1:Object) : void
      {
         if(this._isConnect && this._lc != null)
         {
            try
            {
               this._lc.send(this._sendName,"receiveHandler",param1);
            }
            catch(e:ArgumentError)
            {
            }
         }
      }
      
      private function onGetServerTimerHandler(param1:DataEvent) : void
      {
         this.sendHandler({
            "func":"otherProcessFunc",
            "param":[param1.type,param1.data]
         });
      }
      
      private function netSaveErrorHandler(param1:Event) : void
      {
         this.sendHandler({
            "func":"saveProcessFunc",
            "param":[param1.type,null]
         });
      }
      
      private function netGetErrorHandler(param1:DataEvent) : void
      {
         this.sendHandler({
            "func":"saveProcessFunc",
            "param":[param1.type,int(param1.data)]
         });
      }
      
      private function multipleErrorHandler(param1:Event) : void
      {
         this.sendHandler({
            "func":"saveProcessFunc",
            "param":[param1.type,null]
         });
      }
      
      private function getStoreStateHandler(param1:DataEvent) : void
      {
         this.sendHandler({
            "func":"saveProcessFunc",
            "param":[param1.type,String(param1.data)]
         });
      }
      
      private function saveProcess(param1:SaveEvent) : void
      {
         var tmpStr:String;
         var obj:Object;
         var tmpMaxLen:int;
         var dataObj:Object;
         var tmpLen:int;
         var i:int;
         var e:SaveEvent = param1;
         if(e.type != SaveEvent.SAVE_GET)
         {
            this.sendHandler({
               "func":"saveProcessFunc",
               "param":[e.type,e.ret]
            });
            return;
         }
         tmpStr = "";
         obj = this.copyObj(e.ret);
         if(Boolean(obj) && Boolean(obj.data != undefined) && obj.data != null)
         {
            try
            {
               tmpStr = JSONAPI.encode(obj.data);
            }
            catch(e:Error)
            {
               tmpStr = "";
            }
            tmpMaxLen = 15 * 1000;
            dataObj = new Object();
            dataObj.index = obj.index;
            dataObj.datetime = obj.datetime;
            dataObj.title = obj.title;
            dataObj.data = "";
            dataObj.endFlag = "1";
            tmpLen = Math.ceil(tmpStr.length / tmpMaxLen);
            if(tmpLen == 0)
            {
               this.sendHandler({
                  "func":"saveProcessFunc",
                  "param":["joinData",dataObj]
               });
               return;
            }
            i = 0;
            while(i < tmpLen)
            {
               dataObj.data = tmpStr.substr(i * tmpMaxLen,tmpMaxLen);
               dataObj.endFlag = "0";
               if(i == tmpLen - 1)
               {
                  dataObj.endFlag = "1";
               }
               this.sendHandler({
                  "func":"saveProcessFunc",
                  "param":["joinData",dataObj]
               });
               i++;
            }
            return;
         }
         this.sendHandler({
            "func":"saveProcessFunc",
            "param":[e.type,e.ret]
         });
      }
      
      private function copyObj(param1:Object) : Object
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return _loc2_.readObject() as Object;
      }
      
      public function showRefer(param1:int = 0) : void
      {
         if(ctrl)
         {
            ctrl.openIntegralWin(param1);
         }
      }
      
      public function showSort() : void
      {
         if(ctrl)
         {
            ctrl.openSortWin();
         }
      }
      
      private function joinDataFun(param1:String, param2:String, param3:Boolean = true, param4:int = 0, param5:Boolean = true) : void
      {
         var data:Object = null;
         var title:String = param1;
         var dataStr:String = param2;
         var ui:Boolean = param3;
         var index:int = param4;
         var isEnd:Boolean = param5;
         this.joinStr += dataStr;
         if(!isEnd)
         {
            return;
         }
         try
         {
            data = JSONAPI.decode(this.joinStr);
         }
         catch(e:Error)
         {
            data = "";
         }
         this.joinStr = "";
         this.saveData(title,data,ui,index);
      }
      
      public function saveData(param1:String, param2:Object, param3:Boolean = true, param4:int = 0) : void
      {
         if(ctrl)
         {
            ctrl.save(param1,param2,param3,param4);
         }
         else
         {
            this._saveDataObj = new Object();
            this._saveDataObj.title = param1;
            this._saveDataObj.data = param2;
            this._saveDataObj.ui = param3;
            this._saveDataObj.index = param4;
         }
      }
      
      public function getData(param1:Boolean = true, param2:int = 0) : void
      {
         if(ctrl)
         {
            ctrl.get(param1,param2);
         }
         else
         {
            this._getDataObj = new Object();
            this._getDataObj.ui = param1;
            this._getDataObj.index = param2;
         }
      }
      
      public function openSaveUI(param1:String, param2:Object) : void
      {
         if(ctrl)
         {
            ctrl.openSaveUI(param1,param2);
         }
         else
         {
            this._openSaveUIObj = new Object();
            this._openSaveUIObj.title = param1;
            this._openSaveUIObj.data = param2;
         }
      }
      
      public function getList() : void
      {
         if(ctrl)
         {
            ctrl.getList();
         }
         else
         {
            this._getListObj = new Object();
         }
      }
      
      public function testCtrl(param1:int) : void
      {
         var _loc2_:String = this._password.charAt(param1);
         this.sendHandler({
            "func":"testReturn",
            "param":[param1,_loc2_]
         });
      }
      
      public function get isLog() : Object
      {
         var _loc1_:Object = null;
         if(ctrl)
         {
            _loc1_ = ctrl.isLog;
            this.sendHandler({
               "func":"saveProcessFunc",
               "param":["isLog",_loc1_]
            });
            return _loc1_;
         }
         this.sendHandler({
            "func":"saveProcessFunc",
            "param":["isLog",null]
         });
         return null;
      }
      
      public function incMoney_As3(param1:PayMoneyVar) : void
      {
         var _loc2_:int = 0;
         if(param1 == null || param1.money == undefined)
         {
            _loc2_ = 0;
         }
         else
         {
            _loc2_ = int(param1.money);
         }
         this.incMoney(_loc2_);
      }
      
      private function incMoney(param1:int) : void
      {
         this.incMoneyObj = null;
         if(ctrl)
         {
            ctrl.incMoney(param1);
         }
         else
         {
            this.incMoneyObj = new Object();
            this.incMoneyObj.money = param1;
         }
      }
      
      public function decMoney_As3(param1:PayMoneyVar) : void
      {
         var _loc2_:int = 0;
         if(param1 == null || param1.money == undefined)
         {
            _loc2_ = 0;
         }
         else
         {
            _loc2_ = int(param1.money);
         }
         this.decMoney(_loc2_);
      }
      
      private function decMoney(param1:int) : void
      {
         this.decMoneyObj = null;
         if(ctrl)
         {
            ctrl.decMoney(param1);
         }
         else
         {
            this.decMoneyObj = new Object();
            this.decMoneyObj.money = param1;
         }
      }
      
      public function decMoney_statistic(param1:int, param2:uint, param3:int, param4:String, param5:Number, param6:int) : void
      {
         this.decMoneyStatisticObj = null;
         if(ctrl)
         {
            ctrl.decMoneyStatistic(param1,param2,param3,param4,param5,param6);
         }
         else
         {
            this.decMoneyStatisticObj = new Object();
            this.decMoneyStatisticObj.money = param1;
            this.decMoneyStatisticObj.saveIndex = param2;
            this.decMoneyStatisticObj.propId = param3;
            this.decMoneyStatisticObj.propName = param4;
            this.decMoneyStatisticObj.propPrice = param5;
            this.decMoneyStatisticObj.propCount = param6;
         }
      }
      
      public function getTotalPaiedFun(param1:Object = null) : void
      {
         this.getTotalPaiedObj = null;
         if(ctrl)
         {
            ctrl.getTotalPaiedFun(param1);
         }
         else
         {
            this.getTotalPaiedObj = new Object();
            this.getTotalPaiedObj.dateObj = param1;
         }
      }
      
      public function getTotalRechargedFun(param1:Object = null) : void
      {
         this.getTotalRechargedObj = null;
         if(ctrl)
         {
            ctrl.getTotalRechargedFun(param1);
         }
         else
         {
            this.getTotalRechargedObj = new Object();
            this.getTotalRechargedObj.dateObj = param1;
         }
      }
      
      public function getBalance() : void
      {
         this.getBalanceObj = null;
         if(ctrl)
         {
            ctrl.getBalance();
         }
         else
         {
            this.getBalanceObj = new Object();
         }
      }
      
      public function payMoney_As3(param1:PayMoneyVar) : void
      {
         var _loc2_:int = 0;
         if(param1 == null || param1.money == undefined)
         {
            _loc2_ = 0;
         }
         else
         {
            _loc2_ = int(param1.money);
         }
         this.payMoney(_loc2_);
      }
      
      private function payMoney(param1:int) : void
      {
         this.payMoneyObj = null;
         if(ctrl)
         {
            ctrl.payMoney(param1);
         }
         else
         {
            this.payMoneyObj.money = param1;
         }
      }
      
      private function payProcess(param1:PayEvent) : void
      {
         this.sendHandler({
            "func":"payProcessFunc",
            "param":[param1.type,param1.data]
         });
      }
      
      public function showShopUi() : void
      {
         if(ctrl)
         {
            ctrl.showShopUi();
         }
      }
      
      public function set _exValue(param1:Array) : void
      {
         if(ctrl)
         {
            ctrl._exValue = param1;
         }
      }
      
      public function getPackageInfoFun(param1:uint = 10, param2:uint = 1, param3:String = "0", param4:Array = null, param5:String = "") : void
      {
         if(ctrl)
         {
            ctrl.getPackageInfoFun(param1,param3,param2,param4,param5);
         }
      }
      
      public function getFreePacInfoFun(param1:uint = 10, param2:uint = 1, param3:String = "0") : void
      {
         if(ctrl)
         {
            ctrl.getFreePacInfoFun(param1,param2,param3);
         }
      }
      
      public function getPayPacInfoFun(param1:uint = 8, param2:uint = 1, param3:String = "0") : void
      {
         if(ctrl)
         {
            ctrl.getPayPacInfoFun(param1,param2,param3);
         }
      }
      
      public function buyProFun(param1:String, param2:uint, param3:String = "") : void
      {
         if(ctrl)
         {
            ctrl.buyProFun(param1,param2,param3);
         }
      }
      
      public function modifyExFun(param1:String, param2:Array, param3:String = "") : void
      {
         if(ctrl)
         {
            ctrl.modifyExValFun(param1,param2,param3);
         }
      }
      
      public function clearItemsByExTypeFun(param1:String, param2:Array, param3:String = "") : void
      {
         if(ctrl)
         {
            ctrl.clearItemsByExType(param1,param2,param3);
         }
      }
      
      public function removeItemsFun(param1:Array, param2:String = "") : void
      {
         if(ctrl)
         {
            ctrl.removeItemsFun(param1,param2);
         }
      }
      
      public function consumeItemFun(param1:String) : void
      {
         if(ctrl)
         {
            ctrl.consumeItemFun(param1);
         }
      }
      
      public function addItemsFun(param1:Array, param2:String = "") : void
      {
         if(ctrl)
         {
            ctrl.addItemsFun(param1,param2);
         }
      }
      
      public function updateItemProFun(param1:Object, param2:String = "") : void
      {
         if(ctrl)
         {
            ctrl.updateItemProFun(param1,param2);
         }
      }
      
      public function getShopItemsFun(param1:Array, param2:String = "") : void
      {
         if(ctrl)
         {
            ctrl.getShopItemsFun(param1,param2);
         }
      }
      
      public function getShopList() : void
      {
         if(ctrl)
         {
            ctrl.getShopList();
         }
      }
      
      public function buyPropNd(param1:Object) : void
      {
         if(ctrl)
         {
            ctrl.buyPropNd(param1);
         }
      }
      
      private function shopProcess(param1:ShopEvent) : void
      {
         this.sendHandler({
            "func":"shopProcessFunc",
            "param":[param1.type,param1.data]
         });
      }
      
      public function userLogOut() : void
      {
         if(ctrl)
         {
            ctrl.userLogOut();
         }
      }
      
      public function get isSecondaryLog() : Object
      {
         var _loc1_:Object = null;
         if(ctrl)
         {
            _loc1_ = ctrl.isSecondaryLog;
         }
         return _loc1_;
      }
      
      public function showSecondaryLogPanel() : void
      {
         if(ctrl)
         {
            ctrl.showSecondaryLogPanel();
         }
      }
      
      public function saveSecondaryData(param1:String, param2:Object, param3:int = 0) : void
      {
         if(ctrl)
         {
            ctrl.saveSecondaryData(param1,param2,param3);
         }
      }
      
      public function getSecondaryData(param1:int = 0) : void
      {
         if(ctrl)
         {
            ctrl.getSecondaryData(param1);
         }
      }
      
      public function getSecondarySaveList() : void
      {
         if(ctrl)
         {
            ctrl.getSecondarySaveList();
         }
      }
      
      public function secondaryLogOut() : void
      {
         if(ctrl)
         {
            ctrl.secondaryLogOut();
         }
      }
      
      public function getServerTime() : void
      {
         this.stObj = null;
         if(ctrl)
         {
            ctrl.getServerTime();
         }
         else
         {
            this.stObj = new Object();
         }
      }
      
      public function showLogPanel() : void
      {
         if(ctrl)
         {
            ctrl.showLogPanel();
         }
      }
      
      public function getStoreState() : void
      {
         if(ctrl)
         {
            ctrl.getStoreState();
         }
      }
      
      public function changeScore(param1:int) : void
      {
         if(param1 < 0)
         {
            return;
         }
         this.curScore = -1;
         if(ctrl)
         {
            ctrl.changeScore(param1);
         }
         else
         {
            this.curScore = param1;
         }
      }
      
      public function submitScore(param1:int) : void
      {
         if(param1 < 0)
         {
            return;
         }
         this.totalScore = -1;
         if(ctrl)
         {
            ctrl.submitScore(param1);
         }
         else
         {
            this.totalScore = param1;
         }
      }
      
      private function rankListProcess(param1:RankListEvent) : void
      {
         this.sendHandler({
            "func":"rankListProcessFunc",
            "param":[param1.type,param1.data]
         });
      }
      
      public function getOneRankInfo(param1:uint, param2:String) : void
      {
         if(ctrl)
         {
            ctrl.getOneRankInfo(param1,param2);
         }
      }
      
      public function getRankListByOwn(param1:uint, param2:uint, param3:uint) : void
      {
         if(ctrl)
         {
            ctrl.getRankListByOwn(param1,param2,param3);
         }
      }
      
      public function submitScoreToRankLists(param1:uint, param2:Array) : void
      {
         if(ctrl)
         {
            ctrl.submitScoreToRankLists(param1,param2);
         }
      }
      
      public function getRankListsData(param1:uint, param2:uint, param3:uint) : void
      {
         if(ctrl)
         {
            ctrl.getRankListsData(param1,param2,param3);
         }
      }
      
      public function getUserData(param1:String, param2:uint) : void
      {
         if(ctrl)
         {
            ctrl.getUserData(param1,param2);
         }
      }
      
      public function setFocusManager() : void
      {
         this.sendHandler({
            "func":"setFocusManager",
            "param":null
         });
      }
      
      private function getCtrl(param1:EngineEvent) : void
      {
         stage.removeEventListener("xctrl",this.getCtrl);
         ctrl = param1.eData;
         this._isLoadCtrl = true;
         if(this._isLoadAs2)
         {
            ctrl["mainHandler"] = this;
         }
         ctrl["mouseVisible"] = this._mouseVisible;
         if(this._getDataObj != null)
         {
            this.getData(this._getDataObj.ui,this._getDataObj.index);
         }
         if(this._saveDataObj)
         {
            this.saveData(this._saveDataObj.title,this._saveDataObj.data,this._saveDataObj.ui,this._saveDataObj.index);
         }
         if(this._openSaveUIObj)
         {
            this.openSaveUI(this._openSaveUIObj.title,this._openSaveUIObj.data);
         }
         if(this._getListObj)
         {
            this.getList();
         }
         if(this.stObj)
         {
            this.getServerTime();
         }
         if(this.totalScore >= 0)
         {
            this.submitScore(this.totalScore);
         }
         if(this.curScore >= 0)
         {
            this.changeScore(this.curScore);
         }
         if(this.incMoneyObj)
         {
            this.incMoney(this.incMoneyObj.money);
         }
         if(this.decMoneyObj)
         {
            this.decMoney(this.decMoneyObj.money);
         }
         if(this.decMoneyStatisticObj)
         {
            this.decMoney_statistic(this.decMoneyStatisticObj.money,this.decMoneyStatisticObj.saveIndex,this.decMoneyStatisticObj.propId,this.decMoneyStatisticObj.propName,this.decMoneyStatisticObj.propPrice,this.decMoneyStatisticObj.propCount);
         }
         if(this.getBalanceObj)
         {
            this.getBalance();
         }
         if(this.getTotalPaiedObj)
         {
            this.getTotalPaiedFun(this.getTotalPaiedObj.dateObj);
         }
         if(this.getTotalRechargedObj)
         {
            this.getTotalRechargedFun(this.getTotalRechargedObj.dateObj);
         }
         if(this.payMoneyObj)
         {
            this.payMoney(this.payMoneyObj.money);
         }
      }
      
      public function setMouseVisible(param1:Boolean) : void
      {
         this._mouseVisible = param1;
         if(ctrl)
         {
            ctrl["mouseVisible"] = this._mouseVisible;
         }
      }
      
      public function showGameList() : void
      {
         if(ctrl)
         {
            ctrl.showGameList();
         }
      }
      
      public function unionCreate(param1:int, param2:String, param3:String) : void
      {
         if(ctrl)
         {
            ctrl.createUnion(param1,param2,param3);
         }
      }
      
      public function getUnionList(param1:int, param2:int, param3:int) : void
      {
         if(ctrl)
         {
            ctrl.getUnionList(param1,param2,param3);
         }
      }
      
      public function applyUnion(param1:int, param2:int, param3:String) : void
      {
         if(ctrl)
         {
            ctrl.applyUnion(param1,param2,param3);
         }
      }
      
      public function getOwnUnion(param1:int) : void
      {
         if(ctrl)
         {
            ctrl.getOwnUnion(param1);
         }
      }
      
      public function getUnionDetail(param1:int, param2:int) : void
      {
         if(ctrl)
         {
            ctrl.getUnionDetail(param1,param2);
         }
      }
      
      public function getUnionMembers(param1:int, param2:int) : void
      {
         if(ctrl)
         {
            ctrl.getUnionMembers(param1,param2);
         }
      }
      
      public function setMemberExtra(param1:int, param2:int, param3:String, param4:int = 0, param5:int = 0, param6:int = 0) : void
      {
         if(ctrl)
         {
            ctrl.setMemberExtra(param1,param2,param3,param4,param5,param6);
         }
      }
      
      public function setUnionExtra(param1:int, param2:int, param3:String, param4:int) : void
      {
         if(ctrl)
         {
            ctrl.setUnionExtra(param1,param2,param3,param4);
         }
      }
      
      public function getUnionLog(param1:int, param2:int, param3:int) : void
      {
         if(ctrl)
         {
            ctrl.getUnionLog(param1,param2,param3);
         }
      }
      
      public function quitUion(param1:int) : void
      {
         if(ctrl)
         {
            ctrl.quitUion(param1);
         }
      }
      
      public function doTask(param1:int, param2:String) : void
      {
         if(ctrl)
         {
            ctrl.doTask(param1,param2);
         }
      }
      
      public function doExchange(param1:int, param2:int) : void
      {
         if(ctrl)
         {
            ctrl.doExchange(param1,param2);
         }
      }
      
      public function getTaskValue(param1:int) : void
      {
         if(ctrl)
         {
            ctrl.getTaskValue(param1);
         }
      }
      
      public function getApplyList(param1:int, param2:int, param3:int) : void
      {
         if(ctrl)
         {
            ctrl.getApplyList(param1,param2,param3);
         }
      }
      
      public function auditMember(param1:int, param2:int, param3:int, param4:int) : void
      {
         if(ctrl)
         {
            ctrl.auditMember(param1,param2,param3,param4);
         }
      }
      
      public function removeMember(param1:int, param2:int, param3:int) : void
      {
         if(ctrl)
         {
            ctrl.removeMember(param1,param2,param3);
         }
      }
      
      public function dissolveUnion(param1:int, param2:int) : void
      {
         if(ctrl)
         {
            ctrl.dissolveUnion(param1,param2);
         }
      }
      
      public function getVariables(param1:int, param2:Array) : void
      {
         if(ctrl)
         {
            ctrl.getVariables(param1,param2);
         }
      }
      
      public function doVariable(param1:int, param2:int) : void
      {
         if(ctrl)
         {
            ctrl.doVariable(param1,param2);
         }
      }
      
      public function getRoleList(param1:int, param2:int) : void
      {
         if(ctrl)
         {
            ctrl.getRoleList(param1,param2);
         }
      }
      
      public function setRole(param1:int, param2:int, param3:int, param4:int) : void
      {
         if(ctrl)
         {
            ctrl.setRole(param1,param2,param3,param4);
         }
      }
      
      public function usePersonalContribution(param1:int, param2:int) : *
      {
         if(ctrl)
         {
            ctrl.usePersonalContribution(param1,param2);
         }
      }
      
      public function useUnionContribution(param1:int, param2:int) : *
      {
         if(ctrl)
         {
            ctrl.useUnionContribution(param1,param2);
         }
      }
      
      public function applyMultiAudit(param1:int, param2:Array, param3:int) : *
      {
         if(ctrl)
         {
            ctrl.applyMultiAudit(param1,param2,param3);
         }
      }
      
      public function transferUnion(param1:int, param2:int, param3:int, param4:int) : *
      {
         if(ctrl)
         {
            ctrl.transferUnion(param1,param2,param3,param4);
         }
      }
      
      public function setRoleRevised(param1:int, param2:String, param3:int, param4:int) : void
      {
         if(ctrl)
         {
            ctrl.setRoleRevised(param1,param2,param3,param4);
         }
      }
      
      public function setMemberExtraRevised(param1:int, param2:int, param3:String, param4:int = 0, param5:String = "0", param6:int = 0) : void
      {
         if(ctrl)
         {
            ctrl.setMemberExtraRevised(param1,param2,param3,param4,param5,param6);
         }
      }
      
      public function auditMemberRevised(param1:int, param2:String, param3:int, param4:int) : void
      {
         if(ctrl)
         {
            ctrl.auditMemberRevised(param1,param2,param3,param4);
         }
      }
      
      public function removeMemberRevised(param1:int, param2:String, param3:int) : void
      {
         if(ctrl)
         {
            ctrl.removeMemberRevised(param1,param2,param3);
         }
      }
      
      public function transferUnionRevised(param1:int, param2:String, param3:int, param4:int) : *
      {
         if(ctrl)
         {
            ctrl.transferUnionRevised(param1,param2,param3,param4);
         }
      }
      
      private function getUrl() : void
      {
      }
   }
}

