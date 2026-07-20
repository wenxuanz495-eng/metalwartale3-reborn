package ctrl4399.view.components
{
   import ctrl4399.strconst.AllConst;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import org.heaven.impl.tot.Singleton;
   
   public class SaveTip extends Sprite
   {
      
      private var _skin:Sprite;
      
      private var _btnLeft:SimpleButton;
      
      private var _btnRight:SimpleButton;
      
      private var _title:TextField;
      
      private var _btnLeftTxt:TextField;
      
      private var _btnRightTxt:TextField;
      
      private var _btnLeftStr:String;
      
      private var _btnRightStr:String;
      
      private var _blueTextFormat:TextFormat;
      
      private var _lineTextFormat:TextFormat;
      
      private var _tipTextFormat:TextFormat;
      
      private var _isSet:Boolean;
      
      private var _isInit:Boolean;
      
      private var _status:String;
      
      private var _curMode:int;
      
      public function SaveTip()
      {
         super();
         if(stage)
         {
            this.init();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.init);
         }
      }
      
      private function init(param1:Event = null) : void
      {
         if(param1 != null)
         {
            removeEventListener(Event.ADDED_TO_STAGE,this.init);
         }
         var _loc2_:Class = Singleton.getClass(AllConst.SAVE_TIP);
         this._skin = new _loc2_() as Sprite;
         addChild(this._skin);
         x = (stage.stageWidth - this._skin.width) / 2;
         y = (stage.stageHeight - this._skin.height) / 2;
         this._title = this._skin["title"] as TextField;
         this._btnLeft = this._skin["btn0"] as SimpleButton;
         this._btnRight = this._skin["btn1"] as SimpleButton;
         this._skin.mouseChildren = true;
         this._skin.mouseEnabled = false;
         mouseEnabled = false;
         this.initTxt();
         this.initBtn();
         addChild(this._btnLeftTxt);
         addChild(this._btnRightTxt);
         this._isInit = true;
         if(this._isSet)
         {
            this.doSet();
         }
      }
      
      private function autoTxtSize() : void
      {
         this._btnLeftTxt.x = this._btnLeft.x + (this._btnLeft.width - this._btnLeftTxt.width) / 2;
         this._btnLeftTxt.y = this._btnLeft.y + (this._btnLeft.height - this._btnLeftTxt.height) / 2;
         this._btnRightTxt.x = this._btnRight.x + (this._btnRight.width - this._btnRightTxt.width) / 2;
         this._btnRightTxt.y = this._btnRight.y + (this._btnRight.height - this._btnRightTxt.height) / 2;
      }
      
      private function initTxt() : void
      {
         this._title.selectable = false;
         this._title.autoSize = TextFieldAutoSize.LEFT;
         this._title.mouseWheelEnabled = false;
         this._title.mouseEnabled = false;
         this._tipTextFormat = new TextFormat();
         this._tipTextFormat.font = "宋体";
         this._tipTextFormat.size = 16;
         this._blueTextFormat = new TextFormat();
         this._blueTextFormat.font = "宋体";
         this._blueTextFormat.size = 14;
         this._lineTextFormat = new TextFormat();
         this._lineTextFormat.font = "宋体";
         this._lineTextFormat.size = 14;
         this._btnLeftTxt = new TextField();
         this._btnLeftTxt.autoSize = TextFieldAutoSize.LEFT;
         this._btnLeftTxt.selectable = false;
         this._btnLeftTxt.mouseWheelEnabled = false;
         this._btnLeftTxt.mouseEnabled = false;
         this._btnRightTxt = new TextField();
         this._btnRightTxt.selectable = false;
         this._btnRightTxt.mouseWheelEnabled = false;
         this._btnRightTxt.autoSize = TextFieldAutoSize.LEFT;
         this._btnRightTxt.mouseEnabled = false;
      }
      
      private function initBtn() : void
      {
         this._btnLeft.addEventListener(MouseEvent.CLICK,this.btnDownHandler,false,0,true);
         this._btnRight.addEventListener(MouseEvent.CLICK,this.btnDownHandler,false,0,true);
      }
      
      private function btnDownHandler(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this._btnLeft:
               this.leftBtnDownHandler();
               break;
            case this._btnRight:
               this.rightBtnDownHandler();
         }
      }
      
      private function leftBtnDownHandler() : void
      {
         var _loc1_:int = 0;
         if(this._curMode == AllConst.SAVE_COVER_MODE)
         {
            _loc1_ = AllConst.SAVE_DATA;
         }
         else if(this._curMode == AllConst.SAVE_MODE)
         {
            _loc1_ = AllConst.SAVE_DATA;
         }
         else if(this._curMode == AllConst.GET_MODE)
         {
            _loc1_ = AllConst.GET_DATA;
         }
         else if(this._curMode == AllConst.SAVE_GET_MODE)
         {
            _loc1_ = AllConst.SAVE_PRO;
         }
         else if(this._curMode == AllConst.SAVE_SUC_MODE || this._curMode == AllConst.SAVE_LOCAL_SUC_MODE)
         {
            _loc1_ = AllConst.SAVE_SUC_DATA;
         }
         dispatchEvent(new ComponentEvent(AllConst.SAVE_TIP_DOWN,_loc1_));
      }
      
      private function rightBtnDownHandler() : void
      {
         var _loc1_:int = 0;
         if(this._curMode == AllConst.SAVE_GET_MODE)
         {
            _loc1_ = AllConst.GET_PRO;
            if(this._status != AllConst.DataOK)
            {
               dispatchEvent(new ComponentEvent(AllConst.GetData_Excep,this._status));
               return;
            }
         }
         else
         {
            _loc1_ = AllConst.CLOSE;
         }
         dispatchEvent(new ComponentEvent(AllConst.SAVE_TIP_DOWN,_loc1_));
      }
      
      public function showMode(param1:int, param2:String = "0") : void
      {
         this._status = param2;
         this._curMode = param1;
         this._isSet = true;
         if(this._isInit)
         {
            this.doSet();
         }
      }
      
      private function saveOrGetMode() : void
      {
         this._title.text = "";
         this._btnLeftStr = "保存进度";
         this._btnRightStr = "读取进度";
         this._btnLeftTxt.text = this._btnLeftStr;
         this._btnLeftTxt.setTextFormat(this._lineTextFormat,0,this._btnLeftStr.length);
         this._btnRightTxt.text = this._btnRightStr;
         this._btnRightTxt.setTextFormat(this._lineTextFormat,0,this._btnRightStr.length);
         this._btnLeft.x = -107.6;
         this._btnLeft.y = -18.6;
         this._btnRight.x = 28;
         this._btnRight.y = -17.6;
         this.autoTxtSize();
      }
      
      private function saveMode() : void
      {
         this._title.text = "是否保存进度";
         this._btnLeftStr = "是";
         this._btnRightStr = "否";
         this._btnLeftTxt.text = this._btnLeftStr;
         this._btnLeftTxt.setTextFormat(this._blueTextFormat,0,this._btnLeftStr.length);
         this._btnRightTxt.text = this._btnRightStr;
         this._btnRightTxt.setTextFormat(this._blueTextFormat,0,this._btnRightStr.length);
         this._btnLeft.x = -107.6;
         this._btnLeft.y = -2.6;
         this._btnRight.x = 28;
         this._btnRight.y = -2.6;
         this.autoTxtSize();
      }
      
      private function getMode() : void
      {
         this._title.text = "是否读取进度";
         this._btnLeftStr = "是";
         this._btnRightStr = "否";
         this._btnLeftTxt.text = this._btnLeftStr;
         this._btnLeftTxt.setTextFormat(this._blueTextFormat,0,this._btnLeftStr.length);
         this._btnRightTxt.text = this._btnRightStr;
         this._btnRightTxt.setTextFormat(this._blueTextFormat,0,this._btnRightStr.length);
         this._btnLeft.x = -107.6;
         this._btnLeft.y = -2.6;
         this._btnRight.x = 28;
         this._btnRight.y = -2.6;
         this.autoTxtSize();
      }
      
      private function saveCoverMode() : void
      {
         this._title.text = "是否覆盖进度";
         this._btnLeftStr = "是";
         this._btnRightStr = "否";
         this._btnLeftTxt.text = this._btnLeftStr;
         this._btnLeftTxt.setTextFormat(this._blueTextFormat,0,this._btnLeftStr.length);
         this._btnRightTxt.text = this._btnRightStr;
         this._btnRightTxt.setTextFormat(this._blueTextFormat,0,this._btnRightStr.length);
         this._btnLeft.x = -107.6;
         this._btnLeft.y = -2.6;
         this._btnRight.x = 28;
         this._btnRight.y = -2.6;
         this.autoTxtSize();
      }
      
      private function saveSucMode() : void
      {
         if(this._curMode == AllConst.SAVE_LOCAL_SUC_MODE)
         {
            this._title.text = "本地存档成功！\n是否需要进入游戏？";
         }
         else
         {
            this._title.text = "存档成功！\n是否需要进入游戏？";
         }
         this._title.setTextFormat(this._tipTextFormat);
         this._btnLeftStr = "是";
         this._btnRightStr = "否";
         this._btnLeftTxt.text = this._btnLeftStr;
         this._btnLeftTxt.setTextFormat(this._blueTextFormat,0,this._btnLeftStr.length);
         this._btnRightTxt.text = this._btnRightStr;
         this._btnRightTxt.setTextFormat(this._blueTextFormat,0,this._btnRightStr.length);
         this._btnLeft.x = -107.6;
         this._btnLeft.y = -2.6;
         this._btnRight.x = 28;
         this._btnRight.y = -2.6;
         this.autoTxtSize();
      }
      
      private function doSet() : void
      {
         var _loc1_:int = 0;
         switch(this._curMode)
         {
            case AllConst.SAVE_GET_MODE:
               this.saveOrGetMode();
               break;
            case AllConst.SAVE_MODE:
               _loc1_ = AllConst.SAVE_DATA;
               dispatchEvent(new ComponentEvent(AllConst.SAVE_TIP_DOWN,_loc1_));
               break;
            case AllConst.GET_MODE:
               _loc1_ = AllConst.GET_DATA;
               dispatchEvent(new ComponentEvent(AllConst.SAVE_TIP_DOWN,_loc1_));
               break;
            case AllConst.SAVE_COVER_MODE:
               this.saveCoverMode();
               break;
            case AllConst.SAVE_LOCAL_SUC_MODE:
            case AllConst.SAVE_SUC_MODE:
               this.saveSucMode();
         }
      }
   }
}

