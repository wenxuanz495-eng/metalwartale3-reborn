package ctrl4399.proxy.gameListApi
{
   import flash.utils.Dictionary;
   import org.apache.thrift.*;
   import org.apache.thrift.meta_data.*;
   import org.apache.thrift.protocol.*;
   
   public class FR_exception extends Error implements TBase
   {
      
      private static const STRUCT_DESC:TStruct = new TStruct("FR_exception");
      
      private static const CODE_FIELD_DESC:TField = new TField("code",TType.I32,1);
      
      private static const MSG_FIELD_DESC:TField = new TField("msg",TType.STRING,2);
      
      public static const CODE:int = 1;
      
      public static const MSG:int = 2;
      
      public static const metaDataMap:Dictionary = new Dictionary();
      
      metaDataMap[CODE] = new FieldMetaData("code",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
      metaDataMap[MSG] = new FieldMetaData("msg",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      FieldMetaData.addStructMetaDataMap(FR_exception,metaDataMap);
      
      private var _code:int;
      
      private var _msg:String;
      
      private var __isset_code:Boolean = false;
      
      public function FR_exception()
      {
         super();
      }
      
      public function get code() : int
      {
         return this._code;
      }
      
      public function set code(param1:int) : void
      {
         this._code = param1;
         this.__isset_code = true;
      }
      
      public function unsetCode() : void
      {
         this.__isset_code = false;
      }
      
      public function isSetCode() : Boolean
      {
         return this.__isset_code;
      }
      
      public function get msg() : String
      {
         return this._msg;
      }
      
      public function set msg(param1:String) : void
      {
         this._msg = param1;
      }
      
      public function unsetMsg() : void
      {
         this.msg = null;
      }
      
      public function isSetMsg() : Boolean
      {
         return this.msg != null;
      }
      
      public function setFieldValue(param1:int, param2:*) : void
      {
         switch(param1)
         {
            case CODE:
               if(param2 == null)
               {
                  this.unsetCode();
               }
               else
               {
                  this.code = param2;
               }
               break;
            case MSG:
               if(param2 == null)
               {
                  this.unsetMsg();
               }
               else
               {
                  this.msg = param2;
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
            case CODE:
               return this.code;
            case MSG:
               return this.msg;
            default:
               throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
         }
      }
      
      public function isSet(param1:int) : Boolean
      {
         switch(param1)
         {
            case CODE:
               return this.isSetCode();
            case MSG:
               return this.isSetMsg();
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
               case CODE:
                  if(_loc2_.type == TType.I32)
                  {
                     this.code = param1.readI32();
                     this.__isset_code = true;
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case MSG:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.msg = param1.readString();
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
         param1.writeFieldBegin(CODE_FIELD_DESC);
         param1.writeI32(this.code);
         param1.writeFieldEnd();
         if(this.msg != null)
         {
            param1.writeFieldBegin(MSG_FIELD_DESC);
            param1.writeString(this.msg);
            param1.writeFieldEnd();
         }
         param1.writeFieldStop();
         param1.writeStructEnd();
      }
      
      public function toString() : String
      {
         var _loc1_:String = new String("FR_exception(");
         var _loc2_:Boolean = true;
         _loc1_ += "code:";
         _loc1_ += this.code;
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "msg:";
         if(this.msg == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.msg;
         }
         _loc2_ = false;
         return _loc1_ + ")";
      }
      
      public function validate() : void
      {
      }
   }
}

