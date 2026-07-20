package UI.change
{
   import UI.ClickEvent;
   import UI.icon.ItemsCarIcon;
   import UI.page.PageBox;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import gameAll.data.CarItemsDataGroup;
   import gs.TweenLite;
   
   public class CarIconBox extends Sprite
   {
      
      public var totalPage:int = 0;
      
      public var nowPage:int = 0;
      
      public var totalNum:int = 0;
      
      public var xNum:int = 10;
      
      public var yNum:int = 10;
      
      protected var xGap:int = 0;
      
      protected var yGap:int = 0;
      
      public var baseWidth:int = 100;
      
      public var baseHeight:int = 100;
      
      public var arr:Array = [];
      
      public var pageBox:PageBox;
      
      public var type:String = "bag";
      
      private var siteRankB:Boolean = false;
      
      public function CarIconBox(_type:String = "bag", _siteRankB:Boolean = false)
      {
         super();
         this.type = _type;
         this.siteRankB = _siteRankB;
      }
      
      public function setNum(_x:int, _y:int, _width:int, _height:int) : *
      {
         this.xNum = _x;
         this.yNum = _y;
         this.baseWidth = _width;
         this.baseHeight = _height;
      }
      
      public function setTotalNum(_totaNum:int, _nowPage:int = 0, _breakB:Boolean = false, _tweenB:Boolean = true) : *
      {
         var lb0:ItemsCarIcon = null;
         this.totalNum = _totaNum;
         this.totalPage = int((this.totalNum - 1) / (this.xNum * this.yNum)) + 1;
         for(var n:int = 0; n < this.totalNum; n++)
         {
            lb0 = new ItemsCarIcon();
            this.addChild(lb0);
            lb0.setNum(String(n + 1));
            lb0.site = n;
            lb0.addEventListener(MouseEvent.CLICK,this.buttonClick);
            lb0.addEventListener(MouseEvent.MOUSE_DOWN,this.buttonDown);
            lb0.addEventListener(MouseEvent.MOUSE_UP,this.buttonUp);
            lb0.addEventListener(MouseEvent.MOUSE_OVER,this.buttonOver);
            lb0.addEventListener(MouseEvent.MOUSE_OUT,this.buttonOut);
            this.arr[n] = lb0;
         }
         if(this.arr.length > 0)
         {
            this.countGap();
            this.nowPage = -1;
            this.showPage(_nowPage,_breakB,_tweenB);
         }
      }
      
      private function countGap() : *
      {
         var lb0:ItemsCarIcon = null;
         if(this.arr.length > 0)
         {
            lb0 = this.arr[0];
            if(this.xNum > 1)
            {
               this.xGap = (this.baseWidth - this.xNum * lb0.width) / (this.xNum - 1);
            }
            if(this.yNum > 1)
            {
               this.yGap = (this.baseHeight - this.yNum * lb0.height) / (this.yNum - 1);
            }
         }
      }
      
      public function inData_byItems(arr0:Array, maxSite:int = -1) : *
      {
         var n:* = undefined;
         var site0:int = 0;
         var m:* = undefined;
         var page0:int = 0;
         this.clear();
         if(maxSite == -1)
         {
            maxSite = int(arr0.length);
         }
         this.setTotalNum(maxSite,this.nowPage,true,false);
         if(this.siteRankB)
         {
            for(n in arr0)
            {
               site0 = int(arr0[n].site);
               this.arr[site0].inData_byItems(arr0[n]);
            }
         }
         else
         {
            for(m in arr0)
            {
               this.arr[m].inData_byItems(arr0[m]);
            }
            if(m < this.arr.length)
            {
               page0 = this.getLevelPage(m);
               if(page0 < this.nowPage)
               {
                  this.showPage(page0);
               }
            }
         }
      }
      
      public function inData(armsItems:CarItemsDataGroup) : *
      {
         if(this.type == "equip")
         {
            this.inData_byItems(armsItems.equArr,armsItems.equMaxNum);
         }
         else if(this.type == "bag")
         {
            this.inData_byItems(armsItems.arr,armsItems.bagMaxNum);
         }
      }
      
      public function inData_byDefine(arr0:Array) : *
      {
         var n:* = undefined;
         this.setTotalNum(arr0.length,0,true,false);
         for(n in arr0)
         {
            this.arr[n].inData_byDefine(arr0[n]);
         }
      }
      
      public function setTypeByArr(arr0:Array) : *
      {
         var n:* = undefined;
         for(n in this.arr)
         {
            this.arr[n].setType(arr0[n]);
            this.arr[n].setNum(String(n + 1));
         }
      }
      
      public function setStateByArr(arr0:Array) : *
      {
         var n:* = undefined;
         for(n in this.arr)
         {
            if(arr0[n] == "lock")
            {
               this.arr[n].setState(arr0[n]);
            }
         }
      }
      
      public function setTypeAll(type0:int) : *
      {
         var n:* = undefined;
         for(n in this.arr)
         {
            this.arr[n].setType(type0);
         }
      }
      
      public function addArmsIcon(lb00:ItemsCarIcon, first:int = 0) : *
      {
         var lb0:ItemsCarIcon = null;
         if(this.siteRankB)
         {
            this.arr[first].inData_byMe(lb00);
            return this.arr[first];
         }
         lb0 = new ItemsCarIcon();
         this.addChild(lb0);
         lb0.inData_byMe(lb00);
         this.arr.splice(first,0,lb0);
         lb0.site = first;
         this.countGap();
         lb0.addEventListener(MouseEvent.CLICK,this.buttonClick);
         lb0.addEventListener(MouseEvent.MOUSE_DOWN,this.buttonDown);
         lb0.addEventListener(MouseEvent.MOUSE_UP,this.buttonUp);
         lb0.addEventListener(MouseEvent.MOUSE_OVER,this.buttonOver);
         lb0.addEventListener(MouseEvent.MOUSE_OUT,this.buttonOut);
         this.fleshData();
         this.showPage(this.nowPage,true,false);
         return lb0;
      }
      
      public function removeIcon(first:int = 0) : *
      {
         var lb0:ItemsCarIcon = null;
         if(this.siteRankB)
         {
            this.arr[first].clearData();
            return;
         }
         lb0 = this.arr[first];
         this.removeChild(lb0);
         this.arr.splice(first,1);
         lb0.removeEventListener(MouseEvent.CLICK,this.buttonClick);
         lb0.removeEventListener(MouseEvent.MOUSE_DOWN,this.buttonDown);
         lb0.removeEventListener(MouseEvent.MOUSE_UP,this.buttonUp);
         lb0.removeEventListener(MouseEvent.MOUSE_OVER,this.buttonOver);
         lb0.removeEventListener(MouseEvent.MOUSE_OUT,this.buttonOut);
         lb0.clear();
         this.fleshData();
         this.showPage(this.nowPage,true,false);
         return lb0;
      }
      
      public function removeArmsIcon(lb0:*) : *
      {
         var f0:int = this.arr.indexOf(lb0);
         if(f0 >= 0)
         {
            this.removeIcon(f0);
         }
      }
      
      public function clear() : *
      {
         var n:* = undefined;
         var lb0:ItemsCarIcon = null;
         for(n in this.arr)
         {
            lb0 = this.arr[n];
            this.removeChild(lb0);
            lb0.removeEventListener(MouseEvent.CLICK,this.buttonClick);
            lb0.removeEventListener(MouseEvent.MOUSE_DOWN,this.buttonDown);
            lb0.removeEventListener(MouseEvent.MOUSE_UP,this.buttonUp);
            lb0.removeEventListener(MouseEvent.MOUSE_OVER,this.buttonOver);
            lb0.removeEventListener(MouseEvent.MOUSE_OUT,this.buttonOut);
            lb0.clear();
         }
         this.arr.length = 0;
         this.fleshData();
      }
      
      public function getLevelPage(num:int) : int
      {
         return int(num / (this.xNum * this.yNum));
      }
      
      public function showPage(_num:int, _breakB:Boolean = false, _tweenB:Boolean = true) : *
      {
         var first:int = 0;
         var last:int = 0;
         var n:* = undefined;
         var lb0:ItemsCarIcon = null;
         var n0:int = 0;
         if(_num <= 0)
         {
            _num = 0;
         }
         else if(_num >= this.totalPage - 1)
         {
            _num = this.totalPage - 1;
         }
         if(_num != this.nowPage || _breakB)
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
                  lb0.visible = true;
                  n0 = n - first;
                  lb0.x = (this.xGap + lb0.width) * (n0 % this.xNum);
                  lb0.y = (this.yGap + lb0.height) * int(n0 / this.xNum);
               }
               else
               {
                  lb0.visible = false;
               }
            }
            if(_tweenB)
            {
               this.alpha = 0;
               TweenLite.to(this,0.5,{"alpha":1});
            }
         }
      }
      
      private function fleshData() : *
      {
         this.totalNum = this.arr.length;
         this.totalPage = int((this.totalNum - 1) / (this.xNum * this.yNum)) + 1;
      }
      
      private function fleshPageBox() : *
      {
         if(this.pageBox is PageBox)
         {
         }
      }
      
      private function buttonClick(event:MouseEvent) : *
      {
         var clickEvent:ClickEvent = new ClickEvent();
         clickEvent.goal = event.target;
         clickEvent.index = this.arr.indexOf(event.target);
         this.dispatchEvent(clickEvent);
      }
      
      private function buttonDown(event:MouseEvent) : *
      {
         var downEvent:ClickEvent = new ClickEvent(ClickEvent.ON_DOWN);
         downEvent.goal = event.target;
         this.dispatchEvent(downEvent);
      }
      
      private function buttonUp(event:MouseEvent) : *
      {
         var upEvent:ClickEvent = new ClickEvent(ClickEvent.ON_UP);
         upEvent.goal = event.target;
         this.dispatchEvent(upEvent);
      }
      
      private function buttonOver(event:MouseEvent) : *
      {
         var downEvent:ClickEvent = new ClickEvent(ClickEvent.ON_OVER);
         downEvent.goal = event.target;
         this.dispatchEvent(downEvent);
      }
      
      private function buttonOut(event:MouseEvent) : *
      {
         var upEvent:ClickEvent = new ClickEvent(ClickEvent.ON_OUT);
         upEvent.goal = event.target;
         this.dispatchEvent(upEvent);
      }
   }
}

