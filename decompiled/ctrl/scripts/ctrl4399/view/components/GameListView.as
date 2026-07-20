package ctrl4399.view.components
{
   import ctrl4399.proxy.GameListProxy;
   import ctrl4399.proxy.MainProxy;
   import ctrl4399.strconst.AllConst;
   import ctrl4399.view.components.as3Ad4399Frame.Ad4399View;
   import ctrl4399.view.components.as3Ad4399Frame.LoaderBrandAd;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.system.LoaderContext;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.ui.Mouse;
   import frame4399.simplePureMvc.core.Facade;
   import org.heaven.impl.tot.Singleton;
   import org.hell.SetBox;
   import unit4399.picLoad.IJPGLoader;
   import unit4399.picLoad.JPGLoadmanager;
   
   public class GameListView extends Sprite
   {
      
      private var lineNum:uint = 4;
      
      private var picsSp:Sprite;
      
      private var adSp:Sprite;
      
      private var itemAry:Array;
      
      private var yspan:uint = 12;
      
      private var xspan:int = 40;
      
      private var box:SetBox;
      
      private var mainProxy:MainProxy;
      
      private var gameListProxy:GameListProxy;
      
      private var _facade:Facade = Facade.getInstance();
      
      public var _isShow:Boolean;
      
      private var _errorTip:Sprite;
      
      private var _errorTxt:TextField;
      
      private var _changeGroupSp:Sprite;
      
      private var canChangeGroup:Boolean = true;
      
      private var _isFirstErrorReq:Boolean = true;
      
      private var _brandAd:LoaderBrandAd;
      
      private var _loadList:Array;
      
      public function GameListView()
      {
         super();
         this.mainProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_MAIN) as MainProxy;
         this.gameListProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_GAMELIST) as GameListProxy;
         this.box = new SetBox();
         var _loc1_:Object = new Object();
         _loc1_.viewClass = Singleton.getClass(AllConst.SPC_VIEW);
         _loc1_.contentViewClass = Singleton.getClass(AllConst.SPC_CONT);
         _loc1_.tfd = new TextFormat();
         this.box.initSetBox("",_loc1_,null,this.checkBtnFun,null);
         this.box.titleHeight = 32;
         this.box.setStageSize(502,357);
         this.box.setBtnVisible();
         var _loc2_:Class = Singleton.getClass(AllConst.GL_TITLE_TOOL);
         var _loc3_:* = new _loc2_();
         _loc3_.width += 6;
         _loc3_.height += 30;
         this.box.append(_loc3_,4,7);
         this.picsSp = new Sprite();
         this.box.append(this.picsSp,32,52);
         this.createItemFun(8);
         this.createChangeGroupTxt();
         this.box.append(this._changeGroupSp,_loc3_.width - this._changeGroupSp.width + 40,252);
         this.adSp = new Sprite();
         this.box.append(this.adSp,_loc3_.x,_loc3_.y);
         this.box.addEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler,false,0,true);
         this.box.addEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHanlder,false,0,true);
         this.box.addEventListener(MouseEvent.MOUSE_UP,this.mouseRollOverHandler,false,0,true);
         this.box.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseRollOverHandler,false,0,true);
         var _loc4_:Class = Singleton.getClass(AllConst.ERROR_TIP_UI) as Class;
         this._errorTip = new _loc4_() as Sprite;
         this._errorTxt = this._errorTip["title"] as TextField;
         this.box.append(this._errorTip,244,164);
         this._errorTip.visible = false;
         this._isShow = false;
         this.box.hide();
      }
      
      private function createChangeGroupTxt() : void
      {
         this._changeGroupSp = new Sprite();
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.font = "宋体";
         _loc1_.size = 15;
         _loc1_.color = 16758309;
         _loc1_.bold = true;
         _loc1_.underline = true;
         var _loc2_:TextField = new TextField();
         _loc2_.defaultTextFormat = _loc1_;
         _loc2_.selectable = false;
         _loc2_.text = "换一组";
         this._changeGroupSp.addChild(_loc2_);
         this._changeGroupSp.mouseChildren = false;
         this._changeGroupSp.buttonMode = true;
         this._changeGroupSp.addEventListener(MouseEvent.CLICK,this.onChangeGroupTxt,false,0,true);
      }
      
      private function onChangeGroupTxt(param1:MouseEvent) : void
      {
         if(this.canChangeGroup)
         {
            this.canChangeGroup = false;
            this.closeError();
            this.stopMoveTextItem();
            this.playWaitProgress();
            this.gameListProxy.getGameListData(this.mainProxy.gameID,true);
         }
      }
      
      private function mouseRollOverHandler(param1:MouseEvent = null) : void
      {
         if(!this.mainProxy.mouseVisible)
         {
            Mouse.show();
         }
      }
      
      public function releaseRes() : void
      {
         this.canChangeGroup = true;
         this.stopMoveTextItem();
         this.playWaitProgress();
      }
      
      public function showError(param1:String) : void
      {
         this.canChangeGroup = true;
         this.stopWaitProgress(true);
         if(param1 == null)
         {
            return;
         }
         if(this._errorTip)
         {
            this._errorTip.visible = true;
            this._errorTxt.text = param1;
         }
      }
      
      public function closeError() : void
      {
         if(this._errorTip)
         {
            this._errorTip.visible = false;
         }
      }
      
      private function mouseRollOutHanlder(param1:MouseEvent = null) : void
      {
         trace("box.mouseX = " + this.box.mouseX + "  box.mouseY = " + this.box.mouseY);
         if(this.box.mouseX >= this.box.width || this.box.mouseX <= 0 || this.box.mouseY <= 0 || this.box.mouseY >= this.box.height)
         {
            if(!this.mainProxy.mouseVisible)
            {
               Mouse.hide();
            }
         }
      }
      
      private function createItemFun(param1:uint) : void
      {
         var _loc3_:GL_PicItem = null;
         var _loc4_:int = 0;
         this.itemAry = [];
         var _loc2_:uint = 0;
         while(_loc2_ < param1)
         {
            _loc3_ = new GL_PicItem();
            _loc3_.mouseChildren = false;
            _loc3_.buttonMode = true;
            _loc4_ = int(_loc2_ / this.lineNum);
            _loc3_.x = _loc2_ % this.lineNum * (_loc3_.width + this.xspan);
            _loc3_.y = _loc4_ * (_loc3_.height + this.yspan);
            _loc3_.waitMc.play();
            this.picsSp.addChild(_loc3_);
            this.itemAry.push(_loc3_);
            _loc2_++;
         }
      }
      
      public function showGameList(param1:Array) : void
      {
         if(param1.length == 0)
         {
            this.stopWaitProgress();
            return;
         }
         this.playWaitProgress();
         this.showItemDataFun(param1);
      }
      
      public function showAd(param1:String, param2:String) : void
      {
         this.addAdsFun(param1,param2);
      }
      
      private function addAdsFun(param1:String, param2:String) : void
      {
         if(this._brandAd == null)
         {
            this._brandAd = this.showBrandAd();
            this.adSp.addChild(this._brandAd);
         }
         this._brandAd.loadBrandAD(param1,param2);
      }
      
      private function showBrandAd() : LoaderBrandAd
      {
         var _loc1_:LoaderBrandAd = new LoaderBrandAd(this.mainProxy.gameID);
         var _loc2_:Class = Singleton.getClass(AllConst.GL_AD_MASK);
         var _loc3_:DisplayObject = new _loc2_() as DisplayObject;
         _loc1_.x = 4;
         _loc1_.y = 335 - _loc3_.height;
         _loc1_.addChild(_loc3_);
         _loc1_.mask = _loc3_;
         return _loc1_;
      }
      
      private function showAdFun() : Ad4399View
      {
         var _loc1_:Class = Singleton.getClass(AllConst.GL_AD_MASK);
         var _loc2_:DisplayObject = new _loc1_() as DisplayObject;
         var _loc3_:Ad4399View = new Ad4399View();
         var _loc4_:Object = AllConst.AD_INFO;
         _loc4_.pubWidth = "490";
         _loc4_.pubHeight = "338";
         _loc2_.width = int(_loc4_.pubWidth);
         _loc2_.y = _loc3_.y + int(_loc4_.pubHeight) - _loc2_.height;
         _loc3_.addChild(_loc2_);
         _loc3_.mask = _loc2_;
         _loc3_.loadAs2Ad(_loc4_);
         return _loc3_;
      }
      
      private function showItemDataFun(param1:Array) : void
      {
         var _loc5_:uint = 0;
         var _loc6_:GL_PicItem = null;
         var _loc7_:Object = null;
         var _loc8_:IJPGLoader = null;
         if(this._errorTip)
         {
            this._errorTip.visible = false;
         }
         var _loc2_:int = 0;
         if(param1.length >= this.itemAry.length)
         {
            _loc2_ = int(this.itemAry.length);
         }
         else
         {
            _loc2_ = int(param1.length);
            _loc5_ = uint(_loc2_);
            while(_loc5_ < this.itemAry.length)
            {
               if(this.picsSp != null && this.itemAry[_loc5_] != null && this.picsSp.contains(this.itemAry[_loc5_]))
               {
                  this.itemAry[_loc5_].removeEventListener(MouseEvent.CLICK,this.onMouseClickHandlder);
                  this.picsSp.removeChild(this.itemAry[_loc5_]);
               }
               _loc5_++;
            }
         }
         var _loc3_:LoaderContext = new LoaderContext(false);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc6_ = this.itemAry[_loc4_];
            if(!(this.picsSp == null || _loc6_ == null))
            {
               if(!this.picsSp.contains(_loc6_))
               {
                  this.picsSp.addChild(_loc6_);
               }
               _loc6_.addEventListener(MouseEvent.CLICK,this.onMouseClickHandlder);
               _loc7_ = param1[_loc4_];
               _loc6_.setGameNameText(_loc7_.gameName);
               _loc6_.url = _loc7_.linkUrl;
               _loc8_ = JPGLoadmanager.loadJPG(_loc7_.picUrl,this.loadJpgCompleteHandler,_loc4_,_loc3_,1);
               if(this._loadList == null)
               {
                  this._loadList = [];
               }
               this._loadList.push(_loc8_);
            }
            _loc4_++;
         }
      }
      
      public function stopWaitProgress(param1:Boolean = false) : void
      {
         var _loc4_:GL_PicItem = null;
         var _loc2_:int = this.picsSp.numChildren;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = GL_PicItem(this.picsSp.getChildAt(_loc3_));
            _loc4_.waitMc.visible = false;
            if(param1 && this._isFirstErrorReq)
            {
               _loc4_.gnTxt.text = "暂无数据";
               _loc4_.noPicMc.visible = true;
            }
            _loc3_++;
         }
      }
      
      public function playWaitProgress() : void
      {
         var _loc3_:GL_PicItem = null;
         var _loc1_:int = this.picsSp.numChildren;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = GL_PicItem(this.picsSp.getChildAt(_loc2_));
            _loc3_.waitMc.visible = true;
            _loc3_.waitMc.play();
            if(_loc3_.noPicMc.visible)
            {
               _loc3_.gnTxt.text = "游戏名称";
               _loc3_.noPicMc.visible = false;
            }
            _loc2_++;
         }
      }
      
      private function stopMoveTextItem() : void
      {
         var _loc2_:GL_PicItem = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.picsSp.numChildren)
         {
            _loc2_ = GL_PicItem(this.picsSp.getChildAt(_loc1_));
            if(_loc2_.isCanMoved)
            {
               _loc2_.stopAndRemoveMoveText();
            }
            _loc1_++;
         }
      }
      
      private function loadJpgCompleteHandler(param1:IJPGLoader, param2:Event, param3:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = undefined;
         if(param3 == 7)
         {
            this._isFirstErrorReq = false;
            this.canChangeGroup = true;
         }
         if(param2.type != Event.COMPLETE)
         {
            return;
         }
         if(this._loadList != null)
         {
            _loc5_ = int(this._loadList.length);
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               if(this._loadList[_loc4_] == param1)
               {
                  this._loadList.splice(_loc4_,1);
                  break;
               }
               _loc4_++;
            }
         }
         if(this.itemAry == null)
         {
            return;
         }
         if(param3 < 0 || param3 >= this.itemAry.length)
         {
            return;
         }
         _loc6_ = this.itemAry[param3];
         if(_loc6_ == null)
         {
            return;
         }
         _loc6_.waitMc.stop();
         _loc6_.waitMc.visible = false;
         _loc6_.picMc.addChild(param1);
      }
      
      private function onMouseClickHandlder(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         try
         {
            navigateToURL(new URLRequest(evt.target.url),"_blank");
         }
         catch(e:*)
         {
            trace("抛出链接异常");
         }
      }
      
      public function showBox() : void
      {
         if(this.box)
         {
            if(this._isShow)
            {
               return;
            }
            this._isShow = true;
            this.box.draggable = true;
            this.box.moveCenter();
            this.box.show(false);
         }
      }
      
      private function checkBtnFun(param1:* = null, param2:int = -1) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:GL_PicItem = null;
         this._isFirstErrorReq = true;
         this._isShow = false;
         if(this._errorTip)
         {
            this._errorTip.visible = false;
         }
         if(this.itemAry != null)
         {
            _loc4_ = int(this.itemAry.length);
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               _loc5_ = this.itemAry[_loc3_];
               if(_loc5_ != null)
               {
                  while(_loc5_.picMc.numChildren)
                  {
                     _loc5_.picMc.removeChildAt(0);
                     _loc5_.removeEventListener(MouseEvent.CLICK,this.onMouseClickHandlder);
                  }
                  _loc5_.waitMc.play();
               }
               _loc3_++;
            }
            if(this._loadList != null)
            {
               _loc4_ = int(this._loadList.length);
               _loc3_ = 0;
               while(_loc3_ < _loc4_)
               {
                  try
                  {
                     this._loadList[_loc3_].cancel();
                  }
                  catch(e:Error)
                  {
                  }
                  _loc3_++;
               }
               this._loadList = null;
            }
            if(!this.mainProxy.mouseVisible)
            {
               Mouse.hide();
            }
            if(param2 == 2)
            {
               dispatchEvent(new Event(AllConst.COLSE_PANEL_4399));
            }
         }
      }
   }
}

