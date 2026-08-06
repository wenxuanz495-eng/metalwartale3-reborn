package UI._new.change
{
   import UI.ClickEvent;
   import UI._new.icon.ChangeIconBox;
   import UI.change.OneKeySellCarUI;
   import UI.change.OneKeySellUI;
   import UI.label.LabelCtrl;
   import UI.page.PageBox;
   import body.hero.CarDefine;
   import flash.display.Loader;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import gameAll.NormalMustDefine;
   import gameAll.data.CarItemsData;
   import gameAll.data.CarItemsDataGroup;
   import gameAll.data.GoodsItemsData;
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

      private var chipSellCenter:Sprite;

      private var chipSellColorText:TextField;

      private var chipSellLevelText:TextField;

      private var chipSellPreviewText:TextField;

      private var chipSellColorIndex:int = 0;

      private var chipSellLevelIndex:int = 0;

      private var chipSellColors:Array = ["white_chip","blue_chip","yellow_chip","orange_chip","green_chip"];

      private var chipSellColorNames:Array = ["白色芯片","蓝色芯片","金色芯片","橙色芯片","绿色芯片"];

      private var chipSellLevels:Array = [10,20,30,40,50,60,70,80,90,100,110,120,130,140,150,-1];

      private var pendingChipSell:Array = [];

      private var carSellCenter:Sprite;

      private var carSellPreviewText:TextField;

      private var pendingCarSell:Array = [];

      private var carSellColors:Array = ["white","blue","yellow","orange","green"];

      private var carSellColorNames:Array = ["白色战车","蓝色战车","金色战车","橙色战车","绿色战车"];
      
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
         this.hideChipSellCenter();
         this.hideCarSellCenter();
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
         PageBox.markUISwitch();
         trace("labelClick刷新***********");
         this.showLabel_byIndex(e.index);
         this.oneSell_box.visible = false;
         this.oneSellCar_box.visible = false;
         this.hideChipSellCenter();
         this.hideCarSellCenter();
      }
      
      public function oneSell(e:*) : *
      {
         if(this.label.nowLabel == "car")
         {
            this.showCarSellCenter();
         }
         else
         {
            this.showChipSellCenter();
         }
      }

      private function showCarSellCenter() : *
      {
         if(this.carSellCenter == null)
         {
            this.createCarSellCenter();
         }
         Game.uiGroup._changeUI.addChild(this.carSellCenter);
         this.carSellCenter.visible = true;
         this.refreshCarSellCenter();
      }

      public function hideCarSellCenter() : *
      {
         if(this.carSellCenter != null)
         {
            this.carSellCenter.visible = false;
         }
      }

      private function createCarSellCenter() : *
      {
         var panel0:Sprite = null;
         var field0:TextField = null;
         var i0:int = 0;
         var x0:Number = 0;
         this.carSellCenter = new Sprite();
         this.carSellCenter.graphics.beginFill(0,0.62);
         this.carSellCenter.graphics.drawRect(0,0,950,560);
         this.carSellCenter.graphics.endFill();
         this.carSellCenter.addEventListener(MouseEvent.CLICK,this.carSellCenterBackgroundClick);
         panel0 = new Sprite();
         panel0.name = "panel";
         panel0.graphics.lineStyle(3,3394815,1);
         panel0.graphics.beginFill(525842,0.99);
         panel0.graphics.drawRect(0,0,650,430);
         panel0.graphics.endFill();
         this.addChipSellImage(panel0,"ui/chip-sell/space-bg.jpg","background",650,430);
         panel0.x = 150;
         panel0.y = 65;
         this.carSellCenter.addChild(panel0);
         field0 = this.makeChipSellText("战车处理中心",22,10079487,true,610,34,"center");
         field0.x = 20;
         field0.y = 14;
         panel0.addChild(field0);
         panel0.addChild(this.makeCarSellButton("关闭",570,14,60,30,"close"));
         panel0.addChild(this.makeChipSellSection("按品质一键出售",20,62,610,120));
         panel0.addChild(this.makeChipSellSection("新获得战车自动出售",20,198,610,150));
         i0 = 0;
         while(i0 < this.carSellColors.length)
         {
            x0 = 38 + i0 * 119;
            panel0.addChild(this.makeCarSellButton(this.carSellColorNames[i0],x0,112,104,42,"sell:" + this.carSellColors[i0]));
            panel0.addChild(this.makeCarSellToggle(this.carSellColorNames[i0],x0,246,"autoSell" + this.capitalizeCarColor(this.carSellColors[i0]) + "Car",this.getCarSellColor(this.carSellColors[i0])));
            i0++;
         }
         this.carSellPreviewText = this.makeChipSellText("",15,13421772,false,390,48);
         this.carSellPreviewText.x = 38;
         this.carSellPreviewText.y = 294;
         panel0.addChild(this.carSellPreviewText);
         panel0.addChild(this.makeCarSellButton("扫描并出售现有战车",442,292,166,40,"scanAuto"));
         field0 = this.makeChipSellText("说明：自动出售仅处理开启规则后新获得的未装备战车；车皮不会出售。清理背包现有战车需点击扫描按钮并确认。",13,10066329,false,590,48);
         field0.x = 30;
         field0.y = 365;
         panel0.addChild(field0);
      }

      private function makeCarSellButton(label0:String, x0:Number, y0:Number, width0:Number, height0:Number, action0:String) : Sprite
      {
         var button0:Sprite = this.makeChipSellButton(label0,x0,y0,width0,height0,action0);
         button0.removeEventListener(MouseEvent.CLICK,this.chipSellCenterClick);
         button0.addEventListener(MouseEvent.CLICK,this.carSellCenterClick);
         return button0;
      }

      private function makeCarSellToggle(label0:String, x0:Number, y0:Number, key0:String, color0:uint) : Sprite
      {
         var button0:Sprite = this.makeCarSellButton("",x0,y0,104,34,key0);
         var text0:TextField = button0.getChildAt(button0.numChildren - 1) as TextField;
         text0.name = "label";
         text0.textColor = color0;
         text0.text = label0;
         text0.x = 25;
         text0.width = 77;
         this.addChipSellImage(button0,"ui/chip-sell/checkbox-frame.png","check",26,26,1,4);
         return button0;
      }

      private function capitalizeCarColor(color0:String) : String
      {
         return color0.charAt(0).toUpperCase() + color0.substr(1);
      }

      private function getCarSellColor(color0:String) : uint
      {
         if(color0 == "blue") return 65535;
         if(color0 == "yellow") return 16776960;
         if(color0 == "orange") return 16737792;
         if(color0 == "green") return 65280;
         return 16777215;
      }

      private function carSellCenterBackgroundClick(e:MouseEvent) : *
      {
         if(e.target == this.carSellCenter)
         {
            this.hideCarSellCenter();
         }
      }

      private function carSellCenterClick(e:MouseEvent) : *
      {
         var action0:String = e.currentTarget.name;
         if(action0 == "close")
         {
            this.hideCarSellCenter();
         }
         else if(action0.indexOf("sell:") == 0)
         {
            this.requestCarSell(this.carBox.dataGroup.getArrByColor(action0.substr(5)),this.getCarColorName(action0.substr(5)));
         }
         else if(action0 == "scanAuto")
         {
            this.requestCarSell(this.getAutoCarSellArray(),"自动出售规则选中的战车");
         }
         else if(action0.indexOf("autoSell") == 0)
         {
            Game.gameData[action0] = !Boolean(Game.gameData[action0]);
            Game.uiGroup.saveDataNoUI("修改战车自动出售设置");
         }
         this.refreshCarSellCenter();
      }

      private function getCarColorName(color0:String) : String
      {
         var index0:int = this.carSellColors.indexOf(color0);
         return index0 >= 0 ? this.carSellColorNames[index0] : color0;
      }

      private function getAutoCarSellArray() : Array
      {
         var car0:CarItemsData = null;
         var result0:Array = [];
         for each(car0 in this.carBox.dataGroup.arr)
         {
            if(car0 != null && !car0.skinB && Game.gameData.shouldAutoSellCar(car0.color))
            {
               result0.push(car0);
            }
         }
         return result0;
      }

      private function requestCarSell(arr0:Array, title0:String) : *
      {
         var car0:CarItemsData = null;
         var price0:Number = 0;
         this.pendingCarSell = arr0.concat();
         for each(car0 in this.pendingCarSell)
         {
            price0 += car0.getSellPrice();
         }
         if(this.pendingCarSell.length <= 0)
         {
            Game.uiGroup.checkTip.showCheck2("没有符合条件的战车。",2);
            return;
         }
         Game.uiGroup.checkTip.showCheck("确定出售" + title0 + "吗？\n数量：" + this.pendingCarSell.length + " 辆\n预计获得：" + price0 + " G币",this.confirmCarSellCenter);
      }

      private function confirmCarSellCenter() : *
      {
         var car0:CarItemsData = null;
         var sold0:int = 0;
         for each(car0 in this.pendingCarSell)
         {
            if(this.carBox.dataGroup.arr.indexOf(car0) >= 0 && !car0.skinB)
            {
               this.carBox.dataGroup.delItems_arr(this.carBox.dataGroup.arr,car0.id);
               Game.gameData.addCoin(car0.getSellPrice());
               sold0++;
            }
         }
         this.pendingCarSell = [];
         if(sold0 > 0)
         {
            Game.SG.playSound("sellItems");
         }
         this.carBox.fleshData();
         Game.uiGroup.infoUI.fleshData();
         this.refreshCarSellCenter();
      }

      private function refreshCarSellCenter() : *
      {
         var panel0:Sprite = null;
         var button0:Sprite = null;
         var text0:TextField = null;
         var key0:String = null;
         var car0:CarItemsData = null;
         var auto0:Array = this.getAutoCarSellArray();
         var price0:Number = 0;
         var keys0:Array = ["autoSellWhiteCar","autoSellBlueCar","autoSellYellowCar","autoSellOrangeCar","autoSellGreenCar"];
         if(this.carSellCenter == null)
         {
            return;
         }
         panel0 = this.carSellCenter.getChildByName("panel") as Sprite;
         for each(key0 in keys0)
         {
            button0 = panel0.getChildByName(key0) as Sprite;
            text0 = button0.getChildByName("label") as TextField;
            text0.text = (Boolean(Game.gameData[key0]) ? "[已选] " : "[  ] ") + text0.text.replace("[已选] ","").replace("[  ] ","");
         }
         for each(car0 in auto0)
         {
            price0 += car0.getSellPrice();
         }
         this.carSellPreviewText.text = "当前背包符合自动规则：" + auto0.length + " 辆\n预计出售收入：" + price0 + " G币";
      }

      private function showChipSellCenter() : *
      {
         if(this.chipSellCenter == null)
         {
            this.createChipSellCenter();
         }
         Game.uiGroup._changeUI.addChild(this.chipSellCenter);
         this.chipSellCenter.visible = true;
         this.refreshChipSellCenter();
      }

      public function hideChipSellCenter() : *
      {
         if(this.chipSellCenter != null)
         {
            this.chipSellCenter.visible = false;
         }
      }

      private function createChipSellCenter() : *
      {
         var panel0:Sprite = null;
         var field0:TextField = null;
         this.chipSellCenter = new Sprite();
         this.chipSellCenter.graphics.beginFill(0,0.62);
         this.chipSellCenter.graphics.drawRect(0,0,950,560);
         this.chipSellCenter.graphics.endFill();
         this.chipSellCenter.addEventListener(MouseEvent.CLICK,this.chipSellCenterBackgroundClick);
         panel0 = new Sprite();
         panel0.name = "panel";
         panel0.graphics.lineStyle(3,3394815,1);
         panel0.graphics.beginFill(525842,0.99);
         panel0.graphics.drawRect(0,0,650,470);
         panel0.graphics.endFill();
         this.addChipSellImage(panel0,"ui/chip-sell/space-bg.jpg","background",650,470);
         panel0.x = 150;
         panel0.y = 45;
         this.chipSellCenter.addChild(panel0);
         field0 = this.makeChipSellText("芯片处理中心",22,10079487,true,610,34,"center");
         field0.x = 20;
         field0.y = 14;
         panel0.addChild(field0);
         panel0.addChild(this.makeChipSellButton("关闭",570,14,60,30,"close"));
         panel0.addChild(this.makeChipSellSection("手动一键出售",20,62,610,160));
         field0 = this.makeChipSellText("芯片品质",16,13421772,true,100,28);
         field0.x = 44;
         field0.y = 102;
         panel0.addChild(field0);
         panel0.addChild(this.makeChipSellButton("<",148,100,34,30,"prevColor"));
         this.chipSellColorText = this.makeChipSellText("",16,16777215,true,150,30,"center");
         this.chipSellColorText.x = 184;
         this.chipSellColorText.y = 103;
         panel0.addChild(this.chipSellColorText);
         panel0.addChild(this.makeChipSellButton(">",336,100,34,30,"nextColor"));
         field0 = this.makeChipSellText("等级范围",16,13421772,true,100,28);
         field0.x = 44;
         field0.y = 145;
         panel0.addChild(field0);
         panel0.addChild(this.makeChipSellButton("<",148,143,34,30,"prevLevel"));
         this.chipSellLevelText = this.makeChipSellText("",16,16777215,true,150,30,"center");
         this.chipSellLevelText.x = 184;
         this.chipSellLevelText.y = 146;
         panel0.addChild(this.chipSellLevelText);
         panel0.addChild(this.makeChipSellButton(">",336,143,34,30,"nextLevel"));
         panel0.addChild(this.makeChipSellButton("出售当前条件",405,100,190,34,"manualSell"));
         panel0.addChild(this.makeChipSellButton("白色+蓝色",405,146,90,30,"quickWhiteBlue"));
         panel0.addChild(this.makeChipSellButton("金色",500,146,44,30,"quickYellow"));
         panel0.addChild(this.makeChipSellButton("橙色",549,146,46,30,"quickOrange"));
         panel0.addChild(this.makeChipSellSection("自动售卖规则",20,236,610,178));
         panel0.addChild(this.makeChipSellToggle("白色芯片",28,274,"autoSellWhiteChip",16777215));
         panel0.addChild(this.makeChipSellToggle("蓝色芯片",146,274,"autoSellBlueChip",65535));
         panel0.addChild(this.makeChipSellToggle("金色芯片",264,274,"autoSellYellowChip",16776960));
         panel0.addChild(this.makeChipSellToggle("橙色芯片",382,274,"autoSellOrangeChip",16737792));
         panel0.addChild(this.makeChipSellToggle("绿色芯片",500,274,"autoSellGreenChip",65280));
         this.chipSellPreviewText = this.makeChipSellText("",15,13421772,false,350,70);
         this.chipSellPreviewText.x = 42;
         this.chipSellPreviewText.y = 326;
         panel0.addChild(this.chipSellPreviewText);
         panel0.addChild(this.makeChipSellButton("扫描并出售背包现有芯片",405,338,190,42,"scanAuto"));
         field0 = this.makeChipSellText("说明：自动规则只处理以后新获得的芯片；清理背包现有芯片需要点击右侧按钮并再次确认。",13,10066329,false,590,38);
         field0.x = 30;
         field0.y = 422;
         panel0.addChild(field0);
      }

      private function makeChipSellSection(title0:String, x0:Number, y0:Number, width0:Number, height0:Number) : Sprite
      {
         var section0:Sprite = new Sprite();
         var text0:TextField = this.makeChipSellText(title0,17,10079487,true,width0 - 24,28);
         section0.graphics.lineStyle(1,3377663,1);
         section0.graphics.beginFill(1055536,0.78);
         section0.graphics.drawRect(0,0,width0,height0);
         section0.graphics.endFill();
         section0.x = x0;
         section0.y = y0;
         text0.x = 12;
         text0.y = 6;
         section0.addChild(text0);
         return section0;
      }

      private function makeChipSellText(text1:String, size0:int, color0:uint, bold0:Boolean, width0:Number, height0:Number, align0:String = "left") : TextField
      {
         var field0:TextField = new TextField();
         field0.defaultTextFormat = new TextFormat("_sans",size0,color0,bold0,null,null,null,null,align0);
         field0.width = width0;
         field0.height = height0;
         field0.text = text1;
         field0.selectable = false;
         field0.mouseEnabled = false;
         return field0;
      }

      private function makeChipSellButton(label0:String, x0:Number, y0:Number, width0:Number, height0:Number, action0:String) : Sprite
      {
         var button0:Sprite = new Sprite();
         var text0:TextField = this.makeChipSellText(label0,14,10079487,true,width0,height0,"center");
         button0.name = action0;
         button0.graphics.lineStyle(1,3394815,1);
         button0.graphics.beginFill(1055536,1);
         button0.graphics.drawRect(0,0,width0,height0);
         button0.graphics.endFill();
         button0.x = x0;
         button0.y = y0;
         button0.buttonMode = true;
         button0.mouseChildren = false;
         this.addChipSellImage(button0,"ui/chip-sell/button-normal.png","normal",width0,height0);
         this.addChipSellImage(button0,"ui/chip-sell/button-hover.png","hover",width0,height0);
         text0.y = Math.max(3,(height0 - 20) / 2);
         button0.addChild(text0);
         button0.addEventListener(MouseEvent.CLICK,this.chipSellCenterClick);
         button0.addEventListener(MouseEvent.MOUSE_OVER,this.chipSellButtonOver);
         button0.addEventListener(MouseEvent.MOUSE_OUT,this.chipSellButtonOut);
         return button0;
      }

      private function makeChipSellToggle(label0:String, x0:Number, y0:Number, key0:String, color0:uint) : Sprite
      {
         var button0:Sprite = this.makeChipSellButton("",x0,y0,110,34,key0);
         var text0:TextField = button0.getChildAt(button0.numChildren - 1) as TextField;
         text0.name = "label";
         text0.defaultTextFormat = new TextFormat("_sans",12,color0,true);
         text0.textColor = color0;
         text0.text = label0;
         text0.x = 26;
         text0.width = 82;
         this.addChipSellImage(button0,"ui/chip-sell/checkbox-frame.png","check",26,26,1,4);
         return button0;
      }

      private function addChipSellImage(target0:Sprite, path0:String, role0:String, width0:Number, height0:Number, x0:Number = 0, y0:Number = 0) : *
      {
         var loader0:Loader = new Loader();
         loader0.name = role0 + "|" + width0 + "|" + height0;
         loader0.x = x0;
         loader0.y = y0;
         loader0.mouseEnabled = false;
         loader0.contentLoaderInfo.addEventListener(Event.COMPLETE,this.chipSellImageComplete);
         loader0.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.chipSellImageError);
         if(role0 == "hover")
         {
            loader0.visible = false;
         }
         if(role0 == "background")
         {
            loader0.alpha = 0.46;
         }
         target0.addChild(loader0);
         loader0.load(new URLRequest(path0));
      }

      private function chipSellImageComplete(e:Event) : *
      {
         var loader0:Loader = e.target.loader as Loader;
         var data0:Array = loader0.name.split("|");
         loader0.content.width = Number(data0[1]);
         loader0.content.height = Number(data0[2]);
      }

      private function chipSellImageError(e:IOErrorEvent) : *
      {
      }

      private function chipSellButtonOver(e:MouseEvent) : *
      {
         this.setChipSellButtonHover(e.currentTarget as Sprite,true);
      }

      private function chipSellButtonOut(e:MouseEvent) : *
      {
         this.setChipSellButtonHover(e.currentTarget as Sprite,false);
      }

      private function setChipSellButtonHover(button0:Sprite, hover0:Boolean) : *
      {
         var child0:* = null;
         var i0:int = 0;
         while(i0 < button0.numChildren)
         {
            child0 = button0.getChildAt(i0);
            if(child0 is Loader)
            {
               if(String(child0.name).indexOf("normal|") == 0)
               {
                  child0.visible = !hover0;
               }
               else if(String(child0.name).indexOf("hover|") == 0)
               {
                  child0.visible = hover0;
               }
            }
            i0++;
         }
      }

      private function chipSellCenterBackgroundClick(e:MouseEvent) : *
      {
         if(e.target == this.chipSellCenter)
         {
            this.hideChipSellCenter();
         }
      }

      private function chipSellCenterClick(e:MouseEvent) : *
      {
         var action0:String = e.currentTarget.name;
         if(action0 == "close")
         {
            this.hideChipSellCenter();
         }
         else if(action0 == "prevColor")
         {
            this.chipSellColorIndex = (this.chipSellColorIndex - 1 + this.chipSellColors.length) % this.chipSellColors.length;
         }
         else if(action0 == "nextColor")
         {
            this.chipSellColorIndex = (this.chipSellColorIndex + 1) % this.chipSellColors.length;
         }
         else if(action0 == "prevLevel")
         {
            this.chipSellLevelIndex = (this.chipSellLevelIndex - 1 + this.chipSellLevels.length) % this.chipSellLevels.length;
         }
         else if(action0 == "nextLevel")
         {
            this.chipSellLevelIndex = (this.chipSellLevelIndex + 1) % this.chipSellLevels.length;
         }
         else if(action0 == "manualSell")
         {
            this.requestChipSell(this.getManualChipSellArray(),"当前筛选条件");
         }
         else if(action0 == "quickWhiteBlue")
         {
            this.requestChipSell(this.materialsBox.dataGroup.getArrByName("white_chip").concat(this.materialsBox.dataGroup.getArrByName("blue_chip")),"白色和蓝色芯片");
         }
         else if(action0 == "quickYellow")
         {
            this.requestChipSell(this.materialsBox.dataGroup.getArrByName("yellow_chip"),"金色芯片");
         }
         else if(action0 == "quickOrange")
         {
            this.requestChipSell(this.materialsBox.dataGroup.getArrByName("orange_chip"),"橙色芯片");
         }
         else if(action0 == "scanAuto")
         {
            this.requestChipSell(this.getAutoChipSellArray(),"自动售卖规则选中的芯片");
         }
         else if(action0.indexOf("autoSell") == 0)
         {
            Game.gameData[action0] = !Boolean(Game.gameData[action0]);
            Game.uiGroup.saveDataNoUI("修改芯片自动售卖设置");
         }
         this.refreshChipSellCenter();
      }

      private function getManualChipSellArray() : Array
      {
         var level0:int = int(this.chipSellLevels[this.chipSellLevelIndex]);
         if(level0 < 0)
         {
            return this.materialsBox.dataGroup.getArrByName(this.chipSellColors[this.chipSellColorIndex]);
         }
         return this.materialsBox.dataGroup.getArrByName(this.chipSellColors[this.chipSellColorIndex],level0 - 1,0);
      }

      private function getAutoChipSellArray() : Array
      {
         var chip0:GoodsItemsData = null;
         var result0:Array = [];
         for each(chip0 in this.materialsBox.dataGroup.arr)
         {
            if(chip0 != null && chip0.type == "chip" && Game.gameData.shouldAutoSellChip(chip0.name))
            {
               result0.push(chip0);
            }
         }
         return result0;
      }

      private function requestChipSell(arr0:Array, title0:String) : *
      {
         var chip0:GoodsItemsData = null;
         var price0:Number = 0;
         this.pendingChipSell = arr0.concat();
         for each(chip0 in this.pendingChipSell)
         {
            price0 += chip0.getSellPrice();
         }
         if(this.pendingChipSell.length <= 0)
         {
            Game.uiGroup.checkTip.showCheck2("没有符合条件的芯片。",2);
            return;
         }
         Game.uiGroup.checkTip.showCheck("确定出售" + title0 + "吗？\n数量：" + this.pendingChipSell.length + " 个\n预计获得：" + price0 + " G币",this.confirmChipSellCenter);
      }

      private function confirmChipSellCenter() : *
      {
         var chip0:GoodsItemsData = null;
         for each(chip0 in this.pendingChipSell)
         {
            if(this.materialsBox.dataGroup.arr.indexOf(chip0) >= 0)
            {
               Game.IC.sellItems(chip0,this.materialsBox.dataGroup);
            }
         }
         this.pendingChipSell = [];
         this.materialsBox.fleshData();
         Game.uiGroup.infoUI.fleshData();
         this.refreshChipSellCenter();
      }

      private function refreshChipSellCenter() : *
      {
         var panel0:Sprite = null;
         var button0:Sprite = null;
         var text0:TextField = null;
         var key0:String = null;
         var auto0:Array = this.getAutoChipSellArray();
         var chip0:GoodsItemsData = null;
         var price0:Number = 0;
         var keys0:Array = ["autoSellWhiteChip","autoSellBlueChip","autoSellYellowChip","autoSellOrangeChip","autoSellGreenChip"];
         if(this.chipSellCenter == null)
         {
            return;
         }
         this.chipSellColorText.text = this.chipSellColorNames[this.chipSellColorIndex];
         this.chipSellLevelText.text = this.chipSellLevels[this.chipSellLevelIndex] < 0 ? "全部等级" : "1～" + this.chipSellLevels[this.chipSellLevelIndex] + "级";
         panel0 = this.chipSellCenter.getChildByName("panel") as Sprite;
         for each(key0 in keys0)
         {
            button0 = panel0.getChildByName(key0) as Sprite;
            text0 = button0.getChildByName("label") as TextField;
            text0.text = (Boolean(Game.gameData[key0]) ? "[已选] " : "[  ] ") + text0.text.replace("[已选] ","").replace("[  ] ","");
         }
         for each(chip0 in auto0)
         {
            price0 += chip0.getSellPrice();
         }
         this.chipSellPreviewText.text = "当前背包符合自动规则：" + auto0.length + " 个\n预计出售收入：" + price0 + " G币";
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

