package UI.button
{
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class SountoScrollBar extends Sprite
   {
      
      public var target:*;
      
      public var targetY:int = 0;
      
      public var btn:SimpleButton;
      
      public var limitHigh:int = 170;
      
      public var dragB:Boolean = false;
      
      public var downPoint:Point = new Point();
      
      public var scrollCover:Sprite;
      
      public var back:*;
      
      public var downFun:Function;
      
      public var upFun:Function;
      
      public function SountoScrollBar()
      {
         super();
         if(this.scrollCover == null)
         {
            return;
         }
         this.scrollCover.visible = false;
         this.btn.addEventListener(MouseEvent.MOUSE_MOVE,this.btnMove);
         this.btn.addEventListener(MouseEvent.MOUSE_DOWN,this.btnDown);
         this.btn.addEventListener(MouseEvent.MOUSE_UP,this.btnUp);
         this.scrollCover.addEventListener(MouseEvent.MOUSE_MOVE,this.btnMove);
         this.scrollCover.addEventListener(MouseEvent.MOUSE_UP,this.btnUp);
      }
      
      public function swapToTask() : *
      {
         var btn0:SimpleButton = Game.swfLoaderManager.getResource("newui","taskScrollBar");
         this.swapBar(btn0,false);
      }
      
      private function swapBar(btn0:SimpleButton, hideBackB:Boolean) : *
      {
         this.btn.removeEventListener(MouseEvent.MOUSE_MOVE,this.btnMove);
         this.btn.removeEventListener(MouseEvent.MOUSE_DOWN,this.btnDown);
         this.btn.removeEventListener(MouseEvent.MOUSE_UP,this.btnUp);
         this.removeChild(this.btn);
         this.btn = btn0;
         this.addChildAt(this.btn,0);
         this.btn.addEventListener(MouseEvent.MOUSE_MOVE,this.btnMove);
         this.btn.addEventListener(MouseEvent.MOUSE_DOWN,this.btnDown);
         this.btn.addEventListener(MouseEvent.MOUSE_UP,this.btnUp);
         this.back.visible = hideBackB;
      }
      
      public function setHigh(_limitHigh:int) : *
      {
         if(this.back == null || this.back.mc1 == null || this.back.mc2 == null)
         {
            return;
         }
         this.limitHigh = _limitHigh;
         this.back.mc1.height = this.limitHigh;
         this.back.mc2.y = this.back.mc1.y + this.back.mc1.height;
      }
      
      public function setTarget(_target:*, firstB:Boolean = true) : *
      {
         if(_target == null || this.btn == null)
         {
            return;
         }
         this.target = _target;
         if(firstB)
         {
            this.targetY = this.target.y;
         }
         if(this.target.height <= this.limitHigh)
         {
            this.btn.mouseEnabled = false;
            this.btn.alpha = 0.3;
         }
         else
         {
            this.btn.mouseEnabled = true;
            this.btn.alpha = 1;
         }
      }
      
      public function btnDown(event:*) : *
      {
         this.dragB = true;
         this.downPoint.x = mouseX - this.btn.x;
         this.downPoint.y = mouseY - this.btn.y;
         this.scrollCover.visible = true;
         if(this.downFun is Function)
         {
            this.downFun();
         }
      }
      
      public function btnUp(event:*) : *
      {
         this.dragB = false;
         this.scrollCover.visible = false;
         if(this.upFun is Function)
         {
            this.upFun();
         }
      }
      
      public function btnMove(event:MouseEvent) : *
      {
         var y0:int = 0;
         if(this.dragB)
         {
            y0 = this.btn.y;
            y0 = mouseY - this.downPoint.y;
            if(y0 < 0)
            {
               y0 = 0;
            }
            else if(y0 > this.limitHigh - this.btn.height)
            {
               y0 = this.limitHigh - this.btn.height;
            }
            this.btn.y = y0;
            this.fleshTarget();
         }
      }
      
      public function getPer() : Number
      {
         return this.btn.y / (this.limitHigh - this.btn.height);
      }
      
      public function setPer(num0:Number) : *
      {
         if(num0 < 0)
         {
            num0 = 0;
         }
         else if(num0 > 1)
         {
            num0 = 1;
         }
         this.btn.y = (this.limitHigh - this.btn.height) * num0;
         this.fleshTarget();
      }
      
      public function fleshTarget() : *
      {
         if(this.target != null)
         {
            this.target.y = -this.getPer() * (this.target.height + 30 - this.limitHigh) + this.targetY;
         }
      }
   }
}

