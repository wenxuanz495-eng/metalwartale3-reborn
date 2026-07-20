package UI.shop
{
   import UI.ClickEvent;
   import UI.page.PageBox;
   import flash.display.Sprite;
   import goods.GoodsDefine;
   import gs.TweenLite;
   
   public class ShopIconBox extends Sprite
   {
      
      public var CLASS:Class;
      
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
      
      public var type:String = "arms";
      
      private var siteRankB:Boolean = false;
      
      public function ShopIconBox(_type:String = "arms", _siteRankB:Boolean = false)
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
      
      public function setLabelClass(class0:Class) : *
      {
         this.CLASS = class0;
      }
      
      public function setTotalNum(_totaNum:int, _nowPage:int = 0, _breakB:Boolean = false, _tweenB:Boolean = true) : *
      {
         var lb0:* = undefined;
         this.totalNum = _totaNum;
         this.totalPage = int((this.totalNum - 1) / (this.xNum * this.yNum)) + 1;
         for(var n:int = 0; n < this.totalNum; n++)
         {
            lb0 = new this.CLASS();
            this.addChild(lb0);
            lb0.index = n;
            lb0.addEventListener(ClickEvent.ON_CLICK,this.buttonClick);
            lb0.addEventListener(ClickEvent.ON_OVER,this.buttonOver);
            lb0.addEventListener(ClickEvent.ON_OUT,this.buttonOut);
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
         var lb0:* = undefined;
         if(this.arr.length > 0)
         {
            lb0 = this.arr[0];
            if(this.xNum > 1)
            {
               this.xGap = (this.baseWidth - this.xNum * lb0.back.width) / (this.xNum - 1);
            }
            if(this.yNum > 1)
            {
               this.yGap = (this.baseHeight - this.yNum * lb0.back.height) / (this.yNum - 1);
            }
         }
      }
      
      public function inData_byArr(arr0:Array) : *
      {
         var n:* = undefined;
         var d0:GoodsDefine = null;
         this.clear();
         this.setTotalNum(arr0.length);
         for(n in arr0)
         {
            d0 = arr0[n];
            this.arr[n].inData_byDefine(d0);
            this.arr[n].index = n;
         }
      }
      
      public function fleshPrice_byNow(gd0:GoodsDefine) : *
      {
         var n:* = undefined;
         var icon0:ShopIcon = null;
         for(n in this.arr)
         {
            icon0 = this.arr[n];
            icon0.fleshPrice_byNow(gd0);
         }
      }
      
      public function fleshPrice_byX(Xnum:int) : *
      {
         var n:* = undefined;
         var icon0:ShopIcon = null;
         for(n in this.arr)
         {
            icon0 = this.arr[n];
            icon0.fleshPrice_byX(Xnum);
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
      
      public function addArmsIcon(lb00:*, first:int = 0) : *
      {
         var lb0:* = undefined;
         if(this.siteRankB)
         {
            this.arr[first].inData_byMe(lb00);
            return this.arr[first];
         }
         lb0 = new this.CLASS();
         this.addChild(lb0);
         lb0.inData_byMe(lb00);
         this.arr.splice(first,0,lb0);
         lb0.site = first;
         this.countGap();
         lb0.addEventListener(ClickEvent.ON_CLICK,this.buttonClick);
         lb0.addEventListener(ClickEvent.ON_OVER,this.buttonOver);
         lb0.addEventListener(ClickEvent.ON_OUT,this.buttonOut);
         this.fleshData();
         this.showPage(this.nowPage,true,false);
         return lb0;
      }
      
      public function removeIcon(first:int = 0) : *
      {
         var lb0:* = undefined;
         if(this.siteRankB)
         {
            this.arr[first].clearData();
            return;
         }
         lb0 = this.arr[first];
         this.removeChild(lb0);
         this.arr.splice(first,1);
         lb0.removeEventListener(ClickEvent.ON_CLICK,this.buttonClick);
         lb0.removeEventListener(ClickEvent.ON_OVER,this.buttonOver);
         lb0.removeEventListener(ClickEvent.ON_OUT,this.buttonOut);
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
         var lb0:* = undefined;
         for(n in this.arr)
         {
            lb0 = this.arr[n];
            this.removeChild(lb0);
            lb0.removeEventListener(ClickEvent.ON_CLICK,this.buttonClick);
            lb0.removeEventListener(ClickEvent.ON_OVER,this.buttonOver);
            lb0.removeEventListener(ClickEvent.ON_OUT,this.buttonOut);
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
         var lb0:* = undefined;
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
                  lb0.x = (this.xGap + lb0.back.width) * (n0 % this.xNum);
                  lb0.y = (this.yGap + lb0.back.height) * int(n0 / this.xNum);
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
      
      private function buttonClick(event:ClickEvent) : *
      {
         var clickEvent:ClickEvent = new ClickEvent();
         clickEvent.goal = event.target;
         clickEvent.index = event.target.index;
         this.dispatchEvent(clickEvent);
      }
      
      private function buttonOver(event:ClickEvent) : *
      {
         var downEvent:ClickEvent = new ClickEvent(ClickEvent.ON_OVER);
         downEvent.goal = event.target;
         downEvent.index = event.target.index;
         this.dispatchEvent(downEvent);
      }
      
      private function buttonOut(event:ClickEvent) : *
      {
         var upEvent:ClickEvent = new ClickEvent(ClickEvent.ON_OUT);
         upEvent.goal = event.target;
         upEvent.index = event.target.index;
         this.dispatchEvent(upEvent);
      }
   }
}

