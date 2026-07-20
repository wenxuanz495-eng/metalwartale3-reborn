package org.events
{
   import flash.events.Event;
   
   public class EngineEvent extends Event
   {
      
      public static const CONFIG:String = "config";
      
      public static const INTABLE:String = "intable";
      
      public var data:*;
      
      public function EngineEvent(param1:String, param2:* = null)
      {
         this.data = param2;
         super(param1);
      }
      
      public function get eData() : *
      {
         return this.data;
      }
   }
}

