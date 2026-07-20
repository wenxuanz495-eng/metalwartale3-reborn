package ctrl4399.proxy.scoreApi
{
   import flash.utils.Dictionary;
   import org.apache.thrift.*;
   import org.apache.thrift.meta_data.*;
   import org.apache.thrift.protocol.*;
   
   public class ReturnSubmitScore implements TBase
   {
      
      private static const STRUCT_DESC:TStruct = new TStruct("ReturnSubmitScore");
      
      private static const CODE_FIELD_DESC:TField = new TField("code",TType.I32,1);
      
      private static const MESSAGE_FIELD_DESC:TField = new TField("message",TType.STRING,2);
      
      private static const DATA_FIELD_DESC:TField = new TField("data",TType.STRUCT,3);
      
      public static const CODE:int = 1;
      
      public static const MESSAGE:int = 2;
      
      public static const DATA:int = 3;
      
      public static const metaDataMap:Dictionary = new Dictionary();
      
      metaDataMap[CODE] = new FieldMetaData("code",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
      metaDataMap[MESSAGE] = new FieldMetaData("message",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[DATA] = new FieldMetaData("data",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,SubmitReturn));
      FieldMetaData.addStructMetaDataMap(ReturnSubmitScore,metaDataMap);
      
      private var _code:int;
      
      private var _message:String;
      
      private var _data:SubmitReturn;
      
      private var __isset_code:Boolean = false;
      
      public function ReturnSubmitScore()
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
      
      public function get data() : SubmitReturn
      {
         return this._data;
      }
      
      public function set data(param1:SubmitReturn) : void
      {
         this._data = param1;
      }
      
      public function unsetData() : void
      {
         this.data = null;
      }
      
      public function isSetData() : Boolean
      {
         return this.data != null;
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
            case DATA:
               if(param2 == null)
               {
                  this.unsetData();
               }
               else
               {
                  this.data = param2;
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
            case MESSAGE:
               return this.message;
            case DATA:
               return this.data;
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
            case MESSAGE:
               return this.isSetMessage();
            case DATA:
               return this.isSetData();
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
               case DATA:
                  if(_loc2_.type == TType.STRUCT)
                  {
                     this.data = new SubmitReturn();
                     this.data.read(param1);
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
         if(this.message != null)
         {
            param1.writeFieldBegin(MESSAGE_FIELD_DESC);
            param1.writeString(this.message);
            param1.writeFieldEnd();
         }
         if(this.data != null)
         {
            param1.writeFieldBegin(DATA_FIELD_DESC);
            this.data.write(param1);
            param1.writeFieldEnd();
         }
         param1.writeFieldStop();
         param1.writeStructEnd();
      }
      
      public function toString() : String
      {
         var _loc1_:String = new String("ReturnSubmitScore(");
         var _loc2_:Boolean = true;
         _loc1_ += "code:";
         _loc1_ += this.code;
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
         _loc1_ += "data:";
         if(this.data == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.data;
         }
         _loc2_ = false;
         return _loc1_ + ")";
      }
      
      public function validate() : void
      {
      }
   }
}

