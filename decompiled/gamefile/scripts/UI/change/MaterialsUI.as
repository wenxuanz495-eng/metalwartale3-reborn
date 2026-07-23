package UI.change
{
   import UI.ClickEvent;
   import UI.dialog.ItemsTipbox;
   import UI.items.ItemsBox;
   import UI.items.ItemsIcon;
   import UI.items.ItemsInfoTip;
   import UI.page.PageBox;
   import UI.shop.MustTopDialogBox;
   import data.Maths;
   import data.StringToDefine;
   import flash.display.Bitmap;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.system.System;
   import gameAll.NormalMustDefine;
   import gameAll.data.GoodsItemsData;
   import gameAll.data.GoodsItemsDataGroup;
   import gs.TweenLite;
   import gs.easing.Back;
   
   public class MaterialsUI extends Sprite
   {
      
      public var buyCheckTip:MustTopDialogBox = new MustTopDialogBox();
      
      public var infoUI_mc:Sprite = new Sprite();
      
      public var pageBox:PageBox;
      
      public var itemsBox:ItemsBox = new ItemsBox("bag",true);
      
      public var ctrlList:CtrlArmsList;
      
      public var nowCtrl:ItemsIcon;
      
      public var itemsData:GoodsItemsDataGroup;
      
      private var dragTarget:*;
      
      private var dragFather:*;
      
      private var dragBmp:Bitmap = new Bitmap();
      
      private var dragBmpSp:Sprite = new Sprite();
      
      private var dragPoint:Point = new Point();
      
      private var iconOverB:Boolean = false;
      
      public var oneSell_btn:SimpleButton;
      
      public var oneSell_box:OneKeySellUI;
      
      public var unlockBag_btn:SimpleButton;
      
      public var cleanUp_btn:SimpleButton;
      
      private var tipBox:ItemsTipbox = new ItemsTipbox();
      
      private var tip_mc:ItemsInfoTip = new ItemsInfoTip();
      
      public function MaterialsUI()
      {
         super();
      }
      
      public function differentFun() : *
      {
         this.itemsBox.setNum(8,5,482,309);
         this.itemsBox.x = 379;
         this.itemsBox.y = 73;
      }
      
      public function init() : *
      {
         this.addEventListener(MouseEvent.MOUSE_UP,this.mouseUp);
         this.initData();
         this.itemsBox.setLabelClass(ItemsIcon);
         this.itemsBox.setNum(10,5,572,270);
         this.itemsBox.x = 284;
         this.itemsBox.y = 116;
         this.itemsBox.setLabelClass(ItemsIcon);
         this.differentFun();
         this.addChild(this.itemsBox);
         this.itemsBox.setTotalNum(this.itemsData.bagMaxNum);
         this.itemsBox.pageBox = this.pageBox;
         this.pageBox.table = this.itemsBox;
         this.pageBox.fleshByTable();
         this.itemsBox.addEventListener(ClickEvent.ON_DOWN,this.iconDown);
         this.itemsBox.addEventListener(ClickEvent.ON_UP,this.iconUp);
         this.itemsBox.addEventListener(ClickEvent.ON_OVER,this.iconOver);
         this.itemsBox.addEventListener(ClickEvent.ON_OUT,this.iconOut);
         addChild(this.infoUI_mc);
         this.infoUI_mc.x = 38;
         this.infoUI_mc.y = 85;
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
         this.ctrlList = new CtrlArmsList();
         addChild(this.ctrlList);
         this.ctrlList.addEventListener(ClickEvent.ON_CLICK,this.ctrlClick);
         this.ctrlList.visible = false;
         addChild(this.buyCheckTip);
         this.buyCheckTip.visible = false;
         this.oneSell_box.visible = false;
         this.oneSell_btn.addEventListener(MouseEvent.CLICK,this.oneSell);
         this.oneSell_box._btn.addEventListener(MouseEvent.CLICK,this.oneKeySell);
         this.oneSell_box.yellow_btn.addEventListener(MouseEvent.CLICK,this.oneKeySell);
         this.oneSell_box.white_btn.addEventListener(MouseEvent.CLICK,this.oneKeySell);
         this.oneSell_box.orange_btn.addEventListener(MouseEvent.CLICK,this.oneKeySell);
         this.unlockBag_btn.addEventListener(MouseEvent.CLICK,this.unlockBagTip);
         this.cleanUp_btn.addEventListener(MouseEvent.CLICK,this.clearUpBag);
         this.fleshAll();
      }
      
      protected function initData() : *
      {
         this.itemsData = Game.gameData.materialsItems;
      }
      
      public function fleshAll() : *
      {
         this.itemsBox.inData_byItems(this.itemsData.arr,this.itemsData.bagMaxNum);
         this.pageBox.fleshByTable();
         Game.gameData.fleshBagFillShow();
         this.oneSell_box.visible = false;
      }
      
      public function oneSell(e:*) : *
      {
         addChild(this.oneSell_box);
         this.oneSell_box.visible = !this.oneSell_box.visible;
      }
      
      private function oneKeySell(e:*) : *
      {
         var arr0:Array = null;
         var n:* = undefined;
         var color0:String = null;
         var level0:int = 0;
         if(e.target.name == "yellow_btn")
         {
            arr0 = this.itemsData.getArrByName("yellow_chip");
         }
         else if(e.target.name == "white_btn")
         {
            arr0 = this.itemsData.getArrByName("white_chip");
            arr0 = arr0.concat(this.itemsData.getArrByName("blue_chip"));
         }
         else if(e.target.name == "orange_btn")
         {
            arr0 = this.itemsData.getArrByName("orange_chip");
         }
         else
         {
            color0 = this.oneSell_box.colorArr[this.oneSell_box.colorIndex];
            level0 = int(this.oneSell_box.levelArr[this.oneSell_box.levelIndex]);
            if(level0 >= 0)
            {
               arr0 = this.itemsData.getArrByName(color0,level0 - 1,0);
            }
            else
            {
               arr0 = this.itemsData.getArrByName(color0);
            }
         }
         for(n in arr0)
         {
            Game.IC.sellItems(arr0[n],this.itemsData);
         }
         if(arr0.length > 0)
         {
            this.fleshAll();
         }
      }
      
      public function clearUpBag(e:* = null) : *
      {
         this.itemsData.cleanUp();
         this.fleshAll();
      }
      
      public function unlockBagTip(e:*) : *
      {
         var mustM:int = Game.gameDefine.unlockBagMustMCoin;
         var musetD:NormalMustDefine = new NormalMustDefine();
         musetD.MCoin = mustM;
         this.buyCheckTip.nowMCoin = Game.gameData.MCoin;
         this.buyCheckTip.showMustCheck(musetD,"你是否要开启下5格背包位置？",this.unlockBag);
      }
      
      public function unlockBag() : *
      {
         var mustM:int = Game.gameDefine.unlockBagMustMCoin;
         Game.payController.decMCoin(mustM,this.affterUnlockBag);
      }
      
      public function affterUnlockBag() : *
      {
         var mustM:int = Game.gameDefine.unlockBagMustMCoin;
         this.itemsData.bagMaxNum += 5;
         this.fleshAll();
      }
      
      public function tweenShow() : *
      {
         this.itemsBox.x = 284 + 10;
         TweenLite.to(this.itemsBox,0.5,{
            "x":284,
            "ease":Back.easeOut
         });
      }
      
      private function ctrlClick(event:ClickEvent) : *
      {
         var id0:GoodsItemsData = null;
         var str0:String = null;
         var obj2:Object = null;
         var index0:int = event.index;
         if(this.nowCtrl != null)
         {
            id0 = this.nowCtrl.itemsData;
            if(id0 is GoodsItemsData)
            {
               if(index0 == 3)
               {
                  if(id0.name.indexOf("_chip") >= 0)
                  {
                     this.sellItems();
                  }
                  else
                  {
                     str0 = "";
                     if(id0.nowNum > 1)
                     {
                        str0 = "你确定要卖出 <font color=\'#FFFF00\'>" + id0.nowNum + "个" + id0.cnName + "</font> 吗？";
                     }
                     else
                     {
                        str0 = "你确定要卖出 <font color=\'#FFFF00\'>" + id0.cnName + "</font> 吗？";
                     }
                     str0 += "\n" + "出售价格为：<font color=\'#FFFF00\'>" + id0.getSellPrice() + "</font> G币。";
                     this.buyCheckTip.showCheck(str0,this.sellItems);
                  }
               }
               else if(index0 == 4)
               {
                  if(id0.name == "exp_card_1" || id0.name == "exp_card_2" || id0.name == "exp_card_3")
                  {
                     if(Game.gameData.rankAdd.getExpCardUseB())
                     {
                        ++Game.gameData.rankAdd.nowExpCard;
                        Game.IC.useItems(this.nowCtrl.itemsData,this.itemsData);
                        this.fleshAll();
                     }
                     else
                     {
                        this.buyCheckTip.showCheck2("今日经验卡次数使用完毕，无法继续使用。\n如果想提升使用次数，请升级您的军衔等级。",2,null,null,2);
                        Game.SG.playSound("failureItems");
                     }
                  }
                  else if(id0.name.indexOf("vipCard") >= 0)
                  {
                     obj2 = Game.gameData.vipData.useCardPan(id0.name);
                     if(Boolean(obj2))
                     {
                        if(Boolean(obj2.useB))
                        {
                           this.buyCheckTip.showCheck2(obj2.txt,1,this.affter_useVipCard,null);
                        }
                        else
                        {
                           this.buyCheckTip.showCheck2(obj2.txt,2,null,null,2);
                        }
                     }
                     else
                     {
                        this.affter_useVipCard();
                     }
                  }
                  else
                  {
                     Game.IC.useItems(this.nowCtrl.itemsData,this.itemsData);
                     this.fleshAll();
                  }
               }
               else if(index0 == 7)
               {
                  if(id0.name == "exp_card_1" || id0.name == "exp_card_2" || id0.name == "exp_card_3")
                  {
                     if(Game.gameData.rankAdd.getExpCardNum() >= id0.nowNum)
                     {
                        Game.gameData.rankAdd.nowExpCard += id0.nowNum;
                        Game.IC.useItems(this.nowCtrl.itemsData,this.itemsData,true);
                        this.fleshAll();
                     }
                     else
                     {
                        this.buyCheckTip.showCheck2("今日只能使用" + Game.gameData.rankAdd.getExpCardNum() + "次经验卡！\n如果想提升使用次数，请升级您的军衔等级。",2,null,null,2);
                        Game.SG.playSound("failureItems");
                     }
                  }
                  else
                  {
                     Game.IC.useItems(this.nowCtrl.itemsData,this.itemsData,true);
                     this.fleshAll();
                  }
               }
               else if(index0 == 8)
               {
                  if(id0.getDefine().cardType == "chipBag")
                  {
                     Game.IC.requestChipBagBatch(this.nowCtrl.itemsData,this.itemsData);
                  }
                  else
                  {
                     Game.IC.requestCoreBatch(this.nowCtrl.itemsData,this.itemsData);
                  }
               }
            }
         }
         this.ctrlList.visible = false;
      }
      
      private function affter_useVipCard() : *
      {
         Game.IC.useItems(this.nowCtrl.itemsData,this.itemsData);
         this.fleshAll();
      }
      
      private function sellItems() : *
      {
         Game.IC.sellItems(this.nowCtrl.itemsData,this.itemsData);
         this.fleshAll();
      }
      
      private function iconOver(event:ClickEvent) : *
      {
         if(this.dragTarget == null)
         {
            if(this.itemsData == Game.gameData.materialsItems)
            {
               Game.uiGroup.changeUI.upMaterialsUI();
            }
            else
            {
               Game.uiGroup.changeUI.upPropsUI();
            }
         }
         this.oneSell_box.visible = false;
         var iai:ItemsIcon = event.goal;
         if(this.dragTarget == null)
         {
            if(this.iconOverB)
            {
               this.iconOverB = false;
            }
            else
            {
               this.ctrlList.visible = false;
            }
         }
      }
      
      private function iconOut(event:ClickEvent) : *
      {
         this.tipBox.hide();
      }
      
      private function iconDown(event:ClickEvent) : *
      {
         var gd0:GoodsItemsData = null;
         var iai:ItemsIcon = event.goal;
         if(Game.gameDefine.nowLevel == 2)
         {
            if(iai.state == "fill")
            {
               gd0 = iai.itemsData;
               if(gd0.name.indexOf("_chip") > 0)
               {
                  System.setClipboard(gd0.getChipText());
               }
            }
         }
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
         var iai:ItemsIcon = null;
         var type0:String = null;
         var define00:* = undefined;
         if(this.dragTarget is ItemsIcon)
         {
            this.iconOverB = true;
            box0 = event.target;
            iai = event.goal;
            if(this.dragTarget != iai)
            {
               this.itemsData.bag_to_bag(this.dragTarget.site,iai.site);
               this.fleshAll();
               Game.SG.playSound("dragDown");
            }
            else if(iai.state == "fill")
            {
               trace("物品栏不为空！！！dragTarget：" + this.dragTarget);
               if(this.dragTarget is ItemsIcon && this.dragTarget == event.goal)
               {
                  trace("物品栏不为空！！！：iai.itemsData" + iai.itemsData);
                  if(iai.itemsData is GoodsItemsData)
                  {
                     trace("出现操作按钮！！！");
                     type0 = iai.itemsData.type;
                     if(type0 == "card")
                     {
                        define00 = iai.itemsData.getDefine();
                        if(define00.cardValue == 0)
                        {
                           if(define00.cardType == "drop_box" || define00.cardType == "drop_box2" || define00.cardType == "drop_box3")
                           {
                              if(iai.itemsData.nowNum > 1)
                              {
                                 this.ctrlList.fleshName([4,8]);
                              }
                              else
                              {
                                 this.ctrlList.fleshName([4]);
                              }
                           }
                           else
                           {
                              this.stopDraging();
                              this.ctrlList.visible = false;
                              return;
                           }
                        }
                        else if(define00.cardValue == -1)
                        {
                           if(define00.cardType == "chipBag" && iai.itemsData.nowNum > 1)
                           {
                              this.ctrlList.fleshName([4,8]);
                           }
                           else
                           {
                              this.ctrlList.fleshName([4]);
                           }
                        }
                        else if(define00.cardValue != 0)
                        {
                           this.ctrlList.fleshName([4,7]);
                        }
                     }
                     else
                     {
                        if(iai.itemsData.name.indexOf("_fragment") >= 0)
                        {
                           this.stopDraging();
                           this.ctrlList.visible = false;
                           return;
                        }
                        this.ctrlList.fleshName([3]);
                     }
                     this.ctrlList.x = iai.x + this.itemsBox.x;
                     if(this.ctrlList.x < 360)
                     {
                        this.ctrlList.x = iai.x + this.itemsBox.x + iai.width + this.ctrlList.width;
                     }
                     this.ctrlList.y = iai.y + this.itemsBox.y;
                     this.ctrlList.visible = true;
                     this.nowCtrl = iai;
                  }
               }
            }
            this.stopDraging();
         }
      }
      
      private function mouseUp(event:MouseEvent) : *
      {
         if(this.dragTarget is ItemsIcon)
         {
            this.stopDraging();
            this.ctrlList.visible = false;
            Game.SG.playSound("dragDown");
         }
      }
      
      private function mouseClick(event:MouseEvent) : *
      {
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
            if(this.itemsData == Game.gameData.materialsItems)
            {
               Game.uiGroup.changeUI.propsUI.mouseChildren = false;
               Game.uiGroup.changeUI.propsUI.mouseEnabled = false;
               Game.uiGroup.changeUI.propsUI.ctrlList.visible = false;
               Game.uiGroup.changeUI.materialsUI.mouseChildren = true;
               Game.uiGroup.changeUI.materialsUI.mouseEnabled = true;
            }
            else
            {
               Game.uiGroup.changeUI.propsUI.mouseChildren = true;
               Game.uiGroup.changeUI.propsUI.mouseEnabled = true;
               Game.uiGroup.changeUI.materialsUI.mouseChildren = false;
               Game.uiGroup.changeUI.materialsUI.mouseEnabled = false;
               Game.uiGroup.changeUI.materialsUI.ctrlList.visible = false;
            }
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
         Game.uiGroup.changeUI.propsUI.mouseChildren = true;
         Game.uiGroup.changeUI.propsUI.mouseEnabled = true;
         Game.uiGroup.changeUI.materialsUI.mouseChildren = true;
         Game.uiGroup.changeUI.materialsUI.mouseEnabled = true;
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

