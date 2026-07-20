package ctrl4399.proxy.gameListApi
{
   import flash.utils.Dictionary;
   import org.apache.thrift.*;
   import org.apache.thrift.meta_data.*;
   import org.apache.thrift.protocol.*;
   
   public class FR_adItem implements TBase
   {
      
      private static const STRUCT_DESC:TStruct = new TStruct("FR_adItem");
      
      private static const SOURCE_FIELD_DESC:TField = new TField("source",TType.STRING,1);
      
      private static const LINK_FIELD_DESC:TField = new TField("link",TType.STRING,2);
      
      public static const SOURCE:int = 1;
      
      public static const LINK:int = 2;
      
      public static const metaDataMap:Dictionary = new Dictionary();
      
      metaDataMap[SOURCE] = new FieldMetaData("source",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[LINK] = new FieldMetaData("link",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      FieldMetaData.addStructMetaDataMap(FR_adItem,metaDataMap);
      
      private var _source:String;
      
      private var _link:String;
      
      public function FR_adItem()
      {
         super();
      }
      
      public function get source() : String
      {
         return this._source;
      }
      
      public function set source(param1:String) : void
      {
         this._source = param1;
      }
      
      public function unsetSource() : void
      {
         this.source = null;
      }
      
      public function isSetSource() : Boolean
      {
         return this.source != null;
      }
      
      public function get link() : String
      {
         return this._link;
      }
      
      public function set link(param1:String) : void
      {
         this._link = param1;
      }
      
      public function unsetLink() : void
      {
         this.link = null;
      }
      
      public function isSetLink() : Boolean
      {
         return this.link != null;
      }
      
      public function setFieldValue(param1:int, param2:*) : void
      {
         switch(param1)
         {
            case SOURCE:
               if(param2 == null)
               {
                  this.unsetSource();
               }
               else
               {
                  this.source = param2;
               }
               break;
            case LINK:
               if(param2 == null)
               {
                  this.unsetLink();
               }
               else
               {
                  this.link = param2;
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
            case SOURCE:
               return this.source;
            case LINK:
               return this.link;
            default:
               throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
         }
      }
      
      public function isSet(param1:int) : Boolean
      {
         switch(param1)
         {
            case SOURCE:
               return this.isSetSource();
            case LINK:
               return this.isSetLink();
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
               case SOURCE:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.source = param1.readString();
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case LINK:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.link = param1.readString();
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
         if(this.source != null)
         {
            param1.writeFieldBegin(SOURCE_FIELD_DESC);
            param1.writeString(this.source);
            param1.writeFieldEnd();
         }
         if(this.link != null)
         {
            param1.writeFieldBegin(LINK_FIELD_DESC);
            param1.writeString(this.link);
            param1.writeFieldEnd();
         }
         param1.writeFieldStop();
         param1.writeStructEnd();
      }
      
      public function toString() : String
      {
         var _loc1_:String = new String("FR_adItem(");
         var _loc2_:Boolean = true;
         _loc1_ += "source:";
         if(this.source == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.source;
         }
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "link:";
         if(this.link == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.link;
         }
         _loc2_ = false;
         return _loc1_ + ")";
      }
      
      public function validate() : void
      {
      }
   }
}

