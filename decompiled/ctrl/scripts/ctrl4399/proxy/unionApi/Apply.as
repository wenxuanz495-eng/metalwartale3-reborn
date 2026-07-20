package ctrl4399.proxy.unionApi
{
   import flash.utils.Dictionary;
   import org.apache.thrift.*;
   import org.apache.thrift.meta_data.*;
   import org.apache.thrift.protocol.*;
   
   public class Apply implements TBase
   {
      
      private static const STRUCT_DESC:TStruct = new TStruct("Apply");
      
      private static const GAME_ID_FIELD_DESC:TField = new TField("gameId",TType.I32,1);
      
      private static const UNION_ID_FIELD_DESC:TField = new TField("unionId",TType.I32,2);
      
      private static const U_ID_FIELD_DESC:TField = new TField("uId",TType.STRING,3);
      
      private static const USER_NAME_FIELD_DESC:TField = new TField("userName",TType.STRING,4);
      
      private static const INDEX_FIELD_DESC:TField = new TField("index",TType.STRING,5);
      
      private static const NICK_NAME_FIELD_DESC:TField = new TField("nickName",TType.STRING,6);
      
      private static const EXTRA_FIELD_DESC:TField = new TField("extra",TType.STRING,7);
      
      public static const GAMEID:int = 1;
      
      public static const UNIONID:int = 2;
      
      public static const UID:int = 3;
      
      public static const USERNAME:int = 4;
      
      public static const INDEX:int = 5;
      
      public static const NICKNAME:int = 6;
      
      public static const EXTRA:int = 7;
      
      public static const metaDataMap:Dictionary = new Dictionary();
      
      metaDataMap[GAMEID] = new FieldMetaData("gameId",TFieldRequirementType.OPTIONAL,new FieldValueMetaData(TType.I32));
      metaDataMap[UNIONID] = new FieldMetaData("unionId",TFieldRequirementType.OPTIONAL,new FieldValueMetaData(TType.I32));
      metaDataMap[UID] = new FieldMetaData("uId",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[USERNAME] = new FieldMetaData("userName",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[INDEX] = new FieldMetaData("index",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[NICKNAME] = new FieldMetaData("nickName",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[EXTRA] = new FieldMetaData("extra",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      FieldMetaData.addStructMetaDataMap(Apply,metaDataMap);
      
      private var _gameId:int;
      
      private var _unionId:int;
      
      private var _uId:String;
      
      private var _userName:String;
      
      private var _index:String;
      
      private var _nickName:String;
      
      private var _extra:String;
      
      private var __isset_gameId:Boolean = false;
      
      private var __isset_unionId:Boolean = false;
      
      public function Apply()
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
            case EXTRA:
               return this.extra;
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
            case EXTRA:
               return this.isSetExtra();
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
         if(this.extra != null)
         {
            param1.writeFieldBegin(EXTRA_FIELD_DESC);
            param1.writeString(this.extra);
            param1.writeFieldEnd();
         }
         param1.writeFieldStop();
         param1.writeStructEnd();
      }
      
      public function toString() : String
      {
         var _loc1_:String = new String("Apply(");
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
         return _loc1_ + ")";
      }
      
      public function validate() : void
      {
      }
   }
}

