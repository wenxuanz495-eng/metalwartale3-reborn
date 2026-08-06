package UI._new.change
{
   import UI.ClickEvent;
   import UI._new.icon.ChangeIconBox;
   import UI._new.icon.NormalAllIcon;
   import UI.page.PageBox;
   import flash.display.Sprite;
   import flash.utils.getTimer;
   import gameAll.data.ArmsItemsData;
   import gameAll.data.CarItemsData;
   
   public class _ChangeUI extends Sprite
   {
      
      public var bag:_BagUI;
      
      public var armsBox:ChangeIconBox;
      
      public var subBox:ChangeIconBox;
      
      public var carBox:ChangeIconBox;
      
      public var dragCtrl:_DragController;
      
      public function _ChangeUI()
      {
         var n:* = undefined;
         this.armsBox = new ChangeIconBox();
         this.subBox = new ChangeIconBox();
         this.carBox = new ChangeIconBox();
         this.dragCtrl = new _DragController();
         super();
         this.mouseEnabled = false;
         this.armsBox.horizontalB = false;
         this.armsBox.setSize(2,4,1,1);
         this.armsBox.setDataGroup(Game.gameData.armsItems,"arms","equip");
         this.armsBox.x = 336;
         this.armsBox.y = 157;
         this.armsBox.fleshNum();
         this.armsBox.page.visible = false;
         addChild(this.armsBox);
         this.subBox.horizontalB = false;
         this.subBox.setSize(2,4,1,1);
         this.subBox.setDataGroup(Game.gameData.subItems,"sub","equip");
         this.subBox.x = 336;
         this.subBox.y = 330;
         this.subBox.fleshNum();
         this.subBox.page.visible = false;
         addChild(this.subBox);
         this.carBox.setSize(1,1,1,1);
         this.carBox.setDataGroup(Game.gameData.carItems,"car","equip");
         this.carBox.x = 42;
         this.carBox.y = 380;
         this.carBox.page.visible = false;
         addChild(this.carBox);
         addChild(this.dragCtrl);
         for(n in this.bag.box_arr)
         {
            this.addEvent(this.bag.box_arr[n]);
         }
         this.addEvent(this.armsBox);
         this.addEvent(this.subBox);
         this.addEvent(this.carBox);
      }
      
      public function fleshData(bagFleshB:Boolean = true) : *
      {
         this.armsBox.fleshData();
         this.subBox.fleshData();
         this.carBox.fleshData();
         if(bagFleshB)
         {
            this.bag.fleshData();
         }
         if(Game.gameState == "no")
         {
            Game.uiGroup.menu.visible = true;
         }
         else
         {
            Game.uiGroup.menu.visible = false;
         }
         Game.uiGroup.allback.fleshByGameState();
         this.bag.fleshByGameState();
      }
      
      public function addOutEvent(box0:ChangeIconBox) : *
      {
         box0.addEventListener(ClickEvent.ON_OVER,Game.uiGroup.itemsIconOver);
         box0.addEventListener(ClickEvent.ON_OUT,Game.uiGroup.itemsIconOut);
      }
      
      private function addEvent(box0:ChangeIconBox) : *
      {
         this.addOutEvent(box0);
         box0.addEventListener(ClickEvent.ON_DOWN,this.iconDown);
         box0.addEventListener(ClickEvent.ON_UP,this.iconUp);
         box0.addEventListener(ClickEvent.ON_OVER,this.iconOver);
         box0.addEventListener(ClickEvent.ON_OUT,this.iconOut);
      }
      
      private function iconDown(e:ClickEvent) : *
      {
         if(getTimer() - PageBox.lastUISwitchAt < 220)
         {
            return;
         }
         var icon0:NormalAllIcon = e.goal;
         if(icon0.state == "fill")
         {
            this.dragCtrl.startDraging(e.goal,e.target);
         }
      }
      
      private function iconUp(e:ClickEvent) : *
      {
         var moveB0:Boolean = false;
         var arms_d0:ArmsItemsData = null;
         var arms_d1:ArmsItemsData = null;
         var car_d0:CarItemsData = null;
         var car_d1:CarItemsData = null;
         this.dragCtrl.stopDraging();
         if(getTimer() - PageBox.lastUISwitchAt < 220)
         {
            this.dragCtrl.clear();
            Game.uiGroup.itemsIconOut();
            this.bag.oneSell_box.visible = false;
            this.bag.oneSellCar_box.visible = false;
            CtrlListCtrl.hideList();
            return;
         }
         var ic2:NormalAllIcon = e.goal;
         var now_ic:NormalAllIcon = this.dragCtrl.dragTarget;
         var fa2:* = e.target;
         var fa0:ChangeIconBox = this.dragCtrl.dragFather;
         var canDragUpB:Boolean = false;
         if(Boolean(this.dragCtrl.dragTarget) && ic2.state != "lock")
         {
            if(!(fa0.type == "car" && fa0.dataType == "equip" && ic2.state != "fill"))
            {
               if(ic2 != this.dragCtrl.dragTarget)
               {
                  moveB0 = true;
                  if(fa2.allType == "arms")
                  {
                     if(!(now_ic.itemsData is ArmsItemsData))
                     {
                        return;
                     }
                     arms_d0 = now_ic.itemsData;
                     arms_d1 = ic2.itemsData;
                     if(fa2.dataType == "equip")
                     {
                        if(arms_d0.getArmsDefine().installLevel > Game.gameData.level + 1)
                        {
                           moveB0 = false;
                        }
                     }
                     if(this.dragCtrl.dragFather.dataType == "equip")
                     {
                        if(Boolean(arms_d1))
                        {
                           if(arms_d1.getArmsDefine().installLevel > Game.gameData.level + 1)
                           {
                              moveB0 = false;
                           }
                        }
                     }
                     if(!moveB0)
                     {
                        Game.uiGroup.checkTip.showCheck2("武器装备等级太高，无法装备。",2);
                     }
                  }
                  else if(fa2.allType == "car")
                  {
                     if(!(now_ic.itemsData is CarItemsData))
                     {
                        return;
                     }
                     car_d0 = now_ic.itemsData;
                     car_d1 = ic2.itemsData;
                     if(fa2.dataType == "equip")
                     {
                        if(car_d0.skinB)
                        {
                           moveB0 = false;
                           Game.uiGroup.checkTip.showCheck2("战车皮肤没有属性，不能装备到战车栏。",2);
                        }
                        else if(car_d0.getNowInstallLevel() > Game.gameData.level + 1)
                        {
                           moveB0 = false;
                        }
                     }
                     if(this.dragCtrl.dragFather.dataType == "equip")
                     {
                        if(Boolean(car_d1))
                        {
                           if(car_d1.skinB)
                           {
                              moveB0 = false;
                              Game.uiGroup.checkTip.showCheck2("战车皮肤没有属性，不能与已装备战车交换。",2);
                           }
                           else if(car_d1.getNowInstallLevel() > Game.gameData.level + 1)
                           {
                              moveB0 = false;
                           }
                        }
                     }
                     if(!moveB0 && !car_d0.skinB && !(car_d1 != null && car_d1.skinB))
                     {
                        Game.uiGroup.checkTip.showCheck2("车身装备等级太高，无法装备。",2);
                     }
                  }
                  if(moveB0)
                  {
                     canDragUpB = true;
                     MoveIconCtrl.move(this.dragCtrl.dragTarget,this.dragCtrl.dragFather,ic2,fa2);
                     this.dragCtrl.dragFather.fleshData();
                     if(fa2 != this.dragCtrl.dragFather)
                     {
                        fa2.fleshData();
                     }
                  }
               }
            }
         }
         if(ic2.state == "fill" && !canDragUpB)
         {
            CtrlListCtrl.iconClick(ic2,fa2);
            CtrlListCtrl.fleshFun = this.fleshData;
         }
         if(ic2.state == "lock")
         {
            CtrlListCtrl.unlockClick(ic2,fa2);
         }
         this.dragCtrl.clear();
         Game.uiGroup.itemsIconOut();
         this.bag.oneSell_box.visible = false;
         Game.gameData.fleshAdd_byItems();
         Game.uiGroup.allback.info.fleshData();
         if(Game.gameState != "no")
         {
            Game.eventGroup.fleshArms();
            Game.eventGroup.fleshSub();
            Game.eventGroup.fleshCar();
         }
      }
      
      private function iconOver(e:ClickEvent) : *
      {
      }
      
      private function iconOut(e:ClickEvent) : *
      {
      }
   }
}

