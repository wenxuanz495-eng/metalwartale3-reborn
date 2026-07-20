package org.hell
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class BaseButton extends Component
   {
      
      protected var _toggle:Boolean = false;
      
      protected var _selected:Boolean = false;
      
      protected var mouseState:String;
      
      protected var background:MovieClip;
      
      protected var pressTimer:Timer;
      
      protected var _autoRepeat:Boolean = false;
      
      public var selectedEvent:String = MouseEvent.CLICK;
      
      private var unlockedMouseState:String;
      
      private var _mouseStateLocked:Boolean = false;
      
      private var _target:DisplayObject;
      
      public function BaseButton()
      {
         super();
      }
      
      public function set mouseStateLocked(param1:Boolean) : void
      {
         this._mouseStateLocked = param1;
         if(param1 == false)
         {
            this.setMouseState(this.unlockedMouseState);
         }
         else
         {
            this.unlockedMouseState = this.mouseState;
         }
      }
      
      public function setMouseState(param1:String) : void
      {
         if(this._mouseStateLocked)
         {
            this.unlockedMouseState = param1;
            return;
         }
         if(this.mouseState == param1)
         {
            return;
         }
         this.mouseState = param1;
         invalidate("state");
      }
      
      protected function setupMouseEvents() : void
      {
         addEventListener(MouseEvent.ROLL_OVER,this.mouseEventHandler,false,0,true);
         addEventListener(MouseEvent.MOUSE_DOWN,this.mouseEventHandler,false,0,true);
         addEventListener(MouseEvent.MOUSE_UP,this.mouseEventHandler,false,0,true);
         addEventListener(MouseEvent.ROLL_OUT,this.mouseEventHandler,false,0,true);
      }
      
      protected function mouseEventHandler(param1:MouseEvent) : void
      {
         if(param1.type == MouseEvent.MOUSE_DOWN)
         {
            this.setMouseState("down");
            this.startPress();
         }
         else if(param1.type == MouseEvent.ROLL_OVER || param1.type == MouseEvent.MOUSE_UP)
         {
            this.setMouseState("over");
            this.endPress();
         }
         else if(param1.type == MouseEvent.ROLL_OUT)
         {
            this.setMouseState("up");
            this.endPress();
         }
      }
      
      public function get autoRepeat() : Boolean
      {
         return this._autoRepeat;
      }
      
      public function set autoRepeat(param1:Boolean) : void
      {
         this._autoRepeat = param1;
      }
      
      protected function endPress() : void
      {
         this.pressTimer.reset();
      }
      
      protected function buttonDown(param1:TimerEvent) : void
      {
         if(!this._autoRepeat)
         {
            this.endPress();
            return;
         }
         if(this.pressTimer.currentCount == 1)
         {
            this.pressTimer.delay = 20;
         }
         dispatchEvent(new Event("press"));
      }
      
      protected function startPress() : void
      {
         if(this._autoRepeat)
         {
            this.pressTimer.delay = 80;
            this.pressTimer.start();
         }
         dispatchEvent(new Event("press"));
      }
      
      public function get toggle() : Boolean
      {
         return this._toggle;
      }
      
      public function set toggle(param1:Boolean) : void
      {
         if(!param1 && this.selected)
         {
            this.selected = false;
         }
         this._toggle = param1;
         if(this._toggle)
         {
            addEventListener(this.selectedEvent,this.toggleSelected,false,0,true);
         }
         else
         {
            removeEventListener(this.selectedEvent,this.toggleSelected);
         }
         invalidate("state");
      }
      
      protected function toggleSelected(param1:MouseEvent) : void
      {
         this.selected = !this.selected;
         dispatchEvent(new Event(Event.CHANGE,true));
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         mouseEnabled = param1;
         if(param1)
         {
            if(this.mouseState == "disenabled")
            {
               this.setMouseState("up");
            }
         }
         else
         {
            this.setMouseState("disenabled");
         }
      }
      
      public function drawNow() : void
      {
         this.drawBackground();
         this.drawLayout();
      }
      
      override protected function draw() : void
      {
         if(isInvalid("state"))
         {
            this.drawBackground();
            invalidate("size",false);
         }
         if(isInvalid("size"))
         {
            this.drawLayout();
         }
         super.draw();
      }
      
      protected function drawLayout() : void
      {
         if(this.target)
         {
            this.target.width = width;
            this.target.height = height;
         }
         if(this.background)
         {
            this.background.width = width;
            this.background.height = height;
         }
      }
      
      protected function drawBackground() : void
      {
         if(skinMc)
         {
            this.background = skinMc as MovieClip;
            if(!this.background)
            {
               return;
            }
            switch(this.mouseState)
            {
               case "up":
                  this.background.gotoAndStop(this.selected ? 5 : 1);
                  break;
               case "over":
                  this.background.gotoAndStop(this.selected ? 6 : 2);
                  break;
               case "down":
                  this.background.gotoAndStop(this.selected ? 7 : 3);
                  break;
               case "disenabled":
                  this.background.gotoAndStop(this.selected ? 8 : 4);
            }
         }
      }
      
      public function get selected() : Boolean
      {
         return this._toggle ? this._selected : false;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(this._selected == param1)
         {
            return;
         }
         this._selected = param1;
         if(this._toggle)
         {
            invalidate("state");
         }
      }
      
      public function get target() : DisplayObject
      {
         return this._target;
      }
      
      public function set target(param1:DisplayObject) : void
      {
         if(!param1 && Boolean(this._target))
         {
            removeChild(this._target);
         }
         this._target = param1;
         if(this._target)
         {
            addChild(this._target);
         }
         invalidate("size");
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseChildren = false;
         this.setupMouseEvents();
         this.setMouseState("up");
         this.pressTimer = new Timer(1,0);
         this.pressTimer.addEventListener(TimerEvent.TIMER,this.buttonDown,false,0,true);
      }
   }
}

