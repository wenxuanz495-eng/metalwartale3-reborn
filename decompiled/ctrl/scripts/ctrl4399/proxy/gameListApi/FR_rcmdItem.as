package ctrl4399.proxy.gameListApi
{
   import flash.utils.Dictionary;
   import org.apache.thrift.*;
   import org.apache.thrift.meta_data.*;
   import org.apache.thrift.protocol.*;
   
   public class FR_rcmdItem implements TBase
   {
      
      private static const STRUCT_DESC:TStruct = new TStruct("FR_rcmdItem");
      
      private static const GAME_ID_FIELD_DESC:TField = new TField("gameId",TType.STRING,1);
      
      private static const GAME_NAME_FIELD_DESC:TField = new TField("gameName",TType.STRING,2);
      
      private static const GAME_IMG_URL_FIELD_DESC:TField = new TField("gameImgUrl",TType.STRING,3);
      
      public static const GAMEID:int = 1;
      
      public static const GAMENAME:int = 2;
      
      public static const GAMEIMGURL:int = 3;
      
      public static const metaDataMap:Dictionary = new Dictionary();
      
      metaDataMap[GAMEID] = new FieldMetaData("gameId",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[GAMENAME] = new FieldMetaData("gameName",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[GAMEIMGURL] = new FieldMetaData("gameImgUrl",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      FieldMetaData.addStructMetaDataMap(FR_rcmdItem,metaDataMap);
      
      private var _gameId:String;
      
      private var _gameName:String;
      
      private var _gameImgUrl:String;
      
      public function FR_rcmdItem()
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
      
      public function get gameName() : String
      {
         return this._gameName;
      }
      
      public function set gameName(param1:String) : void
      {
         this._gameName = param1;
      }
      
      public function unsetGameName() : void
      {
         this.gameName = null;
      }
      
      public function isSetGameName() : Boolean
      {
         return this.gameName != null;
      }
      
      public function get gameImgUrl() : String
      {
         return this._gameImgUrl;
      }
      
      public function set gameImgUrl(param1:String) : void
      {
         this._gameImgUrl = param1;
      }
      
      public function unsetGameImgUrl() : void
      {
         this.gameImgUrl = null;
      }
      
      public function isSetGameImgUrl() : Boolean
      {
         return this.gameImgUrl != null;
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
            case GAMENAME:
               if(param2 == null)
               {
                  this.unsetGameName();
               }
               else
               {
                  this.gameName = param2;
               }
               break;
            case GAMEIMGURL:
               if(param2 == null)
               {
                  this.unsetGameImgUrl();
               }
               else
               {
                  this.gameImgUrl = param2;
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
            case GAMENAME:
               return this.gameName;
            case GAMEIMGURL:
               return this.gameImgUrl;
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
            case GAMENAME:
               return this.isSetGameName();
            case GAMEIMGURL:
               return this.isSetGameImgUrl();
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
               case GAMENAME:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.gameName = param1.readString();
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case GAMEIMGURL:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.gameImgUrl = param1.readString();
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
         if(this.gameId != null)
         {
            param1.writeFieldBegin(GAME_ID_FIELD_DESC);
            param1.writeString(this.gameId);
            param1.writeFieldEnd();
         }
         if(this.gameName != null)
         {
            param1.writeFieldBegin(GAME_NAME_FIELD_DESC);
            param1.writeString(this.gameName);
            param1.writeFieldEnd();
         }
         if(this.gameImgUrl != null)
         {
            param1.writeFieldBegin(GAME_IMG_URL_FIELD_DESC);
            param1.writeString(this.gameImgUrl);
            param1.writeFieldEnd();
         }
         param1.writeFieldStop();
         param1.writeStructEnd();
      }
      
      public function toString() : String
      {
         var _loc1_:String = new String("FR_rcmdItem(");
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
         _loc1_ += "gameName:";
         if(this.gameName == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.gameName;
         }
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "gameImgUrl:";
         if(this.gameImgUrl == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.gameImgUrl;
         }
         _loc2_ = false;
         return _loc1_ + ")";
      }
      
      public function validate() : void
      {
      }
   }
}

