package ctrl4399.proxy.shopApi
{
   import org.apache.thrift.TApplicationError;
   import org.apache.thrift.TError;
   import org.apache.thrift.protocol.TMessage;
   import org.apache.thrift.protocol.TMessageType;
   import org.apache.thrift.protocol.TProtocol;
   
   public class FlashStoreApiImpl implements FlashStoreApi
   {
      
      protected var iprot_:TProtocol;
      
      protected var oprot_:TProtocol;
      
      protected var seqid_:int;
      
      public function FlashStoreApiImpl(param1:TProtocol, param2:TProtocol = null)
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
      
      public function getPropList(param1:Head, param2:Function, param3:Function) : void
      {
         var args:getPropList_args;
         var head:Head = param1;
         var onError:Function = param2;
         var onSuccess:Function = param3;
         this.oprot_.writeMessageBegin(new TMessage("getPropList",TMessageType.CALL,this.seqid_));
         args = new getPropList_args();
         args.head = head;
         args.write(this.oprot_);
         this.oprot_.writeMessageEnd();
         this.oprot_.getTransport().flush(function(param1:Error):void
         {
            var msg:TMessage = null;
            var result:getPropList_result = null;
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
               result = new getPropList_result();
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
               if(result.err != null)
               {
                  if(onError != null)
                  {
                     onError(result.err);
                  }
                  return;
               }
               if(onError != null)
               {
                  onError(new TApplicationError(TApplicationError.MISSING_RESULT,"getPropList failed: unknown result"));
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
      
      public function buyProp(param1:Head, param2:PropInfo, param3:Function, param4:Function) : void
      {
         var args:buyProp_args;
         var head:Head = param1;
         var prop:PropInfo = param2;
         var onError:Function = param3;
         var onSuccess:Function = param4;
         this.oprot_.writeMessageBegin(new TMessage("buyProp",TMessageType.CALL,this.seqid_));
         args = new buyProp_args();
         args.head = head;
         args.prop = prop;
         args.write(this.oprot_);
         this.oprot_.writeMessageEnd();
         this.oprot_.getTransport().flush(function(param1:Error):void
         {
            var msg:TMessage = null;
            var result:buyProp_result = null;
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
               result = new buyProp_result();
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
               if(result.err != null)
               {
                  if(onError != null)
                  {
                     onError(result.err);
                  }
                  return;
               }
               if(onError != null)
               {
                  onError(new TApplicationError(TApplicationError.MISSING_RESULT,"buyProp failed: unknown result"));
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
      
      public function test(param1:Function, param2:Function) : void
      {
         var args:test_args;
         var onError:Function = param1;
         var onSuccess:Function = param2;
         this.oprot_.writeMessageBegin(new TMessage("test",TMessageType.CALL,this.seqid_));
         args = new test_args();
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
               if(result.err != null)
               {
                  if(onError != null)
                  {
                     onError(result.err);
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
import org.apache.thrift.TBase;
import org.apache.thrift.TFieldRequirementType;
import org.apache.thrift.meta_data.FieldMetaData;
import org.apache.thrift.meta_data.FieldValueMetaData;
import org.apache.thrift.meta_data.StructMetaData;
import org.apache.thrift.protocol.TField;
import org.apache.thrift.protocol.TProtocol;
import org.apache.thrift.protocol.TProtocolUtil;
import org.apache.thrift.protocol.TStruct;
import org.apache.thrift.protocol.TType;

class getPropList_args implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("getPropList_args");
   
   private static const HEAD_FIELD_DESC:TField = new TField("head",TType.STRUCT,1);
   
   public static const HEAD:int = 1;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[HEAD] = new FieldMetaData("head",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,Head));
   FieldMetaData.addStructMetaDataMap(getPropList_args,metaDataMap);
   
   private var _head:Head;
   
   public function getPropList_args()
   {
      super();
   }
   
   public function get head() : Head
   {
      return this._head;
   }
   
   public function set head(param1:Head) : void
   {
      this._head = param1;
   }
   
   public function unsetHead() : void
   {
      this.head = null;
   }
   
   public function isSetHead() : Boolean
   {
      return this.head != null;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case HEAD:
            if(param2 == null)
            {
               this.unsetHead();
            }
            else
            {
               this.head = param2;
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
         case HEAD:
            return this.head;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case HEAD:
            return this.isSetHead();
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
            case HEAD:
               if(_loc2_.type == TType.STRUCT)
               {
                  this.head = new Head();
                  this.head.read(param1);
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
      if(this.head != null)
      {
         param1.writeFieldBegin(HEAD_FIELD_DESC);
         this.head.write(param1);
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:String = new String("getPropList_args(");
      var _loc2_:Boolean = true;
      _loc1_ += "head:";
      if(this.head == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.head;
      }
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

class getPropList_result implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("getPropList_result");
   
   private static const SUCCESS_FIELD_DESC:TField = new TField("success",TType.STRUCT,0);
   
   private static const ERR_FIELD_DESC:TField = new TField("err",TType.STRUCT,1);
   
   public static const SUCCESS:int = 0;
   
   public static const ERR:int = 1;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[SUCCESS] = new FieldMetaData("success",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,RES_PropList));
   metaDataMap[ERR] = new FieldMetaData("err",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRUCT));
   FieldMetaData.addStructMetaDataMap(getPropList_result,metaDataMap);
   
   private var _success:RES_PropList;
   
   private var _err:Err_Store;
   
   public function getPropList_result()
   {
      super();
   }
   
   public function get success() : RES_PropList
   {
      return this._success;
   }
   
   public function set success(param1:RES_PropList) : void
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
   
   public function get err() : Err_Store
   {
      return this._err;
   }
   
   public function set err(param1:Err_Store) : void
   {
      this._err = param1;
   }
   
   public function unsetErr() : void
   {
      this.err = null;
   }
   
   public function isSetErr() : Boolean
   {
      return this.err != null;
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
         case ERR:
            if(param2 == null)
            {
               this.unsetErr();
            }
            else
            {
               this.err = param2;
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
         case ERR:
            return this.err;
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
         case ERR:
            return this.isSetErr();
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
                  this.success = new RES_PropList();
                  this.success.read(param1);
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case ERR:
               if(_loc2_.type == TType.STRUCT)
               {
                  this.err = new Err_Store();
                  this.err.read(param1);
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
      else if(this.isSetErr())
      {
         param1.writeFieldBegin(ERR_FIELD_DESC);
         this.err.write(param1);
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:String = new String("getPropList_result(");
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
      _loc1_ += "err:";
      if(this.err == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.err;
      }
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

class buyProp_args implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("buyProp_args");
   
   private static const HEAD_FIELD_DESC:TField = new TField("head",TType.STRUCT,1);
   
   private static const PROP_FIELD_DESC:TField = new TField("prop",TType.STRUCT,2);
   
   public static const HEAD:int = 1;
   
   public static const PROP:int = 2;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[HEAD] = new FieldMetaData("head",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,Head));
   metaDataMap[PROP] = new FieldMetaData("prop",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,PropInfo));
   FieldMetaData.addStructMetaDataMap(buyProp_args,metaDataMap);
   
   private var _head:Head;
   
   private var _prop:PropInfo;
   
   public function buyProp_args()
   {
      super();
   }
   
   public function get head() : Head
   {
      return this._head;
   }
   
   public function set head(param1:Head) : void
   {
      this._head = param1;
   }
   
   public function unsetHead() : void
   {
      this.head = null;
   }
   
   public function isSetHead() : Boolean
   {
      return this.head != null;
   }
   
   public function get prop() : PropInfo
   {
      return this._prop;
   }
   
   public function set prop(param1:PropInfo) : void
   {
      this._prop = param1;
   }
   
   public function unsetProp() : void
   {
      this.prop = null;
   }
   
   public function isSetProp() : Boolean
   {
      return this.prop != null;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case HEAD:
            if(param2 == null)
            {
               this.unsetHead();
            }
            else
            {
               this.head = param2;
            }
            break;
         case PROP:
            if(param2 == null)
            {
               this.unsetProp();
            }
            else
            {
               this.prop = param2;
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
         case HEAD:
            return this.head;
         case PROP:
            return this.prop;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case HEAD:
            return this.isSetHead();
         case PROP:
            return this.isSetProp();
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
            case HEAD:
               if(_loc2_.type == TType.STRUCT)
               {
                  this.head = new Head();
                  this.head.read(param1);
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case PROP:
               if(_loc2_.type == TType.STRUCT)
               {
                  this.prop = new PropInfo();
                  this.prop.read(param1);
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
      if(this.head != null)
      {
         param1.writeFieldBegin(HEAD_FIELD_DESC);
         this.head.write(param1);
         param1.writeFieldEnd();
      }
      if(this.prop != null)
      {
         param1.writeFieldBegin(PROP_FIELD_DESC);
         this.prop.write(param1);
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:String = new String("buyProp_args(");
      var _loc2_:Boolean = true;
      _loc1_ += "head:";
      if(this.head == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.head;
      }
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "prop:";
      if(this.prop == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.prop;
      }
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

class buyProp_result implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("buyProp_result");
   
   private static const SUCCESS_FIELD_DESC:TField = new TField("success",TType.STRUCT,0);
   
   private static const ERR_FIELD_DESC:TField = new TField("err",TType.STRUCT,1);
   
   public static const SUCCESS:int = 0;
   
   public static const ERR:int = 1;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[SUCCESS] = new FieldMetaData("success",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,RES_BuyData));
   metaDataMap[ERR] = new FieldMetaData("err",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRUCT));
   FieldMetaData.addStructMetaDataMap(buyProp_result,metaDataMap);
   
   private var _success:RES_BuyData;
   
   private var _err:Err_Store;
   
   public function buyProp_result()
   {
      super();
   }
   
   public function get success() : RES_BuyData
   {
      return this._success;
   }
   
   public function set success(param1:RES_BuyData) : void
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
   
   public function get err() : Err_Store
   {
      return this._err;
   }
   
   public function set err(param1:Err_Store) : void
   {
      this._err = param1;
   }
   
   public function unsetErr() : void
   {
      this.err = null;
   }
   
   public function isSetErr() : Boolean
   {
      return this.err != null;
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
         case ERR:
            if(param2 == null)
            {
               this.unsetErr();
            }
            else
            {
               this.err = param2;
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
         case ERR:
            return this.err;
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
         case ERR:
            return this.isSetErr();
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
                  this.success = new RES_BuyData();
                  this.success.read(param1);
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case ERR:
               if(_loc2_.type == TType.STRUCT)
               {
                  this.err = new Err_Store();
                  this.err.read(param1);
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
      else if(this.isSetErr())
      {
         param1.writeFieldBegin(ERR_FIELD_DESC);
         this.err.write(param1);
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:String = new String("buyProp_result(");
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
      _loc1_ += "err:";
      if(this.err == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.err;
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
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   FieldMetaData.addStructMetaDataMap(test_args,metaDataMap);
   
   public function test_args()
   {
      super();
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      var _loc3_:int = param1;
      switch(0)
      {
      }
      throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
   }
   
   public function getFieldValue(param1:int) : *
   {
      var _loc2_:int = param1;
      switch(0)
      {
      }
      throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
   }
   
   public function isSet(param1:int) : Boolean
   {
      var _loc2_:int = param1;
      switch(0)
      {
      }
      throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
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
         var _loc3_:int = _loc2_.id;
         switch(0)
         {
         }
         TProtocolUtil.skip(param1,_loc2_.type);
         param1.readFieldEnd();
      }
      param1.readStructEnd();
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      this.validate();
      param1.writeStructBegin(STRUCT_DESC);
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:String = new String("test_args(");
      var _loc2_:Boolean = true;
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
   
   private static const ERR_FIELD_DESC:TField = new TField("err",TType.STRUCT,1);
   
   public static const SUCCESS:int = 0;
   
   public static const ERR:int = 1;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[SUCCESS] = new FieldMetaData("success",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
   metaDataMap[ERR] = new FieldMetaData("err",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRUCT));
   FieldMetaData.addStructMetaDataMap(test_result,metaDataMap);
   
   private var _success:String;
   
   private var _err:Err_Store;
   
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
   
   public function get err() : Err_Store
   {
      return this._err;
   }
   
   public function set err(param1:Err_Store) : void
   {
      this._err = param1;
   }
   
   public function unsetErr() : void
   {
      this.err = null;
   }
   
   public function isSetErr() : Boolean
   {
      return this.err != null;
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
         case ERR:
            if(param2 == null)
            {
               this.unsetErr();
            }
            else
            {
               this.err = param2;
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
         case ERR:
            return this.err;
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
         case ERR:
            return this.isSetErr();
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
            case ERR:
               if(_loc2_.type == TType.STRUCT)
               {
                  this.err = new Err_Store();
                  this.err.read(param1);
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
      else if(this.isSetErr())
      {
         param1.writeFieldBegin(ERR_FIELD_DESC);
         this.err.write(param1);
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
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "err:";
      if(this.err == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.err;
      }
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}
