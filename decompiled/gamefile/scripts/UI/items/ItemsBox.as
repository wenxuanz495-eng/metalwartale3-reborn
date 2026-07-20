package UI.items
{
   import UI.ClickEvent;
   import UI.page.PageBox;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import gameAll.data.ArmsItemsData;
   import gameAll.data.GoodsItemsData;
   import goods.GoodsDefine;
   import gs.TweenLite;
   import items.ItemsDefine;
   
   public class ItemsBox extends Sprite
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
      
      public var type:String = "bag";
      
      private var siteRankB:Boolean = false;
      
      public function ItemsBox(_type:String = "bag", _siteRankB:Boolean = false)
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
         var lb0:* = undefined;
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
         if(this.siteRankB)
         {
            this.setTotalNum(maxSite,this.nowPage,true,false);
            for(n in arr0)
            {
               site0 = int(arr0[n].site);
               this.arr[site0].inData_byItems(arr0[n]);
            }
         }
         else
         {
            this.setTotalNum(arr0.length,this.nowPage,true,false);
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
      
      public function inData_byHole(items0:ArmsItemsData) : *
      {
         var n:* = undefined;
         var n2:* = undefined;
         var icon0:ItemsIcon = null;
         var gid0:* = undefined;
         var site0:int = 0;
         this.clear();
         var maxSite:int = items0.maxHoleNum;
         var arr0:Array = items0.holeArr;
         this.setTotalNum(maxSite,this.nowPage,true,false);
         for(n in this.arr)
         {
            icon0 = this.arr[n];
            if(n >= items0.nowHoleNum)
            {
               icon0.setState("lock");
            }
            else
            {
               icon0.setState("blank");
            }
         }
         for(n2 in arr0)
         {
            gid0 = arr0[n2];
            if(Boolean(gid0.hasOwnProperty("affixLevel")))
            {
               site0 = int(arr0[n2].site);
               this.arr[n2].inData_byItems(arr0[n2]);
               this.arr[n2].setState("fill");
            }
            else
            {
               this.arr[n2].clearData();
               this.arr[n2].setState("blank");
            }
         }
      }
      
      public function inData_byArr(arr0:Array) : *
      {
         var n:* = undefined;
         var d0:ItemsDefine = null;
         this.clear();
         this.setTotalNum(arr0.length);
         for(n in arr0)
         {
            d0 = arr0[n];
            this.arr[n].inData_byDefine(d0);
            this.arr[n].site = n;
         }
      }
      
      public function inData_byGoodsDefineArr(arr0:Array, firstB:Boolean = false) : *
      {
         var n:* = undefined;
         var d0:GoodsDefine = null;
         this.clear();
         this.setTotalNum(arr0.length);
         for(n in arr0)
         {
            d0 = arr0[n];
            this.arr[n].inData_byGoodsDefine(d0,firstB);
            this.arr[n].site = n;
         }
      }
      
      public function inData_byMustStr(mustArr:Array) : Boolean
      {
         var n:* = undefined;
         var icon1:ItemsIcon = null;
         var d1:ItemsDefine = null;
         var aid1:GoodsItemsData = null;
         var enoughB:Boolean = true;
         var arr1:Array = Game.itemsDefineGroup.getArr_byStrArr(mustArr);
         this.inData_byArr(arr1);
         for(n in this.arr)
         {
            icon1 = this.arr[n];
            d1 = icon1.itemsData;
            if(d1.getPropB())
            {
               aid1 = Game.gameData.propsItems.getItemsByBase(d1.name);
            }
            else
            {
               aid1 = Game.gameData.materialsItems.getItemsByBase(d1.name);
            }
            icon1.setNum(100);
            if(aid1 != null)
            {
               if(d1.nowNum <= aid1.nowNum)
               {
                  icon1.setCondition(1);
                  icon1.setMustNum(aid1.nowNum,d1.nowNum);
               }
               else
               {
                  icon1.setCondition(2);
                  icon1.setMustNum(aid1.nowNum,d1.nowNum);
                  enoughB = false;
               }
            }
            else
            {
               icon1.setCondition(2);
               icon1.setMustNum(0,d1.nowNum);
               enoughB = false;
            }
         }
         return enoughB;
      }
      
      public function findItemsData(id0:GoodsItemsData) : ItemsIcon
      {
         var n:* = undefined;
         var icon0:ItemsIcon = null;
         for(n in this.arr)
         {
            icon0 = this.arr[n];
            if(icon0.itemsData == id0)
            {
               return icon0;
            }
         }
         return null;
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
         var lb0:* = undefined;
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
         var lb0:* = undefined;
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
      
      public function clearData() : *
      {
         var n:* = undefined;
         var lb0:* = undefined;
         for(n in this.arr)
         {
            lb0 = this.arr[n];
            lb0.clearData();
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

