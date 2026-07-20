package
{
   import com.adobe.crypto.MD5;
   import ctrl4399.ObjectToXML;
   import ctrl4399.XMLToObject;
   import ctrl4399.proxy.*;
   import ctrl4399.proxy.union.*;
   import ctrl4399.skin.CtrlSkin;
   import ctrl4399.strconst.AllConst;
   import ctrl4399.view.*;
   import ctrl4399.view.components.styleConst.StyleClass;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.DataEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.external.ExternalInterface;
   import flash.net.SharedObject;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.system.ApplicationDomain;
   import flash.system.Capabilities;
   import flash.system.LoaderContext;
   import flash.system.Security;
   import flash.system.System;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import frame4399.simplePureMvc.core.Facade;
   import frame4399.simplePureMvc.core.Notification;
   import org.hell.Dialog;
   import unit4399.events.*;
   
   public class WMCtrl extends Sprite
   {
      
      private static const NET_SAVE_ERROR:String = "netSaveError";
      
      private static const NET_GET_ERROR:String = "netGetError";
      
      public static const cutShot:Class = WMCtrl_cutShot;
      
      public var testTxt:TextField;
      
      private var _facade:Facade = Facade.getInstance();
      
      private var mainProxy:MainProxy;
      
      private var packageProxy:PackageProxy;
      
      private var shopProxy:ShopProxy;
      
      private var shopNdProxy:ShopNdProxy;
      
      private var rankListProxy:RankListProxy;
      
      private var freePackageProxy:FreePackageProxy;
      
      private var _advType:String = "-1";
      
      private var medalProxy:MedalProxy;
      
      private var visitorProxy:VisitorProxy;
      
      private var memberProxy:MemberProxy;
      
      private var growProxy:GrowProxy;
      
      private var masterProxy:MasterProxy;
      
      private var variableProxy:CommonVariableProxy;
      
      private var roleProxy:RoleProxy;
      
      private var secondaryProxy:SecondaryProxy;
      
      private var _mainHandler:Object;
      
      private var _mouseVisible:Boolean = true;
      
      private var _needDoIntegralList:Array;
      
      private var _isInit:Boolean;
      
      private var isSetStyleOk:Boolean;
      
      private var _request_loader:URLLoader;
      
      private var _adLoadTime:int;
      
      private var _adPlayTime:int;
      
      private var _adSuccess:String;
      
      public var gameSizeObj:Object;
      
      private var isLoadCutShot:Boolean = true;
      
      private var mySo:SharedObject;
      
      private var _loaderContext:LoaderContext;
      
      private var _cutShotLoader:Loader;
      
      private var _gameId:String;
      
      private var _gameName:String;
      
      private var _gameWid:Number;
      
      private var _gameHei:Number;
      
      private var _gameInfoStr:String;
      
      private var _objToXml:ObjectToXML;
      
      private var _xmlToObj:XMLToObject;
      
      public function WMCtrl()
      {
         super();
         Security.allowDomain("*");
         Security.allowInsecureDomain("*");
         if(stage)
         {
            this.init();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.init);
         }
      }
      
      public function set _isLoadCutShot(param1:Boolean) : void
      {
         this.isLoadCutShot = param1;
      }
      
      private function saveEventHandler(param1:SaveEvent) : void
      {
         switch(param1.type)
         {
            case SaveEvent.SAVE_GET:
               this.saveGetHandler(param1.ret);
               break;
            case SaveEvent.SAVE_SET:
               this.saveSetHandler(param1.ret as Boolean);
         }
      }
      
      private function saveGetHandler(param1:Object) : void
      {
         if(this.mainProxy == null || this.mainProxy.getStoreAry == null || this.mainProxy.getStoreAry.length == 0)
         {
            return;
         }
         this.mainProxy.getStoreAry.shift();
         if(this.mainProxy.getStoreAry.length > 0)
         {
            this.saveProxy.getStore(String(this.mainProxy.getStoreAry[0]));
         }
      }
      
      private function saveSetHandler(param1:Boolean) : void
      {
         var _loc2_:Object = null;
         var _loc3_:String = null;
         if(this.mainProxy == null || this.mainProxy.saveStoreAry == null || this.mainProxy.saveStoreAry.length == 0)
         {
            return;
         }
         this.mainProxy.saveStoreAry.shift();
         if(this.mainProxy.saveStoreAry.length > 0)
         {
            _loc2_ = this.mainProxy.saveStoreAry[0] as Object;
            this.saveProxy.setOldData(_loc2_.data);
            _loc3_ = this.saveProxy.setData(_loc2_.data);
            this.saveProxy.setStore(String(_loc2_.index),_loc2_.title,_loc3_,_loc2_.data);
         }
      }
      
      private function init(param1:Event = null) : void
      {
         if(param1 != null)
         {
            removeEventListener(Event.ADDED_TO_STAGE,this.init);
         }
         System.useCodePage = false;
         Dialog.stageHolder = stage;
         stage.addEventListener(SaveEvent.SAVE_GET,this.saveEventHandler,false,0,true);
         stage.addEventListener(SaveEvent.SAVE_SET,this.saveEventHandler,false,0,true);
      }
      
      private function skinLoadOK(param1:*) : void
      {
         trace("ctrl skin load OK !!!!");
         this.startCtrlMVC();
         this._isInit = true;
         if(this.isSetStyleOk)
         {
            this.doFuncList(this._needDoIntegralList);
         }
      }
      
      private function startCtrlMVC() : void
      {
         trace("______________________________________");
         trace("__________  wmCtrl start  ____________");
         trace("______________________________________");
         System.useCodePage = false;
         var _loc1_:TextField = this["testTxt"] as TextField;
         _loc1_.visible = false;
         this.mainProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_MAIN) as MainProxy;
         this.mainProxy.realStage = stage;
         this.mainProxy.mouseVisible = this._mouseVisible;
         this._facade.registerProxy(new RedeemTaskProxy(AllConst.PROXY_NAME_REDEEMTASK));
         this._facade.registerMediator(new LogView(AllConst.VIEW_NAME_LOG,this));
         this._facade.registerMediator(new RegView(AllConst.VIEW_NAME_REG,this));
         this._facade.registerMediator(new LogSuccMediator(AllConst.VIEW_NAME_LOGSUCC,this));
         if(AllConst.MODE_OBJECT[AllConst.MODE_NAME_SCORE])
         {
            this._facade.registerProxy(new ScoreProxy(AllConst.PROXY_NAME_SCORE));
            this._facade.registerMediator(new ScoreView(AllConst.VIEW_NAME_SCORE,this));
            this._facade.registerProxy(new SortProxy(AllConst.PROXY_NAME_SORT));
         }
         if(AllConst.MODE_OBJECT[AllConst.MODE_NAME_SAVE])
         {
            this._facade.registerMediator(new SaveLocalMediator());
            this._facade.registerProxy(new SaveProxy(AllConst.PROXY_NAME_SAVE));
            this._facade.registerMediator(new SaveMediator());
            this.saveProxy.realStage = stage;
         }
         if(AllConst.MODE_OBJECT[AllConst.MODE_NAME_GAMELIST])
         {
            this._facade.registerProxy(new GameListProxy(AllConst.PROXY_NAME_GAMELIST));
            this._facade.registerMediator(new GameListMediator(AllConst.VIEW_NAME_GAMELIST,this));
         }
         if(!AllConst.MODE_OBJECT[AllConst.MODE_NAME_PAY])
         {
         }
         if(AllConst.MODE_OBJECT[AllConst.MODE_NAME_MEDAL])
         {
            this._facade.registerProxy(new MedalProxy(AllConst.PROXY_NAME_MEDAL));
            this.medalProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_MEDAL) as MedalProxy;
            this.medalProxy.realStage = stage;
         }
         if(AllConst.MODE_OBJECT[AllConst.MODE_NAME_SHOP])
         {
            this._facade.registerProxy(new ShopProxy(AllConst.PROXY_NAME_SHOP));
            this._facade.registerMediator(new ShopMediator(AllConst.VIEW_NAME_SHOP,this));
            this.shopProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_SHOP) as ShopProxy;
            this.shopProxy.realStage = stage;
            this._facade.registerMediator(new ShopItemMediator(AllConst.VIEW_NAME_SHOP_ITEM,this));
            this._facade.registerProxy(new ShopNdProxy(AllConst.PROXY_NAME_SHOPND));
            this.shopNdProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_SHOPND) as ShopNdProxy;
            this.shopNdProxy.realStage = stage;
            this._facade.registerProxy(new PackageProxy(AllConst.PROXY_NAME_PACKAGE));
            this.packageProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_PACKAGE) as PackageProxy;
            this.packageProxy.realStage = stage;
            this._facade.registerProxy(new FreePackageProxy(AllConst.PROXY_NAME_FREEPACKAGE));
            this.freePackageProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_FREEPACKAGE) as FreePackageProxy;
            this.freePackageProxy.realStage = stage;
         }
         if(AllConst.MODE_OBJECT[AllConst.MODE_NAME_RANKLIST])
         {
            this._facade.registerProxy(new RankListProxy(AllConst.PROXY_NAME_RANKLIST));
            this.rankListProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_RANKLIST) as RankListProxy;
            this.rankListProxy._realStage = stage;
         }
         if(AllConst.MODE_OBJECT[AllConst.MODE_NAME_UNION])
         {
            this._facade.registerProxy(new VisitorProxy(AllConst.PROXY_NAME_UNION_VISITOR));
            this.visitorProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_UNION_VISITOR) as VisitorProxy;
            this.visitorProxy.realStage = stage;
            this._facade.registerProxy(new MemberProxy(AllConst.PROXY_NAME_UNION_MEMBER));
            this.memberProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_UNION_MEMBER) as MemberProxy;
            this.memberProxy.realStage = stage;
            this._facade.registerProxy(new GrowProxy(AllConst.PROXY_NAME_UNION_GROW));
            this.growProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_UNION_GROW) as GrowProxy;
            this.growProxy.realStage = stage;
            this._facade.registerProxy(new MasterProxy(AllConst.PROXY_NAME_UNION_MASTER));
            this.masterProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_UNION_MASTER) as MasterProxy;
            this.masterProxy.realStage = stage;
            this._facade.registerProxy(new CommonVariableProxy(AllConst.PROXY_NAME_UNION_VARIABLE));
            this.variableProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_UNION_VARIABLE) as CommonVariableProxy;
            this.variableProxy.realStage = stage;
            this._facade.registerProxy(new RoleProxy(AllConst.PROXY_NAME_UNION_ROLE));
            this.roleProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_UNION_ROLE) as RoleProxy;
            this.roleProxy.realStage = stage;
         }
         if(AllConst.MODE_OBJECT[AllConst.MODE_NAME_SECONDARY])
         {
            this._facade.registerMediator(new SecondaryLogView(AllConst.VIEW_NAME_SECONDARY,this));
            this._facade.registerProxy(new SecondaryProxy(AllConst.PROXY_NAME_SECONDARY,stage));
            this.secondaryProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_SECONDARY) as SecondaryProxy;
         }
         this._facade.registerCommand(AllConst.SET_AS2_FOCUSMANAGER,this.sendAs2FocusManager,this);
         this._facade.registerCommand(AllConst.SAVE_RETURN,this.saveReturnHandler,this);
         if(!this.isLoadCutShot)
         {
            return;
         }
         this.loadCut();
      }
      
      public function setStyle(param1:String, param2:Object = null, param3:XML = null) : void
      {
         var _loc4_:Object = null;
         _loc4_ = new Object();
         _loc4_.gameID = param1;
         _loc4_.mode = param2;
         AllConst.MODE_OBJECT = param2;
         _loc4_.urlXML = param3;
         if(_loc4_.urlXML)
         {
            this.gameSizeObj = new Object();
            this.gameSizeObj.gameInitWid = _loc4_.urlXML.child("gameWidth").toString();
            this.gameSizeObj.gameInitHei = _loc4_.urlXML.child("gameHeight").toString();
            Dialog.gameSizeObj = this.gameSizeObj;
         }
         trace("__________________--");
         this._facade.registerCommand(AllConst.SKIN_LOAD_OK,this.skinLoadOK,null);
         this._facade.registerCommand(AllConst.MVC_CLOSE_PANEL,this.panelCloseHandler,null);
         this._facade.registerProxy(new MainProxy(AllConst.PROXY_NAME_MAIN));
         var _loc5_:CtrlSkin = new CtrlSkin();
         _loc5_.init();
         if(this._isInit)
         {
            this.doSetStyle(_loc4_);
            this.doFuncList(this._needDoIntegralList);
         }
         else
         {
            this.isSetStyleOk = true;
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.unshift({
               "func":this.doSetStyle,
               "param":_loc4_
            });
         }
      }
      
      private function doSetStyle(param1:Object) : void
      {
         this.mainProxy.gameID = param1.gameID;
         trace("doSetStyle----------->" + this.mainProxy.gameID);
         if(param1.urlXML)
         {
            this.mainProxy.gameName = param1.urlXML.gameName;
         }
         this.submit4399(this.advType);
      }
      
      public function statisticsAD(param1:int, param2:int, param3:Boolean, param4:String, param5:String) : void
      {
         if(param3)
         {
            this._adSuccess = "999";
         }
         else
         {
            this._adSuccess = "-1";
         }
         this._adLoadTime = param1;
         this._adPlayTime = param2;
      }
      
      public function getServerTime() : void
      {
         if(this._isInit)
         {
            this.doGetServerTime();
         }
         else
         {
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.push({
               "func":this.doGetServerTime,
               "param":null
            });
         }
      }
      
      private function doGetServerTime(param1:* = null) : void
      {
         this.mainProxy.getServerTime();
      }
      
      public function showGameList() : void
      {
         if(this._isInit)
         {
            this.doShowGameList();
         }
         else
         {
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.push({
               "func":this.doShowGameList,
               "param":null
            });
         }
      }
      
      private function doShowGameList(param1:* = null) : void
      {
         trace("gameId = " + this.mainProxy.gameID);
         this._facade.sendNotification(AllConst.MVC_SHOW_GAMELIST,this.mainProxy.gameID);
      }
      
      public function createUnion(param1:int, param2:String, param3:String) : *
      {
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else
         {
            this.visitorProxy.createUion(param1,param2,param3);
         }
      }
      
      public function getUnionList(param1:int, param2:int, param3:int) : *
      {
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else
         {
            this.visitorProxy.getUnionList(param1,param2,param3);
         }
      }
      
      public function applyUnion(param1:int, param2:int, param3:String) : *
      {
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else
         {
            this.visitorProxy.applyUnion(param1,param2,param3);
         }
      }
      
      public function getOwnUnion(param1:int) : *
      {
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else
         {
            this.visitorProxy.getOwnUnion(param1);
         }
      }
      
      public function getUnionDetail(param1:int, param2:int) : *
      {
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else
         {
            this.memberProxy.getUnionDetail(param1,param2);
         }
      }
      
      public function getUnionMembers(param1:int, param2:int) : *
      {
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else
         {
            this.memberProxy.getUnionMembers(param1,param2);
         }
      }
      
      public function setMemberExtra(param1:int, param2:int, param3:String, param4:int, param5:int, param6:int) : *
      {
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else
         {
            this.memberProxy.setMemberExtra(param1,param2,param3,param4,param5,param6);
         }
      }
      
      public function setUnionExtra(param1:int, param2:int, param3:String, param4:int) : *
      {
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else
         {
            this.memberProxy.setUnionExtra(param1,param2,param3,param4);
         }
      }
      
      public function getUnionLog(param1:int, param2:int, param3:Number) : *
      {
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else
         {
            this.memberProxy.getUnionLog(param1,param2,param3);
         }
      }
      
      public function quitUion(param1:int) : *
      {
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else
         {
            this.memberProxy.quitUion(param1);
         }
      }
      
      public function doTask(param1:int, param2:String) : *
      {
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else
         {
            this.growProxy.doTask(param1,param2);
         }
      }
      
      public function doExchange(param1:int, param2:int) : *
      {
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else
         {
            this.growProxy.doExchange(param1,param2);
         }
      }
      
      public function getTaskValue(param1:int) : *
      {
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else
         {
            this.growProxy.getTaskValue(param1);
         }
      }
      
      public function getApplyList(param1:int, param2:int, param3:int) : *
      {
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else
         {
            this.masterProxy.getApplyList(param1,param2,param3);
         }
      }
      
      public function auditMember(param1:int, param2:int, param3:int, param4:int) : *
      {
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else
         {
            this.masterProxy.auditMember(param1,param2,param3,param4);
         }
      }
      
      public function removeMember(param1:int, param2:int, param3:int) : *
      {
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else
         {
            this.masterProxy.removeMember(param1,param2,param3);
         }
      }
      
      public function dissolveUnion(param1:int, param2:int) : *
      {
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else
         {
            this.masterProxy.dissolveUnion(param1,param2);
         }
      }
      
      public function getVariables(param1:int, param2:Array) : *
      {
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else
         {
            this.variableProxy.getVariables(param1,param2);
         }
      }
      
      public function doVariable(param1:int, param2:int) : *
      {
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else
         {
            this.variableProxy.doVariable(param1,param2);
         }
      }
      
      public function getRoleList(param1:int, param2:int) : void
      {
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else
         {
            this.roleProxy.getRoleList(param1,param2);
         }
      }
      
      public function setRole(param1:int, param2:int, param3:int, param4:int) : void
      {
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else
         {
            this.memberProxy.setRole(param1,param2,param3,param4);
         }
      }
      
      public function usePersonalContribution(param1:int, param2:int) : *
      {
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else
         {
            this.memberProxy.usePersonalContribution(param1,param2);
         }
      }
      
      public function useUnionContribution(param1:int, param2:int) : *
      {
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else
         {
            this.masterProxy.useUnionContribution(param1,param2);
         }
      }
      
      public function applyMultiAudit(param1:int, param2:Array, param3:int) : *
      {
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else
         {
            this.masterProxy.applyMultiAudit(param1,param2,param3);
         }
      }
      
      public function transferUnion(param1:int, param2:int, param3:int, param4:int) : *
      {
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else
         {
            this.masterProxy.transferUnion(param1,param2,param3,param4);
         }
      }
      
      public function openIntegralWin(param1:int) : void
      {
         if(this._isInit)
         {
            this.doOpenIntegralWin(param1);
         }
         else
         {
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.push({
               "func":this.doOpenIntegralWin,
               "param":param1
            });
         }
      }
      
      private function doOpenIntegralWin(param1:int) : void
      {
         if(!this.mainProxy.isLog)
         {
            this.mainProxy._isOpenScoreUI = true;
            this.mainProxy._socre = param1;
            this.mainProxy.addNeedFunc("openIntegralWin",param1);
            this.mainProxy.getLogUser();
         }
         else
         {
            this._facade.sendNotification(AllConst.UP_DATA_SCORE,[param1]);
         }
      }
      
      public function userLogOut() : void
      {
         if(this._isInit)
         {
            this.doUserLogOut();
         }
         else
         {
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.push({
               "func":this.doUserLogOut,
               "param":null
            });
         }
      }
      
      private function doUserLogOut() : void
      {
         if(this.mainProxy.isLog)
         {
            this.mainProxy.loginOut(true);
            return;
         }
         this.mainProxy.getLogStateFun();
      }
      
      public function get isSecondaryLog() : Object
      {
         var _loc1_:Object = null;
         if(this.mainProxy.isLog && this.secondaryProxy.isLog)
         {
            _loc1_ = this.secondaryProxy.logInfo;
         }
         return _loc1_;
      }
      
      public function showSecondaryLogPanel() : void
      {
         this.addNeedIntegralFun(this.doShowSecondaryLogPanel);
      }
      
      private function addNeedIntegralFun(param1:Function, param2:Object = null) : void
      {
         if(this._isInit)
         {
            param1(param2);
         }
         else
         {
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.push({
               "func":param1,
               "param":param2
            });
         }
      }
      
      private function checkSecondaryMode(param1:String) : Boolean
      {
         if(!AllConst.MODE_OBJECT[AllConst.MODE_NAME_SECONDARY])
         {
            stage.dispatchEvent(new SecondaryEvent(param1,{"code":60001}));
            return false;
         }
         return true;
      }
      
      private function doShowSecondaryLogPanel(param1:Object) : void
      {
         if(!this.checkSecondaryMode(SecondaryEvent.LOGIN))
         {
            return;
         }
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.addNeedFunc("showSecondaryLogPanel",null);
            this.mainProxy.getLogUser();
         }
         else
         {
            this.secondaryProxy.LoginOfCheckCode();
         }
      }
      
      public function saveSecondaryData(param1:String, param2:Object, param3:int = 0) : void
      {
         var _loc4_:Object = new Object();
         _loc4_.title = param1;
         _loc4_.data = param2;
         _loc4_.index = param3;
         this.addNeedIntegralFun(this.doSaveSecondaryData,_loc4_);
      }
      
      private function doSaveSecondaryData(param1:Object = null) : void
      {
         if(!this.checkSecondaryMode(SecondaryEvent.SAVE_SET))
         {
            return;
         }
         this.secondaryProxy.addNeedLogFun(SecondaryProxy.SAVE_SET,param1);
      }
      
      public function getSecondaryData(param1:int = 0) : void
      {
         this.addNeedIntegralFun(this.doGetSecondaryData,param1);
      }
      
      private function doGetSecondaryData(param1:Object = null) : void
      {
         if(!this.checkSecondaryMode(SecondaryEvent.SAVE_GET))
         {
            return;
         }
         this.secondaryProxy.addNeedLogFun(SecondaryProxy.SAVE_GET,param1 as int);
      }
      
      public function getSecondarySaveList() : void
      {
         this.addNeedIntegralFun(this.doGetSecondarySaveList);
      }
      
      private function doGetSecondarySaveList(param1:Object = null) : void
      {
         if(!this.checkSecondaryMode(SecondaryEvent.SAVE_LIST))
         {
            return;
         }
         this.secondaryProxy.addNeedLogFun(SecondaryProxy.SAVE_GET_LIST);
      }
      
      public function secondaryLogOut() : void
      {
         this.addNeedIntegralFun(this.doSecondaryLogOut);
      }
      
      private function doSecondaryLogOut(param1:Object = null) : void
      {
         if(!this.checkSecondaryMode(SecondaryEvent.LOG_OUT))
         {
            return;
         }
         if(!this.secondaryProxy.isLog)
         {
            stage.dispatchEvent(new SecondaryEvent(SecondaryEvent.LOG_OUT,true));
            return;
         }
         this.secondaryProxy.addNeedLogFun(SecondaryProxy.LOG_OUT);
      }
      
      public function changeScore(param1:uint) : void
      {
         if(this._isInit)
         {
            this.doChangeScore(param1);
         }
         else
         {
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.push({
               "func":this.doChangeScore,
               "param":param1
            });
         }
      }
      
      private function doChangeScore(param1:uint) : void
      {
         if(!AllConst.MODE_OBJECT[AllConst.MODE_NAME_MEDAL])
         {
            return;
         }
         this.medalProxy.changeScore(param1);
      }
      
      public function submitScore(param1:uint) : void
      {
         if(this._isInit)
         {
            this.doSubmitScore(param1);
         }
         else
         {
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.push({
               "func":this.doSubmitScore,
               "param":param1
            });
         }
      }
      
      private function doSubmitScore(param1:uint) : void
      {
         if(!AllConst.MODE_OBJECT[AllConst.MODE_NAME_MEDAL])
         {
            return;
         }
         this.medalProxy.submitScore(param1);
      }
      
      public function getShopList() : void
      {
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else
         {
            this.shopNdProxy.getShopList();
         }
      }
      
      public function buyPropNd(param1:Object) : void
      {
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else
         {
            this.shopNdProxy.buyPropNd(param1);
         }
      }
      
      public function showShopUi() : void
      {
         if(this._isInit)
         {
            this.doShowShopUi();
         }
         else
         {
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.push({
               "func":this.doShowShopUi,
               "param":null
            });
         }
      }
      
      private function doShowShopUi(param1:Object = null) : void
      {
         if(!AllConst.MODE_OBJECT[AllConst.MODE_NAME_SHOP])
         {
            stage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Shop_Error_ShowUi));
            return;
         }
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.isShowShop = true;
            this.mainProxy.getLogUser();
         }
         else
         {
            this._facade.sendNotification(AllConst.GET_SHOP_DATA);
         }
      }
      
      public function buyProFun(param1:String, param2:int, param3:String = "") : void
      {
         var _loc4_:Array = [param2,param1];
         if(this._isInit)
         {
            this.doBuyProFun(_loc4_);
         }
         else
         {
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.push({
               "func":this.doBuyProFun,
               "param":_loc4_
            });
         }
      }
      
      private function doBuyProFun(param1:Array) : void
      {
         if(!AllConst.MODE_OBJECT[AllConst.MODE_NAME_SHOP])
         {
            stage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Shop_Error_ShowUi));
            return;
         }
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else if(this.shopProxy)
         {
            this.shopProxy.buyProFun(param1,false);
         }
      }
      
      public function modifyExValFun(param1:String, param2:Array, param3:String = "") : void
      {
         var _loc4_:Object = new Object();
         _loc4_.pId = param1;
         _loc4_.exAry = param2;
         _loc4_.sn = param3;
         if(this._isInit)
         {
            this.doModifyExValFun(_loc4_);
         }
         else
         {
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.push({
               "func":this.doModifyExValFun,
               "param":_loc4_
            });
         }
      }
      
      private function doModifyExValFun(param1:Object) : void
      {
         if(!AllConst.MODE_OBJECT[AllConst.MODE_NAME_SHOP])
         {
            stage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Shop_Error_ShowUi));
            return;
         }
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else if(this.packageProxy)
         {
            this.packageProxy.modifyExValFun(param1);
         }
      }
      
      public function set _exValue(param1:Array) : void
      {
         if(!AllConst.MODE_OBJECT[AllConst.MODE_NAME_SHOP])
         {
            stage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Shop_Error_ShowUi));
            return;
         }
         if(this.shopProxy)
         {
            this.shopProxy._exAry = param1;
         }
      }
      
      public function consumeItemFun(param1:String) : void
      {
         if(this._isInit)
         {
            this.doConsumeItemFun(param1);
         }
         else
         {
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.push({
               "func":this.doConsumeItemFun,
               "param":param1
            });
         }
      }
      
      private function doConsumeItemFun(param1:String) : void
      {
         if(!AllConst.MODE_OBJECT[AllConst.MODE_NAME_SHOP])
         {
            stage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Shop_Error_ShowUi));
            return;
         }
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else if(this.packageProxy)
         {
            this.packageProxy.consumeItem(param1);
         }
      }
      
      public function removeItemsFun(param1:Array, param2:String = "") : void
      {
         var _loc3_:Object = new Object();
         _loc3_.ary = param1;
         _loc3_.sn = param2;
         if(this._isInit)
         {
            this.doRemoveItemsFun(_loc3_);
         }
         else
         {
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.push({
               "func":this.doRemoveItemsFun,
               "param":_loc3_
            });
         }
      }
      
      private function doRemoveItemsFun(param1:Object) : void
      {
         if(!AllConst.MODE_OBJECT[AllConst.MODE_NAME_SHOP])
         {
            stage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Shop_Error_ShowUi));
            return;
         }
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else if(this.packageProxy)
         {
            this.packageProxy.opItems("sub",param1.ary,param1.sn);
         }
      }
      
      public function clearItemsByExType(param1:String, param2:Array, param3:String = "") : void
      {
         var _loc4_:Object = new Object();
         _loc4_.itemsType = param1;
         _loc4_.exFlag = param2;
         _loc4_.sn = param3;
         if(this._isInit)
         {
            this.doClearItemsByExType(_loc4_);
         }
         else
         {
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.push({
               "func":this.doClearItemsByExType,
               "param":_loc4_
            });
         }
      }
      
      private function doClearItemsByExType(param1:Object) : void
      {
         if(!AllConst.MODE_OBJECT[AllConst.MODE_NAME_SHOP])
         {
            stage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Shop_Error_ShowUi));
            return;
         }
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else if(this.packageProxy)
         {
            this.packageProxy.clearItemsByExTypeFun(param1);
         }
      }
      
      public function addItemsFun(param1:Array, param2:String = "") : void
      {
         var _loc3_:Object = new Object();
         _loc3_.ary = param1;
         _loc3_.sn = param2;
         if(this._isInit)
         {
            this.doAddItemsFun(_loc3_);
         }
         else
         {
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.push({
               "func":this.doAddItemsFun,
               "param":_loc3_
            });
         }
      }
      
      private function doAddItemsFun(param1:Object) : void
      {
         if(!AllConst.MODE_OBJECT[AllConst.MODE_NAME_SHOP])
         {
            stage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Shop_Error_ShowUi));
            return;
         }
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else if(this.packageProxy)
         {
            this.packageProxy.addItemsFun(param1.ary,param1.sn);
         }
      }
      
      public function updateItemProFun(param1:Object, param2:String = "") : void
      {
         var _loc3_:Object = new Object();
         _loc3_.itemObj = param1;
         _loc3_.sn = param2;
         if(this._isInit)
         {
            this.doUpdateItemProFun(_loc3_);
         }
         else
         {
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.push({
               "func":this.doUpdateItemProFun,
               "param":_loc3_
            });
         }
      }
      
      private function doUpdateItemProFun(param1:Object) : void
      {
         if(!AllConst.MODE_OBJECT[AllConst.MODE_NAME_SHOP])
         {
            stage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Shop_Error_ShowUi));
            return;
         }
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else if(this.packageProxy)
         {
            this.packageProxy.updateItemPro(param1.itemObj,param1.sn);
         }
      }
      
      public function getShopItemsFun(param1:Array, param2:String = "") : void
      {
         if(param1 == null || param1.length == 0)
         {
            stage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Package_Error_GetIdsList + param2));
            return;
         }
         var _loc3_:String = param1.join(",");
         trace("所有的物品id----->" + _loc3_);
         var _loc4_:Object = new Object();
         _loc4_.idStr = _loc3_;
         _loc4_.sn = param2;
         if(this._isInit)
         {
            this.doGetShopItemFun(_loc4_);
         }
         else
         {
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.push({
               "func":this.doGetShopItemFun,
               "param":_loc4_
            });
         }
      }
      
      private function doGetShopItemFun(param1:Object) : void
      {
         if(!AllConst.MODE_OBJECT[AllConst.MODE_NAME_SHOP])
         {
            stage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Shop_Error_ShowUi));
            return;
         }
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.addNeedFunc("getShopProItemsFun",param1);
            this.mainProxy.getLogUser();
         }
         else if(this.packageProxy)
         {
            this.packageProxy.getShopProItemsFun(param1);
         }
      }
      
      public function getPackageInfoFun(param1:uint, param2:String, param3:uint, param4:Array = null, param5:String = "") : void
      {
         var _loc6_:Object = new Object();
         _loc6_.pageNum = param1;
         _loc6_.typeId = param2;
         _loc6_.curPage = param3;
         _loc6_.exFlag = param4;
         _loc6_.sn = param5;
         if(this._isInit)
         {
            this.doGetPackageInfoFun(_loc6_);
         }
         else
         {
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.push({
               "func":this.doGetPackageInfoFun,
               "param":_loc6_
            });
         }
      }
      
      private function doGetPackageInfoFun(param1:Object) : void
      {
         if(!AllConst.MODE_OBJECT[AllConst.MODE_NAME_SHOP])
         {
            stage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Shop_Error_ShowUi));
            return;
         }
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.addNeedFunc("getPackageInfo",param1);
            this.mainProxy.getLogUser();
         }
         else if(this.packageProxy)
         {
            this.packageProxy.getPackageInfo(param1);
         }
      }
      
      public function getPayPacInfoFun(param1:uint, param2:uint, param3:String) : void
      {
         var _loc4_:Object = new Object();
         _loc4_.pageNum = param1;
         _loc4_.typeId = param3;
         _loc4_.curPage = param2;
         if(this._isInit)
         {
            this.doGetPayPacInfoFun(_loc4_);
         }
         else
         {
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.push({
               "func":this.doGetPayPacInfoFun,
               "param":_loc4_
            });
         }
      }
      
      private function doGetPayPacInfoFun(param1:Object) : void
      {
         if(!AllConst.MODE_OBJECT[AllConst.MODE_NAME_SHOP])
         {
            stage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Shop_Error_ShowUi));
            return;
         }
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.addNeedFunc("getPayPacInfoFun",param1);
            this.mainProxy.getLogUser();
         }
         else if(this.shopProxy)
         {
            this.shopProxy.getPayPacInfoFun(param1);
         }
      }
      
      public function getFreePacInfoFun(param1:uint, param2:uint, param3:String) : void
      {
         var _loc4_:Object = new Object();
         _loc4_.pageNum = param1;
         _loc4_.typeId = param3;
         _loc4_.curPage = param2;
         if(this._isInit)
         {
            this.doGetFreePackageInfoFun(_loc4_);
         }
         else
         {
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.push({
               "func":this.doGetFreePackageInfoFun,
               "param":_loc4_
            });
         }
      }
      
      private function doGetFreePackageInfoFun(param1:Object) : void
      {
         if(!AllConst.MODE_OBJECT[AllConst.MODE_NAME_SHOP])
         {
            stage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Shop_Error_ShowUi));
            return;
         }
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.addNeedFunc("getFreePackageInfo",param1);
            this.mainProxy.getLogUser();
         }
         else if(this.freePackageProxy)
         {
            this.freePackageProxy.getFreePackageInfo(param1);
         }
      }
      
      public function openSortWin() : void
      {
         if(AllConst.MODE_OBJECT[AllConst.MODE_NAME_SCORE])
         {
            this._facade.sendNotification(AllConst.MVC_SORT_REQUEST,true);
         }
      }
      
      public function getOneRankInfo(param1:uint, param2:String) : void
      {
         var _loc3_:Object = new Object();
         _loc3_.rankListId = param1;
         _loc3_.uname = param2;
         if(this._isInit)
         {
            this.doGetOneRankInfo(_loc3_);
         }
         else
         {
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.push({
               "func":this.doGetOneRankInfo,
               "param":_loc3_
            });
         }
      }
      
      private function doGetOneRankInfo(param1:Object) : void
      {
         if(!AllConst.MODE_OBJECT[AllConst.MODE_NAME_RANKLIST])
         {
            return;
         }
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else if(this.rankListProxy)
         {
            this.rankListProxy.getOneRankInfo(param1.rankListId,param1.uname);
         }
      }
      
      public function getRankListByOwn(param1:uint, param2:uint, param3:uint) : void
      {
         var _loc4_:Object = new Object();
         _loc4_.rankListId = param1;
         _loc4_.idx = param2;
         _loc4_.rankNum = param3;
         if(this._isInit)
         {
            this.doGetRankListByOwn(_loc4_);
         }
         else
         {
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.push({
               "func":this.doGetRankListByOwn,
               "param":_loc4_
            });
         }
      }
      
      private function doGetRankListByOwn(param1:Object) : void
      {
         if(!AllConst.MODE_OBJECT[AllConst.MODE_NAME_RANKLIST])
         {
            return;
         }
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else if(this.rankListProxy)
         {
            this.rankListProxy.getRankListByOwn(param1.rankListId,param1.idx,param1.rankNum);
         }
      }
      
      public function submitScoreToRankLists(param1:uint, param2:Array) : void
      {
         var _loc3_:Object = new Object();
         _loc3_.idx = param1;
         _loc3_.rankInfoAry = param2;
         if(this._isInit)
         {
            this.doSubmitScoreToRankLists(_loc3_);
         }
         else
         {
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.push({
               "func":this.doSubmitScoreToRankLists,
               "param":_loc3_
            });
         }
      }
      
      private function doSubmitScoreToRankLists(param1:Object) : void
      {
         if(!AllConst.MODE_OBJECT[AllConst.MODE_NAME_RANKLIST])
         {
            return;
         }
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else if(this.rankListProxy)
         {
            this.rankListProxy.submitScoreToRankLists(param1.idx,param1.rankInfoAry);
         }
      }
      
      public function getRankListsData(param1:uint, param2:uint, param3:uint) : void
      {
         var _loc4_:Object = new Object();
         _loc4_.rankListId = param1;
         _loc4_.pageSize = param2;
         _loc4_.pageNum = param3;
         if(this._isInit)
         {
            this.doGetRankListsData(_loc4_);
         }
         else
         {
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.push({
               "func":this.doGetRankListsData,
               "param":_loc4_
            });
         }
      }
      
      private function doGetRankListsData(param1:Object) : void
      {
         if(!AllConst.MODE_OBJECT[AllConst.MODE_NAME_RANKLIST])
         {
            return;
         }
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else if(this.rankListProxy)
         {
            this.rankListProxy.getRankListsData(param1.rankListId,param1.pageSize,param1.pageNum);
         }
      }
      
      public function getUserData(param1:String, param2:uint) : void
      {
         var _loc3_:Object = new Object();
         _loc3_.uid = param1;
         _loc3_.idx = param2;
         if(this._isInit)
         {
            this.doGetUserData(_loc3_);
         }
         else
         {
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.push({
               "func":this.doGetUserData,
               "param":_loc3_
            });
         }
      }
      
      private function doGetUserData(param1:Object) : void
      {
         if(!AllConst.MODE_OBJECT[AllConst.MODE_NAME_RANKLIST])
         {
            return;
         }
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
         else if(this.rankListProxy)
         {
            this.rankListProxy.getUserData(param1.uid,param1.idx);
         }
      }
      
      public function setMenuVisible(param1:Boolean) : void
      {
      }
      
      public function get isLog() : *
      {
         var _loc1_:Object = null;
         if(this.mainProxy.isLog)
         {
            _loc1_ = new Object();
            _loc1_.uid = this.mainProxy.userID;
            _loc1_.name = this.mainProxy.userName;
            _loc1_.nickName = this.mainProxy.userNickName;
            return _loc1_;
         }
         return null;
      }
      
      public function showLogPanel() : void
      {
         if(this._isInit)
         {
            this.doShowLogPanel(null);
         }
         else
         {
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.push({
               "func":this.doShowLogPanel,
               "param":null
            });
         }
      }
      
      private function doShowLogPanel(param1:Object = null) : void
      {
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.getLogUser();
         }
      }
      
      private function get saveProxy() : SaveProxy
      {
         return this._facade.retrieveProxy(AllConst.PROXY_NAME_SAVE) as SaveProxy;
      }
      
      public function incMoney(param1:int) : void
      {
         stage.dispatchEvent(new PayEvent(PayEvent.INC_MONEY,false));
      }
      
      public function decMoney(param1:int) : void
      {
         trace("减少游戏币sub--------------------->" + param1);
         if(param1 < 0)
         {
            param1 = -1 * param1;
         }
         var _loc2_:Object = {"value":param1};
         if(this._isInit)
         {
            this.doDecMoney(_loc2_);
         }
         else
         {
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.push({
               "func":this.doDecMoney,
               "param":_loc2_
            });
         }
      }
      
      private function doDecMoney(param1:Object) : void
      {
         if(!AllConst.MODE_OBJECT[AllConst.MODE_NAME_PAY])
         {
            stage.dispatchEvent(new PayEvent(PayEvent.DEC_MONEY,false));
            return;
         }
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.addPayNeedFunc("decMoney",param1.value);
            this.mainProxy.getLogUser();
         }
         else
         {
            this.mainProxy.decMoneyFun(param1.value);
         }
      }
      
      public function decMoneyStatistic(param1:int, param2:uint, param3:int, param4:String, param5:Number, param6:int) : void
      {
         if(param1 < 0)
         {
            param1 = -1 * param1;
         }
         var _loc7_:Object = {
            "money":param1,
            "saveIndex":param2,
            "propId":param3,
            "propName":param4,
            "propPrice":param5,
            "propCount":param6
         };
         if(this._isInit)
         {
            this.doDecMoneyStatistic(_loc7_);
         }
         else
         {
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.push({
               "func":this.doDecMoneyStatistic,
               "param":_loc7_
            });
         }
      }
      
      private function doDecMoneyStatistic(param1:Object) : void
      {
         if(!AllConst.MODE_OBJECT[AllConst.MODE_NAME_PAY])
         {
            stage.dispatchEvent(new PayEvent(PayEvent.DEC_MONEY,false));
            return;
         }
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.addPayNeedFunc("decMoneyStatistic",param1.money,param1);
            this.mainProxy.getLogUser();
         }
         else
         {
            this.mainProxy.decMoneyStatisticFun(param1.money,param1);
         }
      }
      
      public function getBalance() : void
      {
         if(this._isInit)
         {
            this.doGetBalance(null);
         }
         else
         {
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.push({
               "func":this.doGetBalance,
               "param":null
            });
         }
      }
      
      private function doGetBalance(param1:Object) : void
      {
         if(!AllConst.MODE_OBJECT[AllConst.MODE_NAME_PAY])
         {
            stage.dispatchEvent(new PayEvent(PayEvent.GET_MONEY,false));
            return;
         }
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.addPayNeedFunc("getMoney",0);
            this.mainProxy.getLogUser();
         }
         else
         {
            this.mainProxy.getMoneyFun();
         }
      }
      
      public function payMoney(param1:int) : void
      {
         trace("兑换游戏币change------>" + param1);
         if(param1 < 0)
         {
            param1 = -1 * param1;
         }
         var _loc2_:Object = {"value":param1};
         if(this._isInit)
         {
            this.doPayMoney(_loc2_);
         }
         else
         {
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.push({
               "func":this.doPayMoney,
               "param":_loc2_
            });
         }
      }
      
      private function doPayMoney(param1:Object) : void
      {
         if(!AllConst.MODE_OBJECT[AllConst.MODE_NAME_PAY])
         {
            stage.dispatchEvent(new PayEvent(PayEvent.PAY_MONEY,false));
            return;
         }
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.addPayNeedFunc("payMoney",param1.value);
            this.mainProxy.getLogUser();
         }
         else
         {
            this.mainProxy.payMoneyFun(param1.value);
         }
      }
      
      public function getTotalPaiedFun(param1:Object = null) : void
      {
         if(this._isInit)
         {
            this.doGetTotalPaiedFun(param1);
         }
         else
         {
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.push({
               "func":this.doGetTotalPaiedFun,
               "param":param1
            });
         }
      }
      
      private function doGetTotalPaiedFun(param1:* = null) : void
      {
         if(!AllConst.MODE_OBJECT[AllConst.MODE_NAME_PAY])
         {
            stage.dispatchEvent(new PayEvent(PayEvent.PAIED_MONEY,false));
            return;
         }
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.addPayNeedFunc("paiedMoney",0,param1);
            this.mainProxy.getLogUser();
         }
         else
         {
            this.mainProxy.getTotalPaiedFun(param1);
         }
      }
      
      public function getTotalRechargedFun(param1:Object = null) : void
      {
         if(this._isInit)
         {
            this.doGetTotalRechargedFun(param1);
         }
         else
         {
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.push({
               "func":this.doGetTotalRechargedFun,
               "param":param1
            });
         }
      }
      
      private function doGetTotalRechargedFun(param1:* = null) : void
      {
         if(!AllConst.MODE_OBJECT[AllConst.MODE_NAME_PAY])
         {
            stage.dispatchEvent(new PayEvent(PayEvent.PAIED_MONEY,false));
            return;
         }
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.addPayNeedFunc("rechargedMoney",0,param1);
            this.mainProxy.getLogUser();
         }
         else
         {
            this.mainProxy.getTotalRechargedFun(param1);
         }
      }
      
      public function saveData(param1:int = 0, param2:String = "", param3:String = "") : void
      {
         var _loc4_:Object = new Object();
         _loc4_.index = param1;
         _loc4_.title = param2;
         _loc4_.data = param3;
         if(this._isInit)
         {
            this.doSaveData(_loc4_);
         }
         else
         {
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.push({
               "func":this.doSaveData,
               "param":_loc4_
            });
         }
      }
      
      private function doSaveData(param1:Object) : void
      {
         if(!AllConst.MODE_OBJECT[AllConst.MODE_NAME_SAVE])
         {
            stage.dispatchEvent(new SaveEvent(SaveEvent.SAVE_SET,false));
            return;
         }
         this.saveProxy.needOpenUI = false;
         this.saveProxy.isOpenSaveUI = false;
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.addNeedFunc("saveData",param1);
            this.mainProxy.getLogUser();
         }
         else
         {
            this.saveProxy.setStore(param1.index.toString(),param1.title,param1.data);
         }
      }
      
      public function getData(param1:int = 0) : void
      {
         trace("doGetData------------index-------------------" + param1);
         if(this._isInit)
         {
            this.doGetData(param1);
         }
         else
         {
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.push({
               "func":this.doGetData,
               "param":param1
            });
         }
      }
      
      private function doGetData(param1:int = 0) : void
      {
         if(!AllConst.MODE_OBJECT[AllConst.MODE_NAME_SAVE])
         {
            stage.dispatchEvent(new SaveEvent(SaveEvent.SAVE_GET,null));
            return;
         }
         this.saveProxy.needOpenUI = false;
         this.saveProxy.isOpenSaveUI = false;
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.addNeedFunc("getData",{"index":param1});
            this.mainProxy.getLogUser();
         }
         else
         {
            trace("doGetData-------------------------------");
            if(this.mainProxy.getStoreAry == null)
            {
               this.mainProxy.getStoreAry = [];
            }
            this.mainProxy.getStoreAry.push(param1.toString());
            if(this.mainProxy.getStoreAry.length == 1)
            {
               this.saveProxy.getStore(param1.toString());
            }
         }
      }
      
      public function getList(param1:* = null) : void
      {
         if(this._isInit)
         {
            this.doGetList(null);
         }
         else
         {
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.push({
               "func":this.doGetList,
               "param":null
            });
         }
      }
      
      private function doGetList(param1:* = null) : void
      {
         if(!AllConst.MODE_OBJECT[AllConst.MODE_NAME_SAVE])
         {
            stage.dispatchEvent(new SaveEvent(SaveEvent.SAVE_LIST,null));
            return;
         }
         this.saveProxy.needOpenUI = false;
         this.saveProxy.isOpenSaveUI = false;
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.addNeedFunc("getList",null);
            this.mainProxy.getLogUser();
         }
         else
         {
            this.saveProxy.getList();
         }
      }
      
      public function set advType(param1:String) : void
      {
         this._advType = param1;
      }
      
      public function get advType() : String
      {
         return this._advType;
      }
      
      public function set mainHandler(param1:Object) : void
      {
         this._mainHandler = param1;
      }
      
      private function sendAs2FocusManager(param1:Notification) : void
      {
         trace("WMCtrl----------------  sendAs2FocusManager()s");
         if(this._mainHandler != null)
         {
            if(this._mainHandler["setFocusManager"] != null && this._mainHandler["setFocusManager"] != undefined)
            {
               this._mainHandler["setFocusManager"]();
            }
         }
      }
      
      public function set mouseVisible(param1:Boolean) : void
      {
         if(this.mainProxy == null)
         {
            this._mouseVisible = param1;
         }
         else
         {
            this.mainProxy.mouseVisible = param1;
         }
      }
      
      private function doFuncList(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Function = null;
         if(param1 == null)
         {
            return;
         }
         _loc3_ = int(param1.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(param1[_loc2_] != null && param1[_loc2_].func != null)
            {
               _loc4_ = param1[_loc2_].func as Function;
               if(_loc4_ != null)
               {
                  _loc4_(param1[_loc2_].param);
               }
            }
            _loc2_++;
         }
      }
      
      private function sumbit4399Error(param1:IOErrorEvent) : void
      {
         this._request_loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.securityErrorHandler);
         this._request_loader.removeEventListener(IOErrorEvent.IO_ERROR,this.sumbit4399Error);
         this._request_loader.removeEventListener(Event.COMPLETE,this.sumbit4399Complete);
         this._request_loader = null;
         trace("************");
      }
      
      private function securityErrorHandler(param1:SecurityErrorEvent) : void
      {
         this._request_loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.securityErrorHandler);
         this._request_loader.removeEventListener(IOErrorEvent.IO_ERROR,this.sumbit4399Error);
         this._request_loader.removeEventListener(Event.COMPLETE,this.sumbit4399Complete);
         this._request_loader = null;
         trace("************");
      }
      
      private function sumbit4399Complete(param1:Event) : void
      {
         this._request_loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.securityErrorHandler);
         this._request_loader.removeEventListener(IOErrorEvent.IO_ERROR,this.sumbit4399Error);
         this._request_loader.removeEventListener(Event.COMPLETE,this.sumbit4399Complete);
         this._request_loader = null;
         this.getIEVer();
         trace("************");
      }
      
      private function submit4399(param1:String) : void
      {
         var submitURL:String;
         var request:URLRequest;
         var ieVer:String = null;
         var currDomain:String = null;
         var time:Date = null;
         var currTime:Number = NaN;
         var currNum0:Number = NaN;
         var currNum1:Number = NaN;
         var currNum2:Number = NaN;
         var currNum3:Number = NaN;
         var currNum4:Number = NaN;
         var currNum:String = null;
         var seed:String = null;
         var adType:String = param1;
         var swfurl:String = loaderInfo.loaderURL;
         var os:String = Capabilities.os;
         var lng:String = Capabilities.language;
         var scres:String = Capabilities.screenResolutionX + "x" + Capabilities.screenResolutionY;
         var fp:String = Capabilities.version;
         var seedValue:String = "";
         if(this.mySo == null)
         {
            this.mySo = SharedObject.getLocal("seed4399Value","/");
         }
         if(this.mySo.data.seedValue == undefined)
         {
            time = new Date();
            currTime = time.time;
            currNum0 = Math.random() * 9;
            currNum1 = Math.random() * 9;
            currNum2 = Math.random() * 9;
            currNum3 = Math.random() * 9;
            currNum4 = Math.random() * 9;
            currNum = String(currNum0) + String(currNum1) + String(currNum2) + String(currNum3) + String(currNum4);
            seed = this.createSeed(String(currTime),currNum,swfurl,os,lng,scres,fp);
            seedValue = MD5.hash(seed);
            this.mySo.data.seedValue = seedValue;
            this.mySo.flush();
         }
         else
         {
            seedValue = String(this.mySo.data.seedValue);
         }
         ieVer = this.getIEVer();
         if(ieVer == null)
         {
            ieVer = "-1";
         }
         currDomain = StyleClass.getHref();
         if(currDomain == null)
         {
            currDomain = swfurl;
         }
         this._request_loader = new URLLoader();
         submitURL = "https://stat.api.4399.com/flashflowstatis/submitflowstatis.php?";
         submitURL += "gameid=" + this.mainProxy.gameID;
         submitURL += "&seedvalue=" + seedValue;
         submitURL += "&adid=" + adType;
         submitURL += "&gamekey=asdf";
         submitURL += "&nocache=" + currTime;
         submitURL += "&os=" + os;
         submitURL += "&lng=" + lng;
         submitURL += "&hosturl=" + this.delFlag("#",currDomain);
         submitURL += "&scres=" + scres;
         submitURL += "&playurl=" + this.delFlag("#",swfurl);
         submitURL += "&fp=" + fp;
         submitURL += "&adLoadTime=" + this._adLoadTime;
         submitURL += "&adPlayTime=" + this._adPlayTime;
         submitURL += "&browser=" + ieVer;
         submitURL += "&ctrVer=5";
         request = new URLRequest(submitURL);
         request.method = URLRequestMethod.GET;
         this._request_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.securityErrorHandler,false,0,true);
         this._request_loader.addEventListener(Event.COMPLETE,this.sumbit4399Complete,false,0,true);
         this._request_loader.addEventListener(IOErrorEvent.IO_ERROR,this.sumbit4399Error,false,0,true);
         try
         {
            this._request_loader.load(request);
         }
         catch(error:Error)
         {
            trace("Unable to load requested document.");
         }
      }
      
      private function delFlag(param1:String, param2:String) : String
      {
         if(param2 == null && param2.length <= 1)
         {
            return param2;
         }
         var _loc3_:Array = param2.split(param1);
         return String(_loc3_[0]);
      }
      
      private function getR() : String
      {
         var _loc1_:String = "1234567890abcdefghijklmnopqrstuvwxyz~!@#$%^&*()_+|";
         var _loc2_:Number = _loc1_.length - 1;
         return _loc1_.charAt(Math.random() * _loc2_);
      }
      
      private function createSeed(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String, param7:String) : String
      {
         return param1 + this.getR() + param2 + this.getR() + param3 + this.getR() + param4 + this.getR() + param5 + this.getR() + param6 + this.getR() + param7;
      }
      
      private function getIEVer() : String
      {
         if(!ExternalInterface.available)
         {
            return null;
         }
         try
         {
            return ExternalInterface.call("eval","window.navigator.userAgent");
         }
         catch(e:Error)
         {
            return null;
         }
      }
      
      public function getStoreState() : void
      {
         if(this._isInit)
         {
            this.doGetStoreState(null);
         }
         else
         {
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.push({
               "func":this.doGetStoreState,
               "param":null
            });
         }
      }
      
      private function doGetStoreState(param1:Object) : void
      {
         if(!AllConst.MODE_OBJECT[AllConst.MODE_NAME_SAVE])
         {
            stage.dispatchEvent(new DataEvent("StoreStateEvent",false,false,"-2"));
            return;
         }
         if(this.mainProxy.isLog)
         {
            this.saveProxy.getStoreState();
         }
         else
         {
            stage.dispatchEvent(new DataEvent("StoreStateEvent",false,false,"-3"));
         }
      }
      
      public function save(param1:String, param2:Object, param3:Boolean = true, param4:int = 0) : void
      {
         var _loc5_:Object = null;
         _loc5_ = new Object();
         _loc5_.title = param1;
         _loc5_.data = param2;
         _loc5_.ui = param3;
         _loc5_.index = param4;
         if(this._isInit)
         {
            this.doSave(_loc5_);
         }
         else
         {
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.push({
               "func":this.doSave,
               "param":_loc5_
            });
         }
      }
      
      public function get(param1:Boolean = true, param2:int = 0) : void
      {
         var _loc3_:Object = null;
         _loc3_ = new Object();
         _loc3_.ui = param1;
         _loc3_.index = param2;
         if(this._isInit)
         {
            this.doGet(_loc3_);
         }
         else
         {
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.push({
               "func":this.doGet,
               "param":_loc3_
            });
         }
      }
      
      public function openSaveUI(param1:String, param2:Object) : void
      {
         if(this._isInit)
         {
            this.doOpenSaveUI({
               "title":param1,
               "data":param2
            });
         }
         else
         {
            if(this._needDoIntegralList == null)
            {
               this._needDoIntegralList = [];
            }
            this._needDoIntegralList.push({
               "func":this.doOpenSaveUI,
               "param":{
                  "title":param1,
                  "data":param2
               }
            });
         }
      }
      
      private function doSave(param1:Object) : void
      {
         if(param1.index > 7 || param1.index < 0 || !AllConst.MODE_OBJECT[AllConst.MODE_NAME_SAVE])
         {
            stage.dispatchEvent(new SaveEvent(SaveEvent.SAVE_SET,false));
            return;
         }
         this.saveProxy.needOpenUI = true;
         this.saveProxy.isOpenSaveUI = param1.ui;
         if(this.mainProxy.isLog)
         {
            this._facade.sendNotification(AllConst.OPEN_SAVE_LIST_UI,{
               "mode":AllConst.SAVE_MODE,
               "title":param1.title,
               "data":param1.data,
               "needUI":param1.ui,
               "index":param1.index
            });
         }
         else
         {
            this.mainProxy.addNeedFunc("openSaveList",{
               "mode":AllConst.SAVE_MODE,
               "title":param1.title,
               "data":param1.data,
               "needUI":param1.ui,
               "index":param1.index
            });
            this.mainProxy.getLogUser();
         }
      }
      
      private function doGet(param1:Object) : void
      {
         if(param1.index > 7 || param1.index < 0 || !AllConst.MODE_OBJECT[AllConst.MODE_NAME_SAVE])
         {
            stage.dispatchEvent(new SaveEvent(SaveEvent.SAVE_GET,null));
            return;
         }
         this.saveProxy.isOpenSaveUI = param1.ui;
         this.saveProxy.needOpenUI = true;
         if(this.mainProxy.isLog)
         {
            this._facade.sendNotification(AllConst.OPEN_SAVE_LIST_UI,{
               "mode":AllConst.GET_MODE,
               "index":param1.index,
               "needUI":param1.ui
            });
         }
         else
         {
            this.mainProxy.addNeedFunc("openSaveList",{
               "mode":AllConst.GET_MODE,
               "index":param1.index,
               "needUI":param1.ui
            });
            this.mainProxy.getLogUser();
         }
      }
      
      private function doOpenSaveUI(param1:Object) : void
      {
         var _loc2_:String = null;
         if(!AllConst.MODE_OBJECT[AllConst.MODE_NAME_SAVE])
         {
            return;
         }
         if(this._objToXml == null)
         {
            this._objToXml = new ObjectToXML();
         }
         _loc2_ = this._objToXml.objectToString(param1.data);
         this.saveProxy.needOpenUI = true;
         this.saveProxy.isOpenSaveUI = true;
         if(this.mainProxy.isLog)
         {
            this._facade.sendNotification(AllConst.OPEN_SAVE_LIST_UI,{
               "mode":AllConst.SAVE_GET_MODE,
               "title":param1.title,
               "data":_loc2_,
               "oldData":param1.data,
               "needUI":true
            });
         }
         else
         {
            this.mainProxy.addNeedFunc("openSaveList",{
               "mode":AllConst.SAVE_GET_MODE,
               "title":param1.title,
               "data":_loc2_,
               "oldData":param1.data,
               "needUI":true
            });
            this.mainProxy.getLogUser();
         }
      }
      
      private function panelCloseHandler(param1:Notification) : void
      {
         trace("舞台派发关闭面板的通知" + String(param1.getBody()));
         stage.dispatchEvent(new DataEvent(AllConst.MVC_CLOSE_PANEL,false,false,String(param1.getBody())));
      }
      
      private function saveReturnHandler(param1:Notification) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         var _loc4_:SaveEvent = null;
         var _loc5_:Object = null;
         var _loc6_:Array = null;
         var _loc7_:int = 0;
         var _loc8_:Boolean = false;
         var _loc9_:int = 0;
         var _loc10_:Boolean = false;
         var _loc11_:Object = null;
         var _loc12_:String = null;
         var _loc13_:XML = null;
         var _loc14_:Boolean = false;
         var _loc15_:Array = null;
         _loc2_ = int(param1.getBody().type);
         _loc3_ = param1.getBody().data;
         switch(_loc2_)
         {
            case AllConst.SAVE_EVENT_GET:
               _loc7_ = int(param1.getBody().from);
               if(_loc3_ != null)
               {
                  if(this._xmlToObj == null)
                  {
                     this._xmlToObj = new XMLToObject();
                  }
                  trace("############@@@@@@@@@@@@#########");
                  _loc6_ = this._xmlToObj.strToObj(_loc3_.data as String);
                  trace("type = " + _loc6_[0]);
                  trace("data = " + _loc6_[1]);
                  if(_loc6_[0] == "String")
                  {
                     _loc12_ = _loc6_[1];
                     trace("############@@@@@@@@@@@@#########");
                     _loc3_.data = _loc12_;
                  }
                  else if(_loc6_[0] == "XML")
                  {
                     _loc13_ = _loc6_[1];
                     _loc3_.data = _loc13_;
                  }
                  else if(_loc6_[0] == "Boolean")
                  {
                     _loc14_ = Boolean(_loc6_[1]);
                     _loc3_.data = _loc14_;
                  }
                  else if(_loc6_[0] == "Object")
                  {
                     _loc5_ = _loc6_[1];
                     _loc3_.data = _loc5_;
                  }
                  else if(_loc6_[0] == "Array")
                  {
                     _loc15_ = _loc6_[1];
                     _loc3_.data = _loc15_;
                  }
               }
               trace("$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
               _loc8_ = param1.getBody().netError as Boolean;
               if(_loc8_)
               {
                  if(_loc7_ == AllConst.MULTIPLE_ERROR)
                  {
                     stage.dispatchEvent(new Event("multipleError"));
                  }
                  else
                  {
                     stage.dispatchEvent(new DataEvent(NET_GET_ERROR,false,false,String(param1.getBody().saveIdx)));
                  }
               }
               _loc4_ = new SaveEvent(SaveEvent.SAVE_GET,_loc3_);
               break;
            case AllConst.SAVE_EVENT_DataExcep:
               this.saveGetHandler(new Object());
               trace("except---->index:" + _loc3_.index,"status:" + _loc3_.status);
               stage.dispatchEvent(new SaveEvent("getDataExcep",_loc3_));
               return;
            case AllConst.SAVE_EVENT_LIST:
               _loc4_ = new SaveEvent(SaveEvent.SAVE_LIST,_loc3_);
               break;
            case AllConst.SAVE_EVENT_SAVE:
               _loc7_ = int(param1.getBody().from);
               if(_loc7_ == AllConst.DATA_FROM_LOCAL)
               {
                  stage.dispatchEvent(new Event(NET_SAVE_ERROR));
               }
               else if(_loc7_ == AllConst.MULTIPLE_ERROR)
               {
                  stage.dispatchEvent(new Event("multipleError"));
               }
               _loc4_ = new SaveEvent(SaveEvent.SAVE_SET,_loc3_);
               _loc9_ = -1;
               _loc10_ = false;
               if(this.saveProxy)
               {
                  _loc9_ = this.saveProxy.saveIdx;
                  _loc10_ = this.saveProxy.isOpenSaveUI;
               }
               if(!_loc10_)
               {
                  break;
               }
               trace("当前存档的索引值-------" + _loc9_);
               _loc11_ = new Object();
               _loc11_.idx = _loc9_;
               _loc11_.saveType = "set";
               stage.dispatchEvent(new SaveEvent("saveBackIndex",_loc11_));
         }
         if(_loc2_ == AllConst.SAVE_EVENT_LIST && this.saveProxy != null && this.saveProxy.isOpenSaveUI)
         {
            return;
         }
         stage.dispatchEvent(_loc4_);
      }
      
      private function loadCut() : void
      {
         var _loc1_:Array = null;
         if(ExternalInterface.available)
         {
            try
            {
               this._gameInfoStr = ExternalInterface.call("getGameInfo");
               if(this._gameInfoStr)
               {
                  _loc1_ = this._gameInfoStr.split("|");
                  this._gameWid = _loc1_[0];
                  this._gameHei = _loc1_[1];
                  this._gameId = _loc1_[2];
                  this._gameName = _loc1_[3];
               }
            }
            catch(e:Error)
            {
            }
         }
         trace("_gameInfoStr = " + this._gameInfoStr);
         this._loaderContext = new LoaderContext(false,new ApplicationDomain());
         this._cutShotLoader = new Loader();
         this._cutShotLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadCutShotCompleteHandler,false,0,true);
         this._cutShotLoader.loadBytes(new cutShot() as ByteArray,this._loaderContext);
         addChild(this._cutShotLoader);
      }
      
      private function loadCutShotCompleteHandler(param1:Event) : void
      {
         this._cutShotLoader.content["a868f47895510ee8f7"] = this._gameId;
      }
   }
}

