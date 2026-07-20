package UI.change
{
   import UI.ClickEvent;
   import UI.icon.ItemsArmsIcon;
   import UI.icon.newIconData;
   import UI.page.PageBox;
   import body.define.OneArmsDefine;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import gameAll.data.ArmsItemsData;
   import gs.TweenLite;
   
   public class ArmsIconBox extends Sprite
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
      
      public var first_index:int = 0;
      
      public function ArmsIconBox(_type:String = "bag", _siteRankB:Boolean = false)
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
         var lb0:ItemsArmsIcon = null;
         this.totalNum = _totaNum;
         this.totalPage = int((this.totalNum - 1) / (this.xNum * this.yNum)) + 1;
         for(var n:int = 0; n < this.totalNum; n++)
         {
            lb0 = new ItemsArmsIcon();
            this.addChild(lb0);
            lb0.setNum(String(n + 1));
            lb0.site = n;
            lb0.index = n;
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
         var lb0:ItemsArmsIcon = null;
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
      
      public function inData_byItems(arr0:Array, maxSite:int = -1, tweenB:Boolean = false) : *
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
            this.setTotalNum(maxSite,this.nowPage,true,tweenB);
            for(n in arr0)
            {
               site0 = int(arr0[n].site);
               this.arr[site0].inData_byItems(arr0[n]);
            }
         }
         else
         {
            this.setTotalNum(arr0.length,this.nowPage,true,tweenB);
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
      
      public function inData_byArr(arr0:Array, checkUpgradeB:Boolean = false) : *
      {
         var n:* = undefined;
         var d0:OneArmsDefine = null;
         var da0:ArmsItemsData = null;
         var icon0:ItemsArmsIcon = null;
         this.clear();
         this.setTotalNum(arr0.length);
         for(n in arr0)
         {
            icon0 = this.arr[n];
            icon0.checkUpgradeB = checkUpgradeB;
            if(arr0[n] is OneArmsDefine)
            {
               d0 = arr0[n];
               icon0.inData_byDefine(d0);
               icon0.setNoHave(true);
            }
            else
            {
               da0 = arr0[n];
               icon0.inData_byItems(da0);
            }
            this.arr[n].site = n;
         }
      }
      
      public function inData_byArr2(arr0:Array, nowHaveB:Boolean = false, itemsData0:* = null) : *
      {
         var n:* = undefined;
         var d0:OneArmsDefine = null;
         var haveB:Boolean = false;
         var id0:ArmsItemsData = null;
         this.clear();
         this.setTotalNum(arr0.length);
         for(n in arr0)
         {
            haveB = true;
            if(arr0[n] is Array)
            {
               d0 = arr0[n][0];
               if(nowHaveB)
               {
                  id0 = itemsData0.getItemsByBase(d0.id,false);
                  if(id0 != null)
                  {
                     d0 = arr0[n][id0.getLevel()];
                  }
                  else
                  {
                     haveB = false;
                     this.arr[n].noHave_mc.visible = true;
                  }
               }
            }
            else
            {
               d0 = arr0[n];
            }
            this.arr[n].inData_byDefine(d0);
            if(!haveB)
            {
               this.arr[n].nameTxt.visible = false;
            }
            this.arr[n].site = n;
         }
      }
      
      public function inData(armsItems:*) : *
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
      
      public function removeIcon(first:int = 0) : *
      {
         var lb0:ItemsArmsIcon = null;
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
         var lb0:ItemsArmsIcon = null;
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
      
      public function getNewArr() : Array
      {
         var n:* = undefined;
         var lb0:ItemsArmsIcon = null;
         var new0:newIconData = null;
         var arr1:Array = [];
         for(n in this.arr)
         {
            lb0 = this.arr[n];
            new0 = new newIconData();
            new0.newB = lb0.newB;
            new0.newLevel = lb0.newLevel;
            new0.realLevel = lb0.realLevel;
            arr1.push(new0);
         }
         return arr1;
      }
      
      public function clearNew() : *
      {
         var n:* = undefined;
         var lb0:ItemsArmsIcon = null;
         var new0:newIconData = new newIconData();
         for(n in this.arr)
         {
            lb0 = this.arr[n];
            lb0.newB = new0.newB;
            lb0.newLevel = new0.newLevel;
            lb0.realLevel = new0.realLevel;
            lb0.hideNew();
         }
      }
      
      public function setNewArr(arr1:Array) : *
      {
         var n:* = undefined;
         var lb0:ItemsArmsIcon = null;
         var new0:newIconData = null;
         for(n in this.arr)
         {
            lb0 = this.arr[n];
            new0 = arr1[n];
            lb0.newB = new0.newB;
            lb0.new_tip.visible = new0.newB;
            lb0.newLevel = new0.newLevel;
            lb0.realLevel = new0.realLevel;
         }
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
         var lb0:ItemsArmsIcon = null;
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

