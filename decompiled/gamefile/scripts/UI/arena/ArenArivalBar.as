package UI.arena
{
   import UI.ClickEvent;
   import data.StringToDefine;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class ArenArivalBar extends Sprite
   {
      
      public var _mc:MovieClip;
      
      public var _txt:TextField;
      
      public var _btn:SimpleButton;
      
      public var hit_mc:Sprite;
      
      public var itemsData:* = null;
      
      public function ArenArivalBar()
      {
         super();
         this._mc.stop();
         this.addLis();
         this.mouseEnabled = false;
      }
      
      public function inData_byObject(obj0:Object) : *
      {
         this.itemsData = obj0;
         this._txt.htmlText = "排名：" + StringToDefine.getFontColor(this.itemsData.rank,"FFFF00");
         this._mc.gotoAndStop(this.itemsData.extra.head);
      }
      
      public function addLis() : *
      {
         this.hit_mc.addEventListener(MouseEvent.MOUSE_OVER,this.buttonOver);
         this.hit_mc.addEventListener(MouseEvent.MOUSE_OUT,this.buttonOut);
         this._btn.addEventListener(MouseEvent.CLICK,this.buttonClick);
      }
      
      public function delLis() : *
      {
         this.hit_mc.removeEventListener(MouseEvent.MOUSE_OVER,this.buttonOver);
         this.hit_mc.removeEventListener(MouseEvent.MOUSE_OUT,this.buttonOut);
         this._btn.removeEventListener(MouseEvent.CLICK,this.buttonClick);
      }
      
      private function buttonClick(event:MouseEvent) : *
      {
         var clickEvent:ClickEvent = new ClickEvent();
         clickEvent.goal = event.target;
         this.dispatchEvent(clickEvent);
      }
      
      private function buttonOver(event:MouseEvent) : *
      {
         var downEvent:ClickEvent = new ClickEvent(ClickEvent.ON_OVER);
         downEvent.goal = event.target;
         this.dispatchEvent(downEvent);
      }
      
      private function buttonOut(event:MouseEvent) : *
      {
         var upEvent:ClickEvent = new ClickEvent(ClickEvent.ON_OUT);
         upEvent.goal = event.target;
         this.dispatchEvent(upEvent);
      }
   }
}

