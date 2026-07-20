package ctrl4399.proxy.unionApi
{
   import flash.utils.Dictionary;
   import org.apache.thrift.*;
   import org.apache.thrift.meta_data.*;
   import org.apache.thrift.protocol.*;
   
   public class RES_Variables implements TBase
   {
      
      private static const STRUCT_DESC:TStruct = new TStruct("RES_Variables");
      
      private static const TAG_FIELD_DESC:TField = new TField("tag",TType.STRING,1);
      
      private static const VARIABLES_FIELD_DESC:TField = new TField("variables",TType.LIST,2);
      
      public static const TAG:int = 1;
      
      public static const VARIABLES:int = 2;
      
      public static const metaDataMap:Dictionary = new Dictionary();
      
      metaDataMap[TAG] = new FieldMetaData("tag",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[VARIABLES] = new FieldMetaData("variables",TFieldRequirementType.DEFAULT,new ListMetaData(TType.LIST,new StructMetaData(TType.STRUCT,variable)));
      FieldMetaData.addStructMetaDataMap(RES_Variables,metaDataMap);
      
      private var _tag:String;
      
      private var _variables:Array;
      
      public function RES_Variables()
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
      
      public function get variables() : Array
      {
         return this._variables;
      }
      
      public function set variables(param1:Array) : void
      {
         this._variables = param1;
      }
      
      public function unsetVariables() : void
      {
         this.variables = null;
      }
      
      public function isSetVariables() : Boolean
      {
         return this.variables != null;
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
            case VARIABLES:
               if(param2 == null)
               {
                  this.unsetVariables();
               }
               else
               {
                  this.variables = param2;
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
            case VARIABLES:
               return this.variables;
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
            case VARIABLES:
               return this.isSetVariables();
            default:
               throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
         }
      }
      
      public function read(param1:TProtocol) : void
      {
         var _loc2_:TField = null;
         var _loc3_:TList = null;
         var _loc4_:int = 0;
         var _loc5_:variable = null;
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
               case VARIABLES:
                  if(_loc2_.type == TType.LIST)
                  {
                     _loc3_ = param1.readListBegin();
                     this.variables = new Array();
                     _loc4_ = 0;
                     while(_loc4_ < _loc3_.size)
                     {
                        _loc5_ = new variable();
                        _loc5_.read(param1);
                        this.variables.push(_loc5_);
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
         if(this.tag != null)
         {
            param1.writeFieldBegin(TAG_FIELD_DESC);
            param1.writeString(this.tag);
            param1.writeFieldEnd();
         }
         if(this.variables != null)
         {
            param1.writeFieldBegin(VARIABLES_FIELD_DESC);
            param1.writeListBegin(new TList(TType.STRUCT,this.variables.length));
            for each(_loc2_ in this.variables)
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
         var _loc1_:String = new String("RES_Variables(");
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
         _loc1_ += "variables:";
         if(this.variables == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.variables;
         }
         _loc2_ = false;
         return _loc1_ + ")";
      }
      
      public function validate() : void
      {
      }
   }
}

