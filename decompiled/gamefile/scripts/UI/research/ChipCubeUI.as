package UI.research
{
   import UI.ClickEvent;
   import UI.DragSprite;
   import UI.items.ItemsBox;
   import UI.items.ItemsIcon;
   import UI.page.PageBox;
   import data.StringToDefine;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import gameAll.data.GoodsItemsData;
   import gameAll.data.GoodsItemsDataGroup;
   import items.ItemsDefine;
   
   public class ChipCubeUI extends DragSprite
   {
      
      public var materialsItems:GoodsItemsDataGroup;
      
      public var chipItemsBox:ItemsBox = new ItemsBox("bag",true);
      
      public var chipItemsData:GoodsItemsDataGroup = new GoodsItemsDataGroup();
      
      public var pointer:Sprite;
      
      public var cubeItems:ItemsIcon;
      
      public var coinTxt:TextField;
      
      public var cube_btn:SimpleButton;
      
      public var info_txt:TextField;
      
      public var bagBack_sp:Sprite;
      
      public var bagItemsBox:ItemsBox = new ItemsBox();
      
      public var pageBox:PageBox;
      
      public var cleanUp_btn:SimpleButton;
      
      public function ChipCubeUI()
      {
         super();
      }
      
      public function init() : *
      {
         this.materialsItems = Game.gameData.materialsItems;
         this.chipItemsBox.setLabelClass(ItemsIcon);
         this.chipItemsBox.setNum(2,2,135,127);
         this.chipItemsBox.setTotalNum(4);
         this.chipItemsBox.x = 357;
         this.chipItemsBox.y = 132;
         addChild(this.chipItemsBox);
         this.bagItemsBox.setLabelClass(ItemsIcon);
         this.bagItemsBox.setNum(5,5,316,335);
         this.bagItemsBox.x = 588;
         this.bagItemsBox.y = 78;
         addChild(this.bagItemsBox);
         this.bagItemsBox.pageBox = this.pageBox;
         this.pageBox.table = this.bagItemsBox;
         addBmp();
         this.addEventListener(MouseEvent.MOUSE_UP,this.mouseUp);
         this.bagItemsBox.addEventListener(ClickEvent.ON_DOWN,this.iconDown);
         this.bagItemsBox.addEventListener(ClickEvent.ON_UP,this.iconUp);
         this.chipItemsBox.addEventListener(ClickEvent.ON_DOWN,this.iconDown);
         this.chipItemsBox.addEventListener(ClickEvent.ON_UP,this.iconUp);
         this.bagBack_sp.addEventListener(MouseEvent.MOUSE_UP,this.bagBackUp);
         this.cube_btn.addEventListener(MouseEvent.CLICK,this.btnClick);
         this.cleanUp_btn.addEventListener(MouseEvent.CLICK,this.clearUpBag);
         this.fleshInfoText();
      }
      
      public function fleshAll() : *
      {
         this.fleshBag();
         this.fleshChip();
         this.chipPan();
      }
      
      public function fleshBag() : *
      {
         var arr0:Array = this.materialsItems.getArr_byNameArr(["white_chip","blue_chip","yellow_chip","orange_chip","green_chip"]);
         this.bagItemsBox.inData_byItems(arr0);
         this.pageBox.table = this.bagItemsBox;
         this.pageBox.fleshByTable();
      }
      
      public function fleshChip() : *
      {
         this.chipItemsBox.inData_byItems(this.chipItemsData.arr,4);
      }
      
      public function fleshInfoText() : *
      {
         this.info_txt.htmlText = "把背包中的芯片拖入此处，保证4个都是" + StringToDefine.getFontColor("同颜色","#FFFF00") + "芯片。";
      }
      
      public function chipPan() : *
      {
         var n:* = undefined;
         var mustCoin:int = 0;
         var mustCoinB:Boolean = false;
         var notEnough_str:String = null;
         var chip0:GoodsItemsData = null;
         var d0:ItemsDefine = null;
         this.fleshInfoText();
         var level0:int = 1;
         var allLevel0:int = 0;
         var chipNumB:Boolean = this.chipItemsData.arr.length == 4;
         var nameSameB:Boolean = true;
         var oneName0:String = "";
         for(n in this.chipItemsData.arr)
         {
            chip0 = this.chipItemsData.arr[n];
            allLevel0 += chip0.affixLevel;
            if(chip0.name == "green_chip")
            {
               nameSameB = false;
               this.info_txt.htmlText = StringToDefine.getFontColor("不能有绿色芯片。","#FF33FF");
               break;
            }
            if(n == 0)
            {
               oneName0 = chip0.name;
            }
            else if(oneName0 != chip0.name)
            {
               nameSameB = false;
               this.info_txt.htmlText = StringToDefine.getFontColor("芯片颜色不同。","#FF33FF");
               break;
            }
         }
         level0 = allLevel0 / this.chipItemsData.arr.length;
         mustCoin = this.getMustCoin();
         mustCoinB = Game.gameData.GCoin >= mustCoin;
         notEnough_str = "";
         if(!mustCoinB)
         {
            notEnough_str = StringToDefine.getFontColor("（不足）","#FF0000");
         }
         this.coinTxt.htmlText = StringToDefine.getFontColor("所需G币：" + mustCoin,"#FFFF00") + "\n" + StringToDefine.getFontColor("当前G币：" + Game.gameData.GCoin,"#CCCCCC") + notEnough_str;
         if(chipNumB && nameSameB && mustCoinB)
         {
            this.pointer.visible = true;
            this.cube_btn.mouseEnabled = true;
            this.cube_btn.alpha = 1;
            d0 = Game.itemsDefineGroup.getDefine(this.getNextChip());
            d0.affixLevel = level0;
            this.cubeItems.inData_byDefine(d0);
         }
         else
         {
            this.pointer.visible = false;
            this.cube_btn.mouseEnabled = false;
            this.cube_btn.alpha = 0.4;
            this.cubeItems.clear();
         }
      }
      
      public function getNowChip() : String
      {
         if(this.chipItemsData.arr.length > 0)
         {
            return this.chipItemsData.arr[0].name;
         }
         return "";
      }
      
      public function getMustCoin() : int
      {
         if(this.chipItemsData.arr.length > 0)
         {
            return Game.gameDefine.getChipCubeMustCoin(this.getNowChip());
         }
         return 0;
      }
      
      public function getNextChip() : String
      {
         var str0:String = this.getNowChip();
         var arr0:Array = ["white_chip","blue_chip","yellow_chip","orange_chip","green_chip"];
         var index0:int = arr0.indexOf(str0);
         if(index0 + 2 <= arr0.length)
         {
            return arr0[index0 + 1];
         }
         return "";
      }
      
      private function iconOver(event:ClickEvent) : *
      {
      }
      
      private function iconOut(event:ClickEvent) : *
      {
      }
      
      private function iconDown(event:ClickEvent) : *
      {
         var iai:ItemsIcon = event.goal;
         if(iai.state == "fill")
         {
            dragTarget = event.goal;
            dragFather = event.target;
            startDraging();
         }
      }
      
      private function iconUp(event:ClickEvent) : *
      {
         var father0:* = undefined;
         var iai:ItemsIcon = null;
         var iai_d:GoodsItemsData = null;
         var iai_copy_d:GoodsItemsData = null;
         var drag_d:GoodsItemsData = null;
         var copy_d:GoodsItemsData = null;
         if(dragTarget is ItemsIcon)
         {
            iconOverB = true;
            father0 = event.target;
            iai = event.goal;
            drag_d = dragTarget.itemsData;
            copy_d = drag_d.copy(1);
            if(dragFather != father0)
            {
               if(father0 == this.chipItemsBox)
               {
                  this.materialsItems.useItemsData(drag_d);
                  this.chipItemsData.addItemsData(copy_d,1,false);
                  copy_d.site = iai.site;
                  if(iai.state == "fill")
                  {
                     iai_d = iai.itemsData;
                     this.chipItemsData.useItemsData(iai_d);
                     this.materialsItems.addItemsData(iai_d.copy(1));
                  }
               }
               else
               {
                  this.chipItemsData.useItemsData(drag_d);
                  this.materialsItems.addItemsData(copy_d,1,false);
                  if(iai.state == "fill")
                  {
                     iai_d = iai.itemsData;
                     iai_copy_d = iai_d.copy(1);
                     this.materialsItems.useItemsData(iai_d);
                     this.chipItemsData.addItemsData(iai_copy_d,1,false);
                     iai_copy_d.site = drag_d.site;
                  }
               }
            }
            this.fleshAll();
            Game.SG.playSound("dragDown");
            stopDraging();
         }
      }
      
      private function bagBackUp(event:MouseEvent) : *
      {
         var drag_d:GoodsItemsData = null;
         var copy_d:GoodsItemsData = null;
         if(dragTarget != null && dragFather != this.bagItemsBox)
         {
            drag_d = dragTarget.itemsData;
            copy_d = drag_d.copy(1);
            this.chipItemsData.useItemsData(drag_d);
            this.materialsItems.addItemsData(copy_d,1,false);
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
      
      public function chipReturn() : *
      {
         var n:* = undefined;
         var chip0:GoodsItemsData = null;
         for(n in this.chipItemsData.arr)
         {
            chip0 = this.chipItemsData.arr[n];
            this.materialsItems.addItemsData(chip0,1,false);
         }
         this.chipItemsData.arr.length = 0;
         this.fleshAll();
      }
      
      public function clearUpBag(e:*) : *
      {
         Game.uiGroup.changeUI.materialsUI.clearUpBag();
         this.fleshBag();
      }
      
      public function clear() : *
      {
         this.chipItemsData.arr.length = 0;
      }
      
      public function btnClick(e:*) : *
      {
         if(!this.cube_btn.mouseEnabled)
         {
            return;
         }
         Game.gameData.addCoin(-this.getMustCoin());
         this.chipItemsData.arr.length = 0;
         this.materialsItems.addItemsDefine(this.cubeItems.itemsData);
         Game.gameData.livenessData.addTaskNum("chip_cube");
         Game.uiGroup.checkTip.showTip("芯片合成成功！",1);
         Game.SG.playSound("upgradeArms");
         this.fleshAll();
         Game.uiGroup.saveDataNoUI();
      }
   }
}

