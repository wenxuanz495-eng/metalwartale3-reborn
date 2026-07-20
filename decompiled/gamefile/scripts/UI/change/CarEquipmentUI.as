package UI.change
{
   import UI.ClickEvent;
   import UI.dialog.ItemsTipbox;
   import UI.icon.ItemsCarIcon;
   import UI.page.PageBox;
   import body.hero.CarDefine;
   import data.Maths;
   import data.StringToDefine;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import gameAll.data.CarItemsData;
   import gameAll.data.CarItemsDataGroup;
   
   public class CarEquipmentUI extends MovieClip
   {
      
      public var itemsData:CarItemsDataGroup;
      
      public var nowArms:CarIconBox = new CarIconBox("equip",true);
      
      public var nowArmsType:Array = [0];
      
      public var equipSite:int = 0;
      
      public var tempEquipSite:int = 6;
      
      public var bagArms:CarIconBox = new CarIconBox("bag",false);
      
      public var ctrlList:CtrlArmsList = new CtrlArmsList();
      
      public var nowCtrl:ItemsCarIcon;
      
      public var buySiteBtn:CtrlArmsButton = new CtrlArmsButton();
      
      public var buyTarget:*;
      
      public var pageBox:PageBox;
      
      private var dragTarget:*;
      
      private var dragFather:*;
      
      private var dragBmp:Bitmap = new Bitmap();
      
      private var dragBmpSp:Sprite = new Sprite();
      
      private var dragPoint:Point = new Point();
      
      private var iconOverB:Boolean = false;
      
      private var tipBox:ItemsTipbox = new ItemsTipbox();
      
      private var tip_mc:CarItemsTip = new CarItemsTip();
      
      public var gotoShop_btn:SimpleButton;
      
      public function CarEquipmentUI()
      {
         super();
      }
      
      protected function initData() : *
      {
         this.itemsData = Game.gameData.carItems;
      }
      
      public function init() : *
      {
         this.initData();
         this.addEventListener(MouseEvent.MOUSE_UP,this.mouseUp);
         this.gotoShop_btn.addEventListener(MouseEvent.CLICK,this.gotoShopCar);
         this.nowArms.setNum(1,3,240,300);
         this.nowArms.x = 37 + 47 * 2;
         this.nowArms.y = 110;
         this.nowArms.addEventListener(ClickEvent.ON_DOWN,this.iconDown);
         this.nowArms.addEventListener(ClickEvent.ON_UP,this.iconUp);
         this.nowArms.addEventListener(ClickEvent.ON_OVER,this.iconOver);
         this.nowArms.addEventListener(ClickEvent.ON_OUT,this.iconOut);
         this.nowArms.setTotalNum(8);
         this.fleshNowArms();
         addChild(this.nowArms);
         this.bagArms.setNum(1,3,240,300);
         this.bagArms.x = 687 + 4;
         this.bagArms.y = 110;
         this.bagArms.addEventListener(ClickEvent.ON_DOWN,this.iconDown);
         this.bagArms.addEventListener(ClickEvent.ON_UP,this.iconUp);
         this.bagArms.addEventListener(ClickEvent.ON_OVER,this.iconOver);
         this.bagArms.addEventListener(ClickEvent.ON_OUT,this.iconOut);
         addChild(this.bagArms);
         this.fleshBagArms();
         this.dragBmpSp.addChild(this.dragBmp);
         this.dragBmpSp.mouseChildren = false;
         this.dragBmpSp.mouseEnabled = false;
         addChild(this.dragBmpSp);
         this.tipBox.inBackData(Game.swfLoaderManager.getResource("dialogbox","Dialogbox_mc3"));
         this.tipBox.visible = false;
         this.tipBox.mouseChildren = false;
         this.tipBox.mouseEnabled = false;
         addChild(this.tipBox);
         this.tip_mc.visible = false;
         this.tip_mc.mouseChildren = false;
         this.tip_mc.mouseEnabled = false;
         addChild(this.tip_mc);
         addChild(this.ctrlList);
         this.ctrlList.addEventListener(ClickEvent.ON_CLICK,this.ctrlClick);
         this.ctrlList.visible = false;
         this.buySiteBtn.setText("购买");
         addChild(this.buySiteBtn);
         this.buySiteBtn.overTextShowB = false;
         this.buySiteBtn.txt.visible = false;
         this.buySiteBtn.visible = false;
         this.buySiteBtn.addEventListener(MouseEvent.CLICK,this.buyClick);
         this.buySiteBtn.addEventListener(MouseEvent.MOUSE_OUT,this.buyOut);
      }
      
      public function fleshAll() : *
      {
         this.fleshBagArms();
         this.fleshNowArms();
         Game.eventGroup.fleshCar();
         Game.gameData.fleshAdd_byItems();
         Game.uiGroup.carShow.copyAll();
         Game.gameData.setLife(1,"mul");
      }
      
      public function fleshAll_noChange() : *
      {
         this.fleshBagArms();
         this.fleshNowArms();
         Game.eventGroup.fleshCar();
      }
      
      public function tweenShow() : *
      {
      }
      
      private function fleshBagArms() : *
      {
         this.bagArms.inData(this.itemsData);
         this.pageBox.table = this.bagArms;
         this.pageBox.fleshByTable();
      }
      
      private function fleshNowArms() : *
      {
         this.nowArms.inData(this.itemsData);
         this.nowArms.setTypeByArr(this.nowArmsType);
         this.nowArms.setStateByArr(this.itemsData.armsState);
      }
      
      public function gotoShopCar(e:*) : *
      {
         Game.uiGroup.gotoShop("car");
         Game.uiGroup.shopUI.gotoBackState = Game.uiGroup.changeUI.return_btn.text;
      }
      
      private function loadEquip(iai:ItemsCarIcon, site0:int = 0) : *
      {
         var id0:String = iai.itemsID;
         this.itemsData.loadEquip(id0,site0);
         this.fleshBagArms();
         this.fleshNowArms();
         this.pageBox.table = this.bagArms;
         this.pageBox.fleshByTable();
      }
      
      private function unloadEquip(iai:ItemsCarIcon, site0:int = 0) : *
      {
         var id0:String = iai.itemsID;
         this.itemsData.unloadEquip(id0,site0);
         this.fleshBagArms();
         this.fleshNowArms();
         this.pageBox.table = this.bagArms;
         this.pageBox.fleshByTable();
      }
      
      private function swapEquip(iai0:ItemsCarIcon, iai1:ItemsCarIcon) : *
      {
         this.itemsData.equipToBag(iai0.itemsID,iai1.itemsID);
         this.fleshBagArms();
         this.fleshNowArms();
         this.pageBox.table = this.bagArms;
         this.pageBox.fleshByTable();
      }
      
      private function ctrlClick(event:ClickEvent) : *
      {
         var sp0:int = 0;
         var id0:CarItemsData = null;
         var d0:CarDefine = null;
         var str0:* = undefined;
         var index0:int = event.index;
         if(this.nowCtrl != null)
         {
            trace("event.index  " + event.index);
            if(index0 == 0)
            {
               this.itemsData.bag_to_equip(this.nowCtrl.itemsData.site,this.equipSite);
               this.fleshAll();
            }
            else if(index0 == 1)
            {
               sp0 = this.itemsData.findBagSpace();
               trace("背包空位：" + sp0);
               if(sp0 >= 0)
               {
                  this.itemsData.bag_to_equip(sp0,this.nowCtrl.itemsData.site);
               }
               this.fleshAll();
            }
            else if(index0 == 3)
            {
               id0 = this.nowCtrl.itemsData;
               d0 = id0.getArmsDefine();
               str0 = "你确定要卖出 <font color=\'#FFFF00\'>" + d0.name + "</font> 吗？";
               str0 += "\n" + "出售价格为：<font color=\'#FFFF00\'>" + id0.getSellPrice() + "</font> G币 。";
               Game.uiGroup.checkTip.showCheck(str0,this.sellArms);
            }
            else if(index0 == 6)
            {
               Game.uiGroup.checkTip.showTip("人物等级不够，无法装备此车身。",2);
               Game.SG.playSound("failureItems");
            }
            else if(index0 == 5)
            {
               this.gotoCarUpgrade(this.nowCtrl.itemsData.id);
            }
         }
         this.ctrlList.visible = false;
      }
      
      public function gotoCarUpgrade(id0:String) : *
      {
         Game.uiGroup.menu.show("strengthen");
         Game.uiGroup.researchUI.showBox("car_inlay");
         Game.uiGroup.researchUI.carBox.gotoCar(id0);
      }
      
      private function sellArms() : *
      {
         var id0:CarItemsData = null;
         var d0:CarDefine = null;
         if(this.nowCtrl != null)
         {
            id0 = this.nowCtrl.itemsData;
            d0 = id0.getArmsDefine();
            this.itemsData.delItems_arr(this.itemsData.arr,id0.id);
            Game.gameData.addCoin(id0.getSellPrice());
            Game.SG.playSound("sellItems");
            this.fleshAll();
         }
      }
      
      private function buyClick(event:MouseEvent) : *
      {
         trace("购买购买购买");
         this.buySiteBtn.visible = false;
         this.buyTarget = null;
      }
      
      private function buyOut(event:MouseEvent) : *
      {
         this.buySiteBtn.visible = false;
         this.buyTarget = null;
      }
      
      private function iconClick(event:ClickEvent) : *
      {
      }
      
      private function iconOver(event:ClickEvent) : *
      {
         var iai:ItemsCarIcon = null;
         iai = event.goal;
         if(this.dragTarget == null)
         {
            if(this.iconOverB)
            {
               this.iconOverB = false;
            }
            else
            {
               if(iai.state == "fill")
               {
                  this.tip_mc.inData(iai.itemsData);
                  this.tipBox.showDialog(this.tip_mc,iai,iai.x + event.target.x,iai.y + event.target.y);
               }
               this.ctrlList.visible = false;
            }
            if(iai.state == "lock" && this.ctrlList.visible == false && !this.iconOverB)
            {
               this.buySiteBtn.visible = true;
               this.buyTarget = iai;
               this.buySiteBtn.x = iai.x + event.target.x + iai.width / 2 - this.buySiteBtn.width / 2;
               this.buySiteBtn.y = iai.y + event.target.y + iai.height / 2 - this.buySiteBtn.height / 2;
            }
         }
      }
      
      private function iconOut(event:ClickEvent) : *
      {
         this.tipBox.hide();
      }
      
      private function iconDown(event:ClickEvent) : *
      {
         var iai:ItemsCarIcon = event.goal;
         if(iai.state == "fill")
         {
            this.tipBox.hide();
            this.dragTarget = event.goal;
            this.dragFather = event.target;
            this.startDraging();
         }
      }
      
      private function iconUp(event:ClickEvent) : *
      {
         var box0:* = undefined;
         var iai:ItemsCarIcon = null;
         var d20:CarDefine = null;
         var d22:CarDefine = null;
         var d21:CarDefine = null;
         var arr3:Array = null;
         if(this.dragTarget is ItemsCarIcon)
         {
            this.iconOverB = true;
            box0 = event.target;
            iai = event.goal;
            if(iai.type == 3)
            {
               this.stopDraging();
               return;
            }
            if(iai != this.dragTarget)
            {
               if(box0.type == "equip" && this.dragFather.type == "bag")
               {
                  if(iai.type == 2 && this.dragTarget.type != 2 || iai.type != 2 && this.dragTarget.type == 2)
                  {
                     trace("临时武器和其它武器不能互换");
                  }
                  else if(iai.state == "fill")
                  {
                     d20 = this.itemsData.getItemsById(this.dragTarget.itemsID).getArmsDefine();
                     if(d20.mustLevel > Game.gameData.level + 1)
                     {
                        Game.uiGroup.checkTip.showTip("人物等级不够，无法装备此车身。",2);
                        Game.SG.playSound("failureItems");
                     }
                     else
                     {
                        this.itemsData.bagEquip_id(this.dragTarget.itemsID,iai.site);
                        this.fleshAll();
                     }
                  }
               }
               else if(box0.type == "bag" && this.dragFather.type == "bag")
               {
                  if(iai.state == "blank")
                  {
                     this.itemsData.swapBagSpace(this.dragTarget.itemsID,iai.site);
                  }
                  else
                  {
                     this.itemsData.swapBag(iai.itemsID,this.dragTarget.itemsID);
                  }
                  this.fleshBagArms();
               }
               else if(box0.type == "bag" && this.dragFather.type == "equip")
               {
                  if((iai.type == 2 && this.dragTarget.type != 2 || iai.type != 2 && this.dragTarget.type == 2) && iai.state != "blank")
                  {
                     trace("临时武器和其它武器不能互换");
                  }
                  else if(iai.state == "fill")
                  {
                     d22 = this.itemsData.getItemsById(iai.itemsID).getArmsDefine();
                     if(d22.mustLevel > Game.gameData.level + 1)
                     {
                        Game.uiGroup.checkTip.showTip("人物等级不够，无法装备此车身。",2);
                        Game.SG.playSound("failureItems");
                     }
                     else
                     {
                        this.itemsData.equipBag_id(this.dragTarget.itemsID,iai.site);
                        this.fleshAll();
                     }
                  }
               }
               Game.SG.playSound("dragDown");
            }
            else if(iai.state == "fill")
            {
               if(this.dragTarget is ItemsCarIcon && this.dragTarget == event.goal)
               {
                  d21 = this.dragTarget.itemsData.getArmsDefine();
                  if(box0.type == "equip")
                  {
                     if(d21.mustLevel >= 10 && Game.gameState != "gaming")
                     {
                        this.ctrlList.fleshName([5]);
                        this.ctrlList.x = iai.x + iai.width + this.ctrlList.width + this.nowArms.x;
                        this.nowCtrl = iai;
                        this.ctrlList.y = iai.y + this.bagArms.y;
                        this.ctrlList.visible = true;
                     }
                  }
                  else
                  {
                     arr3 = [];
                     if(d21.mustLevel > Game.gameData.level + 1)
                     {
                        arr3 = [6,3];
                     }
                     else
                     {
                        arr3 = [0,3];
                     }
                     if(d21.mustLevel >= 10 && Game.gameState != "gaming")
                     {
                        arr3.push(5);
                     }
                     this.ctrlList.fleshName(arr3);
                     this.ctrlList.x = iai.x + this.bagArms.x;
                     this.nowCtrl = iai;
                     this.ctrlList.y = iai.y + this.bagArms.y;
                     this.ctrlList.visible = true;
                     this.buySiteBtn.visible = false;
                  }
               }
            }
            this.stopDraging();
         }
      }
      
      private function mouseUp(event:MouseEvent) : *
      {
         if(this.dragTarget is ItemsCarIcon)
         {
            this.stopDraging();
            this.ctrlList.visible = false;
            Game.SG.playSound("dragDown");
         }
      }
      
      private function mouseClick(event:MouseEvent) : *
      {
         trace("asdfasdfsadf");
      }
      
      private function startDraging() : *
      {
         if(this.dragTarget != null)
         {
            this.ctrlList.visible = false;
            this.dragBmp.bitmapData = StringToDefine.getBmp(this.dragTarget.icon);
            this.dragBmpSp.visible = false;
            this.dragPoint.x = this.mouseX;
            this.dragPoint.y = this.mouseY;
         }
         this.addEventListener(Event.ENTER_FRAME,this.dragIcon);
      }
      
      private function stopDraging(event:MouseEvent = null) : *
      {
         this.removeEventListener(Event.ENTER_FRAME,this.dragIcon);
         this.dragTarget.iconReturn();
         this.dragTarget = null;
         this.dragFather = null;
         this.dragBmp.bitmapData.dispose();
         this.dragBmpSp.visible = false;
      }
      
      private function dragIcon(event:Event) : *
      {
         var len:* = Maths.Long(this.dragPoint.x - mouseX,this.dragPoint.y - mouseY);
         if(len > 10)
         {
            this.dragBmpSp.visible = true;
            this.dragTarget.iconLeave();
            this.dragBmpSp.x = this.mouseX - this.dragBmpSp.width / 2;
            this.dragBmpSp.y = this.mouseY - this.dragBmpSp.height + 10;
         }
      }
   }
}

