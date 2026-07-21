package UI.research
{
   import UI.ClickEvent;
   import UI.button.MoreStateButton;
   import UI.items.ItemsBox;
   import UI.items.ItemsIcon;
   import UI.label.LabelBox;
   import data.TextWay;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import gameAll.data.GoodsItemsData;
   import gameAll.data.GoodsItemsDataGroup;
   import gs.TweenLite;
   import items.ItemsDefine;
   import items.ItemsDefineGroup;
   
   public class CrystalUpgradeUI extends Sprite
   {
      
      public var switchLabel:LabelBox = new LabelBox();
      
      public var box_mc:*;
      
      public var bagFill_mc:*;
      
      public var pointer:Sprite;
      
      public var pointer_mc:MovieClip;
      
      public var upgradeBox:ItemsBox = new ItemsBox("bag",false);
      
      public var nowBox:ItemsBox = new ItemsBox("bag",false);
      
      public var mustCoin_txt:TextField;
      
      public var mustLevel_txt:TextField;
      
      public var mustItems:ItemsIcon;
      
      public var btn:SimpleButton;
      
      public var no_btn:Sprite;
      
      public var condition_icon1:MovieClip;
      
      public var condition_icon2:MovieClip;
      
      public var condition_icon3:MovieClip;
      
      public var nameTxt:TextField;
      
      public var num_txt:TextField;
      
      public var prev_btn:SimpleButton;
      
      public var next_btn:SimpleButton;
      
      public var purpleArr:Array = [];
      
      public var greenArr:Array = [];
      
      public var redArr:Array = [];
      
      public var yellowArr:Array = [];
      
      public var buncherArr:Array = [];
      
      public var boomArr:Array = [];
      
      public var thornArr:Array = [];
      
      public var typeArr:Array = ["chipCube","chipBaptize","purple","green","red","yellow","buncher","boom","thorn"];
      
      public var typeColor:Array = ["芯片合成","芯片洗炼","紫色晶体","绿色晶体","红色晶体","黄色晶体","聚束器","爆炸器","穿透器"];
      
      public var saveTypeArr:Array = [0,0,0,0,0,0,0,0,0];
      
      public var IDG:ItemsDefineGroup;
      
      public var itemsData:GoodsItemsDataGroup;
      
      public var chipCubeUI:ChipCubeUI;
      
      public var chipBaptizeUI:ChipBaptizeUI;
      
      public var nowLevelIndex:int = 0;
      
      public var nowItemsDefine:ItemsDefine = null;
      
      public var nowMustItemsData:GoodsItemsData = null;
      
      public var mustCoin:int = 0;
      
      public var mustNum:int = 0;
      
      private var _cubeNum:String = "";
      
      public function CrystalUpgradeUI()
      {
         super();
         this.pointer_mc.stop();
         this.mustCoin_txt = this.box_mc.mustCoin_txt;
         this.mustLevel_txt = this.box_mc.mustLevel_txt;
         this.mustItems = this.box_mc.mustItems;
         this.no_btn = this.box_mc.no_btn;
         this.btn = this.box_mc._btn;
         this.condition_icon1 = this.box_mc.condition_icon1;
         this.condition_icon2 = this.box_mc.condition_icon2;
         this.condition_icon3 = this.box_mc.condition_icon3;
         this.nameTxt = this.box_mc.nameTxt;
         this.box_mc.addChild(this.bagFill_mc);
         this.box_mc.addChild(this.pointer_mc);
         this.condition_icon1.stop();
         this.condition_icon2.stop();
         this.condition_icon3.stop();
         this.switchLabel.setLabelClass(MoreStateButton);
         this.switchLabel.grapArr = [0,6,0,0,0,6,0,0,6];
         this.switchLabel.addLabel(this.typeArr,40 * this.typeArr.length,false,"group");
         addChild(this.switchLabel);
         this.switchLabel.x = 150;
         this.switchLabel.y = 55;
         this.switchLabel.addEventListener(ClickEvent.ON_CLICK,this.labelClick);
         this.upgradeBox.setLabelClass(ItemsIcon);
         this.upgradeBox.setNum(8,1,516,40);
         this.upgradeBox.setTotalNum(6);
         this.upgradeBox.x = 311;
         this.upgradeBox.y = 80;
         this.box_mc.addChild(this.upgradeBox);
         this.box_mc.addChild(this.pointer);
         this.upgradeBox.addEventListener(ClickEvent.ON_CLICK,this.upgradeClick);
         this.nowBox.setLabelClass(ItemsIcon);
         this.nowBox.setNum(7,1,583,120);
         this.nowBox.x = 328;
         this.nowBox.y = 386;
         this.box_mc.addChild(this.nowBox);
         this.bagFill_mc.visible = false;
         this.btn.addEventListener(MouseEvent.CLICK,this.btnClick);
         this.pointer.mouseEnabled = false;
         this.chipCubeUI = new ChipCubeUI();
         addChild(this.chipCubeUI);
         this.chipCubeUI.visible = false;
         this.chipCubeUI.init();
         this.chipBaptizeUI = new ChipBaptizeUI();
         addChild(this.chipBaptizeUI);
         this.chipBaptizeUI.visible = false;
         this.chipBaptizeUI.init();
         this.prev_btn = this.box_mc.prev_btn;
         this.next_btn = this.box_mc.next_btn;
         this.num_txt = this.box_mc.num_txt;
         this.prev_btn.addEventListener(MouseEvent.CLICK,this.numChange);
         this.next_btn.addEventListener(MouseEvent.CLICK,this.numChange);
         this.num_txt.addEventListener(Event.CHANGE,this.numChange);
         this.cubeNum = 1;
      }
      
      public function init() : *
      {
         var n:* = undefined;
         var colorStr:String = null;
         this.IDG = Game.itemsDefineGroup;
         this.itemsData = Game.gameData.materialsItems;
         for(n in this.typeArr)
         {
            colorStr = this.typeArr[n];
            if(this.pan(colorStr) == "")
            {
               if(n < 6)
               {
                  this[colorStr + "Arr"] = this.IDG.getCrystalArr(colorStr);
               }
               else
               {
                  this[colorStr + "Arr"] = this.IDG.getMaterialsArr(colorStr);
               }
            }
         }
         this.chooseType(this.typeArr[0]);
         this.fleshBag();
      }
      
      public function fleshAll() : *
      {
         trace("晶体合成刷新。");
         this.chooseType(this.switchLabel.nowLabel);
      }
      
      public function fleshBag() : *
      {
         var nowColor:String = this.switchLabel.nowLabel;
         var arr0:Array = [];
         if(this.isCrystalB())
         {
            arr0 = this.itemsData.getArr_byColor(nowColor,"crystal");
         }
         else
         {
            arr0 = this.itemsData.getArr_byColor(nowColor,"");
         }
         this.nowBox.inData_byItems(arr0);
      }
      
      private function pan(colorStr:String) : String
      {
         if(colorStr.indexOf("chip") == 0)
         {
            return "chip";
         }
         if(colorStr.indexOf("con") == 0)
         {
            return "con";
         }
         return "";
      }
      
      public function newPlayerLogin() : *
      {
         this.chipCubeUI.chipItemsData.arr.length = 0;
         this.chipCubeUI.chipItemsBox.clearData();
         this.chipBaptizeUI.chipItems.clearData();
      }
      
      public function showChipBox(str0:String = "") : *
      {
         this.chipCubeUI.visible = false;
         this.chipBaptizeUI.visible = false;
         this.box_mc.visible = false;
         if(str0 == "chipCube")
         {
            this.chipCubeUI.visible = true;
            this.chipCubeUI.fleshAll();
         }
         else if(str0 == "chipBaptize")
         {
            this.chipBaptizeUI.visible = true;
            this.chipBaptizeUI.fleshAll();
         }
         else
         {
            this.box_mc.visible = true;
         }
      }
      
      public function isCrystalB() : Boolean
      {
         var str0:String = this.switchLabel.nowLabel;
         var typeIndex:int = this.typeArr.indexOf(str0);
         if(typeIndex < 6)
         {
            return true;
         }
         return false;
      }
      
      public function chooseType(str:String, index0:int = -1) : *
      {
         this.num_txt.text = 1 + "";
         this.cubeNum = 1;
         var typeIndex:int = this.typeArr.indexOf(str);
         if(this.pan(str) == "chip")
         {
            this.showChipBox(str);
            return;
         }
         if(this.pan(str) == "con")
         {
            this.showChipBox(str);
            return;
         }
         this.showChipBox();
         this.nameTxt.text = "背包中的" + this.typeColor[typeIndex];
         var upgradeArr:Array = this[str + "Arr"];
         this.upgradeBox.inData_byArr(upgradeArr);
         this.pointer_mc.gotoAndStop(upgradeArr.length);
         if(index0 == -1)
         {
            index0 = int(this.saveTypeArr[typeIndex]);
         }
         else
         {
            this.saveTypeArr[typeIndex] = index0;
         }
         this.fleshBag();
         this.chooseLevel(index0);
      }
      
      public function chooseLevel(index0:int, tweenB:Boolean = true) : *
      {
         var aid3:GoodsItemsData = null;
         var nowNum0:int = 0;
         this.nowLevelIndex = index0;
         this.saveTypeArr[this.switchLabel.nowIndex] = index0;
         var icon0:ItemsIcon = this.upgradeBox.arr[index0];
         var define0:ItemsDefine = icon0.itemsData;
         this.pointer.x = this.upgradeBox.x + icon0.x;
         var bagFillB:Boolean = this.itemsData.getFillB();
         if(bagFillB)
         {
            aid3 = this.itemsData.getItemsByName(define0.name);
            if(!(aid3 is GoodsItemsData))
            {
               // Bag full and target is a new stack: allow if consuming source will free one slot.
               var prevNameTmp:String = define0.getPrevCrystalName();
               var prevAidTmp:GoodsItemsData = this.itemsData.getItemsByBase(prevNameTmp);
               var needNumTmp:int = this.isCrystalB() ? Game.gameDefine.crystalUpgradeNum * this.cubeNum : Game.gameDefine.materialUpgradeNum * this.cubeNum;
               var willFreeSlot:Boolean = prevAidTmp is GoodsItemsData && prevAidTmp.nowNum > 0 && prevAidTmp.nowNum <= needNumTmp;
               if(!willFreeSlot)
               {
                  this.showBox(false,tweenB);
                  return;
               }
            }
            this.showBox(true,tweenB);
         }
         else
         {
            this.showBox(true,tweenB);
         }
         this.nowItemsDefine = define0;
         var level0:int = define0.getCrystalLevel();
         this.mustCoin = Game.gameDefine.getCrystalUpgradeCoin(level0,this.isCrystalB()) * this.cubeNum;
         if(this.isCrystalB())
         {
            this.mustNum = Game.gameDefine.crystalUpgradeNum * this.cubeNum;
         }
         else
         {
            this.mustNum = Game.gameDefine.materialUpgradeNum * this.cubeNum;
         }
         var mustLevel:int = Game.gameDefine.getCrystalUpgradeLevel(level0,this.isCrystalB());
         this.mustLevel_txt.text = String(mustLevel);
         var prevD:ItemsDefine = this.IDG.getDefine(define0.getPrevCrystalName());
         this.mustCoin_txt.text = String(this.mustCoin);
         this.mustItems.inData_byDefine(prevD);
         var yesB:Boolean = true;
         var GCoin:Number = Game.gameData.GCoin;
         if(this.mustCoin > GCoin)
         {
            this.condition_icon1.gotoAndStop(2);
            yesB = false;
         }
         else
         {
            this.condition_icon1.gotoAndStop(1);
         }
         if(Game.gameData.level + 1 < mustLevel)
         {
            trace("等级不足");
            yesB = false;
            this.condition_icon3.gotoAndStop(2);
         }
         else
         {
            this.condition_icon3.gotoAndStop(1);
         }
         var aid:GoodsItemsData = this.itemsData.getItemsByBase(prevD.name);
         if(aid is GoodsItemsData)
         {
            nowNum0 = aid.nowNum;
            this.mustItems.setMustNum(nowNum0,this.mustNum);
            if(nowNum0 >= this.mustNum)
            {
               this.condition_icon2.gotoAndStop(1);
               this.nowMustItemsData = aid;
            }
            else
            {
               yesB = false;
               this.condition_icon2.gotoAndStop(2);
            }
         }
         else
         {
            this.mustItems.setMustNum(0,this.mustNum);
            yesB = false;
            this.condition_icon2.gotoAndStop(2);
         }
         if(yesB)
         {
            this.btn.visible = true;
            this.no_btn.visible = false;
         }
         else
         {
            this.btn.visible = false;
            this.no_btn.visible = true;
         }
      }
      
      public function showBox(bb:Boolean = true, tweenB:Boolean = true) : *
      {
         if(bb)
         {
            this.bagFill_mc.visible = false;
            if(tweenB)
            {
               this.box_mc.alpha = 0;
               TweenLite.to(this.box_mc,0.3,{"alpha":1});
            }
            else
            {
               this.box_mc.alpha = 1;
            }
         }
         else
         {
            this.bagFill_mc.visible = true;
            if(tweenB)
            {
               this.bagFill_mc.alpha = 0;
               TweenLite.to(this.bagFill_mc,0.3,{"alpha":1});
            }
            else
            {
               this.bagFill_mc.alpha = 1;
            }
         }
         if(tweenB)
         {
            this.pointer.alpha = 0;
            TweenLite.to(this.pointer,0.3,{"alpha":1});
         }
         else
         {
            this.pointer.alpha = 1;
         }
      }
      
      public function btnClick(event:MouseEvent) : *
      {
         if(this.mustNum < 1.9)
         {
            Game.uiGroup.zuobile("修改了材料合成的所需数量。");
            return;
         }
         this.itemsData.clearAllNewB();
         Game.gameData.addCoin(-this.mustCoin);
         this.itemsData.useItemsData(this.nowMustItemsData,this.mustNum);
         this.itemsData.addItemsDefine(this.nowItemsDefine,this.cubeNum);
         this.fleshBag();
         this.chooseLevel(this.nowLevelIndex);
         Game.SG.playSound("upgradeArms");
      }
      
      public function labelClick(event:ClickEvent) : *
      {
         this.chooseType(this.switchLabel.nowLabel);
      }
      
      public function upgradeClick(event:ClickEvent) : *
      {
         this.chooseLevel(event.index);
      }
      
      private function numChange(event:*) : *
      {
         var mc:* = event.target;
         if(mc == this.prev_btn)
         {
            this.num_txt.text = String(int(this.num_txt.text) - 1);
         }
         else if(mc == this.next_btn)
         {
            this.num_txt.text = String(int(this.num_txt.text) + 1);
         }
         var num0:int = int(this.num_txt.text);
         if(num0 < 1)
         {
            num0 = 1;
         }
         else if(num0 > 99)
         {
            num0 = 99;
         }
         this.num_txt.text = num0 + "";
         this.cubeNum = num0;
         this.chooseLevel(this.nowLevelIndex,false);
      }
      
      public function set cubeNum(num0:int) : *
      {
         this._cubeNum = TextWay.toCode(String(num0));
      }
      
      public function get cubeNum() : int
      {
         return int(TextWay.getText(this._cubeNum));
      }
   }
}

