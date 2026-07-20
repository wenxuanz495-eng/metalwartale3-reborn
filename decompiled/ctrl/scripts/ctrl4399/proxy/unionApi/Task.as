package ctrl4399.proxy.unionApi
{
   import flash.utils.Dictionary;
   import org.apache.thrift.*;
   import org.apache.thrift.meta_data.*;
   import org.apache.thrift.protocol.*;
   
   public class Task implements TBase
   {
      
      private static const STRUCT_DESC:TStruct = new TStruct("Task");
      
      private static const TASK_NAME_FIELD_DESC:TField = new TField("taskName",TType.STRING,1);
      
      private static const VALUE_FIELD_DESC:TField = new TField("value",TType.STRING,2);
      
      public static const TASKNAME:int = 1;
      
      public static const VALUE:int = 2;
      
      public static const metaDataMap:Dictionary = new Dictionary();
      
      metaDataMap[TASKNAME] = new FieldMetaData("taskName",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      metaDataMap[VALUE] = new FieldMetaData("value",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
      FieldMetaData.addStructMetaDataMap(Task,metaDataMap);
      
      private var _taskName:String;
      
      private var _value:String;
      
      public function Task()
      {
         super();
      }
      
      public function get taskName() : String
      {
         return this._taskName;
      }
      
      public function set taskName(param1:String) : void
      {
         this._taskName = param1;
      }
      
      public function unsetTaskName() : void
      {
         this.taskName = null;
      }
      
      public function isSetTaskName() : Boolean
      {
         return this.taskName != null;
      }
      
      public function get value() : String
      {
         return this._value;
      }
      
      public function set value(param1:String) : void
      {
         this._value = param1;
      }
      
      public function unsetValue() : void
      {
         this.value = null;
      }
      
      public function isSetValue() : Boolean
      {
         return this.value != null;
      }
      
      public function setFieldValue(param1:int, param2:*) : void
      {
         switch(param1)
         {
            case TASKNAME:
               if(param2 == null)
               {
                  this.unsetTaskName();
               }
               else
               {
                  this.taskName = param2;
               }
               break;
            case VALUE:
               if(param2 == null)
               {
                  this.unsetValue();
               }
               else
               {
                  this.value = param2;
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
            case TASKNAME:
               return this.taskName;
            case VALUE:
               return this.value;
            default:
               throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
         }
      }
      
      public function isSet(param1:int) : Boolean
      {
         switch(param1)
         {
            case TASKNAME:
               return this.isSetTaskName();
            case VALUE:
               return this.isSetValue();
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
               case TASKNAME:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.taskName = param1.readString();
                  }
                  else
                  {
                     TProtocolUtil.skip(param1,_loc2_.type);
                  }
                  break;
               case VALUE:
                  if(_loc2_.type == TType.STRING)
                  {
                     this.value = param1.readString();
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
         if(this.taskName != null)
         {
            param1.writeFieldBegin(TASK_NAME_FIELD_DESC);
            param1.writeString(this.taskName);
            param1.writeFieldEnd();
         }
         if(this.value != null)
         {
            param1.writeFieldBegin(VALUE_FIELD_DESC);
            param1.writeString(this.value);
            param1.writeFieldEnd();
         }
         param1.writeFieldStop();
         param1.writeStructEnd();
      }
      
      public function toString() : String
      {
         var _loc1_:String = new String("Task(");
         var _loc2_:Boolean = true;
         _loc1_ += "taskName:";
         if(this.taskName == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.taskName;
         }
         _loc2_ = false;
         if(!_loc2_)
         {
            _loc1_ += ", ";
         }
         _loc1_ += "value:";
         if(this.value == null)
         {
            _loc1_ += "null";
         }
         else
         {
            _loc1_ += this.value;
         }
         _loc2_ = false;
         return _loc1_ + ")";
      }
      
      public function validate() : void
      {
      }
   }
}

