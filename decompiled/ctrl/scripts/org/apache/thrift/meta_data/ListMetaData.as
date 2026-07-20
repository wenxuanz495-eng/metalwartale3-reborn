package org.apache.thrift.meta_data
{
   public class ListMetaData extends FieldValueMetaData
   {
      
      public var elemMetaData:FieldValueMetaData;
      
      public function ListMetaData(param1:int, param2:FieldValueMetaData)
      {
         super(param1);
         this.elemMetaData = param2;
      }
   }
}

