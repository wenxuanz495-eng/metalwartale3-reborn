package ctrl4399.view
{
   import ctrl4399.proxy.ShopProxy;
   import ctrl4399.strconst.AllConst;
   import ctrl4399.view.components.ShopItemView;
   import flash.events.Event;
   import frame4399.simplePureMvc.core.Facade;
   import frame4399.simplePureMvc.core.Notification;
   import frame4399.simplePureMvc.interfaces.IMediator;
   import frame4399.simplePureMvc.mediator.Mediator;
   
   public class ShopItemMediator extends Mediator implements IMediator
   {
      
      private var shopItemView:ShopItemView;
      
      private var shopProxy:ShopProxy;
      
      private var _facade:Facade = Facade.getInstance();
      
      private var dataAry:Array;
      
      public function ShopItemMediator(param1:String, param2:Object)
      {
         super(param1);
         this.shopProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_SHOP) as ShopProxy;
      }
      
      override public function listNotificationInterests() : Array
      {
         return [AllConst.MVC_SHOP_SHOWITEM,AllConst.MVC_LOGOUT,AllConst.MVC_SHOP_MONEY,AllConst.MVC_SHOP_ERROR,AllConst.MVC_SHOP_DECMONEY];
      }
      
      override public function handleNotification(param1:Notification) : void
      {
         switch(param1.getName())
         {
            case AllConst.MVC_SHOP_SHOWITEM:
               this.dataAry = param1.getBody() as Array;
               this.openShopItemUi();
               this.shopProxy.getMoneyFun();
               break;
            case AllConst.MVC_LOGOUT:
               this.closeShopItemUi();
               break;
            case AllConst.MVC_SHOP_MONEY:
               if(this.shopItemView != null)
               {
                  this.shopItemView.canPayMoney = true;
                  this.shopItemView.changeMoneyFun(String(param1.getBody()));
               }
               break;
            case AllConst.MVC_SHOP_ERROR:
            case AllConst.MVC_SHOP_DECMONEY:
               if(this.shopItemView != null)
               {
                  this.shopItemView.canPayMoney = true;
                  this.shopItemView.showError(String(param1.getBody()));
               }
         }
      }
      
      private function openShopItemUi() : void
      {
         if(this.shopItemView != null)
         {
            this.shopItemView.start(this.dataAry);
            return;
         }
         this.shopItemView = new ShopItemView();
         this.shopItemView.addEventListener(AllConst.CLOSE_BTN_CLICK,this.closeShopItemUi,false,0,true);
         this.shopItemView.start(this.dataAry);
      }
      
      private function closeShopItemUi(param1:Event = null) : void
      {
         if(param1 == null)
         {
            if(this.shopItemView != null)
            {
               this.shopItemView.disPose();
            }
         }
         if(this.shopItemView != null)
         {
            this.shopItemView.removeEventListener(AllConst.CLOSE_BTN_CLICK,this.closeShopItemUi);
            this.shopItemView = null;
         }
         this.dataAry = [];
         this.dataAry = null;
         sendNotification(AllConst.MVC_CLOSE_PANEL,AllConst.CLOSE_SHOPITEM_WIN);
      }
   }
}

