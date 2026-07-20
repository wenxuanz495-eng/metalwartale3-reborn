package ctrl4399.proxy
{
   import com.adobe.crypto.MD5;
   import com.adobe.serialization.json.JSON;
   import ctrl4399.strconst.AllConst;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import frame4399.simplePureMvc.core.Facade;
   import frame4399.simplePureMvc.interfaces.IProxy;
   import frame4399.simplePureMvc.proxy.Proxy;
   import unit4399.events.PayEvent;
   import unit4399.events.ShopEvent;
   import unit4399.road.loader.LoaderManager;
   
   public class ShopProxy extends Proxy implements IProxy
   {
      
      public var realStage:*;
      
      private var mainProxy:MainProxy;
      
      private var _facade:Facade = Facade.getInstance();
      
      private var dataAry:Array;
      
      public var typeAry:Array;
      
      private var itemObj:Object;
      
      public var payMoney:int = 1;
      
      private var exStr:String = "";
      
      private var exAry:Array;
      
      private var isOpenUi:Boolean = false;
      
      private var isOpenUi_buy:Boolean = false;
      
      public function ShopProxy(param1:String = null)
      {
         super(param1);
         this.mainProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_MAIN) as MainProxy;
      }
      
      public function getMoneyFun() : void
      {
         if(this.realStage)
         {
            this.realStage.addEventListener(PayEvent.GET_MONEY,this.onPayHandler,false,0,true);
            this.realStage.addEventListener(PayEvent.DEC_MONEY,this.onPayHandler,false,0,true);
            this.realStage.addEventListener(PayEvent.INC_MONEY,this.onPayHandler,false,0,true);
            this.realStage.addEventListener(PayEvent.PAY_ERROR,this.onPayHandler,false,0,true);
            this.realStage.addEventListener(PayEvent.PAY_MONEY,this.onPayHandler,false,0,true);
         }
         this.mainProxy.getMoneyFun();
      }
      
      public function getPayPacInfoFun(param1:Object) : void
      {
         if(param1 == null)
         {
            if(this.realStage)
            {
               this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.PayPackage_Error_GetList));
            }
            return;
         }
         this.getShopInfoFun(String(param1.curPage),String(param1.typeId),String(param1.pageNum));
         this.getTypeInfoFun();
      }
      
      public function getShopInfoFun(param1:String, param2:String, param3:String = "") : void
      {
         var p:String = param1;
         var type:String = param2;
         var showNum:String = param3;
         if(showNum == "")
         {
            this.isOpenUi = true;
            showNum = "8";
         }
         else
         {
            this.isOpenUi = false;
         }
         LoaderManager.loadBytes(AllConst.URL_GET_SHOP_TOKEN + "/?ran=" + 100000 * Math.random(),function(param1:Event):void
         {
            if(param1.type != Event.COMPLETE)
            {
               if(isOpenUi)
               {
                  sendNotification(AllConst.MVC_SHOP_ERROR,"获取商城物品信息失败");
               }
               else if(realStage)
               {
                  realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.PayPackage_Error_GetList));
               }
               return;
            }
            AllConst.SATAry.push(String(param1.target.data));
            var _loc2_:String = AllConst.SATAry.shift();
            var _loc3_:URLVariables = new URLVariables();
            _loc3_.gameid = mainProxy.gameID;
            trace("分类----" + type);
            _loc3_.type = type;
            _loc3_.p = p;
            _loc3_.show = showNum;
            _loc3_.token = _loc2_;
            _loc3_.verify = MD5.hash(MD5.hash(MD5.hash("SDALPlsldlnSLWPElsdslSE" + _loc3_.gameid + type + p + showNum + _loc3_.token + "PKslsO")));
            LoaderManager.loadBytes(AllConst.URL_GET_SHOP_INFO,getShopInfoComplete,_loc3_);
         });
      }
      
      private function getShopInfoComplete(param1:Event) : void
      {
         if(param1.type != Event.COMPLETE)
         {
            if(this.isOpenUi)
            {
               sendNotification(AllConst.MVC_SHOP_ERROR,"获取商城物品信息失败");
            }
            else if(this.realStage)
            {
               this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.PayPackage_Error_GetList));
            }
            return;
         }
         var _loc2_:XML = XML(param1.target.data);
         if(_loc2_ == null)
         {
            if(this.isOpenUi)
            {
               sendNotification(AllConst.MVC_SHOP_ERROR,"获取商城物品信息失败");
            }
            else if(this.realStage)
            {
               this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.PayPackage_Error_GetList));
            }
            return;
         }
         this.dataAry = [];
         this.analysisXmlFun(_loc2_);
      }
      
      private function analysisXmlFun(param1:XML) : void
      {
         var _loc5_:* = undefined;
         var _loc6_:Object = null;
         var _loc7_:XMLList = null;
         var _loc8_:XMLList = null;
         var _loc9_:Array = null;
         var _loc10_:* = undefined;
         var _loc11_:Object = null;
         var _loc12_:Array = null;
         var _loc13_:* = undefined;
         var _loc14_:Object = null;
         var _loc2_:XMLList = param1.items.item;
         var _loc3_:XMLList = param1.page;
         if(_loc2_ == null || _loc3_ == null)
         {
            if(this.isOpenUi)
            {
               sendNotification(AllConst.MVC_SHOP_ERROR,"获取商城物品信息失败");
            }
            else if(this.realStage)
            {
               this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.PayPackage_Error_GetList));
            }
            return;
         }
         var _loc4_:Object = new Object();
         _loc4_.cur = int(_loc3_.current);
         _loc4_.total = int(_loc3_.total);
         this.dataAry[_loc4_.cur - 1] = [];
         this.dataAry[_loc4_.cur - 1][0] = _loc4_;
         for each(_loc5_ in _loc2_)
         {
            _loc6_ = new Object();
            _loc6_.id = String(_loc5_.id);
            _loc6_.title = String(_loc5_.title);
            _loc6_.price = String(_loc5_.price);
            _loc6_.description = String(_loc5_.description);
            _loc6_.thumb = String(_loc5_.thumb);
            _loc6_.infinite = String(_loc5_.infinite);
            _loc7_ = _loc5_.params.p;
            if(_loc7_ != null)
            {
               _loc9_ = new Array();
               for each(_loc10_ in _loc7_)
               {
                  _loc11_ = new Object();
                  _loc11_["proName"] = String(_loc10_.@key);
                  _loc11_["proValue"] = String(_loc10_);
                  _loc9_.push(_loc11_);
               }
               _loc6_.keys = _loc9_;
            }
            _loc8_ = _loc5_.params2.p;
            if(_loc8_ != null)
            {
               _loc12_ = new Array();
               for each(_loc13_ in _loc8_)
               {
                  _loc14_ = new Object();
                  _loc14_["proName"] = String(_loc13_.@key);
                  _loc14_["proValue"] = String(_loc13_);
                  _loc12_.push(_loc14_);
               }
               _loc6_.hideKeys = _loc12_;
            }
            this.dataAry[_loc4_.cur - 1].push(_loc6_);
         }
         if(this.isOpenUi)
         {
            sendNotification(AllConst.MVC_SHOP_INFO,this.dataAry[_loc4_.cur - 1]);
         }
         else if(this.realStage)
         {
            this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_GET_PAYPACKAGEINFO,this.dataAry[_loc4_.cur - 1]));
         }
      }
      
      public function getTypeInfoFun() : void
      {
         LoaderManager.loadBytes(AllConst.URL_GET_SHOP_TOKEN + "/?ran=" + 100000 * Math.random(),function(param1:Event):void
         {
            if(param1.type != Event.COMPLETE)
            {
               if(isOpenUi)
               {
                  sendNotification(AllConst.MVC_SHOP_ERROR,"获取物品分类及公告失败");
               }
               else if(realStage)
               {
                  realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Shop_Error_TypeNotice));
               }
               return;
            }
            AllConst.SATAry.push(String(param1.target.data));
            var _loc2_:String = AllConst.SATAry.shift();
            var _loc3_:URLVariables = new URLVariables();
            _loc3_.gameid = mainProxy.gameID;
            _loc3_.token = _loc2_;
            _loc3_.verify = MD5.hash(MD5.hash(MD5.hash("SDALPlsldlnSLWPElsdslSE" + _loc3_.gameid + _loc3_.token + "PKslsO")));
            LoaderManager.loadBytes(AllConst.URL_GET_SHOP_TYPE,getShopTypeComplete,_loc3_);
         });
      }
      
      private function getShopTypeComplete(param1:Event) : void
      {
         var _loc6_:Array = null;
         var _loc7_:* = undefined;
         var _loc8_:Object = null;
         if(param1.type != Event.COMPLETE)
         {
            if(this.isOpenUi)
            {
               sendNotification(AllConst.MVC_SHOP_ERROR,"获取物品分类及公告失败");
            }
            else if(this.realStage)
            {
               this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Shop_Error_TypeNotice));
            }
            return;
         }
         var _loc2_:XML = XML(param1.target.data);
         if(_loc2_ == null)
         {
            if(this.isOpenUi)
            {
               sendNotification(AllConst.MVC_SHOP_ERROR,"获取物品分类及公告失败");
            }
            else if(this.realStage)
            {
               this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Shop_Error_TypeNotice));
            }
            return;
         }
         var _loc3_:String = _loc2_.notice;
         this.payMoney = _loc2_.money;
         var _loc4_:XMLList = new XMLList(_loc2_.types.t);
         this.typeAry = [];
         if(_loc4_)
         {
            _loc6_ = [];
            for each(_loc7_ in _loc4_)
            {
               _loc8_ = new Object();
               _loc8_.id = String(_loc7_.@id);
               _loc8_.label = _loc7_.toString();
               _loc6_.push(_loc8_.label);
               this.typeAry.push(_loc8_);
            }
         }
         var _loc5_:Array = this.copyObj(this.typeAry) as Array;
         if(this.isOpenUi)
         {
            sendNotification(AllConst.MVC_SHOP_TYPE,[_loc3_,this.payMoney,_loc6_]);
         }
         else if(this.realStage)
         {
            this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_GET_TYPENOTICE,[_loc3_,_loc5_]));
         }
      }
      
      public function set _exAry(param1:Array) : void
      {
         this.exAry = param1;
      }
      
      public function buyProFun(param1:Array, param2:Boolean = true) : void
      {
         var exObj:Object;
         var h:int = 0;
         var ary:Array = param1;
         var tmpIsOpenUi:Boolean = param2;
         this.isOpenUi_buy = tmpIsOpenUi;
         if(ary == null || ary.length != 2 || int(ary[0]) <= 0 || String(ary[1]) == "")
         {
            if(this.isOpenUi_buy)
            {
               sendNotification(AllConst.MVC_SHOP_ERROR,"购买物品失败！");
            }
            else if(this.realStage)
            {
               this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Shop_Error_Buy));
            }
            return;
         }
         exObj = new Object();
         exObj.proId = ary[1];
         if(this.realStage != null)
         {
            this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_UPDATE_EXTEND,exObj));
         }
         if(this.exAry != null)
         {
            if(this.exAry.length != 4)
            {
               this.exAry = null;
               if(this.isOpenUi_buy)
               {
                  sendNotification(AllConst.MVC_SHOP_ERROR,"设置扩展字段出错了！");
               }
               else if(this.realStage)
               {
                  this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Shop_Error_SetEx));
               }
               return;
            }
            h = 0;
            while(h < 4)
            {
               if(!(this.exAry[h] is int))
               {
                  this.exAry = null;
                  if(this.isOpenUi_buy)
                  {
                     sendNotification(AllConst.MVC_SHOP_ERROR,"设置扩展字段出错了！");
                  }
                  else if(this.realStage)
                  {
                     this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Shop_Error_SetEx));
                  }
                  return;
               }
               h++;
            }
            try
            {
               this.exStr = com.adobe.serialization.json.JSON.encode(this.exAry);
            }
            catch(e:*)
            {
               trace("shopProxy Json转换出错");
               exAry = null;
               if(isOpenUi_buy)
               {
                  sendNotification(AllConst.MVC_SHOP_ERROR,"设置扩展字段出错了！");
               }
               else if(realStage)
               {
                  realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Shop_Error_SetEx));
               }
               return;
            }
         }
         else
         {
            this.exStr = "";
         }
         this.exAry = null;
         LoaderManager.loadBytes(AllConst.URL_GET_SHOP_TOKEN + "/?ran=" + 100000 * Math.random(),function(param1:Event):void
         {
            if(param1.type != Event.COMPLETE)
            {
               if(isOpenUi_buy)
               {
                  sendNotification(AllConst.MVC_SHOP_ERROR,"购买物品失败！");
               }
               else if(realStage)
               {
                  realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Shop_Error_Buy));
               }
               return;
            }
            AllConst.SATAry.push(String(param1.target.data));
            var _loc2_:String = AllConst.SATAry.shift();
            var _loc3_:URLVariables = new URLVariables();
            _loc3_.gameid = mainProxy.gameID;
            _loc3_.uid = mainProxy.userID;
            _loc3_.toolid = ary[1];
            _loc3_.count = ary[0];
            _loc3_.extend = exStr;
            _loc3_.token = _loc2_;
            _loc3_.verify = MD5.hash(MD5.hash(MD5.hash("SDALPlsldlnSLWPElsdslSE" + _loc3_.gameid + _loc3_.uid + _loc3_.toolid + _loc3_.count + _loc3_.extend + _loc3_.token + "PKslsO")));
            LoaderManager.loadBytes(AllConst.URL_GET_SHOP_ADD,addProComplete,_loc3_);
         });
      }
      
      private function addProComplete(param1:Event) : void
      {
         var _loc4_:Object = null;
         var _loc5_:String = null;
         var _loc6_:Object = null;
         if(param1.type != Event.COMPLETE)
         {
            if(this.isOpenUi_buy)
            {
               sendNotification(AllConst.MVC_SHOP_ERROR,"购买物品失败！");
            }
            else if(this.realStage)
            {
               this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Shop_Error_Buy));
            }
            return;
         }
         var _loc2_:String = String(param1.target.data);
         var _loc3_:Array = _loc2_.split("|");
         if(_loc3_[0] == undefined)
         {
            if(this.isOpenUi_buy)
            {
               sendNotification(AllConst.MVC_SHOP_ERROR,"购买物品失败！");
            }
            else if(this.realStage)
            {
               this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Shop_Error_Buy));
            }
            return;
         }
         if(!this.isOpenUi_buy)
         {
            if(this.realStage == null)
            {
               return;
            }
            if(String(_loc3_[0]) == AllConst.ADDPRO_SUCCESS)
            {
               _loc4_ = new Object();
               _loc4_.balance = String(_loc3_[1]);
               this.realStage.dispatchEvent(new PayEvent(PayEvent.DEC_MONEY,_loc4_));
               this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ADD_SUCC));
            }
            else if(_loc3_[1] != undefined && String(_loc3_[1]) != "")
            {
               _loc5_ = AllConst.Shop_Buy_Head + _loc2_;
               this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,_loc5_));
            }
            else
            {
               this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Shop_Error_Buy));
            }
            return;
         }
         if(String(_loc3_[0]) == AllConst.ADDPRO_SUCCESS)
         {
            sendNotification(AllConst.MVC_SHOP_MONEY,String(_loc3_[1]));
            sendNotification(AllConst.MVC_SHOP_DECMONEY,AllConst.ADDPRO_SUCCESS);
            _loc6_ = new Object();
            _loc6_.balance = String(_loc3_[1]);
            if(this.realStage != null)
            {
               this.realStage.dispatchEvent(new PayEvent(PayEvent.DEC_MONEY,_loc6_));
               this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ADD_SUCC));
            }
         }
         else
         {
            if(String(_loc3_[0]) == AllConst.NO_Enough_Money)
            {
               sendNotification(AllConst.MVC_SHOP_ERROR,AllConst.NO_Enough_Money);
               return;
            }
            if(_loc3_[1] != undefined && String(_loc3_[1]) != "")
            {
               sendNotification(AllConst.MVC_SHOP_ERROR,String(_loc3_[1]));
            }
            else
            {
               sendNotification(AllConst.MVC_SHOP_ERROR,"购买物品失败！");
            }
         }
      }
      
      private function onPayHandler(param1:PayEvent) : void
      {
         var _loc2_:String = null;
         switch(param1.type)
         {
            case PayEvent.DEC_MONEY:
            case PayEvent.INC_MONEY:
            case PayEvent.GET_MONEY:
               if(param1.data !== null && !(param1.data is Boolean))
               {
                  _loc2_ = String(param1.data.balance);
                  trace("获取游戏币余额为：" + _loc2_);
                  sendNotification(AllConst.MVC_SHOP_MONEY,_loc2_);
                  break;
               }
               trace("获取游戏币余额错误！");
               sendNotification(AllConst.MVC_SHOP_ERROR,"获取游戏币余额错误！");
               break;
            case PayEvent.PAY_ERROR:
               if(param1.data == null)
               {
                  break;
               }
               trace("使用支付接口其他错误----->" + param1.data.info);
               sendNotification(AllConst.MVC_SHOP_ERROR,param1.data.info);
               break;
            case PayEvent.PAY_MONEY:
               trace("充值游戏币失败");
               sendNotification(AllConst.MVC_SHOP_ERROR,"充值游戏币失败");
         }
      }
      
      public function showShopItemFun(param1:Bitmap, param2:Object) : void
      {
         if(param2 == null)
         {
            return;
         }
         this.itemObj = this.copyObj(param2);
         sendNotification(AllConst.MVC_SHOP_SHOWITEM,[param1,param2,this.payMoney]);
      }
      
      private function copyObj(param1:Object) : Object
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return _loc2_.readObject() as Object;
      }
      
      public function clearData() : void
      {
         if(this.realStage)
         {
            this.realStage.removeEventListener(PayEvent.GET_MONEY,this.onPayHandler);
            this.realStage.removeEventListener(PayEvent.DEC_MONEY,this.onPayHandler);
            this.realStage.removeEventListener(PayEvent.INC_MONEY,this.onPayHandler);
            this.realStage.removeEventListener(PayEvent.PAY_ERROR,this.onPayHandler);
            this.realStage.removeEventListener(PayEvent.PAY_MONEY,this.onPayHandler);
         }
         this.payMoney = 1;
         this.dataAry = null;
         this.typeAry = null;
      }
   }
}

