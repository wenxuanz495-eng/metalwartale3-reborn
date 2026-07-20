package ctrl4399.view.components
{
   import flash.events.Event;
   
   public class ComponentEvent extends Event
   {
      
      private var _data:Object;
      
      public function ComponentEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
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
         return new ComponentEvent(type,this._data);
      }
   }
}

