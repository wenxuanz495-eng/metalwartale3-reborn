package UI.helper
{
   import UI.ClickEvent;
   import UI.label.NormalIconBox;
   import flash.events.MouseEvent;
   
   public class HelperContextBox extends NormalIconBox
   {
      
      public function HelperContextBox()
      {
         super();
      }
      
      override protected function addEL(lb0:*) : *
      {
         lb0._btn.addEventListener(MouseEvent.CLICK,buttonClick);
      }
      
      override protected function removeEL(lb0:*) : *
      {
         lb0._btn.removeEventListener(MouseEvent.CLICK,buttonClick);
      }
      
      override protected function setGoul(clickEvent:ClickEvent, event:MouseEvent) : *
      {
         clickEvent.goal = event.target.parent;
         clickEvent.index = event.target.parent.index;
      }
      
      public function inData(arr0:Array) : *
      {
         var n:* = undefined;
         var lb0:HelperContextBar = null;
         clear();
         var arr1:Array = [];
         for(n in arr0)
         {
            lb0 = new HelperContextBar();
            lb0.inData_byDefine(arr0[n]);
            arr1.push(lb0);
         }
         inData_byArr(arr1);
      }
   }
}

