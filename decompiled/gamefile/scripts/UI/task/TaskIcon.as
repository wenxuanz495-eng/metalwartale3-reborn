package UI.task
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
   
   public class TaskIcon extends Sprite
   {
      
      private var _actived:Boolean = true;
      
      public var icon:Sprite;
      
      public var label:String = "normal";
      
      public var name_txt:TextField;
      
      public var level_txt:TextField;
      
      public var text:String = "";
      
      public var icon_mc:MovieClip;
      
      public var index:int = 0;
      
      public var state:String = "";
      
      public var fastB:Boolean = false;
      
      public var numB:Boolean = true;
      
      public var itemsData:*;
      
      public function TaskIcon()
      {
         super();
         this.init();
      }
      
      public function init() : *
      {
         this.mouseEnabled = true;
         this.mouseChildren = false;
         this.addEventListener(MouseEvent.MOUSE_OVER,this.MOver);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.MOut);
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
      }
      
      public function clearData() : *
      {
         this.itemsData = null;
         if(this.icon_mc != null)
         {
            this.icon.removeChild(this.icon_mc);
            this.icon_mc = null;
         }
         this.setState("blank");
      }
      
      public function clear() : *
      {
         this.clearData();
         this.removeEventListener(MouseEvent.MOUSE_OVER,this.MOver);
         this.removeEventListener(MouseEvent.MOUSE_OUT,this.MOut);
      }
      
      public function setIcon(mc01:MovieClip) : *
      {
         var tt:MovieClip = null;
         var mc0:MovieClip = mc01;
         if(this.icon_mc != null)
         {
            this.icon.removeChild(this.icon_mc);
            this.icon_mc = null;
         }
         mc0.stop();
         if(mc0.width - 45 > 10 || mc0.height - 45 > 10)
         {
            tt = mc0;
            tt.width = 45;
            tt.height = 45;
            mc0 = new MovieClip();
            mc0.addChild(tt);
         }
         this.icon_mc = mc0;
         this.icon.addChild(mc0);
         var mc1:* = mc0.getChildByName("shootPoint");
         var mc2:* = mc0.getChildByName("basePoint");
         if(mc1 is MovieClip)
         {
            mc0.removeChild(mc1);
            mc0.removeChild(mc2);
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
      
      public function setText2(str:String) : *
      {
         this.level_txt.text = str;
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
         d0.chipLevelTipB = false;
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
         this.setText(d0.getLevelTitle());
         this.setIcon(icon0);
         this.setState("fill");
         if(this.numB)
         {
            d0.showTipB = false;
            if(this.fastB)
            {
               if(d0.id == "exp_card_directly")
               {
                  this.setText("直接获得经验值");
                  this.setText2(d0.price + "点");
               }
               else if(d0.id == "GCoin_card_4")
               {
                  this.setText("直接获得G币");
                  this.setText2(d0.price + " G币");
               }
               else if(d0.id == "achieve_card_3")
               {
                  this.setText("直接获得功勋值");
                  this.setText2(d0.price + "点");
               }
               else
               {
                  this.setText2(d0.num + "个");
                  d0.showTipB = true;
               }
            }
            else
            {
               this.setText2(d0.num + "个");
               d0.showTipB = true;
            }
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

