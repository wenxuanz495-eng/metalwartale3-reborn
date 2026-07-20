package prefor
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class Pre918Loader extends Sprite
   {
      
      public static var dimension:Array;
      
      private var barBordeColor:uint = 16344341;
      
      private var barBgColor:uint = 9979956;
      
      private var barColor:uint = 10079334;
      
      private var txtBgColor:uint = 0;
      
      private var barBg:Sprite;
      
      private var bar:Sprite;
      
      private var __width:int = 0;
      
      private var __height:int = 0;
      
      public var preCount:Number = 0;
      
      private var advLoadText:TextField;
      
      private var bgSp:Sprite;
      
      private var txtSp:Sprite;
      
      public function Pre918Loader()
      {
         super();
         this.__width = dimension[0];
         this.__height = dimension[1];
         this.initPre();
         this.txtSp = new Sprite();
         this.txtSp.visible = false;
         var _loc1_:DropShadowFilter = new DropShadowFilter(1,45,0,1,0,0,255,BitmapFilterQuality.HIGH);
         this.advLoadText = new TextField();
         this.advLoadText.mouseEnabled = false;
         this.advLoadText.autoSize = "left";
         this.advLoadText.multiline = false;
         this.advLoadText.selectable = false;
         this.advLoadText.wordWrap = false;
         this.advLoadText.defaultTextFormat = new TextFormat("宋体",14,16777215);
         this.advLoadText.text = "游戏加载中，请稍候....";
         this.advLoadText.mouseEnabled = false;
         this.advLoadText.filters = [_loc1_];
         var _loc2_:int = 10;
         var _loc3_:int = 5;
         this.bgSp = new Sprite();
         this.bgSp.mouseEnabled = false;
         this.bgSp.mouseChildren = false;
         this.bgSp.graphics.beginFill(this.txtBgColor,0.6);
         this.bgSp.graphics.drawRoundRect(0,0,int(this.advLoadText.width + _loc2_ * 2),int(this.advLoadText.height + _loc3_ * 2),15);
         this.bgSp.graphics.endFill();
         this.txtSp.addChild(this.bgSp);
         this.advLoadText.x = this.bgSp.x + _loc2_;
         this.advLoadText.y = this.bgSp.y + _loc3_;
         this.txtSp.addChild(this.advLoadText);
         this.txtSp.x = 10;
         this.txtSp.y = 10;
         addChild(this.txtSp);
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      public function resizeFun(param1:Number, param2:Number) : void
      {
         if(this.txtSp == null || !this.txtSp.visible)
         {
            return;
         }
         this.txtSp.scaleX = param1;
         this.txtSp.scaleY = param2;
         this.txtSp.x = 10;
      }
      
      public function showText() : void
      {
         if(this.txtSp)
         {
            this.txtSp.visible = true;
         }
      }
      
      private function initPre(param1:Event = null) : void
      {
         this.barBg = new Sprite();
         this.barBg.graphics.lineStyle(1,this.barBordeColor);
         this.barBg.graphics.beginFill(this.barBgColor,1);
         this.barBg.graphics.drawRect(0,0,dimension[0] - 20,8);
         this.barBg.graphics.endFill();
         this.barBg.x = 10;
         this.barBg.y = dimension[1] - 18;
         addChild(this.barBg);
         this.bar = new Sprite();
         this.bar.graphics.beginFill(this.barColor,1);
         this.bar.graphics.drawRect(0,0,dimension[0] - 21,7);
         this.bar.graphics.endFill();
         this.bar.x = 11;
         this.bar.y = dimension[1] - 17;
         this.bar.scaleX = 0;
         addChild(this.bar);
      }
      
      public function setText(param1:String) : void
      {
      }
      
      public function _setProgress(param1:Number) : void
      {
         if(this.preCount < param1 && this.preCount <= 1)
         {
            this.bar.scaleX = param1;
            this.preCount = param1;
         }
      }
      
      public function setProgress(param1:uint, param2:uint) : void
      {
         var _loc3_:Number = param1 / param2;
         if(this.preCount < _loc3_ && this.preCount <= 1)
         {
            this.bar.scaleX = _loc3_;
            this.preCount = _loc3_;
         }
      }
   }
}

