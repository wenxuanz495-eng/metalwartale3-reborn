package UI.gift
{
   import UI.ClickEvent;
   import UI.button.MoreStateButton;
   import UI.button.PicButton;
   import UI.label.LabelBox;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class AllGiftUI extends Sprite
   {
      
      public var return_btn:PicButton;
      
      public var label:String = "gift_pay1";
      
      public var switchLabel:LabelBox = new LabelBox();
      
      public var oneyuanUI:OneYuanUI = new OneYuanUI();
      
      public var pay1UI:PayGiftUI = new PayGiftUI();
      
      public var pay2UI:OnePayGiftUI = new OnePayGiftUI();
      
      public function AllGiftUI()
      {
         super();
         this.switchLabel.setLabelClass(MoreStateButton);
         this.switchLabel.auto = true;
         this.switchLabel.addLabel(["gift_pay1","gift_oneyuan"],240,true,"label");
         addChild(this.switchLabel);
         this.switchLabel.x = 192;
         this.switchLabel.y = 8 - 1000;
         this.switchLabel.addEventListener(ClickEvent.ON_CLICK,this.labelClick);
         addChild(this.oneyuanUI);
         addChild(this.pay1UI);
         addChild(this.pay2UI);
         this.showBox(this.label);
         this.return_btn.addEventListener(MouseEvent.CLICK,this.hide);
      }
      
      public function showBox(str0:String) : *
      {
         this.label = str0;
         this.oneyuanUI.visible = false;
         this.pay1UI.visible = false;
         this.pay2UI.visible = false;
         if(str0 == "gift_pay1")
         {
            this.pay1UI.visible = true;
         }
         else if(str0 == "gift_pay2")
         {
            this.pay2UI.visible = true;
         }
         else if(str0 == "gift_oneyuan")
         {
            this.oneyuanUI.visible = true;
         }
      }
      
      public function fleshData() : *
      {
         this.pay1UI.fleshData();
         this.pay2UI.fleshData();
         this.oneyuanUI.fleshData();
      }
      
      public function labelClick(event:ClickEvent) : *
      {
         var btn0:MoreStateButton = event.goal;
         var str0:String = btn0.text;
         this.showBox(str0);
      }
      
      public function hide(e:* = null) : *
      {
         this.visible = false;
      }
   }
}

