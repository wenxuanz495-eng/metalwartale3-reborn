package UI
{
   import flash.events.Event;
   
   public class ClickEvent extends Event
   {
      
      public static var ON_CLICK:String = "onClick";
      
      public static var ON_DOWN:String = "onDown";
      
      public static var ON_UP:String = "onUp";
      
      public static var ON_OVER:String = "onOver";
      
      public static var ON_OUT:String = "onOut";
      
      public static var ON_MOVE:String = "onMove";
      
      public var goal:*;
      
      public var index:int = 0;
      
      public function ClickEvent(_type:String = "onClick")
      {
         super(_type);
      }
      
      override public function clone() : Event
      {
         var newEvent:ClickEvent = new ClickEvent();
         newEvent.goal = this.goal;
         newEvent.index = this.index;
         return newEvent;
      }
   }
}

