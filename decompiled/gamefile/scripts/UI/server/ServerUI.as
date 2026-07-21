package UI.server
{
   import UI.button.SountoScrollBar;
   import data.StringDate;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.StyleSheet;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class ServerUI extends MovieClip
   {
      
      public var logo:MovieClip;
      
      private var _isnew:Boolean;
      
      public var btn_1:MovieClip;
      
      public var btn_2:MovieClip;
      
      public var btn_3:MovieClip;
      
      public var btn_4:MovieClip;
      
      public var btn_5:MovieClip;
      
      public var btn_6:MovieClip;
      
      public var btn_7:MovieClip;
      
      public var btn_8:MovieClip;
      
      public var name_1:MovieClip;
      
      public var name_2:MovieClip;
      
      public var name_3:MovieClip;
      
      public var name_4:MovieClip;
      
      public var name_5:MovieClip;
      
      public var name_6:MovieClip;
      
      public var name_7:MovieClip;
      
      public var name_8:MovieClip;
      
      public var btn_back:SimpleButton;
      
      public var btn_new:SimpleButton;
      
      public var btn_continue:SimpleButton;
      
      public var btn_introd:SimpleButton;
      
      public var btn_bbs:SimpleButton;
      
      public var btn_maker:SimpleButton;
      
      public var producer_mc:MovieClip;
      
      public var intro_mc:MovieClip;
      
      public var versionNumber_txt:TextField;
      
      public var cover_mc:Sprite;
      
      public var context_mc:Sprite = new Sprite();
      
      public var sBar:SountoScrollBar = new SountoScrollBar();
      
      public var bbs_btn:SimpleButton;
      
      public var btn_arr:Array = [];
      
      private var fun:Function;
      
      private var fun2:Function;
      
      public var txt1:TextField;
      
      public var str1:TextField;
      
      private var _selectIdex:int = 7;
      
      private var _selectSaveData:StringDate = null;
      
      private var notice_txt:TextField;
      
      private var noticeLoader:URLLoader;

      private var gameNoticeLoader:URLLoader;
      
      public function ServerUI()
      {
         super();
         this.InitSever();
      }
      
      public function InitSever() : void
      {
         var mc0:Sprite = null;
         this.gotoAndStop(1);
         if(this.logo != null)
         {
            this.logo.visible = false;
         }
         var sheet:StyleSheet = new StyleSheet();
         sheet.parseCSS("a:link {text-decoration:none;}a:hover {text-decoration:underline;color:#FFFF00;}a:active {text-decoration:none;}");
         this.txt1.styleSheet = sheet;
         this.txt1.htmlText = "本游戏开发，感谢@凉粉、@风水、@小熊、@愿原力与你同在、@客观、以及所有在内测群提供帮助的玩家们。";
         this.loadGameNotice();
         this.versionNumber_txt.text = "超合金离线优化海豹版，1.2";
         this.producer_mc.visible = false;
         this.intro_mc.visible = false;
         this.btn_new.addEventListener(MouseEvent.CLICK,this.gotonew);
         this.btn_continue.addEventListener(MouseEvent.CLICK,this.gotocontinue);
         this.btn_introd.addEventListener(MouseEvent.CLICK,this.gotointro);
         this.btn_bbs.addEventListener(MouseEvent.CLICK,this.gotoBBS);
         this.btn_maker.addEventListener(MouseEvent.CLICK,this.gotomake);
         (this.producer_mc["return_btn"] as SimpleButton).addEventListener(MouseEvent.CLICK,this.hideProducer);
         (this.intro_mc["return_btn"] as SimpleButton).addEventListener(MouseEvent.CLICK,this.hideIntro);
         addChild(this.context_mc);
         this.context_mc.x = this.cover_mc.x;
         this.context_mc.y = this.cover_mc.y;
         this.sBar.x = 554;
         this.sBar.y = 342;
         addChild(this.sBar);
         this.context_mc.mask = this.cover_mc;
         if(this.context_mc.numChildren == 0)
         {
            mc0 = this.createOfflineNotice();
            this.sBar.setHigh(this.cover_mc.height - 6);
            this.context_mc.addChild(mc0);
            this.sBar.setTarget(this.context_mc);
            this.loadOfflineNotice();
         }
         addChild(this.producer_mc);
         addChild(this.intro_mc);
      }
      
      private function createOfflineNotice() : Sprite
      {
         var box:Sprite = new Sprite();
         this.notice_txt = new TextField();
         this.notice_txt.width = 455;
         this.notice_txt.height = 210;
         this.notice_txt.multiline = true;
         this.notice_txt.wordWrap = true;
         this.notice_txt.selectable = false;
         this.notice_txt.defaultTextFormat = new TextFormat("_sans",13,65331,null,null,null,null,null,null,0,0,3,2);
         this.notice_txt.text = "【超合金离线优化海豹版 1.2.4 内测更新】\n详细更新内容请查看游戏根目录的公告.txt。";
         box.addChild(this.notice_txt);
         return box;
      }
      
      private function loadOfflineNotice() : void
      {
         this.noticeLoader = new URLLoader();
         this.noticeLoader.dataFormat = URLLoaderDataFormat.TEXT;
         this.noticeLoader.addEventListener(Event.COMPLETE,this.offlineNoticeLoaded);
         this.noticeLoader.addEventListener(IOErrorEvent.IO_ERROR,this.offlineNoticeLoadFailed);
         this.noticeLoader.load(new URLRequest("公告.txt?time=" + new Date().time));
      }

      private function loadGameNotice() : void
      {
         this.gameNoticeLoader = new URLLoader();
         this.gameNoticeLoader.dataFormat = URLLoaderDataFormat.TEXT;
         this.gameNoticeLoader.addEventListener(Event.COMPLETE,this.gameNoticeLoaded);
         this.gameNoticeLoader.addEventListener(IOErrorEvent.IO_ERROR,this.gameNoticeLoadFailed);
         this.gameNoticeLoader.load(new URLRequest("游戏公告.txt?time=" + new Date().time));
      }

      private function gameNoticeLoaded(event:Event) : void
      {
         var text0:String = String(this.gameNoticeLoader.data);
         if(text0.length > 0 && text0.charCodeAt(0) == 65279)
         {
            text0 = text0.substr(1);
         }
         if(text0.length > 0)
         {
            this.txt1.htmlText = text0;
         }
         this.clearGameNoticeLoader();
      }

      private function gameNoticeLoadFailed(event:IOErrorEvent) : void
      {
         this.clearGameNoticeLoader();
      }

      private function clearGameNoticeLoader() : void
      {
         if(this.gameNoticeLoader != null)
         {
            this.gameNoticeLoader.removeEventListener(Event.COMPLETE,this.gameNoticeLoaded);
            this.gameNoticeLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.gameNoticeLoadFailed);
            this.gameNoticeLoader = null;
         }
      }
      
      private function offlineNoticeLoaded(event:Event) : void
      {
         var text0:String = String(this.noticeLoader.data);
         if(text0.length > 0 && text0.charCodeAt(0) == 65279)
         {
            text0 = text0.substr(1);
         }
         if(this.notice_txt != null && text0.length > 0)
         {
            this.notice_txt.text = text0;
         }
         this.clearNoticeLoader();
      }
      
      private function offlineNoticeLoadFailed(event:IOErrorEvent) : void
      {
         this.clearNoticeLoader();
      }
      
      private function clearNoticeLoader() : void
      {
         if(this.noticeLoader != null)
         {
            this.noticeLoader.removeEventListener(Event.COMPLETE,this.offlineNoticeLoaded);
            this.noticeLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.offlineNoticeLoadFailed);
            this.noticeLoader = null;
         }
      }
      
      public function InitSelect() : void
      {
         var i:int = 1;
         while(i < 9)
         {
            (this["btn_" + i] as MovieClip).gotoAndStop(1);
            (this["btn_" + i] as MovieClip).buttonMode = true;
            (this["btn_" + i] as MovieClip).mouseChildren = false;
            (this["name_" + i] as MovieClip).mouseEnabled = false;
            (this["name_" + i] as MovieClip).mouseChildren = false;
            (this["name_" + i]["txt_name"] as TextField).text = "无角色数据";
            (this["name_" + i]["txt_level"] as TextField).text = "";
            (this["name_" + i]["txt_date"] as TextField).text = "";
            (this["btn_" + i] as MovieClip).addEventListener(MouseEvent.CLICK,this.onSelectClick);
            i++;
         }
         (this["btn_back"] as SimpleButton).addEventListener(MouseEvent.CLICK,this.onGoTo1);
      }
      
      protected function onGoTo1(event:MouseEvent) : void
      {
         this.InitSever();
      }
      
      private function getindex(id:int) : int
      {
         switch(id)
         {
            case 2:
               return 0;
            case 3:
               return 1;
            case 1:
               return 2;
            case 4:
               return 3;
            case 5:
               return 4;
            case 6:
               return 5;
            case 7:
               return 6;
            case 8:
               return 7;
            default:
               return 7;
         }
      }
      
      private function getid(id:int) : int
      {
         switch(id)
         {
            case 0:
               return 2;
            case 1:
               return 3;
            case 2:
               return 1;
            case 3:
               return 4;
            case 4:
               return 5;
            case 5:
               return 6;
            case 6:
               return 7;
            case 7:
               return 8;
            default:
               return 8;
         }
      }
      
      public function SetSave(data:Array) : void
      {
         var i:* = undefined;
         var obj:Object = null;
         var tmpStr:String = null;
         var name:String = null;
         var lv:String = null;
         var tarr:Array = null;
         this.gotoAndStop(2);
         this.InitSelect();
         if(data == null)
         {
            return;
         }
         var j:int = 1;
         for(i in data)
         {
            obj = data[i];
            if(obj != null)
            {
               j = this.getid(obj.index);
               if(this["btn_" + j] as MovieClip != null)
               {
                  tmpStr = "存档的位置:" + obj.index + "存档时间:" + obj.datetime + "存档标题:" + obj.title + "存档状态:" + obj.status;
                  trace(tmpStr);
                  name = "";
                  lv = "";
                  tarr = obj.title.split("_");
                  if(tarr.length > 1)
                  {
                     lv = tarr[tarr.length - 1];
                     tarr.pop();
                  }
                  name = tarr.join("_");
                  (this["btn_" + j] as MovieClip).gotoAndStop(1);
                  (this["btn_" + j] as MovieClip).buttonMode = true;
                  (this["btn_" + j] as MovieClip).mouseChildren = false;
                  (this["name_" + j] as MovieClip).mouseEnabled = false;
                  (this["name_" + j] as MovieClip).mouseChildren = false;
                  (this["name_" + j]["txt_name"] as TextField).text = "" + name;
                  (this["name_" + j]["txt_level"] as TextField).text = "LV " + (int(lv) + 1);
                  (this["name_" + j]["txt_date"] as TextField).text = "" + obj.datetime;
                  (this["btn_" + j] as MovieClip).objindex = obj.index;
               }
            }
         }
      }
      
      protected function onSelectClick(event:MouseEvent) : void
      {
         var mc:MovieClip = event.currentTarget as MovieClip;
         var name:String = mc.name;
         var id:int = int(name.split("_")[1]);
         var i:int = 1;
         while(i < 9)
         {
            (this["btn_" + i] as MovieClip).gotoAndStop(1);
            i++;
         }
         mc.gotoAndStop(2);
         this._selectIdex = mc["objindex"] != null ? int(mc["objindex"]) : this.getindex(id);
         if(mc["objindex"] != null)
         {
            if(this._isnew)
            {
               Game.uiGroup.checkTip.showCheck("是否要覆盖旧的存档?",this.yesfuncover,this.nofun);
            }
            else
            {
               this.yesfun();
            }
         }
         else if(this._isnew)
         {
            Game.uiGroup.checkTip.showCheck("是否要创建新的存档?",this.yesfun,this.nofun);
         }
         else
         {
            Game.uiGroup.checkTip.showCheck("该位置无存档,是否要创建?",this.yesfun,this.nofun);
         }
         trace("选择关卡存档:" + id);
      }
      
      public function getSelectData() : StringDate
      {
         return this._selectSaveData;
      }
      
      private function yesfuncover() : void
      {
         Game.gameData.nowSaveIndex = this._selectIdex;
         this.hide();
         if(this.fun2 is Function)
         {
            this.fun2(true);
         }
      }
      
      private function yesfun() : void
      {
         var hasData:Boolean = false;
         Game.gameData.nowSaveIndex = this._selectIdex;
         if(Boolean(this["name_" + this.getid(this._selectIdex)]) && Boolean((this["name_" + this.getid(this._selectIdex)]["txt_date"] as TextField).text))
         {
            hasData = true;
            this._selectSaveData = new StringDate();
            this._selectSaveData.inData_byStr((this["name_" + this.getid(this._selectIdex)]["txt_date"] as TextField).text);
         }
         this.hide();
         if(this.fun2 is Function)
         {
            this.fun2(!hasData);
         }
      }
      
      private function nofun() : void
      {
      }
      
      protected function hideIntro(event:MouseEvent) : void
      {
         this.intro_mc.visible = false;
      }
      
      protected function hideProducer(event:MouseEvent) : void
      {
         this.producer_mc.visible = false;
      }
      
      protected function gotomake(event:MouseEvent) : void
      {
         this.producer_mc.visible = true;
      }
      
      protected function gotointro(event:MouseEvent) : void
      {
         this.intro_mc.visible = true;
      }
      
      protected function gotocontinue(event:MouseEvent) : void
      {
         this._isnew = false;
         if(this.fun is Function)
         {
            this.fun();
         }
      }
      
      protected function gotonew(event:MouseEvent) : void
      {
         this._isnew = true;
         if(this.fun is Function)
         {
            this.fun();
         }
      }
      
      public function click(e:*) : *
      {
         var index0:int = int(String(e.target.name).split("_")[1]);
         Game.gameData.nowSaveIndex = index0;
         this.hide();
         if(this.fun is Function)
         {
            this.fun();
         }
      }
      
      public function gotoBBS(e:*) : *
      {
         navigateToURL(new URLRequest("http://my.4399.com/forums-mtag-tagid-81243.html"),"_blank");
      }
      
      public function show(fun0:Function = null, fun1:Function = null) : *
      {
         this.fun = fun0;
         this.fun2 = fun1;
         this.visible = true;
         this._selectSaveData = null;
         Game.uiGroup.faseUI.clearLogo();
         Game.uiGroup.faseUI.StopGame();
      }
      
      public function hide() : *
      {
         this.visible = false;
         Game.uiGroup.faseUI.resumeLogo();
      }
   }
}

