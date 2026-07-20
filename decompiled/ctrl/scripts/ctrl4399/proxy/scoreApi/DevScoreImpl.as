package ctrl4399.proxy.scoreApi
{
   import org.apache.thrift.TApplicationError;
   import org.apache.thrift.TError;
   import org.apache.thrift.protocol.TMessage;
   import org.apache.thrift.protocol.TMessageType;
   import org.apache.thrift.protocol.TProtocol;
   
   public class DevScoreImpl implements DevScore
   {
      
      protected var iprot_:TProtocol;
      
      protected var oprot_:TProtocol;
      
      protected var seqid_:int;
      
      public function DevScoreImpl(param1:TProtocol, param2:TProtocol = null)
      {
         super();
         this.iprot_ = param1;
         if(param2 == null)
         {
            this.oprot_ = param1;
         }
         else
         {
            this.oprot_ = param2;
         }
      }
      
      public function getInputProtocol() : TProtocol
      {
         return this.iprot_;
      }
      
      public function getOutputProtocol() : TProtocol
      {
         return this.oprot_;
      }
      
      public function getTop(param1:int, param2:String, param3:int, param4:int, param5:Function, param6:Function) : void
      {
         var args:getTop_args;
         var gameId:int = param1;
         var type:String = param2;
         var start:int = param3;
         var length:int = param4;
         var onError:Function = param5;
         var onSuccess:Function = param6;
         this.oprot_.writeMessageBegin(new TMessage("getTop",TMessageType.CALL,this.seqid_));
         args = new getTop_args();
         args.gameId = gameId;
         args.type = type;
         args.start = start;
         args.length = length;
         args.write(this.oprot_);
         this.oprot_.writeMessageEnd();
         this.oprot_.getTransport().flush(function(param1:Error):void
         {
            var msg:TMessage = null;
            var result:getTop_result = null;
            var x:TApplicationError = null;
            var error:Error = param1;
            try
            {
               if(error != null)
               {
                  if(onError != null)
                  {
                     onError(error);
                  }
                  return;
               }
               msg = iprot_.readMessageBegin();
               if(msg.type == TMessageType.EXCEPTION)
               {
                  x = TApplicationError.read(iprot_);
                  iprot_.readMessageEnd();
                  if(onError != null)
                  {
                     onError(x);
                  }
                  return;
               }
               result = new getTop_result();
               result.read(iprot_);
               iprot_.readMessageEnd();
               if(result.isSetSuccess())
               {
                  if(onSuccess != null)
                  {
                     onSuccess(result.success);
                  }
                  return;
               }
               if(onError != null)
               {
                  onError(new TApplicationError(TApplicationError.MISSING_RESULT,"getTop failed: unknown result"));
               }
            }
            catch(e:TError)
            {
               if(onError != null)
               {
                  onError(e);
               }
            }
         });
      }
      
      public function submitScore(param1:int, param2:String, param3:int, param4:String, param5:String, param6:int, param7:int, param8:Function, param9:Function) : void
      {
         var args:submitScore_args;
         var gameId:int = param1;
         var uId:String = param2;
         var score:int = param3;
         var gameKey:String = param4;
         var verify:String = param5;
         var topNum:int = param6;
         var aroundNum:int = param7;
         var onError:Function = param8;
         var onSuccess:Function = param9;
         this.oprot_.writeMessageBegin(new TMessage("submitScore",TMessageType.CALL,this.seqid_));
         args = new submitScore_args();
         args.gameId = gameId;
         args.uId = uId;
         args.score = score;
         args.gameKey = gameKey;
         args.verify = verify;
         args.topNum = topNum;
         args.aroundNum = aroundNum;
         args.write(this.oprot_);
         this.oprot_.writeMessageEnd();
         this.oprot_.getTransport().flush(function(param1:Error):void
         {
            var msg:TMessage = null;
            var result:submitScore_result = null;
            var x:TApplicationError = null;
            var error:Error = param1;
            try
            {
               if(error != null)
               {
                  if(onError != null)
                  {
                     onError(error);
                  }
                  return;
               }
               msg = iprot_.readMessageBegin();
               if(msg.type == TMessageType.EXCEPTION)
               {
                  x = TApplicationError.read(iprot_);
                  iprot_.readMessageEnd();
                  if(onError != null)
                  {
                     onError(x);
                  }
                  return;
               }
               result = new submitScore_result();
               result.read(iprot_);
               iprot_.readMessageEnd();
               if(result.isSetSuccess())
               {
                  if(onSuccess != null)
                  {
                     onSuccess(result.success);
                  }
                  return;
               }
               if(onError != null)
               {
                  onError(new TApplicationError(TApplicationError.MISSING_RESULT,"submitScore failed: unknown result"));
               }
            }
            catch(e:TError)
            {
               if(onError != null)
               {
                  onError(e);
               }
            }
         });
      }
      
      public function test(param1:String, param2:Function, param3:Function) : void
      {
         var args:test_args;
         var name:String = param1;
         var onError:Function = param2;
         var onSuccess:Function = param3;
         this.oprot_.writeMessageBegin(new TMessage("test",TMessageType.CALL,this.seqid_));
         args = new test_args();
         args.name = name;
         args.write(this.oprot_);
         this.oprot_.writeMessageEnd();
         this.oprot_.getTransport().flush(function(param1:Error):void
         {
            var msg:TMessage = null;
            var result:test_result = null;
            var x:TApplicationError = null;
            var error:Error = param1;
            try
            {
               if(error != null)
               {
                  if(onError != null)
                  {
                     onError(error);
                  }
                  return;
               }
               msg = iprot_.readMessageBegin();
               if(msg.type == TMessageType.EXCEPTION)
               {
                  x = TApplicationError.read(iprot_);
                  iprot_.readMessageEnd();
                  if(onError != null)
                  {
                     onError(x);
                  }
                  return;
               }
               result = new test_result();
               result.read(iprot_);
               iprot_.readMessageEnd();
               if(result.isSetSuccess())
               {
                  if(onSuccess != null)
                  {
                     onSuccess(result.success);
                  }
                  return;
               }
               if(onError != null)
               {
                  onError(new TApplicationError(TApplicationError.MISSING_RESULT,"test failed: unknown result"));
               }
            }
            catch(e:TError)
            {
               if(onError != null)
               {
                  onError(e);
               }
            }
         });
      }
   }
}

import flash.utils.Dictionary;
import org.apache.thrift.*;
import org.apache.thrift.meta_data.*;
import org.apache.thrift.protocol.*;

class getTop_args implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("getTop_args");
   
   private static const GAME_ID_FIELD_DESC:TField = new TField("gameId",TType.I32,1);
   
   private static const TYPE_FIELD_DESC:TField = new TField("type",TType.STRING,2);
   
   private static const START_FIELD_DESC:TField = new TField("start",TType.I32,3);
   
   private static const LENGTH_FIELD_DESC:TField = new TField("length",TType.I32,4);
   
   public static const GAMEID:int = 1;
   
   public static const TYPE:int = 2;
   
   public static const START:int = 3;
   
   public static const LENGTH:int = 4;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[GAMEID] = new FieldMetaData("gameId",TFieldRequirementType.REQUIRED,new FieldValueMetaData(TType.I32));
   metaDataMap[TYPE] = new FieldMetaData("type",TFieldRequirementType.REQUIRED,new FieldValueMetaData(TType.STRING));
   metaDataMap[START] = new FieldMetaData("start",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
   metaDataMap[LENGTH] = new FieldMetaData("length",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
   FieldMetaData.addStructMetaDataMap(getTop_args,metaDataMap);
   
   private var _gameId:int;
   
   private var _type:String;
   
   private var _start:int;
   
   private var _length:int;
   
   private var __isset_gameId:Boolean = false;
   
   private var __isset_start:Boolean = false;
   
   private var __isset_length:Boolean = false;
   
   public function getTop_args()
   {
      super();
      this._start = 0;
      this._length = 15;
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
   
   public function get type() : String
   {
      return this._type;
   }
   
   public function set type(param1:String) : void
   {
      this._type = param1;
   }
   
   public function unsetType() : void
   {
      this.type = null;
   }
   
   public function isSetType() : Boolean
   {
      return this.type != null;
   }
   
   public function get start() : int
   {
      return this._start;
   }
   
   public function set start(param1:int) : void
   {
      this._start = param1;
      this.__isset_start = true;
   }
   
   public function unsetStart() : void
   {
      this.__isset_start = false;
   }
   
   public function isSetStart() : Boolean
   {
      return this.__isset_start;
   }
   
   public function get length() : int
   {
      return this._length;
   }
   
   public function set length(param1:int) : void
   {
      this._length = param1;
      this.__isset_length = true;
   }
   
   public function unsetLength() : void
   {
      this.__isset_length = false;
   }
   
   public function isSetLength() : Boolean
   {
      return this.__isset_length;
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
         case TYPE:
            if(param2 == null)
            {
               this.unsetType();
            }
            else
            {
               this.type = param2;
            }
            break;
         case START:
            if(param2 == null)
            {
               this.unsetStart();
            }
            else
            {
               this.start = param2;
            }
            break;
         case LENGTH:
            if(param2 == null)
            {
               this.unsetLength();
            }
            else
            {
               this.length = param2;
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
         case TYPE:
            return this.type;
         case START:
            return this.start;
         case LENGTH:
            return this.length;
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
         case TYPE:
            return this.isSetType();
         case START:
            return this.isSetStart();
         case LENGTH:
            return this.isSetLength();
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
            case TYPE:
               if(_loc2_.type == TType.STRING)
               {
                  this.type = param1.readString();
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case START:
               if(_loc2_.type == TType.I32)
               {
                  this.start = param1.readI32();
                  this.__isset_start = true;
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case LENGTH:
               if(_loc2_.type == TType.I32)
               {
                  this.length = param1.readI32();
                  this.__isset_length = true;
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
      if(!this.__isset_gameId)
      {
         throw new TProtocolError(TProtocolError.UNKNOWN,"Required field \'gameId\' was not found in serialized data! Struct: " + this.toString());
      }
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      this.validate();
      param1.writeStructBegin(STRUCT_DESC);
      param1.writeFieldBegin(GAME_ID_FIELD_DESC);
      param1.writeI32(this.gameId);
      param1.writeFieldEnd();
      if(this.type != null)
      {
         param1.writeFieldBegin(TYPE_FIELD_DESC);
         param1.writeString(this.type);
         param1.writeFieldEnd();
      }
      param1.writeFieldBegin(START_FIELD_DESC);
      param1.writeI32(this.start);
      param1.writeFieldEnd();
      param1.writeFieldBegin(LENGTH_FIELD_DESC);
      param1.writeI32(this.length);
      param1.writeFieldEnd();
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:String = new String("getTop_args(");
      var _loc2_:Boolean = true;
      _loc1_ += "gameId:";
      _loc1_ += this.gameId;
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "type:";
      if(this.type == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.type;
      }
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "start:";
      _loc1_ += this.start;
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "length:";
      _loc1_ += this.length;
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
      if(this.type == null)
      {
         throw new TProtocolError(TProtocolError.UNKNOWN,"Required field \'type\' was not present! Struct: " + this.toString());
      }
   }
}

class getTop_result implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("getTop_result");
   
   private static const SUCCESS_FIELD_DESC:TField = new TField("success",TType.STRUCT,0);
   
   public static const SUCCESS:int = 0;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[SUCCESS] = new FieldMetaData("success",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,ReturnScoreTop));
   FieldMetaData.addStructMetaDataMap(getTop_result,metaDataMap);
   
   private var _success:ReturnScoreTop;
   
   public function getTop_result()
   {
      super();
   }
   
   public function get success() : ReturnScoreTop
   {
      return this._success;
   }
   
   public function set success(param1:ReturnScoreTop) : void
   {
      this._success = param1;
   }
   
   public function unsetSuccess() : void
   {
      this.success = null;
   }
   
   public function isSetSuccess() : Boolean
   {
      return this.success != null;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case SUCCESS:
            if(param2 == null)
            {
               this.unsetSuccess();
            }
            else
            {
               this.success = param2;
            }
            return;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function getFieldValue(param1:int) : *
   {
      switch(param1)
      {
         case SUCCESS:
            return this.success;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case SUCCESS:
            return this.isSetSuccess();
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
            case SUCCESS:
               if(_loc2_.type == TType.STRUCT)
               {
                  this.success = new ReturnScoreTop();
                  this.success.read(param1);
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
      param1.writeStructBegin(STRUCT_DESC);
      if(this.isSetSuccess())
      {
         param1.writeFieldBegin(SUCCESS_FIELD_DESC);
         this.success.write(param1);
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:String = new String("getTop_result(");
      var _loc2_:Boolean = true;
      _loc1_ += "success:";
      if(this.success == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.success;
      }
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

class submitScore_args implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("submitScore_args");
   
   private static const GAME_ID_FIELD_DESC:TField = new TField("gameId",TType.I32,1);
   
   private static const U_ID_FIELD_DESC:TField = new TField("uId",TType.STRING,2);
   
   private static const SCORE_FIELD_DESC:TField = new TField("score",TType.I32,3);
   
   private static const GAME_KEY_FIELD_DESC:TField = new TField("gameKey",TType.STRING,4);
   
   private static const VERIFY_FIELD_DESC:TField = new TField("verify",TType.STRING,5);
   
   private static const TOP_NUM_FIELD_DESC:TField = new TField("topNum",TType.I32,6);
   
   private static const AROUND_NUM_FIELD_DESC:TField = new TField("aroundNum",TType.I32,7);
   
   public static const GAMEID:int = 1;
   
   public static const UID:int = 2;
   
   public static const SCORE:int = 3;
   
   public static const GAMEKEY:int = 4;
   
   public static const VERIFY:int = 5;
   
   public static const TOPNUM:int = 6;
   
   public static const AROUNDNUM:int = 7;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[GAMEID] = new FieldMetaData("gameId",TFieldRequirementType.REQUIRED,new FieldValueMetaData(TType.I32));
   metaDataMap[UID] = new FieldMetaData("uId",TFieldRequirementType.REQUIRED,new FieldValueMetaData(TType.STRING));
   metaDataMap[SCORE] = new FieldMetaData("score",TFieldRequirementType.REQUIRED,new FieldValueMetaData(TType.I32));
   metaDataMap[GAMEKEY] = new FieldMetaData("gameKey",TFieldRequirementType.REQUIRED,new FieldValueMetaData(TType.STRING));
   metaDataMap[VERIFY] = new FieldMetaData("verify",TFieldRequirementType.REQUIRED,new FieldValueMetaData(TType.STRING));
   metaDataMap[TOPNUM] = new FieldMetaData("topNum",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
   metaDataMap[AROUNDNUM] = new FieldMetaData("aroundNum",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
   FieldMetaData.addStructMetaDataMap(submitScore_args,metaDataMap);
   
   private var _gameId:int;
   
   private var _uId:String;
   
   private var _score:int;
   
   private var _gameKey:String;
   
   private var _verify:String;
   
   private var _topNum:int;
   
   private var _aroundNum:int;
   
   private var __isset_gameId:Boolean = false;
   
   private var __isset_score:Boolean = false;
   
   private var __isset_topNum:Boolean = false;
   
   private var __isset_aroundNum:Boolean = false;
   
   public function submitScore_args()
   {
      super();
      this._topNum = 0;
      this._aroundNum = 1;
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
   
   public function get gameKey() : String
   {
      return this._gameKey;
   }
   
   public function set gameKey(param1:String) : void
   {
      this._gameKey = param1;
   }
   
   public function unsetGameKey() : void
   {
      this.gameKey = null;
   }
   
   public function isSetGameKey() : Boolean
   {
      return this.gameKey != null;
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
   
   public function get topNum() : int
   {
      return this._topNum;
   }
   
   public function set topNum(param1:int) : void
   {
      this._topNum = param1;
      this.__isset_topNum = true;
   }
   
   public function unsetTopNum() : void
   {
      this.__isset_topNum = false;
   }
   
   public function isSetTopNum() : Boolean
   {
      return this.__isset_topNum;
   }
   
   public function get aroundNum() : int
   {
      return this._aroundNum;
   }
   
   public function set aroundNum(param1:int) : void
   {
      this._aroundNum = param1;
      this.__isset_aroundNum = true;
   }
   
   public function unsetAroundNum() : void
   {
      this.__isset_aroundNum = false;
   }
   
   public function isSetAroundNum() : Boolean
   {
      return this.__isset_aroundNum;
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
         case GAMEKEY:
            if(param2 == null)
            {
               this.unsetGameKey();
            }
            else
            {
               this.gameKey = param2;
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
         case TOPNUM:
            if(param2 == null)
            {
               this.unsetTopNum();
            }
            else
            {
               this.topNum = param2;
            }
            break;
         case AROUNDNUM:
            if(param2 == null)
            {
               this.unsetAroundNum();
            }
            else
            {
               this.aroundNum = param2;
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
         case SCORE:
            return this.score;
         case GAMEKEY:
            return this.gameKey;
         case VERIFY:
            return this.verify;
         case TOPNUM:
            return this.topNum;
         case AROUNDNUM:
            return this.aroundNum;
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
         case SCORE:
            return this.isSetScore();
         case GAMEKEY:
            return this.isSetGameKey();
         case VERIFY:
            return this.isSetVerify();
         case TOPNUM:
            return this.isSetTopNum();
         case AROUNDNUM:
            return this.isSetAroundNum();
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
            case GAMEKEY:
               if(_loc2_.type == TType.STRING)
               {
                  this.gameKey = param1.readString();
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
            case TOPNUM:
               if(_loc2_.type == TType.I32)
               {
                  this.topNum = param1.readI32();
                  this.__isset_topNum = true;
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case AROUNDNUM:
               if(_loc2_.type == TType.I32)
               {
                  this.aroundNum = param1.readI32();
                  this.__isset_aroundNum = true;
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
      if(!this.__isset_gameId)
      {
         throw new TProtocolError(TProtocolError.UNKNOWN,"Required field \'gameId\' was not found in serialized data! Struct: " + this.toString());
      }
      if(!this.__isset_score)
      {
         throw new TProtocolError(TProtocolError.UNKNOWN,"Required field \'score\' was not found in serialized data! Struct: " + this.toString());
      }
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      this.validate();
      param1.writeStructBegin(STRUCT_DESC);
      param1.writeFieldBegin(GAME_ID_FIELD_DESC);
      param1.writeI32(this.gameId);
      param1.writeFieldEnd();
      if(this.uId != null)
      {
         param1.writeFieldBegin(U_ID_FIELD_DESC);
         param1.writeString(this.uId);
         param1.writeFieldEnd();
      }
      param1.writeFieldBegin(SCORE_FIELD_DESC);
      param1.writeI32(this.score);
      param1.writeFieldEnd();
      if(this.gameKey != null)
      {
         param1.writeFieldBegin(GAME_KEY_FIELD_DESC);
         param1.writeString(this.gameKey);
         param1.writeFieldEnd();
      }
      if(this.verify != null)
      {
         param1.writeFieldBegin(VERIFY_FIELD_DESC);
         param1.writeString(this.verify);
         param1.writeFieldEnd();
      }
      param1.writeFieldBegin(TOP_NUM_FIELD_DESC);
      param1.writeI32(this.topNum);
      param1.writeFieldEnd();
      param1.writeFieldBegin(AROUND_NUM_FIELD_DESC);
      param1.writeI32(this.aroundNum);
      param1.writeFieldEnd();
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:String = new String("submitScore_args(");
      var _loc2_:Boolean = true;
      _loc1_ += "gameId:";
      _loc1_ += this.gameId;
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
      _loc1_ += "score:";
      _loc1_ += this.score;
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "gameKey:";
      if(this.gameKey == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.gameKey;
      }
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
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "topNum:";
      _loc1_ += this.topNum;
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "aroundNum:";
      _loc1_ += this.aroundNum;
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
      if(this.uId == null)
      {
         throw new TProtocolError(TProtocolError.UNKNOWN,"Required field \'uId\' was not present! Struct: " + this.toString());
      }
      if(this.gameKey == null)
      {
         throw new TProtocolError(TProtocolError.UNKNOWN,"Required field \'gameKey\' was not present! Struct: " + this.toString());
      }
      if(this.verify == null)
      {
         throw new TProtocolError(TProtocolError.UNKNOWN,"Required field \'verify\' was not present! Struct: " + this.toString());
      }
   }
}

class submitScore_result implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("submitScore_result");
   
   private static const SUCCESS_FIELD_DESC:TField = new TField("success",TType.STRUCT,0);
   
   public static const SUCCESS:int = 0;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[SUCCESS] = new FieldMetaData("success",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,ReturnSubmitScore));
   FieldMetaData.addStructMetaDataMap(submitScore_result,metaDataMap);
   
   private var _success:ReturnSubmitScore;
   
   public function submitScore_result()
   {
      super();
   }
   
   public function get success() : ReturnSubmitScore
   {
      return this._success;
   }
   
   public function set success(param1:ReturnSubmitScore) : void
   {
      this._success = param1;
   }
   
   public function unsetSuccess() : void
   {
      this.success = null;
   }
   
   public function isSetSuccess() : Boolean
   {
      return this.success != null;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case SUCCESS:
            if(param2 == null)
            {
               this.unsetSuccess();
            }
            else
            {
               this.success = param2;
            }
            return;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function getFieldValue(param1:int) : *
   {
      switch(param1)
      {
         case SUCCESS:
            return this.success;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case SUCCESS:
            return this.isSetSuccess();
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
            case SUCCESS:
               if(_loc2_.type == TType.STRUCT)
               {
                  this.success = new ReturnSubmitScore();
                  this.success.read(param1);
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
      param1.writeStructBegin(STRUCT_DESC);
      if(this.isSetSuccess())
      {
         param1.writeFieldBegin(SUCCESS_FIELD_DESC);
         this.success.write(param1);
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:String = new String("submitScore_result(");
      var _loc2_:Boolean = true;
      _loc1_ += "success:";
      if(this.success == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.success;
      }
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

class test_args implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("test_args");
   
   private static const NAME_FIELD_DESC:TField = new TField("name",TType.STRING,1);
   
   public static const NAME:int = 1;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[NAME] = new FieldMetaData("name",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
   FieldMetaData.addStructMetaDataMap(test_args,metaDataMap);
   
   private var _name:String;
   
   public function test_args()
   {
      super();
      this._name = "";
   }
   
   public function get name() : String
   {
      return this._name;
   }
   
   public function set name(param1:String) : void
   {
      this._name = param1;
   }
   
   public function unsetName() : void
   {
      this.name = null;
   }
   
   public function isSetName() : Boolean
   {
      return this.name != null;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case NAME:
            if(param2 == null)
            {
               this.unsetName();
            }
            else
            {
               this.name = param2;
            }
            return;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function getFieldValue(param1:int) : *
   {
      switch(param1)
      {
         case NAME:
            return this.name;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case NAME:
            return this.isSetName();
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
            case NAME:
               if(_loc2_.type == TType.STRING)
               {
                  this.name = param1.readString();
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
      if(this.name != null)
      {
         param1.writeFieldBegin(NAME_FIELD_DESC);
         param1.writeString(this.name);
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:String = new String("test_args(");
      var _loc2_:Boolean = true;
      _loc1_ += "name:";
      if(this.name == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.name;
      }
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

class test_result implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("test_result");
   
   private static const SUCCESS_FIELD_DESC:TField = new TField("success",TType.STRING,0);
   
   public static const SUCCESS:int = 0;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[SUCCESS] = new FieldMetaData("success",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
   FieldMetaData.addStructMetaDataMap(test_result,metaDataMap);
   
   private var _success:String;
   
   public function test_result()
   {
      super();
   }
   
   public function get success() : String
   {
      return this._success;
   }
   
   public function set success(param1:String) : void
   {
      this._success = param1;
   }
   
   public function unsetSuccess() : void
   {
      this.success = null;
   }
   
   public function isSetSuccess() : Boolean
   {
      return this.success != null;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case SUCCESS:
            if(param2 == null)
            {
               this.unsetSuccess();
            }
            else
            {
               this.success = param2;
            }
            return;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function getFieldValue(param1:int) : *
   {
      switch(param1)
      {
         case SUCCESS:
            return this.success;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case SUCCESS:
            return this.isSetSuccess();
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
            case SUCCESS:
               if(_loc2_.type == TType.STRING)
               {
                  this.success = param1.readString();
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
      param1.writeStructBegin(STRUCT_DESC);
      if(this.isSetSuccess())
      {
         param1.writeFieldBegin(SUCCESS_FIELD_DESC);
         param1.writeString(this.success);
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:String = new String("test_result(");
      var _loc2_:Boolean = true;
      _loc1_ += "success:";
      if(this.success == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.success;
      }
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}
