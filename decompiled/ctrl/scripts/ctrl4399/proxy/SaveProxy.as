package ctrl4399.proxy
{
   import calista.utils.Base64;
   import com.adobe.crypto.MD5;
   import com.adobe.serialization.json.JSON;
   import ctrl4399.ObjectToXML;
   import ctrl4399.XMLToObject;
   import ctrl4399.strconst.AllConst;
   import ctrl4399.view.components.styleConst.StyleClass;
   import flash.events.DataEvent;
   import flash.events.Event;
   import flash.events.NetStatusEvent;
   import flash.net.FileReference;
   import flash.net.SharedObject;
   import flash.net.SharedObjectFlushStatus;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import frame4399.simplePureMvc.core.Facade;
   import frame4399.simplePureMvc.interfaces.IProxy;
   import frame4399.simplePureMvc.proxy.Proxy;
   import unit4399.road.loader2.LoaderUrl;
   
   public class SaveProxy extends Proxy implements IProxy
   {
      
      private var _facade:Facade = Facade.getInstance();
      
      public var realStage:*;
      
      private var _sData:String;
      
      private var _fisstGetLocal:Boolean;
      
      private var _curUpIndex:int;
      
      private var _needOpenUI:Boolean;
      
      private var _oldData:Object;
      
      private var _fi:FileReference;
      
      private var comprassStr:String;
      
      public var isOpenSaveUI:Boolean;
      
      private var sessionStr:String;
      
      public var isNeedOrder:Boolean = true;
      
      private var getSessionNum:int = 0;
      
      private var getStateNum:int = 0;
      
      private var logGetToken:LogData;
      
      private var logGet:LogData;
      
      private var logSet:LogData;
      
      private var logList:LogData;
      
      private var logSession:LogData;
      
      private var logStoreState:LogData;
      
      private var _needUpDataList:Array;
      
      private var _listData:Array;
      
      private var getType:String = "";
      
      private var _xmlToObj:XMLToObject;
      
      private var _getDataFirstObj:Object;
      
      private var _needSaveData:Object;
      
      private var _saveTime:String;
      
      private var _objToXml:ObjectToXML;
      
      private var _getIndex:int;
      
      private var _saveIndex:int;
      
      private var _saveTitle:String;
      
      private var _saveData:String;
      
      private var mySo:SharedObject;
      
      private var mySo2:SharedObject;
      
      public function SaveProxy(param1:String = null)
      {
         super(param1);
         this._saveData = "";
      }
      
      public function set needOpenUI(param1:Boolean) : void
      {
         this._needOpenUI = param1;
      }
      
      public function get needOpenUI() : Boolean
      {
         return this._needOpenUI;
      }
      
      public function set sData(param1:String) : void
      {
         this._sData = param1;
      }
      
      public function get sData() : String
      {
         if(this._sData)
         {
            return this._sData;
         }
         return "null";
      }
      
      private function get mainProxy() : MainProxy
      {
         return this._facade.retrieveProxy(AllConst.PROXY_NAME_MAIN) as MainProxy;
      }
      
      public function getStore(param1:String) : void
      {
         var urlVar:URLVariables;
         var id:String = param1;
         if(this._getDataFirstObj == null)
         {
            this._getDataFirstObj = new Object();
         }
         this._getIndex = int(id);
         trace("取档的索引值------>" + this._getIndex);
         urlVar = new URLVariables();
         urlVar.gameid = this.mainProxy.gameID;
         urlVar.uid = this.mainProxy.userID;
         this.logGetToken = new LogData(LogData.API_SAVE,"getToken");
         new LoaderUrl(AllConst.URL_SAVE_TOKEN + "&ran=" + Math.random() * 100000,function(param1:Event):void
         {
            var _loc2_:URLVariables = null;
            var _loc3_:String = null;
            var _loc4_:String = null;
            var _loc5_:String = null;
            var _loc6_:Object = null;
            if(param1.type == "complete")
            {
               logGetToken.submit(true);
               _loc2_ = new URLVariables();
               _loc2_.gameid = mainProxy.gameID;
               _loc2_.uid = mainProxy.userID;
               _loc2_.index = id;
               _loc3_ = param1.target.data;
               _loc2_.token = _loc3_;
               _loc4_ = saveKey();
               _loc2_.gamekey = _loc4_;
               _loc5_ = MD5.hash(MD5.hash(MD5.hash("SDALPlsldlnSLWPElsdslSE" + id + _loc4_ + mainProxy.userID + mainProxy.gameID + _loc3_ + "PKslsO")));
               _loc2_.verify = _loc5_;
               _loc2_.session = sessionStr;
               _loc2_.refer = StyleClass.getHref();
               logGet = new LogData(LogData.API_SAVE,"get");
               new LoaderUrl(AllConst.URL_SAVE_GET,returnGet,_loc2_);
            }
            else
            {
               logGetToken.exception = param1.toString();
               logGetToken.submit();
               _loc6_ = getLocal(mainProxy.userName,mainProxy.gameID,_getIndex);
               sendNotification(AllConst.SAVE_RETURN,{
                  "type":AllConst.SAVE_EVENT_GET,
                  "data":_loc6_,
                  "from":AllConst.DATA_FROM_LOCAL,
                  "netError":true,
                  "saveIdx":_getIndex
               });
               sendNotification(AllConst.SAVE_DATA_RETURN,{
                  "type":"get",
                  "data":_loc6_,
                  "source":AllConst.DATA_FROM_LOCAL
               });
            }
         },urlVar,this.isNeedOrder);
      }
      
      private function saveKey() : String
      {
         return MD5.hash(MD5.hash(this.mainProxy.gameID + "LPislKLodlLKKOSNlSDOAADLKADJAOADALAklsd" + this.mainProxy.gameID)).substr(4,16);
      }
      
      public function getSeesionFun() : void
      {
         this.isNeedOrder = true;
         var _loc1_:URLVariables = new URLVariables();
         _loc1_.gameid = this.mainProxy.gameID;
         _loc1_.uid = this.mainProxy.userID;
         var _loc2_:String = this.saveKey();
         _loc1_.gamekey = _loc2_;
         var _loc3_:String = MD5.hash(MD5.hash(MD5.hash("SDALPlsldlnSLWPElsdslSE" + _loc2_ + this.mainProxy.userID + this.mainProxy.gameID + "PKslsO")));
         _loc1_.verify = _loc3_;
         _loc1_.refer = StyleClass.getHref();
         this.logSession = new LogData(LogData.API_SAVE,"session");
         new LoaderUrl(AllConst.GetSession + "&ran=" + Math.random() * 100000,this.getSessionComplete,_loc1_);
      }
      
      private function getSessionComplete(param1:Event) : void
      {
         if(param1.type == "complete")
         {
            this.logSession.submit(true);
            this.getSessionNum = 0;
            this.sessionStr = String(param1.target.data);
         }
         else
         {
            this.logSession.exception = param1.toString();
            this.logSession.submit();
            if(this.getSessionNum < 2)
            {
               ++this.getSessionNum;
               this.getSeesionFun();
               return;
            }
            this.getSessionNum = 0;
            this.sessionStr = "";
         }
         if(this.mySo2 == null)
         {
            this.mySo2 = SharedObject.getLocal("/ftnn/" + MD5.hash("FtNnUsEr" + this.mainProxy.userName + "ReSuNnTf") + "/" + MD5.hash("FtNnGiD" + this.mainProxy.gameID + "DiGnNtF"));
         }
         this.mySo2.data[MD5.hash("session")] = Base64.encode(this.sessionStr + "@&");
         this.mySo2.flush();
         this.mySo2.close();
         this.mySo2 = null;
         this.isNeedOrder = false;
         this.mainProxy.runNeedFunc();
      }
      
      public function getStoreState() : void
      {
         var _loc1_:URLVariables = new URLVariables();
         _loc1_.gameid = this.mainProxy.gameID;
         _loc1_.uid = this.mainProxy.userID;
         _loc1_.session = this.sessionStr;
         var _loc2_:String = MD5.hash(MD5.hash(MD5.hash("SDALPlsldlnSLWPElsdslSE" + this.sessionStr + this.mainProxy.userID + this.mainProxy.gameID + "PKslsO")));
         _loc1_.verify = _loc2_;
         _loc1_.refer = StyleClass.getHref();
         this.logStoreState = new LogData(LogData.API_SAVE,"storeState");
         new LoaderUrl(AllConst.GetStoreState,this.getStoreStateComplete,_loc1_);
      }
      
      private function getStoreStateComplete(param1:Event) : void
      {
         var _loc2_:String = "-1";
         if(param1.type == "complete")
         {
            this.logStoreState.submit(true);
            this.getStateNum = 0;
            _loc2_ = String(param1.target.data);
         }
         else
         {
            this.logStoreState.exception = param1.toString();
            this.logStoreState.submit();
            if(this.getStateNum < 2)
            {
               ++this.getStateNum;
               this.getStoreState();
               return;
            }
            this.getStateNum = 0;
            _loc2_ = "-1";
         }
         this.realStage.dispatchEvent(new DataEvent("StoreStateEvent",false,false,_loc2_));
      }
      
      private function getLocalSession() : String
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         if(this.mySo2 == null)
         {
            this.mySo2 = SharedObject.getLocal("/ftnn/" + MD5.hash("FtNnUsEr" + this.mainProxy.userName + "ReSuNnTf") + "/" + MD5.hash("FtNnGiD" + this.mainProxy.gameID + "DiGnNtF"));
         }
         var _loc1_:String = "novalue";
         if(this.mySo2.data[MD5.hash("session")])
         {
            _loc2_ = Base64.decode(String(this.mySo2.data[MD5.hash("session")]));
            _loc3_ = _loc2_.indexOf("@&");
            _loc1_ = _loc3_ == -1 ? "novalue" : _loc2_.substring(0,_loc3_);
         }
         this.mySo2.close();
         this.mySo2 = null;
         return _loc1_;
      }
      
      public function setStore(param1:String, param2:String = "", param3:String = "", param4:Object = null) : void
      {
         var urlVar:URLVariables;
         var id:String = param1;
         var _title:String = param2;
         var data:String = param3;
         var oldData:Object = param4;
         this._saveData = data;
         this._saveIndex = int(id);
         this._saveTitle = _title;
         this._oldData = oldData;
         urlVar = new URLVariables();
         urlVar.gameid = this.mainProxy.gameID;
         urlVar.uid = this.mainProxy.userID;
         this.logGetToken = new LogData(LogData.API_SAVE,"getToken");
         new LoaderUrl(AllConst.URL_SAVE_TOKEN + "&ran=" + Math.random() * 100000,function(param1:Event):void
         {
            var _loc2_:URLVariables = null;
            var _loc3_:ByteArray = null;
            var _loc4_:ByteArray = null;
            var _loc5_:String = null;
            var _loc6_:String = null;
            var _loc7_:String = null;
            if(param1.type == "complete")
            {
               logGetToken.submit(true);
               _loc2_ = new URLVariables();
               _loc2_.gameid = mainProxy.gameID;
               _loc2_.uid = mainProxy.userID;
               _loc2_.index = id;
               _loc2_.title = _title;
               _loc3_ = new ByteArray();
               _loc3_.writeObject(data);
               trace("原始大小-------->" + _loc3_.length);
               _loc3_.compress();
               trace("字节压缩大小-------->" + _loc3_.length);
               comprassStr = Base64.encodeByteArray(_loc3_);
               _loc4_ = new ByteArray();
               _loc4_.writeObject(comprassStr);
               trace("Base64大小-------->" + _loc4_.length);
               _loc4_ = null;
               _loc3_ = null;
               _loc2_.data = comprassStr;
               _loc5_ = param1.target.data;
               _loc2_.token = _loc5_;
               _loc6_ = saveKey();
               _loc2_.gamekey = _loc6_;
               _loc7_ = MD5.hash(MD5.hash(MD5.hash("SDALPlsldlnSLWPElsdslSE" + id + _loc6_ + comprassStr + _title + mainProxy.userID + mainProxy.gameID + _loc5_ + "PKslsO")));
               _loc2_.verify = _loc7_;
               _loc2_.session = sessionStr;
               _loc2_.refer = StyleClass.getHref();
               logSet = new LogData(LogData.API_SAVE,"set");
               new LoaderUrl(AllConst.URL_SAVE_SET,returnSet,_loc2_);
            }
            else
            {
               logGetToken.exception = param1.toString();
               logGetToken.submit();
               if(getLocalSession() == sessionStr)
               {
                  saveLocal(mainProxy.userName,mainProxy.gameID,id,_title,_oldData);
               }
               else
               {
                  sendNotification(AllConst.SAVE_RETURN,{
                     "type":AllConst.SAVE_EVENT_SAVE,
                     "data":false,
                     "from":AllConst.DATA_FROM_LOCAL
                  });
                  sendNotification(AllConst.SAVE_ERROR,"本地存档失败！");
               }
            }
         },urlVar,this.isNeedOrder);
      }
      
      public function getList() : void
      {
         var urlVar:URLVariables = new URLVariables();
         urlVar.gameid = this.mainProxy.gameID;
         urlVar.uid = this.mainProxy.userID;
         this.logGetToken = new LogData(LogData.API_SAVE,"getToken");
         new LoaderUrl(AllConst.URL_SAVE_TOKEN + "&ran=" + Math.random() * 100000,function(param1:Event):void
         {
            var _loc2_:URLVariables = null;
            var _loc3_:String = null;
            var _loc4_:String = null;
            var _loc5_:String = null;
            var _loc6_:Array = null;
            if(param1.type == "complete")
            {
               logGetToken.submit(true);
               _loc2_ = new URLVariables();
               _loc2_.gameid = mainProxy.gameID;
               _loc2_.uid = mainProxy.userID;
               _loc3_ = param1.target.data;
               _loc2_.token = _loc3_;
               _loc4_ = saveKey();
               _loc2_.gamekey = _loc4_;
               _loc5_ = MD5.hash(MD5.hash(MD5.hash("SDALPlsldlnSLWPElsdslSE" + _loc4_ + mainProxy.userID + mainProxy.gameID + _loc3_ + "PKslsO")));
               _loc2_.verify = _loc5_;
               logList = new LogData(LogData.API_SAVE,"list");
               new LoaderUrl(AllConst.URL_SAVE_LIST,returnList,_loc2_);
            }
            else
            {
               logGetToken.exception = param1.toString();
               logGetToken.submit();
               _loc6_ = getLocalList(mainProxy.userName,mainProxy.gameID);
               sendNotification(AllConst.SAVE_RETURN,{
                  "type":AllConst.SAVE_EVENT_LIST,
                  "data":_loc6_,
                  "from":AllConst.DATA_FROM_LOCAL
               });
               sendNotification(AllConst.SAVE_DATA_RETURN,{
                  "type":"list",
                  "data":_loc6_,
                  "source":AllConst.DATA_FROM_LOCAL
               });
            }
         },urlVar,this.isNeedOrder);
      }
      
      private function returnList(param1:Event) : void
      {
         var str:String;
         var localList:Array = null;
         var tmpList:Array = null;
         var i:int = 0;
         var len:int = 0;
         var lineObj:Object = null;
         var localObj:Object = null;
         var str1:String = null;
         var str2:String = null;
         var e:Event = param1;
         if(e.type != Event.COMPLETE)
         {
            this.logList.exception = e.toString();
            this.logList.submit();
            this._listData = this.getLocalList(this.mainProxy.userName,this.mainProxy.gameID);
            sendNotification(AllConst.SAVE_RETURN,{
               "type":AllConst.SAVE_EVENT_LIST,
               "data":this._listData,
               "from":AllConst.DATA_FROM_LOCAL
            });
            sendNotification(AllConst.SAVE_DATA_RETURN,{
               "type":"list",
               "data":this._listData,
               "source":AllConst.DATA_FROM_LOCAL
            });
            return;
         }
         this.logList.submit(true);
         str = e.target.data;
         if(str.charAt(0) != "[" && str != "0")
         {
            sendNotification(AllConst.SAVE_RETURN,{
               "type":AllConst.SAVE_EVENT_LIST,
               "data":null,
               "from":AllConst.DATA_FROM_NET
            });
            sendNotification(AllConst.SAVE_ERROR,str);
            return;
         }
         if(e.target.data != "0")
         {
            try
            {
               this._listData = com.adobe.serialization.json.JSON.decode(e.target.data) as Array;
            }
            catch(e:Error)
            {
               _listData = null;
            }
         }
         else
         {
            this._listData = null;
         }
         if(!this._fisstGetLocal)
         {
            localList = this.getLocalList(this.mainProxy.userName,this.mainProxy.gameID);
            tmpList = [];
            if(this._listData != null)
            {
               len = int(this._listData.length);
               i = 0;
               while(i < len)
               {
                  lineObj = this._listData[i];
                  if(lineObj != null)
                  {
                     if(lineObj.status == undefined)
                     {
                        lineObj.status = AllConst.DataOK;
                     }
                     tmpList[int(lineObj.index)] = lineObj;
                  }
                  i++;
               }
            }
            if(localList != null)
            {
               this._needUpDataList = [];
               len = 8;
               i = 0;
               while(i < len)
               {
                  lineObj = tmpList[i];
                  localObj = localList[i];
                  if(localObj != null)
                  {
                     if(lineObj == null)
                     {
                        if(this._objToXml == null)
                        {
                           this._objToXml = new ObjectToXML();
                        }
                        try
                        {
                           str1 = this._objToXml.objectToString(localObj.data);
                           localObj.data = str1;
                           this._needUpDataList.push(localObj);
                           tmpList[int(localObj.index)] = {
                              "title":localObj.title,
                              "datetime":localObj.datetime,
                              "index":localObj.index,
                              "status":localObj.status
                           };
                        }
                        catch(e:Error)
                        {
                        }
                     }
                     else if(String(lineObj.status) == AllConst.DataOK && !this.getMaxTime(lineObj.datetime,localObj.datetime))
                     {
                        if(this._objToXml == null)
                        {
                           this._objToXml = new ObjectToXML();
                        }
                        try
                        {
                           str2 = this._objToXml.objectToString(localObj.data);
                           localObj.data = str2;
                           tmpList[int(localObj.index)] = {
                              "title":localObj.title,
                              "datetime":localObj.datetime,
                              "index":localObj.index,
                              "status":localObj.status
                           };
                           this._needUpDataList.push(localObj);
                        }
                        catch(e:Error)
                        {
                        }
                     }
                     else
                     {
                        this.clearLoaclData(this.mainProxy.userName,this.mainProxy.gameID,String(localObj.index));
                     }
                  }
                  i++;
               }
               this._listData = tmpList;
            }
            this.upLocalToNet("getListType");
            return;
         }
         sendNotification(AllConst.SAVE_RETURN,{
            "type":AllConst.SAVE_EVENT_LIST,
            "data":this._listData,
            "from":AllConst.DATA_FROM_LOCAL
         });
         sendNotification(AllConst.SAVE_DATA_RETURN,{
            "type":"list",
            "data":this._listData,
            "source":AllConst.DATA_FROM_NET
         });
      }
      
      private function upLocalToNet(param1:String = "") : void
      {
         var _loc2_:Object = null;
         if(this._needUpDataList == null || this._needUpDataList.length <= 0)
         {
            if(param1 != "getListType")
            {
               return;
            }
            trace("upLocalToNet==================");
            sendNotification(AllConst.SAVE_RETURN,{
               "type":AllConst.SAVE_EVENT_LIST,
               "data":this._listData,
               "from":AllConst.DATA_FROM_NET
            });
            sendNotification(AllConst.SAVE_DATA_RETURN,{
               "type":"list",
               "data":this._listData,
               "source":AllConst.DATA_FROM_NET
            });
            return;
         }
         this.getType = param1;
         _loc2_ = this._needUpDataList.pop();
         this._curUpIndex = _loc2_.index;
         this.doUpLocalToNet(_loc2_.index,_loc2_.title,_loc2_.data);
      }
      
      private function doUpLocalToNet(param1:int, param2:String, param3:String) : void
      {
         var index:int = param1;
         var title:String = param2;
         var data:String = param3;
         var urlVar:URLVariables = new URLVariables();
         urlVar.gameid = this.mainProxy.gameID;
         urlVar.uid = this.mainProxy.userID;
         this.logGetToken = new LogData(LogData.API_SAVE,"getToken");
         new LoaderUrl(AllConst.URL_SAVE_TOKEN + "&ran=" + Math.random() * 100000,function(param1:Event):void
         {
            var _loc2_:URLVariables = null;
            var _loc3_:ByteArray = null;
            var _loc4_:String = null;
            var _loc5_:String = null;
            var _loc6_:String = null;
            if(param1.type == "complete")
            {
               logGetToken.submit(true);
               _loc2_ = new URLVariables();
               _loc2_.gameid = mainProxy.gameID;
               _loc2_.uid = mainProxy.userID;
               _loc2_.index = index;
               _loc2_.title = title;
               _loc3_ = new ByteArray();
               _loc3_.writeObject(data);
               _loc3_.compress();
               comprassStr = Base64.encodeByteArray(_loc3_);
               _loc3_ = null;
               _loc2_.data = comprassStr;
               _loc4_ = param1.target.data;
               _loc2_.token = _loc4_;
               _loc5_ = saveKey();
               _loc2_.gamekey = _loc5_;
               _loc6_ = MD5.hash(MD5.hash(MD5.hash("SDALPlsldlnSLWPElsdslSE" + index + _loc5_ + _loc2_.data + title + mainProxy.userID + mainProxy.gameID + _loc4_ + "PKslsO")));
               _loc2_.verify = _loc6_;
               _loc2_.session = sessionStr;
               _loc2_.refer = StyleClass.getHref();
               logSet = new LogData(LogData.API_SAVE,"set");
               new LoaderUrl(AllConst.URL_SAVE_SET,upReturnSet,_loc2_);
            }
            else
            {
               logGetToken.exception = param1.toString();
               logGetToken.submit();
               _listData[_curUpIndex] = null;
               upReturnSet(null);
            }
         },urlVar);
      }
      
      private function upReturnSet(param1:Event) : void
      {
         var _loc2_:Object = null;
         if(Boolean(param1) && Boolean(param1.type == Event.COMPLETE) && String(param1.target.data) == AllConst.MultipleError)
         {
            this.logSet.submit(true);
            if(this.getType != "getListType")
            {
               sendNotification(AllConst.SAVE_RETURN,{
                  "type":AllConst.SAVE_EVENT_SAVE,
                  "data":false,
                  "from":AllConst.MULTIPLE_ERROR
               });
               sendNotification(AllConst.SAVE_ERROR,String(param1.target.data));
            }
            else
            {
               sendNotification(AllConst.SAVE_RETURN,{
                  "type":AllConst.SAVE_EVENT_LIST,
                  "data":this._listData,
                  "from":AllConst.DATA_FROM_NET
               });
               sendNotification(AllConst.SAVE_DATA_RETURN,{
                  "type":"list",
                  "data":this._listData,
                  "source":AllConst.DATA_FROM_NET
               });
            }
            this._needUpDataList.length = 0;
            return;
         }
         if(param1 == null || param1.type != Event.COMPLETE)
         {
            if(param1)
            {
               this.logSet.exception = param1.toString();
            }
            else
            {
               this.logSet.exception = "null";
            }
            this.logSet.submit();
            this._listData[this._curUpIndex] = null;
         }
         if(param1 == null || param1.target.data != "1")
         {
            trace("ʧ°ܡª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª" + this._curUpIndex);
            this._listData[this._curUpIndex] = null;
         }
         else
         {
            this.clearLoaclData(this.mainProxy.userName,this.mainProxy.gameID,String(this._curUpIndex));
         }
         if(this._needUpDataList == null || this._needUpDataList.length <= 0)
         {
            if(this.getType != "getListType")
            {
               return;
            }
            trace("upReturnSet=====================");
            sendNotification(AllConst.SAVE_RETURN,{
               "type":AllConst.SAVE_EVENT_LIST,
               "data":this._listData,
               "from":AllConst.DATA_FROM_NET
            });
            sendNotification(AllConst.SAVE_DATA_RETURN,{
               "type":"list",
               "data":this._listData,
               "source":AllConst.DATA_FROM_NET
            });
            return;
         }
         _loc2_ = this._needUpDataList.pop();
         this._curUpIndex = _loc2_.index;
         this.doUpLocalToNet(_loc2_.index,_loc2_.title,_loc2_.data);
      }
      
      private function getMaxTime(param1:String, param2:String) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         var _loc7_:Array = null;
         var _loc8_:Array = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         _loc3_ = param1.split(" ");
         _loc4_ = param2.split(" ");
         _loc6_ = _loc3_[0].split("-");
         _loc5_ = _loc4_[0].split("-");
         _loc8_ = _loc4_[1].split(":");
         _loc7_ = _loc3_[1].split(":");
         _loc9_ = int(_loc5_.length);
         _loc10_ = 0;
         while(_loc10_ < _loc9_)
         {
            if(int(_loc6_[_loc10_]) > int(_loc5_[_loc10_]))
            {
               return true;
            }
            if(int(_loc6_[_loc10_]) < int(_loc5_[_loc10_]))
            {
               return false;
            }
            _loc10_++;
         }
         _loc9_ = int(_loc8_.length);
         _loc10_ = 0;
         while(_loc10_ < _loc9_)
         {
            if(int(_loc7_[_loc10_]) > int(_loc8_[_loc10_]))
            {
               return true;
            }
            if(int(_loc7_[_loc10_]) < int(_loc8_[_loc10_]))
            {
               return false;
            }
            _loc10_++;
         }
         return true;
      }
      
      private function returnSet(param1:Event) : void
      {
         var _loc2_:String = null;
         if(param1.type != Event.COMPLETE)
         {
            this.logSet.exception = param1.toString();
            this.logSet.submit();
            if(this.getLocalSession() == this.sessionStr)
            {
               this.saveLocal(this.mainProxy.userName,this.mainProxy.gameID,String(this._saveIndex),this._saveTitle,this._oldData);
            }
            else
            {
               sendNotification(AllConst.SAVE_RETURN,{
                  "type":AllConst.SAVE_EVENT_SAVE,
                  "data":false,
                  "from":AllConst.DATA_FROM_LOCAL
               });
               sendNotification(AllConst.SAVE_ERROR,"本地存档失败！");
            }
            return;
         }
         this.logSet.submit(true);
         _loc2_ = param1.target.data;
         var _loc3_:Boolean = int(param1.target.data) == 1 ? true : false;
         if(_loc2_ != "1")
         {
            if(_loc2_ != AllConst.MultipleError)
            {
               sendNotification(AllConst.SAVE_RETURN,{
                  "type":AllConst.SAVE_EVENT_SAVE,
                  "data":false,
                  "from":AllConst.DATA_FROM_NET
               });
            }
            else
            {
               sendNotification(AllConst.SAVE_RETURN,{
                  "type":AllConst.SAVE_EVENT_SAVE,
                  "data":false,
                  "from":AllConst.MULTIPLE_ERROR
               });
            }
            sendNotification(AllConst.SAVE_ERROR,_loc2_);
            return;
         }
         this._saveTime = this.getTime();
         sendNotification(AllConst.SAVE_RETURN,{
            "type":AllConst.SAVE_EVENT_SAVE,
            "data":_loc3_,
            "from":AllConst.DATA_FROM_NET
         });
         sendNotification(AllConst.SAVE_DATA_RETURN,{
            "type":"save",
            "data":_loc3_,
            "source":AllConst.DATA_FROM_NET,
            "index":this._saveIndex,
            "title":this._saveTitle,
            "datetime":this._saveTime
         });
      }
      
      private function returnGet(param1:Event) : void
      {
         var str:String;
         var data:Object = null;
         var from:int = 0;
         var tmpObj:Object = null;
         var byte:ByteArray = null;
         var getLocalObj:Object = null;
         var e:Event = param1;
         trace("returnGet e type----->");
         if(e == null || e.type != Event.COMPLETE)
         {
            this.logGet.exception = e.toString();
            this.logGet.submit();
            data = this.getLocal(this.mainProxy.userName,this.mainProxy.gameID,this._getIndex);
            this._getDataFirstObj[String(this._getIndex)] = false;
            sendNotification(AllConst.SAVE_RETURN,{
               "type":AllConst.SAVE_EVENT_GET,
               "data":data,
               "from":AllConst.DATA_FROM_LOCAL,
               "netError":true,
               "saveIdx":this._getIndex
            });
            sendNotification(AllConst.SAVE_DATA_RETURN,{
               "type":"get",
               "data":data,
               "source":AllConst.DATA_FROM_LOCAL
            });
            return;
         }
         this.logGet.submit(true);
         trace("nameId = " + this.mainProxy.userID);
         str = e.target.data;
         if(str.charAt(0) != "{" && str != "0")
         {
            trace(str);
            this._getDataFirstObj[String(this._getIndex)] = false;
            sendNotification(AllConst.SAVE_ERROR,str);
            if(str != AllConst.MultipleError)
            {
               sendNotification(AllConst.SAVE_RETURN,{
                  "type":AllConst.SAVE_EVENT_GET,
                  "data":null,
                  "from":AllConst.DATA_FROM_NET,
                  "netError":true,
                  "saveIdx":this._getIndex
               });
            }
            else
            {
               sendNotification(AllConst.SAVE_RETURN,{
                  "type":AllConst.SAVE_EVENT_GET,
                  "data":null,
                  "from":AllConst.MULTIPLE_ERROR,
                  "netError":true,
                  "saveIdx":this._getIndex
               });
            }
            return;
         }
         if(str == "0")
         {
            this._getDataFirstObj[String(this._getIndex)] = false;
         }
         else
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
            if(data)
            {
               if(data.status == undefined)
               {
                  data.status = AllConst.DataOK;
               }
               if(String(data.status) != AllConst.DataOK)
               {
                  this.clearLoaclData(this.mainProxy.userName,this.mainProxy.gameID,String(data.index));
                  sendNotification(AllConst.GetData_Excep,String(data.status));
                  sendNotification(AllConst.SAVE_RETURN,{
                     "type":AllConst.SAVE_EVENT_DataExcep,
                     "data":data
                  });
                  return;
               }
            }
         }
         from = AllConst.DATA_FROM_NET;
         if(!this._getDataFirstObj[String(this._getIndex)])
         {
            this._getDataFirstObj[String(this._getIndex)] = true;
            getLocalObj = this.getLocal(this.mainProxy.userName,this.mainProxy.gameID,this._getIndex);
            if(getLocalObj != null)
            {
               if(data == null)
               {
                  data = getLocalObj;
                  this.addNeedUpData(getLocalObj);
                  from = AllConst.DATA_FROM_LOCAL;
               }
               else if(!this.getMaxTime(data.datetime,getLocalObj.datetime))
               {
                  data = getLocalObj;
                  this.addNeedUpData(getLocalObj);
                  from = AllConst.DATA_FROM_LOCAL;
               }
               else
               {
                  this.clearLoaclData(this.mainProxy.userName,this.mainProxy.gameID,String(this._getIndex));
               }
            }
         }
         sendNotification(AllConst.SAVE_RETURN,{
            "type":AllConst.SAVE_EVENT_GET,
            "data":data,
            "from":from,
            "netError":false,
            "saveIdx":this._getIndex
         });
         sendNotification(AllConst.SAVE_DATA_RETURN,{
            "type":"get",
            "data":data,
            "source":from
         });
         this.upLocalToNet();
      }
      
      private function addNeedUpData(param1:Object) : void
      {
         var _loc3_:String = null;
         if(this._needUpDataList == null)
         {
            this._needUpDataList = [];
         }
         var _loc2_:Object = this.copyObj(param1);
         if(this._objToXml == null)
         {
            this._objToXml = new ObjectToXML();
         }
         _loc3_ = this._objToXml.objectToString(_loc2_.data);
         _loc2_.data = _loc3_;
         this._needUpDataList.push(this.copyObj(_loc2_));
      }
      
      public function setTitle(param1:String) : void
      {
         this._saveTitle = param1;
      }
      
      public function setData(param1:Object) : String
      {
         var _loc2_:String = null;
         if(this._objToXml == null)
         {
            this._objToXml = new ObjectToXML();
         }
         _loc2_ = this._objToXml.objectToString(param1);
         this._saveData = _loc2_;
         return _loc2_;
      }
      
      public function saveDataAt(param1:int) : void
      {
         this._saveIndex = param1;
         if(this._saveTitle == null || this._saveData == null)
         {
            return;
         }
         this.setStore(String(param1),this._saveTitle,this._saveData,this._oldData);
      }
      
      private function clearLoaclData(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:String = null;
         if(this.mySo == null)
         {
            _loc4_ = this.getLocalSavePath(param1,param2);
            this.mySo = SharedObject.getLocal(_loc4_);
         }
         if(this.mySo.data[MD5.hash("saveDataList")] == null || this.mySo.data[MD5.hash("saveDataList")][int(param3)] == undefined)
         {
            return;
         }
         this.mySo.data[MD5.hash("saveDataList")][int(param3)] = undefined;
         this.mySo.flush();
      }
      
      private function getLocalSavePath(param1:String, param2:String) : String
      {
         var _loc3_:String = "";
         if(param1 == null || param2 == null)
         {
            return _loc3_;
         }
         return "/ssjj/" + MD5.hash(MD5.hash(param1)) + "/" + MD5.hash(MD5.hash(param2));
      }
      
      private function getLocalHeadData(param1:String, param2:String) : String
      {
         var _loc3_:String = "";
         if(param1 == null || param2 == null)
         {
            return _loc3_;
         }
         _loc3_ = param1 + "," + param2;
         var _loc4_:ByteArray = new ByteArray();
         _loc4_.writeObject(_loc3_);
         _loc4_.compress();
         _loc3_ = Base64.encodeByteArray(_loc4_);
         _loc4_ = null;
         return _loc3_;
      }
      
      private function decodeLocalHeadData(param1:String) : Array
      {
         var _loc2_:Array = null;
         if(param1 == null)
         {
            return _loc2_;
         }
         var _loc3_:ByteArray = new ByteArray();
         _loc3_ = Base64.decodeToByteArray(param1);
         _loc3_.uncompress();
         param1 = _loc3_.readObject() as String;
         _loc3_ = null;
         return param1.split(",");
      }
      
      public function saveLocal(param1:String, param2:String, param3:String, param4:String, param5:Object) : void
      {
         var obj:Object;
         var byte:ByteArray;
         var tmpId:String;
         var flushStatus:String;
         var str:String = null;
         var path:String = null;
         var name:String = param1;
         var gameId:String = param2;
         var index:String = param3;
         var title:String = param4;
         var data:Object = param5;
         if(name == null)
         {
            return;
         }
         if(gameId == null)
         {
            return;
         }
         this._saveIndex = int(index);
         this._saveTitle = title;
         if(this.mySo == null)
         {
            path = this.getLocalSavePath(name,gameId);
            this.mySo = SharedObject.getLocal(path);
         }
         if(this._getDataFirstObj)
         {
            this._getDataFirstObj[String(index)] = false;
         }
         if(this.mySo.data[MD5.hash("saveDataList")] == null)
         {
            this.mySo.data[MD5.hash("saveDataList")] = [];
         }
         obj = new Object();
         obj.index = index;
         obj.title = title;
         obj.status = AllConst.DataOK;
         if(this._objToXml == null)
         {
            this._objToXml = new ObjectToXML();
         }
         str = this._objToXml.objectToString(data);
         str = Base64.encode("#" + String(index) + "$") + "#" + str;
         byte = new ByteArray();
         byte.writeObject(str);
         byte.compress();
         this.comprassStr = Base64.encodeByteArray(byte);
         byte = null;
         tmpId = name != "local43990000" ? this.mainProxy.userID : "noUid";
         this.comprassStr = Base64.encode(this.comprassStr + "#" + this.getLocalHeadData(name,tmpId) + "#");
         obj.data = this.comprassStr;
         obj.datetime = this.getTime();
         this.mySo.data[MD5.hash("saveDataList")][int(index)] = obj;
         flushStatus = null;
         try
         {
            flushStatus = this.mySo.flush();
         }
         catch(e:Error)
         {
            trace("±¾µش浵ʧ°Ü");
            sendNotification(AllConst.SAVE_RETURN,{
               "type":AllConst.SAVE_EVENT_SAVE,
               "data":false,
               "from":AllConst.DATA_FROM_LOCAL
            });
            sendNotification(AllConst.SAVE_ERROR,"本地存档失败");
            if(mySo)
            {
               mySo.close();
               mySo = null;
            }
         }
         if(flushStatus != null)
         {
            switch(flushStatus)
            {
               case SharedObjectFlushStatus.PENDING:
                  if(this.mySo)
                  {
                     this.mySo.addEventListener(NetStatusEvent.NET_STATUS,this.onFlushStatus);
                  }
                  break;
               case SharedObjectFlushStatus.FLUSHED:
                  sendNotification(AllConst.SAVE_RETURN,{
                     "type":AllConst.SAVE_EVENT_SAVE,
                     "data":true,
                     "from":AllConst.DATA_FROM_LOCAL
                  });
                  if(this._needOpenUI)
                  {
                     this._saveTime = this.getTime();
                     sendNotification(AllConst.SAVE_DATA_RETURN,{
                        "type":"save",
                        "data":true,
                        "source":AllConst.DATA_FROM_LOCAL,
                        "index":this._saveIndex,
                        "title":this._saveTitle,
                        "datetime":this._saveTime
                     });
                  }
                  trace("mySo = " + this.mySo);
                  if(this.mySo != null)
                  {
                     this.mySo.close();
                     this.mySo = null;
                  }
            }
         }
      }
      
      private function onFlushStatus(param1:NetStatusEvent) : void
      {
         switch(param1.info.code)
         {
            case "SharedObject.Flush.Success":
               sendNotification(AllConst.SAVE_RETURN,{
                  "type":AllConst.SAVE_EVENT_SAVE,
                  "data":true,
                  "from":AllConst.DATA_FROM_LOCAL
               });
               if(this._needOpenUI)
               {
                  this._saveTime = this.getTime();
                  sendNotification(AllConst.SAVE_DATA_RETURN,{
                     "type":"save",
                     "data":true,
                     "source":AllConst.DATA_FROM_LOCAL,
                     "index":this._saveIndex,
                     "title":this._saveTitle,
                     "datetime":this._saveTime
                  });
               }
               break;
            case "SharedObject.Flush.Failed":
               sendNotification(AllConst.SAVE_ERROR,"本地存档失败");
               sendNotification(AllConst.SAVE_RETURN,{
                  "type":AllConst.SAVE_EVENT_SAVE,
                  "data":false,
                  "from":AllConst.DATA_FROM_LOCAL
               });
         }
         if(this.mySo != null)
         {
            this.mySo.removeEventListener(NetStatusEvent.NET_STATUS,this.onFlushStatus);
            this.mySo.close();
            this.mySo = null;
         }
      }
      
      public function getLocal(param1:String, param2:String, param3:int) : Object
      {
         var obj:Object = null;
         var path:String = null;
         var name:String = param1;
         var gameId:String = param2;
         var index:int = param3;
         if(this.mySo == null)
         {
            try
            {
               path = this.getLocalSavePath(name,gameId);
               this.mySo = SharedObject.getLocal(path);
            }
            catch(e:Error)
            {
               return null;
            }
         }
         try
         {
            this.mySo.data[MD5.hash("saveDataList")];
         }
         catch(e:Error)
         {
            return null;
         }
         if(this.mySo.data[MD5.hash("saveDataList")] == null)
         {
            return null;
         }
         try
         {
            obj = this.mySo.data[MD5.hash("saveDataList")][index];
         }
         catch(e:Error)
         {
            if(mySo)
            {
               mySo.close();
               mySo = null;
            }
            return null;
         }
         if(obj != null)
         {
            obj = this.copyObj(obj);
            obj = this.decodeLocalData(obj,String(index));
         }
         if(this.mySo)
         {
            this.mySo.close();
            this.mySo = null;
         }
         return obj;
      }
      
      public function getLocalList(param1:String, param2:String) : Array
      {
         var arr:Array = null;
         var path:String = null;
         var i:int = 0;
         var obj:Object = null;
         var name:String = param1;
         var gameId:String = param2;
         trace("name = " + name + "   gameId = " + gameId);
         if(this.mySo == null)
         {
            path = this.getLocalSavePath(name,gameId);
            this.mySo = SharedObject.getLocal(path);
         }
         if(this.mySo == null)
         {
            return null;
         }
         try
         {
            arr = this.mySo.data[MD5.hash("saveDataList")];
         }
         catch(e:Error)
         {
            return null;
         }
         arr = this.mySo.data[MD5.hash("saveDataList")] as Array;
         if(arr != null)
         {
            arr = this.copyObj(this.mySo.data[MD5.hash("saveDataList")]) as Array;
         }
         if(arr != null)
         {
            i = 0;
            while(i < 8)
            {
               obj = arr[i];
               if(obj != null)
               {
                  arr[i] = this.decodeLocalData(obj,String(i));
               }
               i++;
            }
         }
         if(this.mySo)
         {
            this.mySo.close();
            this.mySo = null;
         }
         return arr;
      }
      
      private function decodeLocalData(param1:Object, param2:String) : Object
      {
         var tmpStr:String = null;
         var tmpAry:Array = null;
         var userDataAry:Array = null;
         var byte:ByteArray = null;
         var tmpData:String = null;
         var saveDataAry:Array = null;
         var obj:Object = param1;
         var index:String = param2;
         try
         {
            tmpStr = Base64.decode(obj.data);
            tmpAry = tmpStr.split("#");
            userDataAry = this.decodeLocalHeadData(tmpAry[1]);
            if(userDataAry[0] == "local43990000" && userDataAry[1] != "noUid" || userDataAry[0] != "local43990000" && (userDataAry[0] != this.mainProxy.userName || userDataAry[1] != this.mainProxy.userID))
            {
               obj = null;
            }
            else
            {
               byte = Base64.decodeToByteArray(tmpAry[0]);
               byte.uncompress();
               tmpData = byte.readObject() as String;
               saveDataAry = tmpData.split("#");
               if(Base64.decode(saveDataAry[0]).substr(1,1) == index)
               {
                  obj.data = saveDataAry[1];
                  obj.status = AllConst.DataOK;
               }
               else
               {
                  obj = null;
               }
               byte = null;
            }
         }
         catch(e:Error)
         {
            obj = null;
         }
         return obj;
      }
      
      private function getTime() : String
      {
         var _loc1_:String = null;
         _loc1_ = "";
         var _loc2_:Date = new Date();
         _loc1_ += _loc2_.fullYear;
         _loc1_ += "-" + this.serialNum(_loc2_.month + 1);
         _loc1_ += "-" + this.serialNum(_loc2_.getDate());
         _loc1_ += " " + this.serialNum(_loc2_.getHours());
         _loc1_ += ":" + this.serialNum(_loc2_.getMinutes());
         return _loc1_ + (":" + this.serialNum(_loc2_.getSeconds()));
      }
      
      private function serialNum(param1:Number) : String
      {
         var _loc2_:String = null;
         _loc2_ = String(param1);
         if(param1 < 10)
         {
            _loc2_ = "0" + param1;
         }
         return _loc2_;
      }
      
      public function setOldData(param1:Object) : void
      {
         this._oldData = param1;
      }
      
      private function copyObj(param1:Object) : Object
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return _loc2_.readObject() as Object;
      }
      
      public function get saveIdx() : int
      {
         return this._saveIndex;
      }
   }
}

