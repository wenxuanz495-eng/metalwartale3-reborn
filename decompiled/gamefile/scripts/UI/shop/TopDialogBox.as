package UI.shop
{
   import UI.button.PicButton;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.StaticText;
   import goods.GoodsDefine;
   import gs.TweenLite;
   import gs.easing.Back;
   
   public class TopDialogBox extends Sprite
   {
      
      private static const MAX_BUY_NUM:int = 9999999;
      
      public var back:Sprite;
      
      public var mc:*;
      
      public var txt:TextField;
      
      public var yes_btn:PicButton;
      
      public var no_btn:PicButton;
      
      public var m50_btn:PicButton;
      
      public var icon:MovieClip;
      
      public var btnState:int = 0;
      
      public var iconState:int = 0;
      
      public var yesFun:Function = null;
      
      public var noFun:Function = null;
      
      public var m50fun:Function = null;
      
      public var hideDelay:Number = -1;
      
      public var input_txt:TextField;
      
      public var txtBack_mc:Sprite;

      private var inputPanelBack:Sprite = new Sprite();

      private var inputDefaultY:Number = 0;

      private var inputBackDefaultY:Number = 0;
      
      public var shop_mc:*;
      
      public var goodsDefine:GoodsDefine = null;
      
      public var buyDefine:GoodsDefine = new GoodsDefine();
      
      public var bagNum:int = 0;
      
      public var numberRepeatB:Boolean = false;
      
      public var barterMode:Boolean = false;
      
      public var barterMax:int = 0;
      
      public var barterSourceName:String = "";
      
      public var barterTargetName:String = "";
      
      public function TopDialogBox()
      {
         super();
         this.shop_mc = this.mc.shop_mc;
         this.txt = this.mc.txt;
         this.txt.multiline = true;
         this.yes_btn = this.mc.yes_btn;
         this.yes_btn.noLabelB = true;
         this.no_btn = this.mc.no_btn;
         this.m50_btn = this.mc.m50_btn;
         this.icon = this.mc.icon;
         this.input_txt = this.mc.input_txt;
         this.txtBack_mc = this.mc.txtBack_mc;
         this.inputDefaultY = this.input_txt.y;
         this.inputBackDefaultY = this.txtBack_mc.y;
         this.inputPanelBack.graphics.beginFill(0,0.96);
         this.inputPanelBack.graphics.drawRect(-450,-180,900,360);
         this.inputPanelBack.graphics.endFill();
         this.mc.addChildAt(this.inputPanelBack,0);
         this.inputPanelBack.visible = false;
         this.hideConsumptionSlogan(this.mc);
         this.txt.autoSize = "left";
         this.txt.wordWrap = false;
         this.yes_btn.setText("yes");
         this.yes_btn.addEventListener(MouseEvent.CLICK,this.click1);
         this.no_btn.addEventListener(MouseEvent.CLICK,this.click2);
         this.m50_btn.addEventListener(MouseEvent.CLICK,this.click3);
         this.no_btn.setText("no");
         this.icon.stop();
         this.input_txt.visible = false;
         this.txtBack_mc.visible = false;
         this.shop_mc.prev_btn.addEventListener(MouseEvent.CLICK,this.prevClick);
         this.shop_mc.next_btn.addEventListener(MouseEvent.CLICK,this.nextClick);
         this.shop_mc.num_txt.addEventListener(Event.CHANGE,this.priceTxtChange);
         this.shop_mc.num_txt.maxChars = 7;
         this.shop_mc.num_txt.restrict = "0-9";
      }

      private function hideConsumptionSlogan(container0:DisplayObjectContainer) : void
      {
         var child0:DisplayObject = null;
         var text0:String = null;
         for(var i:int = container0.numChildren - 1; i >= 0; i--)
         {
            child0 = container0.getChildAt(i);
            if(child0 is StaticText)
            {
               text0 = StaticText(child0).text;
            }
            else if(child0 is TextField)
            {
               text0 = TextField(child0).text;
            }
            else
            {
               text0 = null;
            }
            if(text0 != null && (text0.indexOf("适当娱乐") >= 0 || text0.indexOf("理性消费") >= 0))
            {
               child0.visible = false;
            }
            else if(child0 is DisplayObjectContainer)
            {
               this.hideConsumptionSlogan(DisplayObjectContainer(child0));
            }
         }
      }
      
      public function showReSignCheck(buyCount:int, _yesFun:Function = null, numB:Boolean = true, _bagNum:int = 1, _repeatB:Boolean = true) : *
      {
         var goodsDefine0:GoodsDefine = new GoodsDefine();
         goodsDefine0.name = "签到";
         goodsDefine0.priceType = "Mprice";
         goodsDefine0.Mprice = 10;
         goodsDefine0.Maxbuy = buyCount;
         this.showCheck("");
         this.yesFun = _yesFun;
         this.bagNum = _bagNum;
         this.numberRepeatB = _repeatB;
         this.goodsDefine = goodsDefine0;
         this.shop_mc.num_txt.text = this.goodsDefine.baseNum + "";
         this.txt.visible = false;
         this.shop_mc.visible = true;
         this.shop_mc.title_txt.htmlText = "你要使用M币补签天数吗？";
         this.fleshPrice();
         if(numB)
         {
            this.shop_mc.numCnTxt.x = -142;
            this.shop_mc.price_txt.x = 12;
            this.shop_mc.price_txt.width = 188;
            this.shop_mc.price_txt.autoSize = TextFieldAutoSize.LEFT;
            this.shop_mc.numCnTxt.visible = true;
            this.shop_mc.num_txt.visible = true;
            this.shop_mc.numBack_mc.visible = true;
            this.shop_mc.prev_btn.visible = true;
            this.shop_mc.next_btn.visible = true;
            this.shop_mc.num_txt.type = "input";
            this.txt.selectable = true;
         }
         else
         {
            this.shop_mc.price_txt.autoSize = TextFieldAutoSize.CENTER;
            this.shop_mc.price_txt.x = -201;
            this.shop_mc.price_txt.width = 402;
            this.shop_mc.numCnTxt.visible = false;
            this.shop_mc.num_txt.visible = false;
            this.shop_mc.numBack_mc.visible = false;
            this.shop_mc.prev_btn.visible = false;
            this.shop_mc.next_btn.visible = false;
            this.shop_mc.num_txt.type = "dynamic";
            this.txt.selectable = false;
         }
      }
      
      public function showShopCheck(goodsDefine0:GoodsDefine, _yesFun:Function = null, numB:Boolean = true, _bagNum:int = 1, _repeatB:Boolean = true) : *
      {
         trace("goodsDefine0.baseNum：" + goodsDefine0.baseNum);
         this.showCheck("");
         this.yesFun = _yesFun;
         this.bagNum = _bagNum;
         this.numberRepeatB = _repeatB;
         this.goodsDefine = goodsDefine0;
         this.shop_mc.num_txt.text = this.goodsDefine.baseNum + "";
         this.txt.visible = false;
         this.shop_mc.visible = true;
         this.shop_mc.title_txt.htmlText = "你要购买 <font color=\'#FFFF00\'>" + goodsDefine0.name + "</font> 吗？";
         this.fleshPrice();
         if(numB)
         {
            this.shop_mc.numCnTxt.x = -142;
            this.shop_mc.price_txt.x = 12;
            this.shop_mc.price_txt.width = 188;
            this.shop_mc.price_txt.autoSize = TextFieldAutoSize.LEFT;
            this.shop_mc.numCnTxt.visible = true;
            this.shop_mc.num_txt.visible = true;
            this.shop_mc.numBack_mc.visible = true;
            this.shop_mc.prev_btn.visible = true;
            this.shop_mc.next_btn.visible = true;
            this.shop_mc.num_txt.type = "input";
            this.txt.selectable = true;
         }
         else
         {
            this.shop_mc.price_txt.autoSize = TextFieldAutoSize.CENTER;
            this.shop_mc.price_txt.x = -201;
            this.shop_mc.price_txt.width = 402;
            this.shop_mc.numCnTxt.visible = false;
            this.shop_mc.num_txt.visible = false;
            this.shop_mc.numBack_mc.visible = false;
            this.shop_mc.prev_btn.visible = false;
            this.shop_mc.next_btn.visible = false;
            this.shop_mc.num_txt.type = "dynamic";
            this.txt.selectable = false;
         }
      }
      
      public function showBarterCheck(sourceName:String, targetName:String, maxNum:int, _yesFun:Function = null) : *
      {
         this.showCheck("");
         this.barterMode = true;
         this.barterMax = maxNum;
         this.barterSourceName = sourceName;
         this.barterTargetName = targetName;
         this.yesFun = _yesFun;
         this.buyDefine = new GoodsDefine();
         this.buyDefine.baseNum = 1;
         this.buyDefine.num = 1;
         this.shop_mc.num_txt.text = "1";
         this.txt.visible = false;
         this.shop_mc.visible = true;
         this.shop_mc.title_txt.htmlText = "你要将 <font color=\'#FFFF00\'>" + sourceName + "</font> 兑换为 <font color=\'#FFFF00\'>" + targetName + "</font> 吗？";
         this.shop_mc.numCnTxt.x = -142;
         this.shop_mc.price_txt.x = 12;
         this.shop_mc.price_txt.width = 188;
         this.shop_mc.price_txt.autoSize = TextFieldAutoSize.LEFT;
         this.shop_mc.numCnTxt.visible = true;
         this.shop_mc.num_txt.visible = true;
         this.shop_mc.numBack_mc.visible = true;
         this.shop_mc.prev_btn.visible = true;
         this.shop_mc.next_btn.visible = true;
         this.shop_mc.num_txt.type = "input";
         this.fleshPrice();
      }
      
      public function show50M_unlock(fun0:Function) : *
      {
         this.m50_btn.setText("m50");
         this.yes_btn.y = 28;
         this.no_btn.y = 28;
         this.m50_btn.visible = true;
         this.m50fun = fun0;
      }
      
      public function fleshPrice() : *
      {
         if(this.barterMode)
         {
            this.fleshBuyNum();
            if(this.buyNum > this.barterMax)
            {
               this.buyNum = this.barterMax;
            }
            this.yes_btn.actived = this.buyNum >= 1 && this.buyNum <= this.barterMax;
            this.shop_mc.price_txt.htmlText = "需要：<font color=\'#FFFF00\'>" + this.buyNum + "</font> 个" + this.barterSourceName;
            this.shop_mc.bag_txt.htmlText = "当前可兑换：<font color=\'#00FF00\'>" + this.barterMax + "</font> 个　兑换后获得：<font color=\'#FFFF00\'>" + this.buyNum + "</font> 个" + this.barterTargetName;
            return;
         }
         this.fleshBuyNum();
         this.buyDefine.init();
         this.buyDefine.fleshPrice_inData(this.goodsDefine);
         trace("buyDefine.baseNum：" + this.buyDefine.baseNum);
         var nowDefine0:GoodsDefine = Game.gameData.getNowGoodsDefine();
         var buyB0:Boolean = this.buyDefine.getBuyB(nowDefine0);
         this.yes_btn.actived = buyB0;
         this.shop_mc.price_txt.htmlText = "需要：" + this.buyDefine.getMustText(nowDefine0);
         trace("shop_mc.price_txt：" + this.shop_mc.price_txt.text);
         var bagName0:String = "目标背包";
         if(this.goodsDefine.type == "car")
         {
            bagName0 = "车库";
         }
         else if(this.goodsDefine.type == "sub" || this.goodsDefine.type == "arms")
         {
            bagName0 = "目标武器库";
         }
         var text2:String = bagName0 + "还有空位：<font color=\'#FFFF00\'>" + this.bagNum + "</font> " + "个";
         if(this.buyDefine.name == "签到")
         {
            text2 = "可补签次数：<font color=\'#FFFF00\'>" + this.buyDefine.Maxbuy + "</font> " + "次";
         }
         if(this.numberRepeatB)
         {
            if(this.bagNum < 1)
            {
               text2 += "<font color=\'#FF0000\'>（不足）</font> ";
               this.yes_btn.actived = false;
            }
         }
         else if(this.buyNum > this.bagNum)
         {
            text2 += "<font color=\'#FF0000\'>（不足）</font> ";
            this.yes_btn.actived = false;
         }
         this.shop_mc.bag_txt.htmlText = text2;
      }
      
      public function prevClick(e:*) : *
      {
         this.buyNum -= this.buyDefine.baseNum;
         this.fleshBuyNum();
         this.fleshPrice();
      }
      
      public function nextClick(e:*) : *
      {
         this.buyNum += this.buyDefine.baseNum;
         this.fleshBuyNum();
         this.fleshPrice();
      }
      
      public function priceTxtChange(e:*) : *
      {
         this.fleshPrice();
      }
      
      private function fleshBuyNum() : *
      {
         this.buyNum = int(this.shop_mc.num_txt.text);
         if(this.buyNum <= this.buyDefine.baseNum)
         {
            this.buyNum = this.buyDefine.baseNum;
         }
         if(this.shop_mc.num_txt.text == "")
         {
            this.buyNum = this.buyDefine.baseNum;
         }
         else
         {
            this.shop_mc.num_txt.text = String(this.buyNum);
         }
      }
      
      private function set buyNum(num0:int) : *
      {
         if(num0 > MAX_BUY_NUM)
         {
            num0 = MAX_BUY_NUM;
         }
         if(num0 <= 0)
         {
            this.buyDefine.num = 0;
         }
         else
         {
            this.buyDefine.num = int(num0 / this.buyDefine.baseNum) * this.buyDefine.baseNum;
         }
         if(this.buyDefine.name == "签到" && num0 > this.buyDefine.Maxbuy)
         {
            this.buyDefine.num = this.buyDefine.Maxbuy;
         }
         this.shop_mc.num_txt.text = String(this.buyDefine.num);
      }
      
      private function get buyNum() : int
      {
         return this.buyDefine.num;
      }
      
      public function showTip(str:String, _icon:int) : *
      {
         this.show(str,1,_icon);
      }
      
      public function showCheck(str:String, fun1:Function = null, fun2:Function = null, _icon:int = 0) : *
      {
         this.show(str,-1,_icon,1,fun1,fun2);
         Game.SG.playSound("topDialogBox_show");
      }
      
      public function showCheck2(str:String, _btn:int = 0, fun1:Function = null, fun2:Function = null, _icon:int = 0) : *
      {
         this.show(str,-1,_icon,_btn,fun1,fun2);
         Game.SG.playSound("topDialogBox_show");
      }
      
      public function show(str:String, _hideDelay:Number = -1, _icon:int = 0, _btn:int = 0, fun1:Function = null, fun2:Function = null) : *
      {
         this.barterMode = false;
         this.yes_btn.actived = true;
         this.txt.visible = true;
         this.shop_mc.visible = false;
         this.iconState = _icon;
         this.btnState = _btn;
         this.yesFun = fun1;
         this.noFun = fun2;
         this.txt.htmlText = str;
         this.visible = true;
         this.mc.alpha = 1;
         this.mc.visible = true;
         this.visible = true;
         this.alpha = 1;
         this.fleshPosition();
         if(_hideDelay != -1)
         {
            this.hideDelay = _hideDelay;
            this.mc.scaleX = 1;
            this.mc.scaleY = 1;
            this.back.visible = false;
            this.hide2();
         }
         else
         {
            this.mc.scaleX = 0.7;
            this.mc.scaleY = 0.7;
            this.back.visible = true;
            TweenLite.to(this.mc,0.3,{
               "scaleX":1,
               "scaleY":1,
               "ease":Back.easeOut
            });
         }
         this.input_txt.visible = false;
         this.txtBack_mc.visible = false;
         this.inputPanelBack.visible = false;
         this.input_txt.y = this.inputDefaultY;
         this.txtBack_mc.y = this.inputBackDefaultY;
         this.yes_btn.y = 45;
         this.no_btn.y = 45;
         this.m50_btn.visible = false;
      }
      
      public function getSelectedNum() : int
      {
         return this.buyNum;
      }
      
      public function showInputText(str:String, inputStr:String, fun1:Function = null, fun2:Function = null) : *
      {
         this.show(str,-1,0,1,fun1,fun2);
         this.inputPanelBack.visible = true;
         this.txt.y = -60;
         this.input_txt.y = this.inputDefaultY + 35;
         this.txtBack_mc.y = this.inputBackDefaultY + 35;
         this.yes_btn.y = 105;
         this.no_btn.y = 105;
         this.input_txt.restrict = null;
         this.input_txt.maxChars = 0;
         this.input_txt.text = inputStr;
         this.input_txt.visible = true;
         this.txtBack_mc.visible = true;
         if(this.input_txt.parent != null)
         {
            this.input_txt.parent.setChildIndex(this.input_txt,this.input_txt.parent.numChildren - 1);
         }
      }
      
      public function showNumberInput(str:String, inputStr:String, fun1:Function = null, fun2:Function = null, maxChars0:int = 8) : *
      {
         this.showInputText(str,inputStr,fun1,fun2);
         this.input_txt.restrict = "0-9";
         this.input_txt.maxChars = maxChars0;
      }
      
      public function hide() : *
      {
         this.back.visible = false;
         TweenLite.to(this.mc,0.2,{
            "scaleX":0.7,
            "scaleY":0.7,
            "autoAlpha":0,
            "ease":Back.easeIn
         });
         trace("隐藏————————————————————");
      }
      
      public function hide2() : *
      {
         this.back.visible = false;
         TweenLite.to(this.mc,0.5,{
            "autoAlpha":0,
            "delay":this.hideDelay
         });
      }
      
      public function fleshPosition() : *
      {
         this.yes_btn.setText("yes");
         this.yes_btn.setBack("orange1");
         var y0:int = -15;
         if(this.btnState == 0)
         {
            y0 = 0;
            this.yes_btn.visible = false;
            this.no_btn.visible = false;
         }
         else if(this.btnState == 1)
         {
            this.yes_btn.x = -88;
            this.no_btn.x = 88;
            this.yes_btn.visible = true;
            this.no_btn.visible = true;
         }
         else if(this.btnState == 2)
         {
            this.yes_btn.x = 0;
            this.yes_btn.visible = true;
            this.no_btn.visible = false;
         }
         else if(this.btnState == 3)
         {
            this.no_btn.x = 0;
            this.yes_btn.visible = false;
            this.no_btn.visible = true;
         }
         else if(this.btnState == 4)
         {
            this.yes_btn.x = -88;
            this.no_btn.x = 88;
            this.yes_btn.visible = true;
            this.no_btn.visible = true;
            this.yes_btn.setText("pay");
            this.yes_btn.setBack("blue1");
         }
         else if(this.btnState == 5)
         {
            this.yes_btn.x = -88;
            this.no_btn.x = 88;
            this.yes_btn.visible = true;
            this.no_btn.visible = true;
            this.yes_btn.setText("gotoShop2");
         }
         if(this.iconState == 0)
         {
            this.txt.y = y0 - this.txt.height / 2;
            this.icon.visible = false;
            this.txt.x = -this.txt.width / 2;
         }
         else
         {
            this.txt.y = y0 - this.txt.height / 2;
            this.icon.y = y0;
            this.icon.x = -(this.txt.width + 10 + this.icon.width) / 2 + this.icon.width / 2 - 20;
            this.txt.x = this.icon.x + this.icon.width / 2 + 10;
            this.icon.visible = true;
            this.icon.gotoAndStop(this.iconState);
         }
      }
      
      public function click1(event:MouseEvent) : *
      {
         this.hide();
         if(this.yesFun is Function)
         {
            this.yesFun();
         }
         if(this.yes_btn.text == "pay")
         {
            Game.uiGroup.pay();
         }
      }
      
      public function click2(event:MouseEvent) : *
      {
         this.hide();
         if(this.noFun is Function)
         {
            this.noFun();
         }
      }
      
      public function click3(event:MouseEvent) : *
      {
         this.hide();
         if(this.m50fun is Function)
         {
            this.m50fun();
         }
      }
   }
}

