package ctrl4399.view.components.sortlist
{
   import ctrl4399.strconst.AllConst;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import org.heaven.impl.tot.Singleton;
   import org.hell.ScrollBar;
   
   public class SList extends Sprite
   {
      
      private var vsb:ScrollBar;
      
      private var listCont:Sprite;
      
      private var totalLen:uint = 15;
      
      private var showLen:uint = 5;
      
      private const TOTAL_LEN:uint = 15;
      
      private const SHOW_LEN:uint = 5;
      
      private var _itemList:Array;
      
      public function SList()
      {
         var _loc1_:ListItem = null;
         var _loc2_:int = 0;
         this.vsb = new ScrollBar();
         this.listCont = new Sprite();
         super();
         this._itemList = [];
         _loc2_ = 0;
         while(_loc2_ < this.TOTAL_LEN)
         {
            this._itemList[_loc2_] = new ListItem();
            _loc1_ = this._itemList[_loc2_];
            this.listCont.addChild(_loc1_);
            _loc1_.y = 53 * _loc2_;
            _loc1_.visible = false;
            _loc2_++;
         }
         addChild(this.listCont);
         this.listCont.scrollRect = new Rectangle(0,0,458,254);
         var _loc3_:Object = new Object();
         _loc3_.skinClass = null;
         _loc3_.upArrowSkinClass = Singleton.getClass(AllConst.SPC_SCROLL_UP);
         _loc3_.downArrowSkinClass = Singleton.getClass(AllConst.SPC_SCROLL_DOWN);
         _loc3_.thumbSkinClass = Singleton.getClass(AllConst.SPC_SCROLL_THUMB);
         _loc3_.trackSkinClass = Singleton.getClass(AllConst.SPC_SCROLL_TRACE);
         _loc3_.arrowHeight = 8;
         _loc3_.scrollBarWidth = 10;
         this.vsb.style = _loc3_;
         this.vsb.setSize(10,254);
         this.vsb.enabled = true;
         addChild(this.vsb);
         this.vsb.move(462,0);
         this.vsb.pageSize = 254;
         this.vsb.lineScrollSize = 10;
         this.vsb.minScrollPosition = 0;
         this.vsb.maxScrollPosition = 0;
         this.vsb.addEventListener("scroll",this.vspScroll);
         this.listCont.addEventListener(MouseEvent.MOUSE_WHEEL,this.mouseWheel);
      }
      
      protected function mouseWheel(param1:MouseEvent) : void
      {
         this.vsb.scrollPosition -= param1.delta * 10;
      }
      
      protected function vspScroll(param1:Event) : void
      {
         var _loc2_:Rectangle = this.listCont.scrollRect;
         _loc2_.y = this.vsb.scrollPosition;
         this.listCont.scrollRect = _loc2_;
      }
      
      public function showData(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ListItem = null;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(param1)
         {
            _loc6_ = int(param1.length) - this.showLen;
            _loc7_ = _loc6_ > 0 ? _loc6_ : 0;
            _loc7_ = _loc7_ > this.TOTAL_LEN - this.SHOW_LEN ? int(this.TOTAL_LEN - this.SHOW_LEN) : _loc7_;
            this.vsb.scrollPosition = 0;
            this.vsb.maxScrollPosition = 54 * _loc7_;
         }
         this.clearData();
         if(param1 == null)
         {
            return;
         }
         _loc3_ = int(this._itemList.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this._itemList[_loc2_] as ListItem;
            _loc5_ = param1[_loc2_];
            if(_loc5_)
            {
               _loc4_.uid = _loc5_[0];
               _loc4_.showData(param1[_loc2_]);
               _loc4_.visible = true;
            }
            _loc2_++;
         }
      }
      
      private function clearData() : void
      {
         var _loc1_:ListItem = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(this._itemList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = this._itemList[_loc3_] as ListItem;
            _loc1_.clearData();
            _loc1_.visible = false;
            _loc3_++;
         }
      }
      
      public function upDataPic(param1:DisplayObject, param2:String) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:ListItem = null;
         _loc4_ = int(this._itemList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = this._itemList[_loc3_] as ListItem;
            if(_loc5_.uid == param2)
            {
               _loc5_.upDataPic(param1);
               break;
            }
            _loc3_++;
         }
      }
      
      public function move(param1:int, param2:int) : void
      {
         this.x = param1;
         this.y = param2;
      }
   }
}

