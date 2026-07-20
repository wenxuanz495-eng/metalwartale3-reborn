package ctrl4399.proxy.unionApi
{
   import flash.utils.Dictionary;
   import org.apache.thrift.*;
   import org.apache.thrift.meta_data.*;
   import org.apache.thrift.protocol.*;
   
   public class Member implements TBase
   {
      
      private static const STRUCT_DESC:TStruct = new TStruct("Member");
      
      private static const GAME_ID_FIELD_DESC:TField = new TField("gameId",TType.I32,1);
      
      private static const UNION_ID_FIELD_DESC:TField = new TField("unionId",TType.I32,2);
      
      private static const U_ID_FIELD_DESC:TField = new TField("uId",TType.STRING,3);
      
      private static const USER_NAME_FIELD_DESC:TField = new TField("userName",TType.STRING,4);
      
      private static const INDEX_FIELD_DESC:TField = new TField("index",TType.STRING,5);
      
      private static const NICK_NAME_FIELD_DESC:TField = new TField("nickName",TType.STRING,6);
      
      private static const CONTRIBUTION_FIELD_DESC:TField = new TField("contribution",TType.I32,7);
      
      private static const EXTRA_FIELD_DESC:TField = new TField("extra",TType.STRING,8);
      
      private static const EXTRA2_FIELD_DESC:TField = new TField("extra2",TType.STRING,9);
      
      private static const ACTIVE_TIME_FIELD_DESC:TField = new TField("active_time",TType.STRING,10);
      
      private static const ROLE_ID_FIELD_DESC:TField = new TField("roleId",TType.STRING,11);
      
      private static const ROLE_NAME_FIELD_DESC:TField = new TField("roleName",TType.STRING,12);
      
      public static const GAMEID:int = 1;
      
      public static const UNIONID:int = 2;
      
      public static const UID:int = 3;
      
      public static const USERNAME:int = 4;
      
      public static const INDEX:int = 5;
      
      public static const NICKNAME:int = 6;
      
      public static const CONTRIBUTION:int = 7;
      
      public static const EXTRA:int = 8;
      
      public static const EXTRA2:int = 9;
      
      public static const ACTIVE_TIME:int = 10;
      
      public static const ROLEID:int = 11;
      
      public static const ROLENAME:int = 12;
      
      public static const metaDataMap:Dictionary = new Dictionary();
      
      metaDataMap[GAMEID] = new FieldMetaData("gameId",TFieldRequirementType.OPTIONAL,new FieldValueMetaData(TType.I32));
      metaDataMap[UNIONID] = new FieldMetaData("unionId",TFieldRequirementType.OPTIONAL,new FieldValueMetaData(TType.I32));
      metaDataMap[UID] = new FieldMetaData("uId",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[USERNAME] = new FieldMetaData("userName",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[INDEX] = new FieldMetaData("index",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[NICKNAME] = new FieldMetaData("nickName",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[CONTRIBUTION] = new FieldMetaData("contribution",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
      metaDataMap[EXTRA] = new FieldMetaData("extra",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[EXTRA2] = new FieldMetaData("extra2",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[ACTIVE_TIME] = new FieldMetaData("active_time",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[ROLEID] = new FieldMetaData("roleId",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[ROLENAME] = new FieldMetaData("roleName",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      FieldMetaData.addStructMetaDataMap(Member,metaDataMap);
      
      private var _gameId:int;
      
      private var _unionId:int;
      
      private var _uId:String;
      
      private var _userName:String;
      
      private var _index:String;
      
      private var _nickName:String;
      
      private var _contribution:int;
      
      private var _extra:String;
      
      private var _extra2:String;
      
      private var _active_time:String;
      
      private var _roleId:String;
      
      private var _roleName:String;
      
      private var __isset_gameId:Boolean = false;
      
      private var __isset_unionId:Boolean = false;
      
      private var __isset_contribution:Boolean = false;
      
      public function Member()
      {
         super();
         this._gameId = 0;
         this._unionId = 0;
      }
      
      public function get gameId() : int
      {
         return this._gameId;
      }
      
      public function set gameId(param1:int) : void
      {
         this._gameId = param1;
         this.__isset_gameId = true;
      }
      
      public function unsetGameId() : void
      {
         this.__isset_gameId = false;
      }
      
      public function isSetGameId() : Boolean
      {
         return this.__isset_gameId;
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
      
      public function get uId() : String
      {
         return this._uId;
      }
      
      public function set uId(param1:String) : void
      {
         this._uId = param1;
      }
      
      public function unsetUId() : void
      {
         this.uId = null;
      }
      
      public function isSetUId() : Boolean
      {
         return this.uId != null;
      }
      
      public function get userName() : String
      {
         return this._userName;
      }
      
      public function set userName(param1:String) : void
      {
         this._userName = param1;
      }
      
      public function unsetUserName() : void
      {
         this.userName = null;
      }
      
      public function isSetUserName() : Boolean
      {
         return this.userName != null;
      }
      
      public function get index() : String
      {
         return this._index;
      }
      
      public function set index(param1:String) : void
      {
         this._index = param1;
      }
      
      public function unsetIndex() : void
      {
         this.index = null;
      }
      
      public function isSetIndex() : Boolean
      {
         return this.index != null;
      }
      
      public function get nickName() : String
      {
         return this._nickName;
      }
      
      public function set nickName(param1:String) : void
      {
         this._nickName = param1;
      }
      
      public function unsetNickName() : void
      {
         this.nickName = null;
      }
      
      public function isSetNickName() : Boolean
      {
         return this.nickName != null;
      }
      
      public function get contribution() : int
      {
         return this._contribution;
      }
      
      public function set contribution(param1:int) : void
      {
         this._contribution = param1;
         this.__isset_contribution = true;
      }
      
      public function unsetContribution() : void
      {
         this.__isset_contribution = false;
      }
      
      public function isSetContribution() : Boolean
      {
         return this.__isset_contribution;
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
      
      public function get extra2() : String
      {
         return this._extra2;
      }
      
      public function set extra2(param1:String) : void
      {
         this._extra2 = param1;
      }
      
      public function unsetExtra2() : void
      {
         this.extra2 = null;
      }
      
      public function isSetExtra2() : Boolean
      {
         return this.extra2 != null;
      }
      
      public function get active_time() : String
      {
         return this._active_time;
      }
      
      public function set active_time(param1:String) : void
      {
         this._active_time = param1;
      }
      
      public function unsetActive_time() : void
      {
         this.active_time = null;
      }
      
      public function isSetActive_time() : Boolean
      {
         return this.active_time != null;
      }
      
      public function get roleId() : String
      {
         return this._roleId;
      }
      
      public function set roleId(param1:String) : void
      {
         this._roleId = param1;
      }
      
      public function unsetRoleId() : void
      {
         this.roleId = null;
      }
      
      public function isSetRoleId() : Boolean
      {
         return this.roleId != null;
      }
      
      public function get roleName() : String
      {
         return this._roleName;
      }
      
      public function set roleName(param1:String) : void
      {
         this._roleName = param1;
      }
      
      public function unsetRoleName() : void
      {
         this.roleName = null;
      }
      
      public function isSetRoleName() : Boolean
      {
         return this.roleName != null;
      }
      
      public function setFieldValue(param1:int, param2:*) : void
      {
         switch(param1)
         {
            case GAMEID:
               if(param2 == null)
               {
                  this.unsetGameId();
               }
               else
               {
                  this.gameId = param2;
               }
               break;
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
            case UID:
               if(param2 == null)
               {
                  this.unsetUId();
               }
               else
               {
                  this.uId = param2;
               }
               break;
            case USERNAME:
               if(param2 == null)
               {
                  this.unsetUserName();
               }
               else
               {
                  this.userName = param2;
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
            case NICKNAME:
               if(param2 == null)
               {
                  this.unsetNickName();
               }
               else
               {
                  this.nickName = param2;
               }
               break;
            case CONTRIBUTION:
               if(param2 == null)
               {
                  this.unsetContribution();
               }
               else
               {
                  this.contribution = param2;
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
            case EXTRA2:
               if(param2 == null)
               {
                  this.unsetExtra2();
               }
               else
               {
                  this.extra2 = param2;
               }
               break;
            case ACTIVE_TIME:
               if(param2 == null)
               {
                  this.unsetActive_time();
               }
               else
               {
                  this.active_time = param2;
               }
               break;
            case ROLEID:
               if(param2 == null)
               {
                  this.unsetRoleId();
               }
               else
               {
                  this.roleId = param2;
               }
               break;
            case ROLENAME:
               if(param2 == null)
               {
                  this.unsetRoleName();
               }
               else
               {
                  this.roleName = param2;
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
            case GAMEID:
               return this.gameId;
            case UNIONID:
               return this.unionId;
            case UID:
               return this.uId;
            case USERNAME:
               return this.userName;
            case INDEX:
               return this.index;
            case NICKNAME:
               return this.nickName;
            case CONTRIBUTION:
               return this.contribution;
            case EXTRA:
               return this.extra;
            case EXTRA2:
               return this.extra2;
            case ACTIVE_TIME:
               return this.active_time;
            case ROLEID:
               return this.roleId;
            case ROLENAME:
               return this.roleName;
            default:
               throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
         }
      }
      
      public function isSet(param1:int) : Boolean
      {
         switch(param1)
         {
            case GAMEID:
               return this.isSetGameId();
            case UNIONID:
               return this.isSetUnionId();
            case UID:
               return this.isSetUId();
            case USERNAME:
               return this.isSetUserName();
            case INDEX:
               return this.isSetIndex();
            case NICKNAME:
               return this.isSetNickName();
            case CONTRIBUTION:
               return this.isSetContribution();
            case EXTRA:
               return this.isSetExtra();
            case EXTRA2:
               return this.isSetExtra2();
            case ACTIVE_TIME:
               return this.isSetActive_time();
            case ROLEID:
               return this.isSetRoleId();
            case ROLENAME:
               return this.isSetRoleName();
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
               case GAMEID:
                  if(_loc2_.type == TType.I32)
                  {
                     this.gameId = param1.readI32();
                     this.__isset_gameId = true;
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
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
               case UID:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.uId = param1.readString();
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case USERNAME:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.userName = param1.readString();
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case INDEX:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.index = param1.readString();
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case NICKNAME:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.nickName = param1.readString();
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case CONTRIBUTION:
                  if(_loc2_.type == TType.I32)
                  {
                     this.contribution = param1.readI32();
                     this.__isset_contribution = true;
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
               case EXTRA2:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.extra2 = param1.readString();
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case ACTIVE_TIME:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.active_time = param1.readString();
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case ROLEID:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.roleId = param1.readString();
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case ROLENAME:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.roleName = param1.readString();
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
         param1.writeFieldBegin(GAME_ID_FIELD_DESC);
         param1.writeI32(this.gameId);
         param1.writeFieldEnd();
         param1.writeFieldBegin(UNION_ID_FIELD_DESC);
         param1.writeI32(this.unionId);
         param1.writeFieldEnd();
         if(this.uId != null)
         {
            param1.writeFieldBegin(U_ID_FIELD_DESC);
            param1.writeString(this.uId);
            param1.writeFieldEnd();
         }
         if(this.userName != null)
         {
            param1.writeFieldBegin(USER_NAME_FIELD_DESC);
            param1.writeString(this.userName);
            param1.writeFieldEnd();
         }
         if(this.index != null)
         {
            param1.writeFieldBegin(INDEX_FIELD_DESC);
            param1.writeString(this.index);
            param1.writeFieldEnd();
         }
         if(this.nickName != null)
         {
            param1.writeFieldBegin(NICK_NAME_FIELD_DESC);
            param1.writeString(this.nickName);
            param1.writeFieldEnd();
         }
         param1.writeFieldBegin(CONTRIBUTION_FIELD_DESC);
         param1.writeI32(this.contribution);
         param1.writeFieldEnd();
         if(this.extra != null)
         {
            param1.writeFieldBegin(EXTRA_FIELD_DESC);
            param1.writeString(this.extra);
            param1.writeFieldEnd();
         }
         if(this.extra2 != null)
         {
            param1.writeFieldBegin(EXTRA2_FIELD_DESC);
            param1.writeString(this.extra2);
            param1.writeFieldEnd();
         }
         if(this.active_time != null)
         {
            param1.writeFieldBegin(ACTIVE_TIME_FIELD_DESC);
            param1.writeString(this.active_time);
            param1.writeFieldEnd();
         }
         if(this.roleId != null)
         {
            param1.writeFieldBegin(ROLE_ID_FIELD_DESC);
            param1.writeString(this.roleId);
            param1.writeFieldEnd();
         }
         if(this.roleName != null)
         {
            param1.writeFieldBegin(ROLE_NAME_FIELD_DESC);
            param1.writeString(this.roleName);
            param1.writeFieldEnd();
         }
         param1.writeFieldStop();
         param1.writeStructEnd();
      }
      
      public function toString() : String
      {
         var _loc1_:String = new String("Member(");
         var _loc2_:Boolean = true;
         if(this.isSetGameId())
         {
            _loc1_ += "gameId:";
            _loc1_ += this.gameId;
            _loc2_ = false;
         }
         if(this.isSetUnionId())
         {
            if(!_loc2_)
            {
               _loc1_ += ", ";
            }
            _loc1_ += "unionId:";
            _loc1_ += this.unionId;
            _loc2_ = false;
         }
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "uId:";
         if(this.uId == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.uId;
         }
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "userName:";
         if(this.userName == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.userName;
         }
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "index:";
         if(this.index == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.index;
         }
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "nickName:";
         if(this.nickName == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.nickName;
         }
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "contribution:";
         _loc1_ += this.contribution;
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
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "extra2:";
         if(this.extra2 == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.extra2;
         }
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "active_time:";
         if(this.active_time == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.active_time;
         }
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "roleId:";
         if(this.roleId == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.roleId;
         }
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "roleName:";
         if(this.roleName == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.roleName;
         }
         _loc2_ = false;
         return _loc1_ + ")";
      }
      
      public function validate() : void
      {
      }
   }
}

