package body.hero
{
   import data.StringToDefine;
   import data.TextWay;
   import flash.geom.Rectangle;
   import gameAll.data.CarItemsData;
   
   public class CarDefine
   {
      
      public var father:String;
      
      private var xmlList:Array = new Array();
      
      private var _xml:XML;
      
      private var carXml:XML;
      
      public var id:String;
      
      public var name:String;
      
      public var type:String;
      
      public var hitRect:Rectangle = new Rectangle();
      
      public var hurtRectArr:Array = [];
      
      public var _baseLife:String = "100";
      
      public var defenceType:String = "mixed";
      
      public var _defenceValue:String = "100";
      
      public var imgLabel:String;
      
      public var description:String = "";
      
      public var itemsData:CarItemsData = new CarItemsData();
      
      public var propId:String = "0";
      
      public var propId2:String = "0";
      
      private var _price:String = "0";
      
      private var _Mprice:String = "0";
      
      private var _Xprice:String = "0";
      
      private var _Yprice:String = "0";
      
      private var _Zprice:String = "0";
      
      private var _Jprice:String = "0";
      
      public var discount:Number = 0;
      
      public var priceLevel:int = 0;
      
      public var mustLevel:int = 0;
      
      public var beforeLevel:int = 0;
      
      public var installLevel:int = 1;
      
      private var _maxUpgradeLevel:String = "0";
      
      public function CarDefine()
      {
         super();
         this.baseLife = 100;
         this.defenceValue = 0;
         this.maxUpgradeLevel = 15;
      }
      
      public function set xml(xml0:XML) : *
      {
         var n:* = undefined;
         var xml_list0:XMLList = xml0.gather.car;
         for(n in xml_list0)
         {
            this.xmlList.push(xml_list0[n].@id);
         }
         this._xml = xml0;
         this.father = xml0.father;
      }
      
      public function inData_byXML(xml0:XML) : *
      {
         var n:* = undefined;
         var type00:String = null;
         var hitr:Array = null;
         var hurtRect:Rectangle = null;
         this.carXml = xml0;
         this.id = xml0.@id;
         this.type = xml0.type;
         this.imgLabel = xml0.imgLabel;
         this.price = int(xml0.price);
         this.Mprice = int(xml0.Mprice);
         this.Xprice = int(xml0.Xprice);
         this.Yprice = Number(xml0.Yprice);
         this.Zprice = Number(xml0.Zprice);
         this.Jprice = Number(xml0.Jprice);
         this.propId = String(xml0.propId);
         this.propId2 = String(xml0.propId2);
         this.discount = Number(xml0.discount);
         if(this.discount >= 0)
         {
            this.discount = 0.3;
         }
         this.description = String(xml0.description);
         this.description = StringToDefine.replaceStr(this.description,"{","<");
         this.description = StringToDefine.replaceStr(this.description,"}",">");
         this.priceLevel = int(xml0.priceLevel);
         this.mustLevel = int(xml0.baseLevel);
         this.beforeLevel = int(xml0.level);
         this.installLevel = int(xml0.installLevel);
         if(this.installLevel == 0)
         {
            this.installLevel = 1;
         }
         this.name = String(xml0.child("name"));
         this.baseLife = int(xml0.baseLife);
         this.defenceType = String(xml0.defenceType);
         this.defenceValue = int(xml0.defenceValue);
         var hitRectArr:Array = String(xml0.hitRect).split(",");
         this.hitRect.x = hitRectArr[0];
         this.hitRect.y = hitRectArr[1];
         this.hitRect.width = hitRectArr[2];
         this.hitRect.height = hitRectArr[3];
         var hitXML:* = xml0.hurtRect;
         for(n in hitXML)
         {
            hitr = String(hitXML[n]).split(",");
            hurtRect = new Rectangle();
            hurtRect.x = int(hitr[0]);
            hurtRect.y = int(hitr[1]);
            hurtRect.width = int(hitr[2]);
            hurtRect.height = int(hitr[3]);
            this.hurtRectArr[n] = hurtRect;
         }
         type00 = this.getType();
         if(type00 == "M")
         {
            this.maxUpgradeLevel = int((100 - this.mustLevel) / 5);
         }
         else if(type00 == "XYZ")
         {
            this.maxUpgradeLevel = int((100 - this.mustLevel) / 5);
         }
         else if(type00 == "G")
         {
            this.maxUpgradeLevel = int((100 - this.mustLevel) / 5);
         }
         if(xml0.baseLevel.length() > 1)
         {
            throw new Error("车身：" + this.name + "的baseLevel个数不能超过1个。");
         }
         if(xml0.baseLevel.length() == 0)
         {
            if(this.type == "G")
            {
               throw new Error("G币车身：" + this.name + "的不能没有baseLevel属性。");
            }
         }
      }
      
      public function getType() : String
      {
         return this.type;
      }
      
      public function isCustom() : Boolean
      {
         return this.discount == -1000;
      }
      
      public function inData(id0:String, _itemsData:CarItemsData = null) : *
      {
         var xml0:XML = null;
         var num:int = this.getIndex_byID(id0);
         if(num >= 0)
         {
            xml0 = this._xml.gather.car[num];
            this.inData_byXML(xml0);
            if(_itemsData is CarItemsData)
            {
               this.itemsData = _itemsData;
            }
            else
            {
               this.itemsData = new CarItemsData();
            }
         }
         else
         {
            trace("没找到这个车身的数据：" + id0);
         }
      }
      
      public function getIndex_byID(id0:String) : int
      {
         var n:* = undefined;
         for(n in this.xmlList)
         {
            if(this.xmlList[n] == id0)
            {
               return n;
            }
         }
         return -1;
      }
      
      public function getSellPrice() : int
      {
         return this.price * 0.75 * (1 - this.discount);
      }
      
      public function getImgLabel() : String
      {
         return this.father + "/" + this.imgLabel + "_items";
      }
      
      public function get baseLife() : int
      {
         return int(TextWay.getText(this._baseLife));
      }
      
      public function set baseLife(v0:int) : *
      {
         this._baseLife = TextWay.toCode(String(v0));
      }
      
      public function get defenceValue() : int
      {
         return int(TextWay.getText(this._defenceValue));
      }
      
      public function set defenceValue(v0:int) : *
      {
         this._defenceValue = TextWay.toCode(String(v0));
      }
      
      public function get price() : int
      {
         return int(TextWay.getText(this._price));
      }
      
      public function set price(v0:int) : *
      {
         this._price = TextWay.toCode(String(v0));
      }
      
      public function get Mprice() : int
      {
         return int(TextWay.getText(this._Mprice));
      }
      
      public function set Mprice(v0:int) : *
      {
         this._Mprice = TextWay.toCode(String(v0));
      }
      
      public function get Xprice() : int
      {
         return Number(TextWay.getText(this._Xprice));
      }
      
      public function set Xprice(v0:int) : *
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
      
      public function get maxUpgradeLevel() : Number
      {
         return Number(TextWay.getText(this._maxUpgradeLevel));
      }
      
      public function set maxUpgradeLevel(v0:Number) : *
      {
         this._maxUpgradeLevel = TextWay.toCode(String(v0));
      }
   }
}

