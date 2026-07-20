package gameAll.other
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class IDArea extends Rectangle
   {
      
      public var id:String = "";
      
      public var point:Point = new Point();
      
      public var index:int = 0;
      
      public var hitB:Boolean = false;
      
      public function IDArea()
      {
         super();
      }
      
      public function inData_byString(str:String) : *
      {
         var arr:Array = str.split(",");
         if(arr.length == 2)
         {
            this.point.x = arr[0];
            this.point.y = arr[1];
            x = this.point.x - 50;
            width = 100;
            height = 100000;
            y = -50000;
         }
         else if(arr.length == 4)
         {
            x = int(arr[0]);
            y = int(arr[1]);
            width = int(arr[2]);
            height = int(arr[3]);
            this.point.x = x + width / 2;
            this.point.y = y + height - 100;
         }
      }
   }
}

