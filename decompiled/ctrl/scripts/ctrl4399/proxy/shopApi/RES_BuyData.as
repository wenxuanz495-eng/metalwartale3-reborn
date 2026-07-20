package ctrl4399.proxy.shopApi
{
   import flash.utils.Dictionary;
   import org.apache.thrift.*;
   import org.apache.thrift.meta_data.*;
   import org.apache.thrift.protocol.*;
   
   public class RES_BuyData implements TBase
   {
      
      private static const STRUCT_DESC:TStruct = new TStruct("RES_BuyData");
      
      private static const DATA_FIELD_DESC:TField = new TField("data",TType.STRUCT,1);
      
      public static const DATA:int = 1;
      
      public static const metaDataMap:Dictionary = new Dictionary();
      
      metaDataMap[DATA] = new FieldMetaData("data",TFieldRequirementType.REQUIRED,new StructMetaData(TType.STRUCT,Sole_BuyData));
      FieldMetaData.addStructMetaDataMap(RES_BuyData,metaDataMap);
      
      private var _data:Sole_BuyData;
      
      public function RES_BuyData()
      {
         super();
      }
      
      public function get data() : Sole_BuyData
      {
         return this._data;
      }
      
      public function set data(param1:Sole_BuyData) : void
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
                  if(_loc2_.type == TType.STRUCT)
                  {
                     this.data = new Sole_BuyData();
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
         var _loc1_:String = new String("RES_BuyData(");
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

