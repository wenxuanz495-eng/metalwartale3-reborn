package ctrl4399.proxy.shopApi
{
   import flash.utils.Dictionary;
   import org.apache.thrift.*;
   import org.apache.thrift.meta_data.*;
   import org.apache.thrift.protocol.*;
   
   public class PropInfo implements TBase
   {
      
      private static const STRUCT_DESC:TStruct = new TStruct("PropInfo");
      
      private static const PROP_ID_FIELD_DESC:TField = new TField("propId",TType.STRING,1);
      
      private static const PROP_COUNT_FIELD_DESC:TField = new TField("propCount",TType.I32,2);
      
      private static const PROP_PRICE_FIELD_DESC:TField = new TField("propPrice",TType.I32,3);
      
      private static const TAG_FIELD_DESC:TField = new TField("tag",TType.STRING,4);
      
      public static const PROPID:int = 1;
      
      public static const PROPCOUNT:int = 2;
      
      public static const PROPPRICE:int = 3;
      
      public static const TAG:int = 4;
      
      public static const metaDataMap:Dictionary = new Dictionary();
      
      metaDataMap[PROPID] = new FieldMetaData("propId",TFieldRequirementType.REQUIRED,new FieldValueMetaData(TType.STRING));
      metaDataMap[PROPCOUNT] = new FieldMetaData("propCount",TFieldRequirementType.REQUIRED,new FieldValueMetaData(TType.I32));
      metaDataMap[PROPPRICE] = new FieldMetaData("propPrice",TFieldRequirementType.OPTIONAL,new FieldValueMetaData(TType.I32));
      metaDataMap[TAG] = new FieldMetaData("tag",TFieldRequirementType.OPTIONAL,new FieldValueMetaData(TType.STRING));
      FieldMetaData.addStructMetaDataMap(PropInfo,metaDataMap);
      
      private var _propId:String;
      
      private var _propCount:int;
      
      private var _propPrice:int;
      
      private var _tag:String;
      
      private var __isset_propCount:Boolean = false;
      
      private var __isset_propPrice:Boolean = false;
      
      public function PropInfo()
      {
         super();
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
      
      public function get propCount() : int
      {
         return this._propCount;
      }
      
      public function set propCount(param1:int) : void
      {
         this._propCount = param1;
         this.__isset_propCount = true;
      }
      
      public function unsetPropCount() : void
      {
         this.__isset_propCount = false;
      }
      
      public function isSetPropCount() : Boolean
      {
         return this.__isset_propCount;
      }
      
      public function get propPrice() : int
      {
         return this._propPrice;
      }
      
      public function set propPrice(param1:int) : void
      {
         this._propPrice = param1;
         this.__isset_propPrice = true;
      }
      
      public function unsetPropPrice() : void
      {
         this.__isset_propPrice = false;
      }
      
      public function isSetPropPrice() : Boolean
      {
         return this.__isset_propPrice;
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
            case PROPCOUNT:
               if(param2 == null)
               {
                  this.unsetPropCount();
               }
               else
               {
                  this.propCount = param2;
               }
               break;
            case PROPPRICE:
               if(param2 == null)
               {
                  this.unsetPropPrice();
               }
               else
               {
                  this.propPrice = param2;
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
            case PROPID:
               return this.propId;
            case PROPCOUNT:
               return this.propCount;
            case PROPPRICE:
               return this.propPrice;
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
            case PROPID:
               return this.isSetPropId();
            case PROPCOUNT:
               return this.isSetPropCount();
            case PROPPRICE:
               return this.isSetPropPrice();
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
               case PROPCOUNT:
                  if(_loc2_.type == TType.I32)
                  {
                     this.propCount = param1.readI32();
                     this.__isset_propCount = true;
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case PROPPRICE:
                  if(_loc2_.type == TType.I32)
                  {
                     this.propPrice = param1.readI32();
                     this.__isset_propPrice = true;
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
         if(!this.__isset_propCount)
         {
            throw new TProtocolError(TProtocolError.UNKNOWN,"Required field \'propCount\' was not found in serialized data! Struct: " + this.toString());
         }
         this.validate();
      }
      
      public function write(param1:TProtocol) : void
      {
         this.validate();
         param1.writeStructBegin(STRUCT_DESC);
         if(this.propId != null)
         {
            param1.writeFieldBegin(PROP_ID_FIELD_DESC);
            param1.writeString(this.propId);
            param1.writeFieldEnd();
         }
         param1.writeFieldBegin(PROP_COUNT_FIELD_DESC);
         param1.writeI32(this.propCount);
         param1.writeFieldEnd();
         param1.writeFieldBegin(PROP_PRICE_FIELD_DESC);
         param1.writeI32(this.propPrice);
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
         var _loc1_:String = new String("PropInfo(");
         var _loc2_:Boolean = true;
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
         _loc1_ += "propCount:";
         _loc1_ += this.propCount;
         _loc2_ = false;
         if(this.isSetPropPrice())
         {
            if(!_loc2_)
            {
               _loc1_ += ", ";
            }
            _loc1_ += "propPrice:";
            _loc1_ += this.propPrice;
            _loc2_ = false;
         }
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

