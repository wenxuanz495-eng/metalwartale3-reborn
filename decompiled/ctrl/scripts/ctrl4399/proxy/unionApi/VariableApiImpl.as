package ctrl4399.proxy.unionApi
{
   import org.apache.thrift.TApplicationError;
   import org.apache.thrift.TError;
   import org.apache.thrift.protocol.TMessage;
   import org.apache.thrift.protocol.TMessageType;
   import org.apache.thrift.protocol.TProtocol;
   
   public class VariableApiImpl implements VariableApi
   {
      
      protected var iprot_:TProtocol;
      
      protected var oprot_:TProtocol;
      
      protected var seqid_:int;
      
      public function VariableApiImpl(param1:TProtocol, param2:TProtocol = null)
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
      
      public function getVariables(param1:ApiHeader, param2:Array, param3:Function, param4:Function) : void
      {
         var args:getVariables_args;
         var header:ApiHeader = param1;
         var id:Array = param2;
         var onError:Function = param3;
         var onSuccess:Function = param4;
         this.oprot_.writeMessageBegin(new TMessage("getVariables",TMessageType.CALL,this.seqid_));
         args = new getVariables_args();
         args.header = header;
         args.id = id;
         args.write(this.oprot_);
         this.oprot_.writeMessageEnd();
         this.oprot_.getTransport().flush(function(param1:Error):void
         {
            var msg:TMessage = null;
            var result:getVariables_result = null;
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
               result = new getVariables_result();
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
               if(result.e != null)
               {
                  if(onError != null)
                  {
                     onError(result.e);
                  }
                  return;
               }
               if(onError != null)
               {
                  onError(new TApplicationError(TApplicationError.MISSING_RESULT,"getVariables failed: unknown result"));
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
      
      public function doVariable(param1:ApiHeader, param2:int, param3:Function, param4:Function) : void
      {
         var args:doVariable_args;
         var header:ApiHeader = param1;
         var id:int = param2;
         var onError:Function = param3;
         var onSuccess:Function = param4;
         this.oprot_.writeMessageBegin(new TMessage("doVariable",TMessageType.CALL,this.seqid_));
         args = new doVariable_args();
         args.header = header;
         args.id = id;
         args.write(this.oprot_);
         this.oprot_.writeMessageEnd();
         this.oprot_.getTransport().flush(function(param1:Error):void
         {
            var msg:TMessage = null;
            var result:doVariable_result = null;
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
               result = new doVariable_result();
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
               if(result.e != null)
               {
                  if(onError != null)
                  {
                     onError(result.e);
                  }
                  return;
               }
               if(onError != null)
               {
                  onError(new TApplicationError(TApplicationError.MISSING_RESULT,"doVariable failed: unknown result"));
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

class getVariables_args implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("getVariables_args");
   
   private static const HEADER_FIELD_DESC:TField = new TField("header",TType.STRUCT,1);
   
   private static const ID_FIELD_DESC:TField = new TField("id",TType.LIST,2);
   
   public static const HEADER:int = 1;
   
   public static const ID:int = 2;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[HEADER] = new FieldMetaData("header",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,ApiHeader));
   metaDataMap[ID] = new FieldMetaData("id",TFieldRequirementType.DEFAULT,new ListMetaData(TType.LIST,new FieldValueMetaData(TType.I32)));
   FieldMetaData.addStructMetaDataMap(getVariables_args,metaDataMap);
   
   private var _header:ApiHeader;
   
   private var _id:Array;
   
   public function getVariables_args()
   {
      super();
   }
   
   public function get header() : ApiHeader
   {
      return this._header;
   }
   
   public function set header(param1:ApiHeader) : void
   {
      this._header = param1;
   }
   
   public function unsetHeader() : void
   {
      this.header = null;
   }
   
   public function isSetHeader() : Boolean
   {
      return this.header != null;
   }
   
   public function get id() : Array
   {
      return this._id;
   }
   
   public function set id(param1:Array) : void
   {
      this._id = param1;
   }
   
   public function unsetId() : void
   {
      this.id = null;
   }
   
   public function isSetId() : Boolean
   {
      return this.id != null;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case HEADER:
            if(param2 == null)
            {
               this.unsetHeader();
            }
            else
            {
               this.header = param2;
            }
            break;
         case ID:
            if(param2 == null)
            {
               this.unsetId();
            }
            else
            {
               this.id = param2;
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
         case HEADER:
            return this.header;
         case ID:
            return this.id;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case HEADER:
            return this.isSetHeader();
         case ID:
            return this.isSetId();
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function read(param1:TProtocol) : void
   {
      var _loc2_:TField = null;
      var _loc3_:TList = null;
      var _loc4_:int = 0;
      var _loc5_:int = 0;
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
            case HEADER:
               if(_loc2_.type == TType.STRUCT)
               {
                  this.header = new ApiHeader();
                  this.header.read(param1);
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case ID:
               if(_loc2_.type == TType.LIST)
               {
                  _loc3_ = param1.readListBegin();
                  this.id = new Array();
                  _loc4_ = 0;
                  while(_loc4_ < _loc3_.size)
                  {
                     _loc5_ = param1.readI32();
                     this.id.push(_loc5_);
                     _loc4_++;
                  }
                  param1.readListEnd();
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
      var _loc2_:* = undefined;
      this.validate();
      param1.writeStructBegin(STRUCT_DESC);
      if(this.header != null)
      {
         param1.writeFieldBegin(HEADER_FIELD_DESC);
         this.header.write(param1);
         param1.writeFieldEnd();
      }
      if(this.id != null)
      {
         param1.writeFieldBegin(ID_FIELD_DESC);
         param1.writeListBegin(new TList(TType.I32,this.id.length));
         for each(_loc2_ in this.id)
         {
            param1.writeI32(_loc2_);
         }
         param1.writeListEnd();
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:String = new String("getVariables_args(");
      var _loc2_:Boolean = true;
      _loc1_ += "header:";
      if(this.header == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.header;
      }
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "id:";
      if(this.id == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.id;
      }
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

class getVariables_result implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("getVariables_result");
   
   private static const SUCCESS_FIELD_DESC:TField = new TField("success",TType.STRUCT,0);
   
   private static const E_FIELD_DESC:TField = new TField("e",TType.STRUCT,1);
   
   public static const SUCCESS:int = 0;
   
   public static const E:int = 1;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[SUCCESS] = new FieldMetaData("success",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,RES_Variables));
   metaDataMap[E] = new FieldMetaData("e",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRUCT));
   FieldMetaData.addStructMetaDataMap(getVariables_result,metaDataMap);
   
   private var _success:RES_Variables;
   
   private var _e:Err;
   
   public function getVariables_result()
   {
      super();
   }
   
   public function get success() : RES_Variables
   {
      return this._success;
   }
   
   public function set success(param1:RES_Variables) : void
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
   
   public function get e() : Err
   {
      return this._e;
   }
   
   public function set e(param1:Err) : void
   {
      this._e = param1;
   }
   
   public function unsetE() : void
   {
      this.e = null;
   }
   
   public function isSetE() : Boolean
   {
      return this.e != null;
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
            break;
         case E:
            if(param2 == null)
            {
               this.unsetE();
            }
            else
            {
               this.e = param2;
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
         case SUCCESS:
            return this.success;
         case E:
            return this.e;
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
         case E:
            return this.isSetE();
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
                  this.success = new RES_Variables();
                  this.success.read(param1);
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case E:
               if(_loc2_.type == TType.STRUCT)
               {
                  this.e = new Err();
                  this.e.read(param1);
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
      else if(this.isSetE())
      {
         param1.writeFieldBegin(E_FIELD_DESC);
         this.e.write(param1);
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:String = new String("getVariables_result(");
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
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "e:";
      if(this.e == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.e;
      }
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

class doVariable_args implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("doVariable_args");
   
   private static const HEADER_FIELD_DESC:TField = new TField("header",TType.STRUCT,1);
   
   private static const ID_FIELD_DESC:TField = new TField("id",TType.I32,2);
   
   public static const HEADER:int = 1;
   
   public static const ID:int = 2;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[HEADER] = new FieldMetaData("header",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,ApiHeader));
   metaDataMap[ID] = new FieldMetaData("id",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
   FieldMetaData.addStructMetaDataMap(doVariable_args,metaDataMap);
   
   private var _header:ApiHeader;
   
   private var _id:int;
   
   private var __isset_id:Boolean = false;
   
   public function doVariable_args()
   {
      super();
   }
   
   public function get header() : ApiHeader
   {
      return this._header;
   }
   
   public function set header(param1:ApiHeader) : void
   {
      this._header = param1;
   }
   
   public function unsetHeader() : void
   {
      this.header = null;
   }
   
   public function isSetHeader() : Boolean
   {
      return this.header != null;
   }
   
   public function get id() : int
   {
      return this._id;
   }
   
   public function set id(param1:int) : void
   {
      this._id = param1;
      this.__isset_id = true;
   }
   
   public function unsetId() : void
   {
      this.__isset_id = false;
   }
   
   public function isSetId() : Boolean
   {
      return this.__isset_id;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case HEADER:
            if(param2 == null)
            {
               this.unsetHeader();
            }
            else
            {
               this.header = param2;
            }
            break;
         case ID:
            if(param2 == null)
            {
               this.unsetId();
            }
            else
            {
               this.id = param2;
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
         case HEADER:
            return this.header;
         case ID:
            return this.id;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case HEADER:
            return this.isSetHeader();
         case ID:
            return this.isSetId();
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
            case HEADER:
               if(_loc2_.type == TType.STRUCT)
               {
                  this.header = new ApiHeader();
                  this.header.read(param1);
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case ID:
               if(_loc2_.type == TType.I32)
               {
                  this.id = param1.readI32();
                  this.__isset_id = true;
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
      if(this.header != null)
      {
         param1.writeFieldBegin(HEADER_FIELD_DESC);
         this.header.write(param1);
         param1.writeFieldEnd();
      }
      param1.writeFieldBegin(ID_FIELD_DESC);
      param1.writeI32(this.id);
      param1.writeFieldEnd();
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:String = new String("doVariable_args(");
      var _loc2_:Boolean = true;
      _loc1_ += "header:";
      if(this.header == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.header;
      }
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "id:";
      _loc1_ += this.id;
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

class doVariable_result implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("doVariable_result");
   
   private static const SUCCESS_FIELD_DESC:TField = new TField("success",TType.STRUCT,0);
   
   private static const E_FIELD_DESC:TField = new TField("e",TType.STRUCT,1);
   
   public static const SUCCESS:int = 0;
   
   public static const E:int = 1;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[SUCCESS] = new FieldMetaData("success",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,UnionBool));
   metaDataMap[E] = new FieldMetaData("e",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRUCT));
   FieldMetaData.addStructMetaDataMap(doVariable_result,metaDataMap);
   
   private var _success:UnionBool;
   
   private var _e:Err;
   
   public function doVariable_result()
   {
      super();
   }
   
   public function get success() : UnionBool
   {
      return this._success;
   }
   
   public function set success(param1:UnionBool) : void
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
   
   public function get e() : Err
   {
      return this._e;
   }
   
   public function set e(param1:Err) : void
   {
      this._e = param1;
   }
   
   public function unsetE() : void
   {
      this.e = null;
   }
   
   public function isSetE() : Boolean
   {
      return this.e != null;
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
            break;
         case E:
            if(param2 == null)
            {
               this.unsetE();
            }
            else
            {
               this.e = param2;
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
         case SUCCESS:
            return this.success;
         case E:
            return this.e;
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
         case E:
            return this.isSetE();
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
                  this.success = new UnionBool();
                  this.success.read(param1);
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case E:
               if(_loc2_.type == TType.STRUCT)
               {
                  this.e = new Err();
                  this.e.read(param1);
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
      else if(this.isSetE())
      {
         param1.writeFieldBegin(E_FIELD_DESC);
         this.e.write(param1);
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:String = new String("doVariable_result(");
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
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "e:";
      if(this.e == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.e;
      }
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}
