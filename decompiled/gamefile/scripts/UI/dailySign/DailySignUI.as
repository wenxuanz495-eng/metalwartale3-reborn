package UI.dailySign
{
   import UI.ClickEvent;
   import UI.calendar.CalendarDefine;
   import UI.explore.ExploreIconBox;
   import UI.label.LabelCtrl;
   import data.StringDate;
   import data.TextWay;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import gameAll.api.ShopBuyObject;
   import gameAll.data.DailySignData;
   import goods.GoodsDefine;
   
   public class DailySignUI extends Sprite
   {
      
      public var vip_btn:SimpleButton;
      
      public var sign_btn:SimpleButton;
      
      public var gift_btn:SimpleButton;
      
      public var noSign_btn:*;
      
      public var reSign_btn:* = new MovieClip();
      
      public var reSignCover_btn:* = new MovieClip();
      
      public var noGift_btn:*;
      
      public var noVip_btn:*;
      
      public var month_txt:TextField;
      
      public var nowNum_txt:TextField;
      
      public var label_arr:Array = [];
      
      public var nowIndex:int = 0;
      
      public var normalGiftBox:ExploreIconBox = new ExploreIconBox();
      
      public var vipGiftBox:ExploreIconBox = new ExploreIconBox();
      
      public var date_arr:Array = [];
      
      public var dData:DailySignData;
      
      private var dateStr:String = "";
      
      public var light_sp:Sprite;
      
      public var b1_btn:SimpleButton;
      
      public var b2_btn:SimpleButton;
      
      public var b3_btn:SimpleButton;
      
      public var b4_btn:SimpleButton;
      
      public var b5_btn:SimpleButton;
      
      private var _reSignNum:int = 0;
      
      public var labelCtrl:LabelCtrl = new LabelCtrl();
      
      public var txt_reSign:TextField;
      
      public function DailySignUI()
      {
         super();
         this.noSign_btn.stop();
         this.reSignCover_btn.stop();
         this.noGift_btn.stop();
         this.noVip_btn.stop();
         this.noSign_btn.txt.text = "签到";
         this.noGift_btn.txt.text = "已领取";
         this.noVip_btn.txt.text = "购买VIP";
         this.noSign_btn.visible = false;
         this.reSignCover_btn.visible = false;
         this.noGift_btn.visible = false;
         this.noVip_btn.visible = false;
         this.sign_btn.addEventListener(MouseEvent.CLICK,this.signClick);
         this.reSign_btn.addEventListener(MouseEvent.CLICK,this.resignClick);
         this.gift_btn.addEventListener(MouseEvent.CLICK,this.getGiftClick);
         this.vip_btn.addEventListener(MouseEvent.CLICK,this.vipClick);
         this.add31();
         this.normalGiftBox.setLabelClass(DailySignGiftBar);
         this.normalGiftBox.setNum(2,3,318,217);
         this.normalGiftBox.x = 617;
         this.normalGiftBox.y = 105;
         this.addChild(this.normalGiftBox);
         this.vipGiftBox.setLabelClass(DailySignGiftBar);
         this.vipGiftBox.setNum(2,1,318,56);
         this.vipGiftBox.x = 617;
         this.vipGiftBox.y = 357;
         this.addChild(this.vipGiftBox);
         this.dData = Game.gameData.dailySignData;
         this.labelCtrl.inData([this.b1_btn,this.b2_btn,this.b3_btn,this.b4_btn,this.b5_btn],this.light_sp);
         this.labelCtrl.addEventListener(ClickEvent.ON_CLICK,this.labelClick);
      }
      
      public function fleshData() : *
      {
         Game.severTime.getTime(this.affter_getDate,this.no_getDate);
      }
      
      private function affter_getDate(time00:String) : *
      {
         this.dateStr = TextWay.toCode(time00);
         this.fleshData_break();
         this.showLabel(this.nowIndex);
      }
      
      private function no_getDate(str:* = null) : *
      {
         Game.uiGroup.menu.show("main");
      }
      
      private function add31() : *
      {
         var bar0:DailyDateBar = null;
         for(var i:int = 1; i <= 31; i++)
         {
            bar0 = new DailyDateBar();
            this.date_arr.push(bar0);
            addChild(bar0);
            bar0.visible = false;
         }
      }
      
      private function fleshData_break() : *
      {
         var n:* = undefined;
         var firstSignDate:StringDate = null;
         var bar0:DailyDateBar = null;
         var i:int = 0;
         var nowDate0:StringDate = null;
         var nowDateStr0:String = null;
         var index0:int = 0;
         var sd0:StringDate = this.getNowDate();
         var saveArr:Array = this.dData.getSignArr();
         this.month_txt.text = sd0.month + 1 + "月";
         if(Boolean(saveArr[0]))
         {
            firstSignDate = new StringDate();
            firstSignDate.inData_byStr(saveArr[0]);
            if(sd0.month != firstSignDate.month)
            {
               this.dData.init();
               trace("新的一个月，清除之前的");
               saveArr = this.dData.getSignArr();
            }
         }
         this.nowNum_txt.text = saveArr.length + "";
         var sd1:Date = sd0.getOnlyDateClass();
         sd1.setDate(1);
         var day1:int = sd1.day;
         var dateNum0:int = CalendarDefine.getDateName(sd0.fullYear,sd0.month + 1);
         var todaySignB:Boolean = false;
         var coinueReSign:Boolean = false;
         this._reSignNum = 0;
         for(n in this.date_arr)
         {
            bar0 = this.date_arr[n];
            i = n + 1;
            if(i > dateNum0)
            {
               bar0.visible = false;
            }
            else
            {
               bar0.visible = true;
               bar0.date_txt.text = i + "";
               bar0.today_mc.visible = i == sd0.date;
               if(i == sd0.date)
               {
                  coinueReSign = true;
               }
               nowDate0 = sd0.copy();
               nowDate0.date = i;
               nowDateStr0 = nowDate0.getDateStr();
               bar0.yes_mc.visible = saveArr.indexOf(nowDateStr0) >= 0;
               index0 = i + (day1 + 6) % 7 - 1;
               bar0.x = 28 + index0 % 7 * 81;
               bar0.y = 121 + int(index0 / 7) * 52;
               if(bar0.today_mc.visible && bar0.yes_mc.visible)
               {
                  todaySignB = true;
               }
               if(!coinueReSign && !bar0.yes_mc.visible)
               {
                  ++this._reSignNum;
               }
            }
         }
         if(todaySignB)
         {
            this.noSign_btn.visible = true;
            this.sign_btn.visible = false;
         }
         else
         {
            this.noSign_btn.visible = false;
            this.sign_btn.visible = true;
         }
         if(this._reSignNum > 0)
         {
            this.reSign_btn.visible = true;
            this.reSignCover_btn.visible = false;
         }
         else
         {
            this.reSign_btn.visible = false;
            this.reSignCover_btn.visible = true;
         }
         this.txt_reSign.text = "可补签次数: " + this._reSignNum + "次";
      }
      
      private function getNowDate() : StringDate
      {
         var str0:String = TextWay.getText(this.dateStr);
         var sd0:StringDate = new StringDate();
         sd0.inData_byStr(str0);
         return sd0;
      }
      
      public function fleshGift() : *
      {
         var arr0:Array = Game.goodsDefineGroup.getArr_byStrArr(Game.gameDefine.dailySign.getGift_byIndex(this.nowIndex),1,true);
         var arr1:Array = Game.goodsDefineGroup.getArr_byStrArr(Game.gameDefine.dailySign.getVipGift_byIndex(this.nowIndex),1,true);
         this.normalGiftBox.inData_byArr(arr0,true);
         this.vipGiftBox.inData_byArr(arr1,true);
         var numArr:Array = Game.gameDefine.dailySign.getMustNum();
         var getGiftB_arr:Array = this.dData.getGiftGetArr();
         var nowNum0:int = int(numArr[this.nowIndex]);
         this.gift_btn.visible = false;
         this.noGift_btn.visible = true;
         if(this.dData.signArr.length >= nowNum0)
         {
            if(getGiftB_arr.indexOf(String(nowNum0)) >= 0)
            {
               this.noGift_btn.txt.text = "已领取";
            }
            else
            {
               this.gift_btn.visible = true;
               this.noGift_btn.visible = false;
            }
         }
         else
         {
            this.noGift_btn.txt.text = "领取奖励";
         }
      }
      
      private function showLabel(index0:int) : *
      {
         this.nowIndex = index0;
         this.fleshGift();
         this.labelCtrl.setChoose(index0);
      }
      
      private function labelClick(e:*) : *
      {
         trace(this.labelCtrl.nowIndex);
         this.showLabel(this.labelCtrl.nowIndex);
      }
      
      private function signClick(e:*) : *
      {
         this.dData.addSign(this.getNowDate().getDateStr());
         Game.uiGroup.checkTip.showTip("签到成功！",1);
         Game.SG.playSound("upgradeArms");
         this.fleshData_break();
         this.fleshGift();
      }
      
      private function resignClick(e:*) : void
      {
         Game.uiGroup.checkTip.showReSignCheck(this._reSignNum,this.yesBuy,true);
      }
      
      private function yesBuy() : void
      {
         var fun:Function;
         var count2:int = 0;
         var d0:GoodsDefine = Game.uiGroup.checkTip.buyDefine;
         var obj0:ShopBuyObject = new ShopBuyObject();
         obj0.price = 10;
         obj0.count = d0.num;
         obj0.tag = d0.name;
         obj0.propId = "1036";
         count2 = d0.num;
         fun = function():void
         {
            reSign(count2);
            Game.uiGroup.infoUI.fleshData();
         };
         Game.shop_api.buyPropNd(obj0,fun);
      }
      
      private function getGiftClick(e:*) : *
      {
         var arr0:Array = Game.goodsDefineGroup.getArr_byStrArr(Game.gameDefine.dailySign.getGift_byIndex(this.nowIndex),1,true);
         var arr1:Array = Game.goodsDefineGroup.getArr_byStrArr(Game.gameDefine.dailySign.getVipGift_byIndex(this.nowIndex),1,true);
         var newArr0:* = arr0;
         if(Game.gameData.vipData.nowVip != "")
         {
            newArr0 = arr0.concat(arr1);
         }
         var str0:String = Game.uiGroup.panGift_BagEnough(newArr0);
         if(str0 == "")
         {
            this.affter_getGiftClick();
         }
         else
         {
            Game.uiGroup.checkTip.showCheck2(str0,2);
         }
      }
      
      private function affter_getGiftClick() : *
      {
         var arr0:Array = Game.goodsDefineGroup.getArr_byStrArr(Game.gameDefine.dailySign.getGift_byIndex(this.nowIndex),1,true);
         var arr1:Array = Game.goodsDefineGroup.getArr_byStrArr(Game.gameDefine.dailySign.getVipGift_byIndex(this.nowIndex),1,true);
         var numArr:Array = Game.gameDefine.dailySign.getMustNum();
         var nowNum0:int = int(numArr[this.nowIndex]);
         this.dData.getGift(nowNum0);
         var newArr0:* = arr0;
         if(Game.gameData.vipData.nowVip != "")
         {
            newArr0 = arr0.concat(arr1);
         }
         Game.uiGroup.addGift_byArr(newArr0,true);
         Game.uiGroup.saveDataNoUI();
         this.fleshGift();
      }
      
      private function vipClick(e:*) : *
      {
         Game.uiGroup.show("vip");
      }
      
      public function reSign(num0:int) : *
      {
         var isCanRe:Boolean = false;
         var j:int = 0;
         var ls:String = null;
         var lsd:StringDate = null;
         var sd0:StringDate = this.getNowDate();
         var nn:int = sd0.date;
         var saveArr:Array = this.dData.getSignArr();
         for(var i:int = 1; i <= nn; i++)
         {
            isCanRe = true;
            for(j = 0; j < saveArr.length; j++)
            {
               ls = saveArr[j];
               lsd = new StringDate();
               lsd.inData_byStr(ls);
               if(lsd.date == i)
               {
                  isCanRe = false;
                  break;
               }
            }
            if(isCanRe != false)
            {
               sd0.date = i;
               this.dData.addSign(sd0.getDateStr());
               if(--num0 <= 0)
               {
                  break;
               }
            }
         }
         this.fleshData_break();
         this.fleshGift();
      }
      
      public function addSign(num0:int) : *
      {
         var sd0:StringDate = this.getNowDate();
         for(var i:int = 1; i <= num0; i++)
         {
            sd0.date = i;
            this.dData.addSign(sd0.getDateStr());
         }
         this.fleshData_break();
         this.fleshGift();
      }
   }
}

