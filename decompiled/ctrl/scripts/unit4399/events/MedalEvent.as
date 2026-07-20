package unit4399.events
{
   import flash.events.Event;
   
   public class MedalEvent extends Event
   {
      
      public static const MEDAL_RESTARTGAME:String = "medalRestartGame";
      
      protected var _data:Object;
      
      public function MedalEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._data = param2;
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      override public function clone() : Event
      {
         return new MedalEvent(type,this.data,bubbles,cancelable);
      }
   }
}

