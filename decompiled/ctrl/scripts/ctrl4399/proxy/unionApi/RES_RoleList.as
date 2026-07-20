package ctrl4399.proxy.unionApi
{
   import flash.utils.Dictionary;
   import org.apache.thrift.*;
   import org.apache.thrift.meta_data.*;
   import org.apache.thrift.protocol.*;
   
   public class RES_RoleList implements TBase
   {
      
      private static const STRUCT_DESC:TStruct = new TStruct("RES_RoleList");
      
      private static const TAG_FIELD_DESC:TField = new TField("tag",TType.STRING,1);
      
      private static const ROLE_LIST_FIELD_DESC:TField = new TField("roleList",TType.LIST,2);
      
      private static const COUNT_FIELD_DESC:TField = new TField("count",TType.STRING,3);
      
      public static const TAG:int = 1;
      
      public static const ROLELIST:int = 2;
      
      public static const COUNT:int = 3;
      
      public static const metaDataMap:Dictionary = new Dictionary();
      
      metaDataMap[TAG] = new FieldMetaData("tag",TFieldRequirementType.REQUIRED,new FieldValueMetaData(TType.STRING));
      metaDataMap[ROLELIST] = new FieldMetaData("roleList",TFieldRequirementType.DEFAULT,new ListMetaData(TType.LIST,new StructMetaData(TType.STRUCT,Role)));
      metaDataMap[COUNT] = new FieldMetaData("count",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      FieldMetaData.addStructMetaDataMap(RES_RoleList,metaDataMap);
      
      private var _tag:String;
      
      private var _roleList:Array;
      
      private var _count:String;
      
      public function RES_RoleList()
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
      
      public function get roleList() : Array
      {
         return this._roleList;
      }
      
      public function set roleList(param1:Array) : void
      {
         this._roleList = param1;
      }
      
      public function unsetRoleList() : void
      {
         this.roleList = null;
      }
      
      public function isSetRoleList() : Boolean
      {
         return this.roleList != null;
      }
      
      public function get count() : String
      {
         return this._count;
      }
      
      public function set count(param1:String) : void
      {
         this._count = param1;
      }
      
      public function unsetCount() : void
      {
         this.count = null;
      }
      
      public function isSetCount() : Boolean
      {
         return this.count != null;
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
            case ROLELIST:
               if(param2 == null)
               {
                  this.unsetRoleList();
               }
               else
               {
                  this.roleList = param2;
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
            case ROLELIST:
               return this.roleList;
            case COUNT:
               return this.count;
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
            case ROLELIST:
               return this.isSetRoleList();
            case COUNT:
               return this.isSetCount();
            default:
               throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
         }
      }
      
      public function read(param1:TProtocol) : void
      {
         var _loc2_:TField = null;
         var _loc3_:TList = null;
         var _loc4_:int = 0;
         var _loc5_:Role = null;
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
               case ROLELIST:
                  if(_loc2_.type == TType.LIST)
                  {
                     _loc3_ = param1.readListBegin();
                     this.roleList = new Array();
                     _loc4_ = 0;
                     while(_loc4_ < _loc3_.size)
                     {
                        _loc5_ = new Role();
                        _loc5_.read(param1);
                        this.roleList.push(_loc5_);
                        _loc4_++;
                     }
                     param1.readListEnd();
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case COUNT:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.count = param1.readString();
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
         if(this.roleList != null)
         {
            param1.writeFieldBegin(ROLE_LIST_FIELD_DESC);
            param1.writeListBegin(new TList(TType.STRUCT,this.roleList.length));
            for each(_loc2_ in this.roleList)
            {
               _loc2_.write(param1);
            }
            param1.writeListEnd();
            param1.writeFieldEnd();
         }
         if(this.count != null)
         {
            param1.writeFieldBegin(COUNT_FIELD_DESC);
            param1.writeString(this.count);
            param1.writeFieldEnd();
         }
         param1.writeFieldStop();
         param1.writeStructEnd();
      }
      
      public function toString() : String
      {
         var _loc1_:String = new String("RES_RoleList(");
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
         _loc1_ += "roleList:";
         if(this.roleList == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.roleList;
         }
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "count:";
         if(this.count == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.count;
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

