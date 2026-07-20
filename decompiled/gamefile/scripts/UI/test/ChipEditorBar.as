package UI.test
{
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class ChipEditorBar extends Sprite
   {
      
      public var cover_mc:Sprite;
      
      public var id:String = "";
      
      public var max:Number = 0;
      
      public var cn:String = "";
      
      public var name_txt:TextField;
      
      public var value_txt:TextField;
      
      public var max_txt:TextField;
      
      public var random_btn:SimpleButton;
      
      public var del_btn:SimpleButton;
      
      public var max_btn:SimpleButton;
      
      public function ChipEditorBar()
      {
         super();
         this.cover_mc.mouseChildren = false;
         this.cover_mc.mouseEnabled = false;
         this.cover_mc.alpha = 0;
      }
      
      public function fleshBaseData() : *
      {
         this.name_txt.text = this.cn;
         this.max_txt.text = this.max + "";
      }
      
      public function setValue(value0:Number) : *
      {
         if(value0 < 0)
         {
            value0 = 0;
         }
         else if(value0 >= this.max)
         {
            value0 = this.max - 0.00001;
         }
         if(value0 <= 0)
         {
            this.cover_mc.alpha = 0.8;
         }
         else
         {
            this.cover_mc.alpha = 0;
         }
         this.value_txt.text = value0 + "";
      }
   }
}

