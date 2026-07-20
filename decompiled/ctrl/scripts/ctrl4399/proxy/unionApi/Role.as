package ctrl4399.proxy.unionApi
{
   import flash.utils.Dictionary;
   import org.apache.thrift.*;
   import org.apache.thrift.meta_data.*;
   import org.apache.thrift.protocol.*;
   
   public class Role implements TBase
   {
      
      private static const STRUCT_DESC:TStruct = new TStruct("Role");
      
      private static const ID_FIELD_DESC:TField = new TField("id",TType.I32,1);
      
      private static const NAME_FIELD_DESC:TField = new TField("name",TType.STRING,2);
      
      private static const PRIVILEGE_LIST_FIELD_DESC:TField = new TField("privilegeList",TType.STRING,3);
      
      private static const CREATE_TIME_FIELD_DESC:TField = new TField("create_time",TType.I32,4);
      
      private static const MEMO_FIELD_DESC:TField = new TField("memo",TType.STRING,5);
      
      public static const ID:int = 1;
      
      public static const NAME:int = 2;
      
      public static const PRIVILEGELIST:int = 3;
      
      public static const CREATE_TIME:int = 4;
      
      public static const MEMO:int = 5;
      
      public static const metaDataMap:Dictionary = new Dictionary();
      
      metaDataMap[ID] = new FieldMetaData("id",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
      metaDataMap[NAME] = new FieldMetaData("name",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[PRIVILEGELIST] = new FieldMetaData("privilegeList",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[CREATE_TIME] = new FieldMetaData("create_time",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
      metaDataMap[MEMO] = new FieldMetaData("memo",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      FieldMetaData.addStructMetaDataMap(Role,metaDataMap);
      
      private var _id:int;
      
      private var _name:String;
      
      private var _privilegeList:String;
      
      private var _create_time:int;
      
      private var _memo:String;
      
      private var __isset_id:Boolean = false;
      
      private var __isset_create_time:Boolean = false;
      
      public function Role()
      {
         super();
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function set id(param1:int) : void
      {
         this._id = param1;
         this.__isset_id = true;
      }
      
      public function unsetId() : void
      {
         this.__isset_id = false;
      }
      
      public function isSetId() : Boolean
      {
         return this.__isset_id;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(param1:String) : void
      {
         this._name = param1;
      }
      
      public function unsetName() : void
      {
         this.name = null;
      }
      
      public function isSetName() : Boolean
      {
         return this.name != null;
      }
      
      public function get privilegeList() : String
      {
         return this._privilegeList;
      }
      
      public function set privilegeList(param1:String) : void
      {
         this._privilegeList = param1;
      }
      
      public function unsetPrivilegeList() : void
      {
         this.privilegeList = null;
      }
      
      public function isSetPrivilegeList() : Boolean
      {
         return this.privilegeList != null;
      }
      
      public function get create_time() : int
      {
         return this._create_time;
      }
      
      public function set create_time(param1:int) : void
      {
         this._create_time = param1;
         this.__isset_create_time = true;
      }
      
      public function unsetCreate_time() : void
      {
         this.__isset_create_time = false;
      }
      
      public function isSetCreate_time() : Boolean
      {
         return this.__isset_create_time;
      }
      
      public function get memo() : String
      {
         return this._memo;
      }
      
      public function set memo(param1:String) : void
      {
         this._memo = param1;
      }
      
      public function unsetMemo() : void
      {
         this.memo = null;
      }
      
      public function isSetMemo() : Boolean
      {
         return this.memo != null;
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
            case NAME:
               if(param2 == null)
               {
                  this.unsetName();
               }
               else
               {
                  this.name = param2;
               }
               break;
            case PRIVILEGELIST:
               if(param2 == null)
               {
                  this.unsetPrivilegeList();
               }
               else
               {
                  this.privilegeList = param2;
               }
               break;
            case CREATE_TIME:
               if(param2 == null)
               {
                  this.unsetCreate_time();
               }
               else
               {
                  this.create_time = param2;
               }
               break;
            case MEMO:
               if(param2 == null)
               {
                  this.unsetMemo();
               }
               else
               {
                  this.memo = param2;
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
            case NAME:
               return this.name;
            case PRIVILEGELIST:
               return this.privilegeList;
            case CREATE_TIME:
               return this.create_time;
            case MEMO:
               return this.memo;
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
            case NAME:
               return this.isSetName();
            case PRIVILEGELIST:
               return this.isSetPrivilegeList();
            case CREATE_TIME:
               return this.isSetCreate_time();
            case MEMO:
               return this.isSetMemo();
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
                  if(_loc2_.type == TType.I32)
                  {
                     this.id = param1.readI32();
                     this.__isset_id = true;
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case NAME:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.name = param1.readString();
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case PRIVILEGELIST:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.privilegeList = param1.readString();
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case CREATE_TIME:
                  if(_loc2_.type == TType.I32)
                  {
                     this.create_time = param1.readI32();
                     this.__isset_create_time = true;
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case MEMO:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.memo = param1.readString();
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
         param1.writeFieldBegin(ID_FIELD_DESC);
         param1.writeI32(this.id);
         param1.writeFieldEnd();
         if(this.name != null)
         {
            param1.writeFieldBegin(NAME_FIELD_DESC);
            param1.writeString(this.name);
            param1.writeFieldEnd();
         }
         if(this.privilegeList != null)
         {
            param1.writeFieldBegin(PRIVILEGE_LIST_FIELD_DESC);
            param1.writeString(this.privilegeList);
            param1.writeFieldEnd();
         }
         param1.writeFieldBegin(CREATE_TIME_FIELD_DESC);
         param1.writeI32(this.create_time);
         param1.writeFieldEnd();
         if(this.memo != null)
         {
            param1.writeFieldBegin(MEMO_FIELD_DESC);
            param1.writeString(this.memo);
            param1.writeFieldEnd();
         }
         param1.writeFieldStop();
         param1.writeStructEnd();
      }
      
      public function toString() : String
      {
         var _loc1_:String = new String("Role(");
         var _loc2_:Boolean = true;
         _loc1_ += "id:";
         _loc1_ += this.id;
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "name:";
         if(this.name == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.name;
         }
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "privilegeList:";
         if(this.privilegeList == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.privilegeList;
         }
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "create_time:";
         _loc1_ += this.create_time;
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "memo:";
         if(this.memo == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.memo;
         }
         _loc2_ = false;
         return _loc1_ + ")";
      }
      
      public function validate() : void
      {
      }
   }
}

