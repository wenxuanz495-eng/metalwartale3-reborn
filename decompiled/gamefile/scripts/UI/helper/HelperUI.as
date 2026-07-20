package UI.helper
{
   import UI.ClickEvent;
   import UI._new.change.CtrlListCtrl;
   import UI.button.SountoScrollBar;
   import UI.label.LabelCtrl;
   import UI.label.NormalIconBox;
   import flash.display.Sprite;
   
   public class HelperUI extends Sprite
   {
      
      public var label_arr:Array;
      
      public var nowLabel:String = "helper_help";
      
      public var nowContent:String = "arms";
      
      public var switchLabel:LabelCtrl;
      
      public var label_con:*;
      
      public var list:NormalIconBox;
      
      public var scrollBar:SountoScrollBar;
      
      public var cover_mc:Sprite;
      
      public var context:HelperContextBox;
      
      public var builder:HelperBuilder;
      
      public function HelperUI()
      {
         var n:* = undefined;
         this.switchLabel = new LabelCtrl();
         this.list = new NormalIconBox();
         this.scrollBar = new SountoScrollBar();
         this.context = new HelperContextBox();
         this.builder = new HelperBuilder();
         super();
         this.label_arr = Game.gameDefine.helper.label_arr;
         this.list.setSize(1,10,1,2);
         this.list.x = 148;
         this.list.y = 106;
         addChild(this.list);
         this.list.addEventListener(ClickEvent.ON_CLICK,this.listClick);
         var btn_arr0:Array = [];
         for(n in this.label_arr)
         {
            btn_arr0.push(this.label_con[this.label_arr[n] + "_btn"]);
         }
         this.switchLabel.inData(btn_arr0,this.label_con.light_sp);
         this.switchLabel.addEventListener(ClickEvent.ON_CLICK,this.switchLabelClick);
         this.scrollBar.setHigh(this.cover_mc.height - 5);
         this.context.setSize(1,100,1,4);
         this.context.x = 297;
         this.context.y = 55;
         addChild(this.context);
         addChild(this.scrollBar);
         this.scrollBar.x = 934;
         this.scrollBar.y = 54;
         this.scrollBar.setTarget(this.context);
         this.context.mask = this.cover_mc;
         this.context.addEventListener(ClickEvent.ON_CLICK,this.barClick);
      }
      
      public function fleshData() : *
      {
         this.showLabel(this.nowLabel);
         this.showContent(this.nowContent);
      }
      
      private function listClick(e:ClickEvent) : *
      {
         var l0:String = e.goal.itemsData.name;
         this.showContent(l0);
      }
      
      private function switchLabelClick(e:ClickEvent) : *
      {
         this.nowLabel = this.switchLabel.nowLabel;
         this.showLabel(this.nowLabel);
         var l1:String = this.nowLabel.replace("helper_","");
         var arr0:Array = Game.gameDefine.helper[l1 + "_arr"];
         if(arr0.length > 0)
         {
            this.showContent(arr0[0].name);
         }
      }
      
      private function showLabel(l0:String) : *
      {
         this.switchLabel.setChoose_byLabel(l0);
         var l1:String = l0.replace("helper_","");
         this.setList(l1);
      }
      
      private function setList(type0:String) : *
      {
         var n:* = undefined;
         var obj0:Object = null;
         var icon0:HelperLabelBar = null;
         this.list.clear();
         var arr0:Array = Game.gameDefine.helper[type0 + "_arr"];
         var arr1:Array = [];
         for(n in arr0)
         {
            obj0 = arr0[n];
            icon0 = new HelperLabelBar();
            icon0.setText(obj0.cnName);
            icon0.itemsData = obj0;
            arr1.push(icon0);
         }
         this.list.inData_byArr(arr1);
      }
      
      private function showContent(l0:String) : *
      {
         this.nowContent = l0;
         var lb0:* = this.list.getBarBy2("itemsData","name",l0);
         this.list.doFun("setState",0);
         if(Boolean(lb0))
         {
            lb0.setState(1);
         }
         this.addContent();
         this.scrollBar.setPer(0);
         this.scrollBar.setTarget(this.context);
      }
      
      private function addContent() : *
      {
         var arr0:Array = [];
         if(this.nowLabel == "helper_help")
         {
            if(this.nowContent == "arms")
            {
               arr0 = this.builder.armsResearch("arms").concat(this.builder.armsResearch("subArms"));
            }
            else if(this.nowContent == "car")
            {
               arr0 = this.builder.carReserch();
            }
            else if(this.nowContent == "level")
            {
               arr0 = this.builder.newLevel();
            }
            else if(this.nowContent == "skill")
            {
               arr0 = Game.gameData.playerData.getHelperContextBarDefine();
            }
         }
         else if(this.nowLabel == "helper_day")
         {
            if(this.nowContent == "task")
            {
               arr0 = this.builder.allTask();
            }
            else if(this.nowContent == "extra")
            {
               arr0 = this.builder.newExtra();
            }
            else if(this.nowContent == "gift")
            {
               arr0 = this.builder.newGift();
            }
            else if(this.nowContent == "other")
            {
               arr0 = this.builder.allOther();
            }
         }
         else if(this.nowLabel == "helper_strategy")
         {
            arr0 = this.builder["helper_strategy_" + this.nowContent]();
         }
         this.context.inData(arr0);
      }
      
      private function barClick(e:ClickEvent) : *
      {
         var str0:String = e.goal.define.gotoTarget;
         trace(str0);
         var arr0:Array = str0.split("/");
         var type0:String = arr0[0];
         var ui0:String = arr0[1];
         var id0:String = arr0[2];
         var id2:String = arr0[3];
         if(type0 == "arms")
         {
            Game.uiGroup.gotoResearch(ui0,id0);
         }
         else if(type0 == "armsBuy")
         {
            Game.uiGroup.researchUI.armsBox.gotoShop(ui0,id0);
         }
         else if(type0 == "car")
         {
            if(ui0 == "upgrade")
            {
               CtrlListCtrl.gotoCarUpgrade(id0);
            }
            else if(ui0 == "strengthen")
            {
               CtrlListCtrl.gotoCarUpgrade(id0,"strengthen");
            }
            else if(ui0 == "shop")
            {
               Game.uiGroup.show("shop");
               Game.uiGroup.shopUI.showBox(0);
               Game.uiGroup.shopUI.shopBox.showBox_byLabel("car");
               Game.uiGroup.shopUI.shopBox.pageBox.gotoPage(int(int(id0) / 8));
            }
            else if(ui0 == "exchange")
            {
               Game.uiGroup.show("shop");
               Game.uiGroup.shopUI.showBox(1);
            }
         }
         else if(type0 == "level")
         {
            Game.uiGroup.mainUI.taskUI.gotoOneLevel(ui0,int(id0),int(id2));
         }
         else if(type0 == "skill")
         {
            Game.uiGroup.gotoTrain_label(ui0);
         }
         else if(type0 == "task")
         {
            Game.uiGroup.show("task");
            Game.uiGroup.mainUI.taskUI.showBox(ui0);
         }
         else if(type0 == "extra")
         {
            Game.uiGroup.menu.show("extra");
            Game.uiGroup.show("extra");
            Game.uiGroup.extraUI.showLabel(ui0);
            if(arr0.length > 2)
            {
               Game.eventGroup.chosenLevel(int(id0),ui0,"");
            }
         }
         else if(type0 == "gift")
         {
            if(ui0 == "live")
            {
               Game.uiGroup.menu.show("main");
               Game.uiGroup.mainUI.showLivenessUI();
            }
            else if(ui0 == "rank")
            {
               Game.uiGroup.menu.show("main");
               Game.uiGroup.mainUI.showRankGift();
            }
            else if(ui0 == "vip")
            {
               Game.uiGroup.show("vip");
            }
         }
         else if(type0 == "other")
         {
            if(ui0 == "area")
            {
               Game.uiGroup.show("area");
            }
            else if(ui0 == "vipMap")
            {
               Game.uiGroup.show("vip");
               Game.eventGroup.chosenLevel(999);
            }
         }
         this.addContent();
      }
   }
}

