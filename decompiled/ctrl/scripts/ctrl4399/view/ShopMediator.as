package ctrl4399.view
{
   import ctrl4399.proxy.ShopProxy;
   import ctrl4399.strconst.AllConst;
   import ctrl4399.view.components.ShopView;
   import flash.events.DataEvent;
   import flash.events.Event;
   import frame4399.simplePureMvc.core.Facade;
   import frame4399.simplePureMvc.core.Notification;
   import frame4399.simplePureMvc.interfaces.IMediator;
   import frame4399.simplePureMvc.mediator.Mediator;
   
   public class ShopMediator extends Mediator implements IMediator
   {
      
      private var shopView:ShopView;
      
      private var shopProxy:ShopProxy;
      
      private var _facade:Facade = Facade.getInstance();
      
      private var p:String = "1";
      
      private var type:String = "0";
      
      private var isInit:Boolean = false;
      
      public function ShopMediator(param1:String, param2:Object)
      {
         super(param1);
         this.shopProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_SHOP) as ShopProxy;
      }
      
      override public function listNotificationInterests() : Array
      {
         return [AllConst.GET_SHOP_DATA,AllConst.MVC_LOGOUT,AllConst.MVC_SHOP_MONEY,AllConst.MVC_SHOP_ERROR,AllConst.MVC_SHOP_INFO,AllConst.MVC_SHOP_TYPE,AllConst.MVC_CLOSE_PANEL];
      }
      
      override public function handleNotification(param1:Notification) : void
      {
         var _loc2_:int = 0;
         switch(param1.getName())
         {
            case AllConst.GET_SHOP_DATA:
               this.isInit = true;
               this.shopProxy.getMoneyFun();
               break;
            case AllConst.MVC_SHOP_INFO:
               if(this.shopView != null)
               {
                  this.shopView.showPicItemFun(param1.getBody() as Array);
               }
               break;
            case AllConst.MVC_LOGOUT:
               this.closeShopUi();
               break;
            case AllConst.MVC_SHOP_MONEY:
               if(this.isInit)
               {
                  this.isInit = false;
                  this.openShopUi();
                  this.shopProxy.getShopInfoFun(this.p,this.type);
                  this.shopProxy.getTypeInfoFun();
               }
               if(this.shopView != null)
               {
                  this.shopView.canPayMoney = true;
                  this.shopView.changeMoneyFun(String(param1.getBody()));
               }
               break;
            case AllConst.MVC_SHOP_ERROR:
               if(this.shopView != null && this.shopView.curItme == -1)
               {
                  this.shopView.canPayMoney = true;
                  this.shopView.showError(String(param1.getBody()));
               }
               break;
            case AllConst.MVC_SHOP_TYPE:
               if(this.shopView != null)
               {
                  this.shopView.setTypeFun(param1.getBody() as Array);
               }
               break;
            case AllConst.MVC_CLOSE_PANEL:
               _loc2_ = int(param1.getBody());
               if(this.shopView != null && _loc2_ == AllConst.CLOSE_SHOPITEM_WIN)
               {
                  this.shopView.curItme = -1;
               }
         }
      }
      
      private function openShopUi() : void
      {
         if(this.shopView != null)
         {
            return;
         }
         this.shopView = new ShopView();
         this.shopView.addEventListener(AllConst.CLOSE_BTN_CLICK,this.closeShopUi,false,0,true);
         this.shopView.addEventListener("changeShopType",this.getShopPicInfo,false,0,true);
         this.shopView.addEventListener("changeShopPage",this.getShopPicInfo,false,0,true);
         this.shopView.start();
      }
      
      private function getShopPicInfo(param1:DataEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:Array = null;
         switch(param1.type)
         {
            case "changeShopType":
               this.type = this.getTypeFun(int(param1.data));
               this.shopProxy.getShopInfoFun(this.p,this.type);
               break;
            case "changeShopPage":
               _loc2_ = String(param1.data);
               if(_loc2_ == null || _loc2_ == "")
               {
                  return;
               }
               _loc3_ = _loc2_.split(",");
               if(_loc3_ == null || _loc3_.length < 2)
               {
                  return;
               }
               this.type = this.getTypeFun(int(_loc3_[1]));
               this.shopProxy.getShopInfoFun(_loc3_[0],this.type);
         }
      }
      
      private function getTypeFun(param1:int) : String
      {
         var _loc2_:Array = this.shopProxy.typeAry;
         if(_loc2_ == null)
         {
            return "";
         }
         var _loc3_:Object = _loc2_[param1];
         if(_loc3_ == null || _loc3_.id == undefined)
         {
            return "";
         }
         return String(_loc3_.id);
      }
      
      private function closeShopUi(param1:Event = null) : void
      {
         this.p = "1";
         this.type = "0";
         this.isInit = false;
         if(param1 == null)
         {
            if(this.shopView != null)
            {
               this.shopView.disPose();
            }
         }
         if(this.shopView != null)
         {
            this.shopView.removeEventListener("changeShopType",this.getShopPicInfo);
            this.shopView.removeEventListener("changeShopPage",this.getShopPicInfo);
            this.shopView.removeEventListener(AllConst.CLOSE_BTN_CLICK,this.closeShopUi);
            this.shopView = null;
         }
         if(this.shopProxy == null)
         {
            this.shopProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_SHOP) as ShopProxy;
         }
         this.shopProxy.clearData();
         sendNotification(AllConst.MVC_CLOSE_PANEL,AllConst.CLOSE_SHOP_WIN);
      }
   }
}

