package UI.icon
{
   import body.define.OneArmsDefine;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import gameAll.data.ArmsItemsData;
   import goods.GoodsDefine;
   
   public class ItemsArmsIcon extends MovieClip
   {
      
      public var chooseTip:MovieClip;
      
      private var _numB:Boolean = false;
      
      public var numTxt:TextField;
      
      public var nameTxt:TextField;
      
      public var cover_mc:MovieClip;
      
      public var icon:Sprite;
      
      public var icon_mc:MovieClip;
      
      public var noHave_mc:Sprite;
      
      public var lock_mc:Sprite;
      
      public var nowNum:int = 0;
      
      private var _actived:Boolean = true;
      
      public var state:String = "";
      
      public var state2:String = "";
      
      public var type:int = 0;
      
      public var itemsID:String = "";
      
      public var itemsImgLabel:String = "";
      
      public var index:int = 0;
      
      public var site:int = 0;
      
      public var type2:String = "arms";
      
      public var itemsData:*;
      
      public var testTxt:TextField;
      
      public var new_tip:Sprite;
      
      public var newB:Boolean = false;
      
      public var newLevel:int = -1;
      
      public var realLevel:int = -1;
      
      public var checkUpgradeB:Boolean = false;
      
      public var mouse_mc:Sprite;
      
      public var type_mc:MovieClip;
      
      public function ItemsArmsIcon()
      {
         super();
         this.type_mc.stop();
         this.new_tip.visible = false;
         this.noHave_mc.visible = false;
         this.chooseTip.stop();
         this.lock_mc.visible = false;
         this.cover_mc.stop();
         this.cover_mc.gotoAndStop(1);
         this.buttonMode = true;
         this.stop();
         this.mouseEnabled = true;
         this.mouseChildren = false;
         this.addEventListener(MouseEvent.MOUSE_OVER,this.MOver);
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.MDown);
         this.addEventListener(MouseEvent.MOUSE_UP,this.MUp);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.MOut);
         this.setType(1);
         this.setState("blank");
         this.testTxt.visible = false;
         this.setState2("");
      }
      
      public function dsf(e:*) : *
      {
         var str:String = "";
         str += "site:" + this.site + "\n";
         str += "type:" + this.type + "\n";
         str += "state:" + this.state;
         this.testTxt.text = str;
      }
      
      public function showNew() : *
      {
         this.new_tip.visible = true;
         this.newB = true;
      }
      
      public function hideNew() : *
      {
         this.new_tip.visible = false;
         this.newB = false;
         this.newLevel = this.realLevel;
      }
      
      public function setState2(_state:String) : *
      {
         this.chooseTip.visible = false;
         if(_state == "choose")
         {
            this.chooseTip.visible = true;
         }
         this.state2 = _state;
      }
      
      public function setState(_state:String) : *
      {
         this.state = _state;
         if(this.state == "fill")
         {
            this.lock_mc.visible = false;
            this.actived = true;
            this.iconReturn();
            this.setType(this.type);
            this.type_mc.visible = true;
         }
         else if(this.state == "blank")
         {
            this.lock_mc.visible = false;
            this.actived = true;
            this.iconLeave();
            this.setType(this.type);
            this.type_mc.visible = false;
         }
         else if(this.state == "lock")
         {
            this.icon.visible = false;
            this.gotoAndStop("no");
            this.cover_mc.gotoAndStop(3);
            this.lock_mc.visible = true;
            this.nameTxt.visible = false;
            this.type_mc.visible = false;
         }
      }
      
      public function setType(_type:int) : *
      {
         this.type = _type;
         if(this.type == 0)
         {
            this.cover_mc.visible = true;
            this.numTxt.visible = true;
            this.cover_mc.gotoAndStop(1);
            this.gotoAndStop("normal");
         }
         else if(this.type == 1)
         {
            this.cover_mc.visible = false;
            this.numTxt.visible = false;
            this.gotoAndStop("normal");
         }
         else if(this.type == 2)
         {
            this.numTxt.visible = false;
            this.cover_mc.visible = true;
            this.cover_mc.gotoAndStop(2);
         }
         else if(this.type == 3)
         {
            this.cover_mc.visible = true;
            this.numTxt.visible = true;
            this.cover_mc.gotoAndStop(3);
            this.gotoAndStop("no");
         }
      }
      
      public function setNoHave(bb0:Boolean) : *
      {
         this.noHave_mc.visible = bb0;
         if(bb0)
         {
            this.nameTxt.textColor = 10066329;
         }
         else
         {
            this.nameTxt.textColor = 16777215;
         }
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
      
      public function inData_byItems(id0:*) : *
      {
         this.itemsData = id0;
         this.itemsID = id0.id;
         this.setText(id0.cnName);
         this.type2 = id0.type2;
         this.site = id0.site;
         this.itemsImgLabel = id0.imgLabel;
         this.setIcon(Game.swfLoaderManager.getResource("",id0.imgLabel));
         this.setState("fill");
         if(this.type2 == "temp")
         {
            this.setType(2);
         }
         this.setAttackType(id0.define.attackType);
         if(this.checkUpgradeB)
         {
            this.checkUpgrade();
         }
      }
      
      public function inData_byDefine(d0:OneArmsDefine) : *
      {
         var mc:MovieClip = null;
         var bit:Bitmap = null;
         this.itemsData = d0;
         this.setText(d0.name);
         this.setType(1);
         var temp:* = Game.swfLoaderManager.getResource(d0.father,d0.imgLabel);
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
         this.setIcon(mc);
         this.setState("fill");
         this.setAttackType(d0.attackType);
         if(this.checkUpgradeB)
         {
            this.checkUpgrade();
         }
      }
      
      private function checkUpgrade() : *
      {
         var d0:OneArmsDefine = null;
         var da0:ArmsItemsData = null;
         var str0:String = null;
         this.hideNew();
         if(this.itemsData is ArmsItemsData)
         {
            da0 = this.itemsData;
            d0 = da0.getArmsDefine();
            if(d0.level < d0.maxLevel - 1)
            {
               d0 = Game.defineGroup.getArmsDefine(d0.id,d0.level + 1,d0.father);
            }
            else
            {
               d0 = null;
            }
         }
         else if(this.itemsData is OneArmsDefine)
         {
            d0 = this.itemsData;
            if(d0.index > 50)
            {
               d0 = null;
            }
            else
            {
               str0 = Game.goodsDefineGroup.getBuySite(d0.getLabel());
               if(str0 != "")
               {
                  d0 = null;
               }
            }
         }
         if(Boolean(d0))
         {
            if(Game.gameData.level >= d0.mustLevel - 1)
            {
               this.showNew();
            }
         }
      }
      
      public function inData_byGoodsDefine(d0:GoodsDefine) : *
      {
         this.itemsData = d0;
         this.setText(d0.name);
         this.setType(1);
         this.itemsImgLabel = d0.imgLabel;
         this.setIcon(Game.swfLoaderManager.getResource("",this.itemsImgLabel));
         this.setState("fill");
         this.setAttackType(d0.define.attackType);
      }
      
      public function setAttackType(str0:String) : *
      {
         try
         {
            this.type_mc.gotoAndStop(str0);
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      public function inData_byMe(id0:ItemsArmsIcon) : *
      {
         this.itemsData = id0.itemsData;
         this.type2 = id0.type2;
         this.itemsID = id0.itemsID;
         this.setText(id0.nameTxt.text);
         this.itemsImgLabel = id0.itemsImgLabel;
         this.setIcon(Game.swfLoaderManager.getResource("",this.itemsImgLabel));
         this.setState("fill");
         if(this.type2 == "temp")
         {
            this.setType(2);
         }
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
         if(mc1 is MovieClip)
         {
            mc0.removeChild(mc1);
            mc0.removeChild(mc2);
         }
         var rect0:Rectangle = mc0.getRect(mc0);
         mc0.x = -rect0.x - rect0.width / 2;
         mc0.y = -rect0.y - rect0.height / 2;
      }
      
      public function iconLeave() : *
      {
         this.nameTxt.visible = false;
         this.icon.visible = false;
      }
      
      public function iconReturn() : *
      {
         this.nameTxt.visible = true;
         this.icon.visible = true;
      }
      
      public function setText(str:String) : *
      {
         this.nameTxt.text = str;
      }
      
      public function setNum(str:String) : *
      {
         this.numTxt.text = str;
      }
      
      private function set numB(bb:Boolean) : *
      {
         this._numB = bb;
         if(bb)
         {
            this.numTxt.visible = true;
            this.cover_mc.visible = true;
         }
         else
         {
            this.numTxt.visible = false;
            this.cover_mc.visible = false;
         }
      }
      
      private function get numB() : Boolean
      {
         return this._numB;
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
            this.gotoAndStop("no");
         }
      }
      
      public function setActived(bb:Boolean) : *
      {
         this._actived = bb;
      }
      
      public function get actived() : Boolean
      {
         return this._actived;
      }
      
      protected function MOver(event:MouseEvent) : *
      {
         if(this.actived)
         {
            if(this.type != 3 && this.state != "lock")
            {
               this.gotoAndStop("over");
            }
         }
      }
      
      protected function MOut(event:MouseEvent) : *
      {
         if(this.actived)
         {
            if(this.type != 3 && this.state != "lock")
            {
               this.gotoAndStop("normal");
            }
         }
      }
      
      protected function MDown(event:MouseEvent) : *
      {
         if(this.actived && this.type != 3 && this.state != "lock")
         {
            this.gotoAndStop("down");
         }
      }
      
      protected function MUp(event:MouseEvent) : *
      {
         if(this.actived && this.type != 3 && this.state != "lock")
         {
            this.gotoAndStop("over");
         }
      }
   }
}

