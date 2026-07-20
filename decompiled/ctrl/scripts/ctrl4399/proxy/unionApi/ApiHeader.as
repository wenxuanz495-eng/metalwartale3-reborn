package ctrl4399.proxy.unionApi
{
   import flash.utils.Dictionary;
   import org.apache.thrift.*;
   import org.apache.thrift.meta_data.*;
   import org.apache.thrift.protocol.*;
   
   public class ApiHeader implements TBase
   {
      
      private static const STRUCT_DESC:TStruct = new TStruct("ApiHeader");
      
      private static const TAG_FIELD_DESC:TField = new TField("tag",TType.STRING,1);
      
      private static const GAME_ID_FIELD_DESC:TField = new TField("gameId",TType.STRING,2);
      
      private static const INDEX_FIELD_DESC:TField = new TField("index",TType.STRING,3);
      
      public static const TAG:int = 1;
      
      public static const GAMEID:int = 2;
      
      public static const INDEX:int = 3;
      
      public static const metaDataMap:Dictionary = new Dictionary();
      
      metaDataMap[TAG] = new FieldMetaData("tag",TFieldRequirementType.REQUIRED,new FieldValueMetaData(TType.STRING));
      metaDataMap[GAMEID] = new FieldMetaData("gameId",TFieldRequirementType.REQUIRED,new FieldValueMetaData(TType.STRING));
      metaDataMap[INDEX] = new FieldMetaData("index",TFieldRequirementType.REQUIRED,new FieldValueMetaData(TType.STRING));
      FieldMetaData.addStructMetaDataMap(ApiHeader,metaDataMap);
      
      private var _tag:String;
      
      private var _gameId:String;
      
      private var _index:String;
      
      public function ApiHeader()
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
            case TAG:
               return this.tag;
            case GAMEID:
               return this.gameId;
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
            case TAG:
               return this.isSetTag();
            case GAMEID:
               return this.isSetGameId();
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
         if(this.tag != null)
         {
            param1.writeFieldBegin(TAG_FIELD_DESC);
            param1.writeString(this.tag);
            param1.writeFieldEnd();
         }
         if(this.gameId != null)
         {
            param1.writeFieldBegin(GAME_ID_FIELD_DESC);
            param1.writeString(this.gameId);
            param1.writeFieldEnd();
         }
         if(this.index != null)
         {
            param1.writeFieldBegin(INDEX_FIELD_DESC);
            param1.writeString(this.index);
            param1.writeFieldEnd();
         }
         param1.writeFieldStop();
         param1.writeStructEnd();
      }
      
      public function toString() : String
      {
         var _loc1_:String = new String("ApiHeader(");
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
         return _loc1_ + ")";
      }
      
      public function validate() : void
      {
         if(this.tag == null)
         {
            throw new TProtocolError(TProtocolError.UNKNOWN,"Required field \'tag\' was not present! Struct: " + this.toString());
         }
         if(this.gameId == null)
         {
            throw new TProtocolError(TProtocolError.UNKNOWN,"Required field \'gameId\' was not present! Struct: " + this.toString());
         }
         if(this.index == null)
         {
            throw new TProtocolError(TProtocolError.UNKNOWN,"Required field \'index\' was not present! Struct: " + this.toString());
         }
      }
   }
}

