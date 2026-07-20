package UI.level
{
   import UI.ClickEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class DifficultBox extends Sprite
   {
      
      public var db1:DifficultButton;
      
      public var db2:DifficultButton;
      
      public var db3:DifficultButton;
      
      public var db4:DifficultButton;
      
      public var arr:Array;
      
      public var nowDifficult:int = 0;
      
      internal var clickEvent:ClickEvent;
      
      public function DifficultBox()
      {
         var n:* = undefined;
         this.clickEvent = new ClickEvent();
         super();
         this.db1.setText("难度:普通");
         this.db2.setText("难度:噩梦");
         this.db3.setText("难度:地狱");
         this.db4.setText("难度:炼狱");
         this.arr = [this.db1,this.db2,this.db3,this.db4];
         for(n in this.arr)
         {
            this.arr[n].addEventListener(MouseEvent.CLICK,this.buttonClick);
            this.arr[n].addEventListener(MouseEvent.MOUSE_OVER,this.buttonOver);
            this.arr[n].addEventListener(MouseEvent.MOUSE_OUT,this.buttonOut);
            this.arr[n].addEventListener(MouseEvent.MOUSE_MOVE,this.buttonMove);
            this.arr[n].index = n;
         }
      }
      
      public function setState2(nowd:int, arr0:Array) : *
      {
         var n:* = undefined;
         var db0:DifficultButton = null;
         var lvl0:int = 0;
         for(n in this.arr)
         {
            db0 = this.arr[n];
            lvl0 = int(arr0[n]);
            if(lvl0 > 0)
            {
               db0.setState(0);
            }
            else
            {
               db0.setState(2);
            }
            if(n == nowd)
            {
               db0.setState(1);
            }
         }
      }
      
      public function setState(nowd:int) : *
      {
         this.setState2(nowd,[2,2,2,2]);
      }
      
      public function getState() : Array
      {
         var n:* = undefined;
         var arr1:Array = [];
         for(n in this.arr)
         {
            arr1[n] = this.arr[n].state;
         }
         return arr1;
      }
      
      private function buttonClick(event:MouseEvent) : *
      {
         var n:* = undefined;
         var db0:DifficultButton = null;
         var db10:* = event.target;
         if(!db10.actived)
         {
            return;
         }
         for(n in this.arr)
         {
            db0 = this.arr[n];
            if(db0.state == 0 || db0.state == 1)
            {
               db0.setState(0);
            }
         }
         if(db10.state == 0)
         {
            db10.setState(1);
            this.nowDifficult = db10.index;
            this.clickEvent.goal = this;
            this.dispatchEvent(this.clickEvent);
         }
      }
      
      private function buttonOver(event:*) : *
      {
         var downEvent:ClickEvent = new ClickEvent(ClickEvent.ON_OVER);
         downEvent.goal = event.target;
         downEvent.index = event.target.index;
         this.dispatchEvent(downEvent);
      }
      
      private function buttonOut(event:*) : *
      {
         var upEvent:ClickEvent = new ClickEvent(ClickEvent.ON_OUT);
         upEvent.goal = event.target;
         upEvent.index = event.target.index;
         this.dispatchEvent(upEvent);
      }
      
      private function buttonMove(event:*) : *
      {
         var upEvent:ClickEvent = new ClickEvent(ClickEvent.ON_MOVE);
         upEvent.goal = event.target;
         upEvent.index = event.target.index;
         this.dispatchEvent(upEvent);
      }
   }
}

