package gameAll.define.property
{
   public class NormalPropertyLevelDefine
   {
      
      public var minLevel:int = 1;
      
      public var maxLevel:int = 1;
      
      public var minValue:Number = 0;
      
      public var maxValue:Number = 0;
      
      public function NormalPropertyLevelDefine()
      {
         super();
      }
      
      public function inData_byXML(xml0:XML) : *
      {
         var arr0:Array = String(xml0.@range).split(",");
         var arr1:Array = String(xml0).split(",");
         this.minLevel = Number(arr0[0]);
         this.maxLevel = Number(arr0[1]);
         this.minValue = Number(arr1[0]);
         this.maxValue = Number(arr1[1]);
      }
   }
}

