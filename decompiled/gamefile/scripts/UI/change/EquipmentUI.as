package UI.change
{
   import UI.ClickEvent;
   import UI.dialog.ItemsTipbox;
   import UI.icon.ItemsArmsIcon;
   import UI.page.PageBox;
   import UI.shop.MustTopDialogBox;
   import body.define.OneArmsDefine;
   import data.Maths;
   import data.StringToDefine;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import gameAll.NormalMustDefine;
   import gameAll.data.ArmsItemsData;
   import gameAll.data.ArmsItemsDataGroup;
   
   public class EquipmentUI extends MovieClip
   {
      
      public var itemsData:ArmsItemsDataGroup;
      
      public var mustDefine:NormalMustDefine;
      
      public var type:String = "arms";
      
      public var nowArms:ArmsIconBox = new ArmsIconBox("equip",true);
      
      public var nowArmsType:Array = [3,0,0,0,0,0];
      
      public var equipSite:int = 1;
      
      public var tempEquipSite:int = 6;
      
      public var bagArms:ArmsIconBox = new ArmsIconBox("bag",true);
      
      public var ctrlList:CtrlArmsList = new CtrlArmsList();
      
      public var nowCtrl:ItemsArmsIcon;
      
      public var buySiteBtn:SimpleButton;
      
      public var buyTarget:*;
      
      public var pageBox:PageBox;
      
      private var dragTarget:*;
      
      private var dragFather:*;
      
      private var dragBmp:Bitmap = new Bitmap();
      
      private var dragBmpSp:Sprite = new Sprite();
      
      private var dragPoint:Point = new Point();
      
      private var iconOverB:Boolean = false;
      
      public var upgradeCheckTip:MustTopDialogBox = new MustTopDialogBox();
      
      private var tipBox:ItemsTipbox = new ItemsTipbox();
      
      private var tip_mc:ArmsItemsTip = new ArmsItemsTip();
      
      public function EquipmentUI()
      {
         super();
      }
      
      protected function initData() : *
      {
         this.itemsData = Game.gameData.armsItems;
         this.mustDefine = Game.gameDefine.armsMust;
      }
      
      public function init() : *
      {
         this.initData();
         this.addEventListener(MouseEvent.MOUSE_UP,this.mouseUp);
         this.nowArms.setNum(2,4,240,284);
         this.nowArms.x = 37 + 47 * 2;
         this.nowArms.y = 110;
         this.nowArms.addEventListener(ClickEvent.ON_DOWN,this.iconDown);
         this.nowArms.addEventListener(ClickEvent.ON_UP,this.iconUp);
         this.nowArms.addEventListener(ClickEvent.ON_OVER,this.iconOver);
         this.nowArms.addEventListener(ClickEvent.ON_OUT,this.iconOut);
         this.nowArms.setTotalNum(8);
         this.fleshNowArms();
         addChild(this.nowArms);
         this.bagArms.setNum(2,4,240,284);
         this.bagArms.x = 630;
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
         addChild(this.buySiteBtn);
         this.buySiteBtn.visible = false;
         this.buySiteBtn.addEventListener(MouseEvent.CLICK,this.buyClick);
         this.buySiteBtn.addEventListener(MouseEvent.MOUSE_OUT,this.buyOut);
         addChild(this.upgradeCheckTip);
         this.upgradeCheckTip.visible = false;
      }
      
      public function fleshAll() : *
      {
         trace("武器栏刷新(可能是主或副)。");
         this.fleshBagArms();
         this.fleshNowArms();
         Game.eventGroup.fleshArms();
         Game.eventGroup.fleshSub();
         Game.uiGroup.carShow.copyAll();
         Game.gameData.fleshAdd_byItems();
      }
      
      public function fleshAll_noChange() : *
      {
         this.fleshBagArms();
         this.fleshNowArms();
         Game.eventGroup.fleshArms();
         Game.eventGroup.fleshSub();
         Game.gameData.fleshAdd_byItems();
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
      
      private function ctrlClick(event:ClickEvent) : *
      {
         var sp0:int = 0;
         var id0:ArmsItemsData = null;
         var d0:OneArmsDefine = null;
         var str0:* = undefined;
         var index0:int = event.index;
         if(this.nowCtrl != null)
         {
            if(index0 == 0)
            {
               if(this.nowCtrl.type == 2)
               {
                  this.itemsData.bag_to_equip(this.nowCtrl.itemsData.site,this.tempEquipSite);
               }
               else
               {
                  this.itemsData.bag_to_equip(this.nowCtrl.itemsData.site,this.equipSite);
               }
               this.fleshAll();
            }
            else if(index0 == 1)
            {
               sp0 = this.itemsData.findBagSpace();
               if(sp0 >= 0)
               {
                  this.itemsData.bag_to_equip(sp0,this.nowCtrl.itemsData.site);
               }
               this.fleshAll();
            }
            else if(index0 == 2)
            {
               Game.uiGroup.gotoResearch(this.type + "_upgrade",this.nowCtrl.itemsData.getID());
            }
            else if(index0 == 3)
            {
               id0 = this.nowCtrl.itemsData;
               d0 = id0.define;
               str0 = "你确定要卖出 <font color=\'#FFFF00\'>" + d0.name + "</font> 吗？";
               str0 += "\n" + "出售价格为：<font color=\'#FFFF00\'>" + d0.getSellPrice() + "</font> G币 。";
               this.upgradeCheckTip.showCheck(str0,this.sellArms);
            }
            else if(index0 == 5)
            {
               Game.uiGroup.gotoResearch(this.type + "_inlay",this.nowCtrl.itemsData.getID());
            }
            else if(index0 == 6)
            {
               this.upgradeCheckTip.showTip("人物等级不足，无法装备此武器。",2);
               Game.SG.playSound("failureItems");
            }
         }
         this.ctrlList.visible = false;
      }
      
      private function sellArms() : *
      {
         var id0:ArmsItemsData = null;
         var d0:OneArmsDefine = null;
         if(this.nowCtrl != null)
         {
            id0 = this.nowCtrl.itemsData;
            d0 = id0.define;
            this.itemsData.delItems_arr(this.itemsData.arr,id0.id);
            Game.gameData.addCoin(d0.getSellPrice());
            Game.SG.playSound("sellItems");
            this.fleshBagArms();
         }
      }
      
      private function buyClick(event:MouseEvent) : *
      {
         this.mustDefine.fleshByIndex(this.buyTarget.site);
         this.upgradeCheckTip.nowGCoin = Game.gameData.GCoin;
         this.upgradeCheckTip.nowMCoin = Game.gameData.MCoin;
         this.upgradeCheckTip.nowLevel = Game.gameData.level;
         this.upgradeCheckTip.nowRankLevel = Game.gameData.rankLevel;
         this.upgradeCheckTip.showMustCheck(this.mustDefine,"开启这个武器位需要：",this.buyCheckTip);
         if(this.type != "arms")
         {
            if(this.buyTarget.site == 3)
            {
               this.upgradeCheckTip.show50M_unlock(this.m50_buyCheck);
            }
         }
         this.buySiteBtn.visible = false;
      }
      
      public function m50_buyCheck() : *
      {
         Game.payController.decMCoin(50,this.affter_m50_buyCheck,this.affter_m50_buyCheck2);
      }
      
      public function affter_m50_buyCheck() : *
      {
         this.affterBuyCheckTip2();
      }
      
      public function affter_m50_buyCheck2() : *
      {
         this.upgradeCheckTip.showCheck2("M币不足！",2);
      }
      
      public function buyCheckTip() : *
      {
         if(this.mustDefine.MCoin > 0)
         {
            Game.payController.decMCoin(this.mustDefine.MCoin,this.affterBuyCheckTip);
         }
         else
         {
            this.affterBuyCheckTip();
         }
      }
      
      public function affterBuyCheckTip() : *
      {
         this.itemsData.unlockSite(this.buyTarget.site);
         Game.gameData.addCoin(-this.mustDefine.GCoin);
         this.fleshAll();
      }
      
      public function affterBuyCheckTip2() : *
      {
         this.itemsData.unlockSite(this.buyTarget.site);
         this.fleshAll();
      }
      
      private function buyOut(event:MouseEvent) : *
      {
         this.buySiteBtn.visible = false;
      }
      
      private function iconClick(event:ClickEvent) : *
      {
      }
      
      private function iconOver(event:ClickEvent) : *
      {
         var iai:ItemsArmsIcon = event.goal;
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
               }
               this.ctrlList.visible = false;
            }
            if(iai.state == "lock" && this.ctrlList.visible == false && this.dragTarget == null)
            {
               this.buySiteBtn.visible = true;
               this.buyTarget = iai;
               this.buySiteBtn.x = iai.x + event.target.x + iai.width / 2;
               this.buySiteBtn.y = iai.y + event.target.y + iai.height / 2;
               trace("buySiteBtn.visible:" + this.buySiteBtn.visible + "   x:" + this.buySiteBtn.x + "   y:" + this.buySiteBtn.y);
            }
            else
            {
               this.buySiteBtn.visible = false;
            }
         }
      }
      
      private function iconOut(event:ClickEvent) : *
      {
         this.tipBox.hide();
      }
      
      private function iconDown(event:ClickEvent) : *
      {
         var iai:ItemsArmsIcon = event.goal;
         if(iai.state == "fill" && iai.type != 3)
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
         var d20:OneArmsDefine = null;
         var d21:OneArmsDefine = null;
         var d22:OneArmsDefine = null;
         var iai:ItemsArmsIcon = event.goal;
         trace("武器图标鼠标释放！");
         if(this.dragTarget is ItemsArmsIcon)
         {
            this.iconOverB = true;
            box0 = event.target;
            if(iai.type != 3 && iai.state != "lock")
            {
               if(this.dragTarget != iai)
               {
                  if(box0.type == "equip" && this.dragFather.type == "bag")
                  {
                     if(iai.type == 2 && this.dragTarget.type != 2 || iai.type != 2 && this.dragTarget.type == 2)
                     {
                        trace("临时武器和其它武器不能互换");
                     }
                     else
                     {
                        d20 = this.itemsData.getItemsById(this.dragTarget.itemsID).define;
                        if(d20.mustLevel > Game.gameData.level + 1)
                        {
                           this.upgradeCheckTip.showTip("人物等级不足，无法装备此武器。",2);
                           Game.SG.playSound("failureItems");
                        }
                        else
                        {
                           this.itemsData.bagEquip_id(this.dragTarget.itemsID,iai.site);
                           this.fleshAll();
                        }
                     }
                  }
                  else if(box0.type == "equip" && this.dragFather.type == "equip")
                  {
                     if(iai.type == 2 && this.dragTarget.type != 2 || iai.type != 2 && this.dragTarget.type == 2)
                     {
                        trace("临时武器和其它武器不能互换");
                     }
                     else
                     {
                        this.itemsData.equip_to_equip(this.dragTarget.site,iai.site);
                        this.fleshAll();
                     }
                  }
                  else if(box0.type == "bag" && this.dragFather.type == "bag")
                  {
                     this.itemsData.bag_to_bag(this.dragTarget.site,iai.site);
                     this.fleshAll();
                  }
                  else if((iai.type == 2 && this.dragTarget.type != 2 || iai.type != 2 && this.dragTarget.type == 2) && iai.state != "blank")
                  {
                     trace("临时武器和其它武器不能互换");
                  }
                  else if(iai.state == "fill")
                  {
                     d21 = this.itemsData.getItemsById(iai.itemsID).define;
                     if(d21.mustLevel > Game.gameData.level + 1)
                     {
                        this.upgradeCheckTip.showTip("人物等级不足，无法装备此武器。",2);
                        Game.SG.playSound("failureItems");
                     }
                     else
                     {
                        this.itemsData.equipBag_id(this.dragTarget.itemsID,iai.site);
                        this.fleshAll();
                     }
                  }
                  else
                  {
                     this.itemsData.equipBag_id(this.dragTarget.itemsID,iai.site);
                     this.fleshAll();
                  }
                  Game.SG.playSound("dragDown");
               }
               else if(iai.state == "fill")
               {
                  if(this.dragTarget is ItemsArmsIcon && this.dragTarget == event.goal)
                  {
                     if(iai.type == 0 || iai.type == 1)
                     {
                        if(box0.type == "equip")
                        {
                           this.ctrlList.fleshName([1,2,5]);
                           this.ctrlList.x = iai.x + iai.width + this.ctrlList.width + this.nowArms.x - 20;
                        }
                        else
                        {
                           d22 = this.itemsData.getItemsById(this.dragTarget.itemsID).define;
                           if(d22.mustLevel > Game.gameData.level + 1)
                           {
                              if(d22.index >= 49)
                              {
                                 this.ctrlList.fleshName([6,5,3]);
                              }
                              else
                              {
                                 this.ctrlList.fleshName([6,2,5]);
                              }
                           }
                           else if(d22.index >= 49)
                           {
                              this.ctrlList.fleshName([0,5,3]);
                           }
                           else
                           {
                              this.ctrlList.fleshName([0,2,5]);
                           }
                           this.ctrlList.x = iai.x + this.bagArms.x + 20;
                        }
                        this.nowCtrl = iai;
                     }
                     this.ctrlList.y = iai.y + this.bagArms.y;
                     this.ctrlList.visible = true;
                     this.buySiteBtn.visible = false;
                  }
               }
            }
            this.stopDraging();
         }
         else if(iai.state == "fill" && iai.type == 3)
         {
            this.ctrlList.fleshName([2,5]);
            this.ctrlList.x = iai.x + iai.width + this.ctrlList.width + this.nowArms.x - 20;
            this.nowCtrl = iai;
            this.ctrlList.y = iai.y + this.bagArms.y;
            this.ctrlList.visible = true;
         }
      }
      
      private function mouseUp(event:MouseEvent) : *
      {
         if(this.dragTarget is ItemsArmsIcon)
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

