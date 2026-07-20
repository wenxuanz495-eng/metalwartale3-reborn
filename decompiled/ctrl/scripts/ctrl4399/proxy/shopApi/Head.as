package ctrl4399.proxy.shopApi
{
   import flash.utils.Dictionary;
   import org.apache.thrift.*;
   import org.apache.thrift.meta_data.*;
   import org.apache.thrift.protocol.*;
   
   public class Head implements TBase
   {
      
      private static const STRUCT_DESC:TStruct = new TStruct("Head");
      
      private static const GAME_ID_FIELD_DESC:TField = new TField("gameId",TType.STRING,1);
      
      private static const U_ID_FIELD_DESC:TField = new TField("uId",TType.STRING,2);
      
      private static const INDEX_FIELD_DESC:TField = new TField("index",TType.I32,3);
      
      private static const VERIFY_FIELD_DESC:TField = new TField("verify",TType.STRING,4);
      
      public static const GAMEID:int = 1;
      
      public static const UID:int = 2;
      
      public static const INDEX:int = 3;
      
      public static const VERIFY:int = 4;
      
      public static const metaDataMap:Dictionary = new Dictionary();
      
      metaDataMap[GAMEID] = new FieldMetaData("gameId",TFieldRequirementType.REQUIRED,new FieldValueMetaData(TType.STRING));
      metaDataMap[UID] = new FieldMetaData("uId",TFieldRequirementType.REQUIRED,new FieldValueMetaData(TType.STRING));
      metaDataMap[INDEX] = new FieldMetaData("index",TFieldRequirementType.REQUIRED,new FieldValueMetaData(TType.I32));
      metaDataMap[VERIFY] = new FieldMetaData("verify",TFieldRequirementType.REQUIRED,new FieldValueMetaData(TType.STRING));
      FieldMetaData.addStructMetaDataMap(Head,metaDataMap);
      
      private var _gameId:String;
      
      private var _uId:String;
      
      private var _index:int;
      
      private var _verify:String;
      
      private var __isset_index:Boolean = false;
      
      public function Head()
      {
         super();
      }
      
      public function get gameId() : String
      {
         return this._gameId;
      }
      
      public function set gameId(param1:String) : void
      {
         this._gameId = param1;
      }
      
      public function unsetGameId() : void
      {
         this.gameId = null;
      }
      
      public function isSetGameId() : Boolean
      {
         return this.gameId != null;
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
      
      public function get verify() : String
      {
         return this._verify;
      }
      
      public function set verify(param1:String) : void
      {
         this._verify = param1;
      }
      
      public function unsetVerify() : void
      {
         this.verify = null;
      }
      
      public function isSetVerify() : Boolean
      {
         return this.verify != null;
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
            case VERIFY:
               if(param2 == null)
               {
                  this.unsetVerify();
               }
               else
               {
                  this.verify = param2;
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
            case UID:
               return this.uId;
            case INDEX:
               return this.index;
            case VERIFY:
               return this.verify;
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
            case UID:
               return this.isSetUId();
            case INDEX:
               return this.isSetIndex();
            case VERIFY:
               return this.isSetVerify();
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
                  if(_loc2_.type == TType.STRING)
                  {
                     this.gameId = param1.readString();
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
               case VERIFY:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.verify = param1.readString();
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
         if(this.gameId != null)
         {
            param1.writeFieldBegin(GAME_ID_FIELD_DESC);
            param1.writeString(this.gameId);
            param1.writeFieldEnd();
         }
         if(this.uId != null)
         {
            param1.writeFieldBegin(U_ID_FIELD_DESC);
            param1.writeString(this.uId);
            param1.writeFieldEnd();
         }
         param1.writeFieldBegin(INDEX_FIELD_DESC);
         param1.writeI32(this.index);
         param1.writeFieldEnd();
         if(this.verify != null)
         {
            param1.writeFieldBegin(VERIFY_FIELD_DESC);
            param1.writeString(this.verify);
            param1.writeFieldEnd();
         }
         param1.writeFieldStop();
         param1.writeStructEnd();
      }
      
      public function toString() : String
      {
         var _loc1_:String = new String("Head(");
         var _loc2_:Boolean = true;
         _loc1_ += "gameId:";
         if(this.gameId == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.gameId;
         }
         _loc2_ = false;
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
         _loc1_ += "index:";
         _loc1_ += this.index;
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "verify:";
         if(this.verify == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.verify;
         }
         _loc2_ = false;
         return _loc1_ + ")";
      }
      
      public function validate() : void
      {
         if(this.gameId == null)
         {
            throw new TProtocolError(TProtocolError.UNKNOWN,"Required field \'gameId\' was not present! Struct: " + this.toString());
         }
         if(this.uId == null)
         {
            throw new TProtocolError(TProtocolError.UNKNOWN,"Required field \'uId\' was not present! Struct: " + this.toString());
         }
         if(this.verify == null)
         {
            throw new TProtocolError(TProtocolError.UNKNOWN,"Required field \'verify\' was not present! Struct: " + this.toString());
         }
      }
   }
}

