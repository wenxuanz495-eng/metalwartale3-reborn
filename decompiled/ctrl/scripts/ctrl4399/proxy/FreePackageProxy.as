package ctrl4399.proxy
{
   import com.adobe.crypto.MD5;
   import ctrl4399.strconst.AllConst;
   import flash.events.Event;
   import flash.net.URLVariables;
   import frame4399.simplePureMvc.core.Facade;
   import frame4399.simplePureMvc.interfaces.IProxy;
   import frame4399.simplePureMvc.proxy.Proxy;
   import unit4399.events.ShopEvent;
   import unit4399.road.loader.LoaderManager;
   
   public class FreePackageProxy extends Proxy implements IProxy
   {
      
      public var realStage:*;
      
      private var mainProxy:MainProxy;
      
      private var _facade:Facade = Facade.getInstance();
      
      private var dataObj:Object;
      
      public function FreePackageProxy(param1:String = null)
      {
         super(param1);
         this.mainProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_MAIN) as MainProxy;
      }
      
      public function getFreePackageInfo(param1:Object) : void
      {
         var pacakgeData:Object = param1;
         if(pacakgeData == null)
         {
            if(this.realStage)
            {
               this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.FreePackage_Error_GetList));
            }
            return;
         }
         LoaderManager.loadBytes(AllConst.URL_GET_SHOP_TOKEN + "/?ran=" + 100000 * Math.random(),function(param1:Event):void
         {
            if(param1.type != Event.COMPLETE)
            {
               if(realStage)
               {
                  realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.FreePackage_Error_GetList));
               }
               return;
            }
            AllConst.SATAry.push(String(param1.target.data));
            var _loc2_:String = AllConst.SATAry.shift();
            var _loc3_:URLVariables = new URLVariables();
            _loc3_.gameid = mainProxy.gameID;
            _loc3_.ac = "free";
            _loc3_.type = String(pacakgeData.typeId);
            _loc3_.p = String(pacakgeData.curPage);
            _loc3_.show = String(pacakgeData.pageNum);
            _loc3_.token = _loc2_;
            _loc3_.verify = MD5.hash(MD5.hash(MD5.hash("SDALPlsldlnSLWPElsdslSE" + _loc3_.gameid + _loc3_.type + _loc3_.p + _loc3_.show + _loc3_.token + "PKslsO")));
            LoaderManager.loadBytes(AllConst.URL_GET_SHOP_INFO,getFreePackageInfoComplete,_loc3_);
         });
      }
      
      private function getFreePackageInfoComplete(param1:Event) : void
      {
         if(param1.type != Event.COMPLETE)
         {
            if(this.realStage)
            {
               this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.FreePackage_Error_GetList));
            }
            return;
         }
         var _loc2_:XML = XML(param1.target.data);
         if(_loc2_ == null)
         {
            if(this.realStage)
            {
               this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.FreePackage_Error_GetList));
            }
            return;
         }
         this.dataObj = new Object();
         this.analysisXmlFun(_loc2_);
      }
      
      private function analysisXmlFun(param1:XML) : void
      {
         var _loc5_:* = undefined;
         var _loc6_:Object = null;
         var _loc7_:XMLList = null;
         var _loc8_:XMLList = null;
         var _loc9_:Object = null;
         var _loc10_:* = undefined;
         var _loc11_:Object = null;
         var _loc12_:* = undefined;
         var _loc2_:XMLList = param1.items.item;
         var _loc3_:XMLList = param1.page;
         if(_loc2_ == null || _loc3_ == null)
         {
            if(this.realStage)
            {
               this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.FreePackage_Error_GetList));
            }
            return;
         }
         this.dataObj.cur = int(_loc3_.current);
         this.dataObj.total = int(_loc3_.total);
         var _loc4_:int = -1;
         for each(_loc5_ in _loc2_)
         {
            _loc4_++;
            _loc6_ = new Object();
            _loc6_.proId = String(_loc5_.id);
            _loc6_.title = String(_loc5_.title);
            _loc6_.price = String(_loc5_.price);
            _loc6_.description = String(_loc5_.description);
            _loc6_.thumb = String(_loc5_.thumb);
            _loc6_.infinite = String(_loc5_.infinite);
            _loc7_ = _loc5_.params.p;
            if(_loc7_ != null)
            {
               _loc9_ = new Object();
               for each(_loc10_ in _loc7_)
               {
                  _loc9_[_loc10_.@key] = String(_loc10_);
               }
               _loc6_.keys = _loc9_;
            }
            _loc8_ = _loc5_.params2.p;
            if(_loc8_ != null)
            {
               _loc11_ = new Object();
               for each(_loc12_ in _loc8_)
               {
                  _loc11_[_loc12_.@key] = String(_loc12_);
               }
               _loc6_.hideKeys = _loc11_;
            }
            this.dataObj["item" + _loc4_] = _loc6_;
         }
         this.dataObj.itemNum = _loc4_ + 1;
         if(this.realStage)
         {
            this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_GET_FREEPACKAGEINFO,this.dataObj));
         }
      }
   }
}

