package UI.vip
{
   import data.StringToDefine;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import gameAll.api.ShopBuyObject;
   import gameAll.data.GoodsItemsData;
   import gameAll.vip.OneVipDefine;
   import gameAll.vip.VipData;
   import goods.GoodsDefine;
   
   public class VipUI extends Sprite
   {
      
      public var vipData:VipData;
      
      public var good_arr0:Array = ["vipCard_11","vipCard_12","vipCard_13","vipCard_14"];
      
      public var unlockText_arr:Array = ["普通2-7 全军覆没","普通4-9 决战月都","普通5-7 浴血奋战","普通7-10 重归暗影"];
      
      public var vipName_txt:TextField;
      
      public var time_txt:TextField;
      
      public var back_mc:MovieClip;
      
      public var bar_arr:Array = [];
      
      public var good_arr:Array = [];
      
      public var showNowB:Boolean = false;
      
      private var nowGoodsDefine:GoodsDefine = null;
      
      private var show_t:int = 0;
      
      public function VipUI()
      {
         super();
         this.vipData = Game.gameData.vipData;
         this.back_mc.stop();
         this.back_mc.mouseChildren = false;
         this.back_mc.mouseEnabled = false;
         this.addBar6();
         this.addGoods4();
      }
      
      private function addBar6() : *
      {
         var bar0:VipGiftBar = null;
         var i:int = 0;
         while(i < 6)
         {
            bar0 = new VipGiftBar();
            this.bar_arr.push(bar0);
            addChild(bar0);
            bar0.x = 307 + (515 - 307) * (i % 3);
            bar0.y = 175 + (322 - 175) * (int(i / 3));
            bar0.index = i;
            bar0._btn.addEventListener(MouseEvent.CLICK,this.barClick);
            i++;
         }
      }
      
      private function addGoods4() : *
      {
         var bar0:VipGoodBar = null;
         var d0:GoodsDefine = null;
         var i:int = 0;
         while(i < this.good_arr0.length)
         {
            bar0 = new VipGoodBar();
            this.good_arr.push(bar0);
            addChildAt(bar0,this.getChildIndex(this.back_mc) - 1);
            bar0.x = 34;
            bar0.y = 55 + (147 - 55) * i;
            bar0.index = i;
            d0 = Game.goodsDefineGroup.getItemsDefine_byID(this.good_arr0[i],"props");
            bar0.name_txt.text = d0.name;
            bar0.price_txt.text = this.unlockText_arr[i];
            bar0.define = d0;
            bar0.icon_con.addChild(Game.swfLoaderManager.getResource("",d0.imgLabel));
            bar0._btn.addEventListener(MouseEvent.CLICK,this.goodsClick);
            bar0.mouse_mc.addEventListener(MouseEvent.MOUSE_OVER,this.goodsOver);
            bar0.mouse_mc.addEventListener(MouseEvent.MOUSE_OUT,this.goodsOut);
            i++;
         }
      }
      
      public function fleshData() : *
      {
         this.vipData.fleshCDay();
         this.showByName(this.vipData.nowVip);
         this.showNowB = true;
         this.fleshPrice();
         var d0:OneVipDefine = this.vipData.getNowDefine();
         if(Boolean(d0))
         {
            this.vipName_txt.text = d0.honor;
            if(d0.name == "vipCard_0")
            {
               this.time_txt.text = int(this.vipData.experienceTime) + "秒";
            }
            else if(this.vipData.cDay >= 5000)
            {
               this.time_txt.text = "终生有效";
            }
            else
            {
               this.time_txt.text = "终生有效";
            }
            return;
         }
         this.vipName_txt.text = "无";
         this.time_txt.text = "无";
      }
      
      public function fleshPrice() : *
      {
         var n:* = undefined;
         var bar0:VipGoodBar = null;
         var rank:int = 0;
         var nowVip:String = this.vipData.nowVip;
         if(nowVip != null && nowVip.indexOf("vipCard_1") == 0)
         {
            rank = int(nowVip.substr(8)) - 10;
         }
         for(n in this.good_arr)
         {
            bar0 = this.good_arr[n];
            if(int(n) < rank)
            {
               bar0._btn.visible = false;
               bar0.price_txt.text = "已解锁（永久）";
            }
            else
            {
               bar0._btn.visible = true;
               bar0.price_txt.text = this.unlockText_arr[int(n)];
            }
         }
      }
      
      private function goodsClick(e:*) : *
      {
         var index0:int = int(e.target.parent.index);
         var rank:int = 0;
         var nowVip:String = this.vipData.nowVip;
         if(nowVip != null && nowVip.indexOf("vipCard_1") == 0)
         {
            rank = int(nowVip.substr(8)) - 10;
         }
         if(index0 < rank)
         {
            return;
         }
         Game.uiGroup.checkTip.showCheck2("VIP不能购买。解锁条件：" + this.unlockText_arr[index0],2,null,null,2);
      }
      
      private function yes_goodsClick() : *
      {
         var obj0:ShopBuyObject = null;
         if(Boolean(this.nowGoodsDefine))
         {
            obj0 = new ShopBuyObject();
            obj0.count = 1;
            obj0.price = this.nowGoodsDefine.Mprice;
            obj0.propId = this.nowGoodsDefine.propId;
            obj0.tag = this.nowGoodsDefine.name;
            Game.shop_api.buyPropNd(obj0,this.affter_yes_goodsClick);
         }
      }
      
      private function affter_yes_goodsClick() : *
      {
         Game.uiGroup.addGift_byArr([this.nowGoodsDefine],false,-1,false);
         Game.uiGroup.checkTip.showTip("购买成功！",1);
         Game.SG.playSound("upgradeArms");
         var gd:GoodsItemsData = Game.gameData.propsItems.getItemsByName(this.nowGoodsDefine.id);
         Game.IC.useItems(gd,Game.gameData.propsItems);
      }
      
      private function goodsOver(e:*) : *
      {
         var index0:int = 0;
         this.back_mc.visible = true;
         if(this.show_t >= 2)
         {
            index0 = int(e.target.parent.index);
            this.back_mc.gotoAndStop(index0 + 2);
            this.showByName(this.good_arr0[index0],true);
            this.showNowB = false;
         }
      }
      
      private function goodsOut(e:*) : *
      {
         if(this.show_t >= 2)
         {
            this.back_mc.gotoAndStop(1);
            this.showByName(this.vipData.nowVip);
            this.showNowB = true;
         }
      }
      
      private function showByName(name0:String, hideBtnB:Boolean = false) : *
      {
         var n:* = undefined;
         var d0:OneVipDefine = null;
         var num0:int = 0;
         var txt0:String = null;
         var bar0:VipGiftBar = null;
         for(n in this.bar_arr)
         {
            this.bar_arr[n].no_btn.visible = !hideBtnB;
            this.bar_arr[n]._btn.visible = !hideBtnB;
            this.bar_arr[n].btn_txt.visible = !hideBtnB;
            this.bar_arr[n].visible = false;
         }
         this.back_mc.visible = true;
         d0 = Game.gameDefine.vip.getDefine(name0);
         if(Boolean(d0))
         {
            this.back_mc.visible = false;
            num0 = 0;
            txt0 = "";
            bar0 = this.bar_arr[num0];
            bar0.name_txt.text = "Vip专属地图";
            bar0.btn_txt.text = "进入";
            this.vipData.refreshMapAccess();
            if(this.vipData.getMapCooldownRemaining() > 0)
            {
               bar0.setUseBtn(false);
               txt0 = "退出后冷却中：\n" + StringToDefine.getFontColor(StringToDefine.getTimeStr(this.vipData.getMapCooldownRemaining()),"#FFFF00");
            }
            else if(this.vipData.mapTime > 0)
            {
               bar0.setUseBtn(true);
               txt0 = "剩余时间：\n" + StringToDefine.getFontColor(StringToDefine.getTimeStr(this.vipData.mapTime),"#FFFF00");
               txt0 += "\n退出后冷却：" + int(this.vipData.getMapCooldown() / 60) + "分钟";
            }
            else
            {
               bar0.setUseBtn(false);
               txt0 = "\n地图暂不可进入";
            }
            bar0.content_txt.htmlText = txt0;
            bar0.visible = true;
            num0++;
            bar0 = this.bar_arr[num0];
            bar0.name_txt.text = "VIP称号";
            txt0 = "\n" + StringToDefine.getFontColor(d0.honor,"#FF54C4");
            bar0.content_txt.htmlText = txt0;
            bar0.visible = true;
            bar0.hideBtn();
            num0++;
            bar0 = this.bar_arr[num0];
            bar0.name_txt.text = "VIP礼包（3小时）";
            txt0 = Game.goodsDefineGroup.switchStrArr_toStr(d0.giftArr,true);
            txt0 = txt0.replace("\n","");
            if(this.vipData.getGiftCooldownRemaining() > 0)
            {
               txt0 += "\n冷却剩余：" + StringToDefine.getTimeStr(this.vipData.getGiftCooldownRemaining());
            }
            else
            {
               txt0 += "\n当前可以领取";
            }
            bar0.content_txt.text = txt0;
            bar0.visible = true;
            if(!hideBtnB)
            {
               bar0.setUseBtn(this.vipData.canGetVipGift());
            }
            num0++;
            bar0 = this.bar_arr[num0];
            bar0.name_txt.text = "VIP永久专属BUFF";
            txt0 = "全能训练增加" + d0.all_pro * 100 + "%" + "\n永久生效，无需领取";
            bar0.content_txt.text = txt0;
            bar0.visible = true;
            bar0.hideBtn();
            this.FTimer();
            num0++;
            bar0 = this.bar_arr[num0];
            bar0.name_txt.text = "附加属性";
            txt0 = "打怪获得经验值提高" + d0.expAdd * 100 + "%";
            txt0 += "\n打怪获得功勋值提高" + d0.achieveAdd * 100 + "%";
            bar0.content_txt.text = txt0;
            bar0.hideBtn();
            bar0.visible = true;
            num0++;
            bar0 = this.bar_arr[num0];
            bar0.name_txt.text = "特权";
            txt0 = "普通商城额外9折\n通关可多一次翻牌\n享用战斗托管功能";
            bar0.content_txt.text = txt0;
            bar0.hideBtn();
            bar0.visible = true;
         }
      }
      
      public function FTimer() : *
      {
         var d0:OneVipDefine = null;
         var bar0:* = undefined;
         var txt0:String = null;
         var tt0:Number = Number(NaN);
         if(this.showNowB)
         {
            d0 = this.vipData.getNowDefine();
            if(Boolean(d0))
            {
               this.vipData.refreshMapAccess();
               bar0 = this.bar_arr[0];
               if(this.vipData.getMapCooldownRemaining() > 0)
               {
                  bar0.setUseBtn(false);
                  bar0.content_txt.htmlText = "退出后冷却中：\n" + StringToDefine.getFontColor(StringToDefine.getTimeStr(this.vipData.getMapCooldownRemaining()),"#FFFF00");
               }
                else if(this.vipData.mapTime > 0)
                {
                   bar0.setUseBtn(true);
                   bar0.content_txt.htmlText = "剩余时间：\n" + StringToDefine.getFontColor(StringToDefine.getTimeStr(this.vipData.mapTime),"#FFFF00") + "\n退出后冷却：" + int(this.vipData.getMapCooldown() / 60) + "分钟";
                }
                else
                {
                   bar0.setUseBtn(false);
                   bar0.content_txt.text = "地图暂不可进入";
                }
               bar0 = this.bar_arr[2];
               txt0 = Game.goodsDefineGroup.switchStrArr_toStr(d0.giftArr,true).replace("\n","");
               tt0 = this.vipData.getGiftCooldownRemaining();
               if(tt0 > 0)
               {
                  bar0.setUseBtn(false);
                  txt0 += "\n冷却剩余：" + StringToDefine.getTimeStr(tt0);
               }
               else
               {
                  bar0.setUseBtn(true);
                  txt0 += "\n当前可以领取";
               }
               bar0.content_txt.text = txt0;
               bar0 = this.bar_arr[3];
               bar0.name_txt.text = "VIP永久专属BUFF";
               bar0.content_txt.text = "全能训练增加" + d0.all_pro * 100 + "%" + "\n永久生效，无需领取";
               bar0.hideBtn();
               if(d0.name == "vipCard_0")
               {
                  this.time_txt.text = StringToDefine.getTimeStr(int(this.vipData.experienceTime));
               }
            }
         }
         if(this.visible)
         {
            ++this.show_t;
            if(this.show_t > 100)
            {
               this.show_t = 100;
            }
         }
         else
         {
            this.show_t = 0;
         }
      }
      
      public function barClick(e:*) : *
      {
         var arr1:Array = null;
         var index0:int = int(e.target.parent.index);
         var d0:OneVipDefine = this.vipData.getNowDefine();
         if(Boolean(d0))
         {
            if(index0 == 0)
            {
               if(this.vipData.canEnterMap())
               {
                  Game.eventGroup.chosenLevel(999);
               }
               else
               {
                  Game.uiGroup.checkTip.showTip("VIP地图正在冷却中。",2);
               }
            }
            else if(index0 == 2)
            {
               if(this.vipData.canGetVipGift())
               {
                  arr1 = Game.goodsDefineGroup.getArr_byStrArr(d0.giftArr,1);
                  Game.uiGroup.addGift_byArr(arr1,true);
                  this.vipData.startGiftCooldown();
                  Game.uiGroup.saveDataNoUI();
               }
               else
               {
                  Game.uiGroup.checkTip.showTip("VIP礼包正在冷却中。",2);
               }
            }
            else if(index0 == 3)
            {
               Game.uiGroup.checkTip.showTip("VIP专属BUFF已经永久生效。",1);
            }
            this.fleshData();
         }
      }
   }
}

