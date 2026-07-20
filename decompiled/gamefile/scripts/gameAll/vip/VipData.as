package gameAll.vip
{
   import data.StringDate;
   import data.TextWay;
   import gameAll.data.AdditionalData;
   
   public class VipData
   {
      
      public var nowVip:String = "";
      
      public var durationTime:String = "";
      
      public var giftGetB:Boolean = false;
      
      public var giftReadyAt:Number = 0;
      
      public var buffGetB:Boolean = false;
      
      public var buffTime:Number = -100;
      
      private var _experienceTime:String = "";
      
      public var buffAdd:AdditionalData = new AdditionalData();
      
      public var cDay:int = 0;
      
      private var _mapTime:String = "";
      
      public var mapCooldownReadyAt:Number = 0;
      
      public var _discount:String = "";
      
      public function VipData()
      {
         super();
      }
      
      public function init() : *
      {
         this.nowVip = "";
         this.giftGetB = false;
         this.giftReadyAt = 0;
         this.buffGetB = false;
         this.durationTime = "";
         this.cDay = 0;
         this.buffTime = 0;
         this.experienceTime = -100;
         this.mapTime = -100;
         this.mapCooldownReadyAt = 0;
         this.buffAdd.clearData();
      }
      
      public function inData_byObj(obj:Object) : *
      {
         var n:* = undefined;
         var pro0:String = null;
         var pro_arr:Array = ["nowVip","durationTime","giftGetB","buffGetB","buffTime","experienceTime"];
         if(obj.nowVip == "vipCard_1")
         {
            obj.nowVip = "vipCard_11";
         }
         else if(obj.nowVip == "vipCard_2")
         {
            obj.nowVip = "vipCard_12";
         }
         else if(obj.nowVip == "vipCard_3")
         {
            obj.nowVip = "vipCard_13";
         }
         else if(obj.nowVip == "vipCard_4")
         {
            obj.nowVip = "vipCard_14";
         }
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            this[pro0] = obj[pro0];
         }
         this.giftReadyAt = obj.hasOwnProperty("giftReadyAt") ? Number(obj.giftReadyAt) : 0;
         if(obj.hasOwnProperty("mapTime"))
         {
            this.mapTime = obj.mapTime;
         }
         else
         {
            this.mapTime = -100;
         }
         this.mapCooldownReadyAt = obj.hasOwnProperty("mapCooldownReadyAt") ? Number(obj.mapCooldownReadyAt) : 0;
         if(!obj.hasOwnProperty("mapCooldownReadyAt") && this.mapTime <= 0 && this.getMapDuration() > 0)
         {
            this.mapTime = this.getMapDuration();
         }
         this.refreshMapAccess();
         this.fleshDiscount();
         var d0:OneVipDefine = this.getNowDefine();
         if(Boolean(d0) && this.nowVip != "")
         {
            this.buffGetB = true;
            this.buffTime = -100;
            this.buffAdd.allAdd = d0.all_pro;
         }
         else
         {
            this.buffAdd.clearData();
         }
      }
      
      public function fleshDiscount() : *
      {
         if(this.nowVip != "")
         {
            this.discount = 0.9;
         }
         else
         {
            this.discount = 1;
         }
      }
      
      public function newDayCtrl() : *
      {
         var d0:OneVipDefine = null;
         if(this.nowVip != "vipCard_0")
         {
            d0 = this.getNowDefine();
            if(Boolean(d0))
            {
               this.buffGetB = true;
               this.buffTime = -100;
               this.buffAdd.allAdd = d0.all_pro;
            }
            this.refreshMapAccess();
         }
         this.fleshDiscount();
      }
      
      public function fleshCDay() : int
      {
         var date0:StringDate = null;
         var cday0:Number = Number(NaN);
         var d0:OneVipDefine = this.getNowDefine();
         this.cDay = 0;
         if(Boolean(d0))
         {
            if(this.nowVip != null && this.nowVip.indexOf("vipCard_1") == 0)
            {
               this.cDay = 10000;
            }
            else if(this.durationTime != "")
            {
               date0 = new StringDate();
               date0.inData_byStr(this.durationTime);
               cday0 = Game.timeDate.getSaveDate.compareDate2(date0) + d0.durationTime;
               this.cDay = Math.ceil(cday0);
            }
         }
         return this.cDay;
      }
      
      public function setVip(str0:String) : *
      {
         var d0:OneVipDefine = null;
         this.nowVip = str0;
         this.giftGetB = false;
         this.giftReadyAt = 0;
         this.buffGetB = this.nowVip != "";
         if(this.nowVip != "")
         {
            this.mapTime = this.getMapDuration();
            this.mapCooldownReadyAt = 0;
            d0 = this.getNowDefine();
            if(Boolean(d0))
            {
               this.buffTime = -100;
               this.buffAdd.allAdd = d0.all_pro;
               Game.gameData.fleshAdd_byItems(true);
            }
         }
         if(this.nowVip == "vipCard_0")
         {
            d0 = this.getNowDefine();
            if(Boolean(d0))
            {
               this.experienceTime = d0.durationTime * 100 * 60 * 60;
            }
         }
         else
         {
            this.durationTime = "";
         }
         this.fleshDiscount();
      }
      
      public function getNowBuffGift() : *
      {
         var d0:OneVipDefine = this.getNowDefine();
         if(Boolean(d0))
         {
            this.buffTime = -100;
            this.buffGetB = true;
            this.buffAdd.allAdd = d0.all_pro;
            Game.gameData.fleshAdd_byItems(true);
         }
      }
      
      public function getNowDefine() : OneVipDefine
      {
         return Game.gameDefine.vip.getDefine(this.nowVip);
      }
      
      public function set experienceTime(str0:Number) : *
      {
         this._experienceTime = TextWay.toCode(String(str0));
      }
      
      public function get experienceTime() : Number
      {
         return Number(TextWay.getText(this._experienceTime));
      }
      
      public function set mapTime(str0:Number) : *
      {
         this._mapTime = TextWay.toCode(String(str0));
      }
      
      public function get mapTime() : Number
      {
         return Number(TextWay.getText(this._mapTime));
      }
      
      public function getGiftCooldownRemaining() : Number
      {
         var remain:Number = this.giftReadyAt - new Date().time;
         if(remain <= 0)
         {
            this.giftReadyAt = 0;
            this.giftGetB = false;
            return 0;
         }
         this.giftGetB = true;
         return Math.ceil(remain / 1000);
      }
      
      public function canGetVipGift() : Boolean
      {
         return this.getGiftCooldownRemaining() <= 0;
      }
      
      public function startGiftCooldown() : *
      {
         this.giftReadyAt = new Date().time + 3 * 60 * 60 * 1000;
         this.giftGetB = true;
      }
      
      public function getMapDuration() : Number
      {
         if(this.nowVip == "vipCard_11")
         {
            return 30 * 60;
         }
         if(this.nowVip == "vipCard_12")
         {
            return 60 * 60;
         }
         if(this.nowVip == "vipCard_13")
         {
            return 90 * 60;
         }
         if(this.nowVip == "vipCard_14")
         {
            return 120 * 60;
         }
         return 0;
      }
      
      public function getMapCooldown() : Number
      {
         if(this.nowVip == "vipCard_11")
         {
            return 20 * 60;
         }
         if(this.nowVip == "vipCard_12")
         {
            return 15 * 60;
         }
         if(this.nowVip == "vipCard_13")
         {
            return 10 * 60;
         }
         if(this.nowVip == "vipCard_14")
         {
            return 5 * 60;
         }
         return 0;
      }
      
      public function getMapCooldownRemaining() : Number
      {
         var remain:Number = this.mapCooldownReadyAt - new Date().time;
         return remain > 0 ? Math.ceil(remain / 1000) : 0;
      }
      
      public function refreshMapAccess() : Boolean
      {
         if(this.mapCooldownReadyAt > 0 && this.getMapCooldownRemaining() <= 0)
         {
            this.mapCooldownReadyAt = 0;
            this.mapTime = this.getMapDuration();
            return true;
         }
         if(this.mapCooldownReadyAt <= 0 && this.mapTime > this.getMapDuration())
         {
            this.mapTime = this.getMapDuration();
         }
         return false;
      }
      
      public function canEnterMap() : Boolean
      {
         this.refreshMapAccess();
         return this.mapCooldownReadyAt <= 0 && this.mapTime > 0;
      }
      
      public function startMapCooldown() : *
      {
         var seconds:Number = this.getMapCooldown();
         if(seconds > 0 && this.mapCooldownReadyAt <= new Date().time)
         {
            this.mapTime = 0;
            this.mapCooldownReadyAt = new Date().time + seconds * 1000;
         }
      }
      
      public function set discount(str0:Number) : *
      {
         this._discount = TextWay.toCode(String(str0));
      }
      
      public function get discount() : Number
      {
         return Number(TextWay.getText(this._discount));
      }
      
      public function useCardPan(name0:String) : Object
      {
         var obj2:Object = null;
         var txt0:String = null;
         var d0:OneVipDefine = this.getNowDefine();
         var d1:OneVipDefine = Game.gameDefine.vip.getDefine(name0);
         if(Boolean(d0))
         {
            obj2 = new Object();
            txt0 = "";
            if(d0.name == d1.name)
            {
               txt0 = "你已经拥有了" + d0.cnName + "效果，不能重复使用。";
               obj2.useB = false;
            }
            else if(d0.durationTime > d1.durationTime)
            {
               txt0 = "你已经拥有了" + d0.cnName + "，不能使用低等级的VIP卡。";
               obj2.useB = false;
            }
            else
            {
               txt0 = "你已经拥有了" + d0.cnName + "效果，\n使用此VIP卡后会覆盖该效果，是否使用？";
               obj2.useB = true;
            }
            obj2.txt = txt0;
            return obj2;
         }
         return null;
      }
      
      public function FTimer() : *
      {
         var vipDefine:OneVipDefine = this.getNowDefine();
         if(Boolean(vipDefine) && this.nowVip != "")
         {
            this.buffGetB = true;
            this.buffTime = -100;
            this.buffAdd.allAdd = vipDefine.all_pro;
         }
         if(this.experienceTime > 0)
         {
            this.experienceTime -= 1;
         }
         else if(this.experienceTime > -100)
         {
            this.experienceTime = -100;
            this.init();
            Game.uiGroup.vipUI.fleshData();
         }
      }
   }
}

