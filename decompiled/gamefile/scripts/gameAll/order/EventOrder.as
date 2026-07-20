package gameAll.order
{
   import data.ClassProperty;
   import flash.geom.Point;
   
   public class EventOrder extends EventOrderUnit
   {
      
      public var time:Number = 0;
      
      public var position:Point = new Point();
      
      public function EventOrder()
      {
         super();
      }
      
      public function toString() : *
      {
         return "name:" + name + "   time:" + this.time + "   position:" + this.position;
      }
      
      public function inData_byOrder(eou:EventOrderUnit) : *
      {
         ClassProperty.inData(this,eou,pro_arr);
      }
   }
}

