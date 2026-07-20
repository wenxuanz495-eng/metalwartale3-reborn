package UI.task
{
   import UI.ClickEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import gameAll.define.OneTaskDefine;
   
   public class TaskLabelList extends Sprite
   {
      
      public var l_1:TaskLabel;
      
      public var l_2:TaskLabel;
      
      public var l_3:TaskLabel;
      
      public var l_4:TaskLabel;
      
      public var l_5:TaskLabel;
      
      public var label_arr:Array;
      
      public var title_arr:Array;
      
      public function TaskLabelList()
      {
         var n:* = undefined;
         var lb0:TaskLabel = null;
         this.label_arr = [];
         this.title_arr = ["任务一","任务二","任务三","任务四","任务五"];
         super();
         this.label_arr = [this.l_1,this.l_2,this.l_3,this.l_4,this.l_5];
         for(n in this.label_arr)
         {
            lb0 = this.label_arr[n];
            lb0.setText(this.title_arr[n]);
            lb0.index = n;
            lb0.addEventListener(MouseEvent.CLICK,this.buttonClick);
            lb0.addEventListener(MouseEvent.MOUSE_DOWN,this.buttonDown);
            lb0.addEventListener(MouseEvent.MOUSE_UP,this.buttonUp);
            lb0.addEventListener(MouseEvent.MOUSE_OVER,this.buttonOver);
            lb0.addEventListener(MouseEvent.MOUSE_OUT,this.buttonOut);
         }
         this.showLabel(0);
      }
      
      public function setOneState(num0:int, state0:String) : *
      {
         var n:* = undefined;
         var lb0:TaskLabel = null;
         for(n in this.label_arr)
         {
            lb0 = this.label_arr[n];
            if(n == num0)
            {
               lb0.setNowState(state0);
            }
            else
            {
               lb0.setNowState("no");
            }
         }
      }
      
      public function inData_byArr(arr0:Array) : *
      {
         var n:* = undefined;
         var td0:OneTaskDefine = null;
         var lb0:TaskLabel = null;
         for(n in arr0)
         {
            td0 = arr0[n];
            lb0 = this.label_arr[n];
            lb0.setStar(td0.starLevel);
            if(td0.isSuperB())
            {
               lb0.nameTxt.textColor = 16776960;
            }
            else
            {
               lb0.nameTxt.textColor = 16777215;
            }
         }
      }
      
      public function showLabel(num0:int, activedB:Boolean = false) : *
      {
         var n:* = undefined;
         var lb0:TaskLabel = null;
         if(num0 < 0 && num0 > 4)
         {
            num0 = 0;
         }
         for(n in this.label_arr)
         {
            lb0 = this.label_arr[n];
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
      
      private function buttonClick(event:MouseEvent) : *
      {
         var clickEvent:ClickEvent = new ClickEvent();
         clickEvent.goal = event.target;
         clickEvent.index = event.target.index;
         this.dispatchEvent(clickEvent);
      }
      
      private function buttonDown(event:MouseEvent) : *
      {
         var downEvent:ClickEvent = new ClickEvent(ClickEvent.ON_DOWN);
         downEvent.goal = event.target;
         downEvent.index = event.target.index;
         this.dispatchEvent(downEvent);
      }
      
      private function buttonUp(event:MouseEvent) : *
      {
         var upEvent:ClickEvent = new ClickEvent(ClickEvent.ON_UP);
         upEvent.goal = event.target;
         upEvent.index = event.target.index;
         this.dispatchEvent(upEvent);
      }
      
      private function buttonOver(event:MouseEvent) : *
      {
         var downEvent:ClickEvent = new ClickEvent(ClickEvent.ON_OVER);
         downEvent.goal = event.target;
         downEvent.index = event.target.index;
         this.dispatchEvent(downEvent);
      }
      
      private function buttonOut(event:MouseEvent) : *
      {
         var upEvent:ClickEvent = new ClickEvent(ClickEvent.ON_OUT);
         upEvent.goal = event.target;
         upEvent.index = event.target.index;
         this.dispatchEvent(upEvent);
      }
   }
}

