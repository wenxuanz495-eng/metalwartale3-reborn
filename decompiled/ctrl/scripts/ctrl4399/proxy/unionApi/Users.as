package ctrl4399.proxy.unionApi
{
   import flash.utils.Dictionary;
   import org.apache.thrift.*;
   import org.apache.thrift.meta_data.*;
   import org.apache.thrift.protocol.*;
   
   public class Users implements TBase
   {
      
      private static const STRUCT_DESC:TStruct = new TStruct("Users");
      
      private static const UID_FIELD_DESC:TField = new TField("uid",TType.I32,1);
      
      private static const INDEX_FIELD_DESC:TField = new TField("index",TType.I32,2);
      
      public static const UID:int = 1;
      
      public static const INDEX:int = 2;
      
      public static const metaDataMap:Dictionary = new Dictionary();
      
      metaDataMap[UID] = new FieldMetaData("uid",TFieldRequirementType.REQUIRED,new FieldValueMetaData(TType.I32));
      metaDataMap[INDEX] = new FieldMetaData("index",TFieldRequirementType.REQUIRED,new FieldValueMetaData(TType.I32));
      FieldMetaData.addStructMetaDataMap(Users,metaDataMap);
      
      private var _uid:int;
      
      private var _index:int;
      
      private var __isset_uid:Boolean = false;
      
      private var __isset_index:Boolean = false;
      
      public function Users()
      {
         super();
      }
      
      public function get uid() : int
      {
         return this._uid;
      }
      
      public function set uid(param1:int) : void
      {
         this._uid = param1;
         this.__isset_uid = true;
      }
      
      public function unsetUid() : void
      {
         this.__isset_uid = false;
      }
      
      public function isSetUid() : Boolean
      {
         return this.__isset_uid;
      }
      
      public function get index() : int
      {
         return this._index;
      }
      
      public function set index(param1:int) : void
      {
         this._index = param1;
         this.__isset_index = true;
      }
      
      public function unsetIndex() : void
      {
         this.__isset_index = false;
      }
      
      public function isSetIndex() : Boolean
      {
         return this.__isset_index;
      }
      
      public function setFieldValue(param1:int, param2:*) : void
      {
         switch(param1)
         {
            case UID:
               if(param2 == null)
               {
                  this.unsetUid();
               }
               else
               {
                  this.uid = param2;
               }
               break;
            case INDEX:
               if(param2 == null)
               {
                  this.unsetIndex();
               }
               else
               {
                  this.index = param2;
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
            case UID:
               return this.uid;
            case INDEX:
               return this.index;
            default:
               throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
         }
      }
      
      public function isSet(param1:int) : Boolean
      {
         switch(param1)
         {
            case UID:
               return this.isSetUid();
            case INDEX:
               return this.isSetIndex();
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
               case UID:
                  if(_loc2_.type == TType.I32)
                  {
                     this.uid = param1.readI32();
                     this.__isset_uid = true;
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case INDEX:
                  if(_loc2_.type == TType.I32)
                  {
                     this.index = param1.readI32();
                     this.__isset_index = true;
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
         if(!this.__isset_uid)
         {
            throw new TProtocolError(TProtocolError.UNKNOWN,"Required field \'uid\' was not found in serialized data! Struct: " + this.toString());
         }
         if(!this.__isset_index)
         {
            throw new TProtocolError(TProtocolError.UNKNOWN,"Required field \'index\' was not found in serialized data! Struct: " + this.toString());
         }
         this.validate();
      }
      
      public function write(param1:TProtocol) : void
      {
         this.validate();
         param1.writeStructBegin(STRUCT_DESC);
         param1.writeFieldBegin(UID_FIELD_DESC);
         param1.writeI32(this.uid);
         param1.writeFieldEnd();
         param1.writeFieldBegin(INDEX_FIELD_DESC);
         param1.writeI32(this.index);
         param1.writeFieldEnd();
         param1.writeFieldStop();
         param1.writeStructEnd();
      }
      
      public function toString() : String
      {
         var _loc1_:String = new String("Users(");
         var _loc2_:Boolean = true;
         _loc1_ += "uid:";
         _loc1_ += this.uid;
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "index:";
         _loc1_ += this.index;
         _loc2_ = false;
         return _loc1_ + ")";
      }
      
      public function validate() : void
      {
      }
   }
}

