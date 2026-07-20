package ctrl4399.proxy
{
   import com.adobe.crypto.MD5;
   import com.adobe.serialization.json.JSON;
   import ctrl4399.strconst.AllConst;
   import flash.events.Event;
   import flash.net.URLVariables;
   import frame4399.simplePureMvc.core.Facade;
   import frame4399.simplePureMvc.interfaces.IProxy;
   import frame4399.simplePureMvc.proxy.Proxy;
   import unit4399.events.ShopEvent;
   import unit4399.road.loader.LoaderManager;
   
   public class PackageProxy extends Proxy implements IProxy
   {
      
      public var realStage:*;
      
      private var mainProxy:MainProxy;
      
      private var _facade:Facade = Facade.getInstance();
      
      private var dataObj:Object;
      
      private var curShopOpType:String = "";
      
      private var curShopOpTypeAry:Array;
      
      private var _pid:String = "";
      
      private var _listDataAry:Array;
      
      private var isDelOne:Boolean = true;
      
      private var uPAry:Array;
      
      private var cEAry:Array;
      
      private var mEAry:Array;
      
      private var dIAry:Array;
      
      private var aIAry:Array;
      
      private var gPAry:Array;
      
      public function PackageProxy(param1:String = null)
      {
         super(param1);
         this.mainProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_MAIN) as MainProxy;
      }
      
      public function updateItemPro(param1:Object, param2:String) : void
      {
         var _loc4_:* = undefined;
         var _loc5_:Object = null;
         var _loc6_:int = 0;
         var _loc7_:Boolean = false;
         var _loc8_:* = undefined;
         if(param1 == null || param1.pId == undefined || param1.keys == undefined && param1.hideKeys == undefined)
         {
            if(this.realStage)
            {
               this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Package_Error_UpdatePro + param2));
            }
            return;
         }
         this._pid = String(param1.pId);
         this._listDataAry = [];
         var _loc3_:Array = [param1.keys,param1.hideKeys];
         for(_loc4_ in _loc3_)
         {
            if(_loc3_[_loc4_] == undefined)
            {
               this._listDataAry[_loc4_] = "";
            }
            else
            {
               _loc5_ = _loc3_[_loc4_] as Object;
               if(_loc5_ == null || _loc5_ is int || _loc5_ is uint || _loc5_ is Number || _loc5_ is Boolean || _loc5_ is String || _loc5_ is Array || _loc5_ is XML || _loc5_ is XMLList)
               {
                  if(this.realStage)
                  {
                     this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Package_Error_UpdatePro + param2));
                  }
                  return;
               }
               _loc6_ = 0;
               _loc7_ = true;
               for(_loc8_ in _loc5_)
               {
                  if(!(_loc5_[_loc8_] is String))
                  {
                     _loc7_ = false;
                     break;
                  }
                  _loc6_++;
               }
               if(!_loc7_ || _loc6_ > 8)
               {
                  if(this.realStage)
                  {
                     this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Package_Error_UpdatePro + param2));
                  }
                  return;
               }
               this._listDataAry[_loc4_] = this.jsonStrFun(_loc5_);
               if(this._listDataAry[_loc4_] == null)
               {
                  if(this.realStage)
                  {
                     this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Package_Error_UpdatePro + param2));
                  }
                  return;
               }
            }
         }
         this.reqUpdateProFun(param2);
      }
      
      private function reqUpdateProFun(param1:String) : void
      {
         var sn:String = param1;
         LoaderManager.loadBytes(AllConst.URL_GET_SHOP_TOKEN + "/?ran=" + 100000 * Math.random(),function(param1:Event):void
         {
            if(param1.type != Event.COMPLETE)
            {
               if(realStage)
               {
                  realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Package_Error_UpdatePro + sn));
               }
               return;
            }
            if(uPAry == null)
            {
               uPAry = new Array();
            }
            uPAry.push(sn);
            AllConst.SATAry.push(String(param1.target.data));
            var _loc2_:String = AllConst.SATAry.shift();
            var _loc3_:URLVariables = new URLVariables();
            _loc3_.gameid = mainProxy.gameID;
            _loc3_.uid = mainProxy.userID;
            _loc3_.bagid = _pid;
            _loc3_.list = _listDataAry[0];
            _loc3_.list2 = _listDataAry[1];
            _loc3_.token = _loc2_;
            _loc3_.verify = MD5.hash(MD5.hash(MD5.hash("SDALPlsldlnSLWPElsdslSE" + _loc3_.gameid + _loc3_.uid + _pid + _loc3_.list + _loc3_.list2 + _loc3_.token + "PKslsO")));
            _loc3_.api_index = sn;
            LoaderManager.loadBytes(AllConst.URL_SET_SHOP_PRO,updateProComplete,_loc3_);
         });
      }
      
      private function updateProComplete(param1:Event) : void
      {
         var _loc5_:Object = null;
         var _loc2_:String = "";
         if(this.uPAry)
         {
            _loc2_ = this.uPAry.shift();
         }
         if(param1.type != Event.COMPLETE)
         {
            if(this.realStage)
            {
               this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Package_Error_UpdatePro + _loc2_));
            }
            return;
         }
         var _loc3_:String = String(param1.target.data);
         if(this.realStage == null)
         {
            return;
         }
         var _loc4_:Array = _loc3_.split("|");
         if(_loc4_ == null)
         {
            return;
         }
         if(String(_loc4_[0]) == AllConst.UPDATEPRO_SUCCESS)
         {
            _loc5_ = new Object();
            _loc5_.callIdx = String(_loc4_[2]);
            this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_UPDATEPRO_SUCC,_loc5_));
            return;
         }
         _loc3_ = AllConst.Shop_Update_Head + _loc3_;
         this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,_loc3_));
      }
      
      public function clearItemsByExTypeFun(param1:Object) : void
      {
         var exFlag:Array;
         var h:int;
         var obj:Object = param1;
         if(obj == null || obj.itemsType == undefined || obj.exFlag == undefined)
         {
            if(this.realStage)
            {
               this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Shop_Error_ClearItemsByExTypex + obj.sn));
            }
            return;
         }
         exFlag = obj.exFlag as Array;
         if(exFlag == null || exFlag.length != 4)
         {
            if(this.realStage)
            {
               this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Shop_Error_ClearItemsByExTypex + obj.sn));
            }
            return;
         }
         h = 0;
         while(h < 4)
         {
            if(!(exFlag[h] is int))
            {
               if(exFlag[h] != "N")
               {
                  if(this.realStage)
                  {
                     this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Shop_Error_ClearItemsByExTypex + obj.sn));
                  }
                  return;
               }
               exFlag[h] = null;
            }
            h++;
         }
         LoaderManager.loadBytes(AllConst.URL_GET_SHOP_TOKEN + "/?ran=" + 100000 * Math.random(),function(param1:Event):void
         {
            if(param1.type != Event.COMPLETE)
            {
               if(realStage)
               {
                  realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Shop_Error_ClearItemsByExTypex + obj.sn));
               }
               return;
            }
            if(cEAry == null)
            {
               cEAry = new Array();
            }
            cEAry.push(obj.sn);
            AllConst.SATAry.push(String(param1.target.data));
            var _loc2_:String = AllConst.SATAry.shift();
            var _loc3_:URLVariables = new URLVariables();
            _loc3_.gameid = mainProxy.gameID;
            _loc3_.uid = mainProxy.userID;
            _loc3_.type = obj.itemsType;
            _loc3_.extend = jsonStrFun(obj.exFlag);
            _loc3_.api_index = obj.sn;
            _loc3_.token = _loc2_;
            _loc3_.verify = MD5.hash(MD5.hash(MD5.hash("SDALPlsldlnSLWPElsdslSE" + _loc3_.gameid + _loc3_.uid + _loc3_.type + _loc3_.extend + _loc3_.token + "PKslsO")));
            LoaderManager.loadBytes(AllConst.URL_CLEAR_SHOP_EXTYPE,clearItemsByExTypeComplete,_loc3_);
         });
      }
      
      private function clearItemsByExTypeComplete(param1:Event) : void
      {
         var _loc5_:Object = null;
         var _loc2_:String = "";
         if(this.cEAry)
         {
            _loc2_ = this.cEAry.shift();
         }
         if(param1.type != Event.COMPLETE)
         {
            if(this.realStage)
            {
               this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Shop_Error_ClearItemsByExTypex + _loc2_));
            }
            return;
         }
         var _loc3_:String = String(param1.target.data);
         if(this.realStage == null)
         {
            return;
         }
         var _loc4_:Array = _loc3_.split("|");
         if(_loc4_ == null)
         {
            return;
         }
         if(String(_loc4_[0]) == AllConst.CLEARITEMS_SUCCESS)
         {
            _loc5_ = new Object();
            _loc5_.callIdx = String(_loc4_[2]);
            this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_CLEARITEMS_EXTYPE,_loc5_));
            return;
         }
         _loc3_ = AllConst.Shop_ClearItems_Head + _loc3_;
         this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,_loc3_));
      }
      
      public function modifyExValFun(param1:Object) : void
      {
         var tmpAry:Array;
         var h:int;
         var obj:Object = param1;
         if(obj == null || obj.pId == undefined || obj.exAry == undefined)
         {
            if(this.realStage)
            {
               this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Shop_Error_ModifyEx + obj.sn));
            }
            return;
         }
         tmpAry = obj.exAry as Array;
         if(tmpAry == null || tmpAry.length != 4)
         {
            if(this.realStage)
            {
               this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Shop_Error_ModifyEx + obj.sn));
            }
            return;
         }
         h = 0;
         while(h < 4)
         {
            if(!(tmpAry[h] is int))
            {
               if(this.realStage)
               {
                  this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Shop_Error_ModifyEx + obj.sn));
               }
               return;
            }
            h++;
         }
         LoaderManager.loadBytes(AllConst.URL_GET_SHOP_TOKEN + "/?ran=" + 100000 * Math.random(),function(param1:Event):void
         {
            if(param1.type != Event.COMPLETE)
            {
               if(realStage)
               {
                  realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Shop_Error_ModifyEx + obj.sn));
               }
               return;
            }
            if(mEAry == null)
            {
               mEAry = new Array();
            }
            mEAry.push(obj.sn);
            AllConst.SATAry.push(String(param1.target.data));
            var _loc2_:String = AllConst.SATAry.shift();
            var _loc3_:URLVariables = new URLVariables();
            _loc3_.gameid = mainProxy.gameID;
            _loc3_.uid = mainProxy.userID;
            _loc3_.bagid = obj.pId;
            _loc3_.extend = jsonStrFun(obj.exAry);
            _loc3_.api_index = obj.sn;
            _loc3_.token = _loc2_;
            _loc3_.verify = MD5.hash(MD5.hash(MD5.hash("SDALPlsldlnSLWPElsdslSE" + _loc3_.gameid + _loc3_.uid + _loc3_.bagid + _loc3_.extend + _loc3_.token + "PKslsO")));
            LoaderManager.loadBytes(AllConst.URL_MODIFY_SHOP_EX,modifyExComplete,_loc3_);
         });
      }
      
      private function modifyExComplete(param1:Event) : void
      {
         var _loc5_:Object = null;
         var _loc2_:String = "";
         if(this.mEAry)
         {
            _loc2_ = this.mEAry.shift();
         }
         if(param1.type != Event.COMPLETE)
         {
            if(this.realStage)
            {
               this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Shop_Error_ModifyEx + _loc2_));
            }
            return;
         }
         var _loc3_:String = String(param1.target.data);
         if(this.realStage == null)
         {
            return;
         }
         var _loc4_:Array = _loc3_.split("|");
         if(_loc4_ == null)
         {
            return;
         }
         if(String(_loc4_[0]) == AllConst.MODIFYEX_SUCCESS)
         {
            _loc5_ = new Object();
            _loc5_.callIdx = String(_loc4_[2]);
            this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_MODIFY_EX,_loc5_));
            return;
         }
         _loc3_ = AllConst.Shop_ModifyEx_Head + _loc3_;
         this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,_loc3_));
      }
      
      private function jsonStrFun(param1:*) : String
      {
         var dataStr:String = null;
         var obj:* = param1;
         try
         {
            dataStr = com.adobe.serialization.json.JSON.encode(obj);
         }
         catch(e:*)
         {
            dataStr = null;
         }
         return dataStr;
      }
      
      public function addItemsFun(param1:Array, param2:String) : void
      {
         var _loc4_:* = undefined;
         var _loc5_:Object = null;
         var _loc6_:Object = null;
         var _loc7_:Object = null;
         var _loc8_:Array = null;
         if(param1 == null || param1.length == 0)
         {
            if(this.realStage)
            {
               this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Package_Error_Add + param2));
            }
            return;
         }
         var _loc3_:Array = new Array();
         for(_loc4_ in param1)
         {
            _loc5_ = param1[_loc4_];
            if(_loc5_ == null || _loc5_.itemObj == undefined)
            {
               if(this.realStage)
               {
                  this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Package_Error_Add + param2));
               }
               return;
            }
            _loc6_ = _loc5_.itemObj;
            if(_loc6_ == null || _loc6_.itemId == undefined || _loc6_.count == undefined)
            {
               if(this.realStage)
               {
                  this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Package_Error_Add + param2));
               }
               return;
            }
            _loc7_ = new Object();
            _loc7_.itemId = _loc6_.itemId;
            _loc7_.count = _loc6_.count;
            if(_loc6_.keys != undefined || _loc6_.hideKeys != undefined)
            {
               _loc8_ = new Array();
               if(_loc6_.keys != undefined)
               {
                  _loc8_[0] = _loc6_.keys;
               }
               if(_loc6_.hideKeys != undefined)
               {
                  _loc8_[1] = _loc6_.hideKeys;
               }
               _loc7_.itemProAry = _loc8_;
            }
            if(_loc5_.exFlag != undefined)
            {
               _loc7_.exFlag = _loc5_.exFlag;
            }
            param1[_loc4_] = _loc7_;
         }
         this.opItems("add",param1,param2);
      }
      
      public function opItems(param1:String, param2:Array, param3:String) : void
      {
         var _loc7_:* = undefined;
         var _loc8_:String = null;
         var _loc9_:Object = null;
         var _loc10_:Array = null;
         var _loc11_:* = undefined;
         var _loc12_:Object = null;
         var _loc13_:int = 0;
         var _loc14_:Boolean = false;
         var _loc15_:* = undefined;
         var _loc16_:Array = null;
         var _loc17_:int = 0;
         var _loc4_:String = "";
         if(param1 == "sub")
         {
            _loc4_ = AllConst.Package_Error_Delete + param3;
         }
         else
         {
            if(param1 != "add")
            {
               _loc4_ = AllConst.Package_Error + param3;
               if(this.realStage)
               {
                  this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,_loc4_));
               }
               return;
            }
            _loc4_ = AllConst.Package_Error_Add + param3;
         }
         if(param2 == null || param2.length == 0)
         {
            if(this.realStage)
            {
               this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,_loc4_));
            }
            return;
         }
         var _loc5_:int = 0;
         var _loc6_:Array = new Array();
         for(_loc7_ in param2)
         {
            _loc9_ = param2[_loc7_];
            if(_loc9_ == null || _loc9_.itemId == undefined || _loc9_.count == undefined || int(_loc9_.count) <= 0)
            {
               if(this.realStage)
               {
                  this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,_loc4_));
               }
               return;
            }
            _loc6_[_loc5_] = new Array();
            _loc6_[_loc5_][0] = String(_loc9_.itemId);
            _loc6_[_loc5_][1] = int(_loc9_.count);
            if(_loc9_.itemProAry != undefined)
            {
               _loc10_ = _loc9_.itemProAry as Array;
               if(_loc10_ == null || _loc10_.length > 2)
               {
                  if(this.realStage)
                  {
                     this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,_loc4_));
                  }
                  return;
               }
               for(_loc11_ in _loc10_)
               {
                  if(_loc10_[_loc11_] != undefined)
                  {
                     _loc12_ = _loc10_[_loc11_] as Object;
                     if(_loc12_ == null || _loc12_ is int || _loc12_ is uint || _loc12_ is Number || _loc12_ is Boolean || _loc12_ is String || _loc12_ is Array || _loc12_ is XML || _loc12_ is XMLList)
                     {
                        if(this.realStage)
                        {
                           this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,_loc4_));
                        }
                        return;
                     }
                     _loc13_ = 0;
                     _loc14_ = true;
                     for(_loc15_ in _loc12_)
                     {
                        if(!(_loc12_[_loc15_] is String))
                        {
                           _loc14_ = false;
                           break;
                        }
                        _loc13_++;
                     }
                     if(!_loc14_ || _loc13_ > 8)
                     {
                        if(this.realStage)
                        {
                           this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,_loc4_));
                        }
                        return;
                     }
                  }
               }
               _loc6_[_loc5_][2] = _loc10_[0];
               _loc6_[_loc5_][3] = _loc10_[1];
            }
            if(_loc9_.exFlag != undefined)
            {
               _loc16_ = _loc9_.exFlag as Array;
               if(_loc16_ != null)
               {
                  if(_loc16_.length != 4)
                  {
                     if(this.realStage)
                     {
                        this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,_loc4_));
                     }
                     return;
                  }
                  _loc17_ = 0;
                  while(_loc17_ < 4)
                  {
                     if(!(_loc16_[_loc17_] is int))
                     {
                        if(this.realStage)
                        {
                           this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,_loc4_));
                        }
                        return;
                     }
                     _loc17_++;
                  }
                  _loc6_[_loc5_][4] = _loc16_;
               }
               else
               {
                  _loc6_[_loc5_][4] = "";
               }
            }
            _loc9_ = null;
            _loc5_++;
         }
         _loc8_ = this.jsonStrFun(_loc6_);
         if(param1 == "sub")
         {
            this.isDelOne = false;
            this.reqDelItemFun(_loc8_,param3);
         }
         else if(param1 == "add")
         {
            this.reqAddItemFun(_loc8_,param3);
         }
      }
      
      public function consumeItem(param1:String) : void
      {
         if(param1 == "")
         {
            if(this.realStage)
            {
               this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Package_Error_Delete));
            }
            return;
         }
         this.isDelOne = true;
         this.reqDelItemFun(param1);
      }
      
      private function reqDelItemFun(param1:String, param2:String = "") : void
      {
         var dataStr:String = param1;
         var sn:String = param2;
         if(dataStr == null || dataStr == "")
         {
            if(this.realStage)
            {
               this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Package_Error_Delete + sn));
            }
            return;
         }
         LoaderManager.loadBytes(AllConst.URL_GET_SHOP_TOKEN + "/?ran=" + 100000 * Math.random(),function(param1:Event):void
         {
            if(param1.type != Event.COMPLETE)
            {
               if(realStage)
               {
                  realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Package_Error_Delete + sn));
               }
               return;
            }
            if(dIAry == null)
            {
               dIAry = new Array();
            }
            dIAry.push(sn);
            AllConst.SATAry.push(String(param1.target.data));
            var _loc2_:String = AllConst.SATAry.shift();
            var _loc3_:URLVariables = new URLVariables();
            _loc3_.gameid = mainProxy.gameID;
            _loc3_.uid = mainProxy.userID;
            if(!isDelOne)
            {
               _loc3_.list = dataStr;
               _loc3_.ac = "batch";
            }
            else
            {
               _loc3_.toolid = dataStr;
            }
            _loc3_.token = _loc2_;
            _loc3_.verify = MD5.hash(MD5.hash(MD5.hash("SDALPlsldlnSLWPElsdslSE" + _loc3_.gameid + _loc3_.uid + dataStr + _loc3_.token + "PKslsO")));
            _loc3_.api_index = sn;
            LoaderManager.loadBytes(AllConst.URL_GET_SHOP_DEL,delProComplete,_loc3_);
         });
      }
      
      private function delProComplete(param1:Event) : void
      {
         var _loc5_:Object = null;
         var _loc2_:String = "";
         if(this.dIAry)
         {
            _loc2_ = this.dIAry.shift();
         }
         if(param1.type != Event.COMPLETE)
         {
            if(this.realStage)
            {
               this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Package_Error_Delete + _loc2_));
            }
            return;
         }
         var _loc3_:String = String(param1.target.data);
         if(this.realStage == null)
         {
            return;
         }
         var _loc4_:Array = _loc3_.split("|");
         if(_loc4_ == null)
         {
            return;
         }
         if(String(_loc4_[0]) == AllConst.DELPRO_SUCCESS)
         {
            _loc5_ = new Object();
            _loc5_.callIdx = String(_loc4_[2]);
            this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_DEL_SUCC,_loc5_));
            return;
         }
         if(!this.isDelOne)
         {
            _loc3_ = AllConst.Shop_DelItems_Head + _loc3_;
         }
         else
         {
            _loc3_ = AllConst.Shop_DelItem_Head + _loc3_;
         }
         this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,_loc3_));
      }
      
      private function reqAddItemFun(param1:String, param2:String) : void
      {
         var dataStr:String = param1;
         var sn:String = param2;
         if(dataStr == null || dataStr == "")
         {
            if(this.realStage)
            {
               this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Package_Error_Add + sn));
            }
            return;
         }
         LoaderManager.loadBytes(AllConst.URL_GET_SHOP_TOKEN + "/?ran=" + 100000 * Math.random(),function(param1:Event):void
         {
            if(param1.type != Event.COMPLETE)
            {
               if(realStage)
               {
                  realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Package_Error_Add + sn));
               }
               return;
            }
            if(aIAry == null)
            {
               aIAry = new Array();
            }
            aIAry.push(sn);
            AllConst.SATAry.push(String(param1.target.data));
            var _loc2_:String = AllConst.SATAry.shift();
            var _loc3_:URLVariables = new URLVariables();
            _loc3_.ac = "batch";
            _loc3_.gameid = mainProxy.gameID;
            _loc3_.uid = mainProxy.userID;
            _loc3_.list = dataStr;
            _loc3_.token = _loc2_;
            _loc3_.verify = MD5.hash(MD5.hash(MD5.hash("SDALPlsldlnSLWPElsdslSE" + _loc3_.gameid + _loc3_.uid + dataStr + _loc3_.token + "PKslsO")));
            _loc3_.api_index = sn;
            LoaderManager.loadBytes(AllConst.URL_GET_SHOP_ADD,addProComplete,_loc3_);
         });
      }
      
      private function addProComplete(param1:Event) : void
      {
         var _loc5_:Object = null;
         var _loc2_:String = "";
         if(this.aIAry)
         {
            _loc2_ = this.aIAry.shift();
         }
         if(param1.type != Event.COMPLETE)
         {
            if(this.realStage)
            {
               this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Package_Error_Add + _loc2_));
            }
            return;
         }
         var _loc3_:String = String(param1.target.data);
         if(this.realStage == null)
         {
            return;
         }
         var _loc4_:Array = _loc3_.split("|");
         if(_loc4_ == null)
         {
            return;
         }
         if(String(_loc4_[0]) == AllConst.ADDFREEPRO_SUCCESS)
         {
            _loc5_ = new Object();
            _loc5_.callIdx = String(_loc4_[2]);
            this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ADDFREE_SUCC,_loc5_));
            return;
         }
         _loc3_ = AllConst.Shop_AddItems_Head + _loc3_;
         this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,_loc3_));
      }
      
      public function getShopProItemsFun(param1:Object) : void
      {
         var idsStr:String = null;
         var idsObj:Object = param1;
         idsStr = idsObj.idStr;
         if(idsStr == null || idsStr == "")
         {
            if(this.realStage)
            {
               this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Package_Error_GetIdsList + idsObj.sn));
            }
            return;
         }
         LoaderManager.loadBytes(AllConst.URL_GET_SHOP_TOKEN + "/?ran=" + 100000 * Math.random(),function(param1:Event):void
         {
            if(param1.type != Event.COMPLETE)
            {
               if(realStage)
               {
                  realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Package_Error_GetIdsList + idsObj.sn));
               }
               return;
            }
            if(gPAry == null)
            {
               gPAry = new Array();
            }
            gPAry.push(idsObj.sn);
            if(curShopOpTypeAry == null)
            {
               curShopOpTypeAry = new Array();
            }
            curShopOpTypeAry.push(AllConst.Package_Error_GetIdsList);
            AllConst.SATAry.push(String(param1.target.data));
            var _loc2_:String = AllConst.SATAry.shift();
            var _loc3_:URLVariables = new URLVariables();
            _loc3_.gameid = mainProxy.gameID;
            _loc3_.uid = mainProxy.userID;
            _loc3_.ac = "ids";
            _loc3_.ids = idsStr;
            _loc3_.token = _loc2_;
            _loc3_.api_index = idsObj.sn;
            _loc3_.verify = MD5.hash(MD5.hash(MD5.hash("SDALPlsldlnSLWPElsdslSE" + _loc3_.gameid + _loc3_.uid + _loc3_.ids + _loc3_.token + "PKslsO")));
            LoaderManager.loadBytes(AllConst.URL_GET_SHOP_PACKAGE,getPackageInfoComplete,_loc3_);
         });
      }
      
      public function getPackageInfo(param1:Object) : void
      {
         var pacakgeData:Object = param1;
         if(pacakgeData == null)
         {
            if(this.realStage)
            {
               this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Package_Error_GetList + pacakgeData.sn));
            }
            return;
         }
         LoaderManager.loadBytes(AllConst.URL_GET_SHOP_TOKEN + "/?ran=" + 100000 * Math.random(),function(param1:Event):void
         {
            var exStr:String;
            var tmpAry:Array;
            var tmp:String;
            var urlval:URLVariables;
            var h:int = 0;
            var e:Event = param1;
            if(e.type != Event.COMPLETE)
            {
               if(realStage)
               {
                  realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Package_Error_GetList + pacakgeData.sn));
               }
               return;
            }
            exStr = "";
            tmpAry = pacakgeData.exFlag as Array;
            if(tmpAry != null)
            {
               if(tmpAry.length != 4)
               {
                  if(realStage)
                  {
                     realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Shop_Error_SetEx + pacakgeData.sn));
                  }
                  return;
               }
               h = 0;
               while(h < 4)
               {
                  if(!(tmpAry[h] is int))
                  {
                     if(realStage)
                     {
                        realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Shop_Error_SetEx + pacakgeData.sn));
                     }
                     return;
                  }
                  h++;
               }
               try
               {
                  exStr = com.adobe.serialization.json.JSON.encode(tmpAry);
               }
               catch(e:*)
               {
                  trace("packageProxy Json转换出错");
                  if(realStage)
                  {
                     realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,AllConst.Shop_Error_SetEx + pacakgeData.sn));
                  }
                  return;
               }
            }
            if(gPAry == null)
            {
               gPAry = new Array();
            }
            gPAry.push(pacakgeData.sn);
            if(curShopOpTypeAry == null)
            {
               curShopOpTypeAry = new Array();
            }
            curShopOpTypeAry.push(AllConst.Package_Error_GetList);
            AllConst.SATAry.push(String(e.target.data));
            tmp = AllConst.SATAry.shift();
            urlval = new URLVariables();
            urlval.gameid = mainProxy.gameID;
            urlval.uid = mainProxy.userID;
            urlval.type = String(pacakgeData.typeId);
            urlval.p = String(pacakgeData.curPage);
            urlval.show = String(pacakgeData.pageNum);
            urlval.extend = exStr;
            urlval.token = tmp;
            urlval.api_index = pacakgeData.sn;
            urlval.verify = MD5.hash(MD5.hash(MD5.hash("SDALPlsldlnSLWPElsdslSE" + urlval.gameid + urlval.uid + urlval.type + urlval.p + urlval.show + urlval.extend + urlval.token + "PKslsO")));
            LoaderManager.loadBytes(AllConst.URL_GET_SHOP_PACKAGE,getPackageInfoComplete,urlval);
         });
      }
      
      private function getPackageInfoComplete(param1:Event) : void
      {
         var _loc2_:String = "";
         if(this.gPAry)
         {
            _loc2_ = this.gPAry.shift();
         }
         this.curShopOpType = "";
         if(this.curShopOpTypeAry)
         {
            this.curShopOpType = this.curShopOpTypeAry.shift();
         }
         if(param1.type != Event.COMPLETE)
         {
            if(this.realStage)
            {
               this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,this.curShopOpType + _loc2_));
            }
            return;
         }
         var _loc3_:XML = XML(param1.target.data);
         if(_loc3_ == null)
         {
            if(this.realStage)
            {
               this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,this.curShopOpType + _loc2_));
            }
            return;
         }
         this.dataObj = new Object();
         this.analysisXmlFun(_loc3_,_loc2_);
      }
      
      private function analysisXmlFun(param1:XML, param2:String) : void
      {
         var _loc6_:* = undefined;
         var _loc7_:Object = null;
         var _loc8_:XMLList = null;
         var _loc9_:XMLList = null;
         var _loc10_:Object = null;
         var _loc11_:* = undefined;
         var _loc12_:Object = null;
         var _loc13_:* = undefined;
         var _loc3_:XMLList = param1.items.item;
         var _loc4_:XMLList = param1.page;
         if(_loc3_ == null || _loc4_ == null)
         {
            if(this.realStage)
            {
               this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_ERROR,this.curShopOpType + param2));
            }
            return;
         }
         this.dataObj.cur = int(_loc4_.current);
         this.dataObj.total = int(_loc4_.total);
         this.dataObj.callIdx = String(param1.index);
         var _loc5_:int = -1;
         for each(_loc6_ in _loc3_)
         {
            _loc5_++;
            _loc7_ = new Object();
            _loc7_.proId = String(_loc6_.toolid);
            _loc7_.pId = String(_loc6_.id);
            _loc7_.title = String(_loc6_.title);
            _loc7_.price = String(_loc6_.price);
            _loc7_.description = String(_loc6_.description);
            _loc7_.thumb = String(_loc6_.thumb);
            _loc7_.count = String(_loc6_.count);
            _loc8_ = _loc6_.params.p;
            if(_loc8_ != null)
            {
               _loc10_ = new Object();
               for each(_loc11_ in _loc8_)
               {
                  _loc10_[_loc11_.@key] = String(_loc11_);
               }
               _loc7_.keys = _loc10_;
            }
            _loc9_ = _loc6_.params2.p;
            if(_loc9_ != null)
            {
               _loc12_ = new Object();
               for each(_loc13_ in _loc9_)
               {
                  _loc12_[_loc13_.@key] = String(_loc13_);
               }
               _loc7_.hideKeys = _loc12_;
            }
            this.dataObj["item" + _loc5_] = _loc7_;
         }
         this.dataObj.itemNum = _loc5_ + 1;
         this.dataObj.getType = this.curShopOpType == AllConst.Package_Error_GetList ? "all" : "ids";
         if(this.realStage)
         {
            this.realStage.dispatchEvent(new ShopEvent(ShopEvent.SHOP_GET_PACKAGEINFO,this.dataObj));
         }
      }
   }
}

