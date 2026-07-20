package UI.vip
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class VipGiftBar extends Sprite
   {
      
      public var name_txt:TextField;
      
      public var content_txt:TextField;
      
      public var _btn:SimpleButton;
      
      public var no_btn:MovieClip;
      
      public var btn_txt:TextField;
      
      public var index:int = 0;
      
      public function VipGiftBar()
      {
         super();
         this.no_btn.stop();
         this.btn_txt.mouseEnabled = false;
      }
      
      public function showBtn() : *
      {
         this.no_btn.visible = true;
         this._btn.visible = true;
         this.btn_txt.visible = true;
      }
      
      public function hideBtn() : *
      {
         this.no_btn.visible = false;
         this._btn.visible = false;
         this.btn_txt.visible = false;
      }
      
      public function setUseBtn(useB:Boolean) : *
      {
         this.no_btn.visible = !useB;
         this._btn.visible = useB;
         this.btn_txt.visible = true;
      }
   }
}

