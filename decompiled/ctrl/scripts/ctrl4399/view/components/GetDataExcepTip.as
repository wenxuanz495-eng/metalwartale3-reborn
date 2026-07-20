package ctrl4399.view.components
{
   import ctrl4399.strconst.AllConst;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol283")]
   public class GetDataExcepTip extends MovieClip
   {
      
      public var cancelBtn:SimpleButton;
      
      public var closeBtn:SimpleButton;
      
      public var infoTxt:TextField;
      
      public var ssBtn:SimpleButton;
      
      public var sureBtn:SimpleButton;
      
      private var urlReq:URLRequest;
      
      public function GetDataExcepTip()
      {
         super();
         this.urlReq = new URLRequest();
         this.urlReq.url = AllConst.AppealUrl;
         this.initTxt();
      }
      
      private function initTxt() : void
      {
         if(this.infoTxt == null)
         {
            return;
         }
         this.infoTxt.multiline = true;
         this.infoTxt.mouseEnabled = false;
         this.infoTxt.selectable = false;
         this.infoTxt.wordWrap = true;
         this.infoTxt.autoSize = TextFieldAutoSize.CENTER;
      }
      
      public function showTip(param1:String) : void
      {
         if(this.infoTxt == null)
         {
            return;
         }
         if(param1 == AllConst.TempStop)
         {
            this.infoTxt.text = AllConst.TemExcepInfo;
            this.sureBtn.visible = false;
            this.ssBtn.visible = true;
            this.cancelBtn.visible = true;
         }
         else if(param1 == AllConst.ForeverStop)
         {
            this.infoTxt.text = AllConst.ForeverExcepInfo;
            this.sureBtn.visible = true;
            this.ssBtn.visible = false;
            this.cancelBtn.visible = false;
         }
         else
         {
            this.infoTxt.text = "取档的数据出现异常";
            this.sureBtn.visible = false;
            this.ssBtn.visible = true;
            this.cancelBtn.visible = true;
         }
         this.addEvent();
      }
      
      private function addEvent() : void
      {
         if(Boolean(this.closeBtn) && Boolean(this.closeBtn.visible) && !this.closeBtn.hasEventListener(MouseEvent.CLICK))
         {
            this.closeBtn.addEventListener(MouseEvent.CLICK,this.onClickHandler);
         }
         if(Boolean(this.sureBtn) && !this.sureBtn.hasEventListener(MouseEvent.CLICK))
         {
            this.sureBtn.addEventListener(MouseEvent.CLICK,this.onClickHandler);
         }
         if(Boolean(this.ssBtn) && Boolean(this.ssBtn.visible) && !this.ssBtn.hasEventListener(MouseEvent.CLICK))
         {
            this.ssBtn.addEventListener(MouseEvent.CLICK,this.onClickHandler);
         }
         if(Boolean(this.cancelBtn) && Boolean(this.cancelBtn.visible) && !this.cancelBtn.hasEventListener(MouseEvent.CLICK))
         {
            this.cancelBtn.addEventListener(MouseEvent.CLICK,this.onClickHandler);
         }
      }
      
      private function delEvent() : void
      {
         if(Boolean(this.closeBtn) && this.closeBtn.hasEventListener(MouseEvent.CLICK))
         {
            this.closeBtn.removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         }
         if(Boolean(this.sureBtn) && this.sureBtn.hasEventListener(MouseEvent.CLICK))
         {
            this.sureBtn.removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         }
         if(Boolean(this.ssBtn) && this.ssBtn.hasEventListener(MouseEvent.CLICK))
         {
            this.ssBtn.removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         }
         if(Boolean(this.cancelBtn) && this.cancelBtn.hasEventListener(MouseEvent.CLICK))
         {
            this.cancelBtn.removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         }
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.target.name as String;
         switch(_loc2_)
         {
            case "cancelBtn":
            case "sureBtn":
            case "closeBtn":
               this.closePanel();
               break;
            case "ssBtn":
               this.linkSsWeb();
         }
      }
      
      private function linkSsWeb() : void
      {
         navigateToURL(this.urlReq,"_blank");
      }
      
      private function closePanel() : void
      {
         this.delEvent();
         if(Boolean(this.parent) && this.parent.contains(this))
         {
            this.parent.removeChild(this);
         }
         dispatchEvent(new Event("DelBgEvent"));
      }
   }
}

