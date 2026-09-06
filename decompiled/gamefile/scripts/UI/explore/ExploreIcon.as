package UI.explore
{
   import UI.ClickEvent;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import goods.GoodsDefine;
   
   public class ExploreIcon extends Sprite
   {
      
      private var _actived:Boolean = true;
      
      public var back:MovieClip;
      
      public var icon:Sprite;
      
      public var label:String = "normal";
      
      public var name_txt:TextField;
      
      public var num_txt:TextField;
      
      public var text:String = "";
      
      public var icon_mc:MovieClip;
      
      public var index:int = 0;
      
      public var state:String = "";
      
      public var fastB:Boolean = false;
      
      public var numB:Boolean = true;
      
      public var itemsData:*;
      
      public function ExploreIcon()
      {
         super();
         this.init();
      }
      
      public function init() : *
      {
         this.name_txt.visible = false;
         this.back.stop();
         this.mouseEnabled = true;
         this.mouseChildren = false;
         this.addEventListener(MouseEvent.MOUSE_OVER,this.MOver);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.MOut);
         this.num_txt.visible = false;
      }
      
      public function setState(_state:String) : *
      {
         this.state = _state;
         if(this.state == "fill")
         {
         }
      }
      
      public function setBack(num:int) : *
      {
         this.back.gotoAndStop(num);
      }
      
      public function clearData() : *
      {
         this.itemsData = null;
         this.icon.y = 37;
         this.name_txt.visible = false;
         if(this.icon_mc != null)
         {
            this.icon.removeChild(this.icon_mc);
            this.icon_mc = null;
         }
         this.setState("blank");
      }
      
      public function setNum(num:int) : *
      {
         if(num > 1)
         {
            this.num_txt.visible = true;
            this.num_txt.x = this.icon.x + this.icon.width;
            this.icon.x = 80;
         }
         else
         {
            this.num_txt.visible = false;
            this.icon.x = 84;
         }
         this.num_txt.text = "x" + num;
      }
      
      public function clear() : *
      {
         this.clearData();
         this.removeEventListener(MouseEvent.MOUSE_OVER,this.MOver);
         this.removeEventListener(MouseEvent.MOUSE_OUT,this.MOut);
      }
      
      public function setIcon(mc0:MovieClip) : *
      {
         if(this.icon_mc != null)
         {
            this.icon.removeChild(this.icon_mc);
            this.icon_mc = null;
         }
         this.icon_mc = mc0;
         mc0.stop();
         this.icon.addChild(mc0);
         var mc1:* = mc0.getChildByName("shootPoint");
         var mc2:* = mc0.getChildByName("basePoint");
         var mc3:* = mc0.getChildByName("laserPoint");
         if(mc1 is MovieClip)
         {
            mc0.removeChild(mc1);
            mc0.removeChild(mc2);
         }
         if(mc3 is MovieClip)
         {
            mc0.removeChild(mc3);
         }
         var rect0:Rectangle = mc0.getRect(mc0);
         mc0.x = -rect0.x - rect0.width / 2;
         mc0.y = -rect0.y - rect0.height / 2;
      }
      
      public function setText(str:String) : *
      {
         this.text = str;
         this.name_txt.text = str;
      }
      
      public function setGCoin(num0:int) : *
      {
         this.icon.y = 29;
         this.setText(num0 + " G币");
         this.name_txt.visible = true;
      }
      
      public function iconLeave() : *
      {
         this.icon.visible = false;
      }
      
      public function iconReturn() : *
      {
         this.icon.visible = true;
      }
      
      public function inData_byDefine(d0:GoodsDefine) : *
      {
         var mc:MovieClip = null;
         var bit:Bitmap = null;
         this.itemsData = d0;
         var temp:* = Game.swfLoaderManager.getResource("",d0.imgLabel);
         if(!(temp is DisplayObject))
         {
            mc = new MovieClip();
            bit = new Bitmap(temp);
            mc.addChild(bit);
            bit.x = -bit.width / 2;
            bit.y = -bit.height / 2;
         }
         else
         {
            mc = temp;
         }
         var icon0:MovieClip = mc;
         this.setText(d0.name);
         this.setIcon(icon0);
         this.setState("fill");
         this.setNum(d0.num);
         if(d0.id == "GCoin_card_4")
         {
            this.setGCoin(d0.price);
         }
      }
      
      public function set actived(bb:Boolean) : *
      {
         this._actived = bb;
         if(bb)
         {
            this.mouseEnabled = true;
         }
         else
         {
            this.mouseEnabled = false;
            this.gotoLabel("no");
         }
      }
      
      public function get actived() : Boolean
      {
         return this._actived;
      }
      
      public function gotoLabel(label0:String) : *
      {
         if(this.state != "lock" || label0 == "no")
         {
            this.back.gotoAndStop(label0);
            this.label = label0;
         }
      }
      
      protected function MOver(event:MouseEvent) : *
      {
         var downEvent:ClickEvent = new ClickEvent(ClickEvent.ON_OVER);
         this.dispatchEvent(downEvent);
      }
      
      protected function MOut(event:MouseEvent) : *
      {
         var upEvent:ClickEvent = new ClickEvent(ClickEvent.ON_OUT);
         this.dispatchEvent(upEvent);
      }
   }
}

