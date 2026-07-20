package ctrl4399.view.components.shopModule.selectlist
{
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import flash.utils.getDefinitionByName;
   
   public class ScrollMc extends Sprite
   {
      
      private var THIS:* = this;
      
      private var PARENT:*;
      
      private var txtBlank:Number;
      
      private var barBlank:Number;
      
      private var txtHeight:Number;
      
      private var maskHeight:Number;
      
      private var barHeight:Number;
      
      private var bar_minY:Number;
      
      private var bar_maxY:Number;
      
      private var mc_maxY:Number;
      
      private var mc_minY:Number;
      
      private var mc_height:Number;
      
      private var overFlag:Boolean;
      
      private var myTxtArr:Array = new Array();
      
      private var myTxtBtnArr:Array;
      
      private var __mc:*;
      
      private var __stage:*;
      
      private var _bar_mc:*;
      
      private var _scroll_bg:*;
      
      private var _txtMc:*;
      
      private var _mask_mc:*;
      
      private var _txt_bg:*;
      
      private var __tb:String;
      
      private var txtBgHeihgt:Number;
      
      private var txtY:Number;
      
      private var barY:Number;
      
      private var nowId:int = -1;
      
      public function ScrollMc(param1:MovieClip, param2:*, param3:String, param4:Stage)
      {
         super();
         this.__mc = param1;
         this.__stage = param4;
         this.PARENT = param2;
         this.__tb = param3;
         this.init();
      }
      
      public function init() : *
      {
         this._bar_mc = this.__mc.bar_mc;
         this._scroll_bg = this.__mc.scroll_bg;
         this._txtMc = this.__mc.txtMc;
         this._mask_mc = this.__mc.mask_mc;
         this._txt_bg = this.__mc.txt_bg;
         this.txtBgHeihgt = this._txt_bg.height;
         this.txtY = this._txtMc.y;
         this.barY = this._bar_mc.y;
         this._bar_mc.visible = false;
         this._scroll_bg.visible = false;
         this.__mc.addEventListener(Event.REMOVED_FROM_STAGE,this.removeFromeStage);
      }
      
      public function chaneTxt(param1:Array, param2:Number = 20, param3:Boolean = false) : *
      {
         var _loc5_:* = undefined;
         var _loc6_:Class = null;
         this.nowId = -1;
         if(param1 == null)
         {
            return;
         }
         if(this.myTxtBtnArr != null)
         {
            _loc5_ = 0;
            while(_loc5_ < this.myTxtBtnArr.length)
            {
               this._txtMc.removeChild(this.myTxtBtnArr[_loc5_]);
               _loc5_++;
            }
         }
         this.myTxtBtnArr = new Array();
         if(param3)
         {
            return;
         }
         this.myTxtArr = param1;
         var _loc4_:* = 0;
         while(_loc4_ < param1.length)
         {
            _loc6_ = getDefinitionByName(this.__tb) as Class;
            this.myTxtBtnArr[_loc4_] = new _loc6_();
            this.myTxtBtnArr[_loc4_].y = param2 * _loc4_ + 2;
            this._txtMc.addChild(this.myTxtBtnArr[_loc4_]);
            this.myTxtBtnArr[_loc4_].txt.text = this.myTxtArr[_loc4_];
            this.myTxtBtnArr[_loc4_].id = _loc4_;
            this.myTxtBtnArr[_loc4_].addEventListener(MouseEvent.ROLL_OVER,this.txtOver);
            this.myTxtBtnArr[_loc4_].addEventListener(MouseEvent.ROLL_OUT,this.txtOut);
            this.myTxtBtnArr[_loc4_].addEventListener(MouseEvent.MOUSE_DOWN,this.txtDown);
            _loc4_++;
         }
         this._txtMc.y = this.txtY;
         this._bar_mc.y = this.barY;
         this.txtBlank = 5;
         this.barBlank = 0;
         this.txtHeight = this._txtMc.height;
         this.maskHeight = this._mask_mc.height;
         this.barHeight = this._scroll_bg.height - this._bar_mc.height - this.barBlank * 2;
         this.bar_minY = this._bar_mc.y;
         this.bar_maxY = this.bar_minY + this.barHeight;
         this.mc_maxY = this._txtMc.y;
         this.mc_minY = this._txtMc.y - this.txtHeight + this.maskHeight - this.txtBlank;
         this.mc_height = this.mc_maxY - this.mc_minY;
         this._mask_mc.cacheAsBitmap = true;
         this._txtMc.cacheAsBitmap = true;
         this._txtMc.mask = this._mask_mc;
         if(this.txtHeight > this.maskHeight)
         {
            this._bar_mc.visible = true;
            this._scroll_bg.visible = true;
            this._txt_bg.height = this.txtBgHeihgt;
            this._bar_mc.buttonMode = true;
            this._bar_mc.addEventListener(MouseEvent.ROLL_OVER,this.btn_over);
            this._bar_mc.addEventListener(MouseEvent.ROLL_OUT,this.btn_out);
            this._bar_mc.addEventListener(MouseEvent.MOUSE_DOWN,this.btn_down);
            this._bar_mc.addEventListener(MouseEvent.MOUSE_UP,this.btn_up);
         }
         else
         {
            this._bar_mc.visible = false;
            this._scroll_bg.visible = false;
            this._txt_bg.height = this.txtHeight + 10;
         }
      }
      
      public function get over() : Boolean
      {
         return this.overFlag;
      }
      
      private function btn_over(param1:MouseEvent) : *
      {
         this.overFlag = true;
      }
      
      private function btn_out(param1:MouseEvent) : *
      {
         this.overFlag = false;
      }
      
      private function txtOver(param1:MouseEvent) : *
      {
         var _loc2_:* = param1.currentTarget.id;
         var _loc3_:* = this.myTxtBtnArr[_loc2_];
         _loc3_.gotoAndStop(2);
      }
      
      private function txtOut(param1:MouseEvent) : *
      {
         var _loc2_:* = param1.currentTarget.id;
         var _loc3_:* = this.myTxtBtnArr[_loc2_];
         _loc3_.gotoAndStop(1);
      }
      
      private function txtDown(param1:MouseEvent) : *
      {
         var _loc2_:* = param1.currentTarget.id;
         if(_loc2_ != this.nowId)
         {
            this.PARENT._choice_txt.text = this.myTxtArr[_loc2_];
            this.PARENT.change(_loc2_);
            this.nowId = _loc2_;
         }
      }
      
      private function btn_down(param1:MouseEvent) : *
      {
         this.__stage.addEventListener(MouseEvent.MOUSE_UP,this.onRelease_onReleaseOutside);
         this._bar_mc.addEventListener(Event.ENTER_FRAME,this.btnOnEnterFrame);
         this._txtMc.addEventListener(Event.ENTER_FRAME,this.txtOnEnterFrame);
      }
      
      private function onRelease_onReleaseOutside(param1:MouseEvent) : *
      {
         this._bar_mc.removeEventListener(Event.ENTER_FRAME,this.btnOnEnterFrame);
         this.__stage.removeEventListener(MouseEvent.MOUSE_UP,this.onRelease_onReleaseOutside);
      }
      
      private function btn_up(param1:MouseEvent) : *
      {
         this._bar_mc.removeEventListener(Event.ENTER_FRAME,this.btnOnEnterFrame);
         this._txtMc.removeEventListener(Event.ENTER_FRAME,this.txtOnEnterFrame);
      }
      
      private function btnOnEnterFrame(param1:Event) : *
      {
         this._bar_mc.y = this.__mc.mouseY;
         if(this._bar_mc.y < this.bar_minY)
         {
            this._bar_mc.y = this.bar_minY;
         }
         else if(this._bar_mc.y > this.bar_maxY)
         {
            this._bar_mc.y = this.bar_maxY;
         }
      }
      
      private function txtOnEnterFrame(param1:Event) : *
      {
         var _loc2_:Number = 3;
         var _loc3_:Number = this.mc_maxY - (this._bar_mc.y - this.bar_minY) * (this.mc_height / this.barHeight);
         var _loc4_:* = (_loc3_ - this._txtMc.y) / _loc2_;
         var _loc5_:* = _loc3_ - this._txtMc.y;
         if(Math.abs(_loc5_) < 1)
         {
            this._txtMc.y = _loc3_;
         }
         else
         {
            this._txtMc.y += _loc4_;
         }
      }
      
      private function removeFromeStage(param1:Event) : *
      {
         this._txtMc.removeEventListener(Event.ENTER_FRAME,this.txtOnEnterFrame);
         this._bar_mc.removeEventListener(Event.ENTER_FRAME,this.btnOnEnterFrame);
      }
   }
}

