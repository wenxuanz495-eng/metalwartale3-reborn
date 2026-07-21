package UI.research
{
   import UI.ClickEvent;
   import UI.change.CarIconBox;
   import UI.icon.ItemsCarIcon;
   import UI.page.PageBox;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import gameAll.data.CarItemsData;
   import gameAll.data.CarItemsDataGroup;
   import gameAll.define.car.CarStrengthenDefine;
   
   public class CarUpgradeUI extends Sprite
   {
      
      public var carItemsData:CarItemsDataGroup;
      
      public var choose_mc:*;
      
      public var carBox:CarIconBox = new CarIconBox();
      
      public var pageBox:PageBox;
      
      public var itemsIcon:ItemsCarIcon;
      
      public var now_txt:TextField;
      
      public var next_txt:TextField;
      
      public var maxLevel_mc:*;
      
      public var nowIndex:int = 0;
      
      public var upgradeBox:CarUpgradeBox;
      
      public var strengthenBox:CarStrengthenBox;
      
      public function CarUpgradeUI()
      {
         super();
         this.mouseEnabled = false;
         this.maxLevel_mc.visible = false;
         this.choose_mc.mouseChildren = false;
         this.choose_mc.mouseEnabled = false;
         this.choose_mc.back.stop();
         this.carBox.setNum(1,3,166,297);
         this.carBox.x = 59;
         this.carBox.y = 110;
         addChild(this.carBox);
         this.carItemsData = Game.gameData.carItems;
         this.carBox.addEventListener(ClickEvent.ON_CLICK,this.carIconClick);
         this.maxLevel_mc.stop();
         this.pageBox.fleshFun = this.fleshChooseShow;
         this.upgradeBox = new CarUpgradeBox();
         this.strengthenBox = new CarStrengthenBox();
         addChild(this.upgradeBox);
         addChild(this.strengthenBox);
         this.upgradeBox.upgrade_btn.addEventListener(MouseEvent.CLICK,this.upgradeClick);
         this.strengthenBox.strengthen_btn.addEventListener(MouseEvent.CLICK,this.strengthenClick);
         this.upgradeBox.no_btn.addEventListener(MouseEvent.CLICK,this.backStrengthen);
         this.strengthenBox.gotoUpgrade_btn.addEventListener(MouseEvent.CLICK,this.gotoUpgrade);
         addChild(this.maxLevel_mc);
      }
      
      public function fleshData() : *
      {
         this.fleshCarList();
         if(this.nowIndex > this.carBox.arr.length - 1)
         {
            this.nowIndex = 0;
         }
         if(this.carBox.arr.length > 0)
         {
            this.chooseStrengthenCar(this.nowIndex);
         }
      }
      
      public function fleshCarList() : *
      {
         var n:* = undefined;
         var arr0:Array = this.carItemsData.equArr.concat(this.carItemsData.arr);
         var arr1:Array = [];
         for(n in arr0)
         {
            arr1.push(arr0[n]);
         }
         this.carBox.inData_byItems(arr1);
         this.pageBox.table = this.carBox;
         this.pageBox.fleshByTable();
         if(arr1.length == 0)
         {
            this.nowIndex = 0;
            this.maxLevel_mc.visible = true;
            this.maxLevel_mc.txt.text = "没有车身可供升级";
         }
         else
         {
            this.maxLevel_mc.visible = false;
         }
      }
      
      public function fleshChooseShow() : *
      {
         if(this.nowIndex > this.carBox.arr.length - 1)
         {
            this.choose_mc.visible = false;
         }
         else
         {
            this.choose_mc.visible = int(this.nowIndex / 3) == this.pageBox.nowPage;
         }
      }
      
      public function carIconClick(e:ClickEvent) : *
      {
         this.chooseStrengthenCar(e.index);
         Game.SG.playSound("normal_btn");
      }
      
      public function gotoCar(id0:String, type0:String = "upgrade") : *
      {
         var n:* = undefined;
         var d0:CarItemsData = null;
         trace("前往id：" + id0);
         var index0:int = 0;
         for(n in this.carBox.arr)
         {
            d0 = this.carBox.arr[n].itemsData;
            if(Boolean(d0))
            {
               if(d0.id == id0)
               {
                  index0 = n;
                  break;
               }
            }
         }
         this.pageBox.gotoPage(int(index0 / 3));
         if(type0 == "upgrade")
         {
            this.chooseUpgradeCar(index0);
         }
         else
         {
            this.chooseStrengthenCar(index0);
         }
      }
      
      public function chooseCarIcon(index0:int) : Boolean
      {
         var data0:CarItemsData = null;
         var p0:Point = null;
         this.nowIndex = index0;
         var icon0:ItemsCarIcon = this.carBox.arr[index0];
         if(Boolean(icon0))
         {
            data0 = icon0.itemsData;
            this.itemsIcon.inData_byItems(data0);
            this.choose_mc.visible = true;
            p0 = icon0.localToGlobal(new Point());
            this.choose_mc.x = p0.x;
            this.choose_mc.y = p0.y;
            this.fleshChooseShow();
            return true;
         }
         this.choose_mc.visible = false;
         this.itemsIcon.clearData();
         this.now_txt.text = "";
         this.next_txt.text = "";
         this.upgradeBox.visible = false;
         this.strengthenBox.visible = false;
         return false;
      }
      
      public function chooseUpgradeCar(index0:int) : *
      {
         if(!this.chooseCarIcon(index0))
         {
            return;
         }
         this.upgradeBox.visible = true;
         this.strengthenBox.visible = false;
         var icon0:ItemsCarIcon = this.carBox.arr[index0];
         var data0:CarItemsData = icon0.itemsData;
         this.maxLevel_mc.visible = data0.getMaxUpgradeB();
         this.maxLevel_mc.gotoAndStop(1);
         this.now_txt.text = data0.getNowUpgradeText();
         this.next_txt.text = data0.getNextUpgradeText();
         this.upgradeBox.inData(data0);
      }
      
      public function upgradeClick(e:*) : *
      {
         var icon0:ItemsCarIcon = this.carBox.arr[this.nowIndex];
         var data0:CarItemsData = icon0.itemsData;
         var mustM0:int = data0.getNextMustM();
         Game.payController.decMCoin(mustM0,this.completeUpgrade);
      }
      
      public function completeUpgrade() : *
      {
         var icon0:ItemsCarIcon = this.carBox.arr[this.nowIndex];
         var data0:CarItemsData = icon0.itemsData;
         data0.upgrade();
         this.chooseUpgradeCar(this.nowIndex);
         Game.uiGroup.checkTip.showTip("升级成功！",1);
         Game.SG.playSound("upgradeArms");
      }
      
      public function backStrengthen(e:*) : *
      {
         this.upgradeBox.visible = false;
         this.strengthenBox.visible = true;
         this.chooseStrengthenCar(this.nowIndex);
      }
      
      public function chooseStrengthenCar(index0:int) : *
      {
         if(!this.chooseCarIcon(index0))
         {
            return;
         }
         this.upgradeBox.visible = false;
         this.strengthenBox.visible = true;
         var icon0:ItemsCarIcon = this.carBox.arr[index0];
         var data0:CarItemsData = icon0.itemsData;
         this.maxLevel_mc.visible = data0.getMaxStrengthenB();
         this.maxLevel_mc.gotoAndStop(2);
         this.now_txt.text = data0.getNowStrengthenText();
         this.next_txt.text = data0.getNextStrengthenText();
         this.strengthenBox.inData(data0);
      }
      
      public function strengthenClick(e:*) : *
      {
         var icon0:ItemsCarIcon = this.carBox.arr[this.nowIndex];
         var data0:CarItemsData = icon0.itemsData;
         var d0:CarStrengthenDefine = data0.getNextStrengthenDefine();
         var xmust0:Number = d0.superalloy_X;
         var ymust0:Number = d0.superalloy_Y;
         if(xmust0 > 0)
         {
            Game.gameData.materialsItems.useItemsNum("superalloy_X",xmust0);
         }
         if(ymust0 > 0)
         {
            Game.gameData.materialsItems.useItemsNum("superalloy_Y",ymust0);
         }
         if(Math.random() <= d0.successRate)
         {
            this.completeStrengthen();
         }
         else
         {
            this.chooseStrengthenCar(this.nowIndex);
            Game.uiGroup.checkTip.showTip("强化失败！",2);
            Game.SG.playSound("failureItems");
            Game.uiGroup.saveDataNoUI();
         }
      }
      
      public function completeStrengthen() : *
      {
         var icon0:ItemsCarIcon = this.carBox.arr[this.nowIndex];
         var data0:CarItemsData = icon0.itemsData;
         data0.strengthen();
         this.chooseStrengthenCar(this.nowIndex);
         Game.uiGroup.checkTip.showTip("强化成功！",1);
         Game.SG.playSound("upgradeArms");
         Game.uiGroup.saveDataNoUI();
      }
      
      public function gotoUpgrade(e:*) : *
      {
         this.upgradeBox.visible = true;
         this.strengthenBox.visible = false;
         this.chooseUpgradeCar(this.nowIndex);
      }
   }
}

