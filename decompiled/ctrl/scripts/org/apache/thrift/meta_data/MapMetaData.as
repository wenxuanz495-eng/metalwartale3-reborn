package org.apache.thrift.meta_data
{
   public class MapMetaData extends FieldValueMetaData
   {
      
      public var keyMetaData:FieldValueMetaData;
      
      public var valueMetaData:FieldValueMetaData;
      
      public function MapMetaData(param1:int, param2:FieldValueMetaData, param3:FieldValueMetaData)
      {
         super(param1);
         this.keyMetaData = param2;
         this.valueMetaData = param3;
      }
   }
}

