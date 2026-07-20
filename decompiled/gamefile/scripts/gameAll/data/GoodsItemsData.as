package gameAll.data
{
   import data.TextWay;
   import items.ItemsDefine;
   
   public class GoodsItemsData extends ItemsData
   {
      
      public var affixLevel:int = 0;
      
      private var _nowNum:String = "37";
      
      public var define:* = new Object();
      
      public var addArr:Array = [];
      
      public function GoodsItemsData()
      {
         super();
      }
      
      public function get nowNum() : int
      {
         return int(TextWay.getText(this._nowNum));
      }
      
      public function set nowNum(v0:int) : *
      {
         this._nowNum = TextWay.toCode(String(v0));
      }
      
      public function inData_byDefine(id:ItemsDefine) : *
      {
         imgLabel = id.imgLabel;
         name = id.name;
         cnName = id.cnName;
         type = id.type;
         this.define = id;
         if(type != "chip")
         {
            this.addArr = id.addArr;
         }
      }
      
      override public function inData_byObj(obj0:Object) : *
      {
         super.inData_byObj(obj0);
         this.nowNum = obj0.nowNum;
         this.affixLevel = obj0.affixLevel;
         if(type == "chip")
         {
            this.addArr = obj0.addArr;
         }
         else
         {
            this.addArr = this.getDefine().addArr;
         }
      }
      
      public function copy(num:int = 0) : GoodsItemsData
      {
         var gid:GoodsItemsData = new GoodsItemsData();
         gid.inData_byObj(this);
         if(num >= 0)
         {
            gid.nowNum = num;
         }
         return gid;
      }
      
      public function inData_byMe() : *
      {
         this.define = this.getDefine();
      }
      
      public function clearData() : *
      {
         this.define = null;
      }
      
      public function getSellPrice() : int
      {
         if(!this.define.hasOwnProperty("price"))
         {
            this.define = this.getDefine();
         }
         if(this.define.type == "chip")
         {
            return Game.gameDefine.getChipPrice(name,this.affixLevel);
         }
         return this.define.price * this.nowNum / 4;
      }
      
      public function getDefine() : ItemsDefine
      {
         return Game.itemsDefineGroup.getDefine(name);
      }
      
      public function getAddData() : AdditionalData
      {
         var ad0:AdditionalData = new AdditionalData();
         ad0.inData_byArr(this.addArr);
         return ad0;
      }
      
      public function getChipText() : String
      {
         var str0:String = "";
         str0 += this.affixLevel + "|";
         return str0 + this.addArr.toString();
      }
      
      public function inData_byChipText(str0:String) : *
      {
         this.affixLevel = int(str0.split("|")[0]);
         this.addArr = str0.split("|")[1].split(",");
      }
   }
}

