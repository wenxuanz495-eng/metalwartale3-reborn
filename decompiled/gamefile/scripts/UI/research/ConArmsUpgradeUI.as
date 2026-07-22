package UI.research
{
   import UI.icon.ItemsArmsIcon;
   import UI.items.ItemsBox;
   import UI.items.ItemsIcon;
   import body.define.OneArmsDefine;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import gameAll.data.ArmsItemsData;
   import gameAll.data.ArmsItemsDataGroup;
   import gameAll.data.GoodsItemsDataGroup;
   import items.ItemsDefine;
   
   public class ConArmsUpgradeUI extends Sprite
   {
      
      public var itemsData:ArmsItemsDataGroup;
      
      public var materialsItems:GoodsItemsDataGroup;
      
      public var nowArmsChoose:ItemsArmsIcon = null;
      
      public var nowArms:ItemsArmsIcon = new ItemsArmsIcon();
      
      public var name_txt:TextField;
      
      public var now_txt:TextField;
      
      public var next_txt:TextField;
      
      public var mustItemsBox:ItemsBox = new ItemsBox();
      
      public var upgrade_btn:SimpleButton;
      
      public var no_btn:SimpleButton;
      
      public var no_mc:*;
      
      public function ConArmsUpgradeUI()
      {
         super();
         this.upgrade_btn.addEventListener(MouseEvent.MOUSE_UP,this.upgradeClick);
         this.no_mc.visible = false;
         this.mustItemsBox.setLabelClass(ItemsIcon);
         this.mustItemsBox.setNum(2,2,135,123);
         this.mustItemsBox.x = 727;
         this.mustItemsBox.y = 248;
         addChild(this.mustItemsBox);
         addChild(this.no_mc);
         this.itemsData = Game.gameData.armsItems;
         this.materialsItems = Game.gameData.materialsItems;
         this.nowArms.x = 500;
         this.nowArms.y = 83;
         addChild(this.nowArms);
      }
      
      public function chooseIcon(icon0:ItemsArmsIcon) : *
      {
         var enoughB:Boolean = false;
         if(Boolean(this.nowArmsChoose))
         {
            this.nowArmsChoose.setState2("");
         }
         this.nowArmsChoose = icon0;
         this.nowArmsChoose.setState2("choose");
         var data0:ArmsItemsData = icon0.itemsData;
         var d0:OneArmsDefine = data0.define;
         this.nowArms.inData_byItems(data0);
         this.name_txt.text = d0.commonLevel + "";
         var spStr:String = d0.specialType;
         var nowLv:int = int(spStr.split("Level_Growth_")[1]) + data0.strengLevel;
         var nextLv:int = nowLv + 1;
         this.now_txt.text = "角色等级+" + nowLv;
         this.next_txt.text = "角色等级+" + nextLv;
         var mustArr:Array = Game.gameDefine.armsUpgrade.getConMust(data0.strengLevel + 1);
         if(mustArr.length > 0)
         {
            this.no_mc.visible = false;
            enoughB = this.mustItemsBox.inData_byMustStr(mustArr);
            this.upgrade_btn.mouseEnabled = enoughB;
            this.upgrade_btn.alpha = enoughB ? 1 : 0.4;
         }
         else
         {
            this.no_mc.visible = true;
            this.no_mc.txt.text = "该武器已经升至满级";
            this.upgrade_btn.mouseEnabled = false;
            this.upgrade_btn.alpha = 0.4;
         }
      }
      
      public function upgradeClick(event:MouseEvent) : *
      {
         var n:* = undefined;
         var dd0:ArmsItemsData = null;
         var data0:ArmsItemsData = null;
         var items0:ItemsDefine = null;
         for(n in this.mustItemsBox.arr)
         {
            items0 = this.mustItemsBox.arr[n].itemsData;
            if(items0.getPropB())
            {
               Game.gameData.propsItems.useItemsNum(items0.name,items0.nowNum);
            }
            else
            {
               this.materialsItems.useItemsNum(items0.name,items0.nowNum);
            }
         }
         dd0 = this.nowArmsChoose.itemsData;
         data0 = this.itemsData.getItemsByBase(dd0.baseLabel);
         data0.upgradeStrengLevel();
         data0.fleshData();
         this.chooseIcon(this.nowArmsChoose);
         Game.SG.playSound("upgradeArms");
         Game.uiGroup.checkTip.showTip("升级成功！",1);
         Game.gameData.honorData.checkWeaponMasterHonor();
      }
   }
}

