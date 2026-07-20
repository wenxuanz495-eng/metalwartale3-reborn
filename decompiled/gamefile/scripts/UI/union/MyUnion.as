package UI.union
{
   import com.adobe.serialization.json.JSON2;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MyUnion
   {
      
      private var _sendedMyInfo:Boolean = false;
      
      private var _unionDayGift:Array = [];
      
      private var father:UnionUI = null;
      
      private var mc_box:MovieClip = null;
      
      public var mc_donate:MovieClip = null;
      
      private var _data:* = null;
      
      public function MyUnion(mc0:UnionUI, mc1:MovieClip, mc2:MovieClip)
      {
         super();
         this.father = mc0;
         this.mc_box = mc1;
         this.mc_donate = mc2;
      }
      
      protected function onClickBtn(event:MouseEvent) : void
      {
         var noFun:Function = null;
         var hasc:int = 0;
         var okFun:Function = null;
         var btn:DisplayObject = event.currentTarget as DisplayObject;
         var name:String = btn.name;
         switch(name)
         {
            case "btn_contriG":
               noFun = function(e:MouseEvent):void
               {
                  mc_donate.visible = false;
               };
               this.mc_donate.visible = true;
               this.mc_donate["txt_title"].text = "金币捐献";
               this.mc_donate["txt_typ1"].text = "G";
               this.mc_donate["txt_typ2"].text = "G";
               this.mc_donate["txt_typ3"].text = "G";
               hasc = 1 - Game.gameData.giftData.GetUnionContriG();
               if(hasc <= 0)
               {
                  this.mc_box.btn_contriG.alpha = 0.3;
                  this.mc_box.btn_contriG.mouseEnabled = false;
               }
               else
               {
                  this.mc_box.btn_contriG.alpha = 1;
                  this.mc_box.btn_contriG.mouseEnabled = true;
               }
               this.mc_donate["txt_hasCount"].text = "" + hasc;
               this.mc_donate["txt_donateNum"].text = "100万";
               this.mc_donate["txt_getNum"].text = "50";
               this.mc_donate.btn_close.addEventListener(MouseEvent.CLICK,this.onClickBtn);
               this.mc_donate.btn_ok.addEventListener(MouseEvent.CLICK,this.onDonateBtn);
               this.mc_donate.btn_no.addEventListener(MouseEvent.CLICK,noFun);
               break;
            case "btn_contriM":
               noFun = function(e:MouseEvent):void
               {
                  mc_donate.visible = false;
               };
               this.mc_donate.visible = true;
               this.mc_donate["txt_title"].text = "M币捐献";
               this.mc_donate["txt_typ1"].text = "M";
               this.mc_donate["txt_typ2"].text = "M";
               this.mc_donate["txt_typ3"].text = "M";
               hasc = 5 - Game.gameData.giftData.GetUnionContriM();
               if(hasc <= 0)
               {
                  this.mc_box.btn_contriM.alpha = 0.3;
                  this.mc_box.btn_contriM.mouseEnabled = false;
               }
               else
               {
                  this.mc_box.btn_contriM.alpha = 1;
                  this.mc_box.btn_contriM.mouseEnabled = true;
               }
               this.mc_donate["txt_hasCount"].text = "" + hasc;
               this.mc_donate["txt_donateNum"].text = "50 ";
               this.mc_donate["txt_getNum"].text = "100";
               this.mc_donate.btn_close.addEventListener(MouseEvent.CLICK,this.onClickBtn);
               this.mc_donate.btn_ok.addEventListener(MouseEvent.CLICK,this.onDonateBtn);
               this.mc_donate.btn_no.addEventListener(MouseEvent.CLICK,noFun);
               break;
            case "btn_notice":
               okFun = function():void
               {
                  Game.uiGroup.checkTip.showCheck2("修改公告成功!",2);
                  father.hideAllWindows();
               };
               noFun = function(errs:String):void
               {
                  Game.uiGroup.checkTip.showCheck2(errs,2);
                  father.hideAllWindows();
               };
               if((this.mc_box["txt_notice"].text as String).length > 80)
               {
                  Game.uiGroup.checkTip.showCheck2("公告请不要超过80个汉字!",2);
                  return;
               }
               if(Boolean(this.mc_box["txt_notice"]))
               {
                  this.father.ExtraUnionObj1.notice = Game.sensitiveWords.encode(this.mc_box["txt_notice"].text);
               }
               Game.union_api.setUnionExtra(Game.nowSaveIndex,1,this.father.ExtraUnionObj1,this.father.MyUnionID,okFun,noFun);
               break;
            case "btn_getWelfare":
               Game.gameData.giftData.AddUnionContriGift();
               this.mc_box.btn_getWelfare.alpha = 0.3;
               this.mc_box.btn_getWelfare.mouseEnabled = false;
               Game.uiGroup.checkTip.showCheck2("领取成功!",2);
               Game.uiGroup.addGift_byArr(this._unionDayGift,true,Game.gameData.level,false);
               Game.uiGroup.changeUI.materialsUI.fleshAll();
               Game.uiGroup.infoUI.fleshData();
               Game.uiGroup.saveDataNoUI();
               break;
            case "btn_leave":
               Game.uiGroup.checkTip.showCheck("退出公会后你的公会贡献将全部清零！是否确定？",this.sureExitUnion);
               break;
            case "btn_dissolve":
               Game.uiGroup.checkTip.showCheck("解散公会后你的公会贡献将全部清零！是否确定？",this.sureDissolve);
               break;
            case "btn_undissolve":
               Game.uiGroup.checkTip.showCheck("是否要取消解散？",this.sureUnDissolve);
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
      
      public function Init(iscache:Boolean = true) : void
      {
         var hasMC:int;
         var hasGC:int;
         var hasGift:int;
         var nofun:Function;
         this.mc_box.gotoAndStop(2);
         this.mc_box.btn_notice.addEventListener(MouseEvent.CLICK,this.onClickBtn);
         this.mc_box.btn_getWelfare.addEventListener(MouseEvent.CLICK,this.onClickBtn);
         this.mc_box.btn_leave.addEventListener(MouseEvent.CLICK,this.onClickBtn);
         this.mc_box.btn_dissolve.addEventListener(MouseEvent.CLICK,this.onClickBtn);
         this.mc_box.btn_undissolve.addEventListener(MouseEvent.CLICK,this.onClickBtn);
         this.mc_box.btn_contriG.addEventListener(MouseEvent.CLICK,this.onClickBtn);
         this.mc_box.btn_contriM.addEventListener(MouseEvent.CLICK,this.onClickBtn);
         this.mc_box["btn_dissolve"].visible = false;
         this.mc_box["btn_undissolve"].visible = false;
         hasMC = 5 - Game.gameData.giftData.GetUnionContriM();
         hasGC = 1 - Game.gameData.giftData.GetUnionContriG();
         hasGift = 1 - Game.gameData.giftData.GetUnionContriGift();
         this.mc_box.txt_contriGCount.text = "" + hasGC;
         this.mc_box.txt_contriMCount.text = "" + hasMC;
         if(hasMC <= 0)
         {
            this.mc_box.btn_contriM.alpha = 0.3;
            this.mc_box.btn_contriM.mouseEnabled = false;
         }
         else
         {
            this.mc_box.btn_contriM.alpha = 1;
            this.mc_box.btn_contriM.mouseEnabled = true;
         }
         if(hasGC <= 0)
         {
            this.mc_box.btn_contriG.alpha = 0.3;
            this.mc_box.btn_contriG.mouseEnabled = false;
         }
         else
         {
            this.mc_box.btn_contriG.alpha = 1;
            this.mc_box.btn_contriG.mouseEnabled = true;
         }
         if(hasGift <= 0)
         {
            this.mc_box.btn_getWelfare.alpha = 0.3;
            this.mc_box.btn_getWelfare.mouseEnabled = false;
         }
         else
         {
            this.mc_box.btn_getWelfare.alpha = 1;
            this.mc_box.btn_getWelfare.mouseEnabled = true;
         }
         nofun = function(err:String):void
         {
            Game.uiGroup.checkTip.showCheck2(err,2);
         };
         Game.union_api.getOwnUnion(Game.nowSaveIndex,this.updateMyUnion,nofun,iscache);
      }
      
      private function updateMyUnion(data1:Object) : void
      {
         var toexp:int;
         var ext:Object;
         var ext2:Object;
         var personExt:Object;
         var jumfun:Function = null;
         var obj:Object = null;
         this._data = data1;
         if(data1.unionInfo == null && data1.member == null)
         {
            jumfun = function():void
            {
               father.InitBox(1);
            };
            this.father.IsHasUnion = false;
            Game.uiGroup.checkTip.showCheck2("您还没有加入任何公会,请先加入公会!",2,jumfun);
            return;
         }
         this.father.IsHasUnion = true;
         if(data1.unionInfo.userName == data1.member.userName && data1.unionInfo.index == Game.nowSaveIndex)
         {
            this.father.IsPresident = true;
            this.mc_box["btn_dissolve"].visible = true;
            this.mc_box.btn_notice.visible = true;
            this.mc_box["txt_notice"].mouseEnabled = true;
            if(data1.unionInfo.dissolveDate != null && data1.unionInfo.dissolveDate != "" && data1.unionInfo.dissolveDate != "0")
            {
               this.mc_box["btn_dissolve"].visible = false;
               this.mc_box["btn_undissolve"].visible = true;
            }
         }
         else
         {
            this.mc_box.btn_notice.visible = false;
            this.mc_box["txt_notice"].mouseEnabled = false;
         }
         if(this.mc_box.currentFrame != 2)
         {
            return;
         }
         this.father.UnionPreID = data1.unionInfo.userName;
         this.father.UnionLevel = int(data1.unionInfo.level);
         this.father.MemberLevel = this.father.GetMemberLevel(data1.member.contribution);
         this.father.MyUnionID = data1.unionInfo.id;
         this.father.MyUnionName = data1.unionInfo.title;
         Game.gameData.groupData.name = data1.unionInfo.title;
         toexp = 9999999;
         if(Boolean(this.father.unionExp[this.father.UnionLevel]))
         {
            toexp = int(this.father.unionExp[this.father.UnionLevel]);
         }
         this.mc_box["txt_name"].text = "" + data1.unionInfo.title;
         this.mc_box["txt_president"].text = "" + data1.unionInfo.userName;
         this.mc_box["txt_rank"].text = "" + data1.unionInfo.id;
         this.mc_box["txt_lv"].text = "" + data1.unionInfo.level;
         this.mc_box["txt_exp"].text = "" + data1.unionInfo.contribution + "/" + toexp;
         this.mc_box["txt_myexp"].text = data1.member.contribution;
         ext = null;
         ext2 = null;
         personExt = null;
         ext = this.makeJsonObj(data1.unionInfo.extra);
         ext2 = this.makeJsonObj(data1.unionInfo.extra2);
         personExt = this.makeJsonObj(data1.member.extra);
         if(Boolean(ext.notice))
         {
            this.mc_box["txt_notice"].text = ext.notice;
            this.father.ExtraUnionObj1.notice = ext.notice;
         }
         if(Boolean(ext.playerName))
         {
            this.mc_box["txt_president"].text = ext.playerName;
         }
         if(Boolean(ext2.zdl))
         {
            this.mc_box["txt_zdl"].text = ext2.zdl;
            this.father.ExtraUnionObj2.zdl = ext2.zdl;
         }
         if(Boolean(personExt.post))
         {
            if(this.father.IsPresident)
            {
               this.mc_box["txt_post"].text = "会长";
            }
            else
            {
               this.mc_box["txt_post"].text = this.father.GetPost(data1.member.contribution) + "(还剩" + this.father.GetNextPostExp(data1.member.contribution) + "贡献值升级到" + this.father.GetNextPost(data1.member.contribution) + ")";
            }
         }
         this.setDayGift(data1.member.contribution,data1.unionInfo.level);
         Game.union_api.getUnionMembers(Game.nowSaveIndex,this.father.MyUnionID,this.updateMember);
         if(!this._sendedMyInfo && !Game.gameData.isZuobi)
         {
            this._sendedMyInfo = true;
            obj = {};
            obj.zdl = Game.gameData.getAllDps();
            obj.level = Game.gameData.level + 1;
            obj.playerName = Game.gameData.playerName;
            obj.post = this.father.GetPost(data1.member.contribution);
            Game.union_api.setMemberExtra(Game.nowSaveIndex,1,obj);
            if(this.father.IsPresident)
            {
               if(Boolean(this.father.ExtraUnionObj2.zdl))
               {
                  this.father.ExtraUnionObj1.zdl = this.father.ExtraUnionObj2.zdl;
               }
               this.father.ExtraUnionObj1.playerName = Game.gameData.playerName;
               Game.union_api.setUnionExtra(Game.nowSaveIndex,1,this.father.ExtraUnionObj1,this.father.MyUnionID);
            }
         }
      }
      
      private function setDayGift(mycontri:int, unionLv:int) : void
      {
         var postLv:int = 1;
         for(var i:int = this.father.postExp.length - 1; i >= 0; i--)
         {
            if(mycontri >= this.father.postExp[i])
            {
               break;
            }
            postLv = i + 1;
         }
         if(this.father.IsPresident)
         {
            postLv = int(this.father.postExp.length);
         }
         var medalPrize:int = int(this.father.postPrize1[postLv - 1]);
         var relifePrize:int = int(this.father.postPrize2[postLv - 1]);
         var coinpriz:Number = int(10000 * Math.pow(unionLv,4 / 7) * (1 + postLv / 10));
         if(this.father.IsPresident)
         {
            medalPrize = 10 * unionLv;
            coinpriz = int(30000 * Math.pow(unionLv,4 / 7));
         }
         this.mc_box["txt_gift_1"].text = "" + medalPrize;
         this.mc_box["txt_gift_2"].text = "" + relifePrize;
         this.mc_box["txt_gift_3"].text = "" + coinpriz;
         this._unionDayGift.push("GCoin," + coinpriz + ",1");
         this._unionDayGift.push("props,rebirth_crystal," + relifePrize);
         this._unionDayGift.push("props,justice2_badge," + medalPrize);
      }
      
      private function updateMember(arr:Array) : void
      {
         var num:int = 0;
         if(this.mc_box.currentFrame == 2)
         {
            num = 50;
            if(Boolean(this.father.unionCount[this.father.UnionLevel]))
            {
               num = int(this.father.unionCount[this.father.UnionLevel]);
            }
            this.mc_box["txt_num"].text = "" + arr.length + "/" + num;
            return;
         }
      }
      
      private function onDonateBtn(e:MouseEvent) : void
      {
         var hasM:Number = NaN;
         var okFun:Function = null;
         var hasG:Number = NaN;
         var okFun2:Function = null;
         var nofun:Function = function(errs:String):void
         {
            Game.uiGroup.checkTip.showCheck2(errs,2);
            father.hideAllWindows();
         };
         if(this.mc_donate["txt_typ1"].text == "M")
         {
            hasM = Game.gameData.MCoin;
            if(isNaN(hasM) || hasM < 50)
            {
               Game.uiGroup.checkTip.showCheck2("M币不足,无法捐献!",2);
               return;
            }
            okFun = function():void
            {
               Game.gameData.propsItems.addItems("superalloyStone",2);
               Game.uiGroup.checkTip.showCheck2("捐献成功并获得2个原石!",2);
               father.hideAllWindows();
               Game.gameData.giftData.AddUnionContriM();
               var hasMC:int = 5 - Game.gameData.giftData.GetUnionContriM();
               mc_box.txt_contriMCount.text = "" + hasMC;
               if(hasMC <= 0)
               {
                  mc_box.btn_contriM.alpha = 0.3;
                  mc_box.btn_contriM.mouseEnabled = false;
               }
               Game.gameData.addMCoin(-50);
               Game.uiGroup.infoUI.fleshData();
               Game.uiGroup.saveDataNoUI();
               Init(false);
            };
            Game.union_api.doExchange(Game.nowSaveIndex,50,okFun,nofun);
         }
         else if(this.mc_donate["txt_typ1"].text == "G")
         {
            hasG = Game.gameData.GCoin;
            if(isNaN(hasG) || hasG < 1000000)
            {
               Game.uiGroup.checkTip.showCheck2("G币不足,无法捐献!",2);
               return;
            }
            okFun2 = function():void
            {
               Game.uiGroup.checkTip.showCheck2("捐献成功!",2);
               father.hideAllWindows();
               Game.gameData.giftData.AddUnionContriG();
               var hasGC:int = 1 - Game.gameData.giftData.GetUnionContriG();
               mc_box.txt_contriGCount.text = "" + hasGC;
               if(hasGC <= 0)
               {
                  mc_box.btn_contriG.alpha = 0.3;
                  mc_box.btn_contriG.mouseEnabled = false;
               }
               Game.gameData.addCoin(-1000000);
               Game.uiGroup.infoUI.fleshData();
               Game.uiGroup.saveDataNoUI();
               Init(false);
            };
            Game.union_api.doTask(Game.nowSaveIndex,"8",okFun2,nofun);
         }
      }
      
      private function sureUnDissolve() : void
      {
         var okFun:Function = function(str:String):void
         {
            Game.uiGroup.checkTip.showCheck2("公会取消解散",2);
            mc_box["btn_dissolve"].visible = true;
            mc_box["btn_undissolve"].visible = false;
            _data.unionInfo.dissolveDate = "0";
            father.hideAllWindows();
         };
         var noFun:Function = function(errs:String):void
         {
            Game.uiGroup.checkTip.showCheck2(errs,2);
            father.hideAllWindows();
         };
         Game.union_api.dissolveUnion(Game.nowSaveIndex,0,okFun,noFun);
      }
      
      private function sureDissolve() : void
      {
         var okFun:Function = function(str:String):void
         {
            mc_box["btn_dissolve"].visible = false;
            mc_box["btn_undissolve"].visible = true;
            _data.unionInfo.dissolveDate = "1";
            Game.uiGroup.checkTip.showCheck2("公会将在 " + str + " 解散",2);
            father.hideAllWindows();
         };
         var noFun:Function = function(errs:String):void
         {
            Game.uiGroup.checkTip.showCheck2(errs,2);
            father.hideAllWindows();
         };
         Game.union_api.dissolveUnion(Game.nowSaveIndex,1,okFun,noFun);
      }
      
      private function sureExitUnion() : void
      {
         var okFun:Function = function():void
         {
            Game.uiGroup.checkTip.showCheck2("退出公会成功!",2);
            father.InitBox(1);
            father.hideAllWindows();
         };
         var noFun:Function = function(errs:String):void
         {
            Game.uiGroup.checkTip.showCheck2(errs,2);
            father.hideAllWindows();
         };
         Game.union_api.quitUion(Game.nowSaveIndex,okFun,noFun);
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
         this._sendedMyInfo = false;
         this._unionDayGift = [];
      }
   }
}

