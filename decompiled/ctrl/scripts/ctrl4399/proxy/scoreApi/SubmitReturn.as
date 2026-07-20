package ctrl4399.proxy.scoreApi
{
   import flash.utils.Dictionary;
   import org.apache.thrift.*;
   import org.apache.thrift.meta_data.*;
   import org.apache.thrift.protocol.*;
   
   public class SubmitReturn implements TBase
   {
      
      private static const STRUCT_DESC:TStruct = new TStruct("SubmitReturn");
      
      private static const SCORE_FIELD_DESC:TField = new TField("score",TType.I32,1);
      
      private static const RANK_FIELD_DESC:TField = new TField("rank",TType.I32,2);
      
      private static const GET_MEDAL_FIELD_DESC:TField = new TField("getMedal",TType.BOOL,3);
      
      private static const MEDAL_FIELD_DESC:TField = new TField("medal",TType.I32,4);
      
      private static const MAX_SCORE_FIELD_DESC:TField = new TField("maxScore",TType.I32,5);
      
      private static const MAX_RANK_FIELD_DESC:TField = new TField("maxRank",TType.I32,6);
      
      private static const MESSAGE_FIELD_DESC:TField = new TField("message",TType.STRING,7);
      
      private static const RANKING_LENGTH_FIELD_DESC:TField = new TField("rankingLength",TType.I32,8);
      
      private static const RANKING_FIELD_DESC:TField = new TField("ranking",TType.MAP,9);
      
      public static const SCORE:int = 1;
      
      public static const RANK:int = 2;
      
      public static const GETMEDAL:int = 3;
      
      public static const MEDAL:int = 4;
      
      public static const MAXSCORE:int = 5;
      
      public static const MAXRANK:int = 6;
      
      public static const MESSAGE:int = 7;
      
      public static const RANKINGLENGTH:int = 8;
      
      public static const RANKING:int = 9;
      
      public static const metaDataMap:Dictionary = new Dictionary();
      
      metaDataMap[SCORE] = new FieldMetaData("score",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
      metaDataMap[RANK] = new FieldMetaData("rank",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
      metaDataMap[GETMEDAL] = new FieldMetaData("getMedal",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.BOOL));
      metaDataMap[MEDAL] = new FieldMetaData("medal",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
      metaDataMap[MAXSCORE] = new FieldMetaData("maxScore",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
      metaDataMap[MAXRANK] = new FieldMetaData("maxRank",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
      metaDataMap[MESSAGE] = new FieldMetaData("message",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[RANKINGLENGTH] = new FieldMetaData("rankingLength",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
      metaDataMap[RANKING] = new FieldMetaData("ranking",TFieldRequirementType.DEFAULT,new MapMetaData(TType.MAP,new FieldValueMetaData(TType.I32),new StructMetaData(TType.STRUCT,OneScoreRank)));
      FieldMetaData.addStructMetaDataMap(SubmitReturn,metaDataMap);
      
      private var _score:int;
      
      private var _rank:int;
      
      private var _getMedal:Boolean;
      
      private var _medal:int;
      
      private var _maxScore:int;
      
      private var _maxRank:int;
      
      private var _message:String;
      
      private var _rankingLength:int;
      
      private var _ranking:Dictionary;
      
      private var __isset_score:Boolean = false;
      
      private var __isset_rank:Boolean = false;
      
      private var __isset_getMedal:Boolean = false;
      
      private var __isset_medal:Boolean = false;
      
      private var __isset_maxScore:Boolean = false;
      
      private var __isset_maxRank:Boolean = false;
      
      private var __isset_rankingLength:Boolean = false;
      
      public function SubmitReturn()
      {
         super();
         this._getMedal = false;
         this._medal = 0;
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
      
      public function get getMedal() : Boolean
      {
         return this._getMedal;
      }
      
      public function set getMedal(param1:Boolean) : void
      {
         this._getMedal = param1;
         this.__isset_getMedal = true;
      }
      
      public function unsetGetMedal() : void
      {
         this.__isset_getMedal = false;
      }
      
      public function isSetGetMedal() : Boolean
      {
         return this.__isset_getMedal;
      }
      
      public function get medal() : int
      {
         return this._medal;
      }
      
      public function set medal(param1:int) : void
      {
         this._medal = param1;
         this.__isset_medal = true;
      }
      
      public function unsetMedal() : void
      {
         this.__isset_medal = false;
      }
      
      public function isSetMedal() : Boolean
      {
         return this.__isset_medal;
      }
      
      public function get maxScore() : int
      {
         return this._maxScore;
      }
      
      public function set maxScore(param1:int) : void
      {
         this._maxScore = param1;
         this.__isset_maxScore = true;
      }
      
      public function unsetMaxScore() : void
      {
         this.__isset_maxScore = false;
      }
      
      public function isSetMaxScore() : Boolean
      {
         return this.__isset_maxScore;
      }
      
      public function get maxRank() : int
      {
         return this._maxRank;
      }
      
      public function set maxRank(param1:int) : void
      {
         this._maxRank = param1;
         this.__isset_maxRank = true;
      }
      
      public function unsetMaxRank() : void
      {
         this.__isset_maxRank = false;
      }
      
      public function isSetMaxRank() : Boolean
      {
         return this.__isset_maxRank;
      }
      
      public function get message() : String
      {
         return this._message;
      }
      
      public function set message(param1:String) : void
      {
         this._message = param1;
      }
      
      public function unsetMessage() : void
      {
         this.message = null;
      }
      
      public function isSetMessage() : Boolean
      {
         return this.message != null;
      }
      
      public function get rankingLength() : int
      {
         return this._rankingLength;
      }
      
      public function set rankingLength(param1:int) : void
      {
         this._rankingLength = param1;
         this.__isset_rankingLength = true;
      }
      
      public function unsetRankingLength() : void
      {
         this.__isset_rankingLength = false;
      }
      
      public function isSetRankingLength() : Boolean
      {
         return this.__isset_rankingLength;
      }
      
      public function get ranking() : Dictionary
      {
         return this._ranking;
      }
      
      public function set ranking(param1:Dictionary) : void
      {
         this._ranking = param1;
      }
      
      public function unsetRanking() : void
      {
         this.ranking = null;
      }
      
      public function isSetRanking() : Boolean
      {
         return this.ranking != null;
      }
      
      public function setFieldValue(param1:int, param2:*) : void
      {
         switch(param1)
         {
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
            case GETMEDAL:
               if(param2 == null)
               {
                  this.unsetGetMedal();
               }
               else
               {
                  this.getMedal = param2;
               }
               break;
            case MEDAL:
               if(param2 == null)
               {
                  this.unsetMedal();
               }
               else
               {
                  this.medal = param2;
               }
               break;
            case MAXSCORE:
               if(param2 == null)
               {
                  this.unsetMaxScore();
               }
               else
               {
                  this.maxScore = param2;
               }
               break;
            case MAXRANK:
               if(param2 == null)
               {
                  this.unsetMaxRank();
               }
               else
               {
                  this.maxRank = param2;
               }
               break;
            case MESSAGE:
               if(param2 == null)
               {
                  this.unsetMessage();
               }
               else
               {
                  this.message = param2;
               }
               break;
            case RANKINGLENGTH:
               if(param2 == null)
               {
                  this.unsetRankingLength();
               }
               else
               {
                  this.rankingLength = param2;
               }
               break;
            case RANKING:
               if(param2 == null)
               {
                  this.unsetRanking();
               }
               else
               {
                  this.ranking = param2;
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
            case SCORE:
               return this.score;
            case RANK:
               return this.rank;
            case GETMEDAL:
               return this.getMedal;
            case MEDAL:
               return this.medal;
            case MAXSCORE:
               return this.maxScore;
            case MAXRANK:
               return this.maxRank;
            case MESSAGE:
               return this.message;
            case RANKINGLENGTH:
               return this.rankingLength;
            case RANKING:
               return this.ranking;
            default:
               throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
         }
      }
      
      public function isSet(param1:int) : Boolean
      {
         switch(param1)
         {
            case SCORE:
               return this.isSetScore();
            case RANK:
               return this.isSetRank();
            case GETMEDAL:
               return this.isSetGetMedal();
            case MEDAL:
               return this.isSetMedal();
            case MAXSCORE:
               return this.isSetMaxScore();
            case MAXRANK:
               return this.isSetMaxRank();
            case MESSAGE:
               return this.isSetMessage();
            case RANKINGLENGTH:
               return this.isSetRankingLength();
            case RANKING:
               return this.isSetRanking();
            default:
               throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
         }
      }
      
      public function read(param1:TProtocol) : void
      {
         var _loc2_:TField = null;
         var _loc3_:TMap = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:OneScoreRank = null;
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
               case GETMEDAL:
                  if(_loc2_.type == TType.BOOL)
                  {
                     this.getMedal = param1.readBool();
                     this.__isset_getMedal = true;
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case MEDAL:
                  if(_loc2_.type == TType.I32)
                  {
                     this.medal = param1.readI32();
                     this.__isset_medal = true;
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case MAXSCORE:
                  if(_loc2_.type == TType.I32)
                  {
                     this.maxScore = param1.readI32();
                     this.__isset_maxScore = true;
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case MAXRANK:
                  if(_loc2_.type == TType.I32)
                  {
                     this.maxRank = param1.readI32();
                     this.__isset_maxRank = true;
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case MESSAGE:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.message = param1.readString();
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case RANKINGLENGTH:
                  if(_loc2_.type == TType.I32)
                  {
                     this.rankingLength = param1.readI32();
                     this.__isset_rankingLength = true;
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case RANKING:
                  if(_loc2_.type == TType.MAP)
                  {
                     _loc3_ = param1.readMapBegin();
                     this.ranking = new Dictionary();
                     _loc4_ = 0;
                     while(_loc4_ < _loc3_.size)
                     {
                        _loc5_ = param1.readI32();
                        _loc6_ = new OneScoreRank();
                        _loc6_.read(param1);
                        this.ranking[_loc5_] = _loc6_;
                        _loc4_++;
                     }
                     param1.readMapEnd();
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
         var _loc2_:int = 0;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         this.validate();
         param1.writeStructBegin(STRUCT_DESC);
         param1.writeFieldBegin(SCORE_FIELD_DESC);
         param1.writeI32(this.score);
         param1.writeFieldEnd();
         param1.writeFieldBegin(RANK_FIELD_DESC);
         param1.writeI32(this.rank);
         param1.writeFieldEnd();
         param1.writeFieldBegin(GET_MEDAL_FIELD_DESC);
         param1.writeBool(this.getMedal);
         param1.writeFieldEnd();
         param1.writeFieldBegin(MEDAL_FIELD_DESC);
         param1.writeI32(this.medal);
         param1.writeFieldEnd();
         param1.writeFieldBegin(MAX_SCORE_FIELD_DESC);
         param1.writeI32(this.maxScore);
         param1.writeFieldEnd();
         param1.writeFieldBegin(MAX_RANK_FIELD_DESC);
         param1.writeI32(this.maxRank);
         param1.writeFieldEnd();
         if(this.message != null)
         {
            param1.writeFieldBegin(MESSAGE_FIELD_DESC);
            param1.writeString(this.message);
            param1.writeFieldEnd();
         }
         param1.writeFieldBegin(RANKING_LENGTH_FIELD_DESC);
         param1.writeI32(this.rankingLength);
         param1.writeFieldEnd();
         if(this.ranking != null)
         {
            param1.writeFieldBegin(RANKING_FIELD_DESC);
            _loc2_ = 0;
            for(_loc3_ in this.ranking)
            {
               _loc2_++;
            }
            param1.writeMapBegin(new TMap(TType.I32,TType.STRUCT,_loc2_));
            for(_loc4_ in this.ranking)
            {
               param1.writeI32(_loc4_);
               this.ranking[_loc4_].write(param1);
            }
            param1.writeMapEnd();
            param1.writeFieldEnd();
         }
         param1.writeFieldStop();
         param1.writeStructEnd();
      }
      
      public function toString() : String
      {
         var _loc1_:String = new String("SubmitReturn(");
         var _loc2_:Boolean = true;
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
         _loc1_ += "getMedal:";
         _loc1_ += this.getMedal;
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "medal:";
         _loc1_ += this.medal;
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "maxScore:";
         _loc1_ += this.maxScore;
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "maxRank:";
         _loc1_ += this.maxRank;
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "message:";
         if(this.message == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.message;
         }
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "rankingLength:";
         _loc1_ += this.rankingLength;
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "ranking:";
         if(this.ranking == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.ranking;
         }
         _loc2_ = false;
         return _loc1_ + ")";
      }
      
      public function validate() : void
      {
      }
   }
}

