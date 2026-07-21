package UI.gift
{
   import UI.ClickEvent;
   import data.StringToDefine;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import gameAll.data.LivenessData;
   import gameAll.define.liveness.LivenessGiftDefine;
   import gameAll.define.liveness.LivenessTaskDefine;
   
   public class LivenessUI extends Sprite
   {
      
      public var liveData:LivenessData;
      
      public var baifen_bar:Sprite;
      
      public var baifen_txt:TextField;
      
      public var light_mc:Sprite;
      
      public var return_btn:SimpleButton;
      
      public var taskName_txt:TextField;
      
      public var taskGift_txt:TextField;
      
      public var taskMust_txt:TextField;
      
      public var arr:Array;
      
      public var gift_1:LivenessGiftBox;
      
      public var gift_2:LivenessGiftBox;
      
      public var gift_3:LivenessGiftBox;
      
      public var gift_4:LivenessGiftBox;
      
      public var gift_5:LivenessGiftBox;
      
      public function LivenessUI()
      {
         var box0:LivenessGiftBox = null;
         this.arr = [];
         super();
         for(var i:int = 0; i < 5; i++)
         {
            box0 = this["gift_" + (i + 1)];
            box0.index = i;
            box0.addEventListener(ClickEvent.ON_CLICK,this.getLivenessGift);
            this.arr.push(box0);
         }
         this.liveData = Game.gameData.livenessData;
         this.return_btn.addEventListener(MouseEvent.CLICK,this.hide);
         this.init_LivenessGift();
      }
      
      public function fleshData() : *
      {
         this.fleshLivenessValue();
         this.fleshLivenessGift();
         this.fleshTask();
      }
      
      public function fleshTask() : *
      {
         var n:* = undefined;
         var d0:LivenessTaskDefine = null;
         var now_v:int = 0;
         var arr0:Array = this.liveData.taskNumArr;
         var taskArr:Array = Game.gameDefine.liveness.taskArr;
         var nameStr:String = "";
         var giftStr:String = "";
         var mustStr:String = "";
         for(n in arr0)
         {
            d0 = taskArr[n];
            if(Boolean(d0))
            {
               now_v = int(arr0[n]);
               nameStr += d0.name + "\n";
               giftStr += d0.gift + "\n";
               if(now_v == -1)
               {
                  mustStr += StringToDefine.getFontColor(d0.must + "","#00FF00") + "/" + d0.must + "\n";
               }
               else
               {
                  mustStr += StringToDefine.getFontColor(now_v + "","#FF0000") + "/" + d0.must + "\n";
               }
            }
         }
         this.taskName_txt.htmlText = nameStr;
         this.taskGift_txt.htmlText = giftStr;
         this.taskMust_txt.htmlText = mustStr;
      }
      
      public function fleshLivenessGift() : *
      {
         var n:* = undefined;
         var box0:LivenessGiftBox = null;
         var arr1:Array = this.liveData.getGiftStateArr();
         for(n in this.arr)
         {
            box0 = this.arr[n];
            box0.showBtnState(arr1[n]);
         }
      }
      
      public function fleshLivenessValue() : *
      {
         this.baifen_txt.htmlText = this.liveData.value + "";
         var baifen0:Number = this.liveData.value / LivenessData.max;
         if(baifen0 > 1)
         {
            baifen0 = 1;
         }
         if(baifen0 < 0)
         {
            baifen0 = 0;
         }
         this.baifen_bar.scaleX = baifen0;
         this.light_mc.x = this.baifen_bar.x + this.baifen_bar.width;
      }

      private function init_LivenessGift() : *
      {
         var n:* = undefined;
         var box0:LivenessGiftBox = null;
         var d0:LivenessGiftDefine = null;
         for(n in this.arr)
         {
            box0 = this.arr[n];
            d0 = Game.gameDefine.liveness.arr[n];
            box0.inData_byDefine(d0);
         }
      }
      
      public function btnMove(event:MouseEvent = null) : *
      {
      }
      
      public function btnOver(event:MouseEvent) : *
      {
      }
      
      public function btnOut(event:MouseEvent) : *
      {
      }
      
      public function getLivenessGift(event:ClickEvent) : *
      {
         var giftArr:Array = event.target.define.giftArr;
         var arr1:Array = Game.goodsDefineGroup.getArr_byStrArr(giftArr,Game.gameData.level,true);
         var bagTipStr:String = Game.uiGroup.panGift_BagEnough(arr1);
         if(bagTipStr == "")
         {
            Game.uiGroup.addGift_byArr(arr1,true);
            this.liveData.getGift_byIndex(event.index);
            this.fleshData();
            Game.uiGroup.saveDataNoUI();
         }
         else
         {
            Game.uiGroup.checkTip.showCheck2(bagTipStr,2);
         }
      }
      
      public function hide(e:* = null) : *
      {
         this.visible = false;
      }
   }
}

