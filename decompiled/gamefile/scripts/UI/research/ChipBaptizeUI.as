package UI.research
{
   import UI.ClickEvent;
   import UI.DragSprite;
   import UI.items.ItemsBox;
   import UI.items.ItemsIcon;
   import UI.page.PageBox;
   import data.TextWay;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import gameAll.data.AdditionalData;
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

      private var autoButton:Sprite;

      private var autoPanel:Sprite;

      private var autoRows:Array = [];

      private var autoStatus:TextField;

      private var autoTimer:Timer = new Timer(80);

      private var autoRunning:Boolean = false;

      private var autoWashCount:int = 0;
      
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
         this.autoButton = this.createButton("自动洗炼",114,36);
         this.autoButton.x = this._btn.x - 128;
         if(this.autoButton.x < 8)
         {
            this.autoButton.x = this._btn.x + this._btn.width + 12;
         }
         this.autoButton.y = this._btn.y;
         addChild(this.autoButton);
         this.autoButton.addEventListener(MouseEvent.CLICK,this.openAutoPanel);
         this.autoTimer.addEventListener(TimerEvent.TIMER,this.autoWashStep);
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
                  copy_d = iai_d.copy(1);
                  if(this.materialsItems.useItemsDataReal(iai_d))
                  {
                     dd1 = this.chipItems.itemsData;
                     dd1 = this.materialsItems.addItemsData(dd1.copy(1),1,dd1.newB);
                     if(dd1 == null)
                     {
                        this.materialsItems.addItemsData(copy_d,1,copy_d.newB);
                     }
                     else
                     {
                        dd1.site = iai_d.site;
                        this.chipItems.clearData();
                        this.chipItems.inData_byItems(copy_d);
                     }
                  }
               }
            }
            else if(dragFather != null)
            {
                  drag_d = dragTarget.itemsData;
                  copy_d = drag_d.copy(1);
                  if(this.materialsItems.useItemsDataReal(drag_d))
                  {
                     if(this.chipItems.state == "fill")
                     {
                        dd0 = this.chipItems.itemsData;
                        dd0 = this.materialsItems.addItemsData(dd0.copy(1),1,dd0.newB);
                        if(dd0 == null)
                        {
                           this.materialsItems.addItemsData(copy_d,1,copy_d.newB);
                           this.fleshAll();
                           Game.SG.playSound("dragDown");
                           stopDraging();
                           return;
                        }
                        dd0.site = drag_d.site;
                     }
                     this.chipItems.clearData();
                     this.chipItems.inData_byItems(copy_d);
                  }
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
         this.stopAutoWash("芯片已移除");
         this.closeAutoPanel();
         var d0:GoodsItemsData = this.chipItems.itemsData;
         if(d0 is GoodsItemsData)
         {
            if(this.materialsItems.addItemsData(d0.copy(1),1,d0.newB) != null)
            {
               this.chipItems.clearData();
            }
            else
            {
               Game.uiGroup.checkTip.showTip("背包已满，无法取回芯片。",2);
               Game.SG.playSound("failureItems");
            }
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
         this.stopAutoWash("");
         this.closeAutoPanel();
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
         Game.SG.playSound("upgradeArms");
      }
      
      public function repeat() : *
      {
         this.affixBox.repeat(this.chipItems.itemsData);
      }

      private function openAutoPanel(e:MouseEvent = null) : *
      {
         if(this.chipItems.state != "fill")
         {
            Game.uiGroup.checkTip.showCheck2("请先放入需要洗炼的芯片。",2);
            return;
         }
         this.stopAutoWash("");
         this.closeAutoPanel();
         this.autoPanel = new Sprite();
         this.autoPanel.graphics.beginFill(0,0.45);
         this.autoPanel.graphics.drawRect(-240,-60,950,560);
         this.autoPanel.graphics.endFill();
         this.autoPanel.graphics.beginFill(263177,0.98);
         this.autoPanel.graphics.lineStyle(3,65535,1);
         this.autoPanel.graphics.drawRect(0,0,570,420);
         this.autoPanel.graphics.endFill();
         this.autoPanel.x = 240;
         this.autoPanel.y = 60;
         addChild(this.autoPanel);

         var title:TextField = this.makeText("自动洗炼设置",20,65535,true);
         title.x = 16;
         title.y = 10;
         this.autoPanel.addChild(title);
         var hint:TextField = this.makeText("勾选‘达标即停’的属性可单独触发停止；都不勾选时需全部达标",13,13434879,false);
         hint.x = 16;
         hint.y = 38;
         this.autoPanel.addChild(hint);
         var minTitle:TextField = this.makeText("最低值",12,16777215,true);
         minTitle.x = 300;
         minTitle.y = 61;
         this.autoPanel.addChild(minTitle);
         var maxTitle:TextField = this.makeText("最高值(可空)",12,16777215,true);
         maxTitle.x = 368;
         maxTitle.y = 61;
         this.autoPanel.addChild(maxTitle);
         var stopTitle:TextField = this.makeText("达标即停",12,16777215,true);
         stopTitle.x = 474;
         stopTitle.y = 61;
         this.autoPanel.addChild(stopTitle);

         this.autoRows.length = 0;
         var rowIndex:int = 0;
         var bar:ChipAffixBar = null;
         for each(bar in this.affixBox.arr)
         {
            if(!bar.lockB)
            {
               this.addAutoTargetRow(bar,rowIndex++);
            }
         }
         if(rowIndex == 0)
         {
            var emptyText:TextField = this.makeText("没有可洗炼的未锁定属性。",15,16776960,true);
            emptyText.x = 20;
            emptyText.y = 100;
            this.autoPanel.addChild(emptyText);
         }

         this.autoStatus = this.makeText("填写目标后开始",13,10092543,false);
         this.autoStatus.x = 18;
         this.autoStatus.y = 365;
         this.autoPanel.addChild(this.autoStatus);
         var fillMaxButton:Sprite = this.createButton("填充本级最大值",132,36);
         fillMaxButton.x = 185;
         fillMaxButton.y = 368;
         fillMaxButton.addEventListener(MouseEvent.CLICK,this.fillAutoLevelMax);
         this.autoPanel.addChild(fillMaxButton);
         var startButton:Sprite = this.createButton("开始/停止",114,36);
         startButton.x = 325;
         startButton.y = 368;
         startButton.addEventListener(MouseEvent.CLICK,this.startAutoWash);
         this.autoPanel.addChild(startButton);
         var closeButton:Sprite = this.createButton("关闭",114,36);
         closeButton.x = 445;
         closeButton.y = 368;
         closeButton.addEventListener(MouseEvent.CLICK,this.closeAutoPanelClick);
         this.autoPanel.addChild(closeButton);
      }

      private function addAutoTargetRow(bar:ChipAffixBar, index:int) : *
      {
         var y0:Number = 84 + index * 38;
         var labelText:String = bar.txt.text.split("\r").join("").split("\n").join("");
         var label:TextField = this.makeText(labelText,13,65280,false);
         label.x = 18;
         label.y = y0 + 5;
         label.width = 275;
         label.autoSize = TextFieldAutoSize.NONE;
         this.autoPanel.addChild(label);
         var minInput:TextField = this.createNumberInput(60,25);
         minInput.x = 298;
         minInput.y = y0;
         this.autoPanel.addChild(minInput);
         var maxInput:TextField = this.createNumberInput(82,25);
         maxInput.x = 372;
         maxInput.y = y0;
         this.autoPanel.addChild(maxInput);
         var stopCheck:Sprite = this.createAutoStopCheck();
         stopCheck.x = 495;
         stopCheck.y = y0 + 2;
         this.autoPanel.addChild(stopCheck);
         this.autoRows.push({name:bar.affixName,min:minInput,max:maxInput,stopCheck:stopCheck,stopOnReach:false});
      }

      private function fillAutoLevelMax(e:MouseEvent = null) : *
      {
         if(this.chipItems.state != "fill" || !(this.chipItems.itemsData is GoodsItemsData))
         {
            if(this.autoStatus != null)
            {
               this.autoStatus.text = "请先放入芯片";
            }
            return;
         }
         var chip0:GoodsItemsData = this.chipItems.itemsData as GoodsItemsData;
         var row:Object = null;
         var rawValue:Number = NaN;
         var displayValue:Number = NaN;
         var count0:int = 0;
         for each(row in this.autoRows)
         {
            rawValue = Game.gameDefine.addDefine.getMaxValue(chip0.affixLevel,String(row.name));
            // Use the exact same presentation rule as the original affix UI:
            // integer-looking affixes stay integers, while affixes shown with
            // one decimal place keep that one decimal place.
            displayValue = this.getDisplayedAffixValue(String(row.name),rawValue);
            row.min.text = "";
            row.max.text = String(displayValue);
            row.maxIsTarget = true;
            ++count0;
         }
         if(this.autoStatus != null)
         {
            this.autoStatus.text = "已填充 " + (chip0.affixLevel + 1) + " 级词条最大值，共 " + count0 + " 条";
         }
      }

      private function createAutoStopCheck() : Sprite
      {
         var check:Sprite = new Sprite();
         check.buttonMode = true;
         check.mouseChildren = false;
         this.drawAutoStopCheck(check,false);
         check.addEventListener(MouseEvent.CLICK,this.toggleAutoStopCheck);
         return check;
      }

      private function toggleAutoStopCheck(e:MouseEvent) : *
      {
         var check:Sprite = e.currentTarget as Sprite;
         var row:Object = null;
         for each(row in this.autoRows)
         {
            if(row.stopCheck === check)
            {
               row.stopOnReach = !Boolean(row.stopOnReach);
               this.drawAutoStopCheck(check,Boolean(row.stopOnReach));
               return;
            }
         }
      }

      private function drawAutoStopCheck(check:Sprite, selected:Boolean) : *
      {
         check.graphics.clear();
         check.graphics.beginFill(986895,1);
         check.graphics.lineStyle(2,65535,1);
         check.graphics.drawRect(0,0,22,22);
         check.graphics.endFill();
         if(selected)
         {
            check.graphics.lineStyle(3,16777215,1);
            check.graphics.moveTo(4,11);
            check.graphics.lineTo(9,17);
            check.graphics.lineTo(19,5);
         }
      }

      private function startAutoWash(e:MouseEvent) : *
      {
         if(this.autoRunning)
         {
            this.stopAutoWash("已手动停止");
            return;
         }
         if(this.autoRows.length == 0)
         {
            this.autoStatus.text = "没有未锁定属性";
            return;
         }
         if(!this.hasAutoTarget())
         {
            this.autoStatus.text = "请至少填写一个目标值";
            return;
         }
         if(this.autoTargetsReached())
         {
            this.autoStatus.text = "当前属性已经达到目标";
            return;
         }
         this.autoWashCount = 0;
         this.autoRunning = true;
         this.autoStatus.text = "自动洗炼中...";
         this.autoTimer.start();
      }

      private function autoWashStep(e:TimerEvent) : *
      {
         if(!this.autoRunning)
         {
            return;
         }
         if(this.chipItems.state != "fill" || !(this.chipItems.itemsData is GoodsItemsData))
         {
            this.stopAutoWash("芯片已移除");
            return;
         }
         if(this.affixBox.getLockNum() == this.affixBox.arr.length)
         {
            this.stopAutoWash("全部属性已锁定");
            return;
         }
         var cost:int = this.getMustX();
         var xnum:int = Game.gameData.getNowGoodsDefine().Xprice;
         if(xnum < cost)
         {
            this.stopAutoWash("X合金不足，已停止");
            return;
         }
         if(!Game.gameData.materialsItems.useItemsNum("superalloy_X",cost))
         {
            this.stopAutoWash("X合金不足，已停止");
            return;
         }
         this.repeat();
         ++this.autoWashCount;
         this.fleshMust();
         if(this.autoTargetsReached())
         {
            this.stopAutoWash("达到目标，共洗炼 " + this.autoWashCount + " 次");
            Game.SG.playSound("upgradeArms");
            return;
         }
         this.autoStatus.text = "自动洗炼中：" + this.autoWashCount + " 次";
      }

      private function hasAutoTarget() : Boolean
      {
         var row:Object = null;
         for each(row in this.autoRows)
         {
            if(String(row.min.text) != "" || String(row.max.text) != "")
            {
               return true;
            }
         }
         return false;
      }

      private function autoTargetsReached() : Boolean
      {
         var usedTargets:int = 0;
         var individuallySelected:int = 0;
         var allTargetsReached:Boolean = true;
         var row:Object = null;
         var bar:ChipAffixBar = null;
         var found:ChipAffixBar = null;
         var value:Number = Number(NaN);
         var minValue:Number = Number(NaN);
         var maxValue:Number = Number(NaN);
         for each(row in this.autoRows)
         {
            if(String(row.min.text) == "" && String(row.max.text) == "")
            {
               continue;
            }
            ++usedTargets;
            found = null;
            for each(bar in this.affixBox.arr)
            {
               if(bar.affixName == String(row.name))
               {
                  found = bar;
                  break;
               }
            }
            if(found == null)
            {
               allTargetsReached = false;
               continue;
            }
            value = this.getDisplayedAffixValue(found.affixName,found.affixValue);
            var rowReached:Boolean = true;
            if(String(row.min.text) != "")
            {
               minValue = Number(row.min.text);
               if(isNaN(minValue) || value < minValue)
               {
                  rowReached = false;
               }
            }
            if(String(row.max.text) != "")
            {
               maxValue = Number(row.max.text);
               if(isNaN(maxValue) || (Boolean(row.maxIsTarget) ? value < maxValue : value > maxValue))
               {
                  rowReached = false;
               }
            }
            if(!rowReached)
            {
               allTargetsReached = false;
            }
            if(Boolean(row.stopOnReach))
            {
               ++individuallySelected;
               if(rowReached)
               {
                  return true;
               }
            }
         }
         return individuallySelected == 0 && usedTargets > 0 && allTargetsReached;
      }

      private function getDisplayedAffixValue(name:String, rawValue:Number) : Number
      {
         var index:int = AdditionalData.allName.indexOf(name);
         var scale:Number = index >= 0 ? Number(AdditionalData.allBaifen[index]) : 1;
         if(scale == 100)
         {
            return rawValue > 1 ? Math.ceil(rawValue * 100) : Math.ceil(rawValue * 1000) / 10;
         }
         if(scale == 30)
         {
            return Math.ceil(rawValue * scale);
         }
         return rawValue > 10 ? Math.ceil(rawValue) : Math.ceil(rawValue * 10) / 10;
      }

      private function stopAutoWash(reason:String) : *
      {
         if(!this.autoRunning && reason == "")
         {
            return;
         }
         var hadRolls:Boolean = this.autoWashCount > 0;
         this.autoRunning = false;
         this.autoTimer.stop();
         if(this.autoStatus != null && reason != "")
         {
            this.autoStatus.text = reason;
         }
         if(hadRolls)
         {
            Game.uiGroup.saveDataNoUI("自动洗炼");
         }
         this.autoWashCount = 0;
      }

      private function closeAutoPanelClick(e:MouseEvent) : *
      {
         this.stopAutoWash("已手动停止");
         this.closeAutoPanel();
      }

      private function closeAutoPanel() : *
      {
         if(this.autoPanel != null)
         {
            if(contains(this.autoPanel))
            {
               removeChild(this.autoPanel);
            }
            this.autoPanel = null;
            this.autoRows.length = 0;
            this.autoStatus = null;
         }
      }

      private function createNumberInput(width0:Number, height0:Number) : TextField
      {
         var field:TextField = new TextField();
         field.defaultTextFormat = new TextFormat("_sans",14,16777215,false);
         field.type = TextFieldType.INPUT;
         field.restrict = "0-9.";
         field.maxChars = 10;
         field.background = true;
         field.backgroundColor = 986895;
         field.border = true;
         field.borderColor = 65535;
         field.width = width0;
         field.height = height0;
         return field;
      }

      private function createButton(labelValue:String, width0:Number, height0:Number) : Sprite
      {
         var button:Sprite = new Sprite();
         var original:SimpleButton = null;
         try
         {
            original = new SimpleButton(this.cloneButtonState(this._btn.upState,width0,height0),this.cloneButtonState(this._btn.overState,width0,height0),this.cloneButtonState(this._btn.downState,width0,height0),this.cloneButtonState(this._btn.hitTestState,width0,height0));
            button.addChild(original);
         }
         catch(error:Error)
         {
            button.graphics.beginFill(1973790,1);
            button.graphics.lineStyle(2,16750848,1);
            button.graphics.drawRect(0,0,width0,height0);
            button.graphics.endFill();
         }
         var label:TextField = this.makeText(labelValue,14,16777215,true);
         label.mouseEnabled = false;
         label.x = (width0 - label.width) / 2;
         label.y = (height0 - label.height) / 2;
         button.addChild(label);
         button.buttonMode = true;
         button.mouseChildren = false;
         return button;
      }

      private function cloneButtonState(source:DisplayObject, width0:Number, height0:Number) : DisplayObject
      {
         if(source == null)
         {
            throw new Error("button state missing");
         }
         var bounds:Rectangle = source.getBounds(source);
         var bitmapData:BitmapData = new BitmapData(Math.max(1,Math.ceil(bounds.width)),Math.max(1,Math.ceil(bounds.height)),true,0);
         var matrix:Matrix = new Matrix();
         matrix.translate(-bounds.x,-bounds.y);
         bitmapData.draw(source,matrix,null,null,null,true);
         var bitmap:Bitmap = new Bitmap(bitmapData,"auto",true);
         bitmap.width = width0;
         bitmap.height = height0;
         return bitmap;
      }

      private function makeText(value:String, size:int, color:uint, bold:Boolean) : TextField
      {
         var field:TextField = new TextField();
         field.defaultTextFormat = new TextFormat("_sans",size,color,bold);
         field.autoSize = TextFieldAutoSize.LEFT;
         field.selectable = false;
         field.text = value;
         return field;
      }
   }
}

