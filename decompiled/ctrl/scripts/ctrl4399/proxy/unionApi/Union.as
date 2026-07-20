package ctrl4399.proxy.unionApi
{
   import flash.utils.Dictionary;
   import org.apache.thrift.*;
   import org.apache.thrift.meta_data.*;
   import org.apache.thrift.protocol.*;
   
   public class Union implements TBase
   {
      
      private static const STRUCT_DESC:TStruct = new TStruct("Union");
      
      private static const ID_FIELD_DESC:TField = new TField("id",TType.I32,1);
      
      private static const GAME_ID_FIELD_DESC:TField = new TField("gameId",TType.I32,2);
      
      private static const U_ID_FIELD_DESC:TField = new TField("uId",TType.STRING,3);
      
      private static const USER_NAME_FIELD_DESC:TField = new TField("userName",TType.STRING,4);
      
      private static const INDEX_FIELD_DESC:TField = new TField("index",TType.STRING,5);
      
      private static const NICK_NAME_FIELD_DESC:TField = new TField("nickName",TType.STRING,6);
      
      private static const TITLE_FIELD_DESC:TField = new TField("title",TType.STRING,7);
      
      private static const LEVEL_FIELD_DESC:TField = new TField("level",TType.I32,8);
      
      private static const EXPERIENCE_FIELD_DESC:TField = new TField("experience",TType.I32,9);
      
      private static const CONTRIBUTION_FIELD_DESC:TField = new TField("contribution",TType.I32,10);
      
      private static const EXTRA_FIELD_DESC:TField = new TField("extra",TType.STRING,11);
      
      private static const EXTRA2_FIELD_DESC:TField = new TField("extra2",TType.STRING,12);
      
      private static const DISSOLVE_DATE_FIELD_DESC:TField = new TField("dissolveDate",TType.STRING,13);
      
      private static const COUNT_FIELD_DESC:TField = new TField("count",TType.STRING,14);
      
      private static const TRANSFER_FIELD_DESC:TField = new TField("transfer",TType.STRING,15);
      
      public static const ID:int = 1;
      
      public static const GAMEID:int = 2;
      
      public static const UID:int = 3;
      
      public static const USERNAME:int = 4;
      
      public static const INDEX:int = 5;
      
      public static const NICKNAME:int = 6;
      
      public static const TITLE:int = 7;
      
      public static const LEVEL:int = 8;
      
      public static const EXPERIENCE:int = 9;
      
      public static const CONTRIBUTION:int = 10;
      
      public static const EXTRA:int = 11;
      
      public static const EXTRA2:int = 12;
      
      public static const DISSOLVEDATE:int = 13;
      
      public static const COUNT:int = 14;
      
      public static const TRANSFER:int = 15;
      
      public static const metaDataMap:Dictionary = new Dictionary();
      
      metaDataMap[ID] = new FieldMetaData("id",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
      metaDataMap[GAMEID] = new FieldMetaData("gameId",TFieldRequirementType.OPTIONAL,new FieldValueMetaData(TType.I32));
      metaDataMap[UID] = new FieldMetaData("uId",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[USERNAME] = new FieldMetaData("userName",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[INDEX] = new FieldMetaData("index",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[NICKNAME] = new FieldMetaData("nickName",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[TITLE] = new FieldMetaData("title",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[LEVEL] = new FieldMetaData("level",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
      metaDataMap[EXPERIENCE] = new FieldMetaData("experience",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
      metaDataMap[CONTRIBUTION] = new FieldMetaData("contribution",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
      metaDataMap[EXTRA] = new FieldMetaData("extra",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[EXTRA2] = new FieldMetaData("extra2",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[DISSOLVEDATE] = new FieldMetaData("dissolveDate",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[COUNT] = new FieldMetaData("count",TFieldRequirementType.OPTIONAL,new FieldValueMetaData(TType.STRING));
      metaDataMap[TRANSFER] = new FieldMetaData("transfer",TFieldRequirementType.OPTIONAL,new FieldValueMetaData(TType.STRING));
      FieldMetaData.addStructMetaDataMap(Union,metaDataMap);
      
      private var _id:int;
      
      private var _gameId:int;
      
      private var _uId:String;
      
      private var _userName:String;
      
      private var _index:String;
      
      private var _nickName:String;
      
      private var _title:String;
      
      private var _level:int;
      
      private var _experience:int;
      
      private var _contribution:int;
      
      private var _extra:String;
      
      private var _extra2:String;
      
      private var _dissolveDate:String;
      
      private var _count:String;
      
      private var _transfer:String;
      
      private var __isset_id:Boolean = false;
      
      private var __isset_gameId:Boolean = false;
      
      private var __isset_level:Boolean = false;
      
      private var __isset_experience:Boolean = false;
      
      private var __isset_contribution:Boolean = false;
      
      public function Union()
      {
         super();
         this._gameId = 0;
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
      
      public function get dissolveDate() : String
      {
         return this._dissolveDate;
      }
      
      public function set dissolveDate(param1:String) : void
      {
         this._dissolveDate = param1;
      }
      
      public function unsetDissolveDate() : void
      {
         this.dissolveDate = null;
      }
      
      public function isSetDissolveDate() : Boolean
      {
         return this.dissolveDate != null;
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
      
      public function get transfer() : String
      {
         return this._transfer;
      }
      
      public function set transfer(param1:String) : void
      {
         this._transfer = param1;
      }
      
      public function unsetTransfer() : void
      {
         this.transfer = null;
      }
      
      public function isSetTransfer() : Boolean
      {
         return this.transfer != null;
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
            case DISSOLVEDATE:
               if(param2 == null)
               {
                  this.unsetDissolveDate();
               }
               else
               {
                  this.dissolveDate = param2;
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
            case TRANSFER:
               if(param2 == null)
               {
                  this.unsetTransfer();
               }
               else
               {
                  this.transfer = param2;
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
            case GAMEID:
               return this.gameId;
            case UID:
               return this.uId;
            case USERNAME:
               return this.userName;
            case INDEX:
               return this.index;
            case NICKNAME:
               return this.nickName;
            case TITLE:
               return this.title;
            case LEVEL:
               return this.level;
            case EXPERIENCE:
               return this.experience;
            case CONTRIBUTION:
               return this.contribution;
            case EXTRA:
               return this.extra;
            case EXTRA2:
               return this.extra2;
            case DISSOLVEDATE:
               return this.dissolveDate;
            case COUNT:
               return this.count;
            case TRANSFER:
               return this.transfer;
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
            case GAMEID:
               return this.isSetGameId();
            case UID:
               return this.isSetUId();
            case USERNAME:
               return this.isSetUserName();
            case INDEX:
               return this.isSetIndex();
            case NICKNAME:
               return this.isSetNickName();
            case TITLE:
               return this.isSetTitle();
            case LEVEL:
               return this.isSetLevel();
            case EXPERIENCE:
               return this.isSetExperience();
            case CONTRIBUTION:
               return this.isSetContribution();
            case EXTRA:
               return this.isSetExtra();
            case EXTRA2:
               return this.isSetExtra2();
            case DISSOLVEDATE:
               return this.isSetDissolveDate();
            case COUNT:
               return this.isSetCount();
            case TRANSFER:
               return this.isSetTransfer();
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
               case DISSOLVEDATE:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.dissolveDate = param1.readString();
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
               case TRANSFER:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.transfer = param1.readString();
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
         param1.writeFieldBegin(GAME_ID_FIELD_DESC);
         param1.writeI32(this.gameId);
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
         if(this.title != null)
         {
            param1.writeFieldBegin(TITLE_FIELD_DESC);
            param1.writeString(this.title);
            param1.writeFieldEnd();
         }
         param1.writeFieldBegin(LEVEL_FIELD_DESC);
         param1.writeI32(this.level);
         param1.writeFieldEnd();
         param1.writeFieldBegin(EXPERIENCE_FIELD_DESC);
         param1.writeI32(this.experience);
         param1.writeFieldEnd();
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
         if(this.dissolveDate != null)
         {
            param1.writeFieldBegin(DISSOLVE_DATE_FIELD_DESC);
            param1.writeString(this.dissolveDate);
            param1.writeFieldEnd();
         }
         if(this.count != null)
         {
            param1.writeFieldBegin(COUNT_FIELD_DESC);
            param1.writeString(this.count);
            param1.writeFieldEnd();
         }
         if(this.transfer != null)
         {
            param1.writeFieldBegin(TRANSFER_FIELD_DESC);
            param1.writeString(this.transfer);
            param1.writeFieldEnd();
         }
         param1.writeFieldStop();
         param1.writeStructEnd();
      }
      
      public function toString() : String
      {
         var _loc1_:String = new String("Union(");
         var _loc2_:Boolean = true;
         _loc1_ += "id:";
         _loc1_ += this.id;
         _loc2_ = false;
         if(this.isSetGameId())
         {
            if(!_loc2_)
            {
               _loc1_ += ", ";
            }
            _loc1_ += "gameId:";
            _loc1_ += this.gameId;
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
         _loc1_ += "level:";
         _loc1_ += this.level;
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "experience:";
         _loc1_ += this.experience;
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
         _loc1_ += "dissolveDate:";
         if(this.dissolveDate == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.dissolveDate;
         }
         _loc2_ = false;
         if(this.isSetCount())
         {
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
         }
         if(this.isSetTransfer())
         {
            if(!_loc2_)
            {
               _loc1_ += ", ";
            }
            _loc1_ += "transfer:";
            if(this.transfer == null)
            {
               _loc1_ += "null";
            }
            else
            {
               _loc1_ += this.transfer;
            }
            _loc2_ = false;
         }
         return _loc1_ + ")";
      }
      
      public function validate() : void
      {
      }
   }
}

