package UI.label
{
   import UI.ClickEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class NormalIconBox extends Sprite
   {
      
      public var totalPage:int = 1;
      
      public var nowPage:int = 0;
      
      public var totalNum:int = 0;
      
      public var xNum:int = 10;
      
      public var yNum:int = 10;
      
      protected var xGap:int = 0;
      
      protected var yGap:int = 0;
      
      public var horizontalB:Boolean = true;
      
      public var arr:Array = [];
      
      public function NormalIconBox()
      {
         super();
      }
      
      public function setSize(_x:int, _y:int, _xGap:int, _yGap:int) : *
      {
         this.xNum = _x;
         this.yNum = _y;
         this.xGap = _xGap;
         this.yGap = _yGap;
      }
      
      public function arrange() : *
      {
         var n:* = undefined;
         var lb0:* = undefined;
         var n0:int = 0;
         var firstIndex:int = this.xNum * this.yNum * this.nowPage;
         var lastIndex:int = firstIndex + this.xNum * this.yNum;
         for(n in this.arr)
         {
            lb0 = this.arr[n];
            if(n >= firstIndex && n < lastIndex)
            {
               lb0.visible = true;
               n0 = n - firstIndex;
               if(this.horizontalB)
               {
                  lb0.x = (this.xGap + lb0.width) * (n0 % this.xNum);
                  lb0.y = (this.yGap + lb0.height) * int(n0 / this.xNum);
               }
               else
               {
                  lb0.x = (this.xGap + lb0.width) * int(n0 / this.yNum);
                  lb0.y = (this.yGap + lb0.height) * (n0 % this.yNum);
               }
            }
            else
            {
               lb0.visible = false;
            }
         }
      }
      
      public function showPage(_num:int) : *
      {
         if(_num <= 0)
         {
            _num = 0;
         }
         else if(_num >= this.totalPage - 1)
         {
            _num = this.totalPage - 1;
         }
         this.nowPage = _num;
         this.arrange();
      }
      
      public function inData_byArr(arr0:Array) : *
      {
         var n:* = undefined;
         var lb0:* = undefined;
         this.clear();
         this.arr = arr0;
         for(n in this.arr)
         {
            lb0 = this.arr[n];
            lb0.index = n;
            this.addEL(lb0);
            this.addChild(lb0);
         }
         this.totalPage = int((this.arr.length - 1) / (this.xNum * this.yNum)) + 1;
         if(this.totalPage < 1)
         {
            this.totalPage = 1;
         }
         this.showPage(0);
      }
      
      protected function addEL(lb0:*) : *
      {
         lb0.addEventListener(MouseEvent.CLICK,this.buttonClick);
         lb0.addEventListener(MouseEvent.MOUSE_DOWN,this.buttonDown);
         lb0.addEventListener(MouseEvent.MOUSE_UP,this.buttonUp);
         lb0.addEventListener(MouseEvent.MOUSE_OVER,this.buttonOver);
         lb0.addEventListener(MouseEvent.MOUSE_OUT,this.buttonOut);
      }
      
      protected function removeEL(lb0:*) : *
      {
         lb0.removeEventListener(MouseEvent.CLICK,this.buttonClick);
         lb0.removeEventListener(MouseEvent.MOUSE_DOWN,this.buttonDown);
         lb0.removeEventListener(MouseEvent.MOUSE_UP,this.buttonUp);
         lb0.removeEventListener(MouseEvent.MOUSE_OVER,this.buttonOver);
         lb0.removeEventListener(MouseEvent.MOUSE_OUT,this.buttonOut);
      }
      
      protected function setGoul(clickEvent:ClickEvent, event:MouseEvent) : *
      {
         clickEvent.goal = event.target;
         clickEvent.index = event.target.index;
      }
      
      public function clear() : *
      {
         var n:* = undefined;
         var lb0:* = undefined;
         for(n in this.arr)
         {
            lb0 = this.arr[n];
            this.removeChild(lb0);
            this.removeEL(lb0);
            lb0.clear();
         }
         this.arr.length = 0;
      }
      
      public function doFun(funName:String, funValue:*) : *
      {
         var n:* = undefined;
         var lb0:* = undefined;
         for(n in this.arr)
         {
            lb0 = this.arr[n];
            lb0[funName](funValue);
         }
      }
      
      public function getBarBy2(pro0:String, pro1:String, value0:*) : *
      {
         var n:* = undefined;
         var lb0:* = undefined;
         for(n in this.arr)
         {
            lb0 = this.arr[n];
            if(lb0[pro0][pro1] == value0)
            {
               return lb0;
            }
         }
         return null;
      }
      
      protected function buttonClick(event:MouseEvent) : *
      {
         var clickEvent:ClickEvent = new ClickEvent();
         this.setGoul(clickEvent,event);
         this.dispatchEvent(clickEvent);
      }
      
      protected function buttonDown(event:MouseEvent) : *
      {
         var downEvent:ClickEvent = new ClickEvent(ClickEvent.ON_DOWN);
         this.setGoul(downEvent,event);
         this.dispatchEvent(downEvent);
      }
      
      protected function buttonUp(event:MouseEvent) : *
      {
         var upEvent:ClickEvent = new ClickEvent(ClickEvent.ON_UP);
         this.setGoul(upEvent,event);
         this.dispatchEvent(upEvent);
      }
      
      protected function buttonOver(event:MouseEvent) : *
      {
         var downEvent:ClickEvent = new ClickEvent(ClickEvent.ON_OVER);
         this.setGoul(downEvent,event);
         this.dispatchEvent(downEvent);
      }
      
      protected function buttonOut(event:MouseEvent) : *
      {
         var upEvent:ClickEvent = new ClickEvent(ClickEvent.ON_OUT);
         this.setGoul(upEvent,event);
         this.dispatchEvent(upEvent);
      }
   }
}

