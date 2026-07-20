package ctrl4399.proxy.rankListApi
{
   import flash.utils.Dictionary;
   import org.apache.thrift.*;
   import org.apache.thrift.meta_data.*;
   import org.apache.thrift.protocol.*;
   
   public class FSQE_Submit implements TBase
   {
      
      private static const STRUCT_DESC:TStruct = new TStruct("FSQE_Submit");
      
      private static const R_ID_FIELD_DESC:TField = new TField("rId",TType.I32,1);
      
      private static const SCORE_FIELD_DESC:TField = new TField("score",TType.I32,2);
      
      private static const EXTRA_FIELD_DESC:TField = new TField("extra",TType.STRING,3);
      
      public static const RID:int = 1;
      
      public static const SCORE:int = 2;
      
      public static const EXTRA:int = 3;
      
      public static const metaDataMap:Dictionary = new Dictionary();
      
      metaDataMap[RID] = new FieldMetaData("rId",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
      metaDataMap[SCORE] = new FieldMetaData("score",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
      metaDataMap[EXTRA] = new FieldMetaData("extra",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      FieldMetaData.addStructMetaDataMap(FSQE_Submit,metaDataMap);
      
      private var _rId:int;
      
      private var _score:int;
      
      private var _extra:String;
      
      private var __isset_rId:Boolean = false;
      
      private var __isset_score:Boolean = false;
      
      public function FSQE_Submit()
      {
         super();
      }
      
      public function get rId() : int
      {
         return this._rId;
      }
      
      public function set rId(param1:int) : void
      {
         this._rId = param1;
         this.__isset_rId = true;
      }
      
      public function unsetRId() : void
      {
         this.__isset_rId = false;
      }
      
      public function isSetRId() : Boolean
      {
         return this.__isset_rId;
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
            case RID:
               if(param2 == null)
               {
                  this.unsetRId();
               }
               else
               {
                  this.rId = param2;
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
            case RID:
               return this.rId;
            case SCORE:
               return this.score;
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
            case RID:
               return this.isSetRId();
            case SCORE:
               return this.isSetScore();
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
               case RID:
                  if(_loc2_.type == TType.I32)
                  {
                     this.rId = param1.readI32();
                     this.__isset_rId = true;
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
         param1.writeFieldBegin(R_ID_FIELD_DESC);
         param1.writeI32(this.rId);
         param1.writeFieldEnd();
         param1.writeFieldBegin(SCORE_FIELD_DESC);
         param1.writeI32(this.score);
         param1.writeFieldEnd();
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
         var _loc1_:String = new String("FSQE_Submit(");
         var _loc2_:Boolean = true;
         _loc1_ += "rId:";
         _loc1_ += this.rId;
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

