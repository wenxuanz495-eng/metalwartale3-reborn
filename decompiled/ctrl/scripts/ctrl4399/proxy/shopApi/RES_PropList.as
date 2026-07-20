package ctrl4399.proxy.shopApi
{
   import flash.utils.Dictionary;
   import org.apache.thrift.*;
   import org.apache.thrift.meta_data.*;
   import org.apache.thrift.protocol.*;
   
   public class RES_PropList implements TBase
   {
      
      private static const STRUCT_DESC:TStruct = new TStruct("RES_PropList");
      
      private static const DATA_FIELD_DESC:TField = new TField("data",TType.LIST,1);
      
      public static const DATA:int = 1;
      
      public static const metaDataMap:Dictionary = new Dictionary();
      
      metaDataMap[DATA] = new FieldMetaData("data",TFieldRequirementType.REQUIRED,new ListMetaData(TType.LIST,new StructMetaData(TType.STRUCT,Sole_PropList)));
      FieldMetaData.addStructMetaDataMap(RES_PropList,metaDataMap);
      
      private var _data:Array;
      
      public function RES_PropList()
      {
         super();
      }
      
      public function get data() : Array
      {
         return this._data;
      }
      
      public function set data(param1:Array) : void
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
            case DATA:
               if(param2 == null)
               {
                  this.unsetData();
               }
               else
               {
                  this.data = param2;
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
            case DATA:
               return this.isSetData();
            default:
               throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
         }
      }
      
      public function read(param1:TProtocol) : void
      {
         var _loc2_:TField = null;
         var _loc3_:TList = null;
         var _loc4_:int = 0;
         var _loc5_:Sole_PropList = null;
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
               case DATA:
                  if(_loc2_.type == TType.LIST)
                  {
                     _loc3_ = param1.readListBegin();
                     this.data = new Array();
                     _loc4_ = 0;
                     while(_loc4_ < _loc3_.size)
                     {
                        _loc5_ = new Sole_PropList();
                        _loc5_.read(param1);
                        this.data.push(_loc5_);
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
         if(this.data != null)
         {
            param1.writeFieldBegin(DATA_FIELD_DESC);
            param1.writeListBegin(new TList(TType.STRUCT,this.data.length));
            for each(_loc2_ in this.data)
            {
               _loc2_.write(param1);
            }
            param1.writeListEnd();
            param1.writeFieldEnd();
         }
         param1.writeFieldStop();
         param1.writeStructEnd();
      }
      
      public function toString() : String
      {
         var _loc1_:String = new String("RES_PropList(");
         var _loc2_:Boolean = true;
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
         if(this.data == null)
         {
            throw new TProtocolError(TProtocolError.UNKNOWN,"Required field \'data\' was not present! Struct: " + this.toString());
         }
      }
   }
}

