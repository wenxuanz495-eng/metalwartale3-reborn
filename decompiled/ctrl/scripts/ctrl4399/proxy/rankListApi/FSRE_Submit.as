package ctrl4399.proxy.rankListApi
{
   import flash.utils.Dictionary;
   import org.apache.thrift.*;
   import org.apache.thrift.meta_data.*;
   import org.apache.thrift.protocol.*;
   
   public class FSRE_Submit implements TBase
   {
      
      private static const STRUCT_DESC:TStruct = new TStruct("FSRE_Submit");
      
      private static const SCORE_FIELD_DESC:TField = new TField("score",TType.I32,1);
      
      private static const RANK_FIELD_DESC:TField = new TField("rank",TType.I32,2);
      
      private static const SCORE_LAST_FIELD_DESC:TField = new TField("scoreLast",TType.I32,3);
      
      private static const RANK_LAST_FIELD_DESC:TField = new TField("rankLast",TType.I32,4);
      
      public static const SCORE:int = 1;
      
      public static const RANK:int = 2;
      
      public static const SCORELAST:int = 3;
      
      public static const RANKLAST:int = 4;
      
      public static const metaDataMap:Dictionary = new Dictionary();
      
      metaDataMap[SCORE] = new FieldMetaData("score",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
      metaDataMap[RANK] = new FieldMetaData("rank",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
      metaDataMap[SCORELAST] = new FieldMetaData("scoreLast",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
      metaDataMap[RANKLAST] = new FieldMetaData("rankLast",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
      FieldMetaData.addStructMetaDataMap(FSRE_Submit,metaDataMap);
      
      private var _score:int;
      
      private var _rank:int;
      
      private var _scoreLast:int;
      
      private var _rankLast:int;
      
      private var __isset_score:Boolean = false;
      
      private var __isset_rank:Boolean = false;
      
      private var __isset_scoreLast:Boolean = false;
      
      private var __isset_rankLast:Boolean = false;
      
      public function FSRE_Submit()
      {
         super();
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
      
      public function get scoreLast() : int
      {
         return this._scoreLast;
      }
      
      public function set scoreLast(param1:int) : void
      {
         this._scoreLast = param1;
         this.__isset_scoreLast = true;
      }
      
      public function unsetScoreLast() : void
      {
         this.__isset_scoreLast = false;
      }
      
      public function isSetScoreLast() : Boolean
      {
         return this.__isset_scoreLast;
      }
      
      public function get rankLast() : int
      {
         return this._rankLast;
      }
      
      public function set rankLast(param1:int) : void
      {
         this._rankLast = param1;
         this.__isset_rankLast = true;
      }
      
      public function unsetRankLast() : void
      {
         this.__isset_rankLast = false;
      }
      
      public function isSetRankLast() : Boolean
      {
         return this.__isset_rankLast;
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
            case SCORELAST:
               if(param2 == null)
               {
                  this.unsetScoreLast();
               }
               else
               {
                  this.scoreLast = param2;
               }
               break;
            case RANKLAST:
               if(param2 == null)
               {
                  this.unsetRankLast();
               }
               else
               {
                  this.rankLast = param2;
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
            case SCORELAST:
               return this.scoreLast;
            case RANKLAST:
               return this.rankLast;
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
            case SCORELAST:
               return this.isSetScoreLast();
            case RANKLAST:
               return this.isSetRankLast();
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
               case SCORELAST:
                  if(_loc2_.type == TType.I32)
                  {
                     this.scoreLast = param1.readI32();
                     this.__isset_scoreLast = true;
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case RANKLAST:
                  if(_loc2_.type == TType.I32)
                  {
                     this.rankLast = param1.readI32();
                     this.__isset_rankLast = true;
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
         param1.writeFieldBegin(SCORE_FIELD_DESC);
         param1.writeI32(this.score);
         param1.writeFieldEnd();
         param1.writeFieldBegin(RANK_FIELD_DESC);
         param1.writeI32(this.rank);
         param1.writeFieldEnd();
         param1.writeFieldBegin(SCORE_LAST_FIELD_DESC);
         param1.writeI32(this.scoreLast);
         param1.writeFieldEnd();
         param1.writeFieldBegin(RANK_LAST_FIELD_DESC);
         param1.writeI32(this.rankLast);
         param1.writeFieldEnd();
         param1.writeFieldStop();
         param1.writeStructEnd();
      }
      
      public function toString() : String
      {
         var _loc1_:String = new String("FSRE_Submit(");
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
         _loc1_ += "scoreLast:";
         _loc1_ += this.scoreLast;
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "rankLast:";
         _loc1_ += this.rankLast;
         _loc2_ = false;
         return _loc1_ + ")";
      }
      
      public function validate() : void
      {
      }
   }
}

