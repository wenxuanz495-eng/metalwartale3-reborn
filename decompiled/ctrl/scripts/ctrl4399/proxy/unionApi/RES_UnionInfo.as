package ctrl4399.proxy.unionApi
{
   import flash.utils.Dictionary;
   import org.apache.thrift.*;
   import org.apache.thrift.meta_data.*;
   import org.apache.thrift.protocol.*;
   
   public class RES_UnionInfo implements TBase
   {
      
      private static const STRUCT_DESC:TStruct = new TStruct("RES_UnionInfo");
      
      private static const TAG_FIELD_DESC:TField = new TField("tag",TType.STRING,1);
      
      private static const UNION_INFO_FIELD_DESC:TField = new TField("unionInfo",TType.STRUCT,2);
      
      public static const TAG:int = 1;
      
      public static const UNIONINFO:int = 2;
      
      public static const metaDataMap:Dictionary = new Dictionary();
      
      metaDataMap[TAG] = new FieldMetaData("tag",TFieldRequirementType.REQUIRED,new FieldValueMetaData(TType.STRING));
      metaDataMap[UNIONINFO] = new FieldMetaData("unionInfo",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,Union));
      FieldMetaData.addStructMetaDataMap(RES_UnionInfo,metaDataMap);
      
      private var _tag:String;
      
      private var _unionInfo:Union;
      
      public function RES_UnionInfo()
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
      
      public function get unionInfo() : Union
      {
         return this._unionInfo;
      }
      
      public function set unionInfo(param1:Union) : void
      {
         this._unionInfo = param1;
      }
      
      public function unsetUnionInfo() : void
      {
         this.unionInfo = null;
      }
      
      public function isSetUnionInfo() : Boolean
      {
         return this.unionInfo != null;
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
            case UNIONINFO:
               if(param2 == null)
               {
                  this.unsetUnionInfo();
               }
               else
               {
                  this.unionInfo = param2;
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
            case UNIONINFO:
               return this.unionInfo;
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
            case UNIONINFO:
               return this.isSetUnionInfo();
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
               case UNIONINFO:
                  if(_loc2_.type == TType.STRUCT)
                  {
                     this.unionInfo = new Union();
                     this.unionInfo.read(param1);
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
         if(this.unionInfo != null)
         {
            param1.writeFieldBegin(UNION_INFO_FIELD_DESC);
            this.unionInfo.write(param1);
            param1.writeFieldEnd();
         }
         param1.writeFieldStop();
         param1.writeStructEnd();
      }
      
      public function toString() : String
      {
         var _loc1_:String = new String("RES_UnionInfo(");
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
         _loc1_ += "unionInfo:";
         if(this.unionInfo == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.unionInfo;
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

