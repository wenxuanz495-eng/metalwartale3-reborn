package ctrl4399.proxy.shopApi
{
   import flash.utils.Dictionary;
   import org.apache.thrift.*;
   import org.apache.thrift.meta_data.*;
   import org.apache.thrift.protocol.*;
   
   public class ActionInfo implements TBase
   {
      
      private static const STRUCT_DESC:TStruct = new TStruct("ActionInfo");
      
      private static const TYPE_FIELD_DESC:TField = new TField("type",TType.I32,1);
      
      private static const STATE_FIELD_DESC:TField = new TField("state",TType.I32,2);
      
      private static const COUNT_FIELD_DESC:TField = new TField("count",TType.I32,3);
      
      private static const SURPLUS_COUNT_FIELD_DESC:TField = new TField("surplusCount",TType.I32,4);
      
      private static const START_DATE_FIELD_DESC:TField = new TField("startDate",TType.I32,5);
      
      private static const END_DATE_FIELD_DESC:TField = new TField("endDate",TType.I32,6);
      
      private static const RATE_FIELD_DESC:TField = new TField("rate",TType.DOUBLE,7);
      
      private static const NATIVE_PRICE_FIELD_DESC:TField = new TField("nativePrice",TType.I32,8);
      
      public static const TYPE:int = 1;
      
      public static const STATE:int = 2;
      
      public static const COUNT:int = 3;
      
      public static const SURPLUSCOUNT:int = 4;
      
      public static const STARTDATE:int = 5;
      
      public static const ENDDATE:int = 6;
      
      public static const RATE:int = 7;
      
      public static const NATIVEPRICE:int = 8;
      
      public static const metaDataMap:Dictionary = new Dictionary();
      
      metaDataMap[TYPE] = new FieldMetaData("type",TFieldRequirementType.OPTIONAL,new FieldValueMetaData(TType.I32));
      metaDataMap[STATE] = new FieldMetaData("state",TFieldRequirementType.OPTIONAL,new FieldValueMetaData(TType.I32));
      metaDataMap[COUNT] = new FieldMetaData("count",TFieldRequirementType.OPTIONAL,new FieldValueMetaData(TType.I32));
      metaDataMap[SURPLUSCOUNT] = new FieldMetaData("surplusCount",TFieldRequirementType.OPTIONAL,new FieldValueMetaData(TType.I32));
      metaDataMap[STARTDATE] = new FieldMetaData("startDate",TFieldRequirementType.OPTIONAL,new FieldValueMetaData(TType.I32));
      metaDataMap[ENDDATE] = new FieldMetaData("endDate",TFieldRequirementType.OPTIONAL,new FieldValueMetaData(TType.I32));
      metaDataMap[RATE] = new FieldMetaData("rate",TFieldRequirementType.OPTIONAL,new FieldValueMetaData(TType.DOUBLE));
      metaDataMap[NATIVEPRICE] = new FieldMetaData("nativePrice",TFieldRequirementType.OPTIONAL,new FieldValueMetaData(TType.I32));
      FieldMetaData.addStructMetaDataMap(ActionInfo,metaDataMap);
      
      private var _type:int;
      
      private var _state:int;
      
      private var _count:int;
      
      private var _surplusCount:int;
      
      private var _startDate:int;
      
      private var _endDate:int;
      
      private var _rate:Number;
      
      private var _nativePrice:int;
      
      private var __isset_type:Boolean = false;
      
      private var __isset_state:Boolean = false;
      
      private var __isset_count:Boolean = false;
      
      private var __isset_surplusCount:Boolean = false;
      
      private var __isset_startDate:Boolean = false;
      
      private var __isset_endDate:Boolean = false;
      
      private var __isset_rate:Boolean = false;
      
      private var __isset_nativePrice:Boolean = false;
      
      public function ActionInfo()
      {
         super();
      }
      
      public function get type() : int
      {
         return this._type;
      }
      
      public function set type(param1:int) : void
      {
         this._type = param1;
         this.__isset_type = true;
      }
      
      public function unsetType() : void
      {
         this.__isset_type = false;
      }
      
      public function isSetType() : Boolean
      {
         return this.__isset_type;
      }
      
      public function get state() : int
      {
         return this._state;
      }
      
      public function set state(param1:int) : void
      {
         this._state = param1;
         this.__isset_state = true;
      }
      
      public function unsetState() : void
      {
         this.__isset_state = false;
      }
      
      public function isSetState() : Boolean
      {
         return this.__isset_state;
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
      
      public function get surplusCount() : int
      {
         return this._surplusCount;
      }
      
      public function set surplusCount(param1:int) : void
      {
         this._surplusCount = param1;
         this.__isset_surplusCount = true;
      }
      
      public function unsetSurplusCount() : void
      {
         this.__isset_surplusCount = false;
      }
      
      public function isSetSurplusCount() : Boolean
      {
         return this.__isset_surplusCount;
      }
      
      public function get startDate() : int
      {
         return this._startDate;
      }
      
      public function set startDate(param1:int) : void
      {
         this._startDate = param1;
         this.__isset_startDate = true;
      }
      
      public function unsetStartDate() : void
      {
         this.__isset_startDate = false;
      }
      
      public function isSetStartDate() : Boolean
      {
         return this.__isset_startDate;
      }
      
      public function get endDate() : int
      {
         return this._endDate;
      }
      
      public function set endDate(param1:int) : void
      {
         this._endDate = param1;
         this.__isset_endDate = true;
      }
      
      public function unsetEndDate() : void
      {
         this.__isset_endDate = false;
      }
      
      public function isSetEndDate() : Boolean
      {
         return this.__isset_endDate;
      }
      
      public function get rate() : Number
      {
         return this._rate;
      }
      
      public function set rate(param1:Number) : void
      {
         this._rate = param1;
         this.__isset_rate = true;
      }
      
      public function unsetRate() : void
      {
         this.__isset_rate = false;
      }
      
      public function isSetRate() : Boolean
      {
         return this.__isset_rate;
      }
      
      public function get nativePrice() : int
      {
         return this._nativePrice;
      }
      
      public function set nativePrice(param1:int) : void
      {
         this._nativePrice = param1;
         this.__isset_nativePrice = true;
      }
      
      public function unsetNativePrice() : void
      {
         this.__isset_nativePrice = false;
      }
      
      public function isSetNativePrice() : Boolean
      {
         return this.__isset_nativePrice;
      }
      
      public function setFieldValue(param1:int, param2:*) : void
      {
         switch(param1)
         {
            case TYPE:
               if(param2 == null)
               {
                  this.unsetType();
               }
               else
               {
                  this.type = param2;
               }
               break;
            case STATE:
               if(param2 == null)
               {
                  this.unsetState();
               }
               else
               {
                  this.state = param2;
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
            case SURPLUSCOUNT:
               if(param2 == null)
               {
                  this.unsetSurplusCount();
               }
               else
               {
                  this.surplusCount = param2;
               }
               break;
            case STARTDATE:
               if(param2 == null)
               {
                  this.unsetStartDate();
               }
               else
               {
                  this.startDate = param2;
               }
               break;
            case ENDDATE:
               if(param2 == null)
               {
                  this.unsetEndDate();
               }
               else
               {
                  this.endDate = param2;
               }
               break;
            case RATE:
               if(param2 == null)
               {
                  this.unsetRate();
               }
               else
               {
                  this.rate = param2;
               }
               break;
            case NATIVEPRICE:
               if(param2 == null)
               {
                  this.unsetNativePrice();
               }
               else
               {
                  this.nativePrice = param2;
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
            case TYPE:
               return this.type;
            case STATE:
               return this.state;
            case COUNT:
               return this.count;
            case SURPLUSCOUNT:
               return this.surplusCount;
            case STARTDATE:
               return this.startDate;
            case ENDDATE:
               return this.endDate;
            case RATE:
               return this.rate;
            case NATIVEPRICE:
               return this.nativePrice;
            default:
               throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
         }
      }
      
      public function isSet(param1:int) : Boolean
      {
         switch(param1)
         {
            case TYPE:
               return this.isSetType();
            case STATE:
               return this.isSetState();
            case COUNT:
               return this.isSetCount();
            case SURPLUSCOUNT:
               return this.isSetSurplusCount();
            case STARTDATE:
               return this.isSetStartDate();
            case ENDDATE:
               return this.isSetEndDate();
            case RATE:
               return this.isSetRate();
            case NATIVEPRICE:
               return this.isSetNativePrice();
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
               case TYPE:
                  if(_loc2_.type == TType.I32)
                  {
                     this.type = param1.readI32();
                     this.__isset_type = true;
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case STATE:
                  if(_loc2_.type == TType.I32)
                  {
                     this.state = param1.readI32();
                     this.__isset_state = true;
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
               case SURPLUSCOUNT:
                  if(_loc2_.type == TType.I32)
                  {
                     this.surplusCount = param1.readI32();
                     this.__isset_surplusCount = true;
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case STARTDATE:
                  if(_loc2_.type == TType.I32)
                  {
                     this.startDate = param1.readI32();
                     this.__isset_startDate = true;
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case ENDDATE:
                  if(_loc2_.type == TType.I32)
                  {
                     this.endDate = param1.readI32();
                     this.__isset_endDate = true;
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case RATE:
                  if(_loc2_.type == TType.DOUBLE)
                  {
                     this.rate = param1.readDouble();
                     this.__isset_rate = true;
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case NATIVEPRICE:
                  if(_loc2_.type == TType.I32)
                  {
                     this.nativePrice = param1.readI32();
                     this.__isset_nativePrice = true;
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
         this.validate();
         param1.writeStructBegin(STRUCT_DESC);
         param1.writeFieldBegin(TYPE_FIELD_DESC);
         param1.writeI32(this.type);
         param1.writeFieldEnd();
         param1.writeFieldBegin(STATE_FIELD_DESC);
         param1.writeI32(this.state);
         param1.writeFieldEnd();
         param1.writeFieldBegin(COUNT_FIELD_DESC);
         param1.writeI32(this.count);
         param1.writeFieldEnd();
         param1.writeFieldBegin(SURPLUS_COUNT_FIELD_DESC);
         param1.writeI32(this.surplusCount);
         param1.writeFieldEnd();
         param1.writeFieldBegin(START_DATE_FIELD_DESC);
         param1.writeI32(this.startDate);
         param1.writeFieldEnd();
         param1.writeFieldBegin(END_DATE_FIELD_DESC);
         param1.writeI32(this.endDate);
         param1.writeFieldEnd();
         param1.writeFieldBegin(RATE_FIELD_DESC);
         param1.writeDouble(this.rate);
         param1.writeFieldEnd();
         param1.writeFieldBegin(NATIVE_PRICE_FIELD_DESC);
         param1.writeI32(this.nativePrice);
         param1.writeFieldEnd();
         param1.writeFieldStop();
         param1.writeStructEnd();
      }
      
      public function toString() : String
      {
         var _loc1_:String = new String("ActionInfo(");
         var _loc2_:Boolean = true;
         if(this.isSetType())
         {
            _loc1_ += "type:";
            _loc1_ += this.type;
            _loc2_ = false;
         }
         if(this.isSetState())
         {
            if(!_loc2_)
            {
               _loc1_ += ", ";
            }
            _loc1_ += "state:";
            _loc1_ += this.state;
            _loc2_ = false;
         }
         if(this.isSetCount())
         {
            if(!_loc2_)
            {
               _loc1_ += ", ";
            }
            _loc1_ += "count:";
            _loc1_ += this.count;
            _loc2_ = false;
         }
         if(this.isSetSurplusCount())
         {
            if(!_loc2_)
            {
               _loc1_ += ", ";
            }
            _loc1_ += "surplusCount:";
            _loc1_ += this.surplusCount;
            _loc2_ = false;
         }
         if(this.isSetStartDate())
         {
            if(!_loc2_)
            {
               _loc1_ += ", ";
            }
            _loc1_ += "startDate:";
            _loc1_ += this.startDate;
            _loc2_ = false;
         }
         if(this.isSetEndDate())
         {
            if(!_loc2_)
            {
               _loc1_ += ", ";
            }
            _loc1_ += "endDate:";
            _loc1_ += this.endDate;
            _loc2_ = false;
         }
         if(this.isSetRate())
         {
            if(!_loc2_)
            {
               _loc1_ += ", ";
            }
            _loc1_ += "rate:";
            _loc1_ += this.rate;
            _loc2_ = false;
         }
         if(this.isSetNativePrice())
         {
            if(!_loc2_)
            {
               _loc1_ += ", ";
            }
            _loc1_ += "nativePrice:";
            _loc1_ += this.nativePrice;
            _loc2_ = false;
         }
         return _loc1_ + ")";
      }
      
      public function validate() : void
      {
      }
   }
}

