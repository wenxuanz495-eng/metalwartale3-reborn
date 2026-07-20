package ctrl4399.proxy
{
   import ctrl4399.proxy.gameListApi.FR_adItem;
   import ctrl4399.proxy.gameListApi.FR_rcmdItem;
   import ctrl4399.proxy.gameListApi.FlashRcmdImpl;
   import ctrl4399.strconst.AllConst;
   import frame4399.simplePureMvc.core.Facade;
   import frame4399.simplePureMvc.interfaces.IProxy;
   import frame4399.simplePureMvc.proxy.Proxy;
   
   public class GameListProxy extends Proxy implements IProxy
   {
      
      private var _dataAry:Array;
      
      private var _facade:Facade = Facade.getInstance();
      
      private var mainProxy:MainProxy;
      
      private var client:FlashRcmdImpl;
      
      private var _changeFlag:Boolean = false;
      
      private var logRecommend:LogData;
      
      public function GameListProxy(param1:String = null)
      {
         super(param1);
         this.mainProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_MAIN) as MainProxy;
         this.client = new FlashRcmdImpl(ThriftClient.createClient(AllConst.URL_GAME_LIST));
      }
      
      public function getGameListData(param1:String, param2:Boolean = false) : void
      {
         this._changeFlag = param2;
         var _loc3_:int = int(param1);
         if(!this._changeFlag)
         {
            this.getAdData(_loc3_);
         }
         this._facade.sendNotification(AllConst.INIT_UI);
         if(this.mainProxy != null && !isNaN(Number(param1)))
         {
            this.logRecommend = new LogData(LogData.API_RECOMMEND,"getGameList");
            this.client.recommend(_loc3_,this.onGameListError,this.onGameListLoaded);
         }
      }
      
      public function getAdData(param1:int) : *
      {
         this.client.getAd(param1,this.onAdError,this.onAdSuccess);
      }
      
      private function onAdSuccess(param1:FR_adItem) : void
      {
         var _loc2_:FR_adItem = param1;
         sendNotification(AllConst.GET_AD_OK,_loc2_);
      }
      
      private function onAdError(param1:Error) : void
      {
         var _loc2_:FR_adItem = new FR_adItem();
         _loc2_.source = AllConst.URL_GAME_LIST_DEFAULT_AD;
         _loc2_.link = "";
         sendNotification(AllConst.GET_AD_OK,_loc2_);
      }
      
      private function onGameListLoaded(param1:Array) : void
      {
         var _loc2_:FR_rcmdItem = null;
         var _loc3_:Object = null;
         this.logRecommend.submit(true);
         this._dataAry = [];
         if(param1.length == 0)
         {
            sendNotification(AllConst.LOAD_GAME_LIST_ERROR,"数据请求异常！");
            return;
         }
         for each(_loc2_ in param1)
         {
            _loc3_ = new Object();
            _loc3_.gameName = _loc2_.gameName;
            _loc3_.picUrl = _loc2_.gameImgUrl;
            _loc3_.linkUrl = AllConst.URL_GAME_LIST_AD_REDICT + "&r=" + this.mainProxy.gameID + "&g=" + _loc2_.gameId;
            this._dataAry.push(_loc3_);
         }
         sendNotification(AllConst.GETDATA_OK,this.dataAry);
      }
      
      private function onGameListError(param1:Error) : void
      {
         this.logRecommend.exception = param1.toString();
         this.logRecommend.submit();
         sendNotification(AllConst.LOAD_GAME_LIST_ERROR,"数据请求异常！");
      }
      
      public function get dataAry() : Array
      {
         if(this._dataAry == null)
         {
            this._dataAry = [];
         }
         return this._dataAry;
      }
   }
}

