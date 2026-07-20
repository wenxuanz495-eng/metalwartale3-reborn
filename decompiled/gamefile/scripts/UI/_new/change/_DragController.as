package UI._new.change
{
   import UI._new.icon.ChangeIconBox;
   import UI._new.icon.NormalAllIcon;
   import data.Maths;
   import data.StringToDefine;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class _DragController extends MovieClip
   {
      
      public var dragB:Boolean = false;
      
      public var dragTarget:NormalAllIcon = null;
      
      public var dragFather:ChangeIconBox = null;
      
      private var dragBmp:Bitmap = new Bitmap();
      
      private var dragPoint:Point = new Point();
      
      private var iconOverB:Boolean = false;
      
      public function _DragController()
      {
         super();
         this.mouseChildren = false;
         this.mouseEnabled = false;
         addChild(this.dragBmp);
         Game.gameSprite.addEventListener(MouseEvent.MOUSE_UP,this.mouseUp);
      }
      
      public function startDraging(target0:*, father0:*) : *
      {
         if(!this.dragB)
         {
            this.dragB = true;
            this.dragTarget = target0;
            this.dragFather = father0;
            if(Boolean(this.dragBmp.bitmapData))
            {
               this.dragBmp.bitmapData.dispose();
            }
            this.dragBmp.bitmapData = StringToDefine.getBmp(this.dragTarget.getIcon());
            this.dragPoint.x = this.mouseX;
            this.dragPoint.y = this.mouseY;
            this.visible = false;
            this.addEventListener(Event.ENTER_FRAME,this.dragIcon);
         }
      }
      
      public function stopDraging() : *
      {
         if(this.dragB)
         {
            this.removeEventListener(Event.ENTER_FRAME,this.dragIcon);
            this.dragTarget.iconReturn();
            this.dragB = false;
            if(Boolean(this.dragBmp.bitmapData))
            {
               this.dragBmp.bitmapData.dispose();
            }
            this.visible = false;
         }
      }
      
      public function dragIcon(event:Event) : *
      {
         var len:* = Maths.Long(this.dragPoint.x - mouseX,this.dragPoint.y - mouseY);
         if(len > 10)
         {
            this.visible = true;
            this.dragTarget.iconLeave();
            this.dragBmp.x = this.mouseX - this.dragBmp.width / 2;
            this.dragBmp.y = this.mouseY - this.dragBmp.height + 10;
         }
      }
      
      public function clear() : *
      {
         this.dragTarget = null;
         this.dragFather = null;
      }
      
      public function mouseUp(e:*) : *
      {
         this.stopDraging();
      }
   }
}

