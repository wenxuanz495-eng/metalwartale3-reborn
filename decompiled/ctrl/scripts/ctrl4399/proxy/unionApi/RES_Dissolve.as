package ctrl4399.proxy.unionApi
{
   import flash.utils.Dictionary;
   import org.apache.thrift.*;
   import org.apache.thrift.meta_data.*;
   import org.apache.thrift.protocol.*;
   
   public class RES_Dissolve implements TBase
   {
      
      private static const STRUCT_DESC:TStruct = new TStruct("RES_Dissolve");
      
      private static const TAG_FIELD_DESC:TField = new TField("tag",TType.STRING,1);
      
      private static const RESULT_FIELD_DESC:TField = new TField("result",TType.STRING,2);
      
      public static const TAG:int = 1;
      
      public static const RESULT:int = 2;
      
      public static const metaDataMap:Dictionary = new Dictionary();
      
      metaDataMap[TAG] = new FieldMetaData("tag",TFieldRequirementType.REQUIRED,new FieldValueMetaData(TType.STRING));
      metaDataMap[RESULT] = new FieldMetaData("result",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      FieldMetaData.addStructMetaDataMap(RES_Dissolve,metaDataMap);
      
      private var _tag:String;
      
      private var _result:String;
      
      public function RES_Dissolve()
      {
         super();
      }
      
      public function get tag() : String
      {
         return this._tag;
      }
      
      public function set tag(param1:String) : void
      {
         this._tag = param1;
      }
      
      public function unsetTag() : void
      {
         this.tag = null;
      }
      
      public function isSetTag() : Boolean
      {
         return this.tag != null;
      }
      
      public function get result() : String
      {
         return this._result;
      }
      
      public function set result(param1:String) : void
      {
         this._result = param1;
      }
      
      public function unsetResult() : void
      {
         this.result = null;
      }
      
      public function isSetResult() : Boolean
      {
         return this.result != null;
      }
      
      public function setFieldValue(param1:int, param2:*) : void
      {
         switch(param1)
         {
            case TAG:
               if(param2 == null)
               {
                  this.unsetTag();
               }
               else
               {
                  this.tag = param2;
               }
               break;
            case RESULT:
               if(param2 == null)
               {
                  this.unsetResult();
               }
               else
               {
                  this.result = param2;
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
            case TAG:
               return this.tag;
            case RESULT:
               return this.result;
            default:
               throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
         }
      }
      
      public function isSet(param1:int) : Boolean
      {
         switch(param1)
         {
            case TAG:
               return this.isSetTag();
            case RESULT:
               return this.isSetResult();
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
               case TAG:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.tag = param1.readString();
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case RESULT:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.result = param1.readString();
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
         if(this.tag != null)
         {
            param1.writeFieldBegin(TAG_FIELD_DESC);
            param1.writeString(this.tag);
            param1.writeFieldEnd();
         }
         if(this.result != null)
         {
            param1.writeFieldBegin(RESULT_FIELD_DESC);
            param1.writeString(this.result);
            param1.writeFieldEnd();
         }
         param1.writeFieldStop();
         param1.writeStructEnd();
      }
      
      public function toString() : String
      {
         var _loc1_:String = new String("RES_Dissolve(");
         var _loc2_:Boolean = true;
         _loc1_ += "tag:";
         if(this.tag == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.tag;
         }
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "result:";
         if(this.result == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.result;
         }
         _loc2_ = false;
         return _loc1_ + ")";
      }
      
      public function validate() : void
      {
         if(this.tag == null)
         {
            throw new TProtocolError(TProtocolError.UNKNOWN,"Required field \'tag\' was not present! Struct: " + this.toString());
         }
      }
   }
}

