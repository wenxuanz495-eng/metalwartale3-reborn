package ctrl4399.proxy.unionApi
{
   import flash.utils.Dictionary;
   import org.apache.thrift.*;
   import org.apache.thrift.meta_data.*;
   import org.apache.thrift.protocol.*;
   
   public class Me implements TBase
   {
      
      private static const STRUCT_DESC:TStruct = new TStruct("Me");
      
      private static const UNION_INFO_FIELD_DESC:TField = new TField("unionInfo",TType.STRUCT,1);
      
      private static const MEMBER_FIELD_DESC:TField = new TField("member",TType.STRUCT,2);
      
      public static const UNIONINFO:int = 1;
      
      public static const MEMBER:int = 2;
      
      public static const metaDataMap:Dictionary = new Dictionary();
      
      metaDataMap[UNIONINFO] = new FieldMetaData("unionInfo",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,Union));
      metaDataMap[MEMBER] = new FieldMetaData("member",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,Member));
      FieldMetaData.addStructMetaDataMap(Me,metaDataMap);
      
      private var _unionInfo:Union;
      
      private var _member:Member;
      
      public function Me()
      {
         super();
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
      
      public function get member() : Member
      {
         return this._member;
      }
      
      public function set member(param1:Member) : void
      {
         this._member = param1;
      }
      
      public function unsetMember() : void
      {
         this.member = null;
      }
      
      public function isSetMember() : Boolean
      {
         return this.member != null;
      }
      
      public function setFieldValue(param1:int, param2:*) : void
      {
         switch(param1)
         {
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
            case MEMBER:
               if(param2 == null)
               {
                  this.unsetMember();
               }
               else
               {
                  this.member = param2;
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
            case UNIONINFO:
               return this.unionInfo;
            case MEMBER:
               return this.member;
            default:
               throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
         }
      }
      
      public function isSet(param1:int) : Boolean
      {
         switch(param1)
         {
            case UNIONINFO:
               return this.isSetUnionInfo();
            case MEMBER:
               return this.isSetMember();
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
               case MEMBER:
                  if(_loc2_.type == TType.STRUCT)
                  {
                     this.member = new Member();
                     this.member.read(param1);
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
         if(this.unionInfo != null)
         {
            param1.writeFieldBegin(UNION_INFO_FIELD_DESC);
            this.unionInfo.write(param1);
            param1.writeFieldEnd();
         }
         if(this.member != null)
         {
            param1.writeFieldBegin(MEMBER_FIELD_DESC);
            this.member.write(param1);
            param1.writeFieldEnd();
         }
         param1.writeFieldStop();
         param1.writeStructEnd();
      }
      
      public function toString() : String
      {
         var _loc1_:String = new String("Me(");
         var _loc2_:Boolean = true;
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
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "member:";
         if(this.member == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.member;
         }
         _loc2_ = false;
         return _loc1_ + ")";
      }
      
      public function validate() : void
      {
      }
   }
}

