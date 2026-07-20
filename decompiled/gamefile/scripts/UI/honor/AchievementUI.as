package UI.honor
{
   import UI.ClickEvent;
   import UI.button.SountoScrollBar;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import gameAll.honor.AchievementData;
   import gameAll.honor.AchievementOneData;
   import gameAll.honor.AchievementOneDefine;
   
   public class AchievementUI extends Sprite
   {
      
      public var acData:AchievementData;
      
      public var labelList:AchievementLabel = new AchievementLabel();
      
      public var list:Array = [];
      
      public var list_con:Sprite = new Sprite();
      
      public var list_cover:Sprite;
      
      public var sBar:SountoScrollBar;
      
      public var completeB:Boolean = true;
      
      public var nowType:String = "lv";
      
      public var ac_txt:TextField;
      
      public var baifen_bar:Sprite;
      
      public var baifen_txt:TextField;
      
      public var baifen_max:Number = 1;
      
      public function AchievementUI()
      {
         super();
         this.mouseEnabled = false;
         this.init();
         this.acData = Game.gameData.honorData.ac;
      }
      
      public function init() : *
      {
         this.baifen_max = this.baifen_bar.scaleX;
         this.labelList.x = 50;
         this.labelList.y = 160;
         this.labelList.addBigLabel();
         addChild(this.labelList);
         addChild(this.list_con);
         this.list_con.x = 310;
         this.list_con.y = 95;
         this.list_con.mask = this.list_cover;
         this.sBar.setHigh(this.list_cover.height);
         this.sBar.setTarget(this.list_con);
         addChild(this.sBar);
         this.labelList.addEventListener(ClickEvent.ON_CLICK,this.labelClick);
      }
      
      private function labelClick(event:ClickEvent) : *
      {
         this.nowType = this.labelList.nowSmallType;
         this.show_byType(this.labelList.nowSmallType);
      }
      
      public function setBaifen(num1:Number, num2:Number) : *
      {
         this.baifen_txt.text = num1 + "/" + num2;
         this.baifen_bar.scaleX = this.baifen_max * (num1 / num2);
      }
      
      public function show_byType(type0:String) : *
      {
         var n:* = undefined;
         var d0:* = undefined;
         var bar0:AchievementBar = null;
         this.fleshAcValue();
         this.clearAllList();
         this.acData.fleshComplete(type0);
         var arr0:Array = [];
         if(this.completeB)
         {
            arr0 = this.acData.getCompleteList(type0);
         }
         else
         {
            arr0 = this.acData.getNoCompleteList(type0);
         }
         for(n in arr0)
         {
            d0 = arr0[n];
            bar0 = new AchievementBar();
            bar0.inData(d0);
            this.list_con.addChild(bar0);
            bar0.x = 295 * (n % 2);
            bar0.y = 190 * int(n / 2);
            bar0._btn.addEventListener(MouseEvent.CLICK,this.giftClick);
            this.list.push(bar0);
         }
         this.sBar.setPer(0);
         this.sBar.setTarget(this.list_con,false);
         addChild(this.sBar);
      }
      
      public function clearAllList() : *
      {
         var n:* = undefined;
         var bar0:AchievementBar = null;
         for(n in this.list)
         {
            bar0 = this.list[n];
            bar0._btn.removeEventListener(MouseEvent.CLICK,this.giftClick);
            this.list_con.removeChild(bar0);
         }
         this.list.length = 0;
      }
      
      private function giftClick(event:MouseEvent) : *
      {
         var data0:AchievementOneData = event.target.parent.itemsData;
         var d0:AchievementOneDefine = data0.getDefine();
         var giftArr0:Array = d0.giftArr;
         var d_arr:Array = Game.goodsDefineGroup.getArr_byStrArr(giftArr0,Game.gameData.level,true);
         var str0:String = Game.uiGroup.panGift_BagEnough(d_arr);
         if(str0 == "")
         {
            Game.uiGroup.addGift_byArr(d_arr,true);
            data0.haveGiftB = true;
            if(d0.honor != "")
            {
               Game.gameData.honorData.addHonor(d0.honor);
            }
            this.acData.addValue(d0.acValue);
         }
         else
         {
            Game.uiGroup.checkTip.showCheck2(str0,2);
         }
         event.target.parent.inData(data0);
         this.fleshAcValue();
      }
      
      public function fleshAcValue() : *
      {
         this.ac_txt.text = this.acData.acValue + "";
         var max0:Number = Game.gameDefine.honor.ac.getAllPoint();
         this.setBaifen(this.acData.acValue,max0);
      }
   }
}

