package UI.gaming
{
   import UI.icon.ItemsArmsIcon;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import gameAll.data.ArmsItemsData;
   
   public class GamingArmsIcon extends MovieClip
   {
      
      public var numTxt:TextField;
      
      public var light:MovieClip;
      
      public var icon:Sprite;
      
      public var state:String = "";
      
      public var type:int = 0;
      
      public var itemsID:String = "";
      
      public var itemsImgLabel:String = "";
      
      public var site:int = 0;
      
      public var icon_mc:MovieClip;
      
      public var lock_mc:Sprite;
      
      public var energy_bar:Sprite;
      
      public var type_mc:MovieClip;
      
      public function GamingArmsIcon()
      {
         super();
         this.type_mc.stop();
         this.stop();
         this.light.stop();
         this.mouseChildren = false;
         this.mouseEnabled = false;
      }
      
      public function setState(_state:String) : *
      {
         this.state = _state;
         if(this.state == "fill")
         {
            this.lock_mc.visible = false;
            this.icon.visible = true;
            this.type_mc.visible = true;
         }
         else if(this.state == "blank")
         {
            this.lock_mc.visible = false;
            this.icon.visible = false;
            this.type_mc.visible = false;
         }
         else if(this.state == "lock")
         {
            this.icon.visible = false;
            this.lock_mc.visible = true;
            this.type_mc.visible = false;
         }
      }
      
      public function setEnergy(value:Number) : *
      {
         if(value < 0)
         {
            value = 0;
         }
         else if(value > 1)
         {
            value = 1;
         }
         this.energy_bar.scaleX = value;
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
      
      public function inData_byItems(id0:ArmsItemsData) : *
      {
         if(id0 is ArmsItemsData)
         {
            this.clearData();
            this.itemsID = id0.id;
            this.itemsImgLabel = id0.imgLabel;
            this.type_mc.gotoAndStop(id0.define.attackType);
            this.setIcon(Game.swfLoaderManager.getResource("",id0.imgLabel));
            this.setState("fill");
         }
         else
         {
            this.setState("blank");
         }
      }
      
      public function inData_byMe(id0:ItemsArmsIcon) : *
      {
         this.itemsID = id0.itemsID;
         if(this.itemsID != "")
         {
            this.clearData();
            this.itemsImgLabel = id0.itemsImgLabel;
            this.setIcon(Game.swfLoaderManager.getResource("",this.itemsImgLabel));
            this.setState("fill");
         }
         else
         {
            this.setState("blank");
         }
      }
      
      public function clearData() : *
      {
         this.itemsID = "";
         this.itemsImgLabel = "";
         if(this.icon_mc != null)
         {
            this.icon.removeChild(this.icon_mc);
            this.icon_mc = null;
         }
         this.setState("blank");
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
         mc0.x = -rect0.x - rect0.width;
         mc0.y = -rect0.y - rect0.height / 2;
      }
      
      public function show() : *
      {
         this.visible = true;
         this.alpha = 1;
         this.light.gotoAndPlay(2);
      }
      
      public function showAlpha() : *
      {
         this.visible = true;
         this.alpha = 0.7;
         this.light.gotoAndStop(1);
      }
      
      public function hide() : *
      {
         this.visible = false;
      }
   }
}

