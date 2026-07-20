package UI.label
{
   import UI.ClickEvent;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   
   public class LabelCtrl extends EventDispatcher
   {
      
      public var arr:Array = [];
      
      public var label_arr:Array = [];
      
      public var light_sp:Sprite = null;
      
      public var nowIndex:int = 0;
      
      public var nowLabel:String = "";
      
      public var autoMouseB:Boolean = true;
      
      public function LabelCtrl()
      {
         super();
      }
      
      public function inData(arr0:Array, light_sp0:Sprite, label_arr0:Array = null) : *
      {
         var n:* = undefined;
         var btn0:InteractiveObject = null;
         this.clearData();
         this.arr = arr0;
         this.label_arr = label_arr0;
         if(this.label_arr == null)
         {
            this.label_arr = [];
         }
         this.light_sp = light_sp0;
         for(n in this.arr)
         {
            btn0 = this.arr[n];
            this.addEL(btn0);
            if(label_arr0 == null)
            {
               this.label_arr.push(btn0.name.split("_btn")[0]);
            }
         }
         this.setChoose(0);
      }
      
      public function clearData() : *
      {
         var n:* = undefined;
         var btn0:InteractiveObject = null;
         for(n in this.arr)
         {
            btn0 = this.arr[n];
            this.removeEL(btn0);
         }
         this.arr.length = 0;
         this.label_arr.length = 0;
         this.nowIndex = 0;
         this.nowLabel = "";
         this.light_sp = null;
      }
      
      public function setChoose(i0:int) : *
      {
         var n:* = undefined;
         var btn0:InteractiveObject = null;
         for(n in this.arr)
         {
            btn0 = this.arr[n];
            if(this.autoMouseB)
            {
               btn0.mouseEnabled = true;
            }
            if(n == i0)
            {
               if(this.autoMouseB)
               {
                  btn0.mouseEnabled = false;
               }
               this.light_sp.x = btn0.x;
               this.light_sp.y = btn0.y;
            }
         }
         this.nowLabel = this.label_arr[i0];
         this.nowIndex = i0;
      }
      
      public function setChoose_byLabel(l0:String) : *
      {
         var i0:int = this.label_arr.indexOf(l0);
         if(i0 >= 0)
         {
            this.setChoose(i0);
         }
      }
      
      protected function addEL(lb0:*) : *
      {
         lb0.addEventListener(MouseEvent.CLICK,this.buttonClick);
      }
      
      protected function removeEL(lb0:*) : *
      {
         lb0.removeEventListener(MouseEvent.CLICK,this.buttonClick);
      }
      
      protected function setGoul(clickEvent:ClickEvent, event:MouseEvent) : *
      {
         clickEvent.goal = event.target;
         clickEvent.index = this.arr.indexOf(event.target);
      }
      
      protected function buttonClick(event:MouseEvent) : *
      {
         var clickEvent:ClickEvent = new ClickEvent();
         this.setGoul(clickEvent,event);
         this.setChoose(this.arr.indexOf(event.target));
         this.dispatchEvent(clickEvent);
      }
   }
}

