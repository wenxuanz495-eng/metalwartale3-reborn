package ctrl4399.proxy.unionApi
{
   import org.apache.thrift.TApplicationError;
   import org.apache.thrift.TError;
   import org.apache.thrift.protocol.TMessage;
   import org.apache.thrift.protocol.TMessageType;
   import org.apache.thrift.protocol.TProtocol;
   
   public class MasterApiImpl implements MasterApi
   {
      
      protected var iprot_:TProtocol;
      
      protected var oprot_:TProtocol;
      
      protected var seqid_:int;
      
      public function MasterApiImpl(param1:TProtocol, param2:TProtocol = null)
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
      
      public function applyList(param1:ApiHeader, param2:int, param3:int, param4:Function, param5:Function) : void
      {
         var args:applyList_args;
         var header:ApiHeader = param1;
         var pageId:int = param2;
         var pageShow:int = param3;
         var onError:Function = param4;
         var onSuccess:Function = param5;
         this.oprot_.writeMessageBegin(new TMessage("applyList",TMessageType.CALL,this.seqid_));
         args = new applyList_args();
         args.header = header;
         args.pageId = pageId;
         args.pageShow = pageShow;
         args.write(this.oprot_);
         this.oprot_.writeMessageEnd();
         this.oprot_.getTransport().flush(function(param1:Error):void
         {
            var msg:TMessage = null;
            var result:applyList_result = null;
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
               result = new applyList_result();
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
                  onError(new TApplicationError(TApplicationError.MISSING_RESULT,"applyList failed: unknown result"));
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
      
      public function applyAudit(param1:ApiHeader, param2:int, param3:String, param4:int, param5:Function, param6:Function) : void
      {
         var args:applyAudit_args;
         var header:ApiHeader = param1;
         var uId:int = param2;
         var index:String = param3;
         var auditResult:int = param4;
         var onError:Function = param5;
         var onSuccess:Function = param6;
         this.oprot_.writeMessageBegin(new TMessage("applyAudit",TMessageType.CALL,this.seqid_));
         args = new applyAudit_args();
         args.header = header;
         args.uId = uId;
         args.index = index;
         args.auditResult = auditResult;
         args.write(this.oprot_);
         this.oprot_.writeMessageEnd();
         this.oprot_.getTransport().flush(function(param1:Error):void
         {
            var msg:TMessage = null;
            var result:applyAudit_result = null;
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
               result = new applyAudit_result();
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
                  onError(new TApplicationError(TApplicationError.MISSING_RESULT,"applyAudit failed: unknown result"));
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
      
      public function memberRemove(param1:ApiHeader, param2:int, param3:String, param4:Function, param5:Function) : void
      {
         var args:memberRemove_args;
         var header:ApiHeader = param1;
         var uId:int = param2;
         var index:String = param3;
         var onError:Function = param4;
         var onSuccess:Function = param5;
         this.oprot_.writeMessageBegin(new TMessage("memberRemove",TMessageType.CALL,this.seqid_));
         args = new memberRemove_args();
         args.header = header;
         args.uId = uId;
         args.index = index;
         args.write(this.oprot_);
         this.oprot_.writeMessageEnd();
         this.oprot_.getTransport().flush(function(param1:Error):void
         {
            var msg:TMessage = null;
            var result:memberRemove_result = null;
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
               result = new memberRemove_result();
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
                  onError(new TApplicationError(TApplicationError.MISSING_RESULT,"memberRemove failed: unknown result"));
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
      
      public function dissolve(param1:ApiHeader, param2:int, param3:Function, param4:Function) : void
      {
         var args:dissolve_args;
         var header:ApiHeader = param1;
         var actionType:int = param2;
         var onError:Function = param3;
         var onSuccess:Function = param4;
         this.oprot_.writeMessageBegin(new TMessage("dissolve",TMessageType.CALL,this.seqid_));
         args = new dissolve_args();
         args.header = header;
         args.actionType = actionType;
         args.write(this.oprot_);
         this.oprot_.writeMessageEnd();
         this.oprot_.getTransport().flush(function(param1:Error):void
         {
            var msg:TMessage = null;
            var result:dissolve_result = null;
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
               result = new dissolve_result();
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
                  onError(new TApplicationError(TApplicationError.MISSING_RESULT,"dissolve failed: unknown result"));
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
      
      public function deleteContributionUnion(param1:ApiHeader, param2:int, param3:Function, param4:Function) : void
      {
         var args:deleteContributionUnion_args;
         var header:ApiHeader = param1;
         var contribution:int = param2;
         var onError:Function = param3;
         var onSuccess:Function = param4;
         this.oprot_.writeMessageBegin(new TMessage("deleteContributionUnion",TMessageType.CALL,this.seqid_));
         args = new deleteContributionUnion_args();
         args.header = header;
         args.contribution = contribution;
         args.write(this.oprot_);
         this.oprot_.writeMessageEnd();
         this.oprot_.getTransport().flush(function(param1:Error):void
         {
            var msg:TMessage = null;
            var result:deleteContributionUnion_result = null;
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
               result = new deleteContributionUnion_result();
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
                  onError(new TApplicationError(TApplicationError.MISSING_RESULT,"deleteContributionUnion failed: unknown result"));
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
      
      public function applyAuditMuch(param1:ApiHeader, param2:Array, param3:int, param4:Function, param5:Function) : void
      {
         var args:applyAuditMuch_args;
         var header:ApiHeader = param1;
         var users:Array = param2;
         var auditResult:int = param3;
         var onError:Function = param4;
         var onSuccess:Function = param5;
         this.oprot_.writeMessageBegin(new TMessage("applyAuditMuch",TMessageType.CALL,this.seqid_));
         args = new applyAuditMuch_args();
         args.header = header;
         args.users = users;
         args.auditResult = auditResult;
         args.write(this.oprot_);
         this.oprot_.writeMessageEnd();
         this.oprot_.getTransport().flush(function(param1:Error):void
         {
            var msg:TMessage = null;
            var result:applyAuditMuch_result = null;
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
               result = new applyAuditMuch_result();
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
                  onError(new TApplicationError(TApplicationError.MISSING_RESULT,"applyAuditMuch failed: unknown result"));
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
      
      public function transfer(param1:ApiHeader, param2:int, param3:String, param4:int, param5:Function, param6:Function) : void
      {
         var args:transfer_args;
         var header:ApiHeader = param1;
         var uId:int = param2;
         var index:String = param3;
         var transferResult:int = param4;
         var onError:Function = param5;
         var onSuccess:Function = param6;
         this.oprot_.writeMessageBegin(new TMessage("transfer",TMessageType.CALL,this.seqid_));
         args = new transfer_args();
         args.header = header;
         args.uId = uId;
         args.index = index;
         args.transferResult = transferResult;
         args.write(this.oprot_);
         this.oprot_.writeMessageEnd();
         this.oprot_.getTransport().flush(function(param1:Error):void
         {
            var msg:TMessage = null;
            var result:transfer_result = null;
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
               result = new transfer_result();
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
                  onError(new TApplicationError(TApplicationError.MISSING_RESULT,"transfer failed: unknown result"));
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

class applyList_args implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("applyList_args");
   
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
   FieldMetaData.addStructMetaDataMap(applyList_args,metaDataMap);
   
   private var _header:ApiHeader;
   
   private var _pageId:int;
   
   private var _pageShow:int;
   
   private var __isset_pageId:Boolean = false;
   
   private var __isset_pageShow:Boolean = false;
   
   public function applyList_args()
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
      var _loc1_:String = new String("applyList_args(");
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

class applyList_result implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("applyList_result");
   
   private static const SUCCESS_FIELD_DESC:TField = new TField("success",TType.STRUCT,0);
   
   private static const E_FIELD_DESC:TField = new TField("e",TType.STRUCT,1);
   
   public static const SUCCESS:int = 0;
   
   public static const E:int = 1;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[SUCCESS] = new FieldMetaData("success",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,RES_ApplyList));
   metaDataMap[E] = new FieldMetaData("e",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRUCT));
   FieldMetaData.addStructMetaDataMap(applyList_result,metaDataMap);
   
   private var _success:RES_ApplyList;
   
   private var _e:Err;
   
   public function applyList_result()
   {
      super();
   }
   
   public function get success() : RES_ApplyList
   {
      return this._success;
   }
   
   public function set success(param1:RES_ApplyList) : void
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
                  this.success = new RES_ApplyList();
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
      var _loc1_:String = new String("applyList_result(");
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

class applyAudit_args implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("applyAudit_args");
   
   private static const HEADER_FIELD_DESC:TField = new TField("header",TType.STRUCT,1);
   
   private static const U_ID_FIELD_DESC:TField = new TField("uId",TType.I32,2);
   
   private static const INDEX_FIELD_DESC:TField = new TField("index",TType.STRING,3);
   
   private static const AUDIT_RESULT_FIELD_DESC:TField = new TField("auditResult",TType.I32,4);
   
   public static const HEADER:int = 1;
   
   public static const UID:int = 2;
   
   public static const INDEX:int = 3;
   
   public static const AUDITRESULT:int = 4;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[HEADER] = new FieldMetaData("header",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,ApiHeader));
   metaDataMap[UID] = new FieldMetaData("uId",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
   metaDataMap[INDEX] = new FieldMetaData("index",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
   metaDataMap[AUDITRESULT] = new FieldMetaData("auditResult",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
   FieldMetaData.addStructMetaDataMap(applyAudit_args,metaDataMap);
   
   private var _header:ApiHeader;
   
   private var _uId:int;
   
   private var _index:String;
   
   private var _auditResult:int;
   
   private var __isset_uId:Boolean = false;
   
   private var __isset_auditResult:Boolean = false;
   
   public function applyAudit_args()
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
   
   public function get uId() : int
   {
      return this._uId;
   }
   
   public function set uId(param1:int) : void
   {
      this._uId = param1;
      this.__isset_uId = true;
   }
   
   public function unsetUId() : void
   {
      this.__isset_uId = false;
   }
   
   public function isSetUId() : Boolean
   {
      return this.__isset_uId;
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
   
   public function get auditResult() : int
   {
      return this._auditResult;
   }
   
   public function set auditResult(param1:int) : void
   {
      this._auditResult = param1;
      this.__isset_auditResult = true;
   }
   
   public function unsetAuditResult() : void
   {
      this.__isset_auditResult = false;
   }
   
   public function isSetAuditResult() : Boolean
   {
      return this.__isset_auditResult;
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
         case AUDITRESULT:
            if(param2 == null)
            {
               this.unsetAuditResult();
            }
            else
            {
               this.auditResult = param2;
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
         case UID:
            return this.uId;
         case INDEX:
            return this.index;
         case AUDITRESULT:
            return this.auditResult;
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
         case UID:
            return this.isSetUId();
         case INDEX:
            return this.isSetIndex();
         case AUDITRESULT:
            return this.isSetAuditResult();
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
            case UID:
               if(_loc2_.type == TType.I32)
               {
                  this.uId = param1.readI32();
                  this.__isset_uId = true;
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
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
            case AUDITRESULT:
               if(_loc2_.type == TType.I32)
               {
                  this.auditResult = param1.readI32();
                  this.__isset_auditResult = true;
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
      param1.writeFieldBegin(U_ID_FIELD_DESC);
      param1.writeI32(this.uId);
      param1.writeFieldEnd();
      if(this.index != null)
      {
         param1.writeFieldBegin(INDEX_FIELD_DESC);
         param1.writeString(this.index);
         param1.writeFieldEnd();
      }
      param1.writeFieldBegin(AUDIT_RESULT_FIELD_DESC);
      param1.writeI32(this.auditResult);
      param1.writeFieldEnd();
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:String = new String("applyAudit_args(");
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
      _loc1_ += "uId:";
      _loc1_ += this.uId;
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
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
      _loc1_ += "auditResult:";
      _loc1_ += this.auditResult;
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

class applyAudit_result implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("applyAudit_result");
   
   private static const SUCCESS_FIELD_DESC:TField = new TField("success",TType.STRUCT,0);
   
   private static const E_FIELD_DESC:TField = new TField("e",TType.STRUCT,1);
   
   public static const SUCCESS:int = 0;
   
   public static const E:int = 1;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[SUCCESS] = new FieldMetaData("success",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,UnionBool));
   metaDataMap[E] = new FieldMetaData("e",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRUCT));
   FieldMetaData.addStructMetaDataMap(applyAudit_result,metaDataMap);
   
   private var _success:UnionBool;
   
   private var _e:Err;
   
   public function applyAudit_result()
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
      var _loc1_:String = new String("applyAudit_result(");
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

class memberRemove_args implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("memberRemove_args");
   
   private static const HEADER_FIELD_DESC:TField = new TField("header",TType.STRUCT,1);
   
   private static const U_ID_FIELD_DESC:TField = new TField("uId",TType.I32,2);
   
   private static const INDEX_FIELD_DESC:TField = new TField("index",TType.STRING,3);
   
   public static const HEADER:int = 1;
   
   public static const UID:int = 2;
   
   public static const INDEX:int = 3;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[HEADER] = new FieldMetaData("header",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,ApiHeader));
   metaDataMap[UID] = new FieldMetaData("uId",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
   metaDataMap[INDEX] = new FieldMetaData("index",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
   FieldMetaData.addStructMetaDataMap(memberRemove_args,metaDataMap);
   
   private var _header:ApiHeader;
   
   private var _uId:int;
   
   private var _index:String;
   
   private var __isset_uId:Boolean = false;
   
   public function memberRemove_args()
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
   
   public function get uId() : int
   {
      return this._uId;
   }
   
   public function set uId(param1:int) : void
   {
      this._uId = param1;
      this.__isset_uId = true;
   }
   
   public function unsetUId() : void
   {
      this.__isset_uId = false;
   }
   
   public function isSetUId() : Boolean
   {
      return this.__isset_uId;
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
         case UID:
            return this.uId;
         case INDEX:
            return this.index;
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
         case UID:
            return this.isSetUId();
         case INDEX:
            return this.isSetIndex();
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
            case UID:
               if(_loc2_.type == TType.I32)
               {
                  this.uId = param1.readI32();
                  this.__isset_uId = true;
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
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
      param1.writeFieldBegin(U_ID_FIELD_DESC);
      param1.writeI32(this.uId);
      param1.writeFieldEnd();
      if(this.index != null)
      {
         param1.writeFieldBegin(INDEX_FIELD_DESC);
         param1.writeString(this.index);
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:String = new String("memberRemove_args(");
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
      _loc1_ += "uId:";
      _loc1_ += this.uId;
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
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
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

class memberRemove_result implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("memberRemove_result");
   
   private static const SUCCESS_FIELD_DESC:TField = new TField("success",TType.STRUCT,0);
   
   private static const E_FIELD_DESC:TField = new TField("e",TType.STRUCT,1);
   
   public static const SUCCESS:int = 0;
   
   public static const E:int = 1;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[SUCCESS] = new FieldMetaData("success",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,UnionBool));
   metaDataMap[E] = new FieldMetaData("e",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRUCT));
   FieldMetaData.addStructMetaDataMap(memberRemove_result,metaDataMap);
   
   private var _success:UnionBool;
   
   private var _e:Err;
   
   public function memberRemove_result()
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
      var _loc1_:String = new String("memberRemove_result(");
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

class dissolve_args implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("dissolve_args");
   
   private static const HEADER_FIELD_DESC:TField = new TField("header",TType.STRUCT,1);
   
   private static const ACTION_TYPE_FIELD_DESC:TField = new TField("actionType",TType.I32,2);
   
   public static const HEADER:int = 1;
   
   public static const ACTIONTYPE:int = 2;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[HEADER] = new FieldMetaData("header",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,ApiHeader));
   metaDataMap[ACTIONTYPE] = new FieldMetaData("actionType",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
   FieldMetaData.addStructMetaDataMap(dissolve_args,metaDataMap);
   
   private var _header:ApiHeader;
   
   private var _actionType:int;
   
   private var __isset_actionType:Boolean = false;
   
   public function dissolve_args()
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
   
   public function get actionType() : int
   {
      return this._actionType;
   }
   
   public function set actionType(param1:int) : void
   {
      this._actionType = param1;
      this.__isset_actionType = true;
   }
   
   public function unsetActionType() : void
   {
      this.__isset_actionType = false;
   }
   
   public function isSetActionType() : Boolean
   {
      return this.__isset_actionType;
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
         case ACTIONTYPE:
            if(param2 == null)
            {
               this.unsetActionType();
            }
            else
            {
               this.actionType = param2;
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
         case ACTIONTYPE:
            return this.actionType;
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
         case ACTIONTYPE:
            return this.isSetActionType();
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
            case ACTIONTYPE:
               if(_loc2_.type == TType.I32)
               {
                  this.actionType = param1.readI32();
                  this.__isset_actionType = true;
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
      param1.writeFieldBegin(ACTION_TYPE_FIELD_DESC);
      param1.writeI32(this.actionType);
      param1.writeFieldEnd();
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:String = new String("dissolve_args(");
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
      _loc1_ += "actionType:";
      _loc1_ += this.actionType;
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

class dissolve_result implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("dissolve_result");
   
   private static const SUCCESS_FIELD_DESC:TField = new TField("success",TType.STRUCT,0);
   
   private static const E_FIELD_DESC:TField = new TField("e",TType.STRUCT,1);
   
   public static const SUCCESS:int = 0;
   
   public static const E:int = 1;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[SUCCESS] = new FieldMetaData("success",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,RES_Dissolve));
   metaDataMap[E] = new FieldMetaData("e",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRUCT));
   FieldMetaData.addStructMetaDataMap(dissolve_result,metaDataMap);
   
   private var _success:RES_Dissolve;
   
   private var _e:Err;
   
   public function dissolve_result()
   {
      super();
   }
   
   public function get success() : RES_Dissolve
   {
      return this._success;
   }
   
   public function set success(param1:RES_Dissolve) : void
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
                  this.success = new RES_Dissolve();
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
      var _loc1_:String = new String("dissolve_result(");
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

class deleteContributionUnion_args implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("deleteContributionUnion_args");
   
   private static const HEADER_FIELD_DESC:TField = new TField("header",TType.STRUCT,1);
   
   private static const CONTRIBUTION_FIELD_DESC:TField = new TField("contribution",TType.I32,2);
   
   public static const HEADER:int = 1;
   
   public static const CONTRIBUTION:int = 2;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[HEADER] = new FieldMetaData("header",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,ApiHeader));
   metaDataMap[CONTRIBUTION] = new FieldMetaData("contribution",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
   FieldMetaData.addStructMetaDataMap(deleteContributionUnion_args,metaDataMap);
   
   private var _header:ApiHeader;
   
   private var _contribution:int;
   
   private var __isset_contribution:Boolean = false;
   
   public function deleteContributionUnion_args()
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
   
   public function get contribution() : int
   {
      return this._contribution;
   }
   
   public function set contribution(param1:int) : void
   {
      this._contribution = param1;
      this.__isset_contribution = true;
   }
   
   public function unsetContribution() : void
   {
      this.__isset_contribution = false;
   }
   
   public function isSetContribution() : Boolean
   {
      return this.__isset_contribution;
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
         case CONTRIBUTION:
            if(param2 == null)
            {
               this.unsetContribution();
            }
            else
            {
               this.contribution = param2;
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
         case CONTRIBUTION:
            return this.contribution;
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
         case CONTRIBUTION:
            return this.isSetContribution();
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
            case CONTRIBUTION:
               if(_loc2_.type == TType.I32)
               {
                  this.contribution = param1.readI32();
                  this.__isset_contribution = true;
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
      param1.writeFieldBegin(CONTRIBUTION_FIELD_DESC);
      param1.writeI32(this.contribution);
      param1.writeFieldEnd();
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:String = new String("deleteContributionUnion_args(");
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
      _loc1_ += "contribution:";
      _loc1_ += this.contribution;
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

class deleteContributionUnion_result implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("deleteContributionUnion_result");
   
   private static const SUCCESS_FIELD_DESC:TField = new TField("success",TType.STRUCT,0);
   
   private static const E_FIELD_DESC:TField = new TField("e",TType.STRUCT,1);
   
   public static const SUCCESS:int = 0;
   
   public static const E:int = 1;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[SUCCESS] = new FieldMetaData("success",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,UnionInt));
   metaDataMap[E] = new FieldMetaData("e",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRUCT));
   FieldMetaData.addStructMetaDataMap(deleteContributionUnion_result,metaDataMap);
   
   private var _success:UnionInt;
   
   private var _e:Err;
   
   public function deleteContributionUnion_result()
   {
      super();
   }
   
   public function get success() : UnionInt
   {
      return this._success;
   }
   
   public function set success(param1:UnionInt) : void
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
                  this.success = new UnionInt();
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
      var _loc1_:String = new String("deleteContributionUnion_result(");
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

class applyAuditMuch_args implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("applyAuditMuch_args");
   
   private static const HEADER_FIELD_DESC:TField = new TField("header",TType.STRUCT,1);
   
   private static const USERS_FIELD_DESC:TField = new TField("users",TType.LIST,2);
   
   private static const AUDIT_RESULT_FIELD_DESC:TField = new TField("auditResult",TType.I32,3);
   
   public static const HEADER:int = 1;
   
   public static const USERS:int = 2;
   
   public static const AUDITRESULT:int = 3;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[HEADER] = new FieldMetaData("header",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,ApiHeader));
   metaDataMap[USERS] = new FieldMetaData("users",TFieldRequirementType.DEFAULT,new ListMetaData(TType.LIST,new StructMetaData(TType.STRUCT,Users)));
   metaDataMap[AUDITRESULT] = new FieldMetaData("auditResult",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
   FieldMetaData.addStructMetaDataMap(applyAuditMuch_args,metaDataMap);
   
   private var _header:ApiHeader;
   
   private var _users:Array;
   
   private var _auditResult:int;
   
   private var __isset_auditResult:Boolean = false;
   
   public function applyAuditMuch_args()
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
   
   public function get users() : Array
   {
      return this._users;
   }
   
   public function set users(param1:Array) : void
   {
      this._users = param1;
   }
   
   public function unsetUsers() : void
   {
      this.users = null;
   }
   
   public function isSetUsers() : Boolean
   {
      return this.users != null;
   }
   
   public function get auditResult() : int
   {
      return this._auditResult;
   }
   
   public function set auditResult(param1:int) : void
   {
      this._auditResult = param1;
      this.__isset_auditResult = true;
   }
   
   public function unsetAuditResult() : void
   {
      this.__isset_auditResult = false;
   }
   
   public function isSetAuditResult() : Boolean
   {
      return this.__isset_auditResult;
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
         case USERS:
            if(param2 == null)
            {
               this.unsetUsers();
            }
            else
            {
               this.users = param2;
            }
            break;
         case AUDITRESULT:
            if(param2 == null)
            {
               this.unsetAuditResult();
            }
            else
            {
               this.auditResult = param2;
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
         case USERS:
            return this.users;
         case AUDITRESULT:
            return this.auditResult;
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
         case USERS:
            return this.isSetUsers();
         case AUDITRESULT:
            return this.isSetAuditResult();
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function read(param1:TProtocol) : void
   {
      var _loc2_:TField = null;
      var _loc3_:TList = null;
      var _loc4_:int = 0;
      var _loc5_:Users = null;
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
            case USERS:
               if(_loc2_.type == TType.LIST)
               {
                  _loc3_ = param1.readListBegin();
                  this.users = new Array();
                  _loc4_ = 0;
                  while(_loc4_ < _loc3_.size)
                  {
                     _loc5_ = new Users();
                     _loc5_.read(param1);
                     this.users.push(_loc5_);
                     _loc4_++;
                  }
                  param1.readListEnd();
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case AUDITRESULT:
               if(_loc2_.type == TType.I32)
               {
                  this.auditResult = param1.readI32();
                  this.__isset_auditResult = true;
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
      if(this.users != null)
      {
         param1.writeFieldBegin(USERS_FIELD_DESC);
         param1.writeListBegin(new TList(TType.STRUCT,this.users.length));
         for each(_loc2_ in this.users)
         {
            _loc2_.write(param1);
         }
         param1.writeListEnd();
         param1.writeFieldEnd();
      }
      param1.writeFieldBegin(AUDIT_RESULT_FIELD_DESC);
      param1.writeI32(this.auditResult);
      param1.writeFieldEnd();
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:String = new String("applyAuditMuch_args(");
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
      _loc1_ += "users:";
      if(this.users == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.users;
      }
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "auditResult:";
      _loc1_ += this.auditResult;
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

class applyAuditMuch_result implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("applyAuditMuch_result");
   
   private static const SUCCESS_FIELD_DESC:TField = new TField("success",TType.STRUCT,0);
   
   private static const E_FIELD_DESC:TField = new TField("e",TType.STRUCT,1);
   
   public static const SUCCESS:int = 0;
   
   public static const E:int = 1;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[SUCCESS] = new FieldMetaData("success",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,UnionBool));
   metaDataMap[E] = new FieldMetaData("e",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRUCT));
   FieldMetaData.addStructMetaDataMap(applyAuditMuch_result,metaDataMap);
   
   private var _success:UnionBool;
   
   private var _e:Err;
   
   public function applyAuditMuch_result()
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
      var _loc1_:String = new String("applyAuditMuch_result(");
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

class transfer_args implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("transfer_args");
   
   private static const HEADER_FIELD_DESC:TField = new TField("header",TType.STRUCT,1);
   
   private static const U_ID_FIELD_DESC:TField = new TField("uId",TType.I32,2);
   
   private static const INDEX_FIELD_DESC:TField = new TField("index",TType.STRING,3);
   
   private static const TRANSFER_RESULT_FIELD_DESC:TField = new TField("transferResult",TType.I32,4);
   
   public static const HEADER:int = 1;
   
   public static const UID:int = 2;
   
   public static const INDEX:int = 3;
   
   public static const TRANSFERRESULT:int = 4;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[HEADER] = new FieldMetaData("header",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,ApiHeader));
   metaDataMap[UID] = new FieldMetaData("uId",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
   metaDataMap[INDEX] = new FieldMetaData("index",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
   metaDataMap[TRANSFERRESULT] = new FieldMetaData("transferResult",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
   FieldMetaData.addStructMetaDataMap(transfer_args,metaDataMap);
   
   private var _header:ApiHeader;
   
   private var _uId:int;
   
   private var _index:String;
   
   private var _transferResult:int;
   
   private var __isset_uId:Boolean = false;
   
   private var __isset_transferResult:Boolean = false;
   
   public function transfer_args()
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
   
   public function get uId() : int
   {
      return this._uId;
   }
   
   public function set uId(param1:int) : void
   {
      this._uId = param1;
      this.__isset_uId = true;
   }
   
   public function unsetUId() : void
   {
      this.__isset_uId = false;
   }
   
   public function isSetUId() : Boolean
   {
      return this.__isset_uId;
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
   
   public function get transferResult() : int
   {
      return this._transferResult;
   }
   
   public function set transferResult(param1:int) : void
   {
      this._transferResult = param1;
      this.__isset_transferResult = true;
   }
   
   public function unsetTransferResult() : void
   {
      this.__isset_transferResult = false;
   }
   
   public function isSetTransferResult() : Boolean
   {
      return this.__isset_transferResult;
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
         case TRANSFERRESULT:
            if(param2 == null)
            {
               this.unsetTransferResult();
            }
            else
            {
               this.transferResult = param2;
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
         case UID:
            return this.uId;
         case INDEX:
            return this.index;
         case TRANSFERRESULT:
            return this.transferResult;
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
         case UID:
            return this.isSetUId();
         case INDEX:
            return this.isSetIndex();
         case TRANSFERRESULT:
            return this.isSetTransferResult();
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
            case UID:
               if(_loc2_.type == TType.I32)
               {
                  this.uId = param1.readI32();
                  this.__isset_uId = true;
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
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
            case TRANSFERRESULT:
               if(_loc2_.type == TType.I32)
               {
                  this.transferResult = param1.readI32();
                  this.__isset_transferResult = true;
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
      param1.writeFieldBegin(U_ID_FIELD_DESC);
      param1.writeI32(this.uId);
      param1.writeFieldEnd();
      if(this.index != null)
      {
         param1.writeFieldBegin(INDEX_FIELD_DESC);
         param1.writeString(this.index);
         param1.writeFieldEnd();
      }
      param1.writeFieldBegin(TRANSFER_RESULT_FIELD_DESC);
      param1.writeI32(this.transferResult);
      param1.writeFieldEnd();
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:String = new String("transfer_args(");
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
      _loc1_ += "uId:";
      _loc1_ += this.uId;
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
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
      _loc1_ += "transferResult:";
      _loc1_ += this.transferResult;
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

class transfer_result implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("transfer_result");
   
   private static const SUCCESS_FIELD_DESC:TField = new TField("success",TType.STRUCT,0);
   
   private static const E_FIELD_DESC:TField = new TField("e",TType.STRUCT,1);
   
   public static const SUCCESS:int = 0;
   
   public static const E:int = 1;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[SUCCESS] = new FieldMetaData("success",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,UnionBool));
   metaDataMap[E] = new FieldMetaData("e",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRUCT));
   FieldMetaData.addStructMetaDataMap(transfer_result,metaDataMap);
   
   private var _success:UnionBool;
   
   private var _e:Err;
   
   public function transfer_result()
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
      var _loc1_:String = new String("transfer_result(");
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
