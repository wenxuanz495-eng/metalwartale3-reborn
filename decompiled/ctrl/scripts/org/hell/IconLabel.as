package org.hell
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class IconLabel extends Component
   {
      
      public static const CENTER:uint = 0;
      
      public static const TOP:uint = 3;
      
      public static const LEFT:uint = 1;
      
      public static const BOTTOM:uint = 4;
      
      public static const RIGHT:uint = 2;
      
      protected var _tf:TextFormat;
      
      protected var _textField:TextField;
      
      protected var _label:String;
      
      protected var txtPad:Number = 2;
      
      protected var _icon:DisplayObject;
      
      private var _align:uint = 1;
      
      private var _iconAlign:uint = 1;
      
      public function IconLabel()
      {
         super();
      }
      
      public function get align() : uint
      {
         return this._align;
      }
      
      public function set align(param1:uint) : void
      {
         this._align = param1;
         invalidate("size");
      }
      
      public function set iconAlign(param1:uint) : void
      {
         this._iconAlign = param1;
         invalidate("size");
      }
      
      public function get iconAlign() : uint
      {
         return this._iconAlign;
      }
      
      public function get actualWidth() : Number
      {
         return (this.textField ? this.textField.width : 0 + this.txtPad) + (this.icon ? this.icon.width : 0);
      }
      
      public function get label() : String
      {
         return this._label;
      }
      
      public function set label(param1:String) : void
      {
         this._label = param1;
         if(this._tf)
         {
            this.textField.defaultTextFormat = this._tf;
         }
         this.textField.text = this._label;
         invalidate("size");
      }
      
      public function get icon() : *
      {
         return this._icon;
      }
      
      public function set icon(param1:*) : void
      {
         if(param1 is Class)
         {
            param1 = new param1();
         }
         this._icon = param1;
         addChild(this._icon);
         invalidate("size");
      }
      
      public function get textField() : TextField
      {
         return this._textField;
      }
      
      public function set textField(param1:TextField) : void
      {
         if(param1)
         {
            if(this._textField)
            {
               this._textField.parent.removeChild(this._textField);
               if(this._textField.text)
               {
                  param1.text = this._textField.text;
               }
               param1.x = this._textField.x;
               param1.y = this._textField.y;
               param1.width = this._textField.width;
               param1.height = this._textField.height;
            }
            this._textField = param1;
            addChild(this._textField);
         }
      }
      
      protected function drawLayout() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:* = undefined;
         if(this.icon == null && this.textField == null)
         {
            return;
         }
         _loc1_ = this.icon == null ? TOP : this.iconAlign;
         this.textField.height = this.textField.textHeight + 4;
         _loc2_ = this.textField.textWidth + 4;
         _loc3_ = this.textField.textHeight + 4;
         _loc4_ = this.icon == null ? 0 : this.icon.width + this.txtPad;
         _loc5_ = this.icon == null ? 0 : this.icon.height + this.txtPad;
         this.textField.visible = Boolean(this.label) && this.label.length > 0;
         if(this.icon != null)
         {
            this.icon.x = Math.round((width - this.icon.width) / 2);
            this.icon.y = Math.round((height - this.icon.height) / 2);
         }
         _loc8_ = 0;
         if(this.textField.visible == false)
         {
            this.textField.width = 0;
            this.textField.height = 0;
         }
         else if(_loc1_ == BOTTOM || _loc1_ == TOP)
         {
            _loc6_ = Math.max(0,Math.min(_loc2_,width - 2 * this.txtPad));
            if(height - 2 > _loc3_)
            {
               _loc7_ = _loc3_;
            }
            else
            {
               _loc7_ = height - 2;
            }
            _loc8_ = this.align == CENTER ? Math.round((width - _loc2_) / 2) : (this.align == LEFT ? this.txtPad : width - _loc2_ - this.txtPad);
            _loc2_ = _loc6_;
            this.textField.width = _loc2_;
            _loc3_ = _loc7_;
            this.textField.height = _loc3_;
            this.textField.x = _loc8_;
            this.textField.y = Math.round((height - this.textField.height - _loc5_) / 2 + (_loc1_ == TOP) ? _loc5_ : 0);
            this.textField.y += 5;
            if(this.icon != null)
            {
               this.icon.y = Math.round(_loc1_ == TOP ? this.textField.y - _loc5_ : this.textField.y + this.textField.height + this.txtPad);
               if(this.align == LEFT)
               {
                  this.icon.x = this.textField.x;
               }
               else if(this.align == RIGHT)
               {
                  this.icon.x = this.textField.x + this.textField.width - this.icon.width;
               }
            }
         }
         else
         {
            _loc2_ = _loc6_ = Math.max(0,Math.min(_loc2_,width - _loc4_ - 2 * this.txtPad));
            this.textField.width = _loc2_;
            _loc8_ = this.align == CENTER ? (width - _loc2_ - _loc4_) / 2 : (this.align == LEFT ? this.txtPad : width - _loc2_ - _loc4_ - this.txtPad);
            this.textField.x = Math.round(_loc8_ + (_loc1_ != RIGHT) ? _loc4_ : 0);
            this.textField.y = Math.round((height - this.textField.height) / 2);
            if(this.icon != null)
            {
               this.icon.x = Math.round(_loc1_ != RIGHT ? this.textField.x - _loc4_ : this.textField.x + _loc2_ + this.txtPad);
            }
         }
      }
      
      override protected function configStyle() : void
      {
         var _loc1_:* = undefined;
         if(!this.textField)
         {
            this.initView();
         }
         if(style.icon != undefined)
         {
            this.icon = style.icon;
         }
         if(style.textFieldStyle)
         {
            for(_loc1_ in style.textFieldStyle)
            {
               this.textField[_loc1_] = style.textFieldStyle[_loc1_];
            }
         }
         this._tf = this.textField.defaultTextFormat;
         if(style.textFormatStyle)
         {
            for(_loc1_ in style.textFormatStyle)
            {
               this._tf[_loc1_] = style.textFormatStyle[_loc1_];
            }
         }
         if(this.label)
         {
            this.label = this.label;
         }
      }
      
      override protected function draw() : void
      {
         if(isInvalid("size"))
         {
            this.drawLayout();
         }
         super.draw();
      }
      
      protected function initView() : void
      {
         this.textField = (new style.textFieldHolderClass() as DisplayObjectContainer).getChildAt(0) as TextField;
         this.textField.selectable = false;
         this.textField.multiline = false;
         this.textField.wordWrap = false;
         this.textField.autoSize = "left";
         this.textField.text = "";
         this.align = 1;
      }
   }
}

