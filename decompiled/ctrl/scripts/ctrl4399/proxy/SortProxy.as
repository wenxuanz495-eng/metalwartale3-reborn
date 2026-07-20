package ctrl4399.proxy
{
   import ctrl4399.proxy.scoreApi.*;
   import ctrl4399.strconst.AllConst;
   import flash.events.Event;
   import flash.system.LoaderContext;
   import flash.system.Security;
   import flash.utils.Dictionary;
   import frame4399.simplePureMvc.core.Facade;
   import frame4399.simplePureMvc.interfaces.IProxy;
   import frame4399.simplePureMvc.proxy.Proxy;
   import unit4399.picLoad.IJPGLoader;
   import unit4399.picLoad.JPGLoadmanager;
   
   public class SortProxy extends Proxy implements IProxy
   {
      
      public static const TYPE_DAY:String = "day";
      
      public static const TYPE_MONTH:String = "month";
      
      public static const TYPE_ALL:String = "all";
      
      private var _mainProxy:MainProxy;
      
      private var _facade:Facade = Facade.getInstance();
      
      private var _loadType:String = "";
      
      public var _dataDay:Array;
      
      public var _dataMonth:Array;
      
      public var _dataAll:Array;
      
      public var selfIndex:int = 0;
      
      public var selfData:Array = null;
      
      private var _loadList:Array;
      
      private var _loadPicArr:Array;
      
      private var _getType:String;
      
      private var _callFunObj:Object;
      
      private var client:DevScoreImpl;
      
      private var logGetTop:LogData;
      
      public function SortProxy(param1:String = null)
      {
         super(param1);
         this._mainProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_MAIN) as MainProxy;
         this._callFunObj = new Object();
         this._callFunObj[TYPE_ALL] = this.allLoadCallBack;
         this._callFunObj[TYPE_MONTH] = this.monthLoadCallBack;
         this._callFunObj[TYPE_DAY] = this.dayLoadCallBack;
         this.client = new DevScoreImpl(ThriftClient.createClient(AllConst.URL_SCORE));
      }
      
      public function clearData() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:IJPGLoader = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:IJPGLoader = null;
         this._loadType = "";
         this._dataDay = null;
         this._dataMonth = null;
         this._dataAll = null;
         if(this._loadList != null)
         {
            _loc2_ = int(this._loadList.length);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc3_ = this._loadList[_loc1_] as IJPGLoader;
               if(_loc3_ != null)
               {
                  _loc5_ = int(this._loadPicArr.length);
                  _loc4_ = 0;
                  while(_loc4_ < _loc5_)
                  {
                     if(this._loadPicArr[_loc4_])
                     {
                        _loc6_ = this._loadPicArr[_loc4_].pic;
                        if(_loc6_ == _loc3_)
                        {
                           this._loadPicArr.splice(_loc4_,1);
                           break;
                        }
                     }
                     _loc4_++;
                  }
                  try
                  {
                     _loc3_.cancel();
                  }
                  catch(e:Error)
                  {
                  }
               }
               _loc1_++;
            }
            this._loadList = null;
         }
      }
      
      public function loadSortData(param1:String) : void
      {
         var _loc3_:Array = null;
         var _loc4_:Function = null;
         var _loc2_:Boolean = false;
         this._loadType = param1;
         switch(param1)
         {
            case TYPE_DAY:
               if(this._dataDay == null)
               {
                  _loc2_ = true;
               }
               else
               {
                  _loc3_ = this._dataDay;
               }
               break;
            case TYPE_MONTH:
               if(this._dataMonth == null)
               {
                  _loc2_ = true;
               }
               else
               {
                  _loc3_ = this._dataMonth;
               }
               break;
            case TYPE_ALL:
               if(this._dataAll == null)
               {
                  _loc2_ = true;
               }
               else
               {
                  _loc3_ = this._dataAll;
               }
         }
         if(_loc2_)
         {
            _loc4_ = this._callFunObj[this._loadType] as Function;
            this.logGetTop = new LogData(LogData.API_SCORE,"getTop");
            this.client.getTop(int(this._mainProxy.gameID),this._loadType,0,15,this.onGetError,_loc4_);
         }
         else
         {
            sendNotification(AllConst.MVC_SORT_RETURN,{
               "data":_loc3_,
               "type":this._loadType
            });
            this.loadPic(_loc3_);
         }
      }
      
      private function onGetError(param1:Error) : void
      {
         this.logGetTop.exception = param1.toString();
         this.logGetTop.submit();
         trace(param1.errorID,param1.message);
      }
      
      private function dayLoadCallBack(param1:ReturnScoreTop) : void
      {
         this.logGetTop.submit(true);
         this._getType = TYPE_DAY;
         this.loadDataCallBack(param1);
      }
      
      private function monthLoadCallBack(param1:ReturnScoreTop) : void
      {
         this.logGetTop.submit(true);
         this._getType = TYPE_MONTH;
         this.loadDataCallBack(param1);
      }
      
      private function allLoadCallBack(param1:ReturnScoreTop) : void
      {
         this.logGetTop.submit(true);
         this._getType = TYPE_ALL;
         this.loadDataCallBack(param1);
      }
      
      private function loadDataCallBack(param1:ReturnScoreTop) : void
      {
         var _loc5_:* = undefined;
         var _loc6_:OneScoreTop = null;
         var _loc7_:Array = null;
         var _loc2_:String = String(param1.code);
         if(_loc2_ != "10000")
         {
            sendNotification(AllConst.LOAD_SORT_DATA_ERROR,param1.message);
            return;
         }
         var _loc3_:Array = new Array();
         var _loc4_:Dictionary = param1.data;
         for(_loc5_ in _loc4_)
         {
            _loc6_ = _loc4_[_loc5_] as OneScoreTop;
            _loc7_ = new Array();
            _loc7_.push(String(_loc6_.uId));
            _loc7_.push(_loc6_.userName);
            _loc7_.push(_loc6_.score);
            _loc7_.push(_loc6_.area);
            _loc7_.push(_loc6_.time);
            _loc7_.push(_loc6_.rank);
            _loc3_.push(_loc7_);
         }
         if(_loc3_ == null || _loc3_.length <= 0)
         {
            sendNotification(AllConst.MVC_SORT_RETURN,{
               "data":null,
               "type":this._getType
            });
            return;
         }
         switch(this._getType)
         {
            case TYPE_DAY:
               this._dataDay = _loc3_;
               break;
            case TYPE_MONTH:
               this._dataMonth = _loc3_;
               break;
            case TYPE_ALL:
               this._dataAll = _loc3_;
         }
         sendNotification(AllConst.MVC_SORT_RETURN,{
            "data":_loc3_,
            "type":this._getType
         });
         this.loadPic(_loc3_);
      }
      
      public function getData() : Array
      {
         var _loc1_:Array = null;
         switch(this._loadType)
         {
            case TYPE_DAY:
               _loc1_ = this._dataDay;
               break;
            case TYPE_MONTH:
               _loc1_ = this._dataMonth;
               break;
            case TYPE_ALL:
               _loc1_ = this._dataAll;
         }
         return _loc1_;
      }
      
      private function loadPic(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:LoaderContext = null;
         var _loc8_:Array = null;
         var _loc9_:Object = null;
         var _loc10_:IJPGLoader = null;
         _loc3_ = int(param1.length);
         if(_loc3_ >= 15)
         {
            _loc3_ = 15;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = param1[_loc2_] as Array;
            if(_loc4_ != null)
            {
               _loc5_ = this.smallPortrait(_loc4_[0]);
               _loc9_ = this.findCachPic(_loc4_[0]);
               if(_loc9_.pic == null)
               {
                  if(_loc7_ == null)
                  {
                     _loc7_ = new LoaderContext(true);
                     Security.loadPolicyFile("https://a.img4399.com/crossdomain.xml");
                  }
                  _loc10_ = JPGLoadmanager.loadJPG(_loc5_,this.picLoadComplete,{
                     "type":this._loadType,
                     "uid":_loc4_[0]
                  },_loc7_,1);
                  if(this._loadList == null)
                  {
                     this._loadList = [];
                  }
                  this._loadList.push(_loc10_);
                  _loc9_.pic = _loc10_;
               }
               else if(_loc9_.pic != null)
               {
                  sendNotification(AllConst.UPDATA_SORT_PIC,{
                     "type":this._loadType,
                     "uid":_loc4_[0],
                     "pic":_loc9_.pic
                  });
               }
            }
            _loc2_++;
         }
      }
      
      private function picLoadComplete(param1:IJPGLoader, param2:Event, param3:Object) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Array = null;
         var _loc7_:String = null;
         var _loc8_:IJPGLoader = null;
         if(param2.type != Event.COMPLETE)
         {
            return;
         }
         if(param3 != null)
         {
            _loc5_ = int(this._loadList.length);
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               _loc8_ = this._loadList[_loc4_] as IJPGLoader;
               if(_loc8_ == param1)
               {
                  this._loadList.splice(_loc4_,1);
                  break;
               }
               _loc4_++;
            }
            sendNotification(AllConst.UPDATA_SORT_PIC,{
               "type":param3.type,
               "uid":param3.uid,
               "pic":param1
            });
         }
      }
      
      private function findCachPic(param1:String) : Object
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Object = null;
         if(this._loadPicArr == null)
         {
            this._loadPicArr = [];
            _loc4_ = {
               "uid":param1,
               "pic":null,
               "load":null
            };
            this._loadPicArr.push(_loc4_);
            return _loc4_;
         }
         _loc3_ = int(this._loadPicArr.length);
         if(_loc3_ <= 0)
         {
            _loc4_ = {
               "uid":param1,
               "pic":null,
               "load":null
            };
            this._loadPicArr.push(_loc4_);
            return _loc4_;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this._loadPicArr[_loc2_];
            if(_loc4_.uid == param1)
            {
               return _loc4_;
            }
            _loc2_++;
         }
         _loc4_ = {
            "uid":param1,
            "pic":null,
            "load":null
         };
         this._loadPicArr.push(_loc4_);
         return _loc4_;
      }
      
      private function delLoad() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
      }
      
      private function smallPortrait(param1:String) : String
      {
         return "https://a.img4399.com/" + (param1 == null ? "0" : param1) + "/small";
      }
   }
}

