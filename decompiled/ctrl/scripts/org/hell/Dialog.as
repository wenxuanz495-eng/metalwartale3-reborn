package org.hell
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class Dialog extends Component
   {
      
      public static var stageHolder:Stage;
      
      public static var gameSizeObj:Object;
      
      protected var _draggable:Boolean = false;
      
      protected var _content:DisplayObject;
      
      protected var bg:Sprite;
      
      protected var bigbg:Sprite;
      
      protected var closeBtn:SimpleButton;
      
      public var view:DisplayObjectContainer;
      
      protected var viewClass:Class;
      
      protected var _titleHeight:int = 25;
      
      protected var titleTf:TextField;
      
      public function Dialog()
      {
         super();
      }
      
      public function get content() : DisplayObject
      {
         return this._content;
      }
      
      public function set content(param1:DisplayObject) : void
      {
         if(Boolean(this._content) && Boolean(this._content.parent))
         {
            this._content.parent.removeChild(this._content);
            this._content.removeEventListener("close",this.closeHandler);
         }
         this._content = param1;
         this._content.addEventListener("close",this.closeHandler,false,0,true);
         addChild(this._content);
      }
      
      protected function bgPress(param1:MouseEvent) : void
      {
         parent.setChildIndex(this,parent.numChildren - 1);
         if(this.bg.mouseY < this.titleHeight)
         {
            startDrag();
            stage.addEventListener(MouseEvent.MOUSE_UP,this.stageRelease);
         }
      }
      
      public function get draggable() : Boolean
      {
         return this._draggable;
      }
      
      public function set draggable(param1:Boolean) : void
      {
         this._draggable = param1;
         if(this._draggable)
         {
            this.bg.addEventListener(MouseEvent.MOUSE_DOWN,this.bgPress,false,0,true);
         }
         else
         {
            this.bg.removeEventListener(MouseEvent.MOUSE_DOWN,this.bgPress);
         }
      }
      
      protected function addEvent() : void
      {
         if(!this.closeBtn.hasEventListener("click"))
         {
            this.closeBtn.addEventListener("click",this.closeHandler,false,0,true);
         }
         if(this.content)
         {
            if(!this._content.hasEventListener("click"))
            {
               this._content.addEventListener("close",this.closeHandler);
            }
         }
      }
      
      protected function removeEvent() : void
      {
         this.closeBtn.removeEventListener("click",this.closeHandler);
         this.bg.removeEventListener(MouseEvent.MOUSE_DOWN,this.bgPress);
         if(this.content)
         {
            this._content.removeEventListener("close",this.closeHandler);
         }
      }
      
      protected function closeHandler(param1:Event) : void
      {
         this.removeEvent();
         if(this.bigbg.parent)
         {
            this.bigbg.parent.removeChild(this.bigbg);
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function show(param1:Boolean = false) : void
      {
         var _loc2_:Sprite = null;
         this.addEvent();
         if(stageHolder)
         {
            stageHolder.addChild(this);
            if(param1)
            {
               _loc2_ = this.getBigbg(0,0);
               stageHolder.addChildAt(_loc2_,stageHolder.getChildIndex(this));
            }
         }
      }
      
      protected function backToScreen() : void
      {
         if(x > stage.stageWidth - 20)
         {
            x = stage.stageWidth - 20;
         }
         else if(x < 40 - width)
         {
            x = 40 - width;
         }
         if(y > stage.stageHeight - 20)
         {
            y = stage.stageHeight - 20;
         }
         else if(y < 0)
         {
            y = 0;
         }
      }
      
      protected function stageRelease(param1:MouseEvent) : void
      {
         stopDrag();
         if(stage)
         {
            this.backToScreen();
            stage.removeEventListener(MouseEvent.MOUSE_UP,this.stageRelease);
         }
      }
      
      public function get titleHeight() : int
      {
         return this._titleHeight;
      }
      
      public function set titleHeight(param1:int) : void
      {
         this._titleHeight = param1;
         invalidate("size");
      }
      
      public function set title(param1:String) : void
      {
         this.titleTf.text = param1;
      }
      
      public function get title() : String
      {
         return this.titleTf.text;
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         var width:Number = NaN;
         var height:Number = NaN;
         var w:Number = param1;
         var h:Number = param2;
         width = w;
         height = h;
         super.setSize(width,height);
         this.bg.width = width;
         this.bg.height = height;
         this.closeBtn.x = width - this.closeBtn.width - 15;
         this.titleTf.width = this.closeBtn.x - this.titleTf.x - 2;
         if(this.content)
         {
            this.content.y = this.titleHeight;
            try
            {
               (this.content as Object).setSize(width,height - this.titleHeight);
            }
            catch(e:Error)
            {
               content.width = width;
               content.height = height - titleHeight;
            }
         }
      }
      
      protected function getBigbg(param1:uint, param2:Number = 0.6) : Sprite
      {
         if(!this.bigbg)
         {
            this.bigbg = new Sprite();
         }
         this.bigbg.graphics.clear();
         this.bigbg.graphics.beginFill(param1,param2);
         this.bigbg.graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
         this.bigbg.graphics.endFill();
         return this.bigbg;
      }
      
      public function moveCenter() : void
      {
         trace("width = " + width + "    height = " + height);
         if(gameSizeObj)
         {
            x = int((gameSizeObj.gameInitWid - width) / 2);
            y = int((gameSizeObj.gameInitHei - height) / 2);
         }
         else if(stage)
         {
            x = int((stage.stageWidth - width) / 2);
            y = int((stage.stageHeight - height) / 2);
         }
      }
      
      public function aotoSize() : void
      {
         if(this.content)
         {
            this.setSize(Math.max(120,this.content.width + 10),Math.max(80,this.content.height + 30));
         }
      }
      
      public function set icon(param1:DisplayObject) : void
      {
      }
      
      public function get icon() : DisplayObject
      {
         return null;
      }
      
      override protected function configStyle() : void
      {
         if(Boolean(style) && Boolean(style.viewClass))
         {
            this.viewClass = style.viewClass;
            this.initView();
         }
      }
      
      protected function initView() : void
      {
         var _loc1_:DisplayObjectContainer = null;
         this.view = new this.viewClass() as DisplayObjectContainer;
         addChildAt(this.view,0);
         this.bg = this.view["bg"];
         if(this.view["tmp"])
         {
            this.bg.addChild(this.view["tmp"]);
         }
         this.closeBtn = this.view["closeBtn"];
         this.closeBtn.visible = false;
         this.titleTf = this.view["titleTf"];
         this.titleTf.mouseEnabled = false;
         this.titleTf.visible = false;
         if(style)
         {
            _loc1_ = style.icon as DisplayObjectContainer;
         }
         if(_loc1_)
         {
            this.view["iconHolder"].addChild(_loc1_);
         }
         this.closeBtn.addEventListener("click",this.closeHandler,false,0,true);
         this.draggable = true;
      }
      
      public function closeBtnVisible(param1:Boolean = true) : void
      {
         this.closeBtn.visible = param1;
      }
      
      public function setTitleAndClose(param1:Boolean = true) : void
      {
         this.titleTf.visible = param1;
         this.closeBtn.visible = param1;
      }
   }
}

