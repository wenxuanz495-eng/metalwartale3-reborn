package ctrl4399.proxy
{
   import com.adobe.crypto.MD5;
   import ctrl4399.proxy.shopApi.Err_Store;
   import ctrl4399.proxy.shopApi.FlashStoreApiImpl;
   import ctrl4399.proxy.shopApi.Head;
   import ctrl4399.proxy.shopApi.PropInfo;
   import ctrl4399.proxy.shopApi.RES_BuyData;
   import ctrl4399.proxy.shopApi.RES_PropList;
   import ctrl4399.proxy.shopApi.Sole_BuyData;
   import ctrl4399.proxy.shopApi.Sole_PropList;
   import ctrl4399.strconst.AllConst;
   import frame4399.simplePureMvc.core.Facade;
   import frame4399.simplePureMvc.interfaces.IProxy;
   import frame4399.simplePureMvc.proxy.Proxy;
   import unit4399.events.ShopEvent;
   
   public class ShopNdProxy extends Proxy implements IProxy
   {
      
      private var mainProxy:MainProxy;
      
      private var _facade:Facade = Facade.getInstance();
      
      private var client:FlashStoreApiImpl;
      
      public var realStage:*;
      
      private var logGetPropList:LogData;
      
      private var logBuyProp:LogData;
      
      public function ShopNdProxy(param1:String = null)
      {
         super(param1);
         this.mainProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_MAIN) as MainProxy;
      }
      
      private function head(param1:int = -1, param2:int = 0, param3:String = "") : Head
      {
         var _loc5_:String = null;
         var _loc4_:Head = new Head();
         _loc4_.gameId = this.mainProxy.gameID;
         _loc4_.uId = this.mainProxy.userID;
         _loc4_.index = param1;
         if(param1 == -1)
         {
            _loc5_ = MD5.hash(MD5.hash(MD5.hash("KLSDJFEHkkdjjsKJ" + _loc4_.gameId + _loc4_.uId + _loc4_.index + "4399XIAMEN")));
         }
         else
         {
            _loc5_ = MD5.hash(MD5.hash(MD5.hash("KLSDJFEHkkdjjsKJ" + _loc4_.gameId + _loc4_.uId + _loc4_.index + param2 + param3 + "4399XIAMEN")));
         }
         _loc4_.verify = _loc5_;
         return _loc4_;
      }
      
      private function errorObj(param1:String, param2:String) : Object
      {
         var _loc3_:Object = new Object();
         _loc3_.eId = param1;
         _loc3_.msg = param2;
         return _loc3_;
      }
      
      public function getShopList() : void
      {
         if(!AllConst.MODE_OBJECT[AllConst.MODE_NAME_SHOP])
         {
            this.eFun(this.errorObj("90002","没有添加商城API的KEY！"));
            return;
         }
         this.client = new FlashStoreApiImpl(ThriftClient.createClient(AllConst.URL_SHOP));
         try
         {
            this.logGetPropList = new LogData(LogData.API_SHOP,"getPropList");
            this.client.getPropList(this.head(),function(param1:*):*
            {
               if(param1 is Err_Store)
               {
                  eFun(errorObj(String(param1.code),param1.msg));
                  logGetPropList.exception = param1.msg;
               }
               else
               {
                  eFun(errorObj(String(param1.errorID),param1.message));
                  logGetPropList.exception = param1.message;
               }
               logGetPropList.submit();
            },function(param1:RES_PropList):*
            {
               var _loc3_:* = undefined;
               var _loc4_:Sole_PropList = null;
               var _loc5_:Object = null;
               var _loc6_:Object = null;
               logGetPropList.submit(true);
               var _loc2_:Array = param1.data as Array;
               if(_loc2_ == null)
               {
                  eFun(errorObj("80001","取物品列表出错了！"));
                  return;
               }
               for(_loc3_ in _loc2_)
               {
                  _loc4_ = _loc2_[_loc3_] as Sole_PropList;
                  _loc5_ = new Object();
                  _loc5_.propId = String(_loc4_.id);
                  _loc5_.price = int(_loc4_.price);
                  _loc5_.propType = String(_loc4_.type);
                  _loc6_ = null;
                  if(_loc4_.isSetActionInfo() && _loc4_.actionInfo.isSetType())
                  {
                     _loc6_ = new Object();
                     _loc6_.type = _loc4_.actionInfo.type;
                     _loc6_.state = _loc4_.actionInfo.state;
                     _loc6_.count = _loc4_.actionInfo.count;
                     _loc6_.surplusCount = _loc4_.actionInfo.surplusCount;
                     _loc6_.startDate = _loc4_.actionInfo.startDate;
                     _loc6_.endDate = _loc4_.actionInfo.endDate;
                     _loc6_.discount = _loc4_.actionInfo.rate;
                     _loc6_.regularPrice = _loc4_.actionInfo.nativePrice;
                  }
                  _loc5_.propAction = _loc6_;
                  _loc2_[_loc3_] = _loc5_;
               }
               sFun(ShopEvent.SHOP_GET_LIST,_loc2_);
            });
         }
         catch(e:Error)
         {
            eFun(errorObj(String(e.errorID),e.message));
         }
      }
      
      public function buyPropNd(param1:Object) : void
      {
         var propInfo:PropInfo = null;
         var dataObj:Object = param1;
         if(!AllConst.MODE_OBJECT[AllConst.MODE_NAME_SHOP])
         {
            this.eFun(this.errorObj("90002","没有添加商城API的KEY！"));
            return;
         }
         if(dataObj == null || dataObj.propId == undefined || dataObj.count == undefined || dataObj.price == undefined || dataObj.idx == undefined)
         {
            this.eFun(this.errorObj("90003","购买的物品数据不完善！"));
            return;
         }
         if(!(dataObj.propId is String) || !(dataObj.count is int) || !(dataObj.price is int) || !(dataObj.idx is int) || Boolean(dataObj.tag) && Boolean(!(dataObj.tag is String)))
         {
            this.eFun(this.errorObj("90005","购买的物品数据类型有误！"));
            return;
         }
         if(int(dataObj.count) <= 0)
         {
            this.eFun(this.errorObj("90004","购买的物品数量须至少1个！"));
            return;
         }
         if(int(dataObj.idx) < 0 || int(dataObj.idx) > 7)
         {
            this.eFun(this.errorObj("90001","传的索引值有问题！"));
            return;
         }
         this.client = new FlashStoreApiImpl(ThriftClient.createClient(AllConst.URL_SHOP));
         try
         {
            propInfo = new PropInfo();
            propInfo.propId = String(dataObj.propId);
            propInfo.propCount = int(dataObj.count);
            propInfo.propPrice = int(dataObj.price);
            propInfo.tag = String(dataObj.tag);
            this.logBuyProp = new LogData(LogData.API_SHOP,"buyProp");
            this.client.buyProp(this.head(int(dataObj.idx),int(dataObj.count),String(dataObj.propId)),propInfo,function(param1:*):*
            {
               if(param1 is Err_Store)
               {
                  eFun(errorObj(String(param1.code),param1.msg));
               }
               else
               {
                  eFun(errorObj(String(param1.errorID),param1.message));
                  logBuyProp.exception = param1.message;
                  logBuyProp.submit();
               }
            },function(param1:RES_BuyData):*
            {
               logBuyProp.submit(true);
               var _loc2_:Sole_BuyData = param1.data as Sole_BuyData;
               var _loc3_:Object = new Object();
               _loc3_.propId = String(_loc2_.propId);
               _loc3_.count = int(_loc2_.count);
               _loc3_.balance = int(_loc2_.remaining);
               _loc3_.tag = String(_loc2_.tag);
               sFun(ShopEvent.SHOP_BUY_ND,_loc3_);
            });
         }
         catch(e:Error)
         {
            eFun(errorObj(String(e.errorID),e.message));
         }
      }
      
      private function eFun(param1:Object) : void
      {
         if(this.realStage)
         {
            this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR_ND,param1));
         }
         this.client = null;
      }
      
      private function sFun(param1:String, param2:Object) : void
      {
         if(this.realStage == null)
         {
            return;
         }
         this.realStage.dispatchEvent(new ShopEvent(param1,param2));
         this.client = null;
      }
   }
}

