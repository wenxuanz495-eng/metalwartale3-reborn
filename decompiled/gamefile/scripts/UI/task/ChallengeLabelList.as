package UI.task
{
   import UI.label.LabelBox;
   import flash.events.MouseEvent;
   
   public class ChallengeLabelList extends LabelBox
   {
      
      public function ChallengeLabelList()
      {
         super();
      }
      
      public function inData_byArr(arr0:Array) : *
      {
         var n:* = undefined;
         var label0:* = undefined;
         var d0:* = undefined;
         var rebirthB:Boolean = false;
         if(arr.length == 0)
         {
            rebirthB = true;
         }
         for(n in arr0)
         {
            if(rebirthB)
            {
               label0 = new CLASS();
            }
            else
            {
               label0 = arr[n];
            }
            label0.index = n;
            label0.addEventListener(MouseEvent.CLICK,click);
            addChild(label0);
            arr[n] = label0;
            d0 = arr0[n];
            label0.setText(d0.getTitle());
            label0.setNowState(d0.state);
            label0.itemsData = d0;
         }
         setPosition(false,arr.length * 55 + (arr.length - 1) * 5);
         showState(0);
      }
      
      public function showLabel(num0:int, activedB:Boolean = false) : *
      {
         var n:* = undefined;
         var lb0:* = undefined;
         for(n in arr)
         {
            lb0 = arr[n];
            if(n == num0)
            {
               lb0.setState(1);
            }
            else if(activedB)
            {
               lb0.setState(2);
            }
            else
            {
               lb0.setState(0);
            }
         }
      }
   }
}

