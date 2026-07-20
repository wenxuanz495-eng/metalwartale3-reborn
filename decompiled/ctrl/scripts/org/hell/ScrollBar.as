package org.hell
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ScrollBar extends Component
   {
      
      public static const HORIZONTAL:String = "h";
      
      public static const VERTICAL:String = "v";
      
      protected var upArrow:BaseButton;
      
      protected var UpArrowSkinClass:Class;
      
      protected var downArrow:BaseButton;
      
      protected var DownArrowSkinClass:Class;
      
      protected var track:BaseButton;
      
      protected var TrackSkinClass:Class;
      
      protected var thumb:BaseButton;
      
      protected var ThumbSkinClass:Class;
      
      protected var _arrowHeight:uint;
      
      protected var WIDTH:Number = 15;
      
      protected var inDrag:Boolean = false;
      
      private var _direction:String = VERTICAL;
      
      private var _minScrollPosition:Number = 0;
      
      private var _maxScrollPosition:Number = 0;
      
      private var _scrollPosition:Number = 0;
      
      private var _lineScrollSize:Number = 1;
      
      private var _pageScrollSize:Number = 0;
      
      private var _pageSize:Number = 10;
      
      private var thumbScrollOffset:Number;
      
      public function ScrollBar()
      {
         this._arrowHeight = this.WIDTH;
         super();
      }
      
      public function get minScrollPosition() : Number
      {
         return this._minScrollPosition;
      }
      
      public function set minScrollPosition(param1:Number) : void
      {
         this.setScrollProperties(this._pageSize,param1,this._maxScrollPosition);
      }
      
      public function get maxScrollPosition() : Number
      {
         return this._maxScrollPosition;
      }
      
      public function set maxScrollPosition(param1:Number) : void
      {
         this.setScrollProperties(this._pageSize,this._minScrollPosition,param1);
      }
      
      public function setScrollProperties(param1:Number, param2:Number, param3:Number, param4:Number = 0) : void
      {
         this.pageSize = param1;
         this._minScrollPosition = param2;
         this._maxScrollPosition = param3;
         if(param4 >= 0)
         {
            this._pageScrollSize = param4;
         }
         this.enabled = this._maxScrollPosition > this._minScrollPosition;
         this.setScrollPosition(this._scrollPosition,false);
         this.updateThumb();
      }
      
      public function set scrollPosition(param1:Number) : void
      {
         this.setScrollPosition(param1,true);
      }
      
      public function get scrollPosition() : Number
      {
         return this._scrollPosition;
      }
      
      public function setScrollPosition(param1:Number, param2:Boolean = true) : void
      {
         var _loc3_:Number = NaN;
         _loc3_ = this.scrollPosition;
         this._scrollPosition = Math.max(this._minScrollPosition,Math.min(this._maxScrollPosition,param1));
         if(_loc3_ == this._scrollPosition)
         {
            return;
         }
         if(param2)
         {
            dispatchEvent(new Event("scroll"));
         }
         this.updateThumb();
      }
      
      public function set pageScrollSize(param1:Number) : void
      {
         if(param1 >= 0)
         {
            this._pageScrollSize = param1;
         }
      }
      
      public function get pageScrollSize() : Number
      {
         return this._pageScrollSize == 0 ? this._pageSize : this._pageScrollSize;
      }
      
      public function get pageSize() : Number
      {
         return this._pageSize;
      }
      
      public function set pageSize(param1:Number) : void
      {
         if(param1 > 0)
         {
            this._pageSize = param1;
         }
      }
      
      protected function updateThumb() : void
      {
         var _loc1_:Number = NaN;
         _loc1_ = this._maxScrollPosition - this._minScrollPosition + this._pageSize;
         if(this.track.height <= 12 || this._maxScrollPosition <= this._minScrollPosition || (_loc1_ == 0 || isNaN(_loc1_)))
         {
            this.thumb.height = 12;
            this.thumb.visible = false;
            this.track.visible = false;
         }
         else
         {
            this.thumb.height = Math.max(13,this._pageSize / _loc1_ * this.track.height);
            this.thumb.y = this.track.y + (this.track.height - this.thumb.height) * ((this._scrollPosition - this._minScrollPosition) / (this._maxScrollPosition - this._minScrollPosition));
            this.thumb.visible = this.enabled;
            this.track.visible = this.enabled;
         }
      }
      
      protected function thumbPressHandler(param1:MouseEvent) : void
      {
         this.inDrag = true;
         this.thumbScrollOffset = mouseY - this.thumb.y;
         this.thumb.mouseStateLocked = true;
         mouseChildren = false;
         stage.addEventListener(MouseEvent.MOUSE_MOVE,this.handleThumbDrag,false,0,true);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.thumbReleaseHandler,false,0,true);
      }
      
      protected function thumbReleaseHandler(param1:MouseEvent) : void
      {
         this.inDrag = false;
         mouseChildren = true;
         this.thumb.mouseStateLocked = false;
         stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.handleThumbDrag);
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.thumbReleaseHandler);
      }
      
      protected function handleThumbDrag(param1:MouseEvent) : void
      {
         var _loc2_:Number = NaN;
         _loc2_ = Math.max(0,Math.min(this.track.height - this.thumb.height,mouseY - this.track.y - this.thumbScrollOffset));
         this.setScrollPosition(_loc2_ / (this.track.height - this.thumb.height) * (this._maxScrollPosition - this._minScrollPosition) + this._minScrollPosition);
      }
      
      public function get direction() : String
      {
         return this._direction;
      }
      
      public function set direction(param1:String) : void
      {
         var _loc2_:Boolean = false;
         if(this._direction == param1)
         {
            return;
         }
         this._direction = param1;
         setScaleY(1);
         _loc2_ = this._direction == HORIZONTAL;
         if(_loc2_)
         {
            if(rotation == 90)
            {
               return;
            }
            setScaleX(-1);
            rotation = -90;
         }
         invalidate("size");
      }
      
      public function get lineScrollSize() : Number
      {
         return this._lineScrollSize;
      }
      
      public function set lineScrollSize(param1:Number) : void
      {
         if(param1 > 0)
         {
            this._lineScrollSize = param1;
         }
      }
      
      public function get arrowHeight() : uint
      {
         return this._arrowHeight;
      }
      
      public function set arrowHeight(param1:uint) : void
      {
         this._arrowHeight = param1;
         if(this.upArrow)
         {
            this.upArrow.height = this.arrowHeight;
         }
         if(this.downArrow)
         {
            this.downArrow.height = this.arrowHeight;
         }
         invalidate("size");
      }
      
      override public function get width() : Number
      {
         return this._direction == HORIZONTAL ? super.height : super.width;
      }
      
      override public function get height() : Number
      {
         return this._direction == HORIZONTAL ? super.width : super.height;
      }
      
      protected function scrollPressHandler(param1:Event) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         param1.stopImmediatePropagation();
         if(param1.currentTarget == this.upArrow)
         {
            this.setScrollPosition(this._scrollPosition - this._lineScrollSize);
         }
         else if(param1.currentTarget == this.downArrow)
         {
            this.setScrollPosition(this._scrollPosition + this._lineScrollSize);
         }
         else
         {
            _loc2_ = this.track.mouseY / this.track.height * (this._maxScrollPosition - this._minScrollPosition) + this._minScrollPosition;
            _loc3_ = this.pageScrollSize == 0 ? this.pageSize : this.pageScrollSize;
            if(this._scrollPosition < _loc2_)
            {
               this.setScrollPosition(Math.min(_loc2_,this._scrollPosition + _loc3_));
            }
            else if(this._scrollPosition > _loc2_)
            {
               this.setScrollPosition(Math.max(_loc2_,this._scrollPosition - _loc3_));
            }
         }
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         this.downArrow.enabled = this.track.enabled = this.thumb.enabled = this.upArrow.enabled = this.enabled && this._maxScrollPosition > this._minScrollPosition;
         this.updateThumb();
      }
      
      override public function get enabled() : Boolean
      {
         return super.enabled;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         if(isInvalid("size"))
         {
            _loc1_ = super.height;
            this.downArrow.move(0,Math.max(this.upArrow.height,_loc1_ - this.downArrow.height));
            this.track.setSize(this.WIDTH,Math.max(0,_loc1_ - this.downArrow.height - this.upArrow.height));
            this.updateThumb();
         }
         this.downArrow.drawNow();
         this.upArrow.drawNow();
         this.track.drawNow();
         this.thumb.drawNow();
         validate();
      }
      
      public function get scrollBarWidth() : Number
      {
         return this.WIDTH;
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         if(this._direction == HORIZONTAL)
         {
            super.setSize(param2,param1);
         }
         else
         {
            super.setSize(param1,param2);
         }
      }
      
      override protected function configStyle() : void
      {
         super.configStyle();
         this.UpArrowSkinClass = style.upArrowSkinClass;
         this.DownArrowSkinClass = style.downArrowSkinClass;
         this.ThumbSkinClass = style.thumbSkinClass;
         this.TrackSkinClass = style.trackSkinClass;
         if(style.arrowHeight != undefined)
         {
            this._arrowHeight = style.arrowHeight;
         }
         if(style.scrollBarWidth != undefined)
         {
            this.WIDTH = style.scrollBarWidth;
         }
         this.initView();
      }
      
      protected function initView() : void
      {
         this.track = new BaseButton();
         this.track.move(0,this.arrowHeight + 1);
         this.track.useHandCursor = false;
         this.track.autoRepeat = true;
         this.track.skinClass = this.TrackSkinClass;
         addChild(this.track);
         this.thumb = new BaseButton();
         this.thumb.setSize(this.WIDTH,15);
         this.thumb.move(0,15);
         this.thumb.skinClass = this.ThumbSkinClass;
         addChild(this.thumb);
         this.downArrow = new BaseButton();
         this.downArrow.setSize(this.WIDTH,this.arrowHeight);
         this.downArrow.autoRepeat = true;
         this.downArrow.skinClass = this.DownArrowSkinClass;
         addChild(this.downArrow);
         this.upArrow = new BaseButton();
         this.upArrow.setSize(this.WIDTH,this.arrowHeight);
         this.upArrow.move(0,0);
         this.upArrow.autoRepeat = true;
         this.upArrow.skinClass = this.UpArrowSkinClass;
         addChild(this.upArrow);
         this.upArrow.addEventListener("press",this.scrollPressHandler,false,0,true);
         this.downArrow.addEventListener("press",this.scrollPressHandler,false,0,true);
         this.track.addEventListener("press",this.scrollPressHandler,false,0,true);
         this.thumb.addEventListener(MouseEvent.MOUSE_DOWN,this.thumbPressHandler,false,0,true);
         this.enabled = false;
      }
   }
}

