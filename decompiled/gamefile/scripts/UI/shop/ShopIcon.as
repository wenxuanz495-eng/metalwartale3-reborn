package UI.shop
{
   import UI.ClickEvent;
   import body.hurt.HurtCount;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import goods.GoodsDefine;
   
   public class ShopIcon extends Sprite
   {
      
      public var edata:Object = null;
      
      private var _actived:Boolean = true;
      
      public var back:MovieClip;
      
      public var icon:Sprite;
      
      public var money_icon:MovieClip;
      
      public var money_icon2:MovieClip;
      
      public var money_icon_arr:Array = [];
      
      public var label:String = "normal";
      
      public var name_txt:TextField;
      
      public var text:String = "";
      
      public var price_txt:TextField;
      
      public var price_txt2:TextField;
      
      public var price_txt_arr:Array = [];
      
      public var num_txt:TextField;
      
      public var buy_btn:ShopBuyButton;
      
      public var buy_btn2:*;
      
      public var lock_mc:MovieClip;
      
      public var icon_mc:MovieClip;
      
      public var index:int = 0;
      
      public var state:String = "";
      
      public var itemsData:GoodsDefine = null;
      
      public var type_mc:MovieClip;
      
      public function ShopIcon()
      {
         super();
         this.init();
      }
      
      public function init() : *
      {
         this.type_mc.stop();
         this.type_mc.visible = false;
         this.money_icon_arr = [this.money_icon,this.money_icon2];
         this.price_txt_arr = [this.price_txt,this.price_txt2];
         this.buy_btn2.mouseEnabled = false;
         this.buy_btn2.mouseChildren = false;
         this.back.stop();
         this.money_icon.stop();
         this.money_icon2.stop();
         this.money_icon2.visible = false;
         this.price_txt2.visible = false;
         this.lock_mc.visible = false;
         this.lock_mc.stop();
         this.mouseEnabled = true;
         this.addEventListener(MouseEvent.MOUSE_OVER,this.MOver);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.MOut);
         this.buy_btn.addEventListener(MouseEvent.CLICK,this.MClick);
         this.num_txt.visible = false;
         this.buy_btn2.visible = false;
      }
      
      public function setState(_state:String) : *
      {
         this.state = _state;
         if(this.state == "fill")
         {
            this.buy_btn.visible = true;
            this.buy_btn2.visible = false;
         }
         else if(this.state == "noMoney")
         {
            this.buy_btn.visible = false;
            this.buy_btn2.visible = true;
         }
         else if(this.state == "lock")
         {
            this.buy_btn.visible = false;
         }
      }
      
      public function setSpecialState(str0:String) : *
      {
         if(str0 != "")
         {
            this.lock_mc.gotoAndStop(str0);
            this.lock_mc.visible = true;
         }
         else
         {
            this.lock_mc.visible = false;
         }
      }
      
      public function setNum(num:int) : *
      {
         if(num > 1)
         {
            this.num_txt.visible = true;
            this.icon.x = 74;
         }
         else
         {
            this.num_txt.visible = false;
            this.icon.x = 84;
         }
         this.num_txt.text = "x" + num;
      }
      
      public function setBack(num:*) : *
      {
         this.back.gotoAndStop(num);
      }
      
      public function clearData() : *
      {
         this.itemsData = null;
         if(this.icon_mc != null)
         {
            this.icon.removeChild(this.icon_mc);
            this.icon_mc = null;
         }
         this.setState("blank");
      }
      
      public function clear() : *
      {
         this.clearData();
         this.buy_btn.clear();
         this.removeEventListener(MouseEvent.MOUSE_OVER,this.MOver);
         this.removeEventListener(MouseEvent.MOUSE_OUT,this.MOut);
         this.removeEventListener(MouseEvent.CLICK,this.MClick);
      }
      
      public function setIcon(mc0:MovieClip) : *
      {
         var rect0:Rectangle = null;
         if(this.icon_mc != null)
         {
            this.icon.removeChild(this.icon_mc);
            this.icon_mc = null;
         }
         this.icon_mc = mc0;
         mc0.stop();
         this.icon.addChild(mc0);
         var mc1:* = mc0.getChildByName("shootPoint");
         var mc2:* = mc0.getChildByName("basePoint");
         if(mc1 is MovieClip)
         {
            mc0.removeChild(mc1);
            mc0.removeChild(mc2);
         }
         rect0 = mc0.getRect(mc0);
         mc0.x = -rect0.x - rect0.width / 2;
         mc0.y = -rect0.y - rect0.height / 2;
      }
      
      public function setText(str:String) : *
      {
         this.text = str;
         this.name_txt.text = str;
      }
      
      public function setPrice(value:*, color0:String = "#FFFF00") : *
      {
         this.price_txt.htmlText = "<font color=\'" + color0 + "\'>" + value + "</font>";
      }
      
      public function iconLeave() : *
      {
         this.icon.visible = false;
      }
      
      public function iconReturn() : *
      {
         this.icon.visible = true;
      }
      
      public function inData_byDefine(d0:GoodsDefine) : *
      {
         var mc:MovieClip = null;
         var bit:Bitmap = null;
         this.itemsData = d0;
         var temp:* = Game.swfLoaderManager.getResource("",d0.imgLabel);
         if(!(temp is DisplayObject))
         {
            mc = new MovieClip();
            bit = new Bitmap(temp);
            mc.addChild(bit);
            bit.x = -bit.width / 2;
            bit.y = -bit.height / 2;
         }
         else
         {
            mc = temp;
         }
         var icon0:MovieClip = mc;
         this.setText(d0.name);
         this.setIcon(icon0);
         this.setState("fill");
         if(d0.id.indexOf("_pack") >= 0)
         {
            this.setNum(int(d0.id.split("_pack")[1]));
         }
         else
         {
            this.setNum(d0.num);
         }
         this.type_mc.visible = false;
         if(d0.type == "car")
         {
            this.type_mc.gotoAndStop(HurtCount.getDefenceLabel(d0.define.defenceType));
            this.type_mc.visible = true;
         }
         else if(d0.type == "arms" || d0.type == "sub")
         {
            this.type_mc.gotoAndStop(d0.define.attackType);
            this.type_mc.visible = true;
         }
      }
      
      public function fleshPrice_byNow(gd0:GoodsDefine) : *
      {
         var n:* = undefined;
         var name00:String = null;
         var p00:Number = NaN;
         var num00:int = 0;
         var spaceStr0:String = null;
         var i:int = 0;
         var buyDefine0:GoodsDefine = new GoodsDefine();
         buyDefine0.num = this.itemsData.num;
         buyDefine0.fleshPrice_inData(this.itemsData);
         var bb0:Boolean = buyDefine0.getBuyB(gd0);
         var typeArr0:Array = buyDefine0.getAllType();
         for(n in this.money_icon_arr)
         {
            if(typeArr0.length < n + 1)
            {
               this.money_icon_arr[n].visible = false;
               this.price_txt_arr[n].visible = false;
            }
            else
            {
               this.money_icon_arr[n].visible = true;
               this.price_txt_arr[n].visible = true;
               name00 = typeArr0[n];
               this.money_icon_arr[n].gotoAndStop(name00);
               this.price_txt_arr[n].text = this.swapToWan(buyDefine0[name00]);
               this.setBack(name00);
            }
         }
         if(bb0)
         {
            this.setState("fill");
            if(this.itemsData.getCoinB())
            {
               this.buy_btn.setText("购买");
            }
            else
            {
               this.buy_btn.setText("兑换");
            }
         }
         else
         {
            this.setState("noMoney");
            this.buy_btn2.txt.text = "条件不足";
         }
         var discount:Number = this.itemsData.discount;
         if(discount >= 0 && discount <= 1 && this.itemsData.id.indexOf("vipCard") == -1)
         {
            discount = 1 - (1 - discount) * Game.gameData.vipData.discount;
         }
         if(this.itemsData.priceType == "Mprice" && Math.ceil(this.itemsData.Mprice * Game.gameData.vipData.discount) == this.itemsData.priceLevel)
         {
            discount = 0;
         }
         if(discount > 0 && (this.itemsData.priceType == "Mprice" || this.itemsData.priceType == "price") && this.itemsData.specialType != "week")
         {
            p00 = Number(this.itemsData.getPriceArr()[0]);
            num00 = (4 - String(this.swapToWan(p00)).length) * 2 + 2;
            spaceStr0 = "";
            for(i = 0; i < num00; i++)
            {
               spaceStr0 += " ";
            }
            if(spaceStr0 == "")
            {
               spaceStr0 = " ";
            }
            if(this.itemsData.priceType == "Mprice")
            {
               this.price_txt.htmlText = this.price_txt.htmlText + spaceStr0 + "<font color=\'#FFFFFF\'>" + this.itemsData.priceLevel + "</font>";
            }
            else
            {
               this.price_txt.htmlText = this.price_txt.htmlText + spaceStr0 + "<font color=\'#FFFFFF\'>" + this.swapToWan(int(p00 / (1 - this.itemsData.discount))) + "</font>";
            }
         }
         var d0:* = this.itemsData;
         if(discount == -100 && d0.priceType == "Mprice")
         {
            this.setSpecialState("hot");
         }
         else if(discount > 0 && (d0.priceType == "Mprice" || d0.priceType == "price") && d0.specialType != "week")
         {
            this.setSpecialState("discount");
         }
         else if(d0.specialType == "week")
         {
            this.setSpecialState("week");
         }
         else
         {
            this.setSpecialState("");
         }
      }
      
      private function swapToWan(price0:int) : String
      {
         var str0:String = null;
         if(price0 >= 10000)
         {
            str0 = String(price0 / 10000);
            return str0 + "万";
         }
         return String(price0);
      }
      
      public function fleshPrice_byX(Xnum:int) : *
      {
         this.lock_mc.visible = false;
         this.setPrice(this.itemsData.Xprice,"#FFFFFF");
         this.money_icon.gotoAndStop(3);
         this.setBack(3);
         if(Xnum >= this.itemsData.Xprice)
         {
            this.setState("fill");
         }
         else
         {
            this.setState("noMoney");
            this.buy_btn2.txt.text = "超合金X不足";
         }
         this.buy_btn.setText("兑换");
      }
      
      public function set actived(bb:Boolean) : *
      {
         this._actived = bb;
         if(bb)
         {
            this.mouseEnabled = true;
         }
         else
         {
            this.mouseEnabled = false;
            this.gotoLabel("no");
         }
      }
      
      public function get actived() : Boolean
      {
         return this._actived;
      }
      
      public function gotoLabel(label0:String) : *
      {
         if(this.state != "lock" || label0 == "no")
         {
            this.back.gotoAndStop(label0);
            this.label = label0;
         }
      }
      
      protected function MOver(event:MouseEvent) : *
      {
         var downEvent:ClickEvent = null;
         if(event.target != this.buy_btn)
         {
            downEvent = new ClickEvent(ClickEvent.ON_OVER);
            this.dispatchEvent(downEvent);
         }
      }
      
      protected function MOut(event:MouseEvent) : *
      {
         var upEvent:ClickEvent = null;
         if(event.target != this.buy_btn)
         {
            upEvent = new ClickEvent(ClickEvent.ON_OUT);
            this.dispatchEvent(upEvent);
         }
      }
      
      protected function MClick(event:MouseEvent) : *
      {
         var downEvent:ClickEvent = new ClickEvent(ClickEvent.ON_CLICK);
         this.dispatchEvent(downEvent);
      }
   }
}

