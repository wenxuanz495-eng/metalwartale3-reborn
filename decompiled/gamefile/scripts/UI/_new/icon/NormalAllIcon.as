package UI._new.icon
{
   import body.hero.CarDefine;
   import body.hurt.HurtCount;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import gameAll.data.ArmsItemsData;
   import gameAll.data.CarItemsData;
   import gameAll.data.GoodsItemsData;
   import gameAll.data.car.CarDataCreator;
   
   public class NormalAllIcon extends Sprite
   {
      
      protected var _actived:Boolean = true;
      
      public var index:int = 0;
      
      public var itemsData:* = null;
      
      public var state:String = "";
      
      public var text:String = "";
      
      public var iconType:String = "arms_icon";
      
      private var sp:MovieClip = null;
      
      private var icon_mc:Sprite;
      
      protected var icon_con:Sprite;
      
      protected var mouse_mc:Sprite;
      
      protected var new_mc:Sprite;
      
      protected var name_txt:TextField;
      
      protected var num_txt:TextField;
      
      protected var type_mc:MovieClip;
      
      protected var lock_mc:MovieClip;
      
      public var showNumEverB:Boolean = false;
      
      private var mc_arr:Array = ["icon_con","name_txt","num_txt","type_mc","lock_mc","new_mc","mouse_mc"];
      
      private var fill_arr:Array = ["icon_con","name_txt","num_txt","type_mc","mouse_mc"];
      
      private var blank_arr:Array = ["mouse_mc"];
      
      private var lock_arr:Array = ["lock_mc","mouse_mc"];
      
      private var _firstinit:Boolean = false;
      
      private var _numY:Number = 0;
      
      public function NormalAllIcon()
      {
         super();
         this.buttonMode = true;
         this.mouseEnabled = true;
         this.mouseChildren = false;
         this.addEvent();
      }
      
      public function setMaterial(type0:String) : *
      {
         var n:* = undefined;
         var name0:String = null;
         this.iconType = type0;
         var sp0:* = Game.swfLoaderManager.getResource("newui",this.iconType);
         if(Boolean(this.sp))
         {
            if(Boolean(this.sp.parent))
            {
               this.removeChild(this.sp);
            }
         }
         this.sp = sp0;
         this.sp.stop();
         addChild(this.sp);
         for(n in this.mc_arr)
         {
            name0 = this.mc_arr[n];
            this[name0] = this.sp.getChildByName(name0);
            if(this[name0] is MovieClip)
            {
               this[name0].stop();
            }
         }
         this.setState("blank");
      }
      
      public function setText(str0:String) : *
      {
         this.text = str0;
         if(this.sp.hasOwnProperty("name_txt"))
         {
            this.sp.name_txt.htmlText = str0;
         }
      }
      
      public function setIcon(mc0:MovieClip) : *
      {
         if(Boolean(this.icon_mc))
         {
            this.icon_con.removeChild(this.icon_mc);
            this.icon_mc = null;
         }
         this.icon_mc = mc0;
         mc0.stop();
         this.icon_con.addChild(mc0);
         var mc1:* = mc0.getChildByName("shootPoint");
         var mc2:* = mc0.getChildByName("basePoint");
         if(mc1 is MovieClip)
         {
            mc0.removeChild(mc1);
            mc0.removeChild(mc2);
         }
         var rect0:Rectangle = mc0.getRect(mc0);
         mc0.x = -rect0.x - rect0.width / 2;
         if(this.iconType == "car_icon")
         {
            mc0.y = -rect0.y - rect0.height;
         }
         else
         {
            mc0.y = -rect0.y - rect0.height / 2;
         }
      }
      
      public function getIcon() : *
      {
         return this.icon_con;
      }
      
      public function iconLeave() : *
      {
         this.icon_con.visible = false;
      }
      
      public function iconReturn() : *
      {
         this.icon_con.visible = true;
      }
      
      public function setNum(str0:*) : *
      {
         if(Boolean(this.num_txt))
         {
            this.num_txt.visible = int(str0) > 1;
            this.num_txt.text = String(str0);
            if(this._firstinit == false)
            {
               this._firstinit = true;
               this._numY = this.num_txt.y;
            }
            this.num_txt.y = this._numY;
         }
      }
      
      public function setNum2(str0:*) : *
      {
         if(Boolean(this.num_txt))
         {
            this.num_txt.visible = int(str0) > 0;
            this.num_txt.text = String(str0 + "级");
            this.num_txt.y = 0;
         }
      }
      
      public function setAttackType(str0:String) : *
      {
         try
         {
            if(Boolean(this.type_mc))
            {
               this.type_mc.gotoAndStop(str0);
            }
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      public function setBack(str0:String) : *
      {
         this.sp.gotoAndStop(str0);
         if(Boolean(this.lock_mc))
         {
            if(this.lock_mc.totalFrames > 1)
            {
               this.lock_mc.gotoAndStop(str0);
            }
         }
      }
      
      public function setNew(bb0:Boolean) : *
      {
         if(Boolean(this.new_mc))
         {
            this.new_mc.visible = bb0;
         }
      }
      
      public function setState(_state:String) : *
      {
         var n:* = undefined;
         var name0:String = null;
         this.state = _state;
         var s_arr0:Array = this[this.state + "_arr"];
         for(n in this.mc_arr)
         {
            name0 = this.mc_arr[n];
            if(Boolean(this[name0]))
            {
               this[name0].visible = s_arr0.indexOf(name0) >= 0;
            }
         }
         if(this.showNumEverB)
         {
            if(Boolean(this.num_txt))
            {
               this.num_txt.visible = true;
            }
         }
         if(this.state != "fill")
         {
            this.itemsData = null;
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
      
      public function addEvent() : *
      {
         this.addEventListener(MouseEvent.MOUSE_OVER,this.MOver);
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.MDown);
         this.addEventListener(MouseEvent.MOUSE_UP,this.MUp);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.MOut);
      }
      
      public function clearEvent() : *
      {
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
            if(this.sp.currentLabel == "no")
            {
               this.setBack("normal");
            }
         }
         else
         {
            this.mouseEnabled = false;
            this.setBack("no");
         }
      }
      
      public function get actived() : Boolean
      {
         return this._actived;
      }
      
      protected function MOver(event:MouseEvent) : *
      {
         if(this.actived)
         {
            this.setBack("over");
         }
      }
      
      protected function MOut(event:MouseEvent) : *
      {
         if(this.actived)
         {
            this.setBack("normal");
         }
      }
      
      protected function MDown(event:MouseEvent) : *
      {
         if(this.actived)
         {
            this.setBack("down");
         }
      }
      
      protected function MUp(event:MouseEvent) : *
      {
         if(this.actived)
         {
            this.setBack("over");
         }
      }
      
      public function clear() : *
      {
         this.clearEvent();
      }
      
      public function inData_byItemsData(id0:*) : *
      {
         var mc:MovieClip = null;
         var define0:CarDefine = null;
         var carColor0:String = null;
         this.itemsData = id0;
         this.setState("fill");
         var cnstr:String = "" + id0.cnName;
         if(id0 is CarItemsData)
         {
            define0 = (id0 as CarItemsData).getDefine();
            carColor0 = CarDataCreator.getColorColor((id0 as CarItemsData).color);
            if(!carColor0)
            {
               carColor0 = "#FFFFFF";
            }
            if((id0 as CarItemsData).skinB)
            {
               cnstr = "<font color=\'#00FFFF\'>[皮肤] " + define0.name + "</font>";
            }
            else
            {
               cnstr = "<font color=\'" + carColor0 + "\'>" + define0.name + "(" + (id0 as CarItemsData).getNowLevel() + ")" + "</font>";
            }
         }
         this.setText(cnstr);
         var dp:* = Game.swfLoaderManager.getResource("",id0.imgLabel);
         if(!(dp is DisplayObject))
         {
            mc = new MovieClip();
            mc.addChild(new Bitmap(dp));
            dp.x = -dp.width / 2;
            dp.y = -dp.height / 2;
         }
         else
         {
            mc = dp as MovieClip;
         }
         this.setIcon(mc);
         this.setNew(id0.newB);
         if(id0 is CarItemsData)
         {
            this.setAttackType(HurtCount.getDefenceLabel(id0.getDefine().defenceType));
         }
         else if(id0 is ArmsItemsData)
         {
            this.setAttackType(id0.define.attackType);
         }
         else if(id0 is GoodsItemsData)
         {
            this.setNum(id0.nowNum);
         }
         if(Boolean(id0) && id0.type == "chip")
         {
            this.setNum2(id0.affixLevel + 1);
         }
      }
   }
}

