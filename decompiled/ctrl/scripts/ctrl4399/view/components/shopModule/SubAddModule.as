package ctrl4399.view.components.shopModule
{
   import flash.display.MovieClip;
   import flash.events.DataEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol347")]
   public class SubAddModule extends MovieClip
   {
      
      public var addBtn:MovieClip;
      
      public var buyTxt:TextField;
      
      public var subBtn:MovieClip;
      
      private var maxBuyNum:uint = 1;
      
      private var curBuyNum:uint = 0;
      
      private var isSetOk:Boolean = false;
      
      public var isAdd:Boolean = true;
      
      public var isSub:Boolean = true;
      
      public function SubAddModule()
      {
         super();
         this.buyTxt.multiline = false;
         this.buyTxt.wordWrap = false;
         this.buyTxt.restrict = "0-9";
         this.buyTxt.maxChars = 3;
         this.buyTxt.addEventListener(Event.CHANGE,this.onChangeBuyHandler);
         this.addBtn.mouseChildren = false;
         this.addBtn.buttonMode = true;
         this.addBtn.addEventListener(MouseEvent.CLICK,this.onClickHandler);
         this.subBtn.mouseChildren = false;
         this.subBtn.buttonMode = true;
         this.subBtn.addEventListener(MouseEvent.CLICK,this.onClickHandler);
      }
      
      public function setSubAddFun(param1:uint, param2:uint) : void
      {
         if(param1 == 0 || param1 < param2)
         {
            this.isSetOk = false;
            return;
         }
         this.maxBuyNum = param1;
         this.curBuyNum = param2;
         this.buyTxt.text = param2.toString();
         this.isSetOk = true;
      }
      
      public function setPos(param1:Number, param2:Number) : void
      {
         this.x = Math.round(param1);
         this.y = Math.round(param2);
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         if(!this.isSetOk)
         {
            return;
         }
         var _loc2_:Boolean = false;
         switch(param1.target.name)
         {
            case "addBtn":
               if(!this.isAdd)
               {
                  return;
               }
               ++this.curBuyNum;
               if(this.curBuyNum > this.maxBuyNum)
               {
                  this.curBuyNum = this.maxBuyNum;
               }
               _loc2_ = true;
               break;
            case "subBtn":
               if(!this.isSub)
               {
                  return;
               }
               --this.curBuyNum;
               if(this.curBuyNum < 1)
               {
                  this.curBuyNum = 1;
               }
               _loc2_ = true;
         }
         if(_loc2_)
         {
            this.buyTxt.text = this.curBuyNum.toString();
            this.dispatchEvent(new DataEvent("addSubEvent",false,false,this.buyTxt.text));
         }
      }
      
      public function setBuyNumTxtFun(param1:int) : void
      {
         if(this.buyTxt != null)
         {
            this.buyTxt.text = param1.toString();
         }
         this.curBuyNum = param1;
      }
      
      private function onChangeBuyHandler(param1:Event) : void
      {
         if(!this.isSetOk)
         {
            return;
         }
         var _loc2_:uint = uint(this.buyTxt.text);
         if(_loc2_ > this.maxBuyNum)
         {
            this.buyTxt.text = this.maxBuyNum.toString();
         }
         else if(_loc2_ < 1)
         {
            this.buyTxt.text = "1";
         }
         this.curBuyNum = uint(this.buyTxt.text);
         this.dispatchEvent(new DataEvent("addSubEvent",false,false,this.buyTxt.text));
      }
   }
}

