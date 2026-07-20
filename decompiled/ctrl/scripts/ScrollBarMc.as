package
{
   import adobe.utils.*;
   import flash.accessibility.*;
   import flash.desktop.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.globalization.*;
   import flash.media.*;
   import flash.net.*;
   import flash.net.drm.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.sampler.*;
   import flash.sensors.*;
   import flash.system.*;
   import flash.text.*;
   import flash.text.engine.*;
   import flash.text.ime.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol393")]
   public dynamic class ScrollBarMc extends MovieClip
   {
      
      public var flashmo_scrollable_area:MovieClip;
      
      public var flashmo_scroller:MovieClip;
      
      public var sd:Number;
      
      public var sr:Number;
      
      public var cd:Number;
      
      public var cr:Number;
      
      public var new_y:Number;
      
      public var drag_area:Rectangle;
      
      public var flashmo_content:DisplayObject;
      
      public var flashmo_content_area:DisplayObject;
      
      public var scrolling_speed:Number;
      
      public function ScrollBarMc()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      public function scrolling(param1:DisplayObject, param2:DisplayObject, param3:Number) : void
      {
         this.scrolling_speed = param3;
         if(this.scrolling_speed < 0 || this.scrolling_speed > 1)
         {
            this.scrolling_speed = 0.5;
         }
         this.flashmo_content = param1;
         this.flashmo_content_area = param2;
         this.flashmo_content.mask = this.flashmo_content_area;
         this.flashmo_content.x = this.flashmo_content_area.x;
         this.flashmo_content.y = this.flashmo_content_area.y;
         this.flashmo_scroller.x = this.flashmo_scrollable_area.x;
         this.flashmo_scroller.y = this.flashmo_scrollable_area.y;
         this.sr = this.flashmo_content_area.height / this.flashmo_content.height;
         this.flashmo_scroller.height = this.flashmo_scrollable_area.height * this.sr;
         this.sd = this.flashmo_scrollable_area.height - this.flashmo_scroller.height;
         this.cd = this.flashmo_content.height - this.flashmo_content_area.height;
         this.cr = this.cd / this.sd * 1.01;
         this.drag_area = new Rectangle(0,0,0,this.flashmo_scrollable_area.height - this.flashmo_scroller.height);
         if(this.flashmo_content.height <= this.flashmo_content_area.height)
         {
            this.flashmo_scroller.visible = this.flashmo_scrollable_area.visible = false;
         }
         this.flashmo_scroller.addEventListener(MouseEvent.MOUSE_DOWN,this.scroller_drag);
         this.flashmo_scroller.addEventListener(MouseEvent.MOUSE_UP,this.scroller_drop);
         this.addEventListener(Event.ENTER_FRAME,this.on_scroll);
      }
      
      public function scroller_drag(param1:MouseEvent) : void
      {
         param1.target.startDrag(false,this.drag_area);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.up);
      }
      
      public function scroller_drop(param1:MouseEvent) : void
      {
         param1.target.stopDrag();
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.up);
      }
      
      public function up(param1:MouseEvent) : void
      {
         this.flashmo_scroller.stopDrag();
      }
      
      public function on_scroll(param1:Event) : void
      {
         this.new_y = this.flashmo_content_area.y + this.flashmo_scrollable_area.y * this.cr - this.flashmo_scroller.y * this.cr;
         this.flashmo_content.y += (this.new_y - this.flashmo_content.y) * this.scrolling_speed;
      }
      
      internal function frame1() : *
      {
      }
   }
}

