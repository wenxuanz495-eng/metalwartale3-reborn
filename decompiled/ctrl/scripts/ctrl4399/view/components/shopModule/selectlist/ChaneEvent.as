package ctrl4399.view.components.shopModule.selectlist
{
   import flash.events.Event;
   
   public class ChaneEvent extends Event
   {
      
      public static const CHANGE:String = "chaneEvent";
      
      private var __id:int;
      
      public function ChaneEvent(param1:String, param2:int)
      {
         super(param1);
         this.__id = param2;
      }
      
      public function get _id() : int
      {
         return this.__id;
      }
   }
}

