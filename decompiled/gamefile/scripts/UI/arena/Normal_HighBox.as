package UI.arena
{
   import UI.ClickEvent;
   import UI.page.PageBox;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import gameAll.define.other.Normal_HighDefine;
   
   public class Normal_HighBox extends Sprite
   {
      
      public var title_bar:Normal_HighBar;
      
      public var bar_arr:Array;
      
      public var pageBox:PageBox;
      
      public var name_arr:Array;
      
      public var title_arr:Array;
      
      public var define:Normal_HighDefine;
      
      public var data_arr:Array;
      
      public var nowPage:int = 0;
      
      public var totalPage:int = 10;
      
      public var barNum:int = 0;
      
      public var BAR_CALSS:Class;
      
      public function Normal_HighBox(class0:Class, num0:int = 10)
      {
         var bar0:* = undefined;
         this.bar_arr = [];
         this.pageBox = new PageBox();
         this.name_arr = [];
         this.title_arr = [];
         this.data_arr = [];
         super();
         this.BAR_CALSS = class0;
         this.barNum = num0;
         for(var i:int = 0; i < num0; i++)
         {
            bar0 = new this.BAR_CALSS();
            bar0.index = i;
            bar0.x = 0;
            bar0.y = 30 + (61 - 40) * i;
            bar0.setBack(i % 2 + 1);
            this.bar_arr.push(bar0);
            bar0.light_mc.addEventListener(MouseEvent.MOUSE_OVER,this.btnOver);
            bar0.light_mc.addEventListener(MouseEvent.MOUSE_OUT,this.btnOut);
            bar0.light_mc.addEventListener(MouseEvent.MOUSE_MOVE,this.btnMove);
            bar0.addEventListener(ClickEvent.ON_CLICK,this.btnClick);
            addChild(bar0);
            trace("生成条目：" + bar0.y);
         }
         this.title_bar = new this.BAR_CALSS();
         addChild(this.title_bar);
         this.title_bar.setStyle("title");
         addChild(this.pageBox);
         var lastBar0:* = this.bar_arr[this.bar_arr.length - 1];
         this.pageBox.y = lastBar0.y + 15;
         this.pageBox.x = lastBar0.width / 2;
         this.pageBox.maxPage = 10;
         this.pageBox.table = this;
         this.pageBox.fleshByTable(false);
      }
      
      public function fleshData() : *
      {
         var n:* = undefined;
         var bar0:Normal_HighBar = null;
         var tmpObj:Object = null;
         var data_arr0:Array = null;
         this.title_bar.setContext(this.define.cn_arr);
         for(n in this.bar_arr)
         {
            bar0 = this.bar_arr[n];
            tmpObj = this.data_arr[n];
            if(Boolean(tmpObj))
            {
               data_arr0 = Game.gameDefine.high.getBarData(tmpObj,this.define.name_arr);
               bar0.setContext(data_arr0);
               bar0.visible = true;
               bar0.inPageNum(this.nowPage);
            }
            else
            {
               bar0.visible = false;
            }
         }
      }
      
      public function showPage(index0:int) : *
      {
         this.nowPage = index0;
         this.getRankList();
      }
      
      public function btnOver(e:*) : *
      {
         var index0:int = int(e.target.parent.index);
         var bar0:Normal_HighBar = this.bar_arr[index0];
         if(Boolean(bar0) && this.data_arr.length > 0)
         {
            bar0.light_mc.gotoAndStop(3);
         }
         var downEvent:ClickEvent = new ClickEvent(ClickEvent.ON_OVER);
         downEvent.goal = e.target.parent;
         downEvent.index = index0;
         this.dispatchEvent(downEvent);
      }
      
      public function btnOut(e:*) : *
      {
         var bar0:Normal_HighBar = this.bar_arr[this.bar_arr.indexOf(e.target.parent)];
         if(Boolean(bar0))
         {
            bar0.light_mc.gotoAndStop(bar0.backType);
         }
         var upEvent:ClickEvent = new ClickEvent(ClickEvent.ON_OUT);
         upEvent.goal = e.target.parent;
         upEvent.index = e.target.parent.index;
         this.dispatchEvent(upEvent);
      }
      
      public function btnMove(e:* = null) : *
      {
         var downEvent:ClickEvent = new ClickEvent(ClickEvent.ON_MOVE);
         downEvent.goal = e.target.parent;
         downEvent.index = e.target.parent.index;
         this.dispatchEvent(downEvent);
      }
      
      public function btnClick(e:* = null) : *
      {
         var downEvent:ClickEvent = new ClickEvent(ClickEvent.ON_CLICK);
         downEvent.goal = e.goal;
         downEvent.index = e.goal.index;
         this.dispatchEvent(downEvent);
      }
      
      public function getRankList(showLoadingB:Boolean = true) : *
      {
         if(showLoadingB)
         {
            Game.uiGroup.loadingUI.show();
         }
         Game.high_api.getRankListsData(this.define.id_arr[Game.nowSaveIndex],this.barNum,this.nowPage + 1,this.affter_getRankList,this.noFun);
      }
      
      private function affter_getRankList(dataAry:Array) : *
      {
         Game.uiGroup.loadingUI.hide();
         this.data_arr = dataAry;
         this.fleshData();
      }
      
      public function noFun() : *
      {
         Game.uiGroup.loadingUI.hide();
      }
   }
}

