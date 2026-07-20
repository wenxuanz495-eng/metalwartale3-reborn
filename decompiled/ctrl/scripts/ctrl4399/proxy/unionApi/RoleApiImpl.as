package ctrl4399.proxy.unionApi
{
   import org.apache.thrift.TApplicationError;
   import org.apache.thrift.TError;
   import org.apache.thrift.protocol.TMessage;
   import org.apache.thrift.protocol.TMessageType;
   import org.apache.thrift.protocol.TProtocol;
   
   public class RoleApiImpl implements RoleApi
   {
      
      protected var iprot_:TProtocol;
      
      protected var oprot_:TProtocol;
      
      protected var seqid_:int;
      
      public function RoleApiImpl(param1:TProtocol, param2:TProtocol = null)
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
      
      public function getRoleList(param1:ApiHeader, param2:int, param3:int, param4:Function, param5:Function) : void
      {
         var args:getRoleList_args;
         var header:ApiHeader = param1;
         var pageId:int = param2;
         var pageShow:int = param3;
         var onError:Function = param4;
         var onSuccess:Function = param5;
         this.oprot_.writeMessageBegin(new TMessage("getRoleList",TMessageType.CALL,this.seqid_));
         args = new getRoleList_args();
         args.header = header;
         args.pageId = pageId;
         args.pageShow = pageShow;
         args.write(this.oprot_);
         this.oprot_.writeMessageEnd();
         this.oprot_.getTransport().flush(function(param1:Error):void
         {
            var msg:TMessage = null;
            var result:getRoleList_result = null;
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
               result = new getRoleList_result();
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
                  onError(new TApplicationError(TApplicationError.MISSING_RESULT,"getRoleList failed: unknown result"));
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

class getRoleList_args implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("getRoleList_args");
   
   private static const HEADER_FIELD_DESC:TField = new TField("header",TType.STRUCT,1);
   
   private static const PAGE_ID_FIELD_DESC:TField = new TField("pageId",TType.I32,2);
   
   private static const PAGE_SHOW_FIELD_DESC:TField = new TField("pageShow",TType.I32,3);
   
   public static const HEADER:int = 1;
   
   public static const PAGEID:int = 2;
   
   public static const PAGESHOW:int = 3;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[HEADER] = new FieldMetaData("header",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,ApiHeader));
   metaDataMap[PAGEID] = new FieldMetaData("pageId",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
   metaDataMap[PAGESHOW] = new FieldMetaData("pageShow",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
   FieldMetaData.addStructMetaDataMap(getRoleList_args,metaDataMap);
   
   private var _header:ApiHeader;
   
   private var _pageId:int;
   
   private var _pageShow:int;
   
   private var __isset_pageId:Boolean = false;
   
   private var __isset_pageShow:Boolean = false;
   
   public function getRoleList_args()
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
   
   public function get pageId() : int
   {
      return this._pageId;
   }
   
   public function set pageId(param1:int) : void
   {
      this._pageId = param1;
      this.__isset_pageId = true;
   }
   
   public function unsetPageId() : void
   {
      this.__isset_pageId = false;
   }
   
   public function isSetPageId() : Boolean
   {
      return this.__isset_pageId;
   }
   
   public function get pageShow() : int
   {
      return this._pageShow;
   }
   
   public function set pageShow(param1:int) : void
   {
      this._pageShow = param1;
      this.__isset_pageShow = true;
   }
   
   public function unsetPageShow() : void
   {
      this.__isset_pageShow = false;
   }
   
   public function isSetPageShow() : Boolean
   {
      return this.__isset_pageShow;
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
         case PAGEID:
            if(param2 == null)
            {
               this.unsetPageId();
            }
            else
            {
               this.pageId = param2;
            }
            break;
         case PAGESHOW:
            if(param2 == null)
            {
               this.unsetPageShow();
            }
            else
            {
               this.pageShow = param2;
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
         case PAGEID:
            return this.pageId;
         case PAGESHOW:
            return this.pageShow;
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
         case PAGEID:
            return this.isSetPageId();
         case PAGESHOW:
            return this.isSetPageShow();
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
            case PAGEID:
               if(_loc2_.type == TType.I32)
               {
                  this.pageId = param1.readI32();
                  this.__isset_pageId = true;
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case PAGESHOW:
               if(_loc2_.type == TType.I32)
               {
                  this.pageShow = param1.readI32();
                  this.__isset_pageShow = true;
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
      param1.writeFieldBegin(PAGE_ID_FIELD_DESC);
      param1.writeI32(this.pageId);
      param1.writeFieldEnd();
      param1.writeFieldBegin(PAGE_SHOW_FIELD_DESC);
      param1.writeI32(this.pageShow);
      param1.writeFieldEnd();
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:String = new String("getRoleList_args(");
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
      _loc1_ += "pageId:";
      _loc1_ += this.pageId;
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "pageShow:";
      _loc1_ += this.pageShow;
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

class getRoleList_result implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("getRoleList_result");
   
   private static const SUCCESS_FIELD_DESC:TField = new TField("success",TType.STRUCT,0);
   
   private static const E_FIELD_DESC:TField = new TField("e",TType.STRUCT,1);
   
   public static const SUCCESS:int = 0;
   
   public static const E:int = 1;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[SUCCESS] = new FieldMetaData("success",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,RES_RoleList));
   metaDataMap[E] = new FieldMetaData("e",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRUCT));
   FieldMetaData.addStructMetaDataMap(getRoleList_result,metaDataMap);
   
   private var _success:RES_RoleList;
   
   private var _e:Err;
   
   public function getRoleList_result()
   {
      super();
   }
   
   public function get success() : RES_RoleList
   {
      return this._success;
   }
   
   public function set success(param1:RES_RoleList) : void
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
                  this.success = new RES_RoleList();
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
      var _loc1_:String = new String("getRoleList_result(");
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
   
   private static const E_FIELD_DESC:TField = new TField("e",TType.STRUCT,1);
   
   public static const SUCCESS:int = 0;
   
   public static const E:int = 1;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[SUCCESS] = new FieldMetaData("success",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
   metaDataMap[E] = new FieldMetaData("e",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRUCT));
   FieldMetaData.addStructMetaDataMap(test_result,metaDataMap);
   
   private var _success:String;
   
   private var _e:Err;
   
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
               if(_loc2_.type == TType.STRING)
               {
                  this.success = param1.readString();
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
         param1.writeString(this.success);
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
