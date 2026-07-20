package org.hell
{
   import flash.display.DisplayObject;
   
   public class Button extends BaseButton
   {
      
      public function Button()
      {
         super();
      }
      
      public function get iconLabel() : IconLabel
      {
         return target as IconLabel;
      }
      
      public function get icon() : DisplayObject
      {
         return this.iconLabel.icon;
      }
      
      public function set icon(param1:DisplayObject) : void
      {
         this.iconLabel.icon = param1;
         invalidate("size");
      }
      
      public function get label() : String
      {
         return this.iconLabel.label;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         target = new IconLabel();
      }
      
      override protected function configStyle() : void
      {
         super.configStyle();
         if(style.labelStyle)
         {
            (target as IconLabel).style = style.labelStyle;
         }
         (target as IconLabel).align = 0;
      }
      
      override protected function drawBackground() : void
      {
         super.drawBackground();
         if(Boolean(style) && Boolean(this.iconLabel))
         {
            if(style.selectedLabelStyle)
            {
               if(selected)
               {
                  this.iconLabel.style = style.selectedLabelStyle;
               }
               else
               {
                  this.iconLabel.style = style.labelStyle;
               }
            }
         }
      }
      
      public function set label(param1:String) : void
      {
         this.iconLabel.label = param1;
         invalidate("size");
      }
   }
}

