package ctrl4399.proxy.scoreApi
{
   import flash.utils.Dictionary;
   import org.apache.thrift.*;
   import org.apache.thrift.meta_data.*;
   import org.apache.thrift.protocol.*;
   
   public class OneScoreTop implements TBase
   {
      
      private static const STRUCT_DESC:TStruct = new TStruct("OneScoreTop");
      
      private static const U_ID_FIELD_DESC:TField = new TField("uId",TType.STRING,1);
      
      private static const USER_NAME_FIELD_DESC:TField = new TField("userName",TType.STRING,2);
      
      private static const SCORE_FIELD_DESC:TField = new TField("score",TType.I32,3);
      
      private static const AREA_FIELD_DESC:TField = new TField("area",TType.STRING,4);
      
      private static const TIME_FIELD_DESC:TField = new TField("time",TType.STRING,5);
      
      private static const RANK_FIELD_DESC:TField = new TField("rank",TType.I32,6);
      
      public static const UID:int = 1;
      
      public static const USERNAME:int = 2;
      
      public static const SCORE:int = 3;
      
      public static const AREA:int = 4;
      
      public static const TIME:int = 5;
      
      public static const RANK:int = 6;
      
      public static const metaDataMap:Dictionary = new Dictionary();
      
      metaDataMap[UID] = new FieldMetaData("uId",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[USERNAME] = new FieldMetaData("userName",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[SCORE] = new FieldMetaData("score",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
      metaDataMap[AREA] = new FieldMetaData("area",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[TIME] = new FieldMetaData("time",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[RANK] = new FieldMetaData("rank",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
      FieldMetaData.addStructMetaDataMap(OneScoreTop,metaDataMap);
      
      private var _uId:String;
      
      private var _userName:String;
      
      private var _score:int;
      
      private var _area:String;
      
      private var _time:String;
      
      private var _rank:int;
      
      private var __isset_score:Boolean = false;
      
      private var __isset_rank:Boolean = false;
      
      public function OneScoreTop()
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
      
      public function get time() : String
      {
         return this._time;
      }
      
      public function set time(param1:String) : void
      {
         this._time = param1;
      }
      
      public function unsetTime() : void
      {
         this.time = null;
      }
      
      public function isSetTime() : Boolean
      {
         return this.time != null;
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
            case TIME:
               if(param2 == null)
               {
                  this.unsetTime();
               }
               else
               {
                  this.time = param2;
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
            case USERNAME:
               return this.userName;
            case SCORE:
               return this.score;
            case AREA:
               return this.area;
            case TIME:
               return this.time;
            case RANK:
               return this.rank;
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
            case USERNAME:
               return this.isSetUserName();
            case SCORE:
               return this.isSetScore();
            case AREA:
               return this.isSetArea();
            case TIME:
               return this.isSetTime();
            case RANK:
               return this.isSetRank();
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
               case TIME:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.time = param1.readString();
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
         if(this.userName != null)
         {
            param1.writeFieldBegin(USER_NAME_FIELD_DESC);
            param1.writeString(this.userName);
            param1.writeFieldEnd();
         }
         param1.writeFieldBegin(SCORE_FIELD_DESC);
         param1.writeI32(this.score);
         param1.writeFieldEnd();
         if(this.area != null)
         {
            param1.writeFieldBegin(AREA_FIELD_DESC);
            param1.writeString(this.area);
            param1.writeFieldEnd();
         }
         if(this.time != null)
         {
            param1.writeFieldBegin(TIME_FIELD_DESC);
            param1.writeString(this.time);
            param1.writeFieldEnd();
         }
         param1.writeFieldBegin(RANK_FIELD_DESC);
         param1.writeI32(this.rank);
         param1.writeFieldEnd();
         param1.writeFieldStop();
         param1.writeStructEnd();
      }
      
      public function toString() : String
      {
         var _loc1_:String = new String("OneScoreTop(");
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
         _loc1_ += "time:";
         if(this.time == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.time;
         }
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "rank:";
         _loc1_ += this.rank;
         _loc2_ = false;
         return _loc1_ + ")";
      }
      
      public function validate() : void
      {
      }
   }
}

