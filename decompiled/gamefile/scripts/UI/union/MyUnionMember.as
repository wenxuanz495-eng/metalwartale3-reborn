package UI.union
{
   import com.adobe.serialization.json.JSON2;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class MyUnionMember
   {
      
      private var _sendAllFight:Boolean = false;
      
      private var _memberlistPage:int = 1;
      
      private var _asklistPage:int = 1;
      
      private const ONEPAGECOUNT:int = 12;
      
      private const ONEPAGECOUNT2:int = 12;
      
      private var _myUnionMemberList:Array = [];
      
      private var father:UnionUI = null;
      
      private var mc_box:MovieClip = null;
      
      public var mc_requestlist:MovieClip = null;
      
      public function MyUnionMember(mc0:UnionUI, mc1:MovieClip, mc2:MovieClip)
      {
         super();
         this.father = mc0;
         this.mc_box = mc1;
         this.mc_requestlist = mc2;
      }
      
      protected function onClickBtn(event:MouseEvent) : void
      {
         var btn:DisplayObject = event.currentTarget as DisplayObject;
         var name:String = btn.name;
         var noFun:Function = function(errs:String):void
         {
            Game.uiGroup.checkTip.showCheck2(errs,2);
            mc_requestlist.visible = false;
         };
         switch(name)
         {
            case "btn_nextpage2":
               ++this._asklistPage;
               (this.mc_requestlist["btn_lastpage2"] as SimpleButton).alpha = 1;
               (this.mc_requestlist["btn_lastpage2"] as SimpleButton).mouseEnabled = true;
               Game.union_api.getApplyList(Game.nowSaveIndex,this._asklistPage,this.ONEPAGECOUNT2,this.updateAskList,noFun);
               break;
            case "btn_lastpage2":
               if(--this._asklistPage <= 1)
               {
                  this._asklistPage = 1;
                  (this.mc_requestlist["btn_lastpage2"] as SimpleButton).alpha = 0.3;
                  (this.mc_requestlist["btn_lastpage2"] as SimpleButton).mouseEnabled = false;
               }
               else
               {
                  (this.mc_requestlist["btn_lastpage2"] as SimpleButton).alpha = 1;
                  (this.mc_requestlist["btn_lastpage2"] as SimpleButton).mouseEnabled = true;
               }
               Game.union_api.getApplyList(Game.nowSaveIndex,this._asklistPage,this.ONEPAGECOUNT2,this.updateAskList,noFun);
               break;
            case "btn_requestlist":
               this.mc_requestlist.visible = true;
               this.mc_requestlist.btn_close.addEventListener(MouseEvent.CLICK,this.onClickBtn);
               this.mc_requestlist.btn_lastpage2.addEventListener(MouseEvent.CLICK,this.onClickBtn);
               this.mc_requestlist.btn_nextpage2.addEventListener(MouseEvent.CLICK,this.onClickBtn);
               this.updateAskList(null);
               Game.union_api.getApplyList(Game.nowSaveIndex,1,12,this.updateAskList,noFun);
               break;
            case "btn_nextpage":
               if(this.mc_box.currentFrame == 3)
               {
                  ++this._memberlistPage;
                  (this.mc_box["btn_lastpage"] as SimpleButton).alpha = 1;
                  (this.mc_box["btn_lastpage"] as SimpleButton).mouseEnabled = true;
                  this.updateMember(this._myUnionMemberList);
               }
               break;
            case "btn_lastpage":
               if(this.mc_box.currentFrame == 3)
               {
                  if(--this._memberlistPage <= 1)
                  {
                     this._memberlistPage = 1;
                     (this.mc_box["btn_lastpage"] as SimpleButton).alpha = 0.3;
                     (this.mc_box["btn_lastpage"] as SimpleButton).mouseEnabled = false;
                  }
                  else
                  {
                     (this.mc_box["btn_lastpage"] as SimpleButton).alpha = 1;
                     (this.mc_box["btn_lastpage"] as SimpleButton).mouseEnabled = true;
                  }
                  this.updateMember(this._myUnionMemberList);
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
      
      private function updateAskList(arr:Array) : void
      {
         var obj:Object = null;
         var ext:Object = null;
         var len:int = 0;
         if(arr == null)
         {
            len = 0;
            (this.mc_requestlist["btn_lastpage2"] as SimpleButton).alpha = 0.3;
            (this.mc_requestlist["btn_lastpage2"] as SimpleButton).mouseEnabled = false;
            (this.mc_requestlist["btn_nextpage2"] as SimpleButton).alpha = 0.3;
            (this.mc_requestlist["btn_nextpage2"] as SimpleButton).mouseEnabled = false;
         }
         else
         {
            len = int(arr.length);
         }
         if(this._asklistPage > 1)
         {
            (this.mc_requestlist["btn_lastpage2"] as SimpleButton).alpha = 1;
            (this.mc_requestlist["btn_lastpage2"] as SimpleButton).mouseEnabled = true;
         }
         if(len < this.ONEPAGECOUNT2)
         {
            (this.mc_requestlist["btn_nextpage2"] as SimpleButton).alpha = 0.3;
            (this.mc_requestlist["btn_nextpage2"] as SimpleButton).mouseEnabled = false;
         }
         else
         {
            (this.mc_requestlist["btn_nextpage2"] as SimpleButton).alpha = 1;
            (this.mc_requestlist["btn_nextpage2"] as SimpleButton).mouseEnabled = true;
         }
         (this.mc_requestlist["txt_page"] as TextField).text = "" + this._asklistPage;
         for(var i:int = 0; i < this.ONEPAGECOUNT2; i++)
         {
            this.mc_requestlist["mc_list_" + i]["txt_id"].text = "";
            this.mc_requestlist["mc_list_" + i]["txt_level"].text = "";
            this.mc_requestlist["mc_list_" + i]["txt_zdl"].text = "";
            this.mc_requestlist["mc_list_" + i]["btn_ok"].visible = false;
            this.mc_requestlist["mc_list_" + i]["btn_no"].visible = false;
            this.mc_requestlist["mc_list_" + i].userId = null;
            this.mc_requestlist["mc_list_" + i].userIndex = null;
            if(Boolean(this.mc_requestlist["mc_list_" + i]) && Boolean(arr) && Boolean(arr[i]))
            {
               obj = arr[i];
               this.mc_requestlist["mc_list_" + i]["txt_id"].text = "" + obj.userName;
               this.mc_requestlist["mc_list_" + i]["btn_ok"].visible = true;
               this.mc_requestlist["mc_list_" + i]["btn_no"].visible = true;
               this.mc_requestlist["mc_list_" + i].userId = obj.uId;
               this.mc_requestlist["mc_list_" + i].userIndex = obj.index;
               (this.mc_requestlist["mc_list_" + i]["btn_ok"] as SimpleButton).addEventListener(MouseEvent.CLICK,this.onAgree);
               (this.mc_requestlist["mc_list_" + i]["btn_no"] as SimpleButton).addEventListener(MouseEvent.CLICK,this.onUngree);
               ext = this.makeJsonObj(obj.extra);
               if(Boolean(ext.level))
               {
                  this.mc_requestlist["mc_list_" + i]["txt_level"].text = "" + ext.level;
               }
               if(Boolean(ext.zdl))
               {
                  this.mc_requestlist["mc_list_" + i]["txt_zdl"].text = "" + ext.zdl;
               }
            }
         }
      }
      
      private function updateMember(arr:Array) : void
      {
         var obj:Object = null;
         var userObj2:Object = null;
         if(this.mc_box.currentFrame != 3)
         {
            return;
         }
         this.setPrisedentArr(arr);
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
         if(this._memberlistPage > 1)
         {
            (this.mc_box["btn_lastpage"] as SimpleButton).alpha = 1;
            (this.mc_box["btn_lastpage"] as SimpleButton).mouseEnabled = true;
         }
         if(int(len / this.ONEPAGECOUNT) + 1 > this._memberlistPage)
         {
            (this.mc_box["btn_nextpage"] as SimpleButton).alpha = 1;
            (this.mc_box["btn_nextpage"] as SimpleButton).mouseEnabled = true;
         }
         else
         {
            (this.mc_box["btn_nextpage"] as SimpleButton).alpha = 0.3;
            (this.mc_box["btn_nextpage"] as SimpleButton).mouseEnabled = false;
         }
         (this.mc_box["txt_page"] as TextField).text = "" + this._memberlistPage;
         for(var i:int = 0; i < this.ONEPAGECOUNT; i++)
         {
            this.mc_box["mc_list_" + i]["txt_name"].text = "";
            this.mc_box["mc_list_" + i]["txt_type"].text = "";
            this.mc_box["mc_list_" + i]["txt_contribute"].text = "";
            this.mc_box["mc_list_" + i]["txt_level"].text = "";
            this.mc_box["mc_list_" + i]["txt_zdl"].text = "";
            this.mc_box["mc_list_" + i]["txt_tips"].text = "";
            this.mc_box["mc_list_" + i]["btn_kick"].visible = false;
            this.mc_box["mc_list_" + i].kickId = null;
            this.mc_box["mc_list_" + i].kickIndex = null;
            if(Boolean(this.mc_box["mc_list_" + i]) && Boolean(arr) && Boolean(arr[i + this.ONEPAGECOUNT * (this._memberlistPage - 1)]))
            {
               obj = arr[i + this.ONEPAGECOUNT * (this._memberlistPage - 1)];
               this.mc_box["mc_list_" + i]["txt_name"].text = obj.userName;
               this.mc_box["mc_list_" + i]["txt_contribute"].text = obj.contribution;
               if(this.father.IsPresident)
               {
                  this.mc_box["mc_list_" + i]["btn_kick"].visible = true;
               }
               this.mc_box["mc_list_" + i].kickId = obj.uId;
               this.mc_box["mc_list_" + i].kickIndex = obj.index;
               (this.mc_box["mc_list_" + i]["btn_kick"] as SimpleButton).addEventListener(MouseEvent.CLICK,this.onKickMember);
               if(this.father.UnionPreID == obj.userName)
               {
                  this.mc_box["mc_list_" + i]["btn_kick"].visible = false;
               }
               userObj2 = {};
               userObj2 = this.makeJsonObj(obj.extra);
               if(Boolean(userObj2.level))
               {
                  this.mc_box["mc_list_" + i]["txt_level"].text = "" + userObj2.level;
               }
               if(Boolean(userObj2.zdl))
               {
                  this.mc_box["mc_list_" + i]["txt_zdl"].text = "" + userObj2.zdl;
               }
               if(Boolean(userObj2.tips))
               {
                  this.mc_box["mc_list_" + i]["txt_tips"].text = "" + userObj2.tips;
               }
               if(Boolean(userObj2.post))
               {
                  this.mc_box["mc_list_" + i]["txt_type"].text = "" + userObj2.post;
               }
               if(Boolean(userObj2.playerName))
               {
                  this.mc_box["mc_list_" + i]["txt_name"].text = "" + userObj2.playerName;
               }
            }
         }
         if(Boolean(arr))
         {
            this._myUnionMemberList = arr;
         }
      }
      
      private function setPrisedentArr(arr:Array) : void
      {
         var obj:Object = null;
         var userObj2:Object = null;
         if(arr == null)
         {
            return;
         }
         var zdlcount:int = 0;
         var tempTeamer:Object = null;
         for(var i:int = 0; i < arr.length; i++)
         {
            if(Boolean(arr[i]))
            {
               obj = arr[i];
               userObj2 = {};
               userObj2 = this.makeJsonObj(obj.extra);
               if(userObj2.post == "会长")
               {
                  tempTeamer = obj;
                  arr.splice(i,1);
               }
               if(Boolean(userObj2.zdl))
               {
                  zdlcount += int(userObj2.zdl);
               }
            }
         }
         if(Boolean(tempTeamer))
         {
            arr.unshift(tempTeamer);
         }
         this.father.ExtraUnionObj2.zdl = zdlcount;
         if(this._sendAllFight == false)
         {
            this._sendAllFight = true;
            Game.union_api.setUnionExtra(Game.nowSaveIndex,0,this.father.ExtraUnionObj2,this.father.MyUnionID);
         }
      }
      
      private function updateMyUnion(data:Object) : void
      {
         var jumfun:Function = null;
         if(data.unionInfo == null && data.member == null)
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
         if(data.unionInfo.userName == data.member.userName && data.unionInfo.index == Game.nowSaveIndex)
         {
            this.father.IsPresident = true;
            if(Boolean(this.mc_box["btn_dissolve"]))
            {
               this.mc_box["btn_dissolve"].visible = true;
            }
         }
         if(this.mc_box.currentFrame == 3)
         {
            this.father.MyUnionID = data.unionInfo.id;
            this.getMember(this.father.MyUnionID);
            return;
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
      
      private function getMember(unionid:int) : void
      {
         var noFun:Function = function(errs:String):void
         {
            Game.uiGroup.checkTip.showCheck2(errs,2);
            father.InitBox(1);
            father.hideAllWindows();
         };
         Game.union_api.getUnionMembers(Game.nowSaveIndex,unionid,this.updateMember,noFun);
      }
      
      protected function onKickMember(event:MouseEvent) : void
      {
         var ep:DisplayObject = null;
         var okFun:Function = null;
         var noFun:Function = null;
         var dofun:Function = null;
         ep = event.currentTarget.parent;
         if(Boolean(ep["kickId"]))
         {
            okFun = function():void
            {
               var obj:Object = null;
               Game.uiGroup.checkTip.showCheck2("踢出成功!",2);
               for(var i:int = 0; i < _myUnionMemberList.length; i++)
               {
                  obj = _myUnionMemberList[i];
                  if(obj.uId == ep["kickId"] && ep["kickIndex"] == obj.index)
                  {
                     _myUnionMemberList.splice(i,1);
                     break;
                  }
               }
               updateMember(_myUnionMemberList);
            };
            noFun = function(errs:String):void
            {
               Game.uiGroup.checkTip.showCheck2(errs,2);
            };
            dofun = function():void
            {
               Game.union_api.removeMember(Game.nowSaveIndex,ep["kickId"],ep["kickIndex"],okFun,noFun);
            };
            Game.uiGroup.checkTip.showCheck("确定要踢出该玩家吗?",dofun);
         }
      }
      
      protected function onUngree(event:MouseEvent) : void
      {
         var okFun:Function = null;
         var noFun:Function = null;
         var ep:DisplayObject = event.currentTarget.parent;
         if(Boolean(ep["userId"]))
         {
            ep["btn_no"].visible = false;
            ep["btn_ok"].visible = false;
            okFun = function():void
            {
               Game.uiGroup.checkTip.showCheck2("拒绝申请成功!",2);
            };
            noFun = function(errs:String):void
            {
               Game.uiGroup.checkTip.showCheck2(errs,2);
            };
            Game.union_api.auditMember(Game.nowSaveIndex,ep["userId"],ep["userIndex"],0,okFun,noFun);
         }
      }
      
      protected function onAgree(event:MouseEvent) : void
      {
         var okFun:Function = null;
         var noFun:Function = null;
         var ep:DisplayObject = event.currentTarget.parent;
         if(Boolean(ep["userId"]))
         {
            ep["btn_no"].visible = false;
            ep["btn_ok"].visible = false;
            okFun = function():void
            {
               Game.uiGroup.checkTip.showCheck2("成功接受申请!",2);
            };
            noFun = function(errs:String):void
            {
               Game.uiGroup.checkTip.showCheck2(errs,2);
            };
            Game.union_api.auditMember(Game.nowSaveIndex,ep["userId"],ep["userIndex"],1,okFun,noFun);
         }
      }
      
      public function Init() : void
      {
         this.mc_box.gotoAndStop(3);
         this._memberlistPage = 1;
         this.updateMember(null);
         if(this.father.MyUnionID > 0)
         {
            this.getMember(this.father.MyUnionID);
         }
         else
         {
            Game.union_api.getOwnUnion(Game.nowSaveIndex,this.updateMyUnion);
         }
         this.mc_box.btn_requestlist.visible = true;
         this.mc_box.txt_requestlist.visible = true;
         this.mc_box.txt_requestlist.mouseEnabled = false;
         this.mc_box.btn_requestlist.addEventListener(MouseEvent.CLICK,this.onClickBtn);
         this.mc_box.btn_lastpage.addEventListener(MouseEvent.CLICK,this.onClickBtn);
         this.mc_box.btn_nextpage.addEventListener(MouseEvent.CLICK,this.onClickBtn);
         if(!this.father.IsPresident)
         {
            this.mc_box.btn_requestlist.visible = false;
            this.mc_box.txt_requestlist.visible = false;
         }
      }
      
      public function Release() : void
      {
         this._memberlistPage = 1;
         this._asklistPage = 1;
         this._myUnionMemberList = [];
         this.updateMember(null);
      }
   }
}

