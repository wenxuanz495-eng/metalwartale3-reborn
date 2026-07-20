package ctrl4399.proxy.unionApi
{
   import flash.utils.Dictionary;
   import org.apache.thrift.*;
   import org.apache.thrift.meta_data.*;
   import org.apache.thrift.protocol.*;
   
   public class RES_ApplyList implements TBase
   {
      
      private static const STRUCT_DESC:TStruct = new TStruct("RES_ApplyList");
      
      private static const TAG_FIELD_DESC:TField = new TField("tag",TType.STRING,1);
      
      private static const APPLY_LIST_FIELD_DESC:TField = new TField("applyList",TType.LIST,2);
      
      private static const COUNT_FIELD_DESC:TField = new TField("count",TType.STRING,3);
      
      public static const TAG:int = 1;
      
      public static const APPLYLIST:int = 2;
      
      public static const COUNT:int = 3;
      
      public static const metaDataMap:Dictionary = new Dictionary();
      
      metaDataMap[TAG] = new FieldMetaData("tag",TFieldRequirementType.REQUIRED,new FieldValueMetaData(TType.STRING));
      metaDataMap[APPLYLIST] = new FieldMetaData("applyList",TFieldRequirementType.DEFAULT,new ListMetaData(TType.LIST,new StructMetaData(TType.STRUCT,Apply)));
      metaDataMap[COUNT] = new FieldMetaData("count",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      FieldMetaData.addStructMetaDataMap(RES_ApplyList,metaDataMap);
      
      private var _tag:String;
      
      private var _applyList:Array;
      
      private var _count:String;
      
      public function RES_ApplyList()
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
      
      public function get applyList() : Array
      {
         return this._applyList;
      }
      
      public function set applyList(param1:Array) : void
      {
         this._applyList = param1;
      }
      
      public function unsetApplyList() : void
      {
         this.applyList = null;
      }
      
      public function isSetApplyList() : Boolean
      {
         return this.applyList != null;
      }
      
      public function get count() : String
      {
         return this._count;
      }
      
      public function set count(param1:String) : void
      {
         this._count = param1;
      }
      
      public function unsetCount() : void
      {
         this.count = null;
      }
      
      public function isSetCount() : Boolean
      {
         return this.count != null;
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
            case APPLYLIST:
               if(param2 == null)
               {
                  this.unsetApplyList();
               }
               else
               {
                  this.applyList = param2;
               }
               break;
            case COUNT:
               if(param2 == null)
               {
                  this.unsetCount();
               }
               else
               {
                  this.count = param2;
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
            case APPLYLIST:
               return this.applyList;
            case COUNT:
               return this.count;
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
            case APPLYLIST:
               return this.isSetApplyList();
            case COUNT:
               return this.isSetCount();
            default:
               throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
         }
      }
      
      public function read(param1:TProtocol) : void
      {
         var _loc2_:TField = null;
         var _loc3_:TList = null;
         var _loc4_:int = 0;
         var _loc5_:Apply = null;
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
               case APPLYLIST:
                  if(_loc2_.type == TType.LIST)
                  {
                     _loc3_ = param1.readListBegin();
                     this.applyList = new Array();
                     _loc4_ = 0;
                     while(_loc4_ < _loc3_.size)
                     {
                        _loc5_ = new Apply();
                        _loc5_.read(param1);
                        this.applyList.push(_loc5_);
                        _loc4_++;
                     }
                     param1.readListEnd();
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case COUNT:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.count = param1.readString();
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
         if(this.tag != null)
         {
            param1.writeFieldBegin(TAG_FIELD_DESC);
            param1.writeString(this.tag);
            param1.writeFieldEnd();
         }
         if(this.applyList != null)
         {
            param1.writeFieldBegin(APPLY_LIST_FIELD_DESC);
            param1.writeListBegin(new TList(TType.STRUCT,this.applyList.length));
            for each(_loc2_ in this.applyList)
            {
               _loc2_.write(param1);
            }
            param1.writeListEnd();
            param1.writeFieldEnd();
         }
         if(this.count != null)
         {
            param1.writeFieldBegin(COUNT_FIELD_DESC);
            param1.writeString(this.count);
            param1.writeFieldEnd();
         }
         param1.writeFieldStop();
         param1.writeStructEnd();
      }
      
      public function toString() : String
      {
         var _loc1_:String = new String("RES_ApplyList(");
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
         _loc1_ += "applyList:";
         if(this.applyList == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.applyList;
         }
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "count:";
         if(this.count == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.count;
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

