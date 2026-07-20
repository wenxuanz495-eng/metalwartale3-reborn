package org.hell
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class Component extends Sprite
   {
      
      protected var invalidHash:Object = {};
      
      protected var callLaterMethods:Dictionary;
      
      protected var _enabled:Boolean = true;
      
      protected var startHeight:Number;
      
      protected var startWidth:Number;
      
      protected var _height:Number;
      
      protected var _width:Number;
      
      protected var skinMc:DisplayObjectContainer;
      
      protected var _skinClass:Class;
      
      protected var _style:Object;
      
      private var inCallLaterPhase:Boolean = false;
      
      public function Component()
      {
         super();
         this.callLaterMethods = new Dictionary();
         this.configUI();
      }
      
      protected function configUI() : void
      {
         var _loc1_:Number = 1;
         super.scaleY = _loc1_;
         super.scaleX = _loc1_;
         this.startWidth = super.width;
         this.startHeight = super.height;
      }
      
      public function get skinClass() : Class
      {
         return this._skinClass;
      }
      
      public function set skinClass(param1:Class) : void
      {
         this._skinClass = param1;
         if(Boolean(this.skinMc) && Boolean(this.skinMc.stage))
         {
            removeChild(this.skinMc);
         }
         if(this._skinClass)
         {
            this.skinMc = new this._skinClass();
            addChildAt(this.skinMc,0);
         }
         this.invalidate("size");
      }
      
      protected function isInvalid(param1:String, ... rest) : Boolean
      {
         if(Boolean(this.invalidHash[param1]) || Boolean(this.invalidHash["all"]))
         {
            return true;
         }
         while(rest.length > 0)
         {
            if(this.invalidHash[rest.pop()])
            {
               return true;
            }
         }
         return false;
      }
      
      protected function validate() : void
      {
         this.invalidHash = {};
      }
      
      public function invalidate(param1:String = "all", param2:Boolean = true) : void
      {
         this.invalidHash[param1] = true;
         if(param2)
         {
            this.callLater(this.draw);
         }
      }
      
      protected function draw() : void
      {
         this.validate();
      }
      
      protected function callLater(param1:Function) : void
      {
         if(this.inCallLaterPhase)
         {
            return;
         }
         this.callLaterMethods[param1] = true;
         if(stage != null)
         {
            stage.addEventListener(Event.RENDER,this.callLaterDispatcher,false,0,true);
            stage.invalidate();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.callLaterDispatcher,false,0,true);
         }
      }
      
      private function callLaterDispatcher(param1:Event) : void
      {
         var _loc2_:Dictionary = null;
         var _loc3_:Object = null;
         if(param1.type == Event.ADDED_TO_STAGE)
         {
            removeEventListener(Event.ADDED_TO_STAGE,this.callLaterDispatcher);
            stage.addEventListener(Event.RENDER,this.callLaterDispatcher,false,0,true);
            stage.invalidate();
            return;
         }
         param1.target.removeEventListener(Event.RENDER,this.callLaterDispatcher);
         if(stage == null)
         {
            addEventListener(Event.ADDED_TO_STAGE,this.callLaterDispatcher,false,0,true);
            return;
         }
         this.inCallLaterPhase = true;
         _loc2_ = this.callLaterMethods;
         for(_loc3_ in _loc2_)
         {
            _loc3_();
            delete _loc2_[_loc3_];
         }
         this.inCallLaterPhase = false;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         if(param1 == this._enabled)
         {
            return;
         }
         this._enabled = param1;
         this.invalidate("state");
      }
      
      public function get enabled() : Boolean
      {
         return this._enabled;
      }
      
      public function setSize(param1:Number, param2:Number) : void
      {
         this._width = param1;
         this._height = param2;
         this.invalidate("size");
         dispatchEvent(new Event("resize"));
      }
      
      override public function set width(param1:Number) : void
      {
         if(this._width == param1)
         {
            return;
         }
         this.setSize(param1,this.height);
      }
      
      override public function get width() : Number
      {
         return this._width;
      }
      
      override public function set height(param1:Number) : void
      {
         if(this._height == param1)
         {
            return;
         }
         this.setSize(this.width,param1);
      }
      
      override public function get height() : Number
      {
         return this._height;
      }
      
      protected function getScaleX() : Number
      {
         return super.scaleX;
      }
      
      protected function getScaleY() : Number
      {
         return super.scaleY;
      }
      
      protected function setScaleX(param1:Number) : void
      {
         super.scaleX = param1;
      }
      
      protected function setScaleY(param1:Number) : void
      {
         super.scaleY = param1;
      }
      
      override public function get scaleX() : Number
      {
         return this.width / this.startWidth;
      }
      
      override public function get scaleY() : Number
      {
         return this.height / this.startHeight;
      }
      
      override public function set scaleX(param1:Number) : void
      {
         this.setSize(this.startWidth * param1,this.height);
      }
      
      override public function set scaleY(param1:Number) : void
      {
         this.setSize(this.width,this.startHeight * param1);
      }
      
      public function set style(param1:Object) : void
      {
         if(!param1)
         {
            return;
         }
         this._style = param1;
         this.configStyle();
      }
      
      protected function configStyle() : void
      {
         if(this.style.skinClass)
         {
            this.skinClass = this.style.skinClass as Class;
         }
      }
      
      public function get style() : Object
      {
         return this._style;
      }
      
      public function move(param1:Number, param2:Number) : void
      {
         super.x = Math.round(param1);
         super.y = Math.round(param2);
      }
   }
}

