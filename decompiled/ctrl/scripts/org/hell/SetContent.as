package org.hell
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.AntiAliasType;
   import flash.text.TextField;
   
   public class SetContent extends Component
   {
      
      protected var callback:Function;
      
      protected var caller:Object;
      
      protected var arg:Object;
      
      protected var xSep:uint = 10;
      
      protected var bottomHeight:uint = 30;
      
      protected var _Y_offset:uint = 0;
      
      protected var viewClass:Class;
      
      protected var view:DisplayObjectContainer;
      
      protected var contentBg:DisplayObjectContainer;
      
      protected var okText:String;
      
      protected var okBtn:SimpleButton;
      
      protected var okBtnHolder:DisplayObjectContainer;
      
      protected var okBtnLabel:TextField;
      
      protected var cancelBtn:SimpleButton;
      
      protected var cancelBtnHolder:DisplayObjectContainer;
      
      protected var cancelBtnLabel:TextField;
      
      protected var iconLabelSep:uint = 10;
      
      public function SetContent()
      {
         super();
      }
      
      public function setBtnInterVal(param1:int = 10) : void
      {
         this.iconLabelSep = param1;
      }
      
      public function setYoffset(param1:uint = 0) : void
      {
         this._Y_offset = param1;
      }
      
      public function setOneBtn() : void
      {
         this.cancelBtnHolder.visible = false;
      }
      
      public function disableBtn(param1:int = -1) : void
      {
         if(param1 == 0)
         {
            this.okBtnHolder.visible = false;
            this.cancelBtnHolder.visible = true;
         }
         else if(param1 == 1)
         {
            this.cancelBtnHolder.visible = false;
            this.okBtnHolder.visible = true;
         }
      }
      
      public function setBtnVisible(param1:Boolean = false) : void
      {
         this.okBtnHolder.visible = param1;
         this.cancelBtnHolder.visible = param1;
      }
      
      public function append(param1:DisplayObject, param2:Number, param3:Number) : void
      {
         if(param1)
         {
            this.contentBg.addChild(param1);
            param1.x = param2;
            param1.y = param3;
         }
      }
      
      public function init(param1:Object, param2:Object = null, param3:Function = null, param4:Object = null) : Point
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         this.viewClass = param1.contentViewClass;
         this.initView();
         _loc5_ = this.contentBg.width;
         _loc6_ = this.contentBg.height + this.bottomHeight;
         this.caller = param2;
         this.callback = param3;
         this.arg = param4;
         this.okBtn.addEventListener(MouseEvent.CLICK,this.okClick,false,0,true);
         this.cancelBtn.addEventListener(MouseEvent.CLICK,this.cancelClick,false,0,true);
         this.setSize(_loc5_,_loc6_);
         return new Point(_loc5_,_loc6_);
      }
      
      public function setBtnText(param1:String, param2:String) : void
      {
         this.okBtnLabel.text = param1;
         this.cancelBtnLabel.text = param2;
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         var _loc3_:uint = 0;
         super.setSize(param1,param2);
         this.contentBg.x = this.xSep / 2;
         this.contentBg.width = param1 - this.xSep;
         this.contentBg.height = param2 - this.bottomHeight;
         _loc3_ = this.okBtn.width + this.iconLabelSep + this.cancelBtn.width;
         this.okBtnHolder.x = (param1 - _loc3_) / 2;
         this.okBtnHolder.y = param2 - this._Y_offset - this.okBtn.height - 2;
         this.cancelBtnHolder.x = this.okBtnHolder.x + this.okBtn.width + this.iconLabelSep;
         this.cancelBtnHolder.y = param2 - this._Y_offset - this.cancelBtn.height - 2;
      }
      
      protected function initView() : void
      {
         this.view = new this.viewClass() as DisplayObjectContainer;
         addChild(this.view);
         this.contentBg = this.view["contentBg"];
         this.okBtnHolder = this.view["okBtnHolder"];
         this.okBtnLabel = this.view["okBtnHolder"].label;
         this.okBtnLabel.text = "确 定";
         this.okBtnLabel.mouseEnabled = false;
         this.okBtnLabel.antiAliasType = AntiAliasType.NORMAL;
         this.okBtn = this.view["okBtnHolder"].okBtn;
         this.cancelBtnHolder = this.view["cancelBtnHolder"];
         this.cancelBtn = this.view["cancelBtnHolder"].cancelBtn;
         this.cancelBtnLabel = this.view["cancelBtnHolder"].label;
         this.cancelBtnLabel.text = "取 消";
         this.cancelBtnLabel.mouseEnabled = false;
         this.cancelBtnLabel.antiAliasType = AntiAliasType.NORMAL;
      }
      
      public function close() : void
      {
         if(this.callback != null)
         {
            this.callback.apply(this.caller,[this.arg,MessageBoxConst.CLOSE]);
         }
      }
      
      protected function okClick(param1:Event) : void
      {
         if(this.callback != null)
         {
            this.callback.apply(this.caller,[this.arg,MessageBoxConst.YES]);
         }
         dispatchEvent(new Event("close"));
      }
      
      protected function cancelClick(param1:Event) : void
      {
         if(this.callback != null)
         {
            this.callback.apply(this.caller,[this.arg,MessageBoxConst.NO]);
         }
         dispatchEvent(new Event("close"));
      }
   }
}

