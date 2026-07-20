package gameAll.define.drop
{
   public class DropCarDiffDefine
   {
      
      public var items:oneDropDefine = new oneDropDefine();
      
      public var car:oneDropDefine = new oneDropDefine();
      
      public function DropCarDiffDefine()
      {
         super();
      }
      
      public function inData_byXML(xml0:XML) : *
      {
         this.items.inData_byXML(xml0.items[0]);
         this.car.inData_byXML(xml0.car[0]);
      }
   }
}

