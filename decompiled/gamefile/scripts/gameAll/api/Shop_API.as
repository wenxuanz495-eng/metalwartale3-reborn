package gameAll.api
{
   import com.adobe.serialization.json.JSON2;
   import flash.display.Stage;
   import unit4399.events.ShopEvent;
   
   public class Shop_API
   {
      
      public var yesFun:Function = null;
      
      public var noFun:Function = null;
      
      public var nowObj:* = null;
      
      public function Shop_API()
      {
         super();
      }
      
      public function init(stage0:Stage) : *
      {
         stage0.addEventListener(ShopEvent.SHOP_ERROR_ND,this.onShopEventHandler);
         stage0.addEventListener(ShopEvent.SHOP_BUY_ND,this.onShopEventHandler);
         stage0.addEventListener(ShopEvent.SHOP_GET_LIST,this.onShopEventHandler);
      }
      
      public function buyPropNd(obj0:ShopBuyObject, _yesFun:Function = null, _noFun:Function = null) : *
      {
         if(Game.save_api.isLocal())
         {
            Game.payController.decMCoin(obj0.price * obj0.count,_yesFun,_noFun);
            return;
         }
         obj0.idx = Game.nowSaveIndex;
         this.yesFun = _yesFun;
         this.noFun = _noFun;
         if(this.noFun == null)
         {
            this.noFun = this.test_noFun;
         }
         Game.testText.addTestText("开始购买：" + JSON2.encode(obj0));
         if(Boolean(Game.serviceHold))
         {
            Game.loadingUI.show();
            this.nowObj = obj0;
            Game.payController.getStoreState(this.affter_buyPropNd);
         }
         else if(this.noFun is Function)
         {
            this.noFun("网络错误！");
         }
      }
      
      public function affter_buyPropNd() : *
      {
         Game.serviceHold.buyPropNd(this.nowObj);
      }
      
      private function test_noFun(str0:String) : *
      {
         Game.uiGroup.checkTip.showCheck2(str0,2,null,null,2);
      }
      
      public function fleshMCoin(mcoin0:Number) : *
      {
         Game.payController.fleshMCoin(mcoin0);
      }
      
      private function onShopEventHandler(evt:ShopEvent) : void
      {
         var obj0:Object = evt.data;
         switch(evt.type)
         {
            case ShopEvent.SHOP_ERROR_ND:
               Game.loadingUI.hide();
               Game.testText.addTestText("eId:" + obj0.eId + "  message:" + obj0.msg + "\n");
               if(this.noFun is Function)
               {
                  this.noFun(obj0.msg);
               }
               break;
            case ShopEvent.SHOP_BUY_ND:
               Game.loadingUI.hide();
               Game.testText.addTestText("购买成功：" + JSON2.encode(obj0));
               this.fleshMCoin(obj0.balance);
               if(this.yesFun is Function)
               {
                  this.yesFun();
               }
               Game.uiGroup.saveDataNoUI();
               break;
            case ShopEvent.SHOP_GET_LIST:
         }
      }
   }
}

