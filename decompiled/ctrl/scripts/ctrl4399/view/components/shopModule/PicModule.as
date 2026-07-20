package ctrl4399.view.components.shopModule
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol429")]
   public class PicModule extends MovieClip
   {
      
      public var nTxt:TextField;
      
      public var picMc:MovieClip;
      
      public var waitMc:MovieClip;
      
      private var initName:String = "物品名称";
      
      private var maxLen:uint = 10;
      
      public var itemNum:int = 0;
      
      private var picWid:int = 90;
      
      private var picHei:int = 90;
      
      private var txtMarsk:Shape;
      
      private var canMove:Boolean;
      
      private var txtSpan:int = -1;
      
      private var moveId:int = -1;
      
      public function PicModule()
      {
         super();
         this.mouseChildren = false;
         this.buttonMode = true;
         this.focusRect = false;
         if(this.contains(this.waitMc))
         {
            removeChild(this.waitMc);
         }
         if(this.picMc.contains(this.picMc.maskWordMc))
         {
            this.picMc.removeChild(this.picMc.maskWordMc);
         }
         this.nTxt.multiline = false;
         this.nTxt.wordWrap = false;
         if(this.txtMarsk == null)
         {
            this.txtMarsk = new Shape();
         }
         this.txtMarsk.graphics.clear();
         this.txtMarsk.graphics.beginFill(0,1);
         this.txtMarsk.graphics.drawRect(0,0,this.nTxt.width + 1,this.nTxt.height + 1);
         this.txtMarsk.graphics.endFill();
         --this.nTxt.x;
         --this.nTxt.y;
         addChild(this.txtMarsk);
         this.nTxt.mask = this.txtMarsk;
      }
      
      private static function setCenter(param1:Number, param2:Number, param3:Number, param4:Number, param5:Boolean = false) : Array
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         if(param1 <= param3 && param2 <= param4 && !param5)
         {
            _loc6_ = param1;
            _loc7_ = param2;
            _loc8_ = 1;
         }
         else if(param1 / param3 > param2 / param4)
         {
            _loc8_ = param3 / param1;
            _loc6_ = param3;
            _loc7_ = _loc8_ * param2;
         }
         else
         {
            _loc8_ = param4 / param2;
            _loc6_ = _loc8_ * param1;
            _loc7_ = param4;
         }
         return [_loc6_,_loc7_,_loc8_];
      }
      
      private static function checkspace(param1:String) : String
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:String = "";
         var _loc3_:String = param1;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(_loc3_.charAt(_loc4_) != " ")
            {
               break;
            }
            _loc6_ = _loc4_ + 1;
            while(_loc6_ < _loc3_.length)
            {
               _loc2_ += _loc3_.charAt(_loc6_);
               _loc6_++;
            }
            _loc3_ = _loc2_;
            _loc2_ = "";
            _loc4_ = -1;
            _loc4_++;
         }
         var _loc5_:* = int(_loc3_.length - 1);
         while(_loc5_ >= 0)
         {
            if(_loc3_.charAt(_loc5_) != " ")
            {
               break;
            }
            _loc7_ = 0;
            while(_loc7_ < _loc5_)
            {
               _loc2_ += _loc3_.charAt(_loc7_);
               _loc7_++;
            }
            _loc3_ = _loc2_;
            _loc2_ = "";
            _loc5_--;
         }
         return _loc3_;
      }
      
      public function setPicFun(param1:String, param2:String) : void
      {
         if(checkspace(param2) == "")
         {
            this.setNameFun(this.initName);
         }
         else
         {
            this.setNameFun(param2);
         }
         this.loadPic(param1);
      }
      
      public function getBitMap(param1:DisplayObject, param2:int, param3:int) : Bitmap
      {
         var bd:BitmapData;
         var bm:Bitmap = null;
         var _mc:DisplayObject = param1;
         var _wid:int = param2;
         var _hei:int = param3;
         if(_mc == null)
         {
            return null;
         }
         bd = new BitmapData(_wid,_hei,true,0);
         try
         {
            bd.draw(_mc,null,null,null,new Rectangle(0,0,_wid,_hei));
            bm = new Bitmap(bd,"auto");
         }
         catch(e:*)
         {
            bm = null;
         }
         return bm;
      }
      
      public function getPicBitMap() : Bitmap
      {
         var bd:BitmapData;
         var bm:Bitmap = null;
         if(this.picMc == null)
         {
            return null;
         }
         bd = new BitmapData(this.picMc.width,this.picMc.height,true,0);
         try
         {
            bd.draw(this.picMc,null,null,null,new Rectangle(0,0,this.picMc.width,this.picMc.height));
            bm = new Bitmap(bd,"auto");
         }
         catch(e:*)
         {
            bm = null;
         }
         return bm;
      }
      
      public function addPicAndNameFun(param1:DisplayObject, param2:String) : void
      {
         if(checkspace(param2) == "")
         {
            this.setNameFun(this.initName);
         }
         else
         {
            this.setNameFun(param2);
         }
         if(this.picMc == null || param1 == null)
         {
            return;
         }
         this.picMc.addChild(param1);
      }
      
      private function loadPic(param1:String) : void
      {
         var _loc2_:String = checkspace(param1);
         if(_loc2_ == "")
         {
            if(this.picMc.contains(this.picMc.maskWordMc))
            {
               this.picMc.removeChild(this.picMc.maskWordMc);
            }
            return;
         }
         var _loc3_:Loader = new Loader();
         _loc3_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.errorHandler);
         _loc3_.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.errorHandler);
         _loc3_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onCompletedHandler);
         _loc3_.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.onProgressHandler);
         _loc3_.load(new URLRequest(_loc2_),new LoaderContext(true));
         _loc3_.visible = false;
         if(this.picMc != null)
         {
            this.picMc.addChild(_loc3_);
         }
      }
      
      private function errorHandler(param1:Event) : void
      {
         trace("图片加载出错了，" + param1.type);
         this.removeEvent(LoaderInfo(param1.target));
         if(this.contains(this.waitMc))
         {
            removeChild(this.waitMc);
         }
         if(this.picMc.contains(this.picMc.maskWordMc))
         {
            this.picMc.removeChild(this.picMc.maskWordMc);
         }
      }
      
      private function onCompletedHandler(param1:Event) : void
      {
         var _loc3_:Array = null;
         this.removeEvent(LoaderInfo(param1.target));
         if(this.contains(this.waitMc))
         {
            removeChild(this.waitMc);
         }
         if(LoaderInfo(param1.target) == null)
         {
            if(this.picMc.contains(this.picMc.maskWordMc))
            {
               this.picMc.removeChild(this.picMc.maskWordMc);
            }
            return;
         }
         var _loc2_:Loader = LoaderInfo(param1.target).loader;
         if(_loc2_ == null)
         {
            if(this.picMc.contains(this.picMc.maskWordMc))
            {
               this.picMc.removeChild(this.picMc.maskWordMc);
            }
            return;
         }
         if(!this.picMc.contains(this.picMc.maskWordMc))
         {
            this.picMc.addChild(this.picMc.maskWordMc);
            this.picMc.swapChildren(_loc2_,this.picMc.maskWordMc);
         }
         _loc2_.visible = true;
         if(_loc2_.width > this.picWid || _loc2_.height > this.picHei)
         {
            _loc3_ = setCenter(_loc2_.width,_loc2_.height,this.picWid,this.picHei,true);
            _loc2_.width = _loc3_[0];
            _loc2_.height = _loc3_[1];
            _loc3_ = null;
         }
         _loc2_.x = int((this.picWid - _loc2_.width) * 0.5);
         _loc2_.y = int((this.picHei - _loc2_.height) * 0.5);
      }
      
      private function onProgressHandler(param1:ProgressEvent) : void
      {
         if(!this.contains(this.waitMc))
         {
            addChild(this.waitMc);
         }
      }
      
      private function removeEvent(param1:LoaderInfo) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener(IOErrorEvent.IO_ERROR,this.errorHandler);
         param1.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.errorHandler);
         param1.removeEventListener(Event.COMPLETE,this.onCompletedHandler);
         param1.removeEventListener(ProgressEvent.PROGRESS,this.onProgressHandler);
      }
      
      private function setNameFun(param1:String) : void
      {
         param1 = checkspace(param1);
         if(param1 == "")
         {
            return;
         }
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeMultiByte(param1,"gb2312");
         _loc2_.position = 0;
         if(_loc2_.length > this.maxLen)
         {
            this.nTxt.autoSize = "left";
            this.canMove = true;
         }
         else
         {
            this.nTxt.autoSize = "center";
         }
         _loc2_ = null;
         this.nTxt.text = param1;
      }
      
      public function startMoveTxtFun() : void
      {
         if(!this.canMove)
         {
            return;
         }
         if(this.moveId == -1)
         {
            this.moveId = setInterval(this.moveTxtFun,100);
         }
      }
      
      public function stopMoveTxtFun() : void
      {
         if(!this.canMove)
         {
            return;
         }
         if(this.moveId != -1)
         {
            clearInterval(this.moveId);
         }
         this.moveId = -1;
         this.nTxt.x = this.txtMarsk.x + 1;
      }
      
      private function moveTxtFun() : void
      {
         if(this.txtSpan < 0 && this.nTxt.x + this.nTxt.width <= this.txtMarsk.x + this.txtMarsk.width)
         {
            this.txtSpan *= -1;
         }
         else if(this.txtSpan > 0 && this.nTxt.x >= this.txtMarsk.x)
         {
            this.txtSpan *= -1;
         }
         this.nTxt.x += this.txtSpan;
      }
   }
}

