package UI.server
{
   import UI.button.SountoScrollBar;
   import data.StringDate;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.StyleSheet;
   import flash.text.TextField;
   
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
      
      public function ServerUI()
      {
         super();
         this.InitSever();
      }
      
      public function InitSever() : void
      {
         var mc0:Sprite = null;
         this.gotoAndStop(1);
         var sheet:StyleSheet = new StyleSheet();
         sheet.parseCSS("a:link {text-decoration:none;}a:hover {text-decoration:underline;color:#FFFF00;}a:active {text-decoration:none;}");
         this.txt1.styleSheet = sheet;
         this.txt1.htmlText = this.str1.text;
         this.versionNumber_txt.text = Game.versionNumber;
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
            mc0 = Game.swfLoaderManager.getResource("notice","notice");
            if(Boolean(mc0))
            {
               this.sBar.setHigh(this.cover_mc.height - 6);
               this.context_mc.addChild(mc0);
               this.sBar.setTarget(this.context_mc);
            }
         }
         addChild(this.producer_mc);
         addChild(this.intro_mc);
      }
      
      public function InitSelect() : void
      {
         for(var i:int = 1; i < 9; i++)
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
         for(var i:int = 1; i < 9; i++)
         {
            (this["btn_" + i] as MovieClip).gotoAndStop(1);
         }
         mc.gotoAndStop(2);
         this._selectIdex = this.getindex(id);
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
         Game.gameData.nowSaveIndex = this._selectIdex;
         if(Boolean(this["name_" + this.getid(this._selectIdex)]) && Boolean((this["name_" + this.getid(this._selectIdex)]["txt_date"] as TextField).text))
         {
            this._selectSaveData = new StringDate();
            this._selectSaveData.inData_byStr((this["name_" + this.getid(this._selectIdex)]["txt_date"] as TextField).text);
         }
         this.hide();
         if(this.fun2 is Function)
         {
            this.fun2();
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

