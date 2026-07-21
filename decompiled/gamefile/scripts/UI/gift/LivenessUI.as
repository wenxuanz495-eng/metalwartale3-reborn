package UI.gift
{
   import UI.ClickEvent;
   import data.StringToDefine;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
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

      private var refresh_btn:Sprite;

      private var refresh_txt:TextField;
      
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
         this.createRefreshButton();
         this.init_LivenessGift();
      }

      private function createRefreshButton() : *
      {
         this.refresh_btn = new Sprite();
         this.refresh_btn.x = 625;
         this.refresh_btn.y = 82;
         this.refresh_btn.buttonMode = true;
         this.refresh_btn.mouseChildren = false;
         this.refresh_btn.graphics.beginFill(2119953,1);
         this.refresh_btn.graphics.lineStyle(2,16763904,1);
         this.refresh_btn.graphics.drawRoundRect(0,0,112,32,6,6);
         this.refresh_btn.graphics.endFill();
         this.refresh_txt = new TextField();
         this.refresh_txt.defaultTextFormat = new TextFormat("_sans",15,16777215,true,null,null,null,null,"center");
         this.refresh_txt.width = 112;
         this.refresh_txt.height = 24;
         this.refresh_txt.y = 6;
         this.refresh_txt.text = "刷新活跃度";
         this.refresh_btn.addChild(this.refresh_txt);
         this.refresh_btn.addEventListener(MouseEvent.CLICK,this.askRefreshLiveness);
         this.addChild(this.refresh_btn);
         this.refresh_btn.visible = false;
      }
      
      public function fleshData() : *
      {
         this.fleshLivenessValue();
         this.fleshLivenessGift();
         this.fleshTask();
         this.refresh_btn.visible = this.liveData.value >= LivenessData.max;
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

      private function askRefreshLiveness(event:MouseEvent) : *
      {
         if(this.liveData.value < LivenessData.max)
         {
            return;
         }
         Game.uiGroup.checkTip.showCheck("刷新后活跃度、任务进度和礼包领取状态都会重置，未领取奖励也会消失。是否继续？",this.confirmRefreshLiveness);
      }

      private function confirmRefreshLiveness() : *
      {
         if(this.liveData.refreshAfterFull())
         {
            this.fleshData();
            Game.uiGroup.saveDataNoUI();
         }
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

