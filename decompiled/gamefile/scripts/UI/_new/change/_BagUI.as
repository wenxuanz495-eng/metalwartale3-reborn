package UI._new.change
{
   import UI.ClickEvent;
   import UI._new.icon.ChangeIconBox;
   import UI.change.OneKeySellCarUI;
   import UI.change.OneKeySellUI;
   import UI.label.LabelCtrl;
   import body.hero.CarDefine;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import gameAll.NormalMustDefine;
   import gameAll.data.CarItemsData;
   import gameAll.data.CarItemsDataGroup;
   import gameAll.data.GoodsItemsDataGroup;
   
   public class _BagUI extends Sprite
   {
      
      public var label:LabelCtrl;
      
      public var light_sp:Sprite;
      
      public var car_btn:SimpleButton;
      
      public var arms_btn:SimpleButton;
      
      public var sub_btn:SimpleButton;
      
      public var props_btn:SimpleButton;
      
      public var materials_btn:SimpleButton;
      
      public var carBox:ChangeIconBox;
      
      public var armsBox:ChangeIconBox;
      
      public var subBox:ChangeIconBox;
      
      public var propsBox:ChangeIconBox;
      
      public var materialsBox:ChangeIconBox;
      
      public var box_arr:Array;
      
      public var cleanUp_btn:SimpleButton;
      
      public var oneSell_btn:SimpleButton;
      
      public var unlockBag_btn:SimpleButton;
      
      public var oneSell_box:OneKeySellUI;
      
      public var oneSellCar_box:OneKeySellCarUI;
      
      public function _BagUI()
      {
         var box0:ChangeIconBox = null;
         this.label = new LabelCtrl();
         this.carBox = new ChangeIconBox();
         this.armsBox = new ChangeIconBox();
         this.subBox = new ChangeIconBox();
         this.propsBox = new ChangeIconBox();
         this.materialsBox = new ChangeIconBox();
         this.box_arr = [];
         this.oneSell_box = new OneKeySellUI();
         this.oneSellCar_box = new OneKeySellCarUI();
         super();
         this.mouseEnabled = false;
         this.label.autoMouseB = false;
         this.label.inData([this.car_btn,this.arms_btn,this.sub_btn,this.props_btn,this.materials_btn],this.light_sp);
         this.label.addEventListener(ClickEvent.ON_CLICK,this.labelClick);
         this.box_arr = [this.carBox,this.armsBox,this.subBox,this.propsBox,this.materialsBox];
         box0 = this.carBox;
         box0.setSize(2,3,0,15);
         box0.setDataGroup(Game.gameData.carItems,"car");
         box0.x = 5;
         box0.y = 52;
         addChild(box0);
         box0 = this.armsBox;
         box0.setSize(3,4,4,10);
         box0.setDataGroup(Game.gameData.armsItems,"arms");
         box0.x = 9;
         box0.y = 48;
         addChild(box0);
         box0 = this.subBox;
         box0.setSize(3,4,4,10);
         box0.setDataGroup(Game.gameData.subItems,"sub");
         box0.x = 9;
         box0.y = 48;
         addChild(box0);
         box0 = this.propsBox;
         box0.setSize(6,6,4,4);
         box0.setDataGroup(Game.gameData.propsItems,"props");
         box0.x = 10;
         box0.y = 40;
         addChild(box0);
         box0 = this.materialsBox;
         box0.setSize(6,5,4,4);
         box0.setDataGroup(Game.gameData.materialsItems,"materials");
         box0.x = 10;
         box0.y = 40;
         addChild(box0);
         var y00:int = this.propsBox.page.y + this.propsBox.y;
         this.carBox.page.y = y00 - this.carBox.y;
         this.armsBox.page.y = y00 - this.armsBox.y;
         this.subBox.page.y = y00 - this.subBox.y;
         addChild(this.oneSell_box);
         this.oneSell_box.x = this.oneSell_btn.x + this.oneSell_btn.width / 2;
         this.oneSell_box.y = this.oneSell_btn.y - 5;
         this.oneSell_box.visible = false;
         this.oneSell_btn.addEventListener(MouseEvent.CLICK,this.oneSell);
         this.oneSell_box._btn.addEventListener(MouseEvent.CLICK,this.oneKeySell);
         this.oneSell_box.yellow_btn.addEventListener(MouseEvent.CLICK,this.oneKeySell);
         this.oneSell_box.white_btn.addEventListener(MouseEvent.CLICK,this.oneKeySell);
         this.oneSell_box.orange_btn.addEventListener(MouseEvent.CLICK,this.oneKeySell);
         addChild(this.oneSellCar_box);
         this.oneSellCar_box.x = this.oneSell_btn.x + this.oneSell_btn.width / 2;
         this.oneSellCar_box.y = this.oneSell_btn.y - 40;
         this.oneSellCar_box.visible = false;
         this.oneSellCar_box.white_btn.addEventListener(MouseEvent.CLICK,this.oneKeySellCar);
         this.oneSellCar_box.blue_btn.addEventListener(MouseEvent.CLICK,this.oneKeySellCar);
         this.oneSellCar_box.yellow_btn.addEventListener(MouseEvent.CLICK,this.oneKeySellCar);
         this.unlockBag_btn.addEventListener(MouseEvent.CLICK,this.unlockBagTip);
         this.cleanUp_btn.addEventListener(MouseEvent.CLICK,this.clearUpBag);
      }
      
      public function fleshData() : *
      {
         trace("fleshData刷新***********");
         this.showLabel(this.label.nowLabel);
      }
      
      public function fleshByGameState() : *
      {
         if(Game.gameState == "no")
         {
            this.arms_btn.mouseEnabled = true;
            this.sub_btn.mouseEnabled = true;
            this.props_btn.mouseEnabled = true;
         }
         else
         {
            this.arms_btn.mouseEnabled = true;
            this.sub_btn.mouseEnabled = true;
            this.props_btn.mouseEnabled = true;
         }
      }
      
      public function showLabel(label0:String) : *
      {
         var n:* = undefined;
         var box1:ChangeIconBox = null;
         var visible0:Boolean = false;
         var visible1:Boolean = false;
         var box0:ChangeIconBox = null;
         var y00:int = 0;
         this.label.setChoose_byLabel(label0);
         for(n in this.box_arr)
         {
            box0 = this.box_arr[n];
            box0.visible = false;
         }
         box1 = this[label0 + "Box"];
         box1.visible = true;
         box1.fleshData();
         visible0 = label0 == "materials" || label0 == "car";
         visible1 = label0 == "materials" || label0 == "car";
         this.cleanUp_btn.visible = visible0;
         this.oneSell_btn.visible = visible1;
         this.unlockBag_btn.visible = visible0;
         if(label0 == "car")
         {
            this.oneSell_btn.y = 370;
            this.cleanUp_btn.y = 370;
            this.unlockBag_btn.y = 370;
            y00 = this.propsBox.page.y + this.propsBox.y;
            this.carBox.page.y = y00 - this.carBox.y;
         }
         else
         {
            this.oneSell_btn.y = 404;
            this.cleanUp_btn.y = 404;
            this.unlockBag_btn.y = 404;
         }
         CtrlListCtrl.hideList();
         box1.fleshNewShow();
         trace(label0 + "刷新***********box1.fleshNewShow()");
      }
      
      public function showLabel_byIndex(i0:int) : *
      {
         this.showLabel(this.label.label_arr[i0]);
      }
      
      public function labelClick(e:ClickEvent) : *
      {
         trace("labelClick刷新***********");
         this.showLabel_byIndex(e.index);
         this.oneSell_box.visible = false;
         this.oneSellCar_box.visible = false;
      }
      
      public function oneSell(e:*) : *
      {
         if(this.label.nowLabel == "car")
         {
            addChild(this.oneSellCar_box);
            this.oneSellCar_box.visible = !this.oneSellCar_box.visible;
         }
         else
         {
            addChild(this.oneSell_box);
            this.oneSell_box.visible = !this.oneSell_box.visible;
         }
      }
      
      private function oneKeySellCar(e:MouseEvent) : *
      {
         var arr0:Array = null;
         var n:* = undefined;
         var level0:int = 0;
         var da0:CarItemsData = null;
         var d0:CarDefine = null;
         var itemsData:CarItemsDataGroup = this.carBox.dataGroup;
         if(e.target.name == "yellow_btn")
         {
            arr0 = itemsData.getArrByColor("yellow");
         }
         else if(e.target.name == "blue_btn")
         {
            arr0 = itemsData.getArrByColor("blue");
         }
         else if(e.target.name == "white_btn")
         {
            arr0 = itemsData.getArrByColor("white");
         }
         else
         {
            level0 = int(this.oneSellCar_box.levelArr[this.oneSell_box.levelIndex]);
            if(level0 >= 0)
            {
               arr0 = itemsData.getArrByLevel(level0 - 1,0);
            }
            else
            {
               arr0 = itemsData.getArrByLevel();
            }
         }
         for(n in arr0)
         {
            da0 = arr0[n];
            d0 = da0.getDefine();
            itemsData.delItems_arr(itemsData.arr,da0.id);
            Game.gameData.addCoin(da0.getSellPrice());
         }
         if(arr0.length > 0)
         {
            Game.SG.playSound("sellItems");
            this.carBox.fleshData();
            Game.uiGroup.infoUI.fleshData();
         }
      }
      
      private function oneKeySell(e:MouseEvent) : *
      {
         var arr0:Array = null;
         var n:* = undefined;
         var color0:String = null;
         var level0:int = 0;
         var itemsData:GoodsItemsDataGroup = this.materialsBox.dataGroup;
         if(e.target.name == "yellow_btn")
         {
            arr0 = itemsData.getArrByName("yellow_chip");
         }
         else if(e.target.name == "white_btn")
         {
            arr0 = itemsData.getArrByName("white_chip");
            arr0 = arr0.concat(itemsData.getArrByName("blue_chip"));
         }
         else if(e.target.name == "orange_btn")
         {
            arr0 = itemsData.getArrByName("orange_chip");
         }
         else
         {
            color0 = this.oneSell_box.colorArr[this.oneSell_box.colorIndex];
            level0 = int(this.oneSell_box.levelArr[this.oneSell_box.levelIndex]);
            if(level0 >= 0)
            {
               arr0 = itemsData.getArrByName(color0,level0 - 1,0);
            }
            else
            {
               arr0 = itemsData.getArrByName(color0);
            }
         }
         for(n in arr0)
         {
            Game.IC.sellItems(arr0[n],itemsData);
         }
         if(arr0.length > 0)
         {
            this.materialsBox.fleshData();
            Game.uiGroup.infoUI.fleshData();
         }
      }
      
      private function clearUpBag(e:* = null) : *
      {
         var itemsData1:CarItemsDataGroup = null;
         if(this.label.nowLabel == "car")
         {
            itemsData1 = this.carBox.dataGroup;
            itemsData1.cleanUp();
            this.carBox.fleshData();
            this.oneSellCar_box.visible = false;
            return;
         }
         var itemsData:GoodsItemsDataGroup = this.materialsBox.dataGroup;
         itemsData.cleanUp();
         this.materialsBox.fleshData();
         this.oneSell_box.visible = false;
      }
      
      private function unlockBagTip(e:*) : *
      {
         var mustM:int = Game.gameDefine.unlockBagMustMCoin;
         var musetD:NormalMustDefine = new NormalMustDefine();
         musetD.MCoin = mustM;
         Game.uiGroup.checkTip.nowMCoin = Game.gameData.MCoin;
         Game.uiGroup.checkTip.showMustCheck(musetD,"你是否要开启下5格背包位置？",this.unlockBag);
         this.oneSell_box.visible = false;
      }
      
      private function unlockBag() : *
      {
         var mustM:int = Game.gameDefine.unlockBagMustMCoin;
         Game.payController.decMCoin(mustM,this.affterUnlockBag);
      }
      
      private function affterUnlockBag() : *
      {
         var itemsData1:CarItemsDataGroup = null;
         if(this.label.nowLabel == "car")
         {
            itemsData1 = this.carBox.dataGroup;
            itemsData1.bagMaxNum += 5;
            this.carBox.fleshData(true);
            Game.uiGroup.infoUI.fleshData();
            return;
         }
         var itemsData:GoodsItemsDataGroup = this.materialsBox.dataGroup;
         itemsData.bagMaxNum += 5;
         this.materialsBox.fleshData();
         Game.uiGroup.infoUI.fleshData();
      }
   }
}

