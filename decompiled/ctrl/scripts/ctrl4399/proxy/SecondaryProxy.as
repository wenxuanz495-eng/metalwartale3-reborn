package ctrl4399.proxy
{
   import calista.utils.Base64;
   import com.adobe.serialization.json.JSON;
   import ctrl4399.XMLToObject;
   import ctrl4399.strconst.AllConst;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import frame4399.simplePureMvc.core.Facade;
   import frame4399.simplePureMvc.interfaces.IProxy;
   import frame4399.simplePureMvc.proxy.Proxy;
   import unit4399.events.SecondaryEvent;
   import unit4399.road.loader.LoaderManager;
   
   public class SecondaryProxy extends Proxy implements IProxy
   {
      
      public static const SAVE_SET:String = "SAVE_SET";
      
      public static const SAVE_GET:String = "SAVE_GET";
      
      public static const SAVE_GET_LIST:String = "SAVE_GET_LIST";
      
      public static const LOG_OUT:String = "LOG_OUT";
      
      private var _mainProxy:MainProxy;
      
      private var _isShowCheckCode:Boolean;
      
      private var _isLog:Boolean = false;
      
      private var _isLoging:Boolean = false;
      
      public var _isCheckCode:Boolean = false;
      
      private var stage:Stage;
      
      private var _needLogFunList:Dictionary;
      
      private var _userID:String = "";
      
      private var _userName:String = "";
      
      private var _userNickName:String = "";
      
      private var _token:String = "";
      
      private var _captcha_key:String = "";
      
      private var _xmlToObj:XMLToObject;
      
      private var logCheckCode:LogData;
      
      private var checkCodeCount:int = 0;
      
      private var logLogin:LogData;
      
      private var logSaveSet:LogData;
      
      private var logSaveGet:LogData;
      
      private var logList:LogData;
      
      public function SecondaryProxy(param1:String, param2:Stage)
      {
         super(param1);
         this.stage = param2;
      }
      
      private function get mainProxy() : MainProxy
      {
         if(!this._mainProxy)
         {
            this._mainProxy = Facade.getInstance().retrieveProxy(AllConst.PROXY_NAME_MAIN) as MainProxy;
         }
         return this._mainProxy;
      }
      
      public function get isShowCheckCode() : Boolean
      {
         return this._isShowCheckCode;
      }
      
      public function get isLog() : Boolean
      {
         return this._isLog;
      }
      
      public function get isLoging() : Boolean
      {
         return this._isLoging;
      }
      
      public function get logInfo() : Object
      {
         return {
            "uid":this._userID,
            "name":this._userName,
            "nickName":this._userNickName
         };
      }
      
      public function get captcha_key() : String
      {
         return this._captcha_key;
      }
      
      public function LoginOfCheckCode() : void
      {
         if(this._isCheckCode)
         {
            this._isCheckCode = true;
         }
         var _loc1_:URLVariables = new URLVariables();
         _loc1_.gameid = this.mainProxy.gameID;
         this.logCheckCode = new LogData(LogData.API_SECONDARY,"checkCode");
         LoaderManager.loadBytes(AllConst.URL_SECONDARY_HAVE_CHECK_CODE,this.loginOfCheckCodeComplete,_loc1_);
      }
      
      private function loginOfCheckCodeComplete(param1:Event) : void
      {
         this._isCheckCode = false;
         if(param1.type != Event.COMPLETE)
         {
            this.logCheckCode.exception = param1.toString();
            this.logCheckCode.submit();
            ++this.checkCodeCount;
            if(this.checkCodeCount < 3)
            {
               this.LoginOfCheckCode();
            }
            return;
         }
         this.checkCodeCount = 0;
         this.logCheckCode.submit(true);
         var _loc2_:Object = this.phpDataHandle(param1.target.data);
         if(_loc2_)
         {
            this._isShowCheckCode = Boolean(_loc2_.success);
            if(_loc2_.captcha_key)
            {
               this._captcha_key = _loc2_.captcha_key;
            }
            if(_loc2_.privilege)
            {
               sendNotification(AllConst.MVC_SHOW_SECONDARY_LOGBOX);
            }
            else
            {
               this.loginSuccess({"code":60001});
            }
         }
         else
         {
            this.LoginOfCheckCode();
         }
      }
      
      public function Login(param1:String, param2:String, param3:String = null) : void
      {
         if(!this.mainProxy.isLog)
         {
            return;
         }
         if(this._isLog || this._isLoging)
         {
            return;
         }
         this._isLoging = true;
         var _loc4_:URLVariables = new URLVariables();
         _loc4_.gameid = this.mainProxy.gameID;
         _loc4_.username = param1;
         _loc4_.password = param2;
         if(Boolean(param3) && param3 != "")
         {
            _loc4_.captcha = param3;
            _loc4_.captcha_key = this._captcha_key;
         }
         this.logLogin = new LogData(LogData.API_SECONDARY,"login");
         LoaderManager.loadBytes(AllConst.URL_SECONDARY_CHECK_LOGIN,this.loginComplete,_loc4_);
      }
      
      private function loginComplete(param1:Event) : void
      {
         this._isLoging = false;
         if(param1.type != Event.COMPLETE)
         {
            this.logLogin.exception = param1.toString();
            this.logLogin.submit();
            sendNotification(AllConst.MVC_SECONDARY_COM_ERROR);
            this.LoginOfCheckCode();
            return;
         }
         this.logLogin.submit(true);
         if(this._isLog)
         {
            return;
         }
         var _loc2_:Object = this.phpDataHandle(param1.target.data);
         if(_loc2_)
         {
            if(_loc2_.success)
            {
               this._isLog = true;
               this._userID = _loc2_.user.user_id;
               this._userName = _loc2_.user.user_name;
               this._userNickName = _loc2_.user.nick;
               this._token = _loc2_.token;
               sendNotification(AllConst.MVC_HIDE_SECONDARY_LOGBOX);
               sendNotification(AllConst.MVC_LOG_TIP);
               this.loginSuccess({
                  "code":_loc2_.code,
                  "uid":this._userID,
                  "name":this._userName,
                  "nickName":this._userNickName
               });
               this.doNeedLogFun();
            }
            else
            {
               switch(_loc2_.code)
               {
                  case "20001":
                     trace("其他错误，可能是通讯问题");
                     sendNotification(AllConst.MVC_SECONDARY_COM_ERROR);
                     break;
                  case "20002":
                     trace("用户名或密码错误");
                     sendNotification(AllConst.MVC_SECONDARY_LOG_ERROR);
                     break;
                  case "20003":
                     trace("ip被锁定");
                     sendNotification(AllConst.MVC_SECONDARY_IP_ERROR);
                     break;
                  case "20004":
                     trace("参数错误");
                     sendNotification(AllConst.MVC_SECONDARY_COM_ERROR);
                     break;
                  case "20005":
                     trace("验证码错误，可能验证码为空或者不对");
                     sendNotification(AllConst.MVC_SECONDARY_CHECK_CODE_ERROR);
                     break;
                  case "20007":
                     trace("用户被出售中");
                     sendNotification(AllConst.MVC_SECONDARY_USERLOCKED_ERROR);
                     break;
                  case "60001":
                     trace("此游戏无次账号权限");
               }
               this.LoginOfCheckCode();
               this.loginSuccess({"code":_loc2_.code});
            }
         }
         else
         {
            trace("登录返回数据出错！" + String(param1.target.data));
            sendNotification(AllConst.MVC_SECONDARY_COM_ERROR);
            this.LoginOfCheckCode();
         }
      }
      
      private function phpDataHandle(param1:String) : Object
      {
         var _loc2_:Object = null;
         var _loc3_:Object = com.adobe.serialization.json.JSON.decode(param1);
         var _loc4_:String = String(_loc3_.code);
         var _loc5_:String = String(_loc3_.message);
         if(_loc4_ == null || _loc4_ == "" || _loc5_ == null || _loc5_ == "")
         {
            return _loc2_;
         }
         _loc2_ = new Object();
         _loc2_.code = _loc4_;
         switch(_loc4_)
         {
            case "60000":
               _loc2_.success = false;
               _loc2_.privilege = true;
               break;
            case "60001":
               _loc2_.success = false;
               _loc2_.privilege = false;
               break;
            case "60002":
               _loc2_.success = true;
               _loc2_.privilege = true;
               _loc2_.captcha_key = _loc3_.data.captcha_key;
               break;
            case "20000":
               _loc2_.success = true;
               _loc2_.token = _loc3_.data.token;
               _loc2_.user = _loc3_.data.user;
               break;
            case "20001":
            case "20002":
            case "20003":
            case "20004":
            case "20005":
            case "20007":
               break;
            case "50000":
               _loc2_.success = true;
               break;
            case "50001":
            case "10004":
            case "10005":
            case "10006":
            case "20006":
               _loc2_.success = false;
               break;
            case "40000":
               _loc2_.success = true;
               _loc2_.data = _loc3_.data;
               break;
            case "40001":
            case "40002":
            case "40003":
               _loc2_.success = false;
               break;
            case "30000":
               _loc2_.success = true;
               _loc2_.data = _loc3_.data;
               break;
            case "30001":
               _loc2_.success = false;
         }
         return _loc2_;
      }
      
      private function loginSuccess(param1:Object) : void
      {
         this.dispatchEvent(SecondaryEvent.LOGIN,param1);
      }
      
      private function dispatchEvent(param1:String, param2:Object = null) : void
      {
         this.stage.dispatchEvent(new SecondaryEvent(param1,param2));
      }
      
      public function addNeedLogFun(param1:String, param2:Object = null) : void
      {
         if(this._isLog)
         {
            this.dologFunHandle(param1,param2);
         }
         else
         {
            this.addNeedLogFunList(param1,param2);
         }
      }
      
      private function addNeedLogFunList(param1:String, param2:Object) : void
      {
         var _loc4_:String = null;
         if(!this._needLogFunList)
         {
            this._needLogFunList = new Dictionary(true);
         }
         var _loc3_:Boolean = false;
         for(_loc4_ in this._needLogFunList)
         {
            if(_loc4_ == param1)
            {
               this._needLogFunList[_loc4_] = param2;
               _loc3_ = true;
               break;
            }
         }
         if(!_loc3_)
         {
            this._needLogFunList[param1] = param2;
         }
         if(!this.mainProxy.isLog)
         {
            this.mainProxy.addNeedFunc("showSecondaryLogPanel",null);
            this.mainProxy.getLogUser();
         }
         else
         {
            this.LoginOfCheckCode();
         }
      }
      
      private function doNeedLogFun() : void
      {
         var _loc1_:Object = null;
         var _loc2_:String = null;
         if(!this._needLogFunList)
         {
            return;
         }
         for(_loc2_ in this._needLogFunList)
         {
            _loc1_ = this._needLogFunList[_loc2_];
            this.dologFunHandle(_loc2_,_loc1_);
            delete this._needLogFunList[_loc2_];
         }
         this._needLogFunList = null;
      }
      
      private function dologFunHandle(param1:String, param2:Object) : void
      {
         switch(param1)
         {
            case SAVE_SET:
               this.saveSet(param2);
               break;
            case SAVE_GET:
               this.saveGet(param2 as int);
               break;
            case SAVE_GET_LIST:
               this.saveGetList();
               break;
            case LOG_OUT:
               this.logOut();
         }
      }
      
      private function saveSet(param1:Object) : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.index = int(param1.index);
         _loc2_.title = param1.title;
         trace("保存数据   index:" + param1.index + "   title:" + param1.title + "   data:" + param1.data);
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeObject(param1.data);
         _loc3_.compress();
         var _loc4_:String = Base64.encodeByteArray(_loc3_);
         _loc3_ = null;
         _loc2_.data = _loc4_;
         _loc2_.token = this._token;
         this.logSaveSet = new LogData(LogData.API_SECONDARY,"saveSet");
         LoaderManager.loadBytes(AllConst.URL_SECONDARY_SAVE_SET,this.returnSet,_loc2_);
      }
      
      private function returnSet(param1:Event) : void
      {
         if(param1 == null || param1.type != Event.COMPLETE)
         {
            if(param1 != null)
            {
               this.logSaveSet.exception = param1.toString();
               this.logSaveSet.submit();
            }
            this.saveSetSuccess({"code":50001});
            return;
         }
         this.logSaveSet.submit(true);
         var _loc2_:Object = this.phpDataHandle(param1.target.data);
         if(_loc2_)
         {
            this.saveSetSuccess({"code":_loc2_.code});
         }
         else
         {
            trace("存档返回数据出错！" + String(param1.target.data));
            this.saveSetSuccess({"code":50001});
         }
      }
      
      private function saveSetSuccess(param1:Object) : void
      {
         this.dispatchEvent(SecondaryEvent.SAVE_SET,param1);
      }
      
      private function saveGet(param1:int) : void
      {
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.index = param1;
         _loc2_.token = this._token;
         this.logSaveGet = new LogData(LogData.API_SECONDARY,"saveGet");
         LoaderManager.loadBytes(AllConst.URL_SECONDARY_SAVE_GET,this.returnGet,_loc2_);
      }
      
      private function returnGet(param1:Event) : void
      {
         var obj:Object;
         var data:Object = null;
         var tempData:Object = null;
         var arr:Array = null;
         var tmpObj:Object = null;
         var byte:ByteArray = null;
         var str1:String = null;
         var xml:XML = null;
         var bol:Boolean = false;
         var object:Object = null;
         var tmpAry:Array = null;
         var e:Event = param1;
         if(e == null || e.type != Event.COMPLETE)
         {
            if(e != null)
            {
               this.logSaveGet.exception = e.toString();
               this.logSaveGet.submit();
            }
            this.saveGetSuccess({"code":40001});
            return;
         }
         this.logSaveGet.submit(true);
         obj = this.phpDataHandle(e.target.data);
         if(obj)
         {
            if(obj.success)
            {
               tempData = obj.data;
               try
               {
                  tmpObj = this.copyObj(tempData);
                  try
                  {
                     byte = Base64.decodeToByteArray(tempData.data);
                     byte.uncompress();
                     tempData.data = byte.readObject() as String;
                     byte = null;
                  }
                  catch(e:Error)
                  {
                     tempData = tmpObj;
                  }
               }
               catch(e:Error)
               {
                  tempData = null;
               }
               if(this._xmlToObj == null)
               {
                  this._xmlToObj = new XMLToObject();
               }
               arr = this._xmlToObj.strToObj(tempData.data as String);
               trace("type = " + arr[0]);
               trace("data = " + arr[1]);
               if(arr[0] == "String")
               {
                  str1 = arr[1];
                  tempData.data = str1;
               }
               else if(arr[0] == "XML")
               {
                  xml = arr[1];
                  tempData.data = xml;
               }
               else if(arr[0] == "Boolean")
               {
                  bol = Boolean(arr[1]);
                  tempData.data = bol;
               }
               else if(arr[0] == "Object")
               {
                  object = arr[1];
                  tempData.data = object;
               }
               else if(arr[0] == "Array")
               {
                  tmpAry = arr[1];
                  tempData.data = tmpAry;
               }
               obj.data = tempData;
               this.saveGetSuccess({
                  "code":obj.code,
                  "data":tempData
               });
            }
            else
            {
               this.saveGetSuccess({"code":obj.code});
            }
         }
         else
         {
            trace("读档返回数据出错！" + String(e.target.data));
            this.saveGetSuccess({"code":40001});
         }
      }
      
      private function saveGetSuccess(param1:Object) : void
      {
         this.dispatchEvent(SecondaryEvent.SAVE_GET,param1);
      }
      
      private function saveGetList() : void
      {
         var _loc1_:URLVariables = new URLVariables();
         _loc1_.token = this._token;
         this.logList = new LogData(LogData.API_SECONDARY,"list");
         LoaderManager.loadBytes(AllConst.URL_SECONDARY_SAVE_GET_LIST,this.returnList,_loc1_);
      }
      
      private function returnList(param1:Event) : void
      {
         var _loc2_:Array = null;
         var _loc4_:Array = null;
         if(param1 == null || param1.type != Event.COMPLETE)
         {
            if(param1 != null)
            {
               this.logList.exception = param1.toString();
               this.logList.submit();
            }
            this.saveGetListSuccess({"code":30001});
            return;
         }
         this.logList.submit(true);
         var _loc3_:Object = this.phpDataHandle(param1.target.data);
         if(_loc3_)
         {
            if(_loc3_.success)
            {
               _loc4_ = _loc3_.data as Array;
               this.saveGetListSuccess({
                  "code":_loc3_.code,
                  "data":_loc4_
               });
            }
            else
            {
               this.saveGetListSuccess({"code":_loc3_.code});
            }
         }
         else
         {
            trace("读列表返回数据出错！" + String(param1.target.data));
            this.saveGetListSuccess({"code":30001});
         }
      }
      
      private function saveGetListSuccess(param1:Object) : void
      {
         this.dispatchEvent(SecondaryEvent.SAVE_LIST,param1);
      }
      
      private function logOut() : void
      {
         this._isLog = false;
         this._userID = "";
         this._userName = "";
         this._userNickName = "";
         this._token = "";
         this.logOutSuccess(true);
      }
      
      private function logOutSuccess(param1:Object) : void
      {
         this.dispatchEvent(SecondaryEvent.LOG_OUT,param1);
      }
      
      private function copyObj(param1:Object) : Object
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return _loc2_.readObject() as Object;
      }
   }
}

