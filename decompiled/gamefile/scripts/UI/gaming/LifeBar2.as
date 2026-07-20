package UI.gaming
{
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   
   public class LifeBar2 extends Sprite
   {
      
      public var txt:TextField;
      
      public var nameTxt:TextField;
      
      public var skillTxt:TextField;
      
      public var cover:Sprite;
      
      private var _unitName:String = "";
      
      public var colorType:int = -1;
      
      public var direction:int = 0;
      
      public function LifeBar2()
      {
         super();
         this.mouseChildren = false;
         this.mouseEnabled = false;
      }
      
      public function inData(now:Number, max:Number) : *
      {
         var now0:Number = now;
         if(now < 0)
         {
            now0 = 0;
         }
         else if(now > max)
         {
            now0 = max;
         }
         this.txt.text = String(Math.floor(now0) + "/" + Math.floor(max));
         this.cover.scaleX = now0 / max;
         if(this.direction == 1)
         {
            this.cover.x = 349 - this.cover.width + 5;
         }
      }
      
      public function unitName(str:String, _colorType:int = 0, skillStr:String = "") : *
      {
         var f0:GlowFilter = null;
         this._unitName = str;
         this.skillTxt.text = skillStr;
         this.nameTxt.text = str;
         if(this.colorType != _colorType)
         {
            this.colorType = _colorType;
            f0 = new GlowFilter(5439626,1,3,3,10);
            if(this.colorType == 0)
            {
               f0.color = 6684672;
               this.nameTxt.textColor = 16724991;
            }
            else if(this.colorType == 1)
            {
               f0.color = 255;
               this.nameTxt.textColor = 65535;
            }
            else if(this.colorType == 2)
            {
               f0.color = 10027008;
               this.nameTxt.textColor = 16776960;
            }
            this.nameTxt.filters = [f0];
         }
      }
   }
}

