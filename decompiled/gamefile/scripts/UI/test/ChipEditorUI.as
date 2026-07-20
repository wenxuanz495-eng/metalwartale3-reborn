package UI.test
{
   import UI.items.ItemsIcon;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.system.System;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import gameAll.data.AdditionalData;
   import gameAll.data.GoodsItemsData;
   import items.ItemsDefine;
   import items.ItemsDefineGroup;
   
   public class ChipEditorUI extends Sprite
   {
      
      public var IDG:ItemsDefineGroup;
      
      public var affixLevel_txt:TextField;
      
      public var affixNum_txt:TextField;
      
      public var list_txt:TextField;
      
      public var text_txt:TextField;
      
      public var random_btn:SimpleButton;
      
      public var randomLock_btn:SimpleButton;
      
      public var rebirth_btn:SimpleButton;
      
      public var group_txt:TextField;
      
      public var nickname_txt:TextField;
      
      public var addText_btn:SimpleButton;
      
      public var copyText_btn:SimpleButton;
      
      public var byText_btn:SimpleButton;
      
      public var addChip_btn:SimpleButton;
      
      public var itemsIcon:ItemsIcon;
      
      public var itemsData:GoodsItemsData = new GoodsItemsData();
      
      public var barArr:Array = [];
      
      public function ChipEditorUI()
      {
         super();
         this.affixLevel_txt.text = "王颖";
      }
      
      public function init() : *
      {
         this.createList();
         this.itemsIcon = new ItemsIcon();
         this.itemsIcon.x = 273;
         this.itemsIcon.y = 30;
         addChild(this.itemsIcon);
         this.IDG = Game.itemsDefineGroup;
         this.affixLevel_txt.addEventListener(Event.CHANGE,this.affixLevelChange);
         this.rebirth_btn.addEventListener(MouseEvent.CLICK,this.rebirthChip);
         this.random_btn.addEventListener(MouseEvent.CLICK,this.randomChip);
         this.randomLock_btn.addEventListener(MouseEvent.CLICK,this.randomLockChip);
         this.addText_btn.addEventListener(MouseEvent.CLICK,this.addText);
         this.copyText_btn.addEventListener(MouseEvent.CLICK,this.copyText);
         this.byText_btn.addEventListener(MouseEvent.CLICK,this.byText);
         this.addChip_btn.addEventListener(MouseEvent.CLICK,this.addChip);
         this.rebirthChip();
      }
      
      private function createList() : *
      {
         var n:* = undefined;
         var bar0:ChipEditorBar = null;
         for(n in AdditionalData.allName)
         {
            bar0 = new ChipEditorBar();
            bar0.cn = AdditionalData.allCn[n];
            bar0.id = AdditionalData.allName[n];
            bar0.max = AdditionalData.maxArr[n];
            bar0.fleshBaseData();
            this.addChild(bar0);
            bar0.x = 493;
            bar0.y = 52 + 21 * n;
            bar0.value_txt.addEventListener(KeyboardEvent.KEY_UP,this.oneValueChange);
            bar0.random_btn.addEventListener(MouseEvent.CLICK,this.oneValueRandom);
            bar0.max_btn.addEventListener(MouseEvent.CLICK,this.oneValueMax);
            bar0.del_btn.addEventListener(MouseEvent.CLICK,this.oneValueDel);
            this.group_txt.addEventListener(Event.CHANGE,this.groupTxtChange);
            this.nickname_txt.addEventListener(Event.CHANGE,this.nicknameTxtChange);
            this.barArr.push(bar0);
         }
      }
      
      public function fleshData() : *
      {
         this.changeColor();
         this.fleshBaseData();
         this.addText();
         this.fleshAffix();
         this.group_txt.text = Game.gameData.groupData.name;
         this.nickname_txt.text = Game.gameData.arenaData.nickname;
      }
      
      public function fleshBaseData() : *
      {
         this.affixLevel_txt.text = this.itemsData.affixLevel + 1 + "";
         this.affixNum_txt.text = this.itemsData.addArr.length + "";
         var ad0:AdditionalData = this.itemsData.getAddData();
         this.list_txt.htmlText = ad0.getColorInfo("#333333","#0000FF");
         this.itemsIcon.inData_byItems(this.itemsData);
      }
      
      public function addText(e:* = null) : *
      {
         this.text_txt.text = this.itemsData.getChipText();
      }
      
      public function fleshAffix() : *
      {
         var n:* = undefined;
         var bar0:ChipEditorBar = null;
         var value0:Number = NaN;
         var ad0:AdditionalData = this.itemsData.getAddData();
         for(n in this.barArr)
         {
            bar0 = this.barArr[n];
            value0 = Number(ad0[bar0.id]);
            bar0.setValue(value0);
         }
      }
      
      public function changeColor() : *
      {
         var d0:ItemsDefine = null;
         var arr0:Array = ["white_chip","white_chip","blue_chip","yellow_chip","yellow_chip","orange_chip","orange_chip","green_chip"];
         var num0:int = int(this.itemsData.addArr.length);
         var name0:String = "white_chip";
         if(num0 > 7)
         {
            name0 = "green_chip";
         }
         else
         {
            name0 = arr0[num0];
         }
         d0 = this.IDG.getDefine(name0);
         this.itemsData.name = d0.name;
         this.itemsData.cnName = d0.cnName;
         this.itemsData.imgLabel = d0.imgLabel;
      }
      
      private function affixLevelChange(e:* = null) : *
      {
         this.itemsData.affixLevel = int(this.affixLevel_txt.text) - 1;
      }
      
      public function setValue(name0:String, value0:Number) : *
      {
         var bar0:ChipEditorBar = null;
         var n:* = undefined;
         var add2:AdditionalData = null;
         for(n in this.barArr)
         {
            if(this.barArr[n].id == name0)
            {
               bar0 = this.barArr[n];
               break;
            }
         }
         bar0.setValue(value0);
         value0 = Number(bar0.value_txt.text);
         add2 = new AdditionalData();
         add2.inData_byArr(this.itemsData.addArr);
         add2[name0] = value0;
         this.itemsData.addArr = add2.getStrArr();
      }
      
      private function groupTxtChange(e:*) : *
      {
         Game.gameData.groupData.name = this.group_txt.text;
         Game.uiGroup.infoUI.fleshData();
      }
      
      private function nicknameTxtChange(e:*) : *
      {
         Game.gameData.arenaData.nickname = this.nickname_txt.text;
         Game.uiGroup.infoUI.fleshData();
      }
      
      public function randomChip(e:* = null) : *
      {
         var num0:int = int(this.affixNum_txt.text);
         var add0:AdditionalData = Game.gameDefine.addDefine.getAdditionalData(num0,this.itemsData.affixLevel);
         var addArr0:Array = add0.getStrArr();
         this.itemsData.addArr = addArr0;
         this.fleshData();
      }
      
      public function randomLockChip(e:* = null) : *
      {
         var num0:int = int(this.affixNum_txt.text);
         var add2:AdditionalData = new AdditionalData();
         add2.inData_byArr(this.itemsData.addArr);
         trace("add2:\n" + add2.getPlainInfo());
         var nameArr0:Array = add2.getNameArr();
         trace("nameArr0:\n" + nameArr0);
         var add0:AdditionalData = Game.gameDefine.addDefine.getAdditionalData(num0,this.itemsData.affixLevel,nameArr0);
         var addArr0:Array = add0.getStrArr();
         this.itemsData.addArr = addArr0;
         this.fleshData();
      }
      
      public function rebirthChip(e:* = null) : *
      {
         this.itemsData = new GoodsItemsData();
         var d0:ItemsDefine = this.IDG.getDefine("white_chip").copyAll();
         this.itemsData.inData_byDefine(d0);
         this.fleshData();
      }
      
      private function oneValueChange(event:KeyboardEvent) : *
      {
         var textF0:* = undefined;
         var bar0:* = undefined;
         if(event.keyCode == Keyboard.ENTER || event.keyCode == Keyboard.NUMPAD_ENTER)
         {
            textF0 = event.target;
            bar0 = textF0.parent;
            this.setValue(bar0.id,Number(textF0.text));
            this.fleshData();
         }
      }
      
      private function oneValueRandom(event:*) : *
      {
         var bar0:* = event.target.parent;
         var name0:String = bar0.id;
         var value0:Number = Number(Game.gameDefine.addDefine[name0](this.itemsData.affixLevel));
         this.setValue(name0,value0);
         this.fleshData();
      }
      
      private function oneValueDel(event:*) : *
      {
         var bar0:* = event.target.parent;
         var name0:String = bar0.id;
         var value0:Number = 0;
         this.setValue(name0,value0);
         this.fleshData();
      }
      
      private function oneValueMax(event:*) : *
      {
         var bar0:* = event.target.parent;
         var name0:String = bar0.id;
         var value0:Number = 10000000;
         this.setValue(name0,value0);
         this.fleshData();
      }
      
      private function copyText(e:* = null) : *
      {
         System.setClipboard(this.text_txt.text);
      }
      
      private function byText(e:* = null) : *
      {
         if(this.text_txt.text.indexOf("|") > 0)
         {
            this.itemsData.inData_byChipText(this.text_txt.text);
            this.fleshData();
         }
      }
      
      public function addChip(e:* = null) : *
      {
         var chip0:GoodsItemsData = Game.gameData.materialsItems.addItemsData(this.itemsData.copy());
         chip0.nowNum = 1;
         Game.uiGroup.changeUI.materialsUI.fleshAll();
      }
   }
}

