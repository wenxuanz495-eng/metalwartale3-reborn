package ctrl4399.proxy.shopApi
{
   import flash.utils.Dictionary;
   import org.apache.thrift.*;
   import org.apache.thrift.meta_data.*;
   import org.apache.thrift.protocol.*;
   
   public class Sole_PropList implements TBase
   {
      
      private static const STRUCT_DESC:TStruct = new TStruct("Sole_PropList");
      
      private static const ID_FIELD_DESC:TField = new TField("id",TType.STRING,1);
      
      private static const PRICE_FIELD_DESC:TField = new TField("price",TType.I32,2);
      
      private static const TYPE_FIELD_DESC:TField = new TField("type",TType.STRING,3);
      
      private static const ACTION_INFO_FIELD_DESC:TField = new TField("actionInfo",TType.STRUCT,4);
      
      public static const ID:int = 1;
      
      public static const PRICE:int = 2;
      
      public static const TYPE:int = 3;
      
      public static const ACTIONINFO:int = 4;
      
      public static const metaDataMap:Dictionary = new Dictionary();
      
      metaDataMap[ID] = new FieldMetaData("id",TFieldRequirementType.REQUIRED,new FieldValueMetaData(TType.STRING));
      metaDataMap[PRICE] = new FieldMetaData("price",TFieldRequirementType.REQUIRED,new FieldValueMetaData(TType.I32));
      metaDataMap[TYPE] = new FieldMetaData("type",TFieldRequirementType.REQUIRED,new FieldValueMetaData(TType.STRING));
      metaDataMap[ACTIONINFO] = new FieldMetaData("actionInfo",TFieldRequirementType.OPTIONAL,new StructMetaData(TType.STRUCT,ActionInfo));
      FieldMetaData.addStructMetaDataMap(Sole_PropList,metaDataMap);
      
      private var _id:String;
      
      private var _price:int;
      
      private var _type:String;
      
      private var _actionInfo:ActionInfo;
      
      private var __isset_price:Boolean = false;
      
      public function Sole_PropList()
      {
         super();
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function set id(param1:String) : void
      {
         this._id = param1;
      }
      
      public function unsetId() : void
      {
         this.id = null;
      }
      
      public function isSetId() : Boolean
      {
         return this.id != null;
      }
      
      public function get price() : int
      {
         return this._price;
      }
      
      public function set price(param1:int) : void
      {
         this._price = param1;
         this.__isset_price = true;
      }
      
      public function unsetPrice() : void
      {
         this.__isset_price = false;
      }
      
      public function isSetPrice() : Boolean
      {
         return this.__isset_price;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function set type(param1:String) : void
      {
         this._type = param1;
      }
      
      public function unsetType() : void
      {
         this.type = null;
      }
      
      public function isSetType() : Boolean
      {
         return this.type != null;
      }
      
      public function get actionInfo() : ActionInfo
      {
         return this._actionInfo;
      }
      
      public function set actionInfo(param1:ActionInfo) : void
      {
         this._actionInfo = param1;
      }
      
      public function unsetActionInfo() : void
      {
         this.actionInfo = null;
      }
      
      public function isSetActionInfo() : Boolean
      {
         return this.actionInfo != null;
      }
      
      public function setFieldValue(param1:int, param2:*) : void
      {
         switch(param1)
         {
            case ID:
               if(param2 == null)
               {
                  this.unsetId();
               }
               else
               {
                  this.id = param2;
               }
               break;
            case PRICE:
               if(param2 == null)
               {
                  this.unsetPrice();
               }
               else
               {
                  this.price = param2;
               }
               break;
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
            case ACTIONINFO:
               if(param2 == null)
               {
                  this.unsetActionInfo();
               }
               else
               {
                  this.actionInfo = param2;
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
            case ID:
               return this.id;
            case PRICE:
               return this.price;
            case TYPE:
               return this.type;
            case ACTIONINFO:
               return this.actionInfo;
            default:
               throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
         }
      }
      
      public function isSet(param1:int) : Boolean
      {
         switch(param1)
         {
            case ID:
               return this.isSetId();
            case PRICE:
               return this.isSetPrice();
            case TYPE:
               return this.isSetType();
            case ACTIONINFO:
               return this.isSetActionInfo();
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
               case ID:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.id = param1.readString();
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case PRICE:
                  if(_loc2_.type == TType.I32)
                  {
                     this.price = param1.readI32();
                     this.__isset_price = true;
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case TYPE:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.type = param1.readString();
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case ACTIONINFO:
                  if(_loc2_.type == TType.STRUCT)
                  {
                     this.actionInfo = new ActionInfo();
                     this.actionInfo.read(param1);
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
         if(!this.__isset_price)
         {
            throw new TProtocolError(TProtocolError.UNKNOWN,"Required field \'price\' was not found in serialized data! Struct: " + this.toString());
         }
         this.validate();
      }
      
      public function write(param1:TProtocol) : void
      {
         this.validate();
         param1.writeStructBegin(STRUCT_DESC);
         if(this.id != null)
         {
            param1.writeFieldBegin(ID_FIELD_DESC);
            param1.writeString(this.id);
            param1.writeFieldEnd();
         }
         param1.writeFieldBegin(PRICE_FIELD_DESC);
         param1.writeI32(this.price);
         param1.writeFieldEnd();
         if(this.type != null)
         {
            param1.writeFieldBegin(TYPE_FIELD_DESC);
            param1.writeString(this.type);
            param1.writeFieldEnd();
         }
         if(this.actionInfo != null)
         {
            param1.writeFieldBegin(ACTION_INFO_FIELD_DESC);
            this.actionInfo.write(param1);
            param1.writeFieldEnd();
         }
         param1.writeFieldStop();
         param1.writeStructEnd();
      }
      
      public function toString() : String
      {
         var _loc1_:String = new String("Sole_PropList(");
         var _loc2_:Boolean = true;
         _loc1_ += "id:";
         if(this.id == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.id;
         }
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "price:";
         _loc1_ += this.price;
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "type:";
         if(this.type == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.type;
         }
         _loc2_ = false;
         if(this.isSetActionInfo())
         {
            if(!_loc2_)
            {
               _loc1_ += ", ";
            }
            _loc1_ += "actionInfo:";
            if(this.actionInfo == null)
            {
               _loc1_ += "null";
            }
            else
            {
               _loc1_ += this.actionInfo;
            }
            _loc2_ = false;
         }
         return _loc1_ + ")";
      }
      
      public function validate() : void
      {
         if(this.id == null)
         {
            throw new TProtocolError(TProtocolError.UNKNOWN,"Required field \'id\' was not present! Struct: " + this.toString());
         }
         if(this.type == null)
         {
            throw new TProtocolError(TProtocolError.UNKNOWN,"Required field \'type\' was not present! Struct: " + this.toString());
         }
      }
   }
}

