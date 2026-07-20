package UI.helper
{
   import UI.icon.AllIconLoader;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class HelperContextBar extends Sprite
   {
      
      public var index:int = 0;
      
      public var icon_mc:*;
      
      public var title_txt:TextField;
      
      public var _txt:TextField;
      
      public var _btn:SimpleButton;
      
      public var iconLoader:AllIconLoader = new AllIconLoader();
      
      public var define:HelperContextBarDefine = null;
      
      public function HelperContextBar()
      {
         super();
         this.icon_mc.addChild(this.iconLoader);
      }
      
      public function clear() : *
      {
      }
      
      public function inData_byDefine(d0:HelperContextBarDefine) : *
      {
         this.define = d0;
         if(d0.iconLabel == "")
         {
            this.icon_mc.visible = false;
            this._txt.autoSize = "center";
         }
         else
         {
            this._txt.autoSize = "center";
            this.icon_mc.visible = true;
            this.iconLoader.addIcon(d0.iconLabel);
         }
         this.title_txt.htmlText = d0.title;
         this._txt.htmlText = d0.context;
      }
   }
}

