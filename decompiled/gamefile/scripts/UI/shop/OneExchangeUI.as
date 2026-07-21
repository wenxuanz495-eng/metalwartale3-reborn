package UI.shop
{
   import UI.change.CarItemsTip;
   import UI.dialog.ItemsTipbox;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import gameAll.NormalMustDefine;
   import gameAll.data.ArmsItemsData;
   import gameAll.data.CarItemsData;
   import gameAll.data.GameData;
   import gameAll.data.car.CarDataCreator;
   import goods.ExchangeData;
   import goods.GoodsDefine;
   import goods.GoodsDefineGroup;
   
   public class OneExchangeUI extends Sprite
   {
      
      public const ITEMMAX:int = 8;
      
      public const REFRESHTIME:int = 300000;
      
      public var car_btn:SimpleButton;
      
      public var arms_btn:SimpleButton;
      
      public var sub_btn:SimpleButton;
      
      public var props_btn:SimpleButton;
      
      public var materials_btn:SimpleButton;
      
      public var light_sp:Sprite;
      
      public var txt_time:TextField;
      
      private var tipBox:ItemsTipbox = new ItemsTipbox();
      
      private var tip_mc:CarItemsTip = new CarItemsTip();
      
      public var shopitem_0:Sprite;
      
      public var shopitem_1:Sprite;
      
      public var shopitem_2:Sprite;
      
      public var shopitem_3:Sprite;
      
      public var shopitem_4:Sprite;
      
      public var shopitem_5:Sprite;
      
      public var shopitem_6:Sprite;
      
      public var shopitem_7:Sprite;
      
      public var GDG:GoodsDefineGroup;
      
      public var GD:GameData;
      
      public var nowBuyGoods:GoodsDefine = null;
      
      public var noGoodsShow:*;
      
      public var refresh_btn:SimpleButton;
      
      private var sib:ShopIconBox = null;
      
      private var _dateArr:Array = [];
      
      private var _timer:Timer = new Timer(1000);
      
      private var _tempDT:DataTag = null;
      
      public function OneExchangeUI()
      {
         super();
         this.mouseEnabled = false;
         this.sib = new ShopIconBox();
         this.sib.setLabelClass(ShopIcon);
         this.sib.setNum(4,3,721,364);
         this.sib.x = 208;
         this.sib.y = 82;
         addChild(this.sib);
         this.tipBox.inBackData(Game.swfLoaderManager.getResource("dialogbox","Dialogbox_mc3"));
         this.tipBox.visible = false;
         this.tipBox.mouseChildren = false;
         this.tipBox.mouseEnabled = false;
         addChild(this.tipBox);
         this.tip_mc.visible = false;
         this.tip_mc.mouseChildren = false;
         this.tip_mc.mouseEnabled = false;
         addChild(this.tip_mc);
         this._timer.addEventListener(TimerEvent.TIMER,this.onTimer);
         if(Boolean(this.noGoodsShow))
         {
            this.noGoodsShow.visible = false;
            this.noGoodsShow["txt"].text = "暂无该类型商品";
         }
         this.refresh_btn.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      protected function onTimer(event:TimerEvent) : void
      {
         var lstd:Array = null;
         if(this.GD.lastExchangeData != null)
         {
            lstd = this.GD.lastExchangeData.split("_");
         }
         if(lstd == null || lstd.length != 2 || isNaN(Number(lstd[0])))
         {
            this.freshData();
            lstd = this.GD.lastExchangeData.split("_");
         }
         var data:Number = Number(lstd[0]);
         var nd:Date = Game.timeDate.getSaveDate.getDateClass();
         var nowTime:Number = getTimer() + nd.getTime();
         var decTime:Number = this.REFRESHTIME - (nowTime - data);
         if(decTime <= 0)
         {
            decTime = 0;
            this.affterRefresh2();
         }
         else if(decTime > this.REFRESHTIME)
         {
            decTime = this.REFRESHTIME;
         }
         this.txt_time.text = "刷新剩余时间: " + int(decTime / 1000 / 60) + "分" + int(decTime / 1000 % 60) + "秒";
         // No more first-batch wait message; stock is available on first open.
      }
      
      protected function onClick(event:MouseEvent) : void
      {
         var d0:NormalMustDefine = new NormalMustDefine();
         d0.MCoin = Game.gameDefine.refreshExchange;
         Game.uiGroup.checkTip.showMustCheck(d0,"立即刷新需要",this.materialsClick_1);
      }
      
      private function materialsClick_1() : void
      {
         trace("立即刷新");
         var mustM:int = Game.gameDefine.refreshExchange;
         Game.payController.decMCoin(mustM,this.affterRefresh);
      }
      
      private function affterRefresh() : void
      {
         this.freshData(false);
         this.showByData();
         Game.uiGroup.shopUI.fleshPrice();
         Game.uiGroup.infoUI.fleshData();
      }
      
      private function affterRefresh2() : void
      {
         this.freshData();
         this.showByData();
      }
      
      public function init() : *
      {
         this.GDG = Game.goodsDefineGroup;
         this.GD = Game.gameData;
         this.fleshAll();
      }
      
      public function clearAll() : *
      {
         this._timer.stop();
         this.nowBuyGoods = null;
         this._dateArr = [];
      }
      
      private function checkCanFresh() : Boolean
      {
         var nd:Date = Game.timeDate.getSaveDate.getDateClass();
         var nowTime:Number = getTimer() + nd.getTime();
         // First enter / empty placeholder: always generate goods immediately.
         // Old logic wrote an empty stock string and forced a wait ("第一批货物运达").
         if(this.GD.lastExchangeData == null || this.isEmptyExchangePlaceholder(this.GD.lastExchangeData))
         {
            return true;
         }
         var lstd:Array = this.GD.lastExchangeData.split("_");
         if(lstd.length != 2)
         {
            return true;
         }
         var data:Number = Number(lstd[0]);
         if(nowTime < 0 || nowTime - data < this.REFRESHTIME)
         {
            return false;
         }
         return true;
      }

      private function isEmptyExchangePlaceholder(data0:String) : Boolean
      {
         if(data0 == null || data0 == "")
         {
            return true;
         }
         // Matches old first-open empty payload: time + "_0|0,0|0,..."
         if(data0.indexOf("0|0,0|0,0|0,0|0,0|0,0|0") >= 0)
         {
            return true;
         }
         if(data0.indexOf("_0|0,") >= 0 && data0.split(",").length <= 8)
         {
            // still treat pure empty flags as empty
            var body:String = data0.split("_").length > 1 ? data0.split("_")[1] : data0;
            return body.replace(/0|\|/g,"").replace(/,/g,"") == "";
         }
         return false;
      }
      
      public function fleshAll() : *
      {
         if(this.checkCanFresh())
         {
            this.freshData();
         }
         else
         {
            this.getData();
            // Recover old empty "waiting for first stock" saves.
            if(this._dateArr == null || this._dateArr.length == 0 || this.isEmptyExchangePlaceholder(this.GD.lastExchangeData))
            {
               this.freshData();
            }
         }
         this.showByData();
      }
      
      private function showByData() : void
      {
         var i:int = 0;
         var mc:Sprite = null;
         var dt:DataTag = null;
         for(i = 0; i < this.ITEMMAX; i++)
         {
            mc = this["shopitem_" + i];
            mc["num_txt"].visible = false;
            mc["money_icon2"].visible = false;
            mc["price_txt2"].visible = false;
            mc["lock_mc"].visible = false;
            mc["buy_btn"].visible = false;
            mc["buy_btn2"].visible = true;
            mc.visible = false;
            dt = this._dateArr[i];
            if(dt is DataTag && Boolean(dt.ed))
            {
               mc["name_txt"].text = dt.ed.Name;
               mc["price_txt"].text = dt.ed.EPayCount + "";
               this.removeAllChild(mc["icon"]);
               this.addIcon(mc["icon"],"exchangeIcon_" + dt.ed.Id);
               this.setCanBuyBtn(dt,mc);
               (mc["money_icon"] as MovieClip).gotoAndStop(this.getPriceFrameLabel(dt.ed.EPayType));
               mc["edata"] = dt.ed;
               mc.addEventListener(MouseEvent.MOUSE_OVER,this.onItemOver);
               mc.addEventListener(MouseEvent.MOUSE_OUT,this.onItemOut);
               mc.visible = true;
            }
         }
      }
      
      protected function onItemOut(event:MouseEvent) : void
      {
         this.tipBox.hide();
      }
      
      protected function onItemOver(event:MouseEvent) : void
      {
         var mc:ShopIcon = event.currentTarget as ShopIcon;
         if(mc == null || mc.edata == null)
         {
            return;
         }
         var ed:ExchangeData = mc["edata"];
         this.tip_mc.title_txt.text = ed.Name;
         this.tip_mc.txt.text = ed.Desc;
         this.tipBox.showDialog(this.tip_mc,event.currentTarget,event.currentTarget.x,event.currentTarget.y);
      }
      
      private function setCanBuyBtn(dt:DataTag, mc:Sprite) : void
      {
         var gd:GoodsDefine = this.GD.getNowGoodsDefine();
         var gtype:String = this.getPriceFrameLabel(dt.ed.EPayType);
         if(dt.flag == 1)
         {
            mc["buy_btn"].visible = false;
            mc["buy_btn2"].visible = true;
            mc["buy_btn2"]["txt"].text = "已经兑换";
            return;
         }
         if(gd[gtype] >= dt.ed.EPayCount)
         {
            mc["buy_btn"].visible = true;
            mc["buy_btn2"].visible = false;
            mc["buy_btn"]["txt"].text = "兑换";
            (mc["buy_btn"] as ShopBuyButton).data = dt;
            (mc["buy_btn"] as MovieClip).addEventListener(MouseEvent.CLICK,this.onBuyTips);
         }
         else
         {
            mc["buy_btn"].visible = false;
            mc["buy_btn2"].visible = true;
            mc["buy_btn2"]["txt"].text = dt.ed.EPayType + "不足";
         }
      }
      
      protected function onBuyTips(event:MouseEvent) : void
      {
         var ran:Number = NaN;
         var aid0:ArmsItemsData = null;
         var mc:MovieClip = event.currentTarget as MovieClip;
         var dt:DataTag = mc["data"];
         if(dt == null)
         {
            return;
         }
         var maxI:int = dt.ed.DropProba.length - 1;
         for(var i:int = dt.ed.DropProba.length - 1; i >= 0; i--)
         {
            if(dt.ed.DropProba[i] > dt.ed.DropProba[maxI])
            {
               maxI = i;
            }
            ran = Math.random();
            if(ran <= dt.ed.DropProba[i])
            {
               maxI = i;
               break;
            }
         }
         var giftName:String = dt.ed.DropGroup[maxI];
         var gd:GoodsDefine = this.GDG.GetGoodsByName(giftName);
         if(gd == null)
         {
            return;
         }
         if(gd.type == "sub")
         {
            aid0 = this.GD.subItems.getItemsByBase(gd.id,true);
            if(aid0 is ArmsItemsData)
            {
               Game.uiGroup.checkTip.showCheck2("该物品只能兑换一次",1);
               return;
            }
         }
         var surplusNum:int = 0;
         if(gd.type == "material" || gd.type == "crystal" || gd.type == "chip")
         {
            gd.type = "materials";
         }
         if(gd.type == "card")
         {
            gd.type = "props";
         }
         surplusNum = int(this.GD[gd.type + "Items"].getSurplus());
         var d0:GoodsDefine = new GoodsDefine();
         var gtype:String = this.getPriceFrameLabel(dt.ed.EPayType);
         d0[gtype] = dt.ed.EPayCount;
         d0.name = dt.ed.Name;
         this._tempDT = dt;
         Game.uiGroup.checkTip.showShopCheck(d0,this.onBuyClick,false,surplusNum);
      }
      
      protected function onBuyClick() : void
      {
         var ran:Number = NaN;
         var value:Number = NaN;
         var newGood:CarItemsData = null;
         var dt:DataTag = this._tempDT;
         var ed:ExchangeData = dt.ed;
         if(ed == null)
         {
            return;
         }
         var maxI:int = ed.DropProba.length - 1;
         for(var i:int = ed.DropProba.length - 1; i >= 0; i--)
         {
            if(ed.DropProba[i] > ed.DropProba[maxI])
            {
               maxI = i;
            }
            ran = Math.random();
            if(ran <= ed.DropProba[i])
            {
               maxI = i;
               break;
            }
         }
         switch(ed.EPayType)
         {
            case "金币":
               value = 0;
               value = Math.ceil(Game.gameData.vipData.discount * ed.EPayCount);
               Game.gameData.addCoin(-value);
               break;
            case "超合金X":
               this.GD.materialsItems.useItemsNum("superalloy_X",ed.EPayCount);
               break;
            case "超合金Y":
               this.GD.materialsItems.useItemsNum("superalloy_Y",ed.EPayCount);
               break;
            case "荣誉勋章":
               this.GD.propsItems.useItemsNum("justice_badge",ed.EPayCount);
         }
         var giftName:String = ed.DropGroup[maxI];
         var gd:GoodsDefine = this.GDG.GetGoodsByName(giftName);
         if(Boolean(gd))
         {
            if(gd.type == "material" || gd.type == "crystal" || gd.type == "chip")
            {
               gd.type = "materials";
            }
            if(gd.type == "card")
            {
               gd.type = "props";
            }
            this._tempDT.flag = 1;
            gd.num = ed.DropNum[maxI];
            if(gd.type == "car")
            {
               if(gd.name == "帝皇战车" && !this.CheckCarHas("dihuang"))
               {
                  if(!(this.CheckCarHas("dihu") && this.CheckCarHas("fengying") && this.CheckCarHas("heixi") && this.CheckCarHas("xueao") && this.CheckCarHas("yanlong")))
                  {
                     Game.uiGroup.checkTip.showCheck2("该物品需要集齐地虎,风鹰,黑犀,雪獒,炎龙5辆战车才能兑换!",1);
                     this._tempDT.flag = 0;
                     this.GD.propsItems.useItemsNum("justice_badge",-ed.EPayCount);
                     return;
                  }
               }
               newGood = this.GD[gd.type + "Items"].addItems(gd.id);
               if(gd.name == "地虎" || gd.name == "风鹰" || gd.name == "黑犀" || gd.name == "雪獒" || gd.name == "炎龙" || gd.name == "帝皇战车")
               {
                  gd.define.itemsData.color = "green";
               }
               CarDataCreator.setExchangeData(newGood,9,gd.define.itemsData.color);
            }
            else
            {
               Game.uiGroup.addGift_byArr([gd],true,-1,false);
            }
            Game.uiGroup.checkTip.showCheck2("兑换到" + ed.DropNum[maxI] + "个" + giftName,2);
            this._tempDT = null;
            this.saveBought();
            this.fleshAll();
            Game.uiGroup.saveDataNoUI();
         }
         Game.SG.playSound("buyItems");
         Game.uiGroup.shopUI.fleshPrice();
         Game.uiGroup.infoUI.fleshData();
      }
      
      private function CheckCarHas(id:String) : Boolean
      {
         var aid0:CarItemsData = this.GD.carItems.getItemsByBase(id);
         if(aid0 is CarItemsData)
         {
            return true;
         }
         return false;
      }
      
      private function saveBought() : void
      {
         var dt:DataTag = null;
         var arr:Array = [];
         for(var i:int = 0; i < this._dateArr.length; i++)
         {
            dt = this._dateArr[i];
            arr.push(dt.ed.Id + "|" + dt.flag);
         }
         var darr:Array = this.GD.lastExchangeData.split("_");
         darr[1] = arr.join(",");
         this.GD.lastExchangeData = darr.join("_");
      }
      
      private function addIcon(param0:DisplayObjectContainer, param1:String) : void
      {
         var gic:BitmapData = Game.swfLoaderManager.getResource("itemsUI",param1);
         if(gic == null)
         {
            return;
         }
         var bit:Bitmap = new Bitmap(gic);
         if(bit.width > 145)
         {
            bit.width = 145;
         }
         if(bit.height > 62)
         {
            bit.height = 62;
         }
         bit.x = -bit.width / 2;
         bit.y = -bit.height / 2;
         param0.addChild(bit);
      }
      
      private function removeAllChild(dc:DisplayObjectContainer) : void
      {
         while(dc.numChildren > 0)
         {
            dc.removeChildAt(0);
         }
      }
      
      private function getPriceFrameLabel(type:String) : String
      {
         switch(type)
         {
            case "金币":
               return "price";
            case "超合金X":
               return "Xprice";
            case "超合金Y":
               return "Yprice";
            case "荣誉勋章":
               return "Jprice";
            default:
               return type;
         }
      }
      
      private function getData() : void
      {
         var sda:String = null;
         var edid:int = 0;
         var edtag:int = 0;
         var gd:ExchangeData = null;
         var dtag:DataTag = null;
         var lstd:Array = this.GD.lastExchangeData.split("_");
         if(lstd.length != 2)
         {
            this.freshData();
            return;
         }
         this._dateArr = [];
         var datas:String = lstd[1];
         var dataArr:Array = datas.split(",");
         for(var i:int = 0; i < dataArr.length; i++)
         {
            sda = dataArr[i];
            edid = int(sda.split("|")[0]);
            edtag = int(sda.split("|")[1]);
            gd = Game.exchangeDefineGroup.getItemById(edid);
            dtag = new DataTag();
            dtag.ed = gd;
            dtag.flag = edtag;
            this._dateArr.push(dtag);
         }
      }
      
      private function freshData(issave:Boolean = true) : void
      {
         var ed:ExchangeData = null;
         var dataArr:Array = this.GDG.ExchangeItems.concat();
         this._dateArr = [];
         var dtag:DataTag = null;
         this.randomizeArray(dataArr);
         var i:int = 0;
         for(i = 0; i < dataArr.length && this._dateArr.length < this.ITEMMAX; i++)
         {
            ed = dataArr[i];
            if(Boolean(ed) && ed.Proba >= Math.random())
            {
               dtag = new DataTag();
               dtag.ed = ed;
               dtag.flag = 0;
               this._dateArr.push(dtag);
            }
         }
         // Fill any remaining slots from the same shuffled pool without duplicates.
         for(i = 0; i < dataArr.length && this._dateArr.length < this.ITEMMAX; i++)
         {
            ed = dataArr[i];
            if(Boolean(ed) && !this.containsExchangeData(ed))
            {
               dtag = new DataTag();
               dtag.ed = ed;
               dtag.flag = 0;
               this._dateArr.push(dtag);
            }
         }
         this.saveSeverTimeData(issave);
      }

      private function containsExchangeData(ed:ExchangeData) : Boolean
      {
         var dt:DataTag = null;
         for(var i:int = 0; i < this._dateArr.length; i++)
         {
            dt = this._dateArr[i];
            if(dt != null && dt.ed != null && dt.ed.Id == ed.Id)
            {
               return true;
            }
         }
         return false;
      }
      
      private function saveSeverTimeData(issave:Boolean) : void
      {
         var dtag:DataTag = null;
         var ed:ExchangeData = null;
         var sarr:Array = [];
         var sstr:String = "";
         for(var i:int = 0; i < this._dateArr.length; i++)
         {
            dtag = this._dateArr[i];
            ed = dtag.ed;
            sarr.push(ed.Id + "|" + dtag.flag);
         }
         sstr = sarr.join(",");
         var data:Number = Game.timeDate.getSaveDate.getDateClass().getTime();
         var sdate:String = data + getTimer() + "_" + sstr;
         this.GD.lastExchangeData = sdate;
         if(issave)
         {
            Game.uiGroup.saveDataNoUI();
         }
      }
      
      private function randomizeArray(myArray:Array) : Array
      {
         myArray.sort(function():*
         {
            return Math.random() - 0.5;
         });
         return myArray;
      }
      
      public function fleshPrice() : *
      {
      }
      
      public function showBox_byLabel() : *
      {
         this.sib.visible = true;
         if(this._timer.running == false)
         {
            this._timer.start();
         }
         if(this.GDG.ExchangeItems.length == 0)
         {
            this.noGoodsShow.visible = true;
            this.noGoodsShow.txt.text = "暂无兑换物品!";
         }
         else if(this.isEmptyExchangePlaceholder(this.GD.lastExchangeData))
         {
            this.freshData(false);
            this.showByData();
            this.onTimer(null);
            return;
         }
         else
         {
            this.noGoodsShow.visible = false;
         }
         this.fleshAll();
         this.onTimer(null);
      }
   }
}

import goods.ExchangeData;

class DataTag
{
   
   public var ed:ExchangeData;
   
   public var flag:int = 0;
   
   public function DataTag()
   {
      super();
   }
}
