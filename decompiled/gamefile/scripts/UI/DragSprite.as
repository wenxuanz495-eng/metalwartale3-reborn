package UI
{
   import data.Maths;
   import data.StringToDefine;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class DragSprite extends Sprite
   {
      
      protected var dragTarget:*;
      
      protected var dragFather:*;
      
      protected var dragBmp:Bitmap = new Bitmap();
      
      protected var dragBmpSp:Sprite = new Sprite();
      
      protected var dragPoint:Point = new Point();
      
      protected var iconOverB:Boolean = false;
      
      public function DragSprite()
      {
         super();
      }
      
      protected function addBmp() : *
      {
         this.dragBmpSp.addChild(this.dragBmp);
         this.dragBmpSp.mouseChildren = false;
         this.dragBmpSp.mouseEnabled = false;
         addChild(this.dragBmpSp);
      }
      
      protected function startDraging() : *
      {
         if(this.dragTarget != null)
         {
            this.dragBmp.bitmapData = StringToDefine.getBmp(this.dragTarget.icon);
            this.dragBmpSp.visible = false;
            this.dragPoint.x = this.mouseX;
            this.dragPoint.y = this.mouseY;
         }
         this.addEventListener(Event.ENTER_FRAME,this.dragIcon);
      }
      
      protected function stopDraging(event:MouseEvent = null) : *
      {
         this.removeEventListener(Event.ENTER_FRAME,this.dragIcon);
         this.dragTarget.iconReturn();
         this.dragTarget = null;
         this.dragFather = null;
         this.dragBmp.bitmapData.dispose();
         this.dragBmpSp.visible = false;
      }
      
      public function dragIcon(event:Event) : *
      {
         var len:* = Maths.Long(this.dragPoint.x - mouseX,this.dragPoint.y - mouseY);
         if(len > 10)
         {
            this.dragBmpSp.visible = true;
            this.dragTarget.iconLeave();
            this.dragBmpSp.x = this.mouseX - this.dragBmpSp.width / 2;
            this.dragBmpSp.y = this.mouseY - this.dragBmpSp.height + 10;
         }
      }
   }
}

