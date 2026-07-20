package ctrl4399.view.components.shopModule.selectlist
{
   import flash.display.*;
   import flash.events.*;
   
   public class SelectMc extends Sprite
   {
      
      private var THIS:*;
      
      private var selectDownflag:Boolean = true;
      
      private var __mc:*;
      
      private var _scrollMc:ScrollMc;
      
      private var _scrollTxt:*;
      
      private var _select_btn:*;
      
      public var _choice_txt:*;
      
      public function SelectMc(param1:MovieClip, param2:String)
      {
         var myAdd:Function = null;
         var mc:MovieClip = param1;
         var tb:String = param2;
         this.THIS = this;
         super();
         myAdd = function(param1:Event):*
         {
            init(tb);
         };
         this.__mc = mc;
         if(stage)
         {
            this.init(tb);
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,myAdd);
         }
      }
      
      private function init(param1:String) : *
      {
         var selectOver:Function = null;
         var selectOut:Function = null;
         var tb:String = param1;
         selectOver = function(param1:MouseEvent):*
         {
            if(selectDownflag)
            {
               _select_btn.gotoAndStop(2);
            }
            else
            {
               _select_btn.gotoAndStop(4);
            }
         };
         selectOut = function(param1:MouseEvent):*
         {
            if(selectDownflag)
            {
               _select_btn.gotoAndStop(1);
            }
            else
            {
               _select_btn.gotoAndStop(3);
            }
         };
         this._scrollTxt = this.__mc.scrollTxt;
         this._select_btn = this.__mc.select_btn;
         this._choice_txt = this.__mc.choice_txt;
         this._scrollMc = new ScrollMc(this._scrollTxt,this.THIS,tb,stage);
         addChild(this._scrollMc);
         this._scrollTxt.visible = false;
         this._select_btn.addEventListener(MouseEvent.ROLL_OVER,selectOver);
         this._select_btn.addEventListener(MouseEvent.ROLL_OUT,selectOut);
      }
      
      public function setTxt(param1:String, param2:Array = null, param3:Number = 20) : *
      {
         if(param1 != null)
         {
            this._choice_txt.text = param1;
         }
         if(param2 == null)
         {
            return;
         }
         if(param2.length == 0)
         {
            this._select_btn.removeEventListener(MouseEvent.MOUSE_DOWN,this.selectDown);
            this._scrollMc.chaneTxt(param2,param3,true);
            return;
         }
         this._scrollMc.chaneTxt(param2,param3);
         this._select_btn.addEventListener(MouseEvent.MOUSE_DOWN,this.selectDown);
         this.__mc.addEventListener(Event.REMOVED_FROM_STAGE,this.myRemove);
      }
      
      public function change(param1:int) : *
      {
         dispatchEvent(new ChaneEvent(ChaneEvent.CHANGE,param1));
      }
      
      private function selectDown(param1:MouseEvent) : *
      {
         if(this.selectDownflag)
         {
            this._select_btn.gotoAndStop(3);
            this._scrollTxt.visible = true;
            this.selectDownflag = false;
            stage.addEventListener(MouseEvent.MOUSE_UP,this.stageUp);
         }
      }
      
      private function selectDown2() : *
      {
         if(!this._scrollMc.over)
         {
            stage.removeEventListener(MouseEvent.MOUSE_UP,this.stageUp);
            stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.stageDown);
            this.selectDownflag = true;
            this._select_btn.gotoAndStop(1);
            this._scrollTxt.visible = false;
         }
      }
      
      private function stageUp(param1:MouseEvent) : *
      {
         stage.addEventListener(MouseEvent.MOUSE_DOWN,this.stageDown);
      }
      
      private function stageDown(param1:MouseEvent) : *
      {
         this.selectDown2();
      }
      
      private function myRemove(param1:Event) : *
      {
         this.selectDown2();
      }
      
      public function setPosY(param1:Number) : void
      {
         this.__mc.y += param1;
      }
   }
}

