package goods
{
   import data.StringToDefine;
   import data.TextWay;
   
   public class GoodsDefine
   {
      
      public static var nameArr:Array = ["price","Mprice","Xprice","Yprice","Zprice","Jprice"];
      
      public static var cnArr:Array = ["G币","M币","个超合金X","个超合金Y","个超合金Z","个荣誉勋章"];
      
      public var type:String = "items";
      
      public var name:String = "";
      
      public var id:String = "";
      
      public var propId:String = "0";
      
      public var propId2:String = "0";
      
      public var imgLabel:String = "";
      
      private var _price:String = "0";
      
      private var _Mprice:String = "0";
      
      private var _Xprice:String = "0";
      
      private var _Yprice:String = "0";
      
      private var _Zprice:String = "0";
      
      private var _Jprice:String = "0";
      
      public var priceType:String = "price";
      
      public var priceLevel:int = 0;
      
      public var _num:String = "1";
      
      public var baseNum:int = 1;
      
      public var Maxbuy:int = 1;
      
      public var pro:int = 0;
      
      public var showTipB:Boolean = true;
      
      public var chipLevelTipB:Boolean = true;
      
      public var affixLevel:int = -1;
      
      public var discount:Number = 0;
      
      public var specialType:String = "";
      
      public var define:*;
      
      public function GoodsDefine()
      {
         super();
         this.init();
         this.num = 1;
      }
      
      public function init() : *
      {
         this.price = 0;
         this.Mprice = 0;
         this.Xprice = 0;
         this.Yprice = 0;
         this.Zprice = 0;
         this.Jprice = 0;
      }
      
      public function copy() : GoodsDefine
      {
         var n:* = undefined;
         var pro0:String = null;
         var pro_arr:Array = ["type","propId","propId2","name","id","imgLabel","priceType","priceLevel","num","baseNum","pro","showTipB","chipLevelTipB","affixLevel","discount","specialType","define"];
         pro_arr = pro_arr.concat(nameArr);
         var d0:GoodsDefine = new GoodsDefine();
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            d0[pro0] = this[pro0];
         }
         return d0;
      }
      
      public function getLevelTitle() : String
      {
         if(this.id.indexOf("_chip") >= 0)
         {
            if(this.affixLevel >= 0)
            {
               return this.affixLevel + 1 + "级" + this.name;
            }
         }
         return this.name;
      }
      
      public function getAllType() : Array
      {
         return this.priceType.split("_");
      }
      
      public function getCoinB() : Boolean
      {
         return this.priceType == "Mprice" || this.priceType == "price";
      }
      
      public function isZuobi() : Boolean
      {
         var n:* = undefined;
         return false;
      }
      
      public function fleshPrice_inData(d0:GoodsDefine) : *
      {
         var n:* = undefined;
         var name0:String = null;
         var value0:Number = NaN;
         this.init();
         this.name = d0.name;
         this.priceType = d0.priceType;
         this.priceLevel = d0.priceLevel;
         this.baseNum = d0.baseNum;
         this.id = d0.id;
         this.propId = d0.propId;
         this.propId2 = d0.propId2;
         this.Maxbuy = d0.Maxbuy;
         var arr0:Array = this.getAllType();
         for(n in arr0)
         {
            name0 = arr0[n];
            value0 = Number(d0[name0]);
            if((name0 == "Mprice" || name0 == "price") && this.id.indexOf("vipCard") == -1)
            {
               value0 = Math.ceil(value0 * Game.gameData.vipData.discount);
            }
            this[name0] = value0 * this.num;
         }
      }
      
      public function getPriceArr() : Array
      {
         var n:* = undefined;
         var name0:String = null;
         var value0:Number = NaN;
         var arr0:Array = this.getAllType();
         var arr1:Array = [];
         for(n in arr0)
         {
            name0 = arr0[n];
            value0 = Number(this[name0]);
            arr1.push(value0);
         }
         return arr1;
      }
      
      public function getMustText(d0:GoodsDefine) : String
      {
         var n:* = undefined;
         var str1:String = null;
         var i:* = undefined;
         var name0:String = null;
         var cn0:String = null;
         var value0:Number = NaN;
         var str0:String = null;
         var textArr0:Array = [];
         var arr0:Array = this.getAllType();
         for(n in arr0)
         {
            name0 = arr0[n];
            cn0 = cnArr[nameArr.indexOf(name0)];
            value0 = Number(this[name0]);
            str0 = StringToDefine.getFontColor(value0 + "","#FFFF00") + " " + cn0;
            trace("需求文本：" + str0);
            if(value0 > d0[name0])
            {
               str0 += StringToDefine.getFontColor("(不足)","#FF0000");
            }
            textArr0.push(str0);
         }
         str1 = "";
         for(i in textArr0)
         {
            str1 += textArr0[i];
            if(i < textArr0.length - 1)
            {
               str1 += "，";
            }
         }
         return str1;
      }
      
      public function getBuyB(d0:GoodsDefine) : Boolean
      {
         var n:* = undefined;
         var name0:String = null;
         var value0:Number = NaN;
         var price0:Number = NaN;
         if(this.num == 0)
         {
            return false;
         }
         var arr0:Array = this.getAllType();
         for(n in arr0)
         {
            name0 = arr0[n];
            value0 = Number(this[name0]);
            price0 = Number(d0[name0]);
            if(value0 > price0)
            {
               return false;
            }
         }
         return true;
      }
      
      public function getFastUseB() : Boolean
      {
         if(this.id == "mcoin_reward_card")
         {
            return true;
         }
         if(this.id == "exp_card_directly")
         {
            return true;
         }
         if(this.id == "GCoin_card_4")
         {
            return true;
         }
         if(this.id == "achieve_card_3")
         {
            return true;
         }
         return false;
      }
      
      public function toString() : *
      {
         return this.type + ":" + this.id;
      }
      
      public function get num() : int
      {
         return int(TextWay.getText(this._num));
      }
      
      public function set num(v0:int) : *
      {
         this._num = TextWay.toCode(String(v0));
      }
      
      public function get price() : Number
      {
         return Number(TextWay.getText(this._price));
      }
      
      public function set price(v0:Number) : *
      {
         this._price = TextWay.toCode(String(v0));
      }
      
      public function get Mprice() : Number
      {
         return Number(TextWay.getText(this._Mprice));
      }
      
      public function set Mprice(v0:Number) : *
      {
         this._Mprice = TextWay.toCode(String(v0));
      }
      
      public function get Xprice() : Number
      {
         return Number(TextWay.getText(this._Xprice));
      }
      
      public function set Xprice(v0:Number) : *
      {
         this._Xprice = TextWay.toCode(String(v0));
      }
      
      public function get Yprice() : Number
      {
         return Number(TextWay.getText(this._Yprice));
      }
      
      public function set Yprice(v0:Number) : *
      {
         this._Yprice = TextWay.toCode(String(v0));
      }
      
      public function get Zprice() : Number
      {
         return Number(TextWay.getText(this._Zprice));
      }
      
      public function set Zprice(v0:Number) : *
      {
         this._Zprice = TextWay.toCode(String(v0));
      }
      
      public function get Jprice() : Number
      {
         return Number(TextWay.getText(this._Jprice));
      }
      
      public function set Jprice(v0:Number) : *
      {
         this._Jprice = TextWay.toCode(String(v0));
      }
   }
}

