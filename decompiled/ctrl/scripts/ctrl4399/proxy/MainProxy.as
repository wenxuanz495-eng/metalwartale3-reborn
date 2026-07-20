package ctrl4399.proxy
{
   import com.adobe.crypto.MD5;
   import com.adobe.serialization.json.JSON;
   import ctrl4399.strconst.AllConst;
   import ctrl4399.view.components.styleConst.StyleClass;
   import flash.display.Stage;
   import flash.events.DataEvent;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import frame4399.simplePureMvc.core.Facade;
   import frame4399.simplePureMvc.interfaces.IProxy;
   import frame4399.simplePureMvc.proxy.Proxy;
   import unit4399.calljs.CallJsClass;
   import unit4399.events.PayEvent;
   import unit4399.events.SaveEvent;
   import unit4399.road.loader.LoaderManager;
   
   public class MainProxy extends Proxy implements IProxy
   {
      
      public var realStage:Stage;
      
      public var gameName:String = "";
      
      public var gameID:String = "";
      
      public var userName:String = "";
      
      public var userID:String = "";
      
      public var userNickName:String = "";
      
      public var userType:String = "";
      
      public var isLog:Boolean = false;
      
      public var _isOpenScoreUI:Boolean;
      
      public var _socre:int;
      
      public var _isOpenLogUI:Boolean;
      
      public var _isMedalLog:Boolean;
      
      private var _isFlashCallLog:Boolean;
      
      private var isCanUsePayApi:Boolean = true;
      
      private var secret:String = "123456abcdefghijklmnopqrstuvwxyz";
      
      private var _needList:Array;
      
      private var _isLoging:Boolean;
      
      private var _mouseVisible:Boolean = true;
      
      public var isShowShop:Boolean = false;
      
      public var getStoreAry:Array;
      
      public var saveStoreAry:Array;
      
      public var isOutOp:Boolean = false;
      
      private var isFirstLogOut:Boolean;
      
      private var checkUserInfoNum:int = 0;
      
      private var setMoneyAry:Array;
      
      private var logGetMoney:LogData;
      
      private var logGetTotalPaied:LogData;
      
      private var logGetTotalRecharged:LogData;
      
      private var logGetPayToken:LogData;
      
      private var logDecMoney:LogData;
      
      private var logServerTime:LogData;
      
      public function MainProxy(param1:String = null)
      {
         super(param1);
         CallJsClass.jsCallAsFun("loginCallback",this,"loginRegSucBackFun");
         CallJsClass.jsCallAsFun("logoutCallback",this,"logOutSucBackFun");
         CallJsClass.jsCallAsFun("closeLogRegWindow",this,"closeLogRegWindow");
      }
      
      private function setUserInfo() : void
      {
         this.userID = CallJsClass.asCallJsFun("UniLogin.getUid") as String;
         this.userName = CallJsClass.asCallJsFun("UniLogin.getUname") as String;
         this.userNickName = CallJsClass.asCallJsFun("UniLogin.getDisplayNameText") as String;
         var _loc1_:String = CallJsClass.asCallJsFun("UniLogin.getUserLoginType") as String;
         this.userType = "当前账号登录方式：" + _loc1_;
      }
      
      public function closeLogRegWindow() : void
      {
         sendNotification(AllConst.MVC_CLOSE_PANEL,AllConst.CLOSE_LOGIN_WIN);
      }
      
      public function loginRegSucBackFun() : void
      {
         if(this.isLog)
         {
            return;
         }
         if(!this._isFlashCallLog)
         {
            this._isMedalLog = true;
         }
         this._isLoging = false;
         this.isLog = true;
         this.setUserInfo();
         var _loc1_:RedeemTaskProxy = Facade.getInstance().retrieveProxy(AllConst.PROXY_NAME_REDEEMTASK) as RedeemTaskProxy;
         _loc1_.submitToServer("login");
         if(Boolean(AllConst.MODE_OBJECT[AllConst.MODE_NAME_PAY]) || Boolean(AllConst.MODE_OBJECT[AllConst.MODE_NAME_SHOP]))
         {
            if(this.realStage != null)
            {
               this.realStage.dispatchEvent(new PayEvent(PayEvent.LOG,{
                  "uid":this.userID,
                  "name":this.userName,
                  "nickName":this.userNickName
               }));
            }
            this.setPayInfo();
         }
         if(AllConst.MODE_OBJECT[AllConst.MODE_NAME_SAVE])
         {
            sendNotification(AllConst.MVC_GET_SESSION);
         }
         else
         {
            this.runNeedFunc();
         }
         if(this.realStage != null)
         {
            this.realStage.dispatchEvent(new SaveEvent(SaveEvent.LOG,{
               "uid":this.userID,
               "name":this.userName,
               "nickName":this.userNickName
            }));
         }
         sendNotification(AllConst.MVC_LOG_SUCCESS);
      }
      
      public function logOutSucBackFun() : void
      {
         this._isMedalLog = false;
         this._isFlashCallLog = false;
         this.isLog = false;
         this.userName = "";
         this.userID = "";
         this.userNickName = "";
         sendNotification(AllConst.MVC_LOGOUT);
         if(this.realStage)
         {
            this.realStage.dispatchEvent(new Event("userLoginOut"));
         }
         var _loc1_:RedeemTaskProxy = Facade.getInstance().retrieveProxy(AllConst.PROXY_NAME_REDEEMTASK) as RedeemTaskProxy;
         _loc1_.delTimer();
      }
      
      public function getSign(param1:String, param2:String) : String
      {
         return MD5.hash(param1 + this.gameID + param2 + this.secret);
      }
      
      public function loginOut(param1:Boolean = false) : void
      {
         if(param1)
         {
            this.reqLogOut();
         }
         else
         {
            sendNotification(AllConst.MVC_SHOW_LOGOUTTIP);
         }
      }
      
      public function reqLogOut() : void
      {
         CallJsClass.asCallJsFun("UniLogin.logout");
         var _loc1_:SecondaryProxy = Facade.getInstance().retrieveProxy(AllConst.PROXY_NAME_SECONDARY) as SecondaryProxy;
         if(_loc1_ != null && _loc1_.isLog)
         {
            _loc1_.addNeedLogFun(SecondaryProxy.LOG_OUT);
         }
      }
      
      public function getLogStateFun() : void
      {
         if(this.isFirstLogOut)
         {
            return;
         }
         this.isFirstLogOut = true;
         this.setUserInfo();
         if(this.userID == null || this.userName == null)
         {
            return;
         }
         this.loginOut(true);
      }
      
      public function getLogUser() : void
      {
         if(this._isLoging || this.isLog)
         {
            return;
         }
         this._isLoging = true;
         this.isFirstLogOut = true;
         this._isFlashCallLog = true;
         this.setUserInfo();
         if(this.userID == null || this.userName == null)
         {
            this.isLog = false;
            this._isLoging = false;
            if(this._isOpenScoreUI)
            {
               sendNotification(AllConst.MVC_SHOW_SCORE,[this._socre]);
               this._isOpenScoreUI = false;
               this._socre = 0;
            }
            else if(this._isOpenLogUI)
            {
               sendNotification(AllConst.MVC_SHOW_LOGBOX);
            }
            else
            {
               this.setMoneyAry = null;
               sendNotification(AllConst.MVC_SHOW_LOGBOX);
            }
            return;
         }
         this.userInfoValidityCheck();
      }
      
      private function checkUserInfoCompleted(param1:Event) : void
      {
         if(param1.type != Event.COMPLETE)
         {
            if(this.checkUserInfoNum < 2)
            {
               ++this.checkUserInfoNum;
               this.userInfoValidityCheck();
            }
            else
            {
               this.checkUserInfoNum = 0;
               this._isLoging = false;
               this.loginOut(true);
            }
            return;
         }
         this.checkUserInfoNum = 0;
         var _loc2_:String = param1.target.data;
         var _loc3_:Array = _loc2_.split("|");
         _loc3_.shift();
         _loc3_.pop();
         var _loc4_:int = int(_loc3_.shift());
         if(_loc4_ != 1000 || _loc3_[0] == "0" || _loc3_[0] == "" || _loc3_[1] == "")
         {
            this._isLoging = false;
            this.loginOut(true);
         }
         else
         {
            this.loginRegSucBackFun();
         }
      }
      
      private function userInfoValidityCheck() : void
      {
         var _loc1_:URLVariables = new URLVariables();
         _loc1_.uid = this.userID;
         _loc1_.username = this.userName;
         _loc1_.gameid = this.gameID;
         LoaderManager.loadBytes(AllConst.URL_CHECK_USERINFO,this.checkUserInfoCompleted,_loc1_);
      }
      
      private function setPayInfo() : void
      {
         this.runPayNeedFunc();
         if(this.isShowShop)
         {
            sendNotification(AllConst.GET_SHOP_DATA);
            this.isShowShop = false;
         }
         trace("服务器那边确认成功--------------");
         if(this.realStage != null)
         {
            this.realStage.dispatchEvent(new PayEvent("usePayApi",new Object()));
         }
      }
      
      public function addPayNeedFunc(param1:String, param2:uint, param3:Object = null) : void
      {
         if(this.setMoneyAry == null)
         {
            this.setMoneyAry = [];
         }
         switch(param1)
         {
            case "decMoney":
               this.setMoneyAry.push({
                  "payType":"dec",
                  "moneyVal":param2
               });
               break;
            case "decMoneyStatistic":
               this.setMoneyAry.push({
                  "payType":"decStatistic",
                  "moneyVal":param2,
                  "exInfo":param3
               });
               break;
            case "getMoney":
               this.setMoneyAry.push({
                  "payType":"getMoney",
                  "moneyVal":param2
               });
               break;
            case "payMoney":
               if(this.setMoneyAry.length == 0)
               {
                  this.setMoneyAry.push({
                     "payType":"payMoney",
                     "moneyVal":param2
                  });
               }
               break;
            case "paiedMoney":
               this.setMoneyAry.push({
                  "payType":"paiedMoney",
                  "moneyVal":param2,
                  "exInfo":param3
               });
               break;
            case "rechargedMoney":
               this.setMoneyAry.push({
                  "payType":"rechargedMoney",
                  "moneyVal":param2,
                  "exInfo":param3
               });
         }
      }
      
      private function runPayNeedFunc() : void
      {
         var _loc2_:Object = null;
         if(this.setMoneyAry == null || this.setMoneyAry.length == 0)
         {
            return;
         }
         var _loc1_:* = 0;
         for(; _loc1_ < this.setMoneyAry.length; _loc1_++)
         {
            _loc2_ = this.setMoneyAry[_loc1_];
            if(_loc2_ == null || _loc2_.payType == undefined || _loc2_.moneyVal == undefined)
            {
               this.setMoneyAry.shift();
               _loc1_--;
               continue;
            }
            switch(_loc2_.payType)
            {
               case "dec":
               case "decStatistic":
               case "getMoney":
               case "paiedMoney":
               case "rechargedMoney":
                  this.getPayFun();
                  return;
               case "payMoney":
                  this.payMoneyFun(_loc2_.moneyVal);
                  this.setMoneyAry.shift();
                  _loc1_--;
            }
         }
      }
      
      public function getTotalPaiedFun(param1:Object = null) : void
      {
         var _loc2_:Object = null;
         if(!this.isCanUsePayApi)
         {
            _loc2_ = new Object();
            _loc2_.info = "0|请重试!若还不行,请重新登录!!";
            if(this.realStage != null)
            {
               this.realStage.dispatchEvent(new PayEvent(PayEvent.PAY_ERROR,_loc2_));
            }
            return;
         }
         if(this.setMoneyAry == null)
         {
            this.setMoneyAry = [];
         }
         this.setMoneyAry.push({
            "payType":"paiedMoney",
            "moneyVal":0,
            "exInfo":param1
         });
         if(this.setMoneyAry.length == 1)
         {
            this.getPayFun();
         }
      }
      
      public function getTotalRechargedFun(param1:Object = null) : void
      {
         var _loc2_:Object = null;
         if(!this.isCanUsePayApi)
         {
            _loc2_ = new Object();
            _loc2_.info = "0|请重试!若还不行,请重新登录!!";
            if(this.realStage != null)
            {
               this.realStage.dispatchEvent(new PayEvent(PayEvent.PAY_ERROR,_loc2_));
            }
            return;
         }
         if(this.setMoneyAry == null)
         {
            this.setMoneyAry = [];
         }
         this.setMoneyAry.push({
            "payType":"rechargedMoney",
            "moneyVal":0,
            "exInfo":param1
         });
         if(this.setMoneyAry.length == 1)
         {
            this.getPayFun();
         }
      }
      
      public function decMoneyFun(param1:uint) : void
      {
         var _loc2_:Object = null;
         if(!this.isCanUsePayApi)
         {
            _loc2_ = new Object();
            _loc2_.info = "0|请重试!若还不行,请重新登录!!";
            if(this.realStage != null)
            {
               this.realStage.dispatchEvent(new PayEvent(PayEvent.PAY_ERROR,_loc2_));
            }
            return;
         }
         if(this.setMoneyAry == null)
         {
            this.setMoneyAry = [];
         }
         this.setMoneyAry.push({
            "payType":"dec",
            "moneyVal":param1
         });
         if(this.setMoneyAry.length == 1)
         {
            this.getPayFun();
         }
      }
      
      public function decMoneyStatisticFun(param1:uint, param2:Object) : void
      {
         if(!this.isCanUsePayApi)
         {
            param2 = new Object();
            param2.info = "0|请重试!若还不行,请重新登录!!";
            if(this.realStage != null)
            {
               this.realStage.dispatchEvent(new PayEvent(PayEvent.PAY_ERROR,param2));
            }
            return;
         }
         if(this.setMoneyAry == null)
         {
            this.setMoneyAry = [];
         }
         this.setMoneyAry.push({
            "payType":"decStatistic",
            "moneyVal":param1,
            "exInfo":param2
         });
         if(this.setMoneyAry.length == 1)
         {
            this.getPayFun();
         }
      }
      
      private function getPayFun() : void
      {
         var _loc2_:URLVariables = null;
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:Object = null;
         if(this.setMoneyAry == null || this.setMoneyAry.length == 0)
         {
            return;
         }
         var _loc1_:Object = this.setMoneyAry[0];
         if(_loc1_ != null && _loc1_.payType != undefined)
         {
            _loc2_ = new URLVariables();
            _loc2_.gameid = this.gameID;
            _loc2_.uid = this.userID;
            _loc2_.time = _loc1_.time = new Date().getTime().toString();
            if(Boolean(_loc1_.exInfo) && (_loc1_.payType == "paiedMoney" || _loc1_.payType == "rechargedMoney"))
            {
               _loc3_ = _loc1_.exInfo;
               _loc4_ = "";
               _loc5_ = "";
               if(_loc3_.hasOwnProperty("sDate"))
               {
                  if(!(_loc3_["sDate"] is String) || StyleClass.checkspace(_loc3_["sDate"]).length == 0)
                  {
                     _loc4_ = "error";
                  }
                  else
                  {
                     _loc4_ = StyleClass.creatDateFun(_loc3_["sDate"]);
                     if(_loc4_ != "error")
                     {
                        _loc2_.start_date = _loc4_;
                     }
                  }
               }
               if(_loc3_.hasOwnProperty("eDate"))
               {
                  if(!(_loc3_["eDate"] is String) || StyleClass.checkspace(_loc3_["eDate"]).length == 0)
                  {
                     _loc5_ = "error";
                  }
                  else
                  {
                     _loc5_ = StyleClass.creatDateFun(_loc3_["eDate"]);
                     if(_loc5_ != "error")
                     {
                        _loc2_.end_date = _loc5_;
                     }
                  }
               }
               if(_loc4_ == "error" || _loc5_ == "error" || _loc4_ != "" && _loc5_ != "" && !StyleClass.checkDateTimeFun(_loc4_,_loc5_))
               {
                  _loc6_ = new Object();
                  _loc6_.info = "6|日期或者时间的格式出错了!!";
                  if(this.realStage != null)
                  {
                     this.realStage.dispatchEvent(new PayEvent(PayEvent.PAY_ERROR,_loc6_));
                  }
                  this.setMoneyAry.shift();
                  if(this.setMoneyAry.length)
                  {
                     this.getPayFun();
                  }
                  else
                  {
                     this.setMoneyAry = null;
                  }
                  return;
               }
            }
            _loc2_.version = "v2";
            switch(_loc1_.payType)
            {
               case "getMoney":
                  this.logGetMoney = new LogData(LogData.API_MALL,"getMoney");
                  LoaderManager.loadBytes(AllConst.URL_GET_MONEY,this.getMoneyComplete,_loc2_);
                  break;
               case "paiedMoney":
                  this.logGetTotalPaied = new LogData(LogData.API_MALL,"paiedMoney");
                  LoaderManager.loadBytes(AllConst.URL_GET_TOTAL_PAIED,this.getMoneyComplete,_loc2_);
                  break;
               case "rechargedMoney":
                  this.logGetTotalRecharged = new LogData(LogData.API_MALL,"rechargedMoney");
                  LoaderManager.loadBytes(AllConst.URL_GET_TOTAL_RECHARGED,this.getMoneyComplete,_loc2_);
                  break;
               case "dec":
                  this.logGetPayToken = new LogData(LogData.API_MALL,"token");
                  LoaderManager.loadBytes(AllConst.URL_GET_PAY_TOKEN,this.getPayTokenComplete);
                  break;
               case "decStatistic":
                  this.logGetPayToken = new LogData(LogData.API_MALL,"token");
                  LoaderManager.loadBytes(AllConst.URL_GET_PAY_TOKEN,this.getPayStatisticTokenComplete);
            }
         }
         else
         {
            this.setMoneyAry.shift();
            if(this.setMoneyAry.length)
            {
               this.getPayFun();
            }
            else
            {
               this.setMoneyAry = null;
            }
         }
      }
      
      private function getMoneyComplete(param1:Event) : void
      {
         var _loc7_:Array = null;
         var _loc8_:uint = 0;
         var _loc9_:Object = null;
         if(this.setMoneyAry == null)
         {
            return;
         }
         var _loc2_:Object = this.setMoneyAry[0];
         if(param1.type != Event.COMPLETE || _loc2_ == null)
         {
            this.payErrorFun(_loc2_);
            switch(_loc2_.payType)
            {
               case "getMoney":
                  this.logGetMoney.exception = param1.toString();
                  this.logGetMoney.submit();
                  var _loc3_:String = PayEvent.GET_MONEY;
                  break;
               case "paiedMoney":
                  this.logGetTotalPaied.exception = param1.toString();
                  this.logGetTotalPaied.submit();
                  _loc3_ = PayEvent.PAIED_MONEY;
                  break;
               case "rechargedMoney":
                  this.logGetTotalRecharged.exception = param1.toString();
                  this.logGetTotalRecharged.submit();
                  _loc3_ = PayEvent.RECHARGED_MONEY;
            }
            return;
         }
         trace(_loc2_.payType + "   e.target.data------->" + param1.target.data);
         _loc3_ = "";
         switch(_loc2_.payType)
         {
            case "getMoney":
               this.logGetMoney.submit(true);
               _loc3_ = PayEvent.GET_MONEY;
               break;
            case "paiedMoney":
               this.logGetTotalPaied.submit(true);
               _loc3_ = PayEvent.PAIED_MONEY;
               break;
            case "rechargedMoney":
               this.logGetTotalRecharged.submit(true);
               _loc3_ = PayEvent.RECHARGED_MONEY;
         }
         var _loc4_:String = String(param1.target.data);
         var _loc5_:Boolean = false;
         var _loc6_:Object = new Object();
         switch(_loc4_)
         {
            case "game_not_exist":
               _loc5_ = true;
               _loc6_.info = "3|游戏不存在或者没有支付接口!!";
               break;
            case "datetime_error":
               _loc5_ = true;
               _loc6_.info = "6|日期或者时间的格式出错了!!";
         }
         if(!_loc5_)
         {
            _loc4_ = StyleClass.ecbDecrypt(_loc4_);
            _loc7_ = _loc4_.split("####");
            if(_loc7_.length != 2 || _loc7_[0] != _loc2_.time)
            {
               _loc5_ = true;
               _loc6_.info = "8|非法操作，扣款失败!!";
            }
            else
            {
               _loc4_ = _loc7_[1];
            }
         }
         if(_loc5_)
         {
            if(this.realStage != null)
            {
               this.realStage.dispatchEvent(new PayEvent(PayEvent.PAY_ERROR,_loc6_));
            }
         }
         else
         {
            _loc8_ = uint(_loc4_);
            _loc9_ = new Object();
            _loc9_.balance = _loc8_;
            if(this.realStage != null)
            {
               this.realStage.dispatchEvent(new PayEvent(_loc3_,_loc9_));
            }
            trace(_loc2_.payType + "  操作，还有余额  " + _loc9_.balance);
         }
         this.setMoneyAry.shift();
         if(this.setMoneyAry.length)
         {
            this.getPayFun();
         }
         else
         {
            this.setMoneyAry = null;
         }
      }
      
      private function payErrorFun(param1:Object) : void
      {
         if(this.realStage != null && param1 != null && param1.payType != undefined)
         {
            switch(param1.payType)
            {
               case "dec":
               case "decStatistic":
                  this.realStage.dispatchEvent(new PayEvent(PayEvent.DEC_MONEY,false));
                  break;
               case "getMoney":
                  this.realStage.dispatchEvent(new PayEvent(PayEvent.GET_MONEY,false));
                  break;
               case "paiedMoney":
                  this.realStage.dispatchEvent(new PayEvent(PayEvent.PAIED_MONEY,false));
                  break;
               case "rechargedMoney":
                  this.realStage.dispatchEvent(new PayEvent(PayEvent.RECHARGED_MONEY,false));
            }
         }
         this.setMoneyAry.shift();
         if(this.setMoneyAry.length)
         {
            this.getPayFun();
         }
         else
         {
            this.setMoneyAry = null;
         }
      }
      
      private function getPayTokenComplete(param1:Event) : void
      {
         if(this.setMoneyAry == null)
         {
            return;
         }
         var _loc2_:Object = this.setMoneyAry[0];
         if(param1.type != Event.COMPLETE || _loc2_ == null)
         {
            this.logGetPayToken.exception = param1.toString();
            this.logGetPayToken.submit();
            this.payErrorFun(_loc2_);
            return;
         }
         this.logGetPayToken.submit(true);
         var _loc3_:String = String(param1.target.data);
         var _loc4_:URLVariables = new URLVariables();
         _loc4_.gameid = this.gameID;
         _loc4_.uid = this.userID;
         _loc4_.token = _loc3_;
         _loc4_.time = _loc2_.time;
         if(_loc2_.payType != undefined && _loc2_.moneyVal != undefined)
         {
            _loc4_.money = _loc2_.moneyVal;
            _loc4_.verify = this.getVerify(String(_loc2_.moneyVal),_loc3_);
            _loc4_.version = "v2";
            this.logDecMoney = new LogData(LogData.API_MALL,"dec");
            LoaderManager.loadBytes(AllConst.URL_DEC_MONEY,this.setMoneyComplete,_loc4_);
         }
         else
         {
            this.payErrorFun(_loc2_);
         }
      }
      
      private function getPayStatisticTokenComplete(param1:Event) : void
      {
         if(this.setMoneyAry == null)
         {
            return;
         }
         var _loc2_:Object = this.setMoneyAry[0];
         if(param1.type != Event.COMPLETE || _loc2_ == null)
         {
            this.logGetPayToken.exception = param1.toString();
            this.logGetPayToken.submit();
            this.payErrorFun(_loc2_);
            return;
         }
         this.logGetPayToken.submit(true);
         var _loc3_:String = String(param1.target.data);
         var _loc4_:URLVariables = new URLVariables();
         _loc4_.gameid = this.gameID;
         _loc4_.uid = this.userID;
         _loc4_.token = _loc3_;
         _loc4_.time = _loc2_.time;
         if(_loc2_.payType != undefined && _loc2_.moneyVal != undefined)
         {
            _loc4_.money = _loc2_.moneyVal;
            _loc4_.verify = this.getVerify(String(_loc2_.moneyVal),_loc3_);
            _loc4_.version = "v2";
            _loc4_.index = _loc2_.exInfo.saveIndex;
            _loc4_.prop_id = _loc2_.exInfo.propId;
            _loc4_.prop_title = _loc2_.exInfo.propName;
            _loc4_.prop_price = _loc2_.exInfo.propPrice;
            _loc4_.prop_count = _loc2_.exInfo.propCount;
            this.logDecMoney = new LogData(LogData.API_MALL,"decStatistic");
            LoaderManager.loadBytes(AllConst.URL_DEC_MONEY,this.setMoneyComplete,_loc4_);
         }
         else
         {
            this.payErrorFun(_loc2_);
         }
      }
      
      private function getVerify(param1:String, param2:String) : String
      {
         var _loc3_:String = MD5.hash("SDALPlsldlnSLWPElsdslSE" + this.userID + param1 + this.gameID + param2 + "PKslsO");
         _loc3_ = MD5.hash(_loc3_);
         return MD5.hash(_loc3_);
      }
      
      private function setMoneyComplete(param1:Event) : void
      {
         var _loc6_:Array = null;
         var _loc7_:uint = 0;
         var _loc8_:Object = null;
         if(this.setMoneyAry == null)
         {
            return;
         }
         var _loc2_:Object = this.setMoneyAry[0];
         if(param1.type != Event.COMPLETE || _loc2_ == null)
         {
            this.logDecMoney.exception = param1.toString();
            this.logDecMoney.submit();
            this.payErrorFun(_loc2_);
            return;
         }
         this.logDecMoney.submit(true);
         trace(_loc2_.payType + "   e.target.data------->" + param1.target.data);
         var _loc3_:String = String(param1.target.data);
         var _loc4_:Boolean = false;
         var _loc5_:Object = new Object();
         switch(_loc3_)
         {
            case "token_expires":
               _loc4_ = true;
               _loc5_.info = "0|请重试!若还不行,请重新登录!!";
               break;
            case "verify_error":
               _loc4_ = true;
               _loc5_.info = "1|程序有问题，请联系技术人员100584399!!";
               break;
            case "invalid_money":
               _loc4_ = true;
               _loc5_.info = "2|请检查,目前传进来的值等于0!!";
               break;
            case "game_not_exist":
               _loc4_ = true;
               _loc5_.info = "3|游戏不存在或者没有支付接口!!";
               break;
            case "not_enough_money":
               _loc4_ = true;
               _loc5_.info = "4|余额不足!!";
               break;
            case "system_error":
               _loc4_ = true;
               _loc5_.info = "7|系统错误，扣款失败!!";
         }
         if(!_loc4_)
         {
            _loc3_ = StyleClass.ecbDecrypt(_loc3_);
            _loc6_ = _loc3_.split("####");
            if(_loc6_.length != 2 || _loc6_[0] != _loc2_.time)
            {
               _loc4_ = true;
               _loc5_.info = "8|非法操作，扣款失败!!";
            }
            else
            {
               _loc3_ = _loc6_[1];
            }
         }
         if(_loc4_)
         {
            if(this.realStage != null)
            {
               this.realStage.dispatchEvent(new PayEvent(PayEvent.PAY_ERROR,_loc5_));
            }
         }
         else
         {
            _loc7_ = uint(_loc3_);
            _loc8_ = new Object();
            _loc8_.balance = _loc7_;
            if(this.realStage != null && _loc2_.payType != undefined)
            {
               this.realStage.dispatchEvent(new PayEvent(PayEvent.DEC_MONEY,_loc8_));
            }
            trace(_loc2_.payType + "  操作，还有余额  " + _loc8_.balance);
         }
         this.setMoneyAry.shift();
         if(this.setMoneyAry.length)
         {
            this.getPayFun();
         }
         else
         {
            this.setMoneyAry = null;
         }
      }
      
      public function getMoneyFun() : void
      {
         var _loc1_:Object = null;
         if(!this.isCanUsePayApi)
         {
            _loc1_ = new Object();
            _loc1_.info = "0|请重试!若还不行,请重新登录!!";
            if(this.realStage != null)
            {
               this.realStage.dispatchEvent(new PayEvent(PayEvent.PAY_ERROR,_loc1_));
            }
            return;
         }
         if(this.setMoneyAry == null)
         {
            this.setMoneyAry = [];
         }
         this.setMoneyAry.push({
            "payType":"getMoney",
            "moneyVal":0
         });
         if(this.setMoneyAry.length == 1)
         {
            this.getPayFun();
         }
      }
      
      public function payMoneyFun(param1:uint) : void
      {
         var url:String;
         var obj:Object = null;
         var broswer:String = null;
         var money:uint = param1;
         if(!this.isCanUsePayApi)
         {
            obj = new Object();
            obj.info = "0|请重试!若还不行,请重新登录!!";
            if(this.realStage != null)
            {
               this.realStage.dispatchEvent(new PayEvent(PayEvent.PAY_ERROR,obj));
            }
            return;
         }
         url = AllConst.URL_PAY_MONEY;
         url = url + "&gameid=" + this.gameID;
         url = url + "&money=" + money;
         url = url + "&userid=" + this.userID;
         url = url + "&username=" + this.userName;
         try
         {
            broswer = ExternalInterface.call("function getBrowser(){return navigator.userAgent}") as String;
            if(Boolean(broswer) && (broswer.indexOf("Firefox") != -1 || broswer.indexOf("MSIE") != -1))
            {
               ExternalInterface.call("window.open(\"" + url + "\",\"_blank\")");
            }
            else
            {
               navigateToURL(new URLRequest(url),"_blank");
            }
         }
         catch(e:Error)
         {
            if(realStage != null)
            {
               realStage.dispatchEvent(new PayEvent(PayEvent.PAY_MONEY,false));
            }
         }
      }
      
      public function get mouseVisible() : Boolean
      {
         return this._mouseVisible;
      }
      
      public function set mouseVisible(param1:Boolean) : void
      {
         this._mouseVisible = param1;
      }
      
      public function addNeedFunc(param1:String, param2:Object) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:Object = null;
         if(this._needList == null)
         {
            this._needList = [];
         }
         if(this._needList.length == 0)
         {
            this._needList.push({
               "funcType":param1,
               "funcParam":param2
            });
         }
         for(_loc3_ in this._needList)
         {
            _loc4_ = this._needList[_loc3_];
            if(!(_loc4_ == null || _loc4_.funcType == undefined))
            {
               if(param1 == _loc4_.funcType)
               {
                  this._needList[_loc3_] = {
                     "funcType":param1,
                     "funcParam":param2
                  };
                  break;
               }
               if(_loc3_ == this._needList.length - 1)
               {
                  this._needList.push({
                     "funcType":param1,
                     "funcParam":param2
                  });
               }
            }
         }
      }
      
      public function runNeedFunc() : void
      {
         var _loc1_:Object = null;
         var _loc2_:Object = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc9_:SecondaryProxy = null;
         if(this._needList == null)
         {
            return;
         }
         _loc3_ = int(this._needList.length);
         trace("_needList.length = " + _loc3_);
         var _loc5_:SaveProxy = Facade.getInstance().retrieveProxy(AllConst.PROXY_NAME_SAVE) as SaveProxy;
         var _loc6_:PackageProxy = Facade.getInstance().retrieveProxy(AllConst.PROXY_NAME_PACKAGE) as PackageProxy;
         var _loc7_:FreePackageProxy = Facade.getInstance().retrieveProxy(AllConst.PROXY_NAME_FREEPACKAGE) as FreePackageProxy;
         var _loc8_:ShopProxy = Facade.getInstance().retrieveProxy(AllConst.PROXY_NAME_SHOP) as ShopProxy;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc1_ = this._needList[_loc4_];
            if(_loc1_ != null)
            {
               _loc2_ = _loc1_.funcParam;
               trace("obj.funcType =     " + _loc1_.funcType);
               if(_loc1_.funcType == "getPayPacInfoFun")
               {
                  _loc8_.getPayPacInfoFun(_loc2_);
               }
               else if(_loc1_.funcType == "getShopProItemsFun")
               {
                  _loc6_.getShopProItemsFun(_loc2_);
               }
               else if(_loc1_.funcType == "getFreePackageInfo")
               {
                  _loc7_.getFreePackageInfo(_loc2_);
               }
               else if(_loc1_.funcType == "getPackageInfo")
               {
                  _loc6_.getPackageInfo(_loc2_);
               }
               else if(_loc1_.funcType == "saveData")
               {
                  _loc5_.setStore(String(_loc2_.index),_loc2_.title,_loc2_.data);
               }
               else if(_loc1_.funcType == "getData")
               {
                  trace("doGetData-----------Mainproxy--------------------");
                  if(this.getStoreAry == null)
                  {
                     this.getStoreAry = [];
                  }
                  this.getStoreAry.push(_loc2_.index.toString());
                  if(this.getStoreAry.length == 1)
                  {
                     _loc5_.getStore(_loc2_.index.toString());
                  }
               }
               else if(_loc1_.funcType == "getList")
               {
                  _loc5_.getList();
               }
               else if(_loc1_.funcType == "openIntegralWin")
               {
                  if(this.isLog)
                  {
                     sendNotification(AllConst.UP_DATA_SCORE,[_loc2_]);
                  }
                  else
                  {
                     sendNotification(AllConst.MVC_SHOW_SCORE,[_loc2_]);
                  }
               }
               else if(_loc1_.funcType == "openSaveList")
               {
                  Facade.getInstance().sendNotification(AllConst.OPEN_SAVE_LIST_UI,_loc2_);
               }
               else if(_loc1_.funcType == "showSecondaryLogPanel")
               {
                  _loc9_ = Facade.getInstance().retrieveProxy(AllConst.PROXY_NAME_SECONDARY) as SecondaryProxy;
                  _loc9_.LoginOfCheckCode();
               }
            }
            _loc4_++;
         }
         this._needList = null;
         trace("_needList = " + this._needList);
      }
      
      public function getServerTime() : void
      {
         var _loc1_:URLVariables = new URLVariables();
         _loc1_.gameid = this.gameID;
         _loc1_.uid = this.userID;
         var _loc2_:String = AllConst.URL_GET_SERVERTIME + "&ran=" + String(Math.random() * 1000000);
         this.logServerTime = new LogData(LogData.API_OTHER,"getServerTime");
         LoaderManager.loadBytes(_loc2_,this.getServerTimeComplete,_loc1_);
      }
      
      private function getServerTimeComplete(param1:Event) : void
      {
         var tmpStr:String;
         var timeObj:Object = null;
         var evt:Event = param1;
         if(this.realStage == null)
         {
            return;
         }
         if(evt.type != Event.COMPLETE)
         {
            this.logServerTime.exception = evt.toString();
            this.logServerTime.submit();
            this.realStage.dispatchEvent(new DataEvent("serverTimeEvent"));
            return;
         }
         this.logServerTime.submit(true);
         tmpStr = String(evt.target.data);
         try
         {
            timeObj = com.adobe.serialization.json.JSON.decode(tmpStr);
         }
         catch(e:*)
         {
            timeObj = null;
         }
         if(timeObj == null)
         {
            this.realStage.dispatchEvent(new DataEvent("serverTimeEvent"));
         }
         else
         {
            this.realStage.dispatchEvent(new DataEvent("serverTimeEvent",false,false,String(timeObj.time)));
         }
      }
      
      public function getopenSaveListFunc() : void
      {
         var _loc1_:Object = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Object = null;
         var _loc6_:Boolean = false;
         if(this._needList == null)
         {
            return;
         }
         _loc6_ = false;
         _loc2_ = int(this._needList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = this._needList[_loc3_];
            if(_loc1_.funcType == "openSaveList")
            {
               this._needList.splice(_loc3_,1);
               _loc6_ = true;
               _loc5_ = _loc1_.funcParam;
               break;
            }
            _loc3_++;
         }
         if(_loc6_)
         {
            sendNotification(AllConst.OPEN_SAVE_LOCAL_UI,_loc5_);
         }
      }
   }
}

