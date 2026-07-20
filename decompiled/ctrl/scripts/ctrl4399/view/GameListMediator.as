package ctrl4399.view
{
   import ctrl4399.proxy.GameListProxy;
   import ctrl4399.proxy.gameListApi.FR_adItem;
   import ctrl4399.strconst.AllConst;
   import ctrl4399.view.components.GameListView;
   import flash.events.Event;
   import frame4399.simplePureMvc.core.Facade;
   import frame4399.simplePureMvc.core.Notification;
   import frame4399.simplePureMvc.interfaces.IMediator;
   import frame4399.simplePureMvc.mediator.Mediator;
   
   public class GameListMediator extends Mediator implements IMediator
   {
      
      private var app:WMCtrl;
      
      private var gameListView:GameListView;
      
      private var gameListProxy:GameListProxy;
      
      private var _facade:Facade = Facade.getInstance();
      
      public function GameListMediator(param1:String, param2:Object)
      {
         super(param1);
         this.gameListProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_GAMELIST) as GameListProxy;
         this.app = param2 as WMCtrl;
         this.gameListView = new GameListView();
      }
      
      override public function listNotificationInterests() : Array
      {
         return [AllConst.INIT_UI,AllConst.GETDATA_OK,AllConst.GET_AD_OK,AllConst.MVC_SHOW_GAMELIST,AllConst.LOAD_GAME_LIST_ERROR];
      }
      
      override public function handleNotification(param1:Notification) : void
      {
         var _loc2_:Array = null;
         var _loc3_:FR_adItem = null;
         var _loc4_:String = null;
         switch(param1.getName())
         {
            case AllConst.INIT_UI:
               this.gameListView.showBox();
               if(!this.gameListView.hasEventListener(AllConst.COLSE_PANEL_4399))
               {
                  this.gameListView.addEventListener(AllConst.COLSE_PANEL_4399,this.onClosePanelHandler);
               }
               break;
            case AllConst.GETDATA_OK:
               _loc2_ = param1.getBody() as Array;
               this.gameListView.showGameList(_loc2_);
               break;
            case AllConst.GET_AD_OK:
               _loc3_ = param1.getBody() as FR_adItem;
               this.gameListView.showAd(_loc3_.source,_loc3_.link);
               break;
            case AllConst.MVC_SHOW_GAMELIST:
               if(this.gameListView._isShow)
               {
                  return;
               }
               this.gameListView.showBox();
               _loc4_ = String(param1.getBody());
               this.gameListProxy.getGameListData(_loc4_);
               break;
            case AllConst.LOAD_GAME_LIST_ERROR:
               if(this.gameListView._isShow)
               {
                  this.gameListView.showError(param1.getBody() as String);
               }
         }
      }
      
      private function onClosePanelHandler(param1:Event) : void
      {
         if(this.gameListView.hasEventListener(AllConst.COLSE_PANEL_4399))
         {
            this.gameListView.removeEventListener(AllConst.COLSE_PANEL_4399,this.onClosePanelHandler);
         }
         this.gameListView.releaseRes();
         this._facade.sendNotification(AllConst.MVC_CLOSE_PANEL,AllConst.CLOSE_GAME_LIST_WIN);
      }
   }
}

