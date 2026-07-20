package UI.page
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class PageBox extends Sprite
   {
      
      public var prev_btn:PageTurnButton;
      
      public var next_btn:PageTurnButton;
      
      public var pageArr:Array = [];
      
      public var totalPage:int = 0;
      
      public var nowPage:int = 0;
      
      public var maxPage:int = 5;
      
      public var firstPage:int = 0;
      
      public var table:* = null;
      
      public var fleshFun:Function = null;
      
      public function PageBox()
      {
         super();
         this.prev_btn.addEventListener(MouseEvent.CLICK,this.prev);
         this.next_btn.addEventListener(MouseEvent.CLICK,this.next);
      }
      
      public function setTotalPage(_totalPage:int, _nowPage:int = -1, showPageB:Boolean = true) : *
      {
         var pb0:PageButton = null;
         var tlen:int = 0;
         this.totalPage = _totalPage;
         for(var n:int = 0; n < this.totalPage; n++)
         {
            pb0 = new PageButton();
            tlen = this.totalPage * (pb0.width + 2) - 2;
            pb0.setText(n + 1);
            addChild(pb0);
            pb0.addEventListener(MouseEvent.CLICK,this.pageClick);
            this.pageArr[n] = pb0;
         }
         this.prev_btn.y = pb0.y + pb0.height / 2;
         this.next_btn.y = pb0.y + pb0.height / 2;
         if(this.maxPage > this.totalPage)
         {
            this.setPagePosition(0,this.totalPage - 1,0);
         }
         else
         {
            this.setPagePosition(0,this.maxPage - 1,0);
         }
         this.fleshAll(_nowPage,showPageB);
      }
      
      public function clear() : *
      {
         var n:* = undefined;
         var pb0:PageButton = null;
         for(n in this.pageArr)
         {
            pb0 = this.pageArr[n];
            pb0.removeEventListener(MouseEvent.CLICK,this.pageClick);
            this.removeChild(pb0);
         }
         this.pageArr.length = 0;
         this.totalPage = 0;
         this.firstPage = 0;
         this.nowPage = 0;
      }
      
      public function fleshByTable(showPageB:Boolean = true) : *
      {
         this.clear();
         this.setTotalPage(this.table.totalPage,this.table.nowPage,showPageB);
      }
      
      private function setPagePosition(r0:int, r1:int, first:int) : *
      {
         var pb0:PageButton = null;
         var tlen:int = 0;
         for(var n:int = r0; n <= r1; n++)
         {
            pb0 = this.pageArr[n];
            tlen = 0;
            if(this.maxPage < this.totalPage)
            {
               tlen = this.maxPage * (pb0.width + 2) - 2;
            }
            else
            {
               tlen = this.totalPage * (pb0.width + 2) - 2;
            }
            pb0.x = -tlen / 2 + (pb0.width + 2) * (n - first);
            pb0.visible = true;
         }
         this.prev_btn.x = this.pageArr[r0].x - 20;
         this.next_btn.x = this.pageArr[r1].x + this.pageArr[r1].width + 20;
      }
      
      private function fleshAll(_nowPage:int = -1, showPageB:Boolean = true) : *
      {
         var n:* = undefined;
         var pb0:PageButton = null;
         var middle_p:int = 0;
         var m:* = undefined;
         var end_p:int = 0;
         var pb1:PageButton = null;
         if(_nowPage >= 0)
         {
            this.nowPage = _nowPage;
            if(_nowPage >= this.totalPage - 1)
            {
               this.nowPage = this.totalPage - 1;
            }
         }
         if(this.table != null && showPageB)
         {
            this.table.showPage(this.nowPage);
         }
         for(n in this.pageArr)
         {
            pb0 = this.pageArr[n];
            pb0.setState(0);
            pb0.actived = true;
         }
         this.pageArr[this.nowPage].setState(1);
         this.pageArr[this.nowPage].actived = false;
         if(this.totalPage > this.maxPage)
         {
            middle_p = int(this.maxPage / 2) + this.firstPage;
            if(this.nowPage < middle_p)
            {
               if(this.firstPage > 0)
               {
                  --this.firstPage;
               }
            }
            else if(this.nowPage > middle_p)
            {
               if(this.firstPage < this.totalPage - this.maxPage)
               {
                  ++this.firstPage;
               }
            }
            for(m in this.pageArr)
            {
               pb1 = this.pageArr[m];
               pb1.visible = false;
            }
            end_p = this.maxPage + this.firstPage - 1;
            this.setPagePosition(this.firstPage,end_p,this.firstPage);
         }
         this.prev_btn.actived = true;
         this.next_btn.actived = true;
         if(this.nowPage == 0)
         {
            this.prev_btn.actived = false;
         }
         else if(this.nowPage == this.totalPage - 1)
         {
            this.next_btn.actived = false;
         }
         if(this.totalPage <= 1)
         {
            this.prev_btn.actived = false;
            this.next_btn.actived = false;
         }
         if(this.fleshFun is Function)
         {
            this.fleshFun();
         }
      }
      
      public function prev(event:MouseEvent = null) : *
      {
         --this.nowPage;
         if(this.nowPage >= 0)
         {
            this.fleshAll();
         }
         else
         {
            this.nowPage = 0;
         }
      }
      
      public function next(event:MouseEvent = null) : *
      {
         ++this.nowPage;
         if(this.nowPage < this.totalPage)
         {
            this.fleshAll();
         }
         else
         {
            this.nowPage = this.totalPage - 1;
         }
      }
      
      private function pageClick(event:MouseEvent) : *
      {
         var pb1:* = event.target;
         var cindex:int = pb1.getText() - 1;
         if(cindex != this.nowPage)
         {
            this.nowPage = cindex;
            this.fleshAll();
         }
      }
      
      public function gotoPage(num0:int) : *
      {
         if(num0 >= 0 && num0 < this.totalPage)
         {
            this.nowPage = num0;
            this.fleshAll();
         }
      }
   }
}

