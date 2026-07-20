package ctrl4399
{
   public class ObjectToXML
   {
      
      private var _xml:XML;
      
      private const NULL_TYPY:String = "undefined";
      
      private const BOOBLEAN_TYPE:String = "Boolean";
      
      private const ARRAY_TYPE:String = "Array";
      
      private const STRING_TYPE:String = "String";
      
      private const OBJECT_TYPE:String = "Object";
      
      private const NUMBER_TYPE:String = "Number";
      
      private const XML_TYPE:String = "XML";
      
      public function ObjectToXML()
      {
         super();
      }
      
      public function objectToString(param1:Object) : String
      {
         var _loc2_:XML = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(!param1)
         {
            return null;
         }
         if(param1 is Boolean)
         {
            _loc3_ = this.BOOBLEAN_TYPE;
            _loc2_ = this.bolToXml(param1 as Boolean,null);
         }
         else
         {
            if(param1 is XML)
            {
               _loc2_ = param1 as XML;
               _loc2_.ignoreComments = true;
               return _loc2_.toString();
            }
            if(param1 is Array)
            {
               _loc3_ = this.ARRAY_TYPE;
               _loc2_ = this.arrToXml(param1 as Array,null);
            }
            else
            {
               if(param1 is String)
               {
                  _loc3_ = this.STRING_TYPE;
                  return param1 as String;
               }
               if(param1 is Number || param1 is int || param1 is uint)
               {
                  _loc3_ = this.NUMBER_TYPE;
                  return String(param1);
               }
               if(param1 is Object)
               {
                  _loc3_ = this.OBJECT_TYPE;
                  _loc2_ = this.objToXml(param1);
               }
            }
         }
         this.init(_loc3_);
         this._xml.appendChild(_loc2_);
         this._xml.ignoreWhitespace = true;
         return this._xml.toString();
      }
      
      public function objToXml(param1:Object, param2:String = null) : XML
      {
         var _loc3_:XML = null;
         var _loc4_:Object = null;
         var _loc5_:XML = null;
         _loc3_ = <s></s>;
         _loc3_.@type = this.OBJECT_TYPE;
         _loc3_.@name = param2;
         for(param2 in param1)
         {
            _loc4_ = param1[param2];
            if(_loc4_ is Boolean)
            {
               _loc5_ = this.bolToXml(_loc4_ as Boolean,param2);
               _loc3_.appendChild(_loc5_);
            }
            else if(_loc4_ is String)
            {
               _loc5_ = this.stringToXml(_loc4_ as String,param2);
               _loc3_.appendChild(_loc5_);
            }
            else if(_loc4_ is int || _loc4_ is uint || _loc4_ is Number)
            {
               _loc5_ = this.numToXml(_loc4_ as Number,param2);
               _loc3_.appendChild(_loc5_);
            }
            else if(_loc4_ is Array)
            {
               _loc5_ = this.arrToXml(_loc4_ as Array,param2);
               _loc3_.appendChild(_loc5_);
            }
            else if(_loc4_ is Object)
            {
               _loc5_ = this.objToXml(_loc4_,param2);
               _loc3_.appendChild(_loc5_);
            }
            else if(!_loc4_)
            {
               _loc5_ = this.nullToxml(null,param2);
               _loc3_.appendChild(_loc5_);
            }
         }
         return _loc3_;
      }
      
      private function nullToxml(param1:String, param2:String) : XML
      {
         var _loc3_:XML = null;
         _loc3_ = <s></s>;
         _loc3_.@type = this.NULL_TYPY;
         _loc3_.@name = param2;
         return _loc3_;
      }
      
      private function stringToXml(param1:String, param2:String) : XML
      {
         var _loc3_:XML = null;
         _loc3_ = new XML("<s>" + param1 + "</s>");
         _loc3_.@type = this.STRING_TYPE;
         _loc3_.@name = param2;
         return _loc3_;
      }
      
      private function numToXml(param1:Number, param2:String) : XML
      {
         var _loc3_:XML = null;
         _loc3_ = new XML("<s>" + String(param1) + "</s>");
         _loc3_.@type = this.NUMBER_TYPE;
         _loc3_.@name = param2;
         return _loc3_;
      }
      
      private function arrToXml(param1:Array, param2:String) : XML
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:XML = null;
         var _loc6_:Object = null;
         var _loc7_:XML = null;
         _loc4_ = int(param1.length);
         _loc5_ = <s></s>;
         _loc5_.@type = this.ARRAY_TYPE;
         _loc5_.@name = param2;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc6_ = param1[_loc3_];
            if(_loc6_ is Boolean)
            {
               _loc7_ = this.bolToXml(_loc6_ as Boolean,null);
               _loc5_.appendChild(_loc7_);
            }
            else if(_loc6_ is String)
            {
               _loc7_ = this.stringToXml(_loc6_ as String,null);
               _loc5_.appendChild(_loc7_);
            }
            else if(_loc6_ is int || _loc6_ is uint || _loc6_ is Number)
            {
               _loc7_ = this.numToXml(_loc6_ as Number,null);
               _loc5_.appendChild(_loc7_);
            }
            else if(_loc6_ is Array)
            {
               _loc7_ = this.arrToXml(_loc6_ as Array,null);
               _loc5_.appendChild(_loc7_);
            }
            else if(_loc6_ is Object)
            {
               _loc7_ = this.objToXml(_loc6_,null);
               _loc5_.appendChild(_loc7_);
            }
            _loc3_++;
         }
         return _loc5_;
      }
      
      private function bolToXml(param1:Boolean, param2:String) : XML
      {
         var _loc3_:XML = null;
         if(param1)
         {
            _loc3_ = <s>true</s>;
         }
         else
         {
            _loc3_ = <s>false</s>;
         }
         _loc3_.@type = this.BOOBLEAN_TYPE;
         _loc3_.@name = param2;
         return _loc3_;
      }
      
      private function init(param1:String) : void
      {
         this._xml = <saveXml></saveXml>;
         this._xml.@type = param1;
         this._xml.@game4399 = true;
      }
   }
}

