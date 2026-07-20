package UI.change
{
   import UI.ClickEvent;
   import UI.button.MoreStateButton;
   import UI.button.PicButton;
   import UI.label.LabelBox;
   import UI.main.InfoUI;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ChangeUI extends MovieClip
   {
      
      public var infoUI:InfoUI;
      
      public var infoUI_mc:Sprite = new Sprite();
      
      public var carShow_mc:*;
      
      public var carShow:ChangeEquipImage;
      
      public var armsUI:EquipmentUI = new EquipmentUI();
      
      public var subUI:SubEquipmentUI = new SubEquipmentUI();
      
      public var carUI:CarEquipmentUI = new CarEquipmentUI();
      
      public var materialsUI:MaterialsUI = new MaterialsUI();
      
      public var propsUI:PropsUI = new PropsUI();
      
      public var return_btn:PicButton;
      
      public var btnBox:LabelBox = new LabelBox();
      
      public var nowUI:*;
      
      public var gotoResearch_btn:SimpleButton;
      
      public var gotoShop_btn:SimpleButton;
      
      public var front_mc:Sprite;
      
      public var armsMust_mc:Sprite;
      
      public var armsLabel:LabelBox = new LabelBox();
      
      public function ChangeUI()
      {
         super();
         this.return_btn.setText("return");
         this.btnBox.setLabelClass(MoreStateButton);
         this.btnBox.addLabel(["car","arms","sub","props","materials"],408);
         this.btnBox.x = 290;
         this.btnBox.y = 13 - 100;
         addChild(this.btnBox);
         this.front_mc.mouseChildren = false;
         this.front_mc.mouseEnabled = false;
         this.propsUI.unlockBag_btn.visible = false;
         this.propsUI.oneSell_btn.visible = false;
         this.propsUI.cleanUp_btn.visible = false;
         this.btnBox.addEventListener(ClickEvent.ON_CLICK,this.buttonClick);
         this.return_btn.addEventListener(MouseEvent.CLICK,this.mouseClick);
         this.gotoResearch_btn.addEventListener(MouseEvent.CLICK,this.gotoResearch);
         this.gotoShop_btn.addEventListener(MouseEvent.CLICK,this.gotoShop);
         this.armsLabel.setLabelClass(MoreStateButton);
         this.armsLabel.addLabel(["arms","sub"],284,true,"label2");
         this.armsLabel.x = 431;
         this.armsLabel.y = 17;
         addChild(this.armsLabel);
         this.armsLabel.addEventListener(ClickEvent.ON_CLICK,this.armsLabelClick);
      }
      
      public function onlyShowMaterials() : *
      {
         var n:* = undefined;
         var btn0:MoreStateButton = null;
         for(n in this.btnBox.arr)
         {
            btn0 = this.btnBox.arr[n];
            if(btn0.text == "materials")
            {
               btn0.actived = true;
               btn0.setState(1);
            }
            else
            {
               btn0.actived = false;
            }
         }
         this.return_btn.setText("bagToMenu");
         this.gotoResearch_btn.visible = false;
         this.gotoShop_btn.visible = false;
         this.return_btn.visible = true;
         Game.uiGroup.menu.visible = false;
      }
      
      public function showAll() : *
      {
         var n:* = undefined;
         var btn0:MoreStateButton = null;
         for(n in this.btnBox.arr)
         {
            btn0 = this.btnBox.arr[n];
            btn0.actived = true;
         }
         this.btnBox.showState(this.btnBox.nowIndex);
         this.return_btn.setText("return");
         this.gotoResearch_btn.visible = true;
         this.gotoShop_btn.visible = true;
      }
      
      public function init() : *
      {
         this.addChild(this.armsUI);
         this.addChild(this.subUI);
         this.addChild(this.carUI);
         this.addChild(this.materialsUI);
         this.addChild(this.propsUI);
         this.armsUI.init();
         this.subUI.init();
         this.carUI.init();
         this.materialsUI.init();
         this.propsUI.init();
         this.btnBox.showState(0);
         this.showBox("arms");
         this.addChild(this.return_btn);
      }
      
      public function gotoUI(labelStr:String) : *
      {
         this.showBox(labelStr);
      }
      
      public function setCarShow(_carShow:ChangeEquipImage) : *
      {
         this.carShow = _carShow;
         this.carShow_mc.addChild(this.carShow);
      }
      
      public function fleshAll() : *
      {
         this.armsUI.fleshAll_noChange();
         this.subUI.fleshAll_noChange();
         this.carUI.fleshAll_noChange();
         Game.uiGroup.carShow.copyAll();
         this.propsUI.fleshAll();
         this.materialsUI.fleshAll();
      }
      
      public function buttonClick(event:ClickEvent) : *
      {
         var index0:int = event.index;
         var str0:String = event.goal.text;
         this.showBox(str0);
      }
      
      public function showBox(str:String) : *
      {
         this.chooseUI(this[str + "UI"]);
         this.btnBox.showState(this.btnBox.getIndex(str));
         this.armsMust_mc.visible = true;
         this.armsLabel.visible = true;
         if(str == "arms")
         {
            this.armsLabel.showState(0);
         }
         else if(str == "sub")
         {
            this.armsLabel.showState(1);
         }
         else
         {
            this.armsMust_mc.visible = false;
            this.armsLabel.visible = false;
         }
      }
      
      public function armsLabelClick(event:ClickEvent) : *
      {
         var str0:String = event.goal.text;
         this.showBox(str0);
      }
      
      public function mouseClick(event:MouseEvent) : *
      {
         var name0:String = event.target.name;
         if(name0 == "return_btn")
         {
         }
      }
      
      public function chooseUI(ui0:*) : *
      {
         this.armsUI.visible = false;
         this.subUI.visible = false;
         this.carUI.visible = false;
         this.materialsUI.visible = false;
         this.propsUI.visible = false;
         ui0.visible = true;
         this.nowUI = ui0;
         if(this.nowUI === this.materialsUI || this.nowUI === this.propsUI)
         {
            this.materialsUI.visible = true;
            this.propsUI.visible = true;
         }
      }
      
      public function upMaterialsUI() : *
      {
         if(getChildIndex(this.materialsUI) < getChildIndex(this.propsUI))
         {
            swapChildren(this.materialsUI,this.propsUI);
         }
      }
      
      public function upPropsUI() : *
      {
         if(getChildIndex(this.materialsUI) > getChildIndex(this.propsUI))
         {
            swapChildren(this.materialsUI,this.propsUI);
         }
      }
      
      public function gotoShop(event:MouseEvent) : *
      {
         Game.uiGroup.gotoShop(this.btnBox.nowLabel);
      }
      
      public function gotoResearch(event:MouseEvent) : *
      {
         Game.uiGroup.show("upgrade");
      }
   }
}

