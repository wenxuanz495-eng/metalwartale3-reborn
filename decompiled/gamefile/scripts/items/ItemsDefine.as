package items
{
   import data.StringToDefine;
   import data.TextWay;
   
   public class ItemsDefine
   {
      
      public var type:String = "";
      
      public var name:String = "";
      
      public var cnName:String = "";
      
      public var dropLevel:int = 0;
      
      public var affixLevel:int = 0;
      
      public var nowNum:int = 1;
      
      public var iconImgLabel:String = "";
      
      public var imgLabel:String = "";
      
      public var description:String = "";
      
      private var _price:String = "0";
      
      private var _Mprice:String = "0";
      
      private var _Xprice:String = "0";
      
      private var _Yprice:String = "0";
      
      private var _Zprice:String = "0";
      
      private var _Jprice:String = "0";
      
      public var priceLevel:int = 0;
      
      public var propId:String = "0";
      
      public var propId2:String = "0";
      
      public var discount:Number = 0;
      
      public var addArr:Array = [];
      
      public var cardType:String = "";
      
      private var _cardValue:String = "";
      
      public var baseNum:int = 1;
      
      public function ItemsDefine()
      {
         super();
         this.cardValue = 0;
      }
      
      public function inData_byXML(xml0:XML, type0:String) : *
      {
         this.type = String(type0);
         this.name = String(xml0.child("name"));
         this.cnName = String(xml0.cnName);
         this.dropLevel = int(xml0.dropLevel);
         this.iconImgLabel = String(xml0.iconImgLabel);
         this.imgLabel = String(xml0.imgLabel);
         this.description = String(xml0.description);
         this.description = TextWay.delChat(this.description);
         this.description = StringToDefine.replaceStr(this.description,"{","<");
         this.description = StringToDefine.replaceStr(this.description,"}",">");
         if(xml0.addArr.length() > 0)
         {
            this.addArr = String(xml0.addArr).split(",");
         }
         this.cardType = String(xml0.cardType);
         this.cardValue = Number(xml0.cardValue);
         this.price = int(xml0.price);
         this.Mprice = int(xml0.Mprice);
         this.Xprice = Number(xml0.Xprice);
         this.Yprice = Number(xml0.Yprice);
         this.Zprice = Number(xml0.Zprice);
         this.Jprice = Number(xml0.Jprice);
         this.propId = String(xml0.propId);
         this.propId2 = String(xml0.propId2);
         this.priceLevel = int(this.priceLevel);
         this.discount = Number(xml0.discount);
      }
      
      public function inData_byObj(obj0:Object) : *
      {
         this.type = obj0.type;
         this.name = obj0.name;
         this.cnName = obj0.cnName;
         this.dropLevel = obj0.dropLevel;
         this.iconImgLabel = obj0.iconImgLabel;
         this.imgLabel = obj0.imgLabel;
      }
      
      public function copy() : ItemsDefine
      {
         var gid:ItemsDefine = new ItemsDefine();
         gid.inData_byObj(this);
         return gid;
      }
      
      public function copyAll() : ItemsDefine
      {
         var n:* = undefined;
         var pro0:String = null;
         var gid:ItemsDefine = new ItemsDefine();
         var pro_arr:Array = ["type","propId","propId2","name","cnName","dropLevel","affixLevel","nowNum","iconImgLabel","imgLabel","description","price","Mprice","Xprice","Yprice","Zprice","Jprice","discount","priceLevel","addArr","cardType","cardValue"];
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            gid[pro0] = this[pro0];
         }
         return gid;
      }
      
      public function getBagType() : String
      {
         switch(this.type)
         {
            case "chip":
               return "materials";
            case "capsule":
               return "props";
            case "card":
               return "props";
            default:
               return this.type;
         }
      }
      
      public function getPropB() : Boolean
      {
         if(this.type == "card")
         {
            return true;
         }
         return false;
      }
      
      public function getLevel() : int
      {
         var str0:String = this.name.substr(this.name.length - 1,1);
         return int(str0);
      }
      
      public function getName() : String
      {
         return this.name.substring(0,this.name.length - 2);
      }
      
      public function getCrystalLevel() : int
      {
         var index0:int = this.name.lastIndexOf("_");
         var last0:String = this.name.substring(index0 + 1);
         return int(last0);
      }
      
      public function getPrevCrystalName() : String
      {
         var index0:int = this.name.lastIndexOf("_");
         var first0:String = this.name.substring(0,index0);
         var last0:String = this.name.substring(index0 + 1);
         return first0 + "_" + (int(last0) - 1);
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
      
      public function get cardValue() : Number
      {
         return Number(TextWay.getText(this._cardValue));
      }
      
      public function set cardValue(v0:Number) : *
      {
         this._cardValue = TextWay.toCode(String(v0));
      }
   }
}

