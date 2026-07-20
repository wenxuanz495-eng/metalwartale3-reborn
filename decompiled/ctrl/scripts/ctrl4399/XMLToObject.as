package ctrl4399
{
   import flash.utils.ByteArray;
   
   public class XMLToObject
   {
      
      private const NULL_TYPY:String = "undefined";
      
      private const BOOBLEAN_TYPE:String = "Boolean";
      
      private const ARRAY_TYPE:String = "Array";
      
      private const STRING_TYPE:String = "String";
      
      private const OBJECT_TYPE:String = "Object";
      
      private const NUMBER_TYPE:String = "Number";
      
      private const XML_TYPE:String = "XML";
      
      public function XMLToObject()
      {
         super();
      }
      
      public function strToObj(param1:String) : Array
      {
         var obj:Object = null;
         var arr:Array = null;
         var bol:Boolean = false;
         var xml:XML = null;
         var i:int = 0;
         var len:int = 0;
         var xmlList:XML = null;
         var type:String = null;
         var tmpStr:String = null;
         var str:String = param1;
         try
         {
            xml = new XML(str);
         }
         catch(error:Error)
         {
            tmpStr = str;
            tmpStr = urlencodeGBK(tmpStr);
            try
            {
               xml = new XML(tmpStr);
            }
            catch(error:Error)
            {
               return [STRING_TYPE,str];
            }
         }
         if(xml.children() == null || xml.children() == undefined)
         {
            return [this.STRING_TYPE,str];
         }
         if(xml.@game4399 != "true")
         {
            return [this.XML_TYPE,xml];
         }
         if(xml.@type == this.OBJECT_TYPE)
         {
            xmlList = xml.children()[0];
            obj = this.xmlToObj(xmlList);
            type = this.OBJECT_TYPE;
            return [type,obj];
         }
         if(xml.@type == this.BOOBLEAN_TYPE)
         {
            type = this.BOOBLEAN_TYPE;
            xmlList = xml.children()[0];
            bol = this.xmlToBooblean(xmlList);
            return [type,bol];
         }
         if(xml.@type == this.ARRAY_TYPE)
         {
            type = this.ARRAY_TYPE;
            xmlList = xml.children()[0];
            arr = this.xmlToArray(xmlList);
            return [type,arr];
         }
         return null;
      }
      
      private function xmlToObj(param1:XML) : Object
      {
         var _loc2_:Object = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:XMLList = null;
         var _loc6_:XML = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:Object = null;
         _loc2_ = {};
         _loc5_ = param1.children();
         _loc4_ = _loc5_.length();
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc6_ = _loc5_[_loc3_];
            _loc8_ = _loc6_.@type;
            _loc7_ = _loc6_.@name;
            switch(_loc8_)
            {
               case this.ARRAY_TYPE:
                  _loc9_ = this.xmlToArray(_loc6_) as Array;
                  break;
               case this.BOOBLEAN_TYPE:
                  _loc9_ = this.xmlToBooblean(_loc6_) as Boolean;
                  break;
               case this.STRING_TYPE:
                  _loc9_ = this.xmlToString(_loc6_) as String;
                  break;
               case this.NUMBER_TYPE:
                  _loc9_ = this.xmlToNumber(_loc6_) as Number;
                  break;
               case this.OBJECT_TYPE:
                  _loc9_ = this.xmlToObj(_loc6_);
            }
            _loc2_[_loc7_] = _loc9_;
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function xmlToArray(param1:XML) : Array
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Object = null;
         var _loc6_:XMLList = null;
         var _loc7_:XML = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         _loc2_ = [];
         _loc6_ = param1.children();
         _loc4_ = _loc6_.length();
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc7_ = _loc6_[_loc3_];
            _loc8_ = _loc7_.@type;
            _loc9_ = _loc7_.@name;
            switch(_loc8_)
            {
               case this.ARRAY_TYPE:
                  _loc5_ = this.xmlToArray(_loc7_) as Array;
                  break;
               case this.BOOBLEAN_TYPE:
                  _loc5_ = this.xmlToBooblean(_loc7_) as Boolean;
                  break;
               case this.STRING_TYPE:
                  _loc5_ = this.xmlToString(_loc7_) as String;
                  break;
               case this.NUMBER_TYPE:
                  _loc5_ = this.xmlToNumber(_loc7_) as Number;
                  break;
               case this.OBJECT_TYPE:
                  _loc5_ = this.xmlToObj(_loc7_);
                  break;
               case this.NULL_TYPY:
                  _loc5_ = null;
            }
            _loc2_.push(_loc5_);
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function xmlToNumber(param1:XML) : Number
      {
         var _loc2_:Number = NaN;
         return Number(param1[0]);
      }
      
      private function xmlToBooblean(param1:XML) : Boolean
      {
         var _loc2_:Boolean = false;
         if(param1[0] == "false")
         {
            _loc2_ = false;
         }
         else if(param1[0] == "true")
         {
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      private function xmlToString(param1:XML) : String
      {
         var _loc2_:String = null;
         return String(param1[0]);
      }
      
      private function urlencodeGBK(param1:String) : String
      {
         var _loc2_:String = "";
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeMultiByte(param1,"gbk");
         _loc3_.position = 0;
         return _loc3_.readUTFBytes(_loc3_.length - 1);
      }
   }
}

