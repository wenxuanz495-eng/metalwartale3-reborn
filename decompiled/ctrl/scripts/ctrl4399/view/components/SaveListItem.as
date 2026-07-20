package ctrl4399.view.components
{
   import ctrl4399.strconst.AllConst;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import org.heaven.impl.tot.Singleton;
   
   public class SaveListItem extends Sprite
   {
      
      private var _titleTxt:TextField;
      
      private var _timeTxt:TextField;
      
      private var _mouseOverSkin:Sprite;
      
      private var _mouseOutSkin:Sprite;
      
      private var _mouseDownSkin:Sprite;
      
      private var _disableSkin:Sprite;
      
      private var _isInit:Boolean;
      
      private var _isSet:Boolean;
      
      private var _title:String;
      
      private var _time:String;
      
      private var _status:String;
      
      private var _skin:Sprite;
      
      private var _isDoSelect:Boolean;
      
      private var _isSelect:Boolean;
      
      private var _selectSkin:Sprite;
      
      private var _mainHold:Object;
      
      private var _index:int;
      
      private var _isCanClick:Boolean;
      
      private var _mode:int;
      
      private var _indexTxt:TextField;
      
      private var _canSelceTextForamt:TextFormat;
      
      private var _disableSelectTextFormat:TextFormat;
      
      private var _isAddListener:Boolean;
      
      public function SaveListItem(param1:int)
      {
         super();
         this._mode = param1;
         if(stage)
         {
            this.init();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.init);
         }
      }
      
      public function set index(param1:int) : void
      {
         this._index = param1;
         this._indexTxt.text = "0" + (this._index + 1);
      }
      
      public function get index() : int
      {
         return this._index;
      }
      
      public function set mainHold(param1:Object) : void
      {
         this._mainHold = param1;
      }
      
      public function setSelect(param1:Boolean) : void
      {
         this._isDoSelect = true;
         this._isSelect = param1;
         if(this._isInit)
         {
            this.doSetSelect();
         }
      }
      
      private function doSetSelect() : void
      {
         this._selectSkin.visible = this._isSelect;
      }
      
      private function init(param1:Event = null) : void
      {
         if(param1 != null)
         {
            removeEventListener(Event.ADDED_TO_STAGE,this.init);
         }
         var _loc2_:Class = Singleton.getClass(AllConst.SAVE_LIST_ITME);
         this._skin = new _loc2_() as Sprite;
         addChild(this._skin);
         this._timeTxt = this._skin["timeTxt"] as TextField;
         this._titleTxt = this._skin["titleTxt"] as TextField;
         this._mouseDownSkin = this._skin["downSkin"] as Sprite;
         this._mouseOutSkin = this._skin["outSkin"] as Sprite;
         this._mouseOverSkin = this._skin["overSkin"] as Sprite;
         this._selectSkin = this._skin["selectSkin"] as Sprite;
         this._disableSkin = this._skin["disableSkin"] as Sprite;
         this._indexTxt = this._skin["indexTxt"] as TextField;
         this._mouseDownSkin.visible = false;
         this._mouseOverSkin.visible = false;
         this._selectSkin.visible = false;
         this._mouseOutSkin.visible = false;
         this._disableSkin.visible = true;
         this.initTxt();
         mouseChildren = false;
         mouseEnabled = true;
         addEventListener(Event.REMOVED_FROM_STAGE,this.delSelf);
         this._isInit = true;
         this._isSelect = false;
         this._titleTxt.text = "无存档记录";
         if(this._mode == AllConst.GET_MODE)
         {
            this.setCanClick(false);
         }
         else if(this._mode == AllConst.SAVE_MODE)
         {
            this.setCanClick(true);
         }
         else if(this._mode == AllConst.SAVE_GET_MODE)
         {
            this.setCanClick(true);
         }
         if(this._isSet)
         {
            this.doSetData();
         }
         if(this._isDoSelect)
         {
            this.doSetSelect();
         }
      }
      
      public function setCanClick(param1:Boolean) : void
      {
         this._isCanClick = param1;
         if(this._isInit)
         {
            this.doSetCanClick();
         }
      }
      
      private function doSetCanClick() : void
      {
         if(this._isCanClick)
         {
            if(this._mode == AllConst.GET_MODE && !this._isSet)
            {
               return;
            }
            this._disableSkin.visible = false;
            this._mouseOutSkin.visible = true;
            this._mouseDownSkin.visible = false;
            this._mouseOverSkin.visible = false;
            this._selectSkin.visible = false;
            this._indexTxt.setTextFormat(this._canSelceTextForamt,0,this._indexTxt.text.length);
            this.addListener();
         }
         else
         {
            this._disableSkin.visible = true;
            this._mouseOutSkin.visible = false;
            this._mouseDownSkin.visible = false;
            this._mouseOverSkin.visible = false;
            this._selectSkin.visible = false;
            this._indexTxt.setTextFormat(this._disableSelectTextFormat,0,this._indexTxt.text.length);
            this.delListener();
         }
      }
      
      private function initTxt() : void
      {
         this._canSelceTextForamt = this._indexTxt.getTextFormat();
         this._disableSelectTextFormat = this._indexTxt.getTextFormat();
         this._disableSelectTextFormat.color = 13421772;
         this._timeTxt.text = "";
         this._titleTxt.text = "";
         this._timeTxt.selectable = false;
         this._timeTxt.mouseWheelEnabled = false;
         this._titleTxt.selectable = false;
         this._titleTxt.mouseWheelEnabled = false;
         this._indexTxt.selectable = false;
         this._indexTxt.mouseEnabled = false;
         this._indexTxt.mouseWheelEnabled = false;
      }
      
      private function mouseHandler(param1:MouseEvent) : void
      {
         switch(param1.type)
         {
            case MouseEvent.MOUSE_DOWN:
               this.mouseDownHandler();
               break;
            case MouseEvent.ROLL_OUT:
               this.mouseRollOutHandler();
               break;
            case MouseEvent.ROLL_OVER:
               this.mouseRollOverHandler();
               break;
            case MouseEvent.MOUSE_UP:
               this.mouseUpHandler();
               break;
            case MouseEvent.CLICK:
               this.mouseClickHandler();
         }
      }
      
      private function mouseClickHandler() : void
      {
         this._disableSkin.visible = false;
         if(this._mainHold != null)
         {
            this._mainHold["itemClickHandler"](this._index,this._timeTxt.text,this._status);
         }
      }
      
      private function mouseUpHandler() : void
      {
         this._disableSkin.visible = false;
         this._mouseDownSkin.visible = false;
         this._mouseOutSkin.visible = false;
         this._mouseOverSkin.visible = true;
         addEventListener(MouseEvent.MOUSE_DOWN,this.mouseHandler);
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.mouseHandler);
      }
      
      private function mouseDownHandler() : void
      {
         this._disableSkin.visible = false;
         this._mouseDownSkin.visible = true;
         this._mouseOutSkin.visible = false;
         this._mouseOverSkin.visible = false;
         removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseHandler);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.mouseHandler);
      }
      
      private function mouseRollOutHandler() : void
      {
         this._disableSkin.visible = false;
         this._mouseDownSkin.visible = false;
         this._mouseOutSkin.visible = true;
         this._mouseOverSkin.visible = false;
      }
      
      private function mouseRollOverHandler() : void
      {
         this._disableSkin.visible = false;
         this._mouseDownSkin.visible = false;
         this._mouseOutSkin.visible = false;
         this._mouseOverSkin.visible = true;
      }
      
      public function setData(param1:String, param2:String, param3:String) : void
      {
         this._time = param2;
         this._title = param1;
         this._status = param3;
         this._isSet = true;
         if(this._isInit)
         {
            this.doSetData();
         }
      }
      
      private function doSetData() : void
      {
         if(this._status == AllConst.DataOK)
         {
            this._titleTxt.text = this._title;
         }
         else
         {
            this._titleTxt.text = this._title + "(异常)";
         }
         this._timeTxt.text = "时间：" + this._time;
      }
      
      private function addListener() : void
      {
         if(this._isAddListener)
         {
            return;
         }
         this._isAddListener = true;
         addEventListener(MouseEvent.CLICK,this.mouseHandler,false,0,true);
         addEventListener(MouseEvent.MOUSE_DOWN,this.mouseHandler,false,0,true);
         addEventListener(MouseEvent.ROLL_OUT,this.mouseHandler,false,0,true);
         addEventListener(MouseEvent.ROLL_OVER,this.mouseHandler,false,0,true);
         buttonMode = true;
      }
      
      private function delListener() : void
      {
         if(!this._isAddListener)
         {
            return;
         }
         this._isAddListener = false;
         removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.mouseHandler);
         removeEventListener(MouseEvent.ROLL_OVER,this.mouseHandler);
         removeEventListener(MouseEvent.CLICK,this.mouseHandler);
         buttonMode = false;
      }
      
      private function delSelf(param1:Event) : void
      {
         removeEventListener(Event.REMOVED_FROM_STAGE,this.delSelf);
         this.delListener();
      }
   }
}

