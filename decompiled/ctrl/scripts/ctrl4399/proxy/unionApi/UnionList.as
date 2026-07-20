package ctrl4399.proxy.unionApi
{
   import flash.utils.Dictionary;
   import org.apache.thrift.*;
   import org.apache.thrift.meta_data.*;
   import org.apache.thrift.protocol.*;
   
   public class UnionList implements TBase
   {
      
      private static const STRUCT_DESC:TStruct = new TStruct("UnionList");
      
      private static const UNION_ID_FIELD_DESC:TField = new TField("unionId",TType.I32,1);
      
      private static const TITLE_FIELD_DESC:TField = new TField("title",TType.STRING,2);
      
      private static const USERNAME_FIELD_DESC:TField = new TField("username",TType.STRING,3);
      
      private static const LEVEL_FIELD_DESC:TField = new TField("level",TType.I32,4);
      
      private static const COUNT_FIELD_DESC:TField = new TField("count",TType.STRING,5);
      
      private static const EXTRA_FIELD_DESC:TField = new TField("extra",TType.STRING,6);
      
      private static const EXPERIENCE_FIELD_DESC:TField = new TField("experience",TType.I32,7);
      
      public static const UNIONID:int = 1;
      
      public static const TITLE:int = 2;
      
      public static const USERNAME:int = 3;
      
      public static const LEVEL:int = 4;
      
      public static const COUNT:int = 5;
      
      public static const EXTRA:int = 6;
      
      public static const EXPERIENCE:int = 7;
      
      public static const metaDataMap:Dictionary = new Dictionary();
      
      metaDataMap[UNIONID] = new FieldMetaData("unionId",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
      metaDataMap[TITLE] = new FieldMetaData("title",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[USERNAME] = new FieldMetaData("username",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[LEVEL] = new FieldMetaData("level",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
      metaDataMap[COUNT] = new FieldMetaData("count",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[EXTRA] = new FieldMetaData("extra",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[EXPERIENCE] = new FieldMetaData("experience",TFieldRequirementType.OPTIONAL,new FieldValueMetaData(TType.I32));
      FieldMetaData.addStructMetaDataMap(UnionList,metaDataMap);
      
      private var _unionId:int;
      
      private var _title:String;
      
      private var _username:String;
      
      private var _level:int;
      
      private var _count:String;
      
      private var _extra:String;
      
      private var _experience:int;
      
      private var __isset_unionId:Boolean = false;
      
      private var __isset_level:Boolean = false;
      
      private var __isset_experience:Boolean = false;
      
      public function UnionList()
      {
         super();
      }
      
      public function get unionId() : int
      {
         return this._unionId;
      }
      
      public function set unionId(param1:int) : void
      {
         this._unionId = param1;
         this.__isset_unionId = true;
      }
      
      public function unsetUnionId() : void
      {
         this.__isset_unionId = false;
      }
      
      public function isSetUnionId() : Boolean
      {
         return this.__isset_unionId;
      }
      
      public function get title() : String
      {
         return this._title;
      }
      
      public function set title(param1:String) : void
      {
         this._title = param1;
      }
      
      public function unsetTitle() : void
      {
         this.title = null;
      }
      
      public function isSetTitle() : Boolean
      {
         return this.title != null;
      }
      
      public function get username() : String
      {
         return this._username;
      }
      
      public function set username(param1:String) : void
      {
         this._username = param1;
      }
      
      public function unsetUsername() : void
      {
         this.username = null;
      }
      
      public function isSetUsername() : Boolean
      {
         return this.username != null;
      }
      
      public function get level() : int
      {
         return this._level;
      }
      
      public function set level(param1:int) : void
      {
         this._level = param1;
         this.__isset_level = true;
      }
      
      public function unsetLevel() : void
      {
         this.__isset_level = false;
      }
      
      public function isSetLevel() : Boolean
      {
         return this.__isset_level;
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
      
      public function get extra() : String
      {
         return this._extra;
      }
      
      public function set extra(param1:String) : void
      {
         this._extra = param1;
      }
      
      public function unsetExtra() : void
      {
         this.extra = null;
      }
      
      public function isSetExtra() : Boolean
      {
         return this.extra != null;
      }
      
      public function get experience() : int
      {
         return this._experience;
      }
      
      public function set experience(param1:int) : void
      {
         this._experience = param1;
         this.__isset_experience = true;
      }
      
      public function unsetExperience() : void
      {
         this.__isset_experience = false;
      }
      
      public function isSetExperience() : Boolean
      {
         return this.__isset_experience;
      }
      
      public function setFieldValue(param1:int, param2:*) : void
      {
         switch(param1)
         {
            case UNIONID:
               if(param2 == null)
               {
                  this.unsetUnionId();
               }
               else
               {
                  this.unionId = param2;
               }
               break;
            case TITLE:
               if(param2 == null)
               {
                  this.unsetTitle();
               }
               else
               {
                  this.title = param2;
               }
               break;
            case USERNAME:
               if(param2 == null)
               {
                  this.unsetUsername();
               }
               else
               {
                  this.username = param2;
               }
               break;
            case LEVEL:
               if(param2 == null)
               {
                  this.unsetLevel();
               }
               else
               {
                  this.level = param2;
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
            case EXTRA:
               if(param2 == null)
               {
                  this.unsetExtra();
               }
               else
               {
                  this.extra = param2;
               }
               break;
            case EXPERIENCE:
               if(param2 == null)
               {
                  this.unsetExperience();
               }
               else
               {
                  this.experience = param2;
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
            case UNIONID:
               return this.unionId;
            case TITLE:
               return this.title;
            case USERNAME:
               return this.username;
            case LEVEL:
               return this.level;
            case COUNT:
               return this.count;
            case EXTRA:
               return this.extra;
            case EXPERIENCE:
               return this.experience;
            default:
               throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
         }
      }
      
      public function isSet(param1:int) : Boolean
      {
         switch(param1)
         {
            case UNIONID:
               return this.isSetUnionId();
            case TITLE:
               return this.isSetTitle();
            case USERNAME:
               return this.isSetUsername();
            case LEVEL:
               return this.isSetLevel();
            case COUNT:
               return this.isSetCount();
            case EXTRA:
               return this.isSetExtra();
            case EXPERIENCE:
               return this.isSetExperience();
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
               case UNIONID:
                  if(_loc2_.type == TType.I32)
                  {
                     this.unionId = param1.readI32();
                     this.__isset_unionId = true;
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case TITLE:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.title = param1.readString();
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case USERNAME:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.username = param1.readString();
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case LEVEL:
                  if(_loc2_.type == TType.I32)
                  {
                     this.level = param1.readI32();
                     this.__isset_level = true;
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
               case EXTRA:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.extra = param1.readString();
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case EXPERIENCE:
                  if(_loc2_.type == TType.I32)
                  {
                     this.experience = param1.readI32();
                     this.__isset_experience = true;
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
         param1.writeFieldBegin(UNION_ID_FIELD_DESC);
         param1.writeI32(this.unionId);
         param1.writeFieldEnd();
         if(this.title != null)
         {
            param1.writeFieldBegin(TITLE_FIELD_DESC);
            param1.writeString(this.title);
            param1.writeFieldEnd();
         }
         if(this.username != null)
         {
            param1.writeFieldBegin(USERNAME_FIELD_DESC);
            param1.writeString(this.username);
            param1.writeFieldEnd();
         }
         param1.writeFieldBegin(LEVEL_FIELD_DESC);
         param1.writeI32(this.level);
         param1.writeFieldEnd();
         if(this.count != null)
         {
            param1.writeFieldBegin(COUNT_FIELD_DESC);
            param1.writeString(this.count);
            param1.writeFieldEnd();
         }
         if(this.extra != null)
         {
            param1.writeFieldBegin(EXTRA_FIELD_DESC);
            param1.writeString(this.extra);
            param1.writeFieldEnd();
         }
         param1.writeFieldBegin(EXPERIENCE_FIELD_DESC);
         param1.writeI32(this.experience);
         param1.writeFieldEnd();
         param1.writeFieldStop();
         param1.writeStructEnd();
      }
      
      public function toString() : String
      {
         var _loc1_:String = new String("UnionList(");
         var _loc2_:Boolean = true;
         _loc1_ += "unionId:";
         _loc1_ += this.unionId;
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "title:";
         if(this.title == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.title;
         }
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "username:";
         if(this.username == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.username;
         }
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "level:";
         _loc1_ += this.level;
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
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "extra:";
         if(this.extra == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.extra;
         }
         _loc2_ = false;
         if(this.isSetExperience())
         {
            if(!_loc2_)
            {
               _loc1_ += ", ";
            }
            _loc1_ += "experience:";
            _loc1_ += this.experience;
            _loc2_ = false;
         }
         return _loc1_ + ")";
      }
      
      public function validate() : void
      {
      }
   }
}

