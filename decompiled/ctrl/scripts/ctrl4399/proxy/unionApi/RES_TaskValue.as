package ctrl4399.proxy.unionApi
{
   import flash.utils.Dictionary;
   import org.apache.thrift.*;
   import org.apache.thrift.meta_data.*;
   import org.apache.thrift.protocol.*;
   
   public class RES_TaskValue implements TBase
   {
      
      private static const STRUCT_DESC:TStruct = new TStruct("RES_TaskValue");
      
      private static const TAG_FIELD_DESC:TField = new TField("tag",TType.STRING,1);
      
      private static const VALUE_FIELD_DESC:TField = new TField("value",TType.LIST,2);
      
      private static const EXCHANGE_FIELD_DESC:TField = new TField("exchange",TType.STRING,3);
      
      private static const TOTAL_FIELD_DESC:TField = new TField("total",TType.STRING,4);
      
      public static const TAG:int = 1;
      
      public static const VALUE:int = 2;
      
      public static const EXCHANGE:int = 3;
      
      public static const TOTAL:int = 4;
      
      public static const metaDataMap:Dictionary = new Dictionary();
      
      metaDataMap[TAG] = new FieldMetaData("tag",TFieldRequirementType.REQUIRED,new FieldValueMetaData(TType.STRING));
      metaDataMap[VALUE] = new FieldMetaData("value",TFieldRequirementType.DEFAULT,new ListMetaData(TType.LIST,new StructMetaData(TType.STRUCT,Task)));
      metaDataMap[EXCHANGE] = new FieldMetaData("exchange",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[TOTAL] = new FieldMetaData("total",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      FieldMetaData.addStructMetaDataMap(RES_TaskValue,metaDataMap);
      
      private var _tag:String;
      
      private var _value:Array;
      
      private var _exchange:String;
      
      private var _total:String;
      
      public function RES_TaskValue()
      {
         super();
      }
      
      public function get tag() : String
      {
         return this._tag;
      }
      
      public function set tag(param1:String) : void
      {
         this._tag = param1;
      }
      
      public function unsetTag() : void
      {
         this.tag = null;
      }
      
      public function isSetTag() : Boolean
      {
         return this.tag != null;
      }
      
      public function get value() : Array
      {
         return this._value;
      }
      
      public function set value(param1:Array) : void
      {
         this._value = param1;
      }
      
      public function unsetValue() : void
      {
         this.value = null;
      }
      
      public function isSetValue() : Boolean
      {
         return this.value != null;
      }
      
      public function get exchange() : String
      {
         return this._exchange;
      }
      
      public function set exchange(param1:String) : void
      {
         this._exchange = param1;
      }
      
      public function unsetExchange() : void
      {
         this.exchange = null;
      }
      
      public function isSetExchange() : Boolean
      {
         return this.exchange != null;
      }
      
      public function get total() : String
      {
         return this._total;
      }
      
      public function set total(param1:String) : void
      {
         this._total = param1;
      }
      
      public function unsetTotal() : void
      {
         this.total = null;
      }
      
      public function isSetTotal() : Boolean
      {
         return this.total != null;
      }
      
      public function setFieldValue(param1:int, param2:*) : void
      {
         switch(param1)
         {
            case TAG:
               if(param2 == null)
               {
                  this.unsetTag();
               }
               else
               {
                  this.tag = param2;
               }
               break;
            case VALUE:
               if(param2 == null)
               {
                  this.unsetValue();
               }
               else
               {
                  this.value = param2;
               }
               break;
            case EXCHANGE:
               if(param2 == null)
               {
                  this.unsetExchange();
               }
               else
               {
                  this.exchange = param2;
               }
               break;
            case TOTAL:
               if(param2 == null)
               {
                  this.unsetTotal();
               }
               else
               {
                  this.total = param2;
               }
               break;
            default:
               throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
         }
      }
      
      public function getFieldValue(param1:int) : *
      {
         switch(param1)
         {
            case TAG:
               return this.tag;
            case VALUE:
               return this.value;
            case EXCHANGE:
               return this.exchange;
            case TOTAL:
               return this.total;
            default:
               throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
         }
      }
      
      public function isSet(param1:int) : Boolean
      {
         switch(param1)
         {
            case TAG:
               return this.isSetTag();
            case VALUE:
               return this.isSetValue();
            case EXCHANGE:
               return this.isSetExchange();
            case TOTAL:
               return this.isSetTotal();
            default:
               throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
         }
      }
      
      public function read(param1:TProtocol) : void
      {
         var _loc2_:TField = null;
         var _loc3_:TList = null;
         var _loc4_:int = 0;
         var _loc5_:Task = null;
         param1.readStructBegin();
         while(true)
         {
            _loc2_ = param1.readFieldBegin();
            if(_loc2_.type == TType.STOP)
            {
               break;
            }
            switch(_loc2_.id)
            {
               case TAG:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.tag = param1.readString();
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case VALUE:
                  if(_loc2_.type == TType.LIST)
                  {
                     _loc3_ = param1.readListBegin();
                     this.value = new Array();
                     _loc4_ = 0;
                     while(_loc4_ < _loc3_.size)
                     {
                        _loc5_ = new Task();
                        _loc5_.read(param1);
                        this.value.push(_loc5_);
                        _loc4_++;
                     }
                     param1.readListEnd();
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case EXCHANGE:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.exchange = param1.readString();
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case TOTAL:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.total = param1.readString();
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               default:
                  TProtocolUtil.skip(param1,_loc2_.type);
            }
            param1.readFieldEnd();
         }
         param1.readStructEnd();
         this.validate();
      }
      
      public function write(param1:TProtocol) : void
      {
         var _loc2_:* = undefined;
         this.validate();
         param1.writeStructBegin(STRUCT_DESC);
         if(this.tag != null)
         {
            param1.writeFieldBegin(TAG_FIELD_DESC);
            param1.writeString(this.tag);
            param1.writeFieldEnd();
         }
         if(this.value != null)
         {
            param1.writeFieldBegin(VALUE_FIELD_DESC);
            param1.writeListBegin(new TList(TType.STRUCT,this.value.length));
            for each(_loc2_ in this.value)
            {
               _loc2_.write(param1);
            }
            param1.writeListEnd();
            param1.writeFieldEnd();
         }
         if(this.exchange != null)
         {
            param1.writeFieldBegin(EXCHANGE_FIELD_DESC);
            param1.writeString(this.exchange);
            param1.writeFieldEnd();
         }
         if(this.total != null)
         {
            param1.writeFieldBegin(TOTAL_FIELD_DESC);
            param1.writeString(this.total);
            param1.writeFieldEnd();
         }
         param1.writeFieldStop();
         param1.writeStructEnd();
      }
      
      public function toString() : String
      {
         var _loc1_:String = new String("RES_TaskValue(");
         var _loc2_:Boolean = true;
         _loc1_ += "tag:";
         if(this.tag == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.tag;
         }
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "value:";
         if(this.value == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.value;
         }
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "exchange:";
         if(this.exchange == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.exchange;
         }
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "total:";
         if(this.total == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.total;
         }
         _loc2_ = false;
         return _loc1_ + ")";
      }
      
      public function validate() : void
      {
         if(this.tag == null)
         {
            throw new TProtocolError(TProtocolError.UNKNOWN,"Required field \'tag\' was not present! Struct: " + this.toString());
         }
      }
   }
}

