package UI.items
{
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import goods.GoodsDefine;
   import items.ItemsDefine;
   
   public class ItemsIcon extends Sprite
   {
      
      private var _actived:Boolean = true;
      
      public var back:MovieClip;
      
      public var icon:Sprite;
      
      public var num_mc:*;
      
      public var label:String = "normal";
      
      public var icon_mc:MovieClip;
      
      public var text:String = "return";
      
      public var site:int = 0;
      
      public var index:int = 0;
      
      public var state:String = "";
      
      public var itemsData:* = null;
      
      public var condition_icon:MovieClip;
      
      public var new_mc:Sprite;
      
      public var affix_txt:TextField;
      
      public var mouse_mc:Sprite;
      
      public var showRandomB:Boolean = false;
      
      public function ItemsIcon()
      {
         super();
         this.init();
      }
      
      public function init() : *
      {
         this.new_mc.visible = false;
         this.condition_icon.visible = false;
         this.buttonMode = true;
         this.back.stop();
         this.mouseEnabled = true;
         this.mouseChildren = false;
         this.addEventListener(MouseEvent.MOUSE_OVER,this.MOver);
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.MDown);
         this.addEventListener(MouseEvent.MOUSE_UP,this.MUp);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.MOut);
         this.condition_icon.stop();
         this.setNum(1);
         this.setState("blank");
      }
      
      public function setCondition(num:int = 0) : *
      {
         if(num == 0)
         {
            this.condition_icon.visible = false;
         }
         else
         {
            this.condition_icon.visible = true;
            this.condition_icon.gotoAndStop(num);
         }
      }
      
      public function setState(_state:String) : *
      {
         this.state = _state;
         if(this.state == "fill")
         {
            this.actived = true;
            this.iconReturn();
         }
         else if(this.state == "blank")
         {
            this.actived = true;
            this.iconLeave();
         }
         else if(this.state == "lock")
         {
            this.icon.visible = false;
            this.gotoLabel("no");
         }
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
         this.removeEventListener(MouseEvent.MOUSE_DOWN,this.MDown);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.MUp);
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
         var rect0:Rectangle = mc0.getRect(mc0);
         mc0.x = -rect0.x - rect0.width / 2;
         mc0.y = -rect0.y - rect0.height / 2;
      }
      
      public function setText(str:String) : *
      {
         this.text = str;
      }
      
      public function setNum(num:int) : *
      {
         this.num_mc.txt.text = String(num);
         if(num <= 1)
         {
            this.num_mc.visible = false;
         }
         else
         {
            this.num_mc.visible = true;
         }
         this.num_mc.y = 44.5;
      }
      
      public function setNum2(num:int) : *
      {
         this.num_mc.txt.text = num + "级";
         if(num <= 0)
         {
            this.num_mc.visible = false;
         }
         else
         {
            this.num_mc.visible = true;
         }
         this.num_mc.y = 12;
      }
      
      public function setNumHtmlText(str:*) : *
      {
         this.num_mc.txt.htmlText = str;
      }
      
      public function iconLeave() : *
      {
         this.icon.visible = false;
         this.num_mc.visible = false;
      }
      
      public function iconReturn() : *
      {
         this.icon.visible = true;
         if(int(this.num_mc.txt.text) > 1)
         {
            this.num_mc.visible = true;
         }
      }
      
      public function inData_byItems(obj:*) : *
      {
         var temp:* = undefined;
         var mc:MovieClip = null;
         var bit:Bitmap = null;
         if(!obj.hasOwnProperty("affixLevel"))
         {
            this.clearData();
            this.setState("blank");
         }
         else
         {
            this.itemsData = obj;
            this.site = obj.site;
            this.setNum(obj.nowNum);
            this.new_mc.visible = obj.newB;
            temp = Game.swfLoaderManager.getResource("",obj.imgLabel);
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
            if(obj.getDefine().name == "research_upgrade_card")
            {
               mc.transform.colorTransform = new ColorTransform(0.35,0.65,1.35,1,15,10,80,0);
            }
            else if(obj.getDefine().name == "elite_challenge_card")
            {
               mc.transform.colorTransform = new ColorTransform(1.15,0.45,1.35,1,35,0,65,0);
            }
            this.setState("fill");
            this.setIcon(mc);
            if(Boolean(obj) && obj.type == "chip")
            {
               this.setNum2(obj.affixLevel + 1);
            }
         }
      }
      
      public function inData_byDefine(d0:ItemsDefine) : *
      {
         var mc:MovieClip = null;
         var bit:Bitmap = null;
         this.itemsData = d0;
         this.setNum(d0.nowNum);
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
         if(d0.name == "research_upgrade_card")
         {
            mc.transform.colorTransform = new ColorTransform(0.35,0.65,1.35,1,15,10,80,0);
         }
         else if(d0.name == "elite_challenge_card")
         {
            mc.transform.colorTransform = new ColorTransform(1.15,0.45,1.35,1,35,0,65,0);
         }
         var icon0:MovieClip = mc;
         this.setState("fill");
         this.setIcon(icon0);
      }
      
      public function inData_byGoodsDefine(d0:GoodsDefine, firstB:Boolean = false) : *
      {
         var mc:MovieClip = null;
         var bit:Bitmap = null;
         if(firstB && d0.getFastUseB())
         {
            d0.specialType = d0.price + "";
         }
         this.itemsData = d0;
         this.setNum(d0.num);
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
         if(d0.id == "mcoin_reward_card")
         {
            mc.transform.colorTransform = new ColorTransform(1.25,0.7,0.15,1,60,22,0,0);
         }
         this.setState("fill");
         this.setIcon(mc);
      }
      
      private function showAffixLevel(lv0:int) : *
      {
      }
      
      public function inData_byMe(obj:ItemsIcon) : *
      {
      }
      
      public function setMustNum(nowNum0:int, mustNum0:int) : *
      {
         this.num_mc.visible = true;
         var color0:String = "#66FF00";
         if(mustNum0 > nowNum0)
         {
            color0 = "#FF6600";
         }
         this.setNumHtmlText(nowNum0 + "/" + "<font color=\'" + color0 + "\'>" + mustNum0 + "</font>");
         this.num_mc.txt.width = 60;
         this.num_mc.txt.x = -this.num_mc.txt.width;
         this.num_mc.txt.y = -this.num_mc.txt.height;
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
         this.gotoLabel("over");
      }
      
      protected function MOut(event:MouseEvent) : *
      {
         this.gotoLabel("normal");
      }
      
      protected function MDown(event:MouseEvent) : *
      {
         this.gotoLabel("down");
      }
      
      protected function MUp(event:MouseEvent) : *
      {
         this.gotoLabel("over");
      }
      
      override public function get width() : Number
      {
         if(Boolean(this.mouse_mc))
         {
            return this.mouse_mc.width;
         }
         return super.width;
      }
      
      override public function get height() : Number
      {
         if(Boolean(this.mouse_mc))
         {
            return this.mouse_mc.height;
         }
         return super.height;
      }
   }
}

