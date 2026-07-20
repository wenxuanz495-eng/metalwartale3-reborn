package org.hell
{
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Point;
   
   public class SetBox extends Dialog
   {
      
      protected var stageHolder:Stage;
      
      public var closeBtnDownFunc:Function;
      
      public function SetBox()
      {
         super();
      }
      
      public function setBtnText(param1:String, param2:String) : void
      {
         if(content)
         {
            (content as SetContent).setBtnText(param1,param2);
         }
      }
      
      public function setBtnInterVal(param1:int = 10) : void
      {
         if(content)
         {
            (content as SetContent).setBtnInterVal(param1);
         }
      }
      
      public function initSetBox(param1:String, param2:Object = null, param3:Object = null, param4:Function = null, param5:Object = null) : void
      {
         this.stageHolder = Dialog.stageHolder;
         if(!this.stageHolder)
         {
            return;
         }
         this.style = param2;
         titleTf.defaultTextFormat = param2.tfd;
         if(param1 == null)
         {
            this.title = "提示信息";
         }
         else
         {
            this.title = param1;
         }
         this.stageHolder.addChild(this);
         var _loc6_:SetContent = new SetContent();
         this.content = _loc6_;
         var _loc7_:Point = _loc6_.init(param2,param3,param4,param5);
         setSize(_loc7_.x,_loc7_.y + _titleHeight);
         super.setTitleAndClose();
      }
      
      public function setStageSize(param1:Number, param2:Number) : void
      {
         if(this.stageHolder == null || param1 <= 0 || param2 <= 0)
         {
            return;
         }
         var _loc3_:int = this.stageHolder.stageWidth;
         var _loc4_:int = this.stageHolder.stageHeight;
         var _loc5_:Number = param1;
         var _loc6_:Number = param2;
         if(param1 / param2 >= _loc3_ / _loc4_)
         {
            if(param1 > _loc3_)
            {
               _loc5_ = _loc3_;
               _loc6_ = param2 * _loc3_ / param1;
            }
            else
            {
               _loc5_ = param1;
               _loc6_ = param2;
            }
         }
         else if(param2 > _loc4_)
         {
            _loc6_ = _loc4_;
            _loc5_ = param1 * _loc4_ / param2;
         }
         else
         {
            _loc5_ = param1;
            _loc6_ = param2;
         }
         setSize(_loc5_,_loc6_);
         moveCenter();
      }
      
      public function setYoffset(param1:uint = 0) : void
      {
         if(content)
         {
            (content as SetContent).setYoffset(param1);
         }
      }
      
      public function setOneBtn() : void
      {
         (content as SetContent).setOneBtn();
      }
      
      public function setBtnVisible(param1:Boolean = false) : void
      {
         (content as SetContent).setBtnVisible(param1);
      }
      
      public function append(param1:*, param2:Number, param3:Number) : void
      {
         (content as SetContent).append(param1,param2,param3);
      }
      
      public function disableBtn(param1:int = -1) : void
      {
         (content as SetContent).disableBtn(param1);
      }
      
      public function hide() : void
      {
         this.removeEvent();
         this.closeHandler(null);
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
      }
      
      protected function linkEvent(param1:TextEvent) : void
      {
         dispatchEvent(param1.clone());
      }
      
      override protected function closeHandler(param1:Event) : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
         if(bigbg)
         {
            this.hideOver(null);
         }
         if(param1 != null && param1.target != content)
         {
            (content as SetContent).close();
         }
         if(param1 == null)
         {
            return;
         }
         trace("++++++++++++++++++++++++++++++++++++");
         trace("e.type = " + param1.type);
         trace("++++++++++++++++++++++++++++++++++++");
         if(param1.type == MouseEvent.CLICK)
         {
            if(this.closeBtnDownFunc != null)
            {
               this.closeBtnDownFunc();
            }
         }
      }
      
      protected function hideOver(param1:*) : void
      {
         if(Boolean(bigbg) && Boolean(bigbg.parent))
         {
            bigbg.parent.removeChild(bigbg);
            this.removeEvent();
         }
      }
      
      public function addToBg(param1:DisplayObject, param2:Number, param3:Number) : void
      {
         if(param1 != null)
         {
            bg.addChild(param1);
            param1.x = param2;
            param1.y = param3;
         }
      }
   }
}

