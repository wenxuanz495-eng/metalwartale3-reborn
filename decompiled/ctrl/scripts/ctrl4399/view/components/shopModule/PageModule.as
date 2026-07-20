package ctrl4399.view.components.shopModule
{
   import flash.display.MovieClip;
   import flash.events.DataEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol409")]
   public class PageModule extends MovieClip
   {
      
      public var _nextBtn:MovieClip;
      
      public var _preBtn:MovieClip;
      
      public var curTxt:TextField;
      
      public var totalTxt:TextField;
      
      private const State_No:* = "no";
      
      private const State_Nomal:* = "nomal";
      
      private const State_Over:* = "over";
      
      private var curPageNum:int;
      
      private var totalPageNum:int;
      
      private var pageNum:uint = 8;
      
      public function PageModule()
      {
         super();
         this._preBtn.buttonMode = true;
         this._preBtn.mouseChildren = false;
         this._preBtn.gotoAndStop(this.State_No);
         this._preBtn.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseHandler);
         this._preBtn.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseHandler);
         this._preBtn.addEventListener(MouseEvent.CLICK,this.onMouseHandler);
         this._nextBtn.buttonMode = true;
         this._nextBtn.mouseChildren = false;
         this._nextBtn.gotoAndStop(this.State_No);
         this._nextBtn.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseHandler);
         this._nextBtn.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseHandler);
         this._nextBtn.addEventListener(MouseEvent.CLICK,this.onMouseHandler);
         this.curTxt.text = "1";
         this.totalTxt.text = "1";
      }
      
      public function setPageFun(param1:uint, param2:uint) : void
      {
         if(param1 > param2)
         {
            this._preBtn.gotoAndStop(this.State_No);
            this._nextBtn.gotoAndStop(this.State_No);
            this.curTxt.text = "1";
            this.totalTxt.text = "1";
            return;
         }
         this.curPageNum = param1;
         this.totalPageNum = param2;
         this.curTxt.text = String(this.curPageNum);
         this.totalTxt.text = String(this.totalPageNum);
         this.changeBtnState();
      }
      
      public function setPos(param1:Number, param2:Number) : void
      {
         this.x = Math.round(param1);
         this.y = Math.round(param2);
      }
      
      private function onMouseHandler(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         if(_loc2_ == null || _loc2_.currentLabel == this.State_No)
         {
            return;
         }
         switch(param1.type)
         {
            case "mouseOver":
               _loc2_.gotoAndStop(this.State_Over);
               break;
            case "mouseOut":
               _loc2_.gotoAndStop(this.State_Nomal);
               break;
            case "click":
               if(_loc2_.name == "_preBtn" && this.curPageNum > 1)
               {
                  --this.curPageNum;
               }
               if(_loc2_.name == "_nextBtn" && this.curPageNum < this.totalPageNum)
               {
                  ++this.curPageNum;
               }
               this.changeBtnState();
               this.curTxt.text = String(this.curPageNum);
               this.dispatchEvent(new DataEvent("pageEvent",false,false,this.curTxt.text));
         }
      }
      
      private function changeBtnState() : void
      {
         if(this.totalPageNum > 1 && this.curPageNum <= this.totalPageNum)
         {
            if(this.curPageNum <= 1)
            {
               this._preBtn.gotoAndStop(this.State_No);
               this._nextBtn.gotoAndStop(this.State_Nomal);
            }
            else if(this.curPageNum == this.totalPageNum)
            {
               this._preBtn.gotoAndStop(this.State_Nomal);
               this._nextBtn.gotoAndStop(this.State_No);
            }
            else
            {
               this._preBtn.gotoAndStop(this.State_Nomal);
               this._nextBtn.gotoAndStop(this.State_Nomal);
            }
         }
         else
         {
            this._preBtn.gotoAndStop(this.State_No);
            this._nextBtn.gotoAndStop(this.State_No);
            this.curTxt.text = "1";
            this.totalTxt.text = "1";
         }
      }
   }
}

