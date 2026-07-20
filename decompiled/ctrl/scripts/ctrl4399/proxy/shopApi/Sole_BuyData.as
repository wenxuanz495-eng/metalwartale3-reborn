package ctrl4399.proxy.shopApi
{
   import flash.utils.Dictionary;
   import org.apache.thrift.*;
   import org.apache.thrift.meta_data.*;
   import org.apache.thrift.protocol.*;
   
   public class Sole_BuyData implements TBase
   {
      
      private static const STRUCT_DESC:TStruct = new TStruct("Sole_BuyData");
      
      private static const REMAINING_FIELD_DESC:TField = new TField("remaining",TType.I32,1);
      
      private static const PROP_ID_FIELD_DESC:TField = new TField("propId",TType.STRING,2);
      
      private static const COUNT_FIELD_DESC:TField = new TField("count",TType.I32,3);
      
      private static const TAG_FIELD_DESC:TField = new TField("tag",TType.STRING,4);
      
      public static const REMAINING:int = 1;
      
      public static const PROPID:int = 2;
      
      public static const COUNT:int = 3;
      
      public static const TAG:int = 4;
      
      public static const metaDataMap:Dictionary = new Dictionary();
      
      metaDataMap[REMAINING] = new FieldMetaData("remaining",TFieldRequirementType.REQUIRED,new FieldValueMetaData(TType.I32));
      metaDataMap[PROPID] = new FieldMetaData("propId",TFieldRequirementType.REQUIRED,new FieldValueMetaData(TType.STRING));
      metaDataMap[COUNT] = new FieldMetaData("count",TFieldRequirementType.REQUIRED,new FieldValueMetaData(TType.I32));
      metaDataMap[TAG] = new FieldMetaData("tag",TFieldRequirementType.OPTIONAL,new FieldValueMetaData(TType.STRING));
      FieldMetaData.addStructMetaDataMap(Sole_BuyData,metaDataMap);
      
      private var _remaining:int;
      
      private var _propId:String;
      
      private var _count:int;
      
      private var _tag:String;
      
      private var __isset_remaining:Boolean = false;
      
      private var __isset_count:Boolean = false;
      
      public function Sole_BuyData()
      {
         super();
      }
      
      public function get remaining() : int
      {
         return this._remaining;
      }
      
      public function set remaining(param1:int) : void
      {
         this._remaining = param1;
         this.__isset_remaining = true;
      }
      
      public function unsetRemaining() : void
      {
         this.__isset_remaining = false;
      }
      
      public function isSetRemaining() : Boolean
      {
         return this.__isset_remaining;
      }
      
      public function get propId() : String
      {
         return this._propId;
      }
      
      public function set propId(param1:String) : void
      {
         this._propId = param1;
      }
      
      public function unsetPropId() : void
      {
         this.propId = null;
      }
      
      public function isSetPropId() : Boolean
      {
         return this.propId != null;
      }
      
      public function get count() : int
      {
         return this._count;
      }
      
      public function set count(param1:int) : void
      {
         this._count = param1;
         this.__isset_count = true;
      }
      
      public function unsetCount() : void
      {
         this.__isset_count = false;
      }
      
      public function isSetCount() : Boolean
      {
         return this.__isset_count;
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
      
      public function setFieldValue(param1:int, param2:*) : void
      {
         switch(param1)
         {
            case REMAINING:
               if(param2 == null)
               {
                  this.unsetRemaining();
               }
               else
               {
                  this.remaining = param2;
               }
               break;
            case PROPID:
               if(param2 == null)
               {
                  this.unsetPropId();
               }
               else
               {
                  this.propId = param2;
               }
               break;
            case COUNT:
               if(param2 == null)
               {
                  this.unsetCount();
               }
               else
               {
                  this.count = param2;
               }
               break;
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
            default:
               throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
         }
      }
      
      public function getFieldValue(param1:int) : *
      {
         switch(param1)
         {
            case REMAINING:
               return this.remaining;
            case PROPID:
               return this.propId;
            case COUNT:
               return this.count;
            case TAG:
               return this.tag;
            default:
               throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
         }
      }
      
      public function isSet(param1:int) : Boolean
      {
         switch(param1)
         {
            case REMAINING:
               return this.isSetRemaining();
            case PROPID:
               return this.isSetPropId();
            case COUNT:
               return this.isSetCount();
            case TAG:
               return this.isSetTag();
            default:
               throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
         }
      }
      
      public function read(param1:TProtocol) : void
      {
         var _loc2_:TField = null;
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
               case REMAINING:
                  if(_loc2_.type == TType.I32)
                  {
                     this.remaining = param1.readI32();
                     this.__isset_remaining = true;
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case PROPID:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.propId = param1.readString();
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case COUNT:
                  if(_loc2_.type == TType.I32)
                  {
                     this.count = param1.readI32();
                     this.__isset_count = true;
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
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
               default:
                  TProtocolUtil.skip(param1,_loc2_.type);
            }
            param1.readFieldEnd();
         }
         param1.readStructEnd();
         if(!this.__isset_remaining)
         {
            throw new TProtocolError(TProtocolError.UNKNOWN,"Required field \'remaining\' was not found in serialized data! Struct: " + this.toString());
         }
         if(!this.__isset_count)
         {
            throw new TProtocolError(TProtocolError.UNKNOWN,"Required field \'count\' was not found in serialized data! Struct: " + this.toString());
         }
         this.validate();
      }
      
      public function write(param1:TProtocol) : void
      {
         this.validate();
         param1.writeStructBegin(STRUCT_DESC);
         param1.writeFieldBegin(REMAINING_FIELD_DESC);
         param1.writeI32(this.remaining);
         param1.writeFieldEnd();
         if(this.propId != null)
         {
            param1.writeFieldBegin(PROP_ID_FIELD_DESC);
            param1.writeString(this.propId);
            param1.writeFieldEnd();
         }
         param1.writeFieldBegin(COUNT_FIELD_DESC);
         param1.writeI32(this.count);
         param1.writeFieldEnd();
         if(this.tag != null)
         {
            param1.writeFieldBegin(TAG_FIELD_DESC);
            param1.writeString(this.tag);
            param1.writeFieldEnd();
         }
         param1.writeFieldStop();
         param1.writeStructEnd();
      }
      
      public function toString() : String
      {
         var _loc1_:String = new String("Sole_BuyData(");
         var _loc2_:Boolean = true;
         _loc1_ += "remaining:";
         _loc1_ += this.remaining;
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "propId:";
         if(this.propId == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.propId;
         }
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "count:";
         _loc1_ += this.count;
         _loc2_ = false;
         if(this.isSetTag())
         {
            if(!_loc2_)
            {
               _loc1_ += ", ";
            }
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
         }
         return _loc1_ + ")";
      }
      
      public function validate() : void
      {
         if(this.propId == null)
         {
            throw new TProtocolError(TProtocolError.UNKNOWN,"Required field \'propId\' was not present! Struct: " + this.toString());
         }
      }
   }
}

