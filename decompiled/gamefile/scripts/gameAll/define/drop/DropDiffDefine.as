package gameAll.define.drop
{
   public class DropDiffDefine
   {
      
      public var items:oneDropDefine = new oneDropDefine();
      
      public var chip:oneDropDefine = new oneDropDefine();
      
      public function DropDiffDefine()
      {
         super();
      }
      
      public function inData_byXML(xml0:XML) : *
      {
         var xml2:XML = xml0.items[0];
         this.items.inData_byXML(xml0.items[0]);
         this.chip.inData_byXML(xml0.chip[0]);
      }
   }
}

