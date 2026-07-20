package body.hero
{
   import body.bullet.BulletLink;
   import body.define.OneArmsDefine;
   import data.TextWay;
   import gameAll.data.ArmsItemsData;
   
   public class ArmsDefine extends OneArmsDefine
   {
      
      private var armsFather:String = "";
      
      private var _armsMaxLevel:int = 0;
      
      public var nowArmsMaxLevel:int = 0;
      
      public function ArmsDefine(_armsFather:String = "")
      {
         super();
         this.armsFather = _armsFather;
      }
      
      override public function set baseHurt(_value:Number) : *
      {
         _baseHurt = TextWay.toCode(String(_value));
      }
      
      override public function get baseHurt() : Number
      {
         return int(TextWay.getText(_baseHurt));
      }
      
      public function inData(id0:String, level0:int, father0:String = "", _itemsData:ArmsItemsData = null) : *
      {
         var define0:* = undefined;
         itemsData = new ArmsItemsData();
         if(father0 != "")
         {
            define0 = Game.defineGroup.getArmsDefine(id0,level0,father0,_itemsData);
         }
         else
         {
            define0 = Game.defineGroup.getArmsDefine(id0,level0,this.armsFather,_itemsData);
         }
         inData_byXML(define0.xmlData);
         father = define0.father;
         index = define0.index;
         id = define0.id;
         if(_itemsData is ArmsItemsData)
         {
            itemsData = _itemsData;
         }
         level = define0.level;
         fleshData();
      }
      
      public function get armsMaxLevel() : int
      {
         return Game.defineGroup.getArmsDefineArr(id,this.armsFather).length - 1;
      }
      
      public function get armsImgLabel() : String
      {
         var arr0:Array = imgLabel.split("/");
         if(arr0.length > 1)
         {
            return arr0[1];
         }
         return imgLabel;
      }
      
      public function inData_byStr(str:String) : *
      {
         var bulletL:BulletLink = new BulletLink();
         bulletL.bulletName = str;
         bulletL.inData_byName();
         this.inData(bulletL.bulletTrueName,bulletL.bulletLevel,bulletL.father);
      }
   }
}

