package ctrl4399.view.components.shopModule
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol419")]
   public class DescribeModule extends MovieClip
   {
      
      public var buttomMc:MovieClip;
      
      public var contentMc:MovieClip;
      
      public var dirMc:MovieClip;
      
      public var headMc:MovieClip;
      
      private var minX:int = 5;
      
      private var txt:TextField;
      
      private var xspan:int = 4;
      
      public function DescribeModule()
      {
         super();
         this.mouseChildren = false;
         this.mouseEnabled = false;
         if(this.headMc == null || this.dirMc == null || this.contentMc == null || this.buttomMc == null)
         {
            return;
         }
         this.headMc.x = this.headMc.y = this.contentMc.x = this.buttomMc.x = this.dirMc.y = 0;
         this.contentMc.y = this.headMc.y + this.headMc.height;
         this.buttomMc.y = this.contentMc.y + this.contentMc.height;
         this.dirMc.x = this.minX;
         if(this.txt == null)
         {
            this.txt = this.initNoticeTxt();
         }
         this.txt.x = this.xspan;
         this.txt.y = this.contentMc.y;
         this.addChild(this.txt);
      }
      
      private function initTf() : TextFormat
      {
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.font = "宋体";
         _loc1_.color = 6710886;
         _loc1_.size = 13;
         return _loc1_;
      }
      
      private function initNoticeTxt() : TextField
      {
         var _loc1_:TextField = new TextField();
         _loc1_.width = this.contentMc.width - this.xspan * 2;
         _loc1_.autoSize = TextFieldAutoSize.LEFT;
         _loc1_.mouseEnabled = false;
         _loc1_.mouseWheelEnabled = false;
         _loc1_.selectable = false;
         _loc1_.multiline = true;
         _loc1_.wordWrap = true;
         return _loc1_;
      }
      
      public function setConent(param1:String, param2:TextFormat = null) : void
      {
         if(param2 == null)
         {
            param2 = this.initTf();
         }
         this.txt.text = this.rmSpaceAndLineFlaFun(param1);
         this.txt.setTextFormat(param2);
         var _loc3_:Number = this.contentMc.height;
         this.contentMc.height = this.txt.height;
         this.buttomMc.y = int(this.contentMc.y + this.contentMc.height);
      }
      
      private function rmSpaceAndLineFlaFun(param1:String) : String
      {
         var _loc4_:String = null;
         var _loc2_:String = "";
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1.substring(_loc3_,_loc3_ + 1);
            if(_loc4_ != " " && _loc4_ != "\n")
            {
               _loc2_ += _loc4_;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function setDirX(param1:Number) : void
      {
         if(this.headMc == null || this.dirMc == null)
         {
            return;
         }
         var _loc2_:int = Math.round(param1);
         var _loc3_:int = int(this.headMc.width - this.minX - this.dirMc.width);
         if(_loc2_ < this.minX)
         {
            _loc2_ = this.minX;
         }
         else if(_loc2_ > _loc3_)
         {
            _loc2_ = _loc3_;
         }
         this.dirMc.x = _loc2_;
      }
      
      public function setPos(param1:Number, param2:Number) : void
      {
         this.x = Math.round(param1);
         this.y = Math.round(param2);
      }
   }
}

