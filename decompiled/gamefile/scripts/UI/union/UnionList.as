package UI.union
{
   import UI.change.CarItemsTip;
   import UI.dialog.ItemsTipbox;
   import com.adobe.serialization.json.JSON2;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class UnionList
   {
      
      private var _unionlistPage:int = 1;
      
      private const ONEPAGECOUNT:int = 12;
      
      private var father:UnionUI = null;
      
      private var mc_box:MovieClip = null;
      
      private var mc_create:MovieClip = null;
      
      private var tip_mc:CarItemsTip = null;
      
      private var tipBox:ItemsTipbox = null;
      
      public function UnionList(mc0:UnionUI, mc1:MovieClip, mc2:MovieClip, mc3:CarItemsTip, mc4:ItemsTipbox)
      {
         super();
         this.father = mc0;
         this.mc_box = mc1;
         this.mc_create = mc2;
         this.tip_mc = mc3;
         this.tipBox = mc4;
      }
      
      protected function onClickBtn(event:MouseEvent) : void
      {
         var btn:DisplayObject = event.currentTarget as DisplayObject;
         var name:String = btn.name;
         switch(name)
         {
            case "btn_create":
               this.mc_create.condition_icon1.gotoAndStop(1);
               this.mc_create.condition_icon2.gotoAndStop(1);
               this.mc_create.visible = true;
               this.mc_create.txt_hasM.text = "" + Game.gameData.MCoin;
               this.mc_create.txt_lv.text = "" + 10;
               this.mc_create.btn_close.addEventListener(MouseEvent.CLICK,this.onClickBtn);
               this.mc_create.btn_cancel.addEventListener(MouseEvent.CLICK,this.onClickBtn);
               this.mc_create.btn_ok.addEventListener(MouseEvent.CLICK,this.onClickBtn);
               break;
            case "btn_ok":
               if(this.mc_create.txt_name.text == "" || this.mc_create.txt_name.text == null)
               {
                  Game.uiGroup.checkTip.showCheck2("没有公会名！",2);
                  return;
               }
               if((this.mc_create.txt_name.text as String).length > 10)
               {
                  Game.uiGroup.checkTip.showCheck2("公会名请不要超过10个汉字!",2);
                  return;
               }
               Game.uiGroup.checkTip.showCheck("是否要创建公会?",this.sureCreateUnion);
               break;
            case "btn_nextpage":
               if(this.mc_box.currentFrame == 1)
               {
                  ++this._unionlistPage;
                  (this.mc_box["btn_lastpage"] as SimpleButton).alpha = 1;
                  (this.mc_box["btn_lastpage"] as SimpleButton).mouseEnabled = true;
                  Game.union_api.getUnionList(Game.nowSaveIndex,this._unionlistPage,this.ONEPAGECOUNT,this.updateUnionList,null,false);
               }
               break;
            case "btn_lastpage":
               if(this.mc_box.currentFrame == 1)
               {
                  if(--this._unionlistPage <= 1)
                  {
                     this._unionlistPage = 1;
                     (this.mc_box["btn_lastpage"] as SimpleButton).alpha = 0.3;
                     (this.mc_box["btn_lastpage"] as SimpleButton).mouseEnabled = false;
                  }
                  else
                  {
                     (this.mc_box["btn_lastpage"] as SimpleButton).alpha = 1;
                     (this.mc_box["btn_lastpage"] as SimpleButton).mouseEnabled = true;
                  }
                  Game.union_api.getUnionList(Game.nowSaveIndex,this._unionlistPage,this.ONEPAGECOUNT,this.updateUnionList,null,false);
               }
               break;
            case "btn_close":
               if(this.father.contains(btn))
               {
                  btn.parent.visible = false;
               }
               break;
            case "btn_cancel":
               if(this.father.contains(btn))
               {
                  btn.parent.visible = false;
               }
         }
      }
      
      private function sureCreateUnion() : void
      {
         var extstr:String;
         var okFun:Function = function():void
         {
            Game.uiGroup.checkTip.showCheck2("创建成功!",2);
            Game.uiGroup.infoUI.fleshData();
            father.InitBox(2,false);
            father.hideAllWindows();
         };
         var noFun:Function = function(errs:String):void
         {
            Game.uiGroup.checkTip.showCheck2(errs,2);
            father.InitBox(1);
            father.hideAllWindows();
         };
         var uname:String = this.mc_create.txt_name.text;
         var extObj:Object = {};
         extObj.zdl = 0;
         extObj.notice = "";
         extObj.count = 1;
         extObj.playerName = Game.gameData.playerName;
         extstr = JSON2.encode(extObj);
         Game.union_api.unionCreate(Game.nowSaveIndex,Game.sensitiveWords.encode(uname),extstr,okFun,noFun);
      }
      
      protected function onItemOver(event:MouseEvent) : void
      {
         this.tip_mc.title_txt.text = "玩法说明";
         this.tip_mc.txt.text = "1.一个存档只能创建1个公会\n" + "2.一个存档只能加入1个公会\n" + "3.同一时间可以向3个公会发起申请\n" + "4.公会申请之后无法取消";
         this.tipBox.showDialog(this.tip_mc,event.currentTarget,event.currentTarget.x,event.currentTarget.y);
      }
      
      protected function onItemOut(event:MouseEvent) : void
      {
         this.tipBox.hide();
      }
      
      public function Init() : void
      {
         this.mc_box.gotoAndStop(1);
         this._unionlistPage = 1;
         this.updateUnionList(null);
         (this.mc_box.txt_create as TextField).mouseEnabled = false;
         this.mc_box.mc_help.addEventListener(MouseEvent.MOUSE_OVER,this.onItemOver);
         this.mc_box.mc_help.addEventListener(MouseEvent.MOUSE_OUT,this.onItemOut);
         this.mc_box.btn_create.addEventListener(MouseEvent.CLICK,this.onClickBtn);
         this.mc_box.btn_asklist.addEventListener(MouseEvent.CLICK,this.onClickBtn);
         this.mc_box.btn_lastpage.addEventListener(MouseEvent.CLICK,this.onClickBtn);
         this.mc_box.btn_nextpage.addEventListener(MouseEvent.CLICK,this.onClickBtn);
         if(this.father.IsHasUnion)
         {
            this.mc_box.btn_create.visible = false;
            this.mc_box.txt_create.visible = false;
         }
         else
         {
            this.mc_box.btn_create.visible = true;
            this.mc_box.txt_create.visible = true;
         }
         Game.union_api.getUnionList(Game.nowSaveIndex,this._unionlistPage,this.ONEPAGECOUNT,this.updateUnionList);
      }
      
      private function updateUnionList(arr:Array) : void
      {
         var obj:Object = null;
         var ncount:Number = NaN;
         var ext:Object = null;
         if(this.mc_box.currentFrame != 1)
         {
            return;
         }
         var len:int = 0;
         if(arr == null)
         {
            len = 0;
            (this.mc_box["btn_lastpage"] as SimpleButton).alpha = 0.3;
            (this.mc_box["btn_lastpage"] as SimpleButton).mouseEnabled = false;
            (this.mc_box["btn_nextpage"] as SimpleButton).alpha = 0.3;
            (this.mc_box["btn_nextpage"] as SimpleButton).mouseEnabled = false;
         }
         else
         {
            len = int(arr.length);
         }
         if(this._unionlistPage > 1)
         {
            (this.mc_box["btn_lastpage"] as SimpleButton).alpha = 1;
            (this.mc_box["btn_lastpage"] as SimpleButton).mouseEnabled = true;
         }
         if(len < this.ONEPAGECOUNT)
         {
            (this.mc_box["btn_nextpage"] as SimpleButton).alpha = 0.3;
            (this.mc_box["btn_nextpage"] as SimpleButton).mouseEnabled = false;
         }
         else
         {
            (this.mc_box["btn_nextpage"] as SimpleButton).alpha = 1;
            (this.mc_box["btn_nextpage"] as SimpleButton).mouseEnabled = true;
         }
         (this.mc_box["txt_page"] as TextField).text = "" + this._unionlistPage;
         for(var i:int = 0; i < this.ONEPAGECOUNT; i++)
         {
            this.mc_box["mc_list_" + i]["txt_rank"].text = "";
            this.mc_box["mc_list_" + i]["txt_name"].text = "";
            this.mc_box["mc_list_" + i]["txt_president"].text = "";
            this.mc_box["mc_list_" + i]["txt_lv"].text = "";
            this.mc_box["mc_list_" + i]["txt_num"].text = "";
            this.mc_box["mc_list_" + i]["txt_exp"].text = "";
            this.mc_box["mc_list_" + i]["txt_fightnum"].text = "";
            this.mc_box["mc_list_" + i]["btn_apply"].visible = false;
            this.mc_box["mc_list_" + i].unionId = null;
            this.mc_box["mc_list_" + i].preId = null;
            if(Boolean(this.mc_box["mc_list_" + i]) && Boolean(arr) && Boolean(arr[i]))
            {
               obj = arr[i];
               ncount = Number(this.father.unionCount[int(obj.level)]);
               this.mc_box["mc_list_" + i]["txt_rank"].text = "" + ((this._unionlistPage - 1) * 12 + (i + 1));
               this.mc_box["mc_list_" + i]["txt_name"].text = obj.title;
               this.mc_box["mc_list_" + i]["txt_president"].text = obj.username;
               this.mc_box["mc_list_" + i]["txt_lv"].text = obj.level;
               this.mc_box["mc_list_" + i]["txt_num"].text = obj.count + "/" + ncount;
               this.mc_box["mc_list_" + i]["btn_apply"].visible = true;
               this.mc_box["mc_list_" + i].unionId = obj.unionId;
               this.mc_box["mc_list_" + i].preName = obj.username;
               (this.mc_box["mc_list_" + i]["btn_apply"] as SimpleButton).addEventListener(MouseEvent.CLICK,this.onJoinUnion);
               ext = {};
               ext = this.makeJsonObj(obj.extra);
               if(Boolean(ext.zdl))
               {
                  this.mc_box["mc_list_" + i]["txt_fightnum"].text = ext.zdl;
               }
               if(Boolean(ext.playerName))
               {
                  this.mc_box["mc_list_" + i]["txt_president"].text = ext.playerName;
               }
               if(this.father.IsHasUnion)
               {
                  (this.mc_box["mc_list_" + i]["btn_apply"] as SimpleButton).visible = false;
               }
            }
         }
      }
      
      protected function onJoinUnion(event:MouseEvent) : void
      {
         var ep:DisplayObject = null;
         var okFun:Function = null;
         var noFun:Function = null;
         var dofun:Function = null;
         ep = event.currentTarget.parent;
         if(Boolean(ep["unionId"]))
         {
            if(ep["preName"] == Game.gameData.username)
            {
               Game.uiGroup.checkTip.showCheck2("您不能加入自己的公会!",2);
               return;
            }
            okFun = function():void
            {
               Game.uiGroup.checkTip.showCheck2("申请成功!",2);
            };
            noFun = function(errs:String):void
            {
               Game.uiGroup.checkTip.showCheck2(errs,2);
            };
            dofun = function():void
            {
               var obj:Object = {};
               if(!Game.gameData.isZuobi)
               {
                  obj.zdl = Game.gameData.getAllDps();
                  obj.level = Game.gameData.level + 1;
               }
               Game.union_api.applyUnion(Game.nowSaveIndex,ep["unionId"],obj,okFun,noFun);
            };
            Game.uiGroup.checkTip.showCheck("确定要申请加入该公会吗?",dofun);
         }
      }
      
      private function makeJsonObj(str:String) : Object
      {
         if(str is String && str.indexOf("{") >= 0)
         {
            return JSON2.decode(str);
         }
         return {};
      }
      
      public function Release() : void
      {
         this._unionlistPage = 1;
         this.updateUnionList(null);
      }
   }
}

