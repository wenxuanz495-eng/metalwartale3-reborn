package ctrl4399.proxy
{
   import calista.utils.Base64;
   import com.adobe.crypto.MD5;
   import com.adobe.serialization.json.JSON;
   import ctrl4399.XMLToObject;
   import ctrl4399.proxy.rankListApi.*;
   import ctrl4399.strconst.AllConst;
   import ctrl4399.view.components.styleConst.StyleClass;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import frame4399.simplePureMvc.core.Facade;
   import frame4399.simplePureMvc.interfaces.IProxy;
   import frame4399.simplePureMvc.proxy.Proxy;
   import unit4399.events.RankListEvent;
   import unit4399.road.loader.LoaderManager;
   
   public class RankListProxy extends Proxy implements IProxy
   {
      
      private var mainProxy:MainProxy;
      
      private var _facade:Facade = Facade.getInstance();
      
      public var _realStage:Stage;
      
      private var client:FlashScoreApiImpl;
      
      private var rankListUrl:String = "https://save.api.4399.com/rank/FlashScoreApi";
      
      private var logGetOneRank:LogData;
      
      private var logRankListByOwn:LogData;
      
      private var logSubmitScore:LogData;
      
      private var logGetRankLists:LogData;
      
      private var logToken:LogData;
      
      private var logGetUserData:LogData;
      
      private var curIdx:int = -1;
      
      private var curUid:String = "";
      
      public function RankListProxy(param1:String = null)
      {
         super(param1);
         this.mainProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_MAIN) as MainProxy;
         this.client = new FlashScoreApiImpl(ThriftClient.createClient(this.rankListUrl));
      }
      
      private function createApiHeader() : ApiHeader
      {
         if(this.mainProxy == null)
         {
            return null;
         }
         var _loc1_:ApiHeader = new ApiHeader();
         _loc1_.uId = this.mainProxy.userID;
         _loc1_.gameId = this.mainProxy.gameID;
         return _loc1_;
      }
      
      public function getOneRankInfo(param1:uint, param2:String) : void
      {
         if(this.client == null)
         {
            if(this._realStage)
            {
               this._realStage.dispatchEvent(new RankListEvent(RankListEvent.RANKLIST_ERROR,this.setErrorInfo(AllConst.RL_API_GRKI,AllConst.RL_ERROR_CLIENT_CODE,AllConst.RL_ERROR_CLIENT_MSG)));
            }
            return;
         }
         param2 = StyleClass.checkspace(param2);
         if(param2.length == 0)
         {
            if(this._realStage)
            {
               this._realStage.dispatchEvent(new RankListEvent(RankListEvent.RANKLIST_ERROR,this.setErrorInfo(AllConst.RL_API_GRKI,AllConst.RL_ERROR_ARG_CODE,AllConst.RL_ERROR_ARG_MSG)));
            }
            return;
         }
         this.logGetOneRank = new LogData(LogData.API_RANK_LIST,"getRank");
         this.client.getRank(this.createApiHeader(),param1,param2,this.onGRKIError,this.onGRKISuccess);
      }
      
      private function onGRKIError(param1:Error) : void
      {
         this.logGetOneRank.exception = param1.toString();
         this.logGetOneRank.submit();
         this.onErrorFun(AllConst.RL_API_GRKI,param1);
      }
      
      private function onGRKISuccess(param1:FSR_GetRank) : void
      {
         this.logGetOneRank.submit(true);
         var _loc2_:String = String(param1.code);
         if(_loc2_ != "10000")
         {
            if(this._realStage)
            {
               this._realStage.dispatchEvent(new RankListEvent(RankListEvent.RANKLIST_ERROR,this.setErrorInfo(AllConst.RL_API_GRKI,_loc2_,param1.message)));
            }
            return;
         }
         var _loc3_:Array = param1.data;
         _loc3_ = this.getRankListInfo(_loc3_);
         if(this._realStage)
         {
            this._realStage.dispatchEvent(new RankListEvent(RankListEvent.RANKLIST_SUCCESS,this.setSuccessInfo(AllConst.RL_API_GRKI,_loc3_)));
         }
      }
      
      public function getRankListByOwn(param1:uint, param2:uint, param3:uint) : void
      {
         if(this.client == null)
         {
            if(this._realStage)
            {
               this._realStage.dispatchEvent(new RankListEvent(RankListEvent.RANKLIST_ERROR,this.setErrorInfo(AllConst.RL_API_GRKByOwn,AllConst.RL_ERROR_CLIENT_CODE,AllConst.RL_ERROR_CLIENT_MSG)));
            }
            return;
         }
         if(param3 < 1 || param2 > 7)
         {
            if(this._realStage)
            {
               this._realStage.dispatchEvent(new RankListEvent(RankListEvent.RANKLIST_ERROR,this.setErrorInfo(AllConst.RL_API_GRKByOwn,AllConst.RL_ERROR_ARG_CODE,AllConst.RL_ERROR_ARG_MSG)));
            }
            return;
         }
         this.logRankListByOwn = new LogData(LogData.API_RANK_LIST,"getRankingByArounds");
         this.client.getRankingByArounds(this.createApiHeader(),param2,param1,param3,this.onGRKByOwnError,this.onGRKByOwnSuccess);
      }
      
      private function onGRKByOwnError(param1:Error) : void
      {
         this.logRankListByOwn.exception = param1.toString();
         this.logRankListByOwn.submit();
         this.onErrorFun(AllConst.RL_API_GRKByOwn,param1);
      }
      
      private function onGRKByOwnSuccess(param1:FSR_GetRanking) : void
      {
         this.logRankListByOwn.submit(true);
         var _loc2_:String = String(param1.code);
         if(_loc2_ != "10000")
         {
            if(this._realStage)
            {
               this._realStage.dispatchEvent(new RankListEvent(RankListEvent.RANKLIST_ERROR,this.setErrorInfo(AllConst.RL_API_GRKByOwn,_loc2_,param1.message)));
            }
            return;
         }
         var _loc3_:Array = param1.data;
         _loc3_ = this.getRankListInfo(_loc3_);
         if(this._realStage)
         {
            this._realStage.dispatchEvent(new RankListEvent(RankListEvent.RANKLIST_SUCCESS,this.setSuccessInfo(AllConst.RL_API_GRKByOwn,_loc3_)));
         }
      }
      
      public function submitScoreToRankLists(param1:uint, param2:Array) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:Object = null;
         var _loc5_:FSQE_Submit = null;
         var _loc6_:ByteArray = null;
         var _loc7_:String = null;
         var _loc8_:ByteArray = null;
         var _loc9_:int = 0;
         if(this.client == null)
         {
            if(this._realStage)
            {
               this._realStage.dispatchEvent(new RankListEvent(RankListEvent.RANKLIST_ERROR,this.setErrorInfo(AllConst.RL_API_SSTRK,AllConst.RL_ERROR_CLIENT_CODE,AllConst.RL_ERROR_CLIENT_MSG)));
            }
            return;
         }
         if(param1 > 7 || param2 == null || param2.length < 1 || param2.length > 5)
         {
            if(this._realStage)
            {
               this._realStage.dispatchEvent(new RankListEvent(RankListEvent.RANKLIST_ERROR,this.setErrorInfo(AllConst.RL_API_SSTRK,AllConst.RL_ERROR_ARG_CODE,AllConst.RL_ERROR_ARG_MSG)));
            }
            return;
         }
         for(_loc3_ in param2)
         {
            _loc4_ = param2[_loc3_] as Object;
            if(!_loc4_.hasOwnProperty("rId") || !(_loc4_["rId"] is int) || !_loc4_.hasOwnProperty("score") || !(_loc4_["score"] is int))
            {
               if(this._realStage)
               {
                  this._realStage.dispatchEvent(new RankListEvent(RankListEvent.RANKLIST_ERROR,this.setErrorInfo(AllConst.RL_API_SSTRK,AllConst.RL_ERROR_ARG_CODE,AllConst.RL_ERROR_ARG_MSG)));
               }
               return;
            }
            _loc5_ = new FSQE_Submit();
            _loc5_.rId = int(_loc4_["rId"]);
            _loc5_.score = int(_loc4_["score"]);
            if(_loc4_.hasOwnProperty("extra") && _loc4_["extra"] != null)
            {
               _loc6_ = new ByteArray();
               _loc6_.writeObject(_loc4_["extra"]);
               _loc6_.compress();
               _loc7_ = Base64.encodeByteArray(_loc6_);
               _loc6_ = null;
               _loc8_ = new ByteArray();
               _loc8_.writeObject(_loc7_);
               _loc9_ = int(_loc8_.length);
               _loc8_ = null;
               if(_loc9_ > 512)
               {
                  if(this._realStage)
                  {
                     this._realStage.dispatchEvent(new RankListEvent(RankListEvent.RANKLIST_ERROR,this.setErrorInfo(AllConst.RL_API_SSTRK,AllConst.RL_ERROR_ARG_CODE,AllConst.RL_ERROR_ARG_MSG)));
                  }
                  return;
               }
               _loc5_.extra = _loc7_;
            }
            param2[_loc3_] = _loc5_;
         }
         this.logSubmitScore = new LogData(LogData.API_RANK_LIST,"submit");
         this.client.submit(this.createApiHeader(),param1,param2,this.onSSTRKError,this.onSSTRKSuccess);
      }
      
      private function onSSTRKError(param1:Error) : void
      {
         this.logSubmitScore.exception = param1.toString();
         this.logSubmitScore.submit();
         this.onErrorFun(AllConst.RL_API_SSTRK,param1);
      }
      
      private function onSSTRKSuccess(param1:Dictionary) : void
      {
         var _loc4_:* = undefined;
         var _loc5_:FSR_Submit = null;
         var _loc6_:String = null;
         var _loc7_:Object = null;
         var _loc8_:FSRE_Submit = null;
         this.logSubmitScore.submit(true);
         if(param1 == null)
         {
            if(this._realStage)
            {
               this._realStage.dispatchEvent(new RankListEvent(RankListEvent.RANKLIST_ERROR,this.setErrorInfo(AllConst.RL_API_SSTRK,AllConst.RL_ERROR_BACKDATA_CODE,AllConst.RL_ERROR_BACKDATA_MSG)));
            }
            return;
         }
         var _loc2_:Dictionary = param1;
         var _loc3_:Array = new Array();
         for(_loc4_ in _loc2_)
         {
            _loc5_ = _loc2_[_loc4_] as FSR_Submit;
            _loc6_ = String(_loc5_.code);
            _loc7_ = new Object();
            _loc7_.rId = int(_loc4_);
            _loc7_.code = _loc6_;
            if(_loc6_ == "10000")
            {
               _loc8_ = _loc5_.data as FSRE_Submit;
               _loc7_.curRank = _loc8_.rank;
               _loc7_.curScore = _loc8_.score;
               _loc7_.lastRank = _loc8_.rankLast;
               _loc7_.lastScore = _loc8_.scoreLast;
            }
            else
            {
               _loc7_.message = _loc5_.message;
            }
            _loc3_.push(_loc7_);
         }
         if(this._realStage)
         {
            this._realStage.dispatchEvent(new RankListEvent(RankListEvent.RANKLIST_SUCCESS,this.setSuccessInfo(AllConst.RL_API_SSTRK,_loc3_)));
         }
      }
      
      public function getRankListsData(param1:uint, param2:uint, param3:uint) : void
      {
         if(this.client == null)
         {
            if(this._realStage)
            {
               this._realStage.dispatchEvent(new RankListEvent(RankListEvent.RANKLIST_ERROR,this.setErrorInfo(AllConst.RL_API_GRKD,AllConst.RL_ERROR_CLIENT_CODE,AllConst.RL_ERROR_CLIENT_MSG)));
            }
            return;
         }
         if(param2 < 1 || param3 < 1)
         {
            if(this._realStage)
            {
               this._realStage.dispatchEvent(new RankListEvent(RankListEvent.RANKLIST_ERROR,this.setErrorInfo(AllConst.RL_API_GRKD,AllConst.RL_ERROR_ARG_CODE,AllConst.RL_ERROR_ARG_MSG)));
            }
            return;
         }
         this.logGetRankLists = new LogData(LogData.API_RANK_LIST,"getRankingByPage");
         this.client.getRankingByPage(this.createApiHeader(),param1,param2,param3,this.onGRKDError,this.onGRKDSuccess);
      }
      
      private function onGRKDError(param1:Error) : void
      {
         this.logGetRankLists.exception = param1.toString();
         this.logGetRankLists.submit();
         this.onErrorFun(AllConst.RL_API_GRKD,param1);
      }
      
      private function onGRKDSuccess(param1:FSR_GetRanking) : void
      {
         this.logGetRankLists.submit(true);
         var _loc2_:String = String(param1.code);
         if(_loc2_ != "10000")
         {
            if(this._realStage)
            {
               this._realStage.dispatchEvent(new RankListEvent(RankListEvent.RANKLIST_ERROR,this.setErrorInfo(AllConst.RL_API_GRKD,_loc2_,param1.message)));
            }
            return;
         }
         var _loc3_:Array = param1.data;
         _loc3_ = this.getRankListInfo(_loc3_);
         if(this._realStage)
         {
            this._realStage.dispatchEvent(new RankListEvent(RankListEvent.RANKLIST_SUCCESS,this.setSuccessInfo(AllConst.RL_API_GRKD,_loc3_)));
         }
      }
      
      public function getUserData(param1:String, param2:uint) : void
      {
         var uid:String = param1;
         var idx:uint = param2;
         uid = StyleClass.checkspace(uid);
         if(idx > 7 || uid.length == 0)
         {
            if(this._realStage)
            {
               this._realStage.dispatchEvent(new RankListEvent(RankListEvent.RANKLIST_ERROR,this.setErrorInfo(AllConst.RL_API_GUD,AllConst.RL_ERROR_ARG_CODE,AllConst.RL_ERROR_ARG_MSG)));
            }
            return;
         }
         this.curIdx = idx;
         this.curUid = uid;
         this.logToken = new LogData(LogData.API_RANK_LIST,"token");
         LoaderManager.loadBytes(AllConst.ULR_RNAK_LIST_GET_TOKEN,function(param1:Event):void
         {
            if(param1.type != Event.COMPLETE)
            {
               logToken.exception = param1.toString();
               logToken.submit();
               if(_realStage)
               {
                  _realStage.dispatchEvent(new RankListEvent(RankListEvent.RANKLIST_ERROR,setErrorInfo(AllConst.RL_API_GUD,AllConst.RL_ERROR_USERDATA_CODE,AllConst.RL_ERROR_USERDATA_MSG)));
               }
               return;
            }
            logToken.submit(true);
            var _loc2_:URLVariables = new URLVariables();
            _loc2_.gameid = mainProxy.gameID;
            _loc2_.uid = curUid;
            _loc2_.index = curIdx;
            var _loc3_:String = param1.target.data;
            _loc2_.token = _loc3_;
            var _loc4_:String = saveKey();
            _loc2_.gamekey = _loc4_;
            var _loc5_:String = MD5.hash(MD5.hash(MD5.hash("SDALPlsldlnSLWPElsdslSE" + curIdx + _loc4_ + curUid + mainProxy.gameID + _loc3_ + "PKslsO")));
            _loc2_.verify = _loc5_;
            logGetUserData = new LogData(LogData.API_RANK_LIST,"getUserData");
            LoaderManager.loadBytes(AllConst.ULR_RNAK_LIST_GET,returnGet,_loc2_);
         });
      }
      
      private function saveKey() : String
      {
         return MD5.hash(MD5.hash(this.mainProxy.gameID + "LPislKLodlLKKOSNlSDOAADLKADJAOADALAklsd" + this.mainProxy.gameID)).substr(4,16);
      }
      
      private function returnGet(param1:Event) : void
      {
         var str:String;
         var data:Object = null;
         var tmpObj:Object = null;
         var byte:ByteArray = null;
         var e:Event = param1;
         if(e.type != Event.COMPLETE)
         {
            this.logGetUserData.exception = e.toString();
            this.logGetUserData.submit();
            if(this._realStage)
            {
               this._realStage.dispatchEvent(new RankListEvent(RankListEvent.RANKLIST_ERROR,this.setErrorInfo(AllConst.RL_API_GUD,AllConst.RL_ERROR_USERDATA_CODE,AllConst.RL_ERROR_USERDATA_MSG)));
            }
            return;
         }
         this.logGetUserData.submit(true);
         str = e.target.data;
         if(str.charAt(0) != "{" && str != "0")
         {
            if(this._realStage)
            {
               this._realStage.dispatchEvent(new RankListEvent(RankListEvent.RANKLIST_ERROR,this.setErrorInfo(AllConst.RL_API_GUD,AllConst.RL_ERROR_USERDATA_CODE,AllConst.RL_ERROR_USERDATA_MSG)));
            }
            return;
         }
         if(str != "0")
         {
            try
            {
               data = com.adobe.serialization.json.JSON.decode(e.target.data) as Object;
               tmpObj = this.copyObj(data);
               try
               {
                  byte = Base64.decodeToByteArray(data.data);
                  byte.uncompress();
                  data.data = byte.readObject() as String;
                  byte = null;
               }
               catch(e:Error)
               {
                  data = tmpObj;
               }
            }
            catch(e:Error)
            {
               data = null;
            }
         }
         if(data)
         {
            if(int(data.index) != this.curIdx)
            {
               return;
            }
            if(data.status == undefined)
            {
               data.status = AllConst.DataOK;
            }
            if(String(data.status) != AllConst.DataOK)
            {
               if(this._realStage)
               {
                  this._realStage.dispatchEvent(new RankListEvent(RankListEvent.RANKLIST_ERROR,this.setErrorInfo(AllConst.RL_API_GUD,AllConst.RL_ERROR_USERDATAEXCP_CODE,AllConst.RL_ERROR_USERDATAEXCP_MSG)));
               }
               return;
            }
            data = this.decodeSaveData(data);
         }
         if(this._realStage)
         {
            this._realStage.dispatchEvent(new RankListEvent(RankListEvent.RANKLIST_SUCCESS,this.setSuccessInfo(AllConst.RL_API_GUD,data)));
         }
      }
      
      private function decodeSaveData(param1:Object) : Object
      {
         var _loc4_:String = null;
         var _loc5_:XML = null;
         var _loc6_:Boolean = false;
         var _loc7_:Object = null;
         var _loc8_:Array = null;
         var _loc2_:XMLToObject = new XMLToObject();
         var _loc3_:Array = _loc2_.strToObj(param1.data as String);
         if(_loc3_[0] == "String")
         {
            _loc4_ = _loc3_[1];
            param1.data = _loc4_;
         }
         else if(_loc3_[0] == "XML")
         {
            _loc5_ = _loc3_[1];
            param1.data = _loc5_;
         }
         else if(_loc3_[0] == "Boolean")
         {
            _loc6_ = Boolean(_loc3_[1]);
            param1.data = _loc6_;
         }
         else if(_loc3_[0] == "Object")
         {
            _loc7_ = _loc3_[1];
            param1.data = _loc7_;
         }
         else if(_loc3_[0] == "Array")
         {
            _loc8_ = _loc3_[1];
            param1.data = _loc8_;
         }
         return param1;
      }
      
      private function copyObj(param1:Object) : Object
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return _loc2_.readObject() as Object;
      }
      
      private function getRankListInfo(param1:Array) : Array
      {
         var i:* = undefined;
         var tmpData:FSRE_RankingItem = null;
         var tmpObj:Object = null;
         var byte:ByteArray = null;
         var tmpExtra:* = undefined;
         var dataAry:Array = param1;
         if(dataAry == null)
         {
            return null;
         }
         for(i in dataAry)
         {
            tmpData = dataAry[i] as FSRE_RankingItem;
            tmpObj = new Object();
            tmpObj.index = tmpData.index;
            tmpObj.uId = tmpData.uId;
            tmpObj.userName = tmpData.userName;
            tmpObj.score = tmpData.score;
            tmpObj.rank = tmpData.rank;
            tmpObj.area = tmpData.area;
            if(tmpData.extra)
            {
               try
               {
                  byte = Base64.decodeToByteArray(tmpData.extra);
                  byte.uncompress();
                  tmpExtra = byte.readObject();
               }
               catch(e:Error)
               {
                  tmpExtra = "扩展字段转换出错了！";
                  trace(e.message);
               }
               byte = null;
            }
            tmpObj.extra = tmpExtra;
            dataAry[i] = tmpObj;
         }
         return dataAry;
      }
      
      private function onErrorFun(param1:String, param2:Error) : void
      {
         if(this._realStage)
         {
            this._realStage.dispatchEvent(new RankListEvent(RankListEvent.RANKLIST_ERROR,this.setErrorInfo(param1,AllConst.RL_ERROR_CALLAPI_CODE,AllConst.RL_ERROR_CALLAPI_MSG)));
         }
      }
      
      private function setErrorInfo(param1:String, param2:String, param3:String) : Object
      {
         var _loc4_:Object = new Object();
         _loc4_.apiName = param1;
         _loc4_.code = param2;
         _loc4_.message = param3;
         return _loc4_;
      }
      
      private function setSuccessInfo(param1:String, param2:*) : Object
      {
         var _loc3_:Object = new Object();
         _loc3_.apiName = param1;
         _loc3_.data = param2;
         return _loc3_;
      }
   }
}

