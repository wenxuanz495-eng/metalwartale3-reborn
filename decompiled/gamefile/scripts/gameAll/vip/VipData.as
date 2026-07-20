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
      
      public var buffGetB:Boolean = false;
      
      public var buffTime:Number = -100;
      
      private var _experienceTime:String = "";
      
      public var buffAdd:AdditionalData = new AdditionalData();
      
      public var cDay:int = 0;
      
      private var _mapTime:String = "";
      
      public var _discount:String = "";
      
      public function VipData()
      {
         super();
      }
      
      public function init() : *
      {
         this.nowVip = "";
         this.giftGetB = false;
         this.buffGetB = false;
         this.durationTime = "";
         this.cDay = 0;
         this.buffTime = 0;
         this.experienceTime = -100;
         this.mapTime = -100;
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
         if(obj.hasOwnProperty("mapTime"))
         {
            this.mapTime = obj.mapTime;
         }
         else
         {
            this.mapTime = -100;
         }
         this.fleshDiscount();
         var d0:OneVipDefine = this.getNowDefine();
         if(Boolean(d0) && Boolean(this.buffGetB) && this.buffTime > 0)
         {
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
               this.giftGetB = false;
               this.buffGetB = false;
               this.mapTime = 60 * 60;
               this.buffTime = -100;
            }
            this.buffAdd.clearData();
         }
         this.fleshDiscount();
      }
      
      public function fleshCDay() : int
      {
         var date0:StringDate = null;
         var cday0:Number = NaN;
         var d0:OneVipDefine = this.getNowDefine();
         this.cDay = 0;
         if(Boolean(d0))
         {
            if(d0.name == "vipCard_4")
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
         this.buffGetB = false;
         if(this.nowVip != "")
         {
            this.mapTime = 60 * 60;
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
            Game.severTime.getTime(this.affterGetSeverTime);
         }
         this.fleshDiscount();
      }
      
      public function affterGetSeverTime(time00:String) : *
      {
         this.durationTime = Game.inTimeGetSaveDate(time00).getStr();
      }
      
      public function getNowBuffGift() : *
      {
         var d0:OneVipDefine = this.getNowDefine();
         if(Boolean(d0))
         {
            this.buffTime = d0.buffTime;
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
         if(this.buffTime > 0)
         {
            if(this.buffGetB)
            {
               this.buffTime -= 1;
            }
         }
         else if(this.buffTime <= 0)
         {
            this.buffTime = -100;
            this.buffAdd.clearData();
            Game.gameData.fleshAdd_byItems(true);
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

