package UI.icon
{
   import body.hero.CarDefine;
   import body.hurt.HurtCount;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import gameAll.data.CarItemsData;
   
   public class ItemsCarIcon extends Sprite
   {
      
      public var nameTxt:TextField;
      
      public var icon:Sprite;
      
      public var back:MovieClip;
      
      public var icon_mc:MovieClip;
      
      private var _actived:Boolean = true;
      
      public var state:String = "";
      
      public var itemsID:String = "";
      
      public var itemsImgLabel:String = "";
      
      public var site:int = 0;
      
      public var type2:String = "arms";
      
      public var itemsData:*;
      
      public var type:int = 0;
      
      public var mouse_mc:Sprite;
      
      public var type_mc:MovieClip;
      
      public function ItemsCarIcon()
      {
         super();
         this.type_mc.stop();
         this.buttonMode = true;
         this.back.stop();
         this.mouseEnabled = true;
         this.mouseChildren = false;
         this.addEventListener(MouseEvent.MOUSE_OVER,this.MOver);
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.MDown);
         this.addEventListener(MouseEvent.MOUSE_UP,this.MUp);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.MOut);
         this.setState("blank");
      }
      
      public function setState(_state:String) : *
      {
         this.state = _state;
         if(this.state == "fill")
         {
            this.iconReturn();
         }
         else if(this.state == "blank")
         {
            this.iconLeave();
         }
      }
      
      public function setAttackType(str0:String) : *
      {
         this.type_mc.gotoAndStop(str0);
      }
      
      public function setNum(str:String) : *
      {
      }
      
      public function setType(_type:int) : *
      {
         this.type = _type;
         if(this.type != 0)
         {
            if(this.type != 1)
            {
               if(this.type != 2)
               {
                  if(this.type == 3)
                  {
                  }
               }
            }
         }
      }
      
      public function iconLeave() : *
      {
         this.nameTxt.visible = false;
         this.icon.visible = false;
         this.type_mc.visible = false;
      }
      
      public function iconReturn() : *
      {
         this.nameTxt.visible = true;
         this.icon.visible = true;
         this.type_mc.visible = true;
      }
      
      public function inData_byItems(id0:CarItemsData) : *
      {
         this.itemsData = id0;
         this.itemsID = id0.id;
         this.nameTxt.text = id0.getDefine().name;
         this.site = id0.site;
         this.itemsImgLabel = id0.imgLabel;
         this.setIcon(Game.swfLoaderManager.getResource("",id0.imgLabel));
         this.setState("fill");
         this.setAttackType(HurtCount.getDefenceLabel(id0.getDefenceType()));
      }
      
      public function inData_byDefine(id0:CarDefine) : *
      {
         this.itemsData = id0;
         this.itemsID = id0.id;
         this.nameTxt.text = id0.name;
         this.site = 0;
         this.itemsImgLabel = id0.imgLabel;
         this.setIcon(Game.swfLoaderManager.getResource("car",id0.imgLabel + "_items"));
         this.setState("fill");
         this.setAttackType(HurtCount.getDefenceLabel(id0.defenceType));
      }
      
      public function inData_byMe(id0:ItemsCarIcon) : *
      {
         this.itemsData = id0.itemsData;
         this.itemsID = id0.itemsID;
         this.nameTxt.text = id0.nameTxt.text;
         this.itemsImgLabel = id0.itemsImgLabel;
         this.setIcon(Game.swfLoaderManager.getResource("",this.itemsImgLabel));
         this.setState("fill");
         this.setAttackType(HurtCount.getDefenceLabel(this.itemsData.getDefine().defenceType));
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
         mc0.y = -rect0.y - rect0.height;
      }
      
      public function clearData() : *
      {
         this.itemsID = "";
         this.itemsImgLabel = "";
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
            this.goLabel("no");
         }
      }
      
      public function get actived() : Boolean
      {
         return this._actived;
      }
      
      protected function goLabel(str:String) : *
      {
         this.back.gotoAndStop(str);
      }
      
      protected function MOver(event:MouseEvent) : *
      {
         this.goLabel("over");
      }
      
      protected function MOut(event:MouseEvent) : *
      {
         this.goLabel("normal");
      }
      
      protected function MDown(event:MouseEvent) : *
      {
         this.goLabel("down");
      }
      
      protected function MUp(event:MouseEvent) : *
      {
         this.goLabel("normal");
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

