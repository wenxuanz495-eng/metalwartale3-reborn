package UI.research
{
   import UI.ClickEvent;
   import UI.DragSprite;
   import UI.items.ItemsBox;
   import UI.items.ItemsIcon;
   import UI.page.PageBox;
   import data.TextWay;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import gameAll.data.GoodsItemsData;
   import gameAll.data.GoodsItemsDataGroup;
   import items.ItemsDefine;
   
   public class ChipBaptizeUI extends DragSprite
   {
      
      internal var _num:String = TextWay.toCode("5");
      
      public var materialsItems:GoodsItemsDataGroup;
      
      public var chipItems:ItemsIcon;
      
      public var mustItems:ItemsIcon;
      
      public var pointer:Sprite;
      
      public var affixBox:ChipAffixGroup;
      
      public var _btn:SimpleButton;
      
      public var bagBack_sp:Sprite;
      
      public var bagItemsBox:ItemsBox = new ItemsBox();
      
      public var pageBox:PageBox;
      
      public var cleanUp_btn:SimpleButton;
      
      public function ChipBaptizeUI()
      {
         super();
      }
      
      public function init() : *
      {
         this.materialsItems = Game.gameData.materialsItems;
         this.bagItemsBox.setLabelClass(ItemsIcon);
         this.bagItemsBox.setNum(5,5,316,335);
         this.bagItemsBox.x = 588;
         this.bagItemsBox.y = 78;
         addChild(this.bagItemsBox);
         this.bagItemsBox.pageBox = this.pageBox;
         this.pageBox.table = this.bagItemsBox;
         addBmp();
         this.affixBox = new ChipAffixGroup();
         addChild(this.affixBox);
         this.affixBox.x = 323;
         this.affixBox.y = 143;
         this.addEventListener(MouseEvent.MOUSE_UP,this.mouseUp);
         this.bagItemsBox.addEventListener(ClickEvent.ON_DOWN,this.iconDown);
         this.bagItemsBox.addEventListener(ClickEvent.ON_UP,this.iconUp);
         this.chipItems.addEventListener(MouseEvent.MOUSE_DOWN,this.iconDown);
         this.chipItems.addEventListener(MouseEvent.MOUSE_UP,this.iconUp);
         this.bagBack_sp.addEventListener(MouseEvent.MOUSE_UP,this.bagBackUp);
         this._btn.addEventListener(MouseEvent.CLICK,this.btnClick);
         this.cleanUp_btn.addEventListener(MouseEvent.CLICK,this.clearUpBag);
      }
      
      public function getMustX() : int
      {
         return int(TextWay.getText(this._num)) * (this.affixBox.getLockNum() + 1);
      }
      
      public function fleshAll() : *
      {
         this.fleshBag();
         this.fleshChip();
         this.fleshMust();
      }
      
      public function fleshBag() : *
      {
         var arr0:Array = this.materialsItems.getArr_byName("green_chip");
         var purpleArr:Array = ["purple_chip","ben_purple_chip","zhui_purple_chip","jing_purple_chip","zu_purple_chip","zhen_purple_chip","lie_purple_chip","nu_purple_chip","kuang_purple_chip","hong_purple_chip","ji_purple_chip"];
         arr0 = arr0.concat(this.materialsItems.getArr_byNameArr(purpleArr));
         this.bagItemsBox.inData_byItems(arr0);
         this.pageBox.table = this.bagItemsBox;
         this.pageBox.fleshByTable();
      }
      
      public function fleshChip() : *
      {
         var d0:GoodsItemsData = this.chipItems.itemsData;
         if(d0 is GoodsItemsData)
         {
            this.affixBox.inNewChip(d0);
         }
         else
         {
            this.affixBox.clear();
         }
      }
      
      public function fleshMust() : *
      {
         var id0:ItemsDefine = Game.itemsDefineGroup.getDefine("superalloy_X");
         this.mustItems.inData_byDefine(id0);
         var xnum0:int = Game.gameData.getNowGoodsDefine().Xprice;
         this.mustItems.setMustNum(xnum0,this.getMustX());
         var allLockB:Boolean = this.affixBox.getLockNum() == this.affixBox.arr.length;
         if(xnum0 < this.getMustX() || this.chipItems.state != "fill" || allLockB)
         {
            this._btn.mouseEnabled = false;
            this._btn.alpha = 0.4;
         }
         else
         {
            this._btn.mouseEnabled = true;
            this._btn.alpha = 1;
         }
      }
      
      private function iconOver(event:ClickEvent) : *
      {
      }
      
      private function iconOut(event:ClickEvent) : *
      {
      }
      
      private function iconDown(event:*) : *
      {
         if(event is ClickEvent)
         {
            dragTarget = event.goal;
            dragFather = event.target;
         }
         else
         {
            dragTarget = event.target;
            dragFather = null;
         }
         if(dragTarget.state == "fill")
         {
            startDraging();
         }
         else
         {
            dragTarget = null;
            dragFather = null;
         }
      }
      
      private function iconUp(event:*) : *
      {
         var iai_d:GoodsItemsData = null;
         var dd1:GoodsItemsData = null;
         var drag_d:GoodsItemsData = null;
         var copy_d:GoodsItemsData = null;
         var dd0:GoodsItemsData = null;
         if(dragTarget is ItemsIcon)
         {
            iconOverB = true;
            if(event is ClickEvent)
            {
               if(dragFather == null)
               {
                  iai_d = event.goal.itemsData;
                  this.materialsItems.useItemsData(iai_d);
                  dd1 = this.chipItems.itemsData;
                  dd1 = this.materialsItems.addItemsData(dd1.copy(1),1,dd1.newB);
                  dd1.site = iai_d.site;
                  this.chipItems.clearData();
                  this.chipItems.inData_byItems(iai_d.copy(1));
               }
            }
            else if(dragFather != null)
            {
               drag_d = dragTarget.itemsData;
               copy_d = drag_d.copy(1);
               this.materialsItems.useItemsData(drag_d);
               if(this.chipItems.state == "fill")
               {
                  dd0 = this.chipItems.itemsData;
                  dd0 = this.materialsItems.addItemsData(dd0.copy(1),1,dd0.newB);
                  dd0.site = drag_d.site;
               }
               this.chipItems.clearData();
               this.chipItems.inData_byItems(copy_d);
            }
            this.fleshAll();
            Game.SG.playSound("dragDown");
            stopDraging();
         }
      }
      
      private function bagBackUp(event:MouseEvent) : *
      {
         if(dragTarget == this.chipItems)
         {
            this.chipReturn_noFlesh();
            this.fleshAll();
            Game.SG.playSound("dragDown");
            stopDraging();
         }
      }
      
      private function mouseUp(event:MouseEvent) : *
      {
         if(dragTarget is ItemsIcon)
         {
            stopDraging();
            Game.SG.playSound("dragDown");
         }
      }
      
      public function chipReturn_noFlesh() : *
      {
         var d0:GoodsItemsData = this.chipItems.itemsData;
         if(d0 is GoodsItemsData)
         {
            this.materialsItems.addItemsData(d0.copy(1),1,d0.newB);
            this.chipItems.clearData();
         }
      }
      
      public function chipReturn() : *
      {
         this.chipReturn_noFlesh();
         this.fleshAll();
      }
      
      public function clearUpBag(e:*) : *
      {
         Game.uiGroup.changeUI.materialsUI.clearUpBag();
         this.fleshBag();
      }
      
      public function clear() : *
      {
         this.chipItems.clearData();
      }
      
      public function btnClick(e:*) : *
      {
         if(!this._btn.mouseEnabled)
         {
            return;
         }
         Game.gameData.materialsItems.useItemsNum("superalloy_X",this.getMustX());
         this.repeat();
         this.fleshMust();
         Game.uiGroup.checkTip.showTip("芯片重置成功！",1);
         Game.SG.playSound("upgradeArms");
      }
      
      public function repeat() : *
      {
         this.affixBox.repeat(this.chipItems.itemsData);
      }
   }
}

