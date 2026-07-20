package ctrl4399.proxy.rankListApi
{
   import flash.utils.Dictionary;
   import org.apache.thrift.*;
   import org.apache.thrift.meta_data.*;
   import org.apache.thrift.protocol.*;
   
   public class FSRE_RankingItem implements TBase
   {
      
      private static const STRUCT_DESC:TStruct = new TStruct("FSRE_RankingItem");
      
      private static const INDEX_FIELD_DESC:TField = new TField("index",TType.STRING,1);
      
      private static const U_ID_FIELD_DESC:TField = new TField("uId",TType.STRING,2);
      
      private static const USER_NAME_FIELD_DESC:TField = new TField("userName",TType.STRING,3);
      
      private static const SCORE_FIELD_DESC:TField = new TField("score",TType.I32,4);
      
      private static const RANK_FIELD_DESC:TField = new TField("rank",TType.I32,5);
      
      private static const TIMESTAMP_FIELD_DESC:TField = new TField("timestamp",TType.STRING,6);
      
      private static const AREA_FIELD_DESC:TField = new TField("area",TType.STRING,7);
      
      private static const EXTRA_FIELD_DESC:TField = new TField("extra",TType.STRING,8);
      
      public static const INDEX:int = 1;
      
      public static const UID:int = 2;
      
      public static const USERNAME:int = 3;
      
      public static const SCORE:int = 4;
      
      public static const RANK:int = 5;
      
      public static const TIMESTAMP:int = 6;
      
      public static const AREA:int = 7;
      
      public static const EXTRA:int = 8;
      
      public static const metaDataMap:Dictionary = new Dictionary();
      
      metaDataMap[INDEX] = new FieldMetaData("index",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[UID] = new FieldMetaData("uId",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[USERNAME] = new FieldMetaData("userName",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[SCORE] = new FieldMetaData("score",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
      metaDataMap[RANK] = new FieldMetaData("rank",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
      metaDataMap[TIMESTAMP] = new FieldMetaData("timestamp",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[AREA] = new FieldMetaData("area",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[EXTRA] = new FieldMetaData("extra",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      FieldMetaData.addStructMetaDataMap(FSRE_RankingItem,metaDataMap);
      
      private var _index:String;
      
      private var _uId:String;
      
      private var _userName:String;
      
      private var _score:int;
      
      private var _rank:int;
      
      private var _timestamp:String;
      
      private var _area:String;
      
      private var _extra:String;
      
      private var __isset_score:Boolean = false;
      
      private var __isset_rank:Boolean = false;
      
      public function FSRE_RankingItem()
      {
         super();
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
      
      public function get score() : int
      {
         return this._score;
      }
      
      public function set score(param1:int) : void
      {
         this._score = param1;
         this.__isset_score = true;
      }
      
      public function unsetScore() : void
      {
         this.__isset_score = false;
      }
      
      public function isSetScore() : Boolean
      {
         return this.__isset_score;
      }
      
      public function get rank() : int
      {
         return this._rank;
      }
      
      public function set rank(param1:int) : void
      {
         this._rank = param1;
         this.__isset_rank = true;
      }
      
      public function unsetRank() : void
      {
         this.__isset_rank = false;
      }
      
      public function isSetRank() : Boolean
      {
         return this.__isset_rank;
      }
      
      public function get timestamp() : String
      {
         return this._timestamp;
      }
      
      public function set timestamp(param1:String) : void
      {
         this._timestamp = param1;
      }
      
      public function unsetTimestamp() : void
      {
         this.timestamp = null;
      }
      
      public function isSetTimestamp() : Boolean
      {
         return this.timestamp != null;
      }
      
      public function get area() : String
      {
         return this._area;
      }
      
      public function set area(param1:String) : void
      {
         this._area = param1;
      }
      
      public function unsetArea() : void
      {
         this.area = null;
      }
      
      public function isSetArea() : Boolean
      {
         return this.area != null;
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
            case SCORE:
               if(param2 == null)
               {
                  this.unsetScore();
               }
               else
               {
                  this.score = param2;
               }
               break;
            case RANK:
               if(param2 == null)
               {
                  this.unsetRank();
               }
               else
               {
                  this.rank = param2;
               }
               break;
            case TIMESTAMP:
               if(param2 == null)
               {
                  this.unsetTimestamp();
               }
               else
               {
                  this.timestamp = param2;
               }
               break;
            case AREA:
               if(param2 == null)
               {
                  this.unsetArea();
               }
               else
               {
                  this.area = param2;
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
            case INDEX:
               return this.index;
            case UID:
               return this.uId;
            case USERNAME:
               return this.userName;
            case SCORE:
               return this.score;
            case RANK:
               return this.rank;
            case TIMESTAMP:
               return this.timestamp;
            case AREA:
               return this.area;
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
            case INDEX:
               return this.isSetIndex();
            case UID:
               return this.isSetUId();
            case USERNAME:
               return this.isSetUserName();
            case SCORE:
               return this.isSetScore();
            case RANK:
               return this.isSetRank();
            case TIMESTAMP:
               return this.isSetTimestamp();
            case AREA:
               return this.isSetArea();
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
               case SCORE:
                  if(_loc2_.type == TType.I32)
                  {
                     this.score = param1.readI32();
                     this.__isset_score = true;
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case RANK:
                  if(_loc2_.type == TType.I32)
                  {
                     this.rank = param1.readI32();
                     this.__isset_rank = true;
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case TIMESTAMP:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.timestamp = param1.readString();
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case AREA:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.area = param1.readString();
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
         if(this.index != null)
         {
            param1.writeFieldBegin(INDEX_FIELD_DESC);
            param1.writeString(this.index);
            param1.writeFieldEnd();
         }
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
         param1.writeFieldBegin(SCORE_FIELD_DESC);
         param1.writeI32(this.score);
         param1.writeFieldEnd();
         param1.writeFieldBegin(RANK_FIELD_DESC);
         param1.writeI32(this.rank);
         param1.writeFieldEnd();
         if(this.timestamp != null)
         {
            param1.writeFieldBegin(TIMESTAMP_FIELD_DESC);
            param1.writeString(this.timestamp);
            param1.writeFieldEnd();
         }
         if(this.area != null)
         {
            param1.writeFieldBegin(AREA_FIELD_DESC);
            param1.writeString(this.area);
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
         var _loc1_:String = new String("FSRE_RankingItem(");
         var _loc2_:Boolean = true;
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
         _loc1_ += "score:";
         _loc1_ += this.score;
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "rank:";
         _loc1_ += this.rank;
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "timestamp:";
         if(this.timestamp == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.timestamp;
         }
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "area:";
         if(this.area == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.area;
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

