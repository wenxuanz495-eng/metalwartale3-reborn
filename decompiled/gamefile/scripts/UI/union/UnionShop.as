package UI.union
{
   import body.define.OneArmsDefine;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import gameAll.data.ArmsItemsData;
   import goods.GoodsDefine;
   import goods.UnionShopData;
   import items.ItemsDefine;
   
   public class UnionShop
   {
      
      private var _shoplistPage:int = 1;
      
      private const ONEPAGECOUNT:int = 8;
      
      private var _unionShopList:Array = [];
      
      private var _tempID:int = -1;

      private var _tempBuyCount:int = 1;
      
      private var father:UnionUI = null;
      
      private var mc_box:MovieClip = null;
      
      public function UnionShop(mc0:UnionUI, mc1:MovieClip)
      {
         super();
         this.father = mc0;
         this.mc_box = mc1;
      }
      
      public function Init() : void
      {
         var jumfun:Function = function():void
         {
            father.InitBox(1);
         };
         if(!this.father.IsHasUnion && !Game.getTest())
         {
            Game.uiGroup.checkTip.showCheck2("您还没有加入任何公会,请先加入公会!",2,jumfun);
            return;
         }
         this.mc_box.gotoAndStop(4);
         this._shoplistPage = 1;
         this._unionShopList = Game.unionShopDefineGroup.GetUnionShopArr();
         this.addOfflineBadgeShop();
         this.addOfflineHonorStoneShop();
         this.addOfflineCrystalShop();
         this.mc_box.btn_lastpage.addEventListener(MouseEvent.CLICK,this.onClickBtn);
         this.mc_box.btn_nextpage.addEventListener(MouseEvent.CLICK,this.onClickBtn);
         this.updateMember(null);
         this.updateMember(this._unionShopList);
      }
      
      protected function onClickBtn(event:MouseEvent) : void
      {
         var btn:DisplayObject = event.currentTarget as DisplayObject;
         var name:String = btn.name;
         switch(name)
         {
            case "btn_nextpage":
               if(this.mc_box.currentFrame == 4)
               {
                  ++this._shoplistPage;
                  (this.mc_box["btn_lastpage"] as SimpleButton).alpha = 1;
                  (this.mc_box["btn_lastpage"] as SimpleButton).mouseEnabled = true;
                  (this.mc_box["txt_page"] as TextField).text = "" + this._shoplistPage;
                  this.updateMember(this._unionShopList);
               }
               break;
            case "btn_lastpage":
               if(this.mc_box.currentFrame == 4)
               {
                  if(--this._shoplistPage <= 1)
                  {
                     this._shoplistPage = 1;
                     (this.mc_box["btn_lastpage"] as SimpleButton).alpha = 0.3;
                     (this.mc_box["btn_lastpage"] as SimpleButton).mouseEnabled = false;
                  }
                  else
                  {
                     (this.mc_box["btn_lastpage"] as SimpleButton).alpha = 1;
                     (this.mc_box["btn_lastpage"] as SimpleButton).mouseEnabled = true;
                  }
                  (this.mc_box["txt_page"] as TextField).text = "" + this._shoplistPage;
                  this.updateMember(this._unionShopList);
               }
               break;
            case "btn_close":
               if(this.father.contains(btn))
               {
                  btn.parent.visible = false;
               }
               break;
            case "btn_cancel":
               if(this.father.contains(btn))
               {
                  btn.parent.visible = false;
               }
         }
      }
      
      private function updateMember(arr:Array) : void
      {
         var obj:UnionShopData = null;
         var itemdefine:ItemsDefine = null;
         var moneyType:String = null;
         var canCount:int = 0;
         var il:String = null;
         var ifather:String = null;
         var canPost:String = null;
         var armdefine:OneArmsDefine = null;
         var aid0:ArmsItemsData = null;
         if(this.mc_box.currentFrame != 4)
         {
            return;
         }
         var len:int = 0;
         if(arr == null)
         {
            len = 0;
            (this.mc_box["btn_lastpage"] as SimpleButton).alpha = 0.3;
            (this.mc_box["btn_lastpage"] as SimpleButton).mouseEnabled = false;
            (this.mc_box["btn_nextpage"] as SimpleButton).alpha = 0.3;
            (this.mc_box["btn_nextpage"] as SimpleButton).mouseEnabled = false;
         }
         else
         {
            len = int(arr.length);
         }
         if(int(len / this.ONEPAGECOUNT) + 1 > this._shoplistPage)
         {
            (this.mc_box["btn_nextpage"] as SimpleButton).alpha = 1;
            (this.mc_box["btn_nextpage"] as SimpleButton).mouseEnabled = true;
         }
         else
         {
            (this.mc_box["btn_nextpage"] as SimpleButton).alpha = 0.3;
            (this.mc_box["btn_nextpage"] as SimpleButton).mouseEnabled = false;
         }
         for(var i:int = 0; i < this.ONEPAGECOUNT; i++)
         {
            (this.mc_box["mc_list_" + i]["txt_name"] as TextField).text = "";
            (this.mc_box["mc_list_" + i]["txt_unionCondition"] as TextField).text = "";
            (this.mc_box["mc_list_" + i]["txt_memberCondition"] as TextField).text = "";
            (this.mc_box["mc_list_" + i]["txt_price"] as TextField).text = "";
            (this.mc_box["mc_list_" + i]["btn_buy"] as SimpleButton).visible = false;
            this.mc_box["mc_list_" + i].visible = false;
            if(Boolean(this.mc_box["mc_list_" + i]) && Boolean(arr) && Boolean(arr[i + this.ONEPAGECOUNT * (this._shoplistPage - 1)]))
            {
               obj = arr[i + this.ONEPAGECOUNT * (this._shoplistPage - 1)];
               itemdefine = Game.itemsDefineGroup.getDefine(obj.GoodsID);
               moneyType = this.getMoneyType(obj.BuyType);
               canCount = this.isRepeatable(obj) ? 9999999 : (this.isOwnedWeapon(obj.GoodsID) ? 0 : 1);
               il = "";
               ifather = "";
               if(itemdefine == null)
               {
                  armdefine = Game.defineGroup.getArmsDefine(obj.GoodsID,0);
                  if(armdefine == null)
                  {
                     continue;
                  }
                  il = armdefine.imgLabel;
                  ifather = armdefine.father;
               }
               else
               {
                  il = itemdefine.imgLabel;
               }
               this.mc_box["mc_list_" + i].visible = true;
               this.addIcon(this.mc_box["mc_list_" + i]["mc_icon"],il,ifather);
               (this.mc_box["mc_list_" + i]["txt_name"] as TextField).text = "" + obj.Name;
               (this.mc_box["mc_list_" + i]["txt_price"] as TextField).htmlText = "" + obj.Price + moneyType + "<font color=\'#ff0000\'>" + (this.isRepeatable(obj) ? "(不限购)" : "(剩余" + canCount + ")");
               (this.mc_box["mc_list_" + i]["btn_buy"] as SimpleButton).visible = true;
               canPost = "";
               (this.mc_box["mc_list_" + i]["txt_unionCondition"] as TextField).text = "离线公会商店";
               (this.mc_box["mc_list_" + i]["txt_memberCondition"] as TextField).text = this.isRepeatable(obj) ? "可重复购买" : "仅限拥有1件";
               this.mc_box["mc_list_" + i].buyID = i + this.ONEPAGECOUNT * (this._shoplistPage - 1);
               (this.mc_box["mc_list_" + i]["btn_buy"] as SimpleButton).addEventListener(MouseEvent.CLICK,this.sureBuy);
               if(canCount > 0)
               {
                  (this.mc_box["mc_list_" + i]["btn_buy"] as SimpleButton).alpha = 1;
                  (this.mc_box["mc_list_" + i]["btn_buy"] as SimpleButton).mouseEnabled = true;
               }
               else
               {
                  (this.mc_box["mc_list_" + i]["btn_buy"] as SimpleButton).alpha = 0.3;
                  (this.mc_box["mc_list_" + i]["btn_buy"] as SimpleButton).mouseEnabled = false;
               }
            }
         }
      }
      
      private function getMoneyType(BuyType:String) : String
      {
         switch(BuyType)
         {
            case "G":
               return "G币";
            case "X":
               return "公会奖章";
            case "H":
               return "荣誉勋章";
            default:
               return "";
         }
      }

      private function addOfflineHonorStoneShop() : void
      {
         var old:UnionShopData = null;
         for each(old in this._unionShopList)
         {
            if(old.Id == 1005 || old.GoodsID == "superalloyStone" && old.BuyType == "H")
            {
               return;
            }
         }
         var stone:UnionShopData = new UnionShopData();
         stone.Id = 1005;
         stone.GoodsID = "superalloyStone";
         stone.Price = 2;
         stone.Count = 1;
         stone.DayCanTime = 9999999;
         stone.BuyType = "H";
         stone.Name = "超合金原石*1";
         stone.ConditionUnion = 0;
         stone.ConditionMember = 0;
         this._unionShopList.push(stone);
      }

      private function addOfflineBadgeShop() : void
      {
         var old:UnionShopData = null;
         for each(old in this._unionShopList)
         {
            if(old.Id == 1000 || old.GoodsID == "justice2_badge" && old.BuyType == "G")
            {
               return;
            }
         }
         var badge:UnionShopData = new UnionShopData();
         badge.Id = 1000;
         badge.GoodsID = "justice2_badge";
         badge.Price = 50000;
         badge.Count = 1;
         badge.DayCanTime = 9999999;
         badge.BuyType = "G";
         badge.Name = "公会奖章";
         badge.ConditionUnion = 0;
         badge.ConditionMember = 0;
         this._unionShopList.push(badge);
      }

      private function addOfflineCrystalShop() : void
      {
         var old:UnionShopData = null;
         for(var i:int = this._unionShopList.length - 1; i >= 0; i--)
         {
            old = this._unionShopList[i] as UnionShopData;
            if(old != null && old.GoodsID.indexOf("_crystal_") >= 0)
            {
               this._unionShopList.splice(i,1);
            }
         }
         this.addOfflineCrystal(1001,"red_crystal_9","\u4E5D\u7EA7\u7EA2\u8272\u6676\u4F53*1");
         this.addOfflineCrystal(1002,"yellow_crystal_9","\u4E5D\u7EA7\u9EC4\u8272\u6676\u4F53*1");
         this.addOfflineCrystal(1003,"green_crystal_9","\u4E5D\u7EA7\u7EFF\u8272\u6676\u4F53*1");
         this.addOfflineCrystal(1004,"purple_crystal_9","\u4E5D\u7EA7\u7D2B\u8272\u6676\u4F53*1");
      }

      private function addOfflineCrystal(id:int, goodsID:String, name:String) : void
      {
         var old:UnionShopData = null;
         var crystal:UnionShopData = null;
         for each(old in this._unionShopList)
         {
            if(old.Id == id || old.GoodsID == goodsID)
            {
               return;
            }
         }
         crystal = new UnionShopData();
         crystal.Id = id;
         crystal.GoodsID = goodsID;
         crystal.Price = 10;
         crystal.Count = 1;
         crystal.DayCanTime = 9999999;
         crystal.BuyType = "X";
         crystal.Name = name;
         crystal.ConditionUnion = 0;
         crystal.ConditionMember = 0;
         this._unionShopList.push(crystal);
      }

      private function isRepeatable(obj:UnionShopData) : Boolean
      {
         return Game.itemsDefineGroup.getDefine(obj.GoodsID) != null;
      }

      private function isOwnedWeapon(goodsID:String) : Boolean
      {
         if(Game.gameData.armsItems.getItemsByBase(goodsID,false) is ArmsItemsData)
         {
            return true;
         }
         return Game.gameData.subItems.getItemsByBase(goodsID,false) is ArmsItemsData;
      }
      
      private function sureBuy(event:MouseEvent) : void
      {
         var ep:DisplayObject = event.currentTarget.parent;
         if(ep["buyID"] != null)
         {
            this._tempID = ep["buyID"];
            var obj:UnionShopData = this._unionShopList[this._tempID];
            if(this.isRepeatable(obj))
            {
               var gd:GoodsDefine = this.getPurchaseDefine(obj);
               if(gd == null)
               {
                  Game.uiGroup.checkTip.showCheck2("商品数据不存在，无法购买。",2);
                  return;
               }
               var group:* = Game.gameData[gd.type + "Items"];
               if(group.getItemsByBase(gd.id) == null && group.getSurplus() <= 0)
               {
                  Game.uiGroup.checkTip.showCheck2("目标背包已满，无法购买商品。",3);
                  return;
               }
               var currency:int = obj.BuyType == "G" ? int(Game.gameData.GCoin) : int(Game.gameData.propsItems.getNumByBase(obj.BuyType == "H" ? "justice_badge" : "justice2_badge"));
               var maxCount:int = obj.Price > 0 ? int(currency / obj.Price) : 9999999;
               if(maxCount < 1)
               {
                  Game.uiGroup.checkTip.showCheck2(this.getInsufficientMessage(obj.BuyType),2);
                  return;
               }
               Game.uiGroup.checkTip.showQuantityPurchaseCheck(obj.Name,this.getMoneyType(obj.BuyType),obj.Price,maxCount,"目标背包还有空位：<font color=\'#FFFF00\'>" + group.getSurplus() + "</font> 个",this.onQuantityBuyClick);
            }
            else
            {
               this._tempBuyCount = 1;
               Game.uiGroup.checkTip.showCheck("确认要购买该物品吗？",this.onBuyClick);
            }
         }
      }

      private function onQuantityBuyClick() : void
      {
         this._tempBuyCount = Game.uiGroup.checkTip.getSelectedNum();
         this.onBuyClick();
      }
      
      protected function onBuyClick(event:MouseEvent = null) : void
      {
         var hasm:int = 0;
         var hasx:int = 0;
         var obj:UnionShopData = this._unionShopList[this._tempID];
         var buyCount:int = this.isRepeatable(obj) ? this._tempBuyCount : 1;
         var totalPrice:int = int(obj.Price) * buyCount;
         if(buyCount < 1)
         {
            return;
         }
         var gd:GoodsDefine = this.getPurchaseDefine(obj);
         if(gd == null)
         {
            Game.uiGroup.checkTip.showCheck2("商品数据不存在，无法购买。",2);
            return;
         }
         if(Game.gameData[gd.type + "Items"].getItemsByBase(gd.id) == null && Game.gameData[gd.type + "Items"].getSurplus() <= 0)
         {
            Game.uiGroup.checkTip.showCheck2("目标背包已满，无法购买商品。",3);
            return;
         }
         if(obj.BuyType == "G")
         {
            hasm = Game.gameData.GCoin;
            if(hasm < totalPrice)
            {
               Game.uiGroup.checkTip.showCheck2("金币不足!",2);
               return;
            }
            Game.gameData.addCoin(-totalPrice);
         }
         else if(obj.BuyType == "X")
         {
            hasx = Game.gameData.propsItems.getNumByBase("justice2_badge");
            if(hasx < totalPrice)
            {
               Game.uiGroup.checkTip.showCheck2("公会奖章不足!",2);
               return;
            }
            Game.gameData.propsItems.useItemsNum("justice2_badge",totalPrice);
         }
         else if(obj.BuyType == "H")
         {
            hasx = Game.gameData.propsItems.getNumByBase("justice_badge");
            if(hasx < totalPrice)
            {
               Game.uiGroup.checkTip.showCheck2("荣誉勋章不足!",2);
               return;
            }
            Game.gameData.propsItems.useItemsNum("justice_badge",totalPrice);
         }
         gd.num = int(obj.Count) * buyCount;
         Game.uiGroup.addGift_byArr([gd],true,Game.gameData.level,true);
         if(!this.isRepeatable(obj))
         {
            Game.gameData.giftData.AddUnionShopedByID(obj.Id);
         }
         this.updateMember(this._unionShopList);
         Game.uiGroup.saveDataNoUI();
      }

      private function getPurchaseDefine(obj:UnionShopData) : GoodsDefine
      {
         var source:GoodsDefine = Game.goodsDefineGroup.GetGoodsByName(obj.GoodsID);
         if(source == null)
         {
            return null;
         }
         var gd:GoodsDefine = source.copy();
         if(gd.type == "material" || gd.type == "crystal" || gd.type == "chip")
         {
            gd.type = "materials";
         }
         if(gd.type == "card")
         {
            gd.type = "props";
         }
         return gd;
      }

      private function getInsufficientMessage(buyType:String) : String
      {
         if(buyType == "G")
         {
            return "金币不足!";
         }
         if(buyType == "H")
         {
            return "荣誉勋章不足!";
         }
         return "公会奖章不足!";
      }
      
      private function addIcon(mccontains:DisplayObjectContainer, imgLabel:String, father:String = "") : void
      {
         var bit:Bitmap = null;
         while(mccontains.numChildren > 0)
         {
            mccontains.removeChildAt(0);
         }
         var temp:* = Game.swfLoaderManager.getResource("",imgLabel);
         if(temp == null)
         {
            temp = Game.swfLoaderManager.getResource(father,imgLabel);
            temp.stop();
            temp.x = -temp.width / 2;
            temp.y = -temp.height / 2;
            if(Boolean(temp["basePoint"]))
            {
               temp["basePoint"].visible = false;
            }
            if(Boolean(temp["shootPoint"]))
            {
               temp["shootPoint"].visible = false;
            }
         }
         var mc:MovieClip = null;
         if(!(temp is DisplayObject))
         {
            mc = new MovieClip();
            bit = new Bitmap(temp);
            mc.addChild(bit);
            bit.x = -bit.width / 2;
            bit.y = -bit.height / 2;
         }
         else
         {
            mc = temp;
         }
         mccontains.addChild(mc);
      }
      
      public function Release() : void
      {
         this._shoplistPage = 1;
         this._unionShopList = [];
         this._tempID = -1;
         this._tempBuyCount = 1;
         this.updateMember(null);
      }
   }
}

