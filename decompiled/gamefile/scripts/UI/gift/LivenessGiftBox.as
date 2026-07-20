package UI.gift
{
   import UI.ClickEvent;
   import UI.items.ItemsBox;
   import UI.items.ItemsIcon;
   import data.StringToDefine;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import gameAll.define.liveness.LivenessGiftDefine;
   
   public class LivenessGiftBox extends Sprite
   {
      
      public var giftBox:ItemsBox = new ItemsBox();
      
      public var get_btn:SimpleButton;
      
      public var no_btn:*;
      
      public var txt:TextField;
      
      public var define:LivenessGiftDefine;
      
      public var index:int = 0;
      
      public function LivenessGiftBox()
      {
         super();
         this.giftBox.setLabelClass(ItemsIcon);
         this.giftBox.setNum(5,1,55 * 5,65);
         this.giftBox.x = 7;
         this.giftBox.y = 31;
         addChild(this.giftBox);
         this.get_btn.addEventListener(MouseEvent.CLICK,this.click);
      }
      
      public function inData_byDefine(d0:LivenessGiftDefine) : *
      {
         this.define = d0;
         this.setNum(d0.mustValue);
         var arr4:Array = Game.goodsDefineGroup.getArr_byStrArr(d0.giftArr,Game.gameData.level,true);
         this.giftBox.inData_byGoodsDefineArr(arr4,true);
      }
      
      public function click(event:MouseEvent) : *
      {
         var ce0:ClickEvent = new ClickEvent(ClickEvent.ON_CLICK);
         ce0.index = this.index;
         this.dispatchEvent(ce0.clone());
      }
      
      public function setNum(num0:int) : *
      {
         this.txt.htmlText = "活跃度 " + StringToDefine.getFontColor(num0 + "","#FFFF00");
      }
      
      public function showBtnState(str0:String) : *
      {
         this.get_btn.visible = false;
         this.no_btn.visible = false;
         if(str0 == "no")
         {
            this.no_btn.txt.text = "条件不足";
            this.no_btn.visible = true;
         }
         else if(str0 == "get")
         {
            this.get_btn.visible = true;
         }
         else if(str0 == "over")
         {
            this.no_btn.txt.text = "已领取";
            this.no_btn.visible = true;
         }
      }
   }
}

