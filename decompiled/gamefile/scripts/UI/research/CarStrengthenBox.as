package UI.research
{
   import UI.items.ItemsIcon;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.text.TextField;
   import gameAll.data.CarItemsData;
   import gameAll.define.car.CarStrengthenDefine;
   import items.ItemsDefine;
   
   public class CarStrengthenBox extends Sprite
   {
      
      public var progress_txt:TextField;
      
      public var must_txt:TextField;
      
      public var rate_txt:TextField;
      
      public var mustItems1:ItemsIcon;
      
      public var mustItems2:ItemsIcon;
      
      public var condition_icon1:MovieClip;
      
      public var condition_icon3:MovieClip;
      
      public var strengthen_btn:SimpleButton;
      
      public var gotoUpgrade_btn:SimpleButton;
      
      public function CarStrengthenBox()
      {
         super();
         this.condition_icon1.stop();
         this.condition_icon3.stop();
      }
      
      public function inData(data0:CarItemsData) : *
      {
         this.progress_txt.text = data0.strengthenNum + "/" + data0.getMaxStrengthenLevel();
         var mustB:Boolean = true;
         var d0:CarStrengthenDefine = data0.getNextStrengthenDefine();
         trace(data0.getDefine().name + ":" + data0.getDefine().getType());
         var upgradeB:Boolean = data0.getDefine().getType() != "G";
         this.gotoUpgrade_btn.mouseEnabled = upgradeB;
         this.gotoUpgrade_btn.alpha = upgradeB ? 1 : 0.4;
         if(!d0)
         {
            return;
         }
         var xmust0:Number = d0.superalloy_X;
         var ymust0:Number = d0.superalloy_Y;
         var xnow0:Number = Game.gameData.materialsItems.getNumByBase("superalloy_X");
         var ynow0:Number = Game.gameData.materialsItems.getNumByBase("superalloy_Y");
         var xd0:ItemsDefine = Game.itemsDefineGroup.getDefine("superalloy_X");
         var yd0:ItemsDefine = Game.itemsDefineGroup.getDefine("superalloy_Y");
         this.mustItems1.inData_byDefine(xd0);
         this.mustItems1.visible = xmust0 > 0;
         this.mustItems2.inData_byDefine(yd0);
         this.mustItems2.visible = ymust0 > 0;
         this.mustItems1.setMustNum(xnow0,xmust0);
         this.mustItems2.setMustNum(ynow0,ymust0);
         if(xnow0 < xmust0 || ynow0 < ymust0)
         {
            mustB = false;
            this.condition_icon3.gotoAndStop(2);
         }
         else
         {
            this.condition_icon3.gotoAndStop(1);
         }
         this.strengthen_btn.mouseEnabled = mustB;
         this.strengthen_btn.alpha = mustB ? 1 : 0.4;
         this.rate_txt.text = "强化成功率：" + Number(d0.successRate * 100).toFixed(0) + "%";
      }
   }
}

