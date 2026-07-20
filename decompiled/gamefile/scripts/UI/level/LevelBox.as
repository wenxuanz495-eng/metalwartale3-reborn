package UI.level
{
   import UI.ClickEvent;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import gs.TweenLite;
   
   public class LevelBox extends Sprite
   {
      
      public var CLASS:*;
      
      public var totalPage:int = 0;
      
      public var nowPage:int = 0;
      
      public var totalNum:int = 0;
      
      public var nowNum:int = 0;
      
      public var xNum:int = 10;
      
      public var yNum:int = 10;
      
      protected var xGap:int = 0;
      
      protected var yGap:int = 0;
      
      public var baseWidth:int = 100;
      
      public var baseHeight:int = 100;
      
      public var arr:Array = [];
      
      public function LevelBox()
      {
         super();
      }
      
      public function setLabelClass(class0:*) : *
      {
         this.CLASS = class0;
      }
      
      public function setNum(_x:int, _y:int, _width:int, _height:int) : *
      {
         this.xNum = _x;
         this.yNum = _y;
         this.baseWidth = _width;
         this.baseHeight = _height;
      }
      
      public function clear() : *
      {
         var n:* = undefined;
         var lb0:* = undefined;
         for(n in this.arr)
         {
            lb0 = this.arr[n];
            lb0.removeEventListener(MouseEvent.CLICK,this.buttonClick);
            lb0.removeEventListener(MouseEvent.MOUSE_OVER,this.buttonOver);
            lb0.removeEventListener(MouseEvent.MOUSE_OUT,this.buttonOut);
            lb0.removeEventListener(MouseEvent.MOUSE_MOVE,this.buttonMove);
            this.removeChild(lb0);
         }
         this.arr.length = 0;
         this.nowPage = 0;
         this.totalPage = 1;
         this.totalNum = 0;
      }
      
      public function setTotalNum(_totaNum:int) : *
      {
         var lb0:* = undefined;
         this.totalNum = _totaNum;
         this.totalPage = int((this.totalNum - 1) / (this.xNum * this.yNum)) + 1;
         for(var n:int = 0; n < this.totalNum; n++)
         {
            lb0 = new this.CLASS();
            this.addChild(lb0);
            lb0.setText(n);
            lb0.addEventListener(MouseEvent.CLICK,this.buttonClick);
            lb0.addEventListener(MouseEvent.MOUSE_OVER,this.buttonOver);
            lb0.addEventListener(MouseEvent.MOUSE_OUT,this.buttonOut);
            lb0.addEventListener(MouseEvent.MOUSE_MOVE,this.buttonMove);
            this.arr[n] = lb0;
         }
         if(this.xNum > 1)
         {
            this.xGap = (this.baseWidth - this.xNum * lb0.width) / (this.xNum - 1);
         }
         if(this.yNum > 1)
         {
            this.yGap = (this.baseHeight - this.yNum * lb0.height) / (this.yNum - 1);
         }
         this.nowPage = -1;
         this.showPage(0);
      }
      
      public function setLock(num:int, lockFirstB:Boolean = true) : *
      {
         var lb0:* = undefined;
         for(var n:int = 0; n < this.totalNum; n++)
         {
            lb0 = this.arr[n];
            if(num - 1 >= n)
            {
               lb0.actived = true;
            }
            else
            {
               lb0.actived = false;
            }
         }
         if(Boolean(this.arr[0]))
         {
            if(lockFirstB)
            {
               this.arr[0].actived = false;
            }
            else
            {
               this.arr[0].actived = true;
            }
         }
      }
      
      public function setKnowingLock(num:int) : *
      {
         var lb0:* = undefined;
         for(var n:int = 0; n < this.totalNum; n++)
         {
            lb0 = this.arr[n];
            if(num - 1 >= n)
            {
               lb0.actived = true;
            }
            else
            {
               lb0.actived = false;
            }
         }
      }
      
      public function getLevelPage(num:int) : int
      {
         return int(num / (this.xNum * this.yNum));
      }
      
      public function setName(arr0:Array) : *
      {
         var n:* = undefined;
         var lb0:* = undefined;
         for(n in arr0)
         {
            if(n < this.arr.length)
            {
               lb0 = this.arr[n];
               lb0.setText2(arr0[n]);
            }
         }
      }
      
      public function setPicFirst(firstLabel0:String) : *
      {
         var lb0:* = undefined;
         var i:* = undefined;
         var n:* = undefined;
         var l0:FrameLabel = null;
         var picFirst0:int = 0;
         lb0 = this.arr[0];
         var mc0:MovieClip = lb0.picMc;
         var l_arr0:Array = mc0.currentLabels;
         for(i in l_arr0)
         {
            l0 = l_arr0[i];
            if(l0.name == firstLabel0)
            {
               picFirst0 = l0.frame - 1;
               break;
            }
         }
         for(n in this.arr)
         {
            if(n < this.arr.length)
            {
               lb0 = this.arr[n];
               lb0.picFirst = picFirst0;
               lb0.fleshPic();
            }
         }
      }
      
      public function setStar(arr0:Array, isfrist:Boolean = false) : *
      {
         var n:* = undefined;
         var lb0:* = undefined;
         for(n in this.arr)
         {
            lb0 = this.arr[n];
            if(n > arr0.length - 1)
            {
               lb0.setStar(0);
            }
            else if(isfrist && n == 0)
            {
               lb0.setStar(arr0[n],true);
            }
            else
            {
               lb0.setStar(arr0[n]);
            }
         }
      }
      
      public function showPage(_num:int, _breakB:Boolean = false) : *
      {
         var first:int = 0;
         var last:int = 0;
         var n:* = undefined;
         var lb0:* = undefined;
         var n0:int = 0;
         if(_num >= 0 && _num < this.totalPage && (_num != this.nowPage || _breakB))
         {
            this.nowPage = _num;
            first = this.nowPage * this.xNum * this.yNum;
            last = (this.nowPage + 1) * this.xNum * this.yNum - 1;
            if(last > this.totalNum - 1)
            {
               last = this.totalNum - 1;
            }
            for(n in this.arr)
            {
               lb0 = this.arr[n];
               if(n >= first && n <= last)
               {
                  lb0.visible = lb0.visible2;
                  n0 = n - first;
                  lb0.x = (this.xGap + lb0.width) * (n0 % this.xNum);
                  lb0.y = (this.yGap + lb0.height) * int(n0 / this.xNum);
               }
               else
               {
                  lb0.visible = false;
               }
            }
            this.playTween();
         }
      }
      
      private function fleshAll() : *
      {
      }
      
      public function playTween() : *
      {
         this.alpha = 0;
         TweenLite.to(this,0.5,{"alpha":1});
      }
      
      private function buttonClick(event:MouseEvent) : *
      {
         var clickEvent:ClickEvent = null;
         if(Boolean(event.target.actived))
         {
            clickEvent = new ClickEvent();
            clickEvent.goal = event.target;
            clickEvent.index = event.target.index;
            this.dispatchEvent(clickEvent);
         }
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
      
      private function buttonMove(event:MouseEvent) : *
      {
         var upEvent:ClickEvent = new ClickEvent(ClickEvent.ON_MOVE);
         upEvent.goal = event.target;
         upEvent.index = event.target.index;
         this.dispatchEvent(upEvent);
      }
   }
}

