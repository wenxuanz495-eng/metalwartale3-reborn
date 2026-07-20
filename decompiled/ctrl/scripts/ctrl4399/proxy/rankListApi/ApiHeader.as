package ctrl4399.proxy.rankListApi
{
   import flash.utils.Dictionary;
   import org.apache.thrift.*;
   import org.apache.thrift.meta_data.*;
   import org.apache.thrift.protocol.*;
   
   public class ApiHeader implements TBase
   {
      
      private static const STRUCT_DESC:TStruct = new TStruct("ApiHeader");
      
      private static const U_ID_FIELD_DESC:TField = new TField("uId",TType.STRING,1);
      
      private static const GAME_ID_FIELD_DESC:TField = new TField("gameId",TType.STRING,2);
      
      public static const UID:int = 1;
      
      public static const GAMEID:int = 2;
      
      public static const metaDataMap:Dictionary = new Dictionary();
      
      metaDataMap[UID] = new FieldMetaData("uId",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[GAMEID] = new FieldMetaData("gameId",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      FieldMetaData.addStructMetaDataMap(ApiHeader,metaDataMap);
      
      private var _uId:String;
      
      private var _gameId:String;
      
      public function ApiHeader()
      {
         super();
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
      
      public function setFieldValue(param1:int, param2:*) : void
      {
         switch(param1)
         {
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
            default:
               throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
         }
      }
      
      public function getFieldValue(param1:int) : *
      {
         switch(param1)
         {
            case UID:
               return this.uId;
            case GAMEID:
               return this.gameId;
            default:
               throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
         }
      }
      
      public function isSet(param1:int) : Boolean
      {
         switch(param1)
         {
            case UID:
               return this.isSetUId();
            case GAMEID:
               return this.isSetGameId();
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
                  if(_loc2_.type == TType.STRING)
                  {
                     this.uId = param1.readString();
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
         if(this.uId != null)
         {
            param1.writeFieldBegin(U_ID_FIELD_DESC);
            param1.writeString(this.uId);
            param1.writeFieldEnd();
         }
         if(this.gameId != null)
         {
            param1.writeFieldBegin(GAME_ID_FIELD_DESC);
            param1.writeString(this.gameId);
            param1.writeFieldEnd();
         }
         param1.writeFieldStop();
         param1.writeStructEnd();
      }
      
      public function toString() : String
      {
         var _loc1_:String = new String("ApiHeader(");
         var _loc2_:Boolean = true;
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
         return _loc1_ + ")";
      }
      
      public function validate() : void
      {
      }
   }
}

