package UI._new.change
{
   import UI.ClickEvent;
   import UI._new.icon.ChangeIconBox;
   import UI._new.icon.NormalAllIcon;
   import UI.change.CtrlArmsList;
   import body.define.OneArmsDefine;
   import body.hero.CarDefine;
   import flash.geom.Point;
   import gameAll.NormalMustDefine;
   import gameAll.data.ArmsItemsData;
   import gameAll.data.ArmsItemsDataGroup;
   import gameAll.data.CarItemsData;
   import gameAll.data.CarItemsDataGroup;
   import gameAll.data.GoodsItemsData;
   import gameAll.data.GoodsItemsDataGroup;
   import items.ItemsDefine;
   
   public class CtrlListCtrl
   {
      
      public static var ctrlList:CtrlArmsList;
      
      public static var icon:NormalAllIcon = null;
      
      public static var father:ChangeIconBox = null;
      
      public static var icon2:NormalAllIcon = null;
      
      public static var father2:ChangeIconBox = null;
      
      public static var mustDefine:NormalMustDefine = new NormalMustDefine();
      
      public static var fleshFun:Function = null;
      
      public function CtrlListCtrl()
      {
         super();
      }
      
      public static function iconClick(ic0:NormalAllIcon, fa0:ChangeIconBox) : *
      {
         icon = ic0;
         father = fa0;
         if(father.allType == "arms")
         {
            if(Game.gameState != "no")
            {
               return;
            }
            if(Boolean(armsList()))
            {
               showList(ic0);
            }
            else
            {
               hideList();
            }
         }
         else if(father.allType == "items")
         {
            if(Boolean(itemsList()))
            {
               showList(ic0);
            }
            else
            {
               hideList();
            }
         }
         else if(father.allType == "car")
         {
            if(Boolean(carList()))
            {
               showList(ic0);
            }
            else
            {
               hideList();
            }
         }
      }
      
      public static function showList(ic0:NormalAllIcon) : *
      {
         ctrlList.visible = true;
         var p0:Point = ic0.localToGlobal(new Point());
         ctrlList.x = p0.x;
         ctrlList.y = p0.y;
         if(p0.x < 200)
         {
            ctrlList.x += ctrlList.width + ic0.width;
         }
         if(p0.y > 300)
         {
            ctrlList.y = p0.y + ic0.height - ctrlList.height;
         }
      }
      
      public static function hideList() : *
      {
         ctrlList.visible = false;
      }
      
      public static function ctrlClick(e:ClickEvent) : *
      {
         hideList();
         if(father.allType == "arms")
         {
            armsClick(e.index);
         }
         else if(father.allType == "items")
         {
            itemsClick(e.index);
         }
         else if(father.allType == "car")
         {
            carClick(e.index);
         }
      }
      
      public static function fleshData() : *
      {
         Game.uiGroup._changeUI.bag.showLabel(father.type);
         Game.uiGroup._changeUI.fleshData(false);
         Game.gameData.fleshAdd_byItems();
         Game.uiGroup.allback.info.fleshData();
      }
      
      public static function fleshData2() : *
      {
         Game.uiGroup._changeUI.bag.showLabel(father2.type);
         Game.uiGroup._changeUI.fleshData(false);
         Game.gameData.fleshAdd_byItems();
         Game.uiGroup.allback.info.fleshData();
      }
      
      private static function armsList() : *
      {
         var id0:ArmsItemsData = null;
         var list_arr:Array = null;
         var d0:OneArmsDefine = null;
         var ic0:NormalAllIcon = icon;
         var fa0:ChangeIconBox = father;
         trace("点击：" + fa0.type + "   " + fa0.dataType + "   " + fa0.allType);
         if(ic0.state == "fill")
         {
            id0 = ic0.itemsData;
            list_arr = [];
            if(fa0.dataType == "equip")
            {
               if(ic0.index == 0 && father.type == "arms")
               {
                  list_arr = [2,5];
               }
               else
               {
                  list_arr = [1,2,5];
               }
            }
            else
            {
               d0 = id0.getArmsDefine();
               if(d0.index >= 49)
               {
                  list_arr = [5,3];
               }
               else
               {
                  list_arr = [2,5];
                  if(Game.getTest())
                  {
                     list_arr = [2,5,3];
                  }
               }
               if(d0.installLevel > Game.gameData.level + 1)
               {
                  list_arr.unshift(6);
               }
               else
               {
                  list_arr.unshift(0);
               }
            }
            if(list_arr.length > 0)
            {
               ctrlList.fleshName(list_arr);
               return true;
            }
            return false;
         }
      }
      
      private static function armsClick(index0:int) : *
      {
         var dg0:ArmsItemsDataGroup = null;
         var da0:ArmsItemsData = null;
         var d0:OneArmsDefine = null;
         var sp0:int = 0;
         var str0:* = undefined;
         if(icon.state == "fill")
         {
            dg0 = father.dataGroup;
            da0 = icon.itemsData;
            d0 = da0.define;
            if(index0 == 0)
            {
               if(d0.father == "arms")
               {
                  dg0.bag_to_equip(da0.site,1);
               }
               else
               {
                  dg0.bag_to_equip(da0.site,0);
               }
               fleshData();
            }
            else if(index0 == 1)
            {
               sp0 = dg0.findBagSpace();
               if(sp0 >= 0)
               {
                  dg0.equip_to_bag(da0.site,sp0);
               }
               fleshData();
            }
            else if(index0 == 2)
            {
               Game.uiGroup.gotoResearch(father.type + "_upgrade",da0.getID());
            }
            else if(index0 == 3)
            {
               str0 = "你确定要卖出 <font color=\'#FFFF00\'>" + d0.name + "</font> 吗？";
               str0 += "\n" + "出售价格为：<font color=\'#FFFF00\'>" + d0.getSellPrice() + "</font> G币 。";
               Game.uiGroup.checkTip.showCheck(str0,sellArms);
            }
            else if(index0 == 5)
            {
               Game.uiGroup.gotoResearch(father.type + "_inlay",da0.getID());
            }
            else if(index0 == 6)
            {
               Game.uiGroup.checkTip.showTip("人物等级不足，无法装备此武器。",2);
               Game.SG.playSound("failureItems");
            }
         }
      }
      
      private static function sellArms() : *
      {
         var dg0:ArmsItemsDataGroup = father.dataGroup;
         var da0:ArmsItemsData = icon.itemsData;
         var d0:OneArmsDefine = da0.define;
         dg0.delItems_arr(dg0.arr,da0.id);
         Game.gameData.addCoin(d0.getSellPrice());
         Game.SG.playSound("sellItems");
         father.fleshData();
      }
      
      public static function unlockClick(ic0:NormalAllIcon, fa0:ChangeIconBox) : *
      {
         icon2 = ic0;
         father2 = fa0;
         if(fa0.type == "sub")
         {
            mustDefine = Game.gameDefine.subMust;
         }
         else
         {
            mustDefine = Game.gameDefine.armsMust;
         }
         mustDefine.fleshByIndex(ic0.index);
         Game.uiGroup.checkTip.showMustCheck(mustDefine,"开启这个武器位需要：",unlockCheckTip);
      }
      
      private static function m50_buyCheck() : *
      {
         Game.payController.decMCoin(50,affter_m50_buyCheck,affter_m50_buyCheck2);
      }
      
      private static function affter_m50_buyCheck() : *
      {
         affterBuyCheckTip2();
      }
      
      private static function affter_m50_buyCheck2() : *
      {
         Game.uiGroup.checkTip.showCheck2("M币不足！",2);
      }
      
      private static function unlockCheckTip() : *
      {
         if(mustDefine.MCoin > 0)
         {
            Game.payController.decMCoin(mustDefine.MCoin,affterBuyCheckTip);
         }
         else
         {
            affterBuyCheckTip();
         }
      }
      
      private static function affterBuyCheckTip() : *
      {
         father2.dataGroup.unlockSite(icon2.index);
         Game.gameData.addCoin(-mustDefine.GCoin);
         fleshData2();
         Game.SG.playSound("sellItems");
      }
      
      private static function affterBuyCheckTip2() : *
      {
         father2.dataGroup.unlockSite(icon2.index);
         fleshData2();
         Game.SG.playSound("sellItems");
      }
      
      private static function carList() : *
      {
         var id0:CarItemsData = null;
         var d0:CarDefine = null;
         var list_arr:Array = null;
         var ic0:NormalAllIcon = icon;
         var fa0:ChangeIconBox = father;
         trace("点击：" + fa0.type + "   " + fa0.dataType + "   " + fa0.allType);
         if(ic0.state == "fill")
         {
            id0 = ic0.itemsData;
            d0 = id0.getDefine();
            list_arr = [];
            if(fa0.dataType == "equip")
            {
               if(Game.gameState == "no")
               {
                  if(d0.getType() == "G")
                  {
                     list_arr = [5];
                  }
                  else
                  {
                     list_arr = [2,5];
                  }
               }
            }
            else if(Game.gameState == "no")
            {
               if(d0.getType() == "G")
               {
                  list_arr = [5,3];
               }
               else
               {
                  list_arr = [2,5,3];
               }
               if(id0.getNowInstallLevel() > Game.gameData.level + 1)
               {
                  list_arr.unshift(6);
               }
               else
               {
                  list_arr.unshift(0);
               }
            }
            else
            {
               list_arr = [0,3];
            }
            if(list_arr.length > 0)
            {
               ctrlList.fleshName(list_arr);
               return true;
            }
            return false;
         }
      }
      
      private static function carClick(index0:int) : *
      {
         var dg0:CarItemsDataGroup = null;
         var da0:CarItemsData = null;
         var d0:CarDefine = null;
         var str0:* = undefined;
         if(icon.state == "fill")
         {
            dg0 = father.dataGroup;
            da0 = icon.itemsData;
            d0 = da0.getDefine();
            if(index0 == 0)
            {
               dg0.bag_to_equip(da0.site,0);
               fleshData();
            }
            else if(index0 == 3)
            {
               str0 = "你确定要卖出 <font color=\'#FFFF00\'>" + d0.name + "</font> 吗？";
               str0 += "\n" + "出售价格为：<font color=\'#FFFF00\'>" + da0.getSellPrice() + "</font> G币 。";
               Game.uiGroup.checkTip.showCheck(str0,sellCar);
            }
            else if(index0 == 5)
            {
               gotoCarUpgrade(da0.id,"strengthen");
            }
            else if(index0 == 2)
            {
               gotoCarUpgrade(da0.id);
            }
            else if(index0 == 6)
            {
               Game.uiGroup.checkTip.showTip("人物等级不足，无法装备此车身。",2);
               Game.SG.playSound("failureItems");
            }
         }
         if(Game.gameState != "no")
         {
            Game.eventGroup.fleshArms();
            Game.eventGroup.fleshSub();
            Game.eventGroup.fleshCar();
         }
      }
      
      public static function gotoCarUpgrade(id0:String, type0:String = "upgrade") : *
      {
         Game.uiGroup.menu.show("strengthen");
         Game.uiGroup.researchUI.showBox("car_inlay");
         Game.uiGroup.researchUI.carBox.gotoCar(id0,type0);
      }
      
      private static function sellCar() : *
      {
         var dg0:CarItemsDataGroup = father.dataGroup;
         var da0:CarItemsData = icon.itemsData;
         var d0:CarDefine = da0.getDefine();
         dg0.delItems_arr(dg0.arr,da0.id);
         Game.gameData.addCoin(da0.getSellPrice());
         Game.SG.playSound("sellItems");
         fleshData();
      }
      
      private static function itemsList() : *
      {
         var id0:GoodsItemsData = null;
         var d0:ItemsDefine = null;
         var list_arr:Array = null;
         var ic0:NormalAllIcon = icon;
         var fa0:ChangeIconBox = father;
         if(ic0.state == "fill")
         {
            id0 = ic0.itemsData;
            d0 = id0.getDefine();
            list_arr = [];
            if(d0.type == "card")
            {
               if(d0.cardType == "drop_box" || d0.cardType == "drop_box2" || d0.cardType == "drop_box3")
               {
                  if(id0.nowNum > 1)
                  {
                     list_arr = [4,8];
                  }
                  else
                  {
                     list_arr = [4];
                  }
               }
               else if(d0.cardValue != 0)
               {
                  if(d0.cardValue == -1)
                  {
                     list_arr = [4];
                  }
                  else
                  {
                     list_arr = [4,7];
                  }
               }
            }
            else if(d0.name.indexOf("_fragment") < 0)
            {
               list_arr = [3];
            }
            if(list_arr.length > 0)
            {
               ctrlList.fleshName(list_arr);
               return true;
            }
            return false;
         }
      }
      
      private static function itemsClick(index0:int) : *
      {
         var str0:String = null;
         var obj2:Object = null;
         var dg0:GoodsItemsDataGroup = father.dataGroup;
         var da0:GoodsItemsData = icon.itemsData;
         var d0:ItemsDefine = da0.getDefine();
         if(index0 == 3)
         {
            if(da0.name.indexOf("_chip") >= 0)
            {
               sellItems();
            }
            else
            {
               str0 = "";
               if(da0.nowNum > 1)
               {
                  str0 = "你确定要卖出 <font color=\'#FFFF00\'>" + da0.nowNum + "个" + da0.cnName + "</font> 吗？";
               }
               else
               {
                  str0 = "你确定要卖出 <font color=\'#FFFF00\'>" + da0.cnName + "</font> 吗？";
               }
               str0 += "\n" + "出售价格为：<font color=\'#FFFF00\'>" + da0.getSellPrice() + "</font> G币。";
               Game.uiGroup.checkTip.showCheck(str0,sellItems);
            }
         }
         else if(index0 == 4)
         {
            if(da0.name.indexOf("vipCard") >= 0)
            {
               obj2 = Game.gameData.vipData.useCardPan(da0.name);
               if(Boolean(obj2))
               {
                  if(Boolean(obj2.useB))
                  {
                     Game.uiGroup.checkTip.showCheck2(obj2.txt,1,affter_useVipCard,null);
                  }
                  else
                  {
                     Game.uiGroup.checkTip.showCheck2(obj2.txt,2,null,null,2);
                  }
               }
               else
               {
                  affter_useVipCard();
               }
            }
            else
            {
               Game.IC.useItems(da0,dg0);
            }
            fleshData();
         }
         else if(index0 == 7)
         {
            Game.IC.useItems(da0,dg0,true);
            fleshData();
         }
         else if(index0 == 8)
         {
            Game.IC.requestCoreBatch(da0,dg0);
         }
      }
      
      private static function affter_useVipCard() : *
      {
         Game.IC.useItems(icon.itemsData,father.dataGroup);
         fleshData();
      }
      
      private static function sellItems() : *
      {
         Game.IC.sellItems(icon.itemsData,father.dataGroup);
         fleshData();
      }
   }
}

