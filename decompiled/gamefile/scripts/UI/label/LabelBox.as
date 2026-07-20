package UI.label
{
   import UI.ClickEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class LabelBox extends Sprite
   {
      
      public var CLASS:Class;
      
      public var rankB:Boolean = true;
      
      public var arr:Array = [];
      
      public var grapArr:Array = [];
      
      public var nowIndex:int = 0;
      
      public var nowLabel:String = "";
      
      public var auto:Boolean = true;
      
      public function LabelBox()
      {
         super();
      }
      
      public function setLabelClass(class0:Class, _auto:Boolean = true) : *
      {
         this.CLASS = class0;
         this.auto = _auto;
      }
      
      public function addLabel(arr0:Array, _long:int, _rankB:Boolean = true, _back:String = "") : *
      {
         var n:* = undefined;
         var str0:String = null;
         var label0:* = undefined;
         for(n in arr0)
         {
            str0 = arr0[n];
            label0 = new this.CLASS();
            this.arr.push(label0);
            label0.setText(str0);
            if(_back != "")
            {
               label0.changeBack(_back);
            }
            this.addChild(label0);
            label0.index = n;
            label0.addEventListener(MouseEvent.CLICK,this.click);
         }
         _rankB = _rankB;
         this.setPosition(_rankB,_long);
         this.showState(0);
      }
      
      public function getGrap(index0:int) : int
      {
         var n:* = undefined;
         var allGrap0:int = 0;
         for(n in this.grapArr)
         {
            if(index0 > n)
            {
               allGrap0 += this.grapArr[n];
            }
         }
         return allGrap0;
      }
      
      public function getIndex(str:String) : int
      {
         var n:* = undefined;
         var label0:* = undefined;
         for(n in this.arr)
         {
            label0 = this.arr[n];
            if(label0.text == str)
            {
               return n;
            }
         }
         return -1;
      }
      
      protected function setPosition(_rankB:Boolean, _long:int) : *
      {
         if(_rankB)
         {
            this.rankArrange(_long);
         }
         else
         {
            this.shuArrange(_long);
         }
      }
      
      protected function rankArrange(_long:int) : *
      {
         var n:* = undefined;
         var label0:* = undefined;
         var len:Number = NaN;
         var w0:Number = NaN;
         var cx:Number = NaN;
         for(n in this.arr)
         {
            label0 = this.arr[n];
            len = this.arr.length;
            if(len == 1)
            {
               return;
            }
            w0 = Number(label0.width);
            cx = (_long - len * w0) / (len - 1);
            label0.x = n * (cx + w0) + this.getGrap(n);
         }
      }
      
      protected function shuArrange(_long:int) : *
      {
         var n:* = undefined;
         var label0:* = undefined;
         var len:Number = NaN;
         var h0:Number = NaN;
         var cy:Number = NaN;
         for(n in this.arr)
         {
            label0 = this.arr[n];
            len = this.arr.length;
            if(len == 1)
            {
               return;
            }
            h0 = Number(label0.height);
            cy = (_long - len * h0) / (len - 1);
            label0.y = n * (cy + h0) + this.getGrap(n);
            label0.x = 0;
         }
      }
      
      public function showState(index0:int) : *
      {
         var n:* = undefined;
         var label0:* = undefined;
         this.nowIndex = index0;
         for(n in this.arr)
         {
            label0 = this.arr[n];
            if(label0.state == 1)
            {
               label0.setState(0);
            }
            if(n == index0 && label0.state != 2)
            {
               label0.setState(1);
               this.nowLabel = label0.text;
            }
         }
      }
      
      public function showLabel_byLabel(str0:String) : *
      {
         var btn0:* = this.getByLabel(str0);
         if(Boolean(btn0))
         {
            this.showState(this.arr.indexOf(btn0));
         }
      }
      
      public function getByLabel(str0:String) : *
      {
         var n:* = undefined;
         var label0:* = undefined;
         for(n in this.arr)
         {
            label0 = this.arr[n];
            if(label0.text == str0)
            {
               return label0;
            }
         }
         return null;
      }
      
      public function getNow() : *
      {
         if(this.nowIndex >= 0 && this.nowIndex < this.arr.length)
         {
            return this.arr[this.nowIndex];
         }
         return this.arr[0];
      }
      
      public function clearState() : *
      {
         var n:* = undefined;
         var label0:* = undefined;
         this.nowIndex = -1;
         for(n in this.arr)
         {
            label0 = this.arr[n];
            if(label0.state != 3)
            {
               label0.setState(0);
            }
         }
      }
      
      public function setLock(arr0:Array) : *
      {
         var n:* = undefined;
         var label0:* = undefined;
         for(n in this.arr)
         {
            label0 = this.arr[n];
            label0.setState(arr0[n]);
         }
      }
      
      public function unlockAll() : *
      {
         var n:* = undefined;
         var label0:* = undefined;
         for(n in this.arr)
         {
            label0 = this.arr[n];
            label0.setState(0);
         }
      }
      
      public function clear() : *
      {
         var n:* = undefined;
         var label0:* = undefined;
         for(n in this.arr)
         {
            label0 = this.arr[n];
            if(Boolean(label0.hasOwnProperty("clear")))
            {
               label0.clear();
               label0.removeEventListener(MouseEvent.CLICK,this.click);
               removeChild(label0);
            }
         }
         this.arr.length = 0;
         this.nowIndex = 0;
         this.nowLabel = "";
      }
      
      protected function click(event:MouseEvent) : *
      {
         var index0:int = int(event.target.index);
         if(this.auto)
         {
            this.showState(index0);
         }
         var newevent:ClickEvent = new ClickEvent();
         newevent.goal = event.target;
         newevent.index = index0;
         dispatchEvent(newevent);
      }
   }
}

