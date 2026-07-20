package UI.research
{
   import UI.ClickEvent;
   import UI.button.MoreStateButton;
   import UI.label.LabelBox;
   import UI.label.LabelCtrl;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ResearchUI extends Sprite
   {
      
      public var label:String = "arms_upgrade";
      
      public var label_mc:*;
      
      public var switchLabel:LabelBox = new LabelBox();
      
      public var armsBox:ArmsResearchUI = new ArmsResearchUI();
      
      public var subBox:SubResearchUI = new SubResearchUI();
      
      public var playerBox:PlayerTrainUI = new PlayerTrainUI();
      
      public var crystalBox:CrystalUpgradeUI = new CrystalUpgradeUI();
      
      public var carBox:CarUpgradeUI = new CarUpgradeUI();
      
      public var labelCtrl:LabelCtrl = new LabelCtrl();
      
      public function ResearchUI()
      {
         super();
         this.labelCtrl.inData([this.label_mc.car_inlay_btn,this.label_mc.arms_inlay_btn,this.label_mc.sub_inlay_btn],this.label_mc.light_sp);
         this.labelCtrl.addEventListener(ClickEvent.ON_CLICK,this.labelClick);
         this.switchLabel.setLabelClass(MoreStateButton);
         this.switchLabel.addLabel(["arms_upgrade","arms_inlay","sub_upgrade","sub_inlay","player_upgrade","crystal_upgrade"],635,true,"label");
         addChild(this.switchLabel);
         this.switchLabel.x = 275;
         this.switchLabel.y = 14 - 200;
         this.switchLabel.addEventListener(ClickEvent.ON_CLICK,this.labelClick);
         addChild(this.armsBox);
         addChild(this.subBox);
         addChild(this.playerBox);
         addChild(this.crystalBox);
         addChild(this.carBox);
      }
      
      public function init() : *
      {
         this.armsBox.init();
         this.subBox.init();
         this.playerBox.init();
         this.crystalBox.init();
         this.showBox("arms_upgrade");
      }
      
      public function fleshAll() : *
      {
         this.armsBox.fleshAll();
         this.subBox.fleshAll();
         this.playerBox.fleshAll();
         this.crystalBox.fleshAll();
         this.fleshLevelNew();
      }
      
      public function clearNew() : *
      {
         var n:* = undefined;
         var n2:String = null;
         var label2:MoreStateButton = null;
         var arr2:Array = ["arms","sub","player"];
         for(n in arr2)
         {
            n2 = arr2[n];
            label2 = this.switchLabel.getByLabel(n2 + "_upgrade");
            label2.hideNew();
         }
         this.armsBox.clearNew();
         this.subBox.clearNew();
      }
      
      public function fleshLevelNew() : Boolean
      {
         var n:* = undefined;
         var n2:String = null;
         var label2:MoreStateButton = null;
         var newB0:Boolean = false;
         var arr2:Array = ["arms","sub"];
         for(n in arr2)
         {
            n2 = arr2[n];
            label2 = this.switchLabel.getByLabel(n2 + "_upgrade");
            if(Boolean(this[n2 + "Box"].getNewB()))
            {
               label2.showNew();
               newB0 = true;
            }
            else
            {
               label2.hideNew();
            }
         }
         return newB0;
      }
      
      public function flesh_byNowLabel() : *
      {
      }
      
      public function showBox(str0:String) : *
      {
         this.label = str0;
         if(str0 == "arms_upgrade")
         {
            str0 = "arms_inlay";
         }
         if(str0 == "sub_upgrade")
         {
            str0 = "sub_inlay";
         }
         this.labelCtrl.setChoose_byLabel(str0);
         this.armsBox.visible = false;
         this.subBox.visible = false;
         this.playerBox.visible = false;
         this.crystalBox.visible = false;
         this.carBox.visible = false;
         this.label_mc.visible = true;
         if(str0 == "arms_upgrade")
         {
            this.armsBox.visible = true;
            this.armsBox.fleshAll();
         }
         else if(str0 == "arms_inlay")
         {
            this.armsBox.visible = true;
            this.armsBox.fleshAll();
         }
         else if(str0 == "sub_upgrade")
         {
            this.subBox.visible = true;
            this.subBox.fleshAll();
         }
         else if(str0 == "sub_inlay")
         {
            this.subBox.visible = true;
            this.subBox.fleshAll();
         }
         else if(str0 == "car_inlay")
         {
            this.carBox.visible = true;
            this.carBox.fleshData();
         }
         else if(str0 == "player_upgrade")
         {
            this.playerBox.visible = true;
            this.switchLabel.showState(4);
            this.playerBox.fleshAll();
            this.label_mc.visible = false;
         }
         else if(str0 == "crystal_upgrade")
         {
            this.crystalBox.visible = true;
            this.switchLabel.showState(5);
            this.crystalBox.fleshAll();
            this.label_mc.visible = false;
         }
      }
      
      public function labelClick(event:ClickEvent) : *
      {
         this.fleshLevelNew();
         this.showBox(this.labelCtrl.nowLabel);
      }
      
      public function armsLabelClick(event:ClickEvent) : *
      {
         this.fleshLevelNew();
         if(event.index == 0)
         {
            this.showBox("arms_" + this.armsBox.label);
         }
         else
         {
            this.showBox("sub_" + this.armsBox.label);
         }
      }
      
      public function armsCarClick(event:ClickEvent) : *
      {
         this.fleshLevelNew();
         if(event.index == 0)
         {
            this.showBox("arms_" + this.armsBox.label);
         }
         else if(event.index == 1)
         {
            this.showBox("sub_" + this.armsBox.label);
         }
         else
         {
            this.showBox("car_" + this.armsBox.label);
         }
      }
      
      public function gotoChange(event:MouseEvent) : *
      {
         Game.uiGroup.show("equip");
      }
   }
}

