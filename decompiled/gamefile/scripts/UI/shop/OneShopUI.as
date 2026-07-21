package UI.shop
{
   import UI.ClickEvent;
   import UI.label.LabelCtrl;
   import UI.page.PageBox;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import gameAll.api.ShopBuyObject;
   import gameAll.data.ArmsItemsData;
   import gameAll.data.ArmsItemsDataGroup;
   import gameAll.data.GameData;
   import gameAll.data.GoodsItemsData;
   import gameAll.data.car.CarDataCreator;
   import goods.GoodsDefine;
   import goods.GoodsDefineGroup;
   
   public class OneShopUI extends Sprite
   {
      
      public var FITST_txt:String = "";
      
      public var GDG:GoodsDefineGroup;
      
      public var GD:GameData;
      
      public var switchLabel:LabelCtrl;
      
      public var car_btn:SimpleButton;
      
      public var arms_btn:SimpleButton;
      
      public var sub_btn:SimpleButton;
      
      public var props_btn:SimpleButton;
      
      public var materials_btn:SimpleButton;
      
      public var light_sp:Sprite;
      
      public var armsBox:ShopIconBox;
      
      public var subBox:ShopIconBox;
      
      public var carBox:ShopIconBox;
      
      public var materialsBox:ShopIconBox;
      
      public var propsBox:ShopIconBox;
      
      public var pageBox:PageBox;
      
      public var allBox:Array;
      
      public var nowBuyGoods:GoodsDefine = null;
      
      public var noGoodsShow:*;
      
      public function OneShopUI()
      {
         var n:* = undefined;
         var sib:ShopIconBox = null;
         this.switchLabel = new LabelCtrl();
         this.armsBox = new ShopIconBox();
         this.subBox = new ShopIconBox();
         this.carBox = new ShopIconBox();
         this.materialsBox = new ShopIconBox();
         this.propsBox = new ShopIconBox();
         this.pageBox = new PageBox();
         this.allBox = [];
         super();
         this.mouseEnabled = false;
         this.noGoodsShow.visible = false;
         this.noGoodsShow.txt.text = "暂无该类型商品";
         this.switchLabel.inData([this.car_btn,this.arms_btn,this.sub_btn,this.props_btn,this.materials_btn],this.light_sp);
         this.switchLabel.addEventListener(ClickEvent.ON_CLICK,this.labelClick);
         this.allBox = [this.carBox,this.propsBox,this.materialsBox,this.armsBox,this.subBox];
         for(n in this.allBox)
         {
            sib = this.allBox[n];
            sib.setLabelClass(ShopIcon);
            sib.setNum(4,3,721,364);
            sib.x = 208;
            sib.y = 82;
            addChild(sib);
            sib.addEventListener(ClickEvent.ON_CLICK,this.iconClick);
         }
         addChild(this.pageBox);
         this.pageBox.x = 568;
         this.pageBox.y = 450;
      }
      
      public function init() : *
      {
         this.GDG = Game.goodsDefineGroup;
         this.GD = Game.gameData;
         this.fleshAll();
      }
      
      public function clearAll() : *
      {
         var n:* = undefined;
         var labelNameArr:Array = this.switchLabel.label_arr;
         for(n in labelNameArr)
         {
            if(this.hasOwnProperty([labelNameArr[n]]))
            {
               this[labelNameArr[n]].clear();
            }
         }
      }
      
      public function fleshAll() : *
      {
         var n:* = undefined;
         var str0:String = null;
         var arr0:Array = null;
         var labelNameArr:Array = this.switchLabel.label_arr;
         for(n in labelNameArr)
         {
            str0 = labelNameArr[n];
            arr0 = this.GDG[this.FITST_txt + str0];
            if((arr0 == null || arr0.length == 0) && str0 == "materials")
            {
               if(this.GDG.Mmaterials != null && this.GDG.Mmaterials.length > 0)
               {
                  arr0 = this.GDG.Mmaterials;
               }
               else if(this.GDG.materials != null)
               {
                  arr0 = this.GDG.materials;
               }
            }
            if(arr0 == null)
            {
               arr0 = [];
            }
            this[str0 + "Box"].inData_byArr(arr0);
         }
         this.fleshPrice();
         this.showBox(this.switchLabel.nowIndex);
      }
      
      public function fleshPrice() : *
      {
         var n:* = undefined;
         var sib:ShopIconBox = null;
         for(n in this.allBox)
         {
            sib = this.allBox[n];
            sib.fleshPrice_byNow(this.GD.getNowGoodsDefine());
         }
         Game.uiGroup.shopUI.fleshPlayerMoney();
      }
      
      public function showBox_byLabel(label0:String) : *
      {
         var sib:ShopIconBox = null;
         var n:* = undefined;
         this.switchLabel.setChoose_byLabel(label0);
         for(n in this.allBox)
         {
            sib = this.allBox[n];
            sib.visible = false;
         }
         sib = this[label0 + "Box"];
         sib.visible = true;
         this.pageBox.table = sib;
         this.pageBox.fleshByTable();
         if(sib.arr.length == 0)
         {
            this.noGoodsShow.visible = true;
         }
         else
         {
            this.noGoodsShow.visible = false;
         }
         this.pageBox.visible = !this.noGoodsShow.visible;
      }
      
      public function showBox(num:int) : *
      {
         this.showBox_byLabel(this.switchLabel.label_arr[num]);
      }
      
      private function labelClick(event:ClickEvent) : *
      {
         this.showBox(event.index);
      }
      
      private function iconClick(event:ClickEvent) : *
      {
         var icon0:ShopIcon = event.goal;
         this.buy_byGoodsDefine(icon0.itemsData);
      }
      
      public function buy_byGoodsDefine(d0:GoodsDefine) : *
      {
         var mData0:ArmsItemsDataGroup = null;
         var armsName0:String = null;
         var aid0:ArmsItemsData = null;
         var sarr0:Array = null;
         var n4:* = undefined;
         var id0:GoodsItemsData = null;
         var giftBoxArr:Array = null;
         var d_giftBoxArr:Array = null;
         var enough_str:String = null;
         var jnum0:int = 0;
         var cnum0:int = 0;
         var numRepeatB:Boolean = false;
         var surplusNum:int = 0;
         this.nowBuyGoods = d0.copy();
         if(d0.id == "xuehua" || d0.id == "ertongaixin" || d0.specialType == "heartBarter1")
         {
            // Prefer buying snow with Children's Day hearts.
            if(d0.id == "ertongaixin")
            {
               // Keep reverse barter available, but shop entry is mainly for snow.
               this.showMaterialBarter(d0.id);
               return;
            }
            this.showMaterialBarter("xuehua");
            return;
         }
         if(d0.id == "xinchunsongfu" || d0.id == "laodongjie" || d0.specialType == "heartPrice1")
         {
            this.showHeartPriceBuy(d0);
            return;
         }
         var numB0:Boolean = false;
         if(d0.type == "sub" || d0.type == "arms")
         {
            mData0 = this.GD.armsItems;
            if(d0.type == "sub")
            {
               mData0 = this.GD.subItems;
            }
            armsName0 = d0.id.split("_lv")[0];
            aid0 = mData0.getItemsByBase(armsName0,false);
            if(aid0 is ArmsItemsData)
            {
               Game.uiGroup.checkTip.showCheck2("此商品只能购买一次。",3);
               return;
            }
         }
         // custom goods (discount -1000) are purchasable offline at fixed MB price
         if(d0.id == this.GD.subCarLabel)
         {
            Game.uiGroup.checkTip.showCheck2("你已经拥有了此浮游战机机体，不能购买。",3);
            return;
         }
         var s_num0:int = 0;
         if(d0.id == "superalloyStone")
         {
            sarr0 = ["superalloy","superalloy_X","superalloy_Y","superalloy_Z"];
            for(n4 in sarr0)
            {
               id0 = this.GD.materialsItems.getItemsByName(sarr0[n4]);
               if(id0 is GoodsItemsData)
               {
                  s_num0++;
               }
            }
         }
         else if(d0.id == "school_box")
         {
            if(this.GD.checkArms_byIDArr(["schoolArms"]) != "")
            {
               Game.uiGroup.checkTip.showCheck2("您已经拥有了礼盒内武器，无法购买开学礼盒。",3);
               return;
            }
            if(this.GD.carItems.getItemsByBase("conceptSmart") != null)
            {
               Game.uiGroup.checkTip.showCheck2("您已经拥有了礼盒内车身，无法购买开学礼盒。",3);
               return;
            }
            if(this.GD.armsItems.getSurplus() == 0)
            {
               Game.uiGroup.checkTip.showCheck2("您的副武器库空位不足，无法购买开学礼盒。",3);
               return;
            }
            if(this.GD.carItems.getSurplus() == 0)
            {
               Game.uiGroup.checkTip.showCheck2("您的车库空位不足，无法购买开学礼盒。",3);
               return;
            }
         }
         else if(d0.id.indexOf("_giftBox") >= 0)
         {
            giftBoxArr = Game.gameDefine.liveness.getGift_byName(d0.id);
            if(giftBoxArr is Array)
            {
               if(this.GD.livenessData.boughtArr.indexOf(d0.id) >= 0)
               {
                  Game.uiGroup.checkTip.showCheck2("此商品只能购买一次！",3);
                  return;
               }
               d_giftBoxArr = Game.goodsDefineGroup.getArr_byStrArr(giftBoxArr,1,true);
               enough_str = Game.uiGroup.panGift_BagEnough(d_giftBoxArr);
               if(enough_str != "")
               {
                  Game.uiGroup.checkTip.showCheck2(enough_str,3);
                  return;
               }
            }
         }
         if(d0.priceType == "Jprice")
         {
            jnum0 = this.GD.getNowGoodsDefine().Jprice;
            cnum0 = (d0.Jprice - jnum0) * 10;
            if(cnum0 > 0)
            {
               d0.priceType = "Jprice_Mprice";
               d0.Jprice = jnum0;
               d0.Mprice = cnum0;
            }
         }
         if(d0.id == "superalloyStone" && this.GD.materialsItems.getSurplus() < 4 - s_num0)
         {
            Game.uiGroup.checkTip.showCheck2("您的材料背包空位必须大于" + (4 - s_num0) + "个，才能购买超合金原石。",3);
         }
         else if(!this.GD[d0.type + "Items"].getFillB())
         {
            numRepeatB = true;
            surplusNum = int(this.GD[d0.type + "Items"].getSurplus());
            if(d0.type == "props" || d0.type == "materials")
            {
               numB0 = true;
               if(d0.id.indexOf("_chip") > 0)
               {
                  numRepeatB = false;
               }
               if(d0.id.indexOf("subCar") >= 0 || d0.id == "school_box" || d0.id.indexOf("_giftBox") >= 0 || d0.id == "vipCard_4")
               {
                  numB0 = false;
               }
            }
            else
            {
               numRepeatB = false;
            }
            Game.uiGroup.checkTip.showShopCheck(d0,this.yesBuy,numB0,surplusNum,numRepeatB);
         }
         else if(d0.type == "car")
         {
            Game.uiGroup.checkTip.showCheck2("您的车库已满，无法购买商品。",3);
         }
         else
         {
            Game.uiGroup.checkTip.showCheck2("您的背包已满，无法购买商品。",3);
         }
      }
      
      private function showHeartPriceBuy(d0:GoodsDefine) : *
      {
         var heartNum:int = this.GD.materialsItems.getNumByBase("ertongaixin");
         var itemName:String = d0.name != null && d0.name != "" ? d0.name : d0.id;
         if(heartNum < 1)
         {
            Game.uiGroup.checkTip.showCheck2("没有可用于兑换的儿童节爱心。",2);
            return;
         }
         this.nowBuyGoods = d0.copy();
         Game.uiGroup.checkTip.showBarterCheck("儿童节爱心",itemName,heartNum,this.yesHeartPriceBuySelected);
      }

      private function yesHeartPriceBuySelected() : *
      {
         this.heartPriceBuy(Game.uiGroup.checkTip.getSelectedNum());
      }

      private function heartPriceBuy(exchangeNum:int) : *
      {
         var d0:GoodsDefine = this.nowBuyGoods;
         var heartNum:int = this.GD.materialsItems.getNumByBase("ertongaixin");
         var itemName:String = d0 != null && d0.name != null && d0.name != "" ? d0.name : (d0 != null ? d0.id : "");
         if(d0 == null || exchangeNum < 1 || heartNum < exchangeNum)
         {
            Game.uiGroup.checkTip.showCheck2("儿童节爱心数量不足。",2);
            return;
         }
         if(this.GD.materialsItems.getItemsByBase(d0.id) == null && this.GD.materialsItems.getSurplus() <= 0)
         {
            Game.uiGroup.checkTip.showCheck2("材料背包没有空位，无法完成兑换。",2);
            return;
         }
         // 1 Children's Day heart -> 1 item.
         this.GD.materialsItems.useItemsNum("ertongaixin",exchangeNum);
         this.GD.materialsItems.addItems(d0.id,exchangeNum);
         Game.uiGroup.checkTip.showCheck2("兑换成功：" + exchangeNum + "个儿童节爱心 → " + exchangeNum + "个" + itemName + "。",2);
         Game.uiGroup.saveDataNoUI();
         this.fleshAll();
         Game.uiGroup.infoUI.fleshData();
      }

      private function showMaterialBarter(targetId:String) : *
      {
         var sourceId:String = targetId == "xuehua" ? "ertongaixin" : "xuehua";
         var sourceName:String = targetId == "xuehua" ? "儿童节爱心" : "雪花";
         var targetName:String = targetId == "xuehua" ? "雪花" : "儿童节爱心";
         if(this.GD.materialsItems.getNumByBase(sourceId) < 1)
         {
            Game.uiGroup.checkTip.showCheck2("没有可用于兑换的" + sourceName + "。",2);
            return;
         }
         Game.uiGroup.checkTip.showBarterCheck(sourceName,targetName,this.GD.materialsItems.getNumByBase(sourceId),this.yesMaterialBarterSelected);
      }
      
      private function yesMaterialBarterSelected() : *
      {
         this.materialBarter(Game.uiGroup.checkTip.getSelectedNum());
      }
      
      private function yesMaterialBarterAll() : *
      {
         var targetId:String = this.nowBuyGoods.id;
         var sourceId:String = targetId == "xuehua" ? "ertongaixin" : "xuehua";
         this.materialBarter(this.GD.materialsItems.getNumByBase(sourceId));
      }
      
      private function yesMaterialBarterOne() : *
      {
         this.materialBarter(1);
      }
      
      private function yesMaterialBarter() : *
      {
         this.yesMaterialBarterOne();
      }
      
      private function materialBarter(exchangeNum:int) : *
      {
         var targetId:String = this.nowBuyGoods.id;
         var sourceId:String = targetId == "xuehua" ? "ertongaixin" : "xuehua";
         var sourceName:String = targetId == "xuehua" ? "儿童节爱心" : "雪花";
         var targetName:String = targetId == "xuehua" ? "雪花" : "儿童节爱心";
         var sourceNum:int = this.GD.materialsItems.getNumByBase(sourceId);
         if(sourceNum < exchangeNum || exchangeNum < 1)
         {
            Game.uiGroup.checkTip.showCheck2(sourceName + "数量不足。",2);
            return;
         }
         if(this.GD.materialsItems.getItemsByBase(targetId) == null && this.GD.materialsItems.getSurplus() <= 0 && exchangeNum < sourceNum)
         {
            Game.uiGroup.checkTip.showCheck2("材料背包没有空位，无法完成兑换。",2);
            return;
         }
         this.GD.materialsItems.useItemsNum(sourceId,exchangeNum);
         this.GD.materialsItems.addItems(targetId,exchangeNum);
         Game.uiGroup.checkTip.showCheck2("兑换成功：" + exchangeNum + "个" + sourceName + " → " + exchangeNum + "个" + targetName + "。",2);
         Game.uiGroup.saveDataNoUI("雪花与儿童节爱心互换");
         Game.uiGroup.shopUI.fleshPrice();
         Game.uiGroup.infoUI.fleshData();
         this.nowBuyGoods = null;
      }
      
      public function superalloyStoneDismantle(num0:int) : *
      {
         var obj00:Object = Game.gameDefine.addSuperalloy(num0);
         this.GD.materialsItems.addItems("superalloy",obj00.s);
         this.GD.materialsItems.addItems("superalloy_X",obj00.x);
         this.GD.materialsItems.addItems("superalloy_Y",obj00.y);
         this.GD.materialsItems.addItems("superalloy_Z",obj00.z);
         Game.uiGroup.checkTip.showCheck2("已从" + num0 + "个超合金原石中提炼出：\n" + obj00.text,2);
      }
      
      private function yesBuy() : *
      {
         var obj0:ShopBuyObject = null;
         var d0:GoodsDefine = Game.uiGroup.checkTip.buyDefine;
         if(d0.priceType.indexOf("Mprice") == -1)
         {
            this.buyAffterFun();
            Game.uiGroup.saveDataNoUI();
         }
         else
         {
            obj0 = new ShopBuyObject();
            if(Game.gameData.vipData.discount == 1)
            {
               obj0.propId = d0.propId;
            }
            else
            {
               obj0.propId = d0.propId2;
            }
            obj0.price = d0.Mprice / d0.num;
            obj0.count = d0.num;
            obj0.tag = d0.name;
            if(this.nowBuyGoods.type == "car")
            {
               trace("经过payController.decMCoin");
               Game.payController.decMCoin(d0.Mprice,this.buyAffterFun);
            }
            else
            {
               Game.shop_api.buyPropNd(obj0,this.buyAffterFun);
            }
         }
      }
      
      public function buyAffterFun() : *
      {
         var id0:* = undefined;
         var newGood:* = undefined;
         var giftBoxArr:Array = null;
         var totalNum0:int = 0;
         var m:int = 0;
         var obj00:Object = null;
         var coin009:Number = Number(NaN);
         var d_giftBoxArr:Array = null;
         var packnum0:int = 0;
         var trueLabel0:String = null;
         trace("购买成功！！",1);
         var d0:GoodsDefine = this.nowBuyGoods;
         if(d0 == null)
         {
            return;
         }
         if(!d0.getCoinB())
         {
            Game.uiGroup.checkTip.showTip("兑换成功！",1);
         }
         else
         {
            Game.uiGroup.checkTip.showTip("购买成功！",1);
         }
         var buyDefine0:GoodsDefine = Game.uiGroup.checkTip.buyDefine;
         this.GD.delNowGoodsDefine(Game.uiGroup.checkTip.buyDefine);
         if(d0.type == "props" || d0.type == "materials")
         {
            trace("个数：" + buyDefine0.num);
            giftBoxArr = null;
            if(d0.id.indexOf("_giftBox") >= 0)
            {
               giftBoxArr = Game.gameDefine.liveness.getGift_byName(d0.id);
            }
            if(d0.id.indexOf("_chip") > 0)
            {
               totalNum0 = buyDefine0.num;
               m = 0;
               while(m < totalNum0)
               {
                  newGood = this.GD[d0.type + "Items"].addItems(d0.id,1,int(this.GD.level - 3 + Math.random() * 10));
                  m++;
               }
            }
            else if(d0.id == "superalloyStone")
            {
               Game.testText.addTestText("buyDefine0.num：" + buyDefine0.num);
               obj00 = Game.gameDefine.addSuperalloy(buyDefine0.num);
               this.GD.materialsItems.addItems("superalloy",obj00.s);
               this.GD.materialsItems.addItems("superalloy_X",obj00.x);
               this.GD.materialsItems.addItems("superalloy_Y",obj00.y);
               this.GD.materialsItems.addItems("superalloy_Z",obj00.z);
               Game.uiGroup.checkTip.showCheck2("已从" + buyDefine0.num + "个超合金原石中提炼出：\n" + obj00.text,2);
            }
            else if(d0.id == "school_box")
            {
               CarDataCreator.setShopData(this.GD.carItems.addItems("conceptSmart"));
               this.GD.armsItems.addItems("schoolArms_lv1");
               this.GD.addCoin(1000000);
               this.GD.propsItems.addItems("exp_card_double",2);
               Game.uiGroup.checkTip.showCheck2("您获得了开学礼盒内的全部内容。",2);
            }
            else if(d0.id.indexOf("GCoin_card") >= 0)
            {
               id0 = Game.itemsDefineGroup.getDefine(d0.id);
               coin009 = id0.cardValue * buyDefine0.num;
               this.GD.addCoin(coin009);
               Game.uiGroup.checkTip.showCheck2("你获得了 " + coin009 + " G币！",2);
            }
            else if(d0.id.indexOf("subCar_") >= 0)
            {
               this.GD.subCarLabel = d0.id;
               Game.eventGroup.fleshSub();
               Game.uiGroup.carShow.copyAll();
               Game.uiGroup.checkTip.showCheck2("您的浮游战机机体已经改变。",2);
            }
            else if(giftBoxArr is Array)
            {
               d_giftBoxArr = Game.goodsDefineGroup.getArr_byStrArr(giftBoxArr,1,true);
               Game.uiGroup.addGift_byArr(d_giftBoxArr,true,-1,false,true);
               this.GD.livenessData.boughtArr.push(d0.id);
            }
            else
            {
               packnum0 = 1;
               trueLabel0 = d0.id;
               if(d0.id.indexOf("_pack") >= 0)
               {
                  packnum0 = int(d0.id.split("_pack")[1]);
                  trueLabel0 = d0.id.split("_pack")[0];
               }
               newGood = this.GD[d0.type + "Items"].addItems(trueLabel0,buyDefine0.num * packnum0);
            }
         }
         else
         {
            newGood = this.GD[d0.type + "Items"].addItems(d0.id);
         }
         if(d0.type == "car")
         {
            CarDataCreator.setShopData(newGood);
         }
         Game.SG.playSound("buyItems");
         Game.uiGroup.shopUI.fleshPrice();
         Game.uiGroup.infoUI.fleshData();
         this.nowBuyGoods = null;
         if(buyDefine0.priceType == "price")
         {
            if(d0.type == "car")
            {
               if(buyDefine0.price < 4000)
               {
                  Game.uiGroup.zuobile("G币车身价格小于4000。");
               }
            }
            else
            {
               Game.uiGroup.zuobile("M币商品修改成了G币商品！");
            }
         }
      }
   }
}

