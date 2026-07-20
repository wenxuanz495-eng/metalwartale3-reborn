package org.hell
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.BlurFilter;
   import flash.geom.Rectangle;
   
   public class TabPages extends Component implements ITabPages
   {
      
      protected var contentHolderMask:Shape;
      
      protected var oldSelectedContent:DisplayObject;
      
      protected var _tabWidth:int = 50;
      
      protected var _sepx:int = 5;
      
      protected var contents:Array;
      
      protected var _selectedContent:DisplayObject;
      
      protected var contentHolder:Sprite;
      
      protected var _tabHeight:int = 25;
      
      protected var tabHolder:Sprite;
      
      protected var selectedBtn:Button;
      
      protected var tweenTime:Number = 0.5;
      
      public function TabPages()
      {
         super();
      }
      
      public function finalize() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function set tabHeight(param1:int) : void
      {
         this._tabHeight = param1;
         invalidate("size");
      }
      
      public function set tabWidth(param1:int) : void
      {
         this._tabWidth = param1;
         invalidate("size");
      }
      
      public function removeAll() : void
      {
         while(this.count > 0)
         {
            this.removePageAt(0);
         }
      }
      
      public function removePageAt(param1:uint) : void
      {
         var _loc2_:Button = null;
         if(param1 >= this.contents.length)
         {
            param1 = this.contents.length;
         }
         _loc2_ = this.tabHolder.getChildAt(param1) as Button;
         _loc2_.removeEventListener(MouseEvent.MOUSE_DOWN,this.btnMouseDown);
         this.tabHolder.removeChild(_loc2_);
         this.contents.splice(param1,1);
         invalidate("size");
      }
      
      public function addPage(param1:String, param2:DisplayObject, param3:DisplayObject) : void
      {
         this.addPageAt(param1,param2,param3,int.MAX_VALUE);
      }
      
      public function get selectedIndex() : int
      {
         return this.tabHolder.getChildIndex(this.selectedBtn);
      }
      
      public function get tabHeight() : int
      {
         return this._tabHeight;
      }
      
      public function get count() : uint
      {
         return this.contents.length;
      }
      
      public function addPageAt(param1:String, param2:DisplayObject, param3:DisplayObject, param4:uint) : void
      {
         var _loc5_:Button = null;
         if(param4 >= this.contents.length)
         {
            param4 = this.contents.length;
         }
         _loc5_ = new Button();
         _loc5_.buttonMode = true;
         if(style.buttonStyle)
         {
            _loc5_.style = style.buttonStyle;
         }
         if(param2)
         {
            _loc5_.icon = param2;
         }
         if(param1)
         {
            _loc5_.label = param1;
         }
         _loc5_.selectedEvent = MouseEvent.MOUSE_DOWN;
         _loc5_.toggle = true;
         _loc5_.addEventListener(MouseEvent.MOUSE_DOWN,this.btnMouseDown);
         this.tabHolder.addChildAt(_loc5_,param4);
         this.contents.splice(param4,0,param3);
         invalidate("size");
      }
      
      public function get tabWidth() : int
      {
         return this._tabWidth;
      }
      
      override protected function draw() : void
      {
         if(isInvalid("size"))
         {
            this.drawLayout();
         }
         super.draw();
      }
      
      public function get selectedContent() : DisplayObject
      {
         return this._selectedContent;
      }
      
      override protected function configStyle() : void
      {
         super.configStyle();
         this.initView();
      }
      
      public function initialize(param1:DisplayObjectContainer, param2:Rectangle, param3:Object) : Boolean
      {
         this.style = param3;
         this.tabHeight = param3.tabHeight ? int(param3.tabHeight) : 25;
         this.sepx = param3.horSep ? int(param3.horSep) : 5;
         move(param2.x,param2.y);
         setSize(param2.width,param2.height);
         param1.addChild(this);
         return true;
      }
      
      public function setBodyXY(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:DisplayObjectContainer = null;
         if(this.contents.length >= param1)
         {
            _loc4_ = this.contents[param1] as DisplayObjectContainer;
            _loc4_.x = param2;
            _loc4_.y = param3;
         }
      }
      
      protected function drawLayout() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:DisplayObjectContainer = null;
         _loc1_ = 0;
         _loc2_ = 0;
         while(_loc2_ < this.tabHolder.numChildren)
         {
            _loc3_ = this.tabHolder.getChildAt(_loc2_) as DisplayObjectContainer;
            _loc3_.width = (_loc3_["target"] as IconLabel).actualWidth + style.tabPaddingWidth ? Number(style.tabPaddingWidth) : 8;
            _loc3_.height = this._tabHeight;
            _loc3_.x = _loc1_;
            _loc1_ += _loc3_.width + this.sepx;
            _loc2_++;
         }
         if(this._selectedContent)
         {
            this.contentHolder.y = this._tabHeight;
            this.contentHolderMask.y = this._tabHeight;
            this.contentHolderMask.width = width;
            this.contentHolderMask.height = height - this._tabHeight;
         }
      }
      
      public function set sepx(param1:int) : void
      {
         this._sepx = param1;
         invalidate("size");
      }
      
      protected function initView() : void
      {
         this.contents = [];
         this.tabHolder = new Sprite();
         addChild(this.tabHolder);
         this.contentHolder = new Sprite();
         addChild(this.contentHolder);
         this.contentHolderMask = new Shape();
         this.contentHolderMask.graphics.beginFill(0,1);
         this.contentHolderMask.graphics.drawRect(0,0,10,10);
         this.contentHolderMask.graphics.endFill();
      }
      
      public function get sepx() : int
      {
         return this._sepx;
      }
      
      protected function btnMouseDown(param1:MouseEvent) : void
      {
         this.selectedIndex = this.tabHolder.getChildIndex(param1.currentTarget as DisplayObject);
      }
      
      public function set selectedIndex(param1:int) : void
      {
         if(param1 >= this.contents.length || param1 < 0)
         {
            return;
         }
         if(this.selectedBtn)
         {
            this.selectedBtn.selected = false;
         }
         this.selectedBtn = this.tabHolder.getChildAt(param1) as Button;
         this.selectedBtn.selected = true;
         if(Boolean(this._selectedContent) && this._selectedContent != this.contents[param1])
         {
            this.oldSelectedContent = this._selectedContent;
            this.tweenDone(null);
            this.oldSelectedContent.filters = [new BlurFilter(0,0)];
            this._selectedContent = this.contents[param1];
            this._selectedContent.alpha = 1;
         }
         else
         {
            this._selectedContent = this.contents[param1];
         }
         this.contentHolder.addChild(this._selectedContent);
         dispatchEvent(new Event("changeTabPage"));
      }
      
      protected function tweenDone(param1:Event) : void
      {
         if(this.oldSelectedContent)
         {
            this.oldSelectedContent.filters = [];
            this.oldSelectedContent.x = 0;
            this.oldSelectedContent.alpha = 0;
            if(this.oldSelectedContent.parent)
            {
               this.oldSelectedContent.parent.removeChild(this.oldSelectedContent);
            }
         }
      }
   }
}

