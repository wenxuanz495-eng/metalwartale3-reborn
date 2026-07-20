package gameAll.api
{
   import com.adobe.serialization.json.JSON2;
   import flash.display.Stage;
   import flash.utils.getTimer;
   import unit4399.events.UnionEvent;
   
   public class Union_API
   {
      
      public const ASKDELAY:int = 30000;
      
      private var _unionCreateYesFun:Function = null;
      
      private var _unionCreateNoFun:Function = null;
      
      private var _getUnionListLT:Object = {"time":-1};
      
      private var _getUnionListObj:* = null;
      
      private var _getUnionListYesFun:Function = null;
      
      private var _getUnionListNoFun:Function = null;
      
      private var _applyUnionYesFun:Function = null;
      
      private var _applyUnionNoFun:Function = null;
      
      private var _getOwnUnionLT:Object = {"time":-1};
      
      private var _getOwnUnionObj:* = null;
      
      private var _getOwnUnionYesFun:Function = null;
      
      private var _getOwnUnionNoFun:Function = null;
      
      private var _getUnionMembersObj:* = null;
      
      private var _getUnionMembersLT:Object = {"time":-1};
      
      private var _getUnionMembersYesFun:Function = null;
      
      private var _getUnionMembersNoFun:Function = null;
      
      private var _setMemberExtraYesFun:Function = null;
      
      private var _setMemberExtraNoFun:Function = null;
      
      private var _setUnionExtraYesFun:Function = null;
      
      private var _setUnionExtraNoFun:Function = null;
      
      private var _getUnionLogYesFun:Function = null;
      
      private var _getUnionLogNoFun:Function = null;
      
      private var _quitUionYesFun:Function = null;
      
      private var _quitUionNoFun:Function = null;
      
      private var _doTaskYesFun:Function = null;
      
      private var _doTaskNoFun:Function = null;
      
      private var _doExchangeYesFun:Function = null;
      
      private var _doExchangeNoFun:Function = null;
      
      private var _getApplyListYesFun:Function = null;
      
      private var _getApplyListNoFun:Function = null;
      
      private var _auditMemberYesFun:Function = null;
      
      private var _auditMemberNoFun:Function = null;
      
      private var _removeMemberYesFun:Function = null;
      
      private var _removeMemberNoFun:Function = null;
      
      private var _dissolveUnionYesFun:Function = null;
      
      private var _dissolveUnionNoFun:Function = null;
      
      private var _getVariablesYesFun:Function = null;
      
      private var _getVariablesNoFun:Function = null;
      
      private var _doVariableYesFun:Function = null;
      
      private var _doVariableNoFun:Function = null;
      
      public function Union_API()
      {
         super();
      }
      
      public function init(stage:Stage) : void
      {
         stage.addEventListener(UnionEvent.UNION_VISITOR_SUCCESS,this.onVisitorSuccess);
         stage.addEventListener(UnionEvent.UNION_MEMBER_SUCCESS,this.onMemberSuccess);
         stage.addEventListener(UnionEvent.UNION_GROW_SUCCESS,this.onGrowSuccess);
         stage.addEventListener(UnionEvent.UNION_MASTER_SUCCESS,this.onMasterSuccess);
         stage.addEventListener(UnionEvent.UNION_VARIABLES_SUCCESS,this.onVariablesSuccess);
         stage.addEventListener(UnionEvent.UNION_ERROR,this.unionCreateError);
      }
      
      public function unionCreate(idx:int, title:String, extra:String, _yesFun:Function = null, _noFun:Function = null) : void
      {
         this._unionCreateYesFun = null;
         this._unionCreateNoFun = null;
         this._unionCreateYesFun = _yesFun;
         this._unionCreateNoFun = _noFun;
         if(!Game.serviceHold)
         {
            var createState:Object = this.getLocalState(false);
            if(createState.exists)
            {
               if(_noFun is Function)
               {
                  _noFun("您已经加入本地公会了！");
               }
            }
            else
            {
               Game.gameData.offlineUnion = this.makeLocalUnion(title,idx,extra);
               this.saveLocalState();
               if(_yesFun is Function)
               {
                  _yesFun();
               }
            }
            this._unionCreateYesFun = null;
            this._unionCreateNoFun = null;
            return;
         }
         if(Boolean(Game.serviceHold))
         {
            this.isShowLoading(true);
            Game.serviceHold.unionCreate(idx,title,extra);
         }
         else if(this._unionCreateNoFun is Function)
         {
            this._unionCreateNoFun("网络错误！");
            this._unionCreateYesFun = null;
            this._unionCreateNoFun = null;
         }
      }
      
      public function getUnionList(idx:int, pageNum:int, pageSize:int, _yesFun:Function = null, _noFun:Function = null, iscache:Boolean = true) : void
      {
         this._getUnionListYesFun = null;
         this._getUnionListNoFun = null;
         this._getUnionListYesFun = _yesFun;
         this._getUnionListNoFun = _noFun;
         if(!Game.serviceHold)
         {
            var listState:Object = this.getLocalState(false);
            var localList:Array = [];
            if(listState.exists && pageNum == 1)
            {
               localList.push(this.getLocalListItem(listState.unionInfo));
            }
            this._getUnionListObj = localList;
            if(_yesFun is Function)
            {
               _yesFun(localList);
            }
            this._getUnionListYesFun = null;
            this._getUnionListNoFun = null;
            return;
         }
         if(iscache && !this.checkCanAsk(this._getUnionListLT))
         {
            if(Boolean(this._getUnionListObj))
            {
               this._getUnionListYesFun(this._getUnionListObj);
            }
            this._getUnionListYesFun = null;
            this._getUnionListNoFun = null;
            return;
         }
         if(Boolean(Game.serviceHold))
         {
            this.isShowLoading(true);
            Game.serviceHold.getUnionList(idx,pageNum,pageSize);
         }
         else if(this._getUnionListNoFun is Function)
         {
            this._getUnionListNoFun("网络错误！");
            this._getUnionListYesFun = null;
            this._getUnionListNoFun = null;
         }
      }
      
      public function applyUnion(idx:int, unionId:int, extra:Object, _yesFun:Function = null, _noFun:Function = null) : void
      {
         this._applyUnionYesFun = null;
         this._applyUnionNoFun = null;
         this._applyUnionYesFun = _yesFun;
         this._applyUnionNoFun = _noFun;
         if(!Game.serviceHold)
         {
            var applyState:Object = this.getLocalState(false);
            if(!applyState.exists)
            {
               Game.gameData.offlineUnion = this.makeLocalUnion("离线公会",idx,JSON2.encode({"notice":"本地单机公会","playerName":this.localPlayerName(),"zdl":Game.gameData.getAllDps(),"count":1}));
               this.saveLocalState();
            }
            if(_yesFun is Function)
            {
               _yesFun();
            }
            this._applyUnionYesFun = null;
            this._applyUnionNoFun = null;
            return;
         }
         var exstr:String = JSON2.encode(extra);
         if(Boolean(Game.serviceHold))
         {
            this.isShowLoading(true);
            Game.serviceHold.applyUnion(idx,unionId,exstr);
         }
         else if(this._applyUnionNoFun is Function)
         {
            this._applyUnionNoFun("网络错误！");
            this._applyUnionYesFun = null;
            this._applyUnionNoFun = null;
         }
      }
      
      public function getOwnUnion(idx:int, _yesFun:Function = null, _noFun:Function = null, iscache:Boolean = true) : void
      {
         this._getOwnUnionYesFun = null;
         this._getOwnUnionNoFun = null;
         this._getOwnUnionYesFun = _yesFun;
         this._getOwnUnionNoFun = _noFun;
         if(!Game.serviceHold)
         {
            var ownState:Object = this.getLocalState(true);
            var ownData:Object = {"unionInfo":null,"member":null};
            if(ownState.exists)
            {
               ownData.unionInfo = ownState.unionInfo;
               ownData.member = ownState.member;
            }
            this._getOwnUnionObj = ownData;
            if(_yesFun is Function)
            {
               _yesFun(ownData);
            }
            this._getOwnUnionYesFun = null;
            this._getOwnUnionNoFun = null;
            return;
         }
         if(iscache && !this.checkCanAsk(this._getOwnUnionLT))
         {
            if(Boolean(this._getOwnUnionObj))
            {
               this._getOwnUnionYesFun(this._getOwnUnionObj);
            }
            this._getOwnUnionYesFun = null;
            this._getOwnUnionNoFun = null;
            return;
         }
         if(Boolean(Game.serviceHold))
         {
            this.isShowLoading(true);
            Game.serviceHold.getOwnUnion(idx);
         }
         else if(this._getOwnUnionNoFun is Function)
         {
            this._getOwnUnionNoFun("网络错误！");
            this._getOwnUnionYesFun = null;
            this._getOwnUnionNoFun = null;
         }
      }
      
      public function getUnionMembers(idx:int, unionId:int, _yesFun:Function = null, _noFun:Function = null) : void
      {
         this._getUnionMembersYesFun = null;
         this._getUnionMembersNoFun = null;
         this._getUnionMembersYesFun = _yesFun;
         this._getUnionMembersNoFun = _noFun;
         if(!Game.serviceHold)
         {
            var memberState:Object = this.getLocalState(false);
            var memberList:Array = memberState.exists ? [memberState.member] : [];
            this._getUnionMembersObj = memberList;
            if(_yesFun is Function)
            {
               _yesFun(memberList);
            }
            this._getUnionMembersYesFun = null;
            this._getUnionMembersNoFun = null;
            return;
         }
         if(!this.checkCanAsk(this._getUnionMembersLT))
         {
            if(Boolean(this._getUnionMembersObj))
            {
               this._getUnionMembersYesFun(this._getUnionMembersObj);
            }
            this._getUnionMembersYesFun = null;
            this._getUnionMembersNoFun = null;
            return;
         }
         if(Boolean(Game.serviceHold))
         {
            this.isShowLoading(true);
            Game.serviceHold.getUnionMembers(idx,unionId);
         }
         else if(this._getOwnUnionNoFun is Function)
         {
            this._getOwnUnionNoFun("网络错误！");
            this._getUnionMembersYesFun = null;
            this._getUnionMembersNoFun = null;
         }
      }
      
      public function setMemberExtra(idx:int, type:int, extra:Object, unionId:int = 0, userId:int = 0, userIndex:int = 0, _yesFun:Function = null, _noFun:Function = null) : void
      {
         this._setMemberExtraYesFun = null;
         this._setMemberExtraNoFun = null;
         this._setMemberExtraYesFun = _yesFun;
         this._setMemberExtraNoFun = _noFun;
         if(!Game.serviceHold)
         {
            var memberExtraState:Object = this.getLocalState(false);
            if(memberExtraState.exists)
            {
               memberExtraState.member.extra = JSON2.encode(extra);
               this.saveLocalState();
            }
            if(_yesFun is Function)
            {
               _yesFun();
            }
            this._setMemberExtraYesFun = null;
            this._setMemberExtraNoFun = null;
            return;
         }
         var exstr:String = JSON2.encode(extra);
         if(Boolean(Game.serviceHold))
         {
            this.isShowLoading(true);
            Game.serviceHold.setMemberExtra(idx,type,exstr,unionId,userId,userIndex);
         }
         else if(this._getOwnUnionNoFun is Function)
         {
            this._getOwnUnionNoFun("网络错误！");
            this._setMemberExtraYesFun = null;
            this._setMemberExtraNoFun = null;
         }
      }
      
      public function setUnionExtra(idx:int, type:int, extra:Object, unionId:int, _yesFun:Function = null, _noFun:Function = null) : void
      {
         this._setUnionExtraYesFun = null;
         this._setUnionExtraNoFun = null;
         this._setUnionExtraYesFun = _yesFun;
         this._setUnionExtraNoFun = _noFun;
         if(!Game.serviceHold)
         {
            var unionExtraState:Object = this.getLocalState(false);
            if(unionExtraState.exists)
            {
               if(type == 0)
               {
                  unionExtraState.unionInfo.extra2 = JSON2.encode(extra);
               }
               else
               {
                  unionExtraState.unionInfo.extra = JSON2.encode(extra);
               }
               this.saveLocalState();
            }
            if(_yesFun is Function)
            {
               _yesFun();
            }
            this._setUnionExtraYesFun = null;
            this._setUnionExtraNoFun = null;
            return;
         }
         var extstr:String = JSON2.encode(extra);
         if(Boolean(Game.serviceHold))
         {
            this.isShowLoading(true);
            Game.serviceHold.setUnionExtra(idx,type,extstr,unionId);
         }
         else if(this._getOwnUnionNoFun is Function)
         {
            this._getOwnUnionNoFun("网络错误！");
            this._setUnionExtraYesFun = null;
            this._setUnionExtraNoFun = null;
         }
      }
      
      public function getUnionLog(idx:int, pageNum:int, pageSize:int, _yesFun:Function = null, _noFun:Function = null) : void
      {
         this._getUnionLogYesFun = null;
         this._getUnionLogNoFun = null;
         this._getUnionLogYesFun = _yesFun;
         this._getUnionLogNoFun = _noFun;
         if(!Game.serviceHold)
         {
            if(_yesFun is Function)
            {
               _yesFun([]);
            }
            this._getUnionLogYesFun = null;
            this._getUnionLogNoFun = null;
            return;
         }
         if(Boolean(Game.serviceHold))
         {
            this.isShowLoading(true);
            Game.serviceHold.getUnionLog(idx,pageNum,pageSize);
         }
         else if(this._getUnionLogNoFun is Function)
         {
            this._getOwnUnionNoFun("网络错误！");
            this._getUnionLogYesFun = null;
            this._getUnionLogNoFun = null;
         }
      }
      
      public function quitUion(idx:int, _yesFun:Function = null, _noFun:Function = null) : void
      {
         this._quitUionYesFun = null;
         this._quitUionNoFun = null;
         this._quitUionYesFun = _yesFun;
         this._quitUionNoFun = _noFun;
         if(!Game.serviceHold)
         {
            Game.gameData.offlineUnion = this.makeEmptyLocalState();
            this.saveLocalState();
            if(_yesFun is Function)
            {
               _yesFun();
            }
            this._quitUionYesFun = null;
            this._quitUionNoFun = null;
            return;
         }
         if(Boolean(Game.serviceHold))
         {
            this.isShowLoading(true);
            Game.serviceHold.quitUion(idx);
         }
         else if(this._quitUionNoFun is Function)
         {
            this._quitUionNoFun("网络错误！");
            this._quitUionYesFun = null;
            this._quitUionNoFun = null;
         }
      }
      
      public function doTask(idx:int, task:String, _yesFun:Function = null, _noFun:Function = null) : void
      {
         this._doTaskYesFun = null;
         this._doTaskNoFun = null;
         this._doTaskYesFun = _yesFun;
         this._doTaskNoFun = _noFun;
         if(!Game.serviceHold)
         {
            if(this.getLocalState(false).exists)
            {
               this.addLocalContribution(50,50);
               if(_yesFun is Function)
               {
                  _yesFun();
               }
            }
            else if(_noFun is Function)
            {
               _noFun("您还没有加入任何公会！");
            }
            this._doTaskYesFun = null;
            this._doTaskNoFun = null;
            return;
         }
         if(Boolean(Game.serviceHold))
         {
            this.isShowLoading(true);
            Game.serviceHold.doTask(idx,task);
         }
         else if(this._doTaskNoFun is Function)
         {
            this._doTaskNoFun("网络错误！");
            this._doTaskYesFun = null;
            this._doTaskNoFun = null;
         }
      }
      
      public function doExchange(idx:int, money:int, _yesFun:Function = null, _noFun:Function = null) : void
      {
         this._doExchangeYesFun = null;
         this._doExchangeNoFun = null;
         this._doExchangeYesFun = _yesFun;
         this._doExchangeNoFun = _noFun;
         if(!Game.serviceHold)
         {
            if(this.getLocalState(false).exists)
            {
               this.addLocalContribution(100,100);
               if(_yesFun is Function)
               {
                  _yesFun();
               }
            }
            else if(_noFun is Function)
            {
               _noFun("您还没有加入任何公会！");
            }
            this._doExchangeYesFun = null;
            this._doExchangeNoFun = null;
            return;
         }
         if(Boolean(Game.serviceHold))
         {
            this.isShowLoading(true);
            Game.serviceHold.doExchange(idx,money);
         }
         else if(this._doExchangeNoFun is Function)
         {
            this._doExchangeNoFun("网络错误！");
            this._doExchangeYesFun = null;
            this._doExchangeNoFun = null;
         }
      }
      
      public function getTaskValue(idx:int) : void
      {
         if(!Game.serviceHold)
         {
            return;
         }
         Game.serviceHold.getTaskValue(idx);
      }
      
      public function getApplyList(idx:int, pageNum:int, pageSize:int, _yesFun:Function = null, _noFun:Function = null) : void
      {
         this._getApplyListYesFun = null;
         this._getApplyListNoFun = null;
         this._getApplyListYesFun = _yesFun;
         this._getApplyListNoFun = _noFun;
         if(!Game.serviceHold)
         {
            if(_yesFun is Function)
            {
               _yesFun([]);
            }
            this._getApplyListYesFun = null;
            this._getApplyListNoFun = null;
            return;
         }
         if(Boolean(Game.serviceHold))
         {
            this.isShowLoading(true);
            Game.serviceHold.getApplyList(idx,pageNum,pageSize);
         }
         else if(this._getApplyListNoFun is Function)
         {
            this._getApplyListNoFun("网络错误！");
            this._getApplyListYesFun = null;
            this._getApplyListNoFun = null;
         }
      }
      
      public function auditMember(idx:int, userId:int, userIndex:int, auditResult:int, _yesFun:Function = null, _noFun:Function = null) : void
      {
         this._auditMemberYesFun = null;
         this._auditMemberNoFun = null;
         this._auditMemberYesFun = _yesFun;
         this._auditMemberNoFun = _noFun;
         if(!Game.serviceHold)
         {
            if(_yesFun is Function)
            {
               _yesFun();
            }
            this._auditMemberYesFun = null;
            this._auditMemberNoFun = null;
            return;
         }
         if(Boolean(Game.serviceHold))
         {
            this.isShowLoading(true);
            Game.serviceHold.auditMember(idx,userId,userIndex,auditResult);
         }
         else if(this._auditMemberNoFun is Function)
         {
            this._auditMemberNoFun("网络错误！");
            this._auditMemberYesFun = null;
            this._auditMemberNoFun = null;
         }
      }
      
      public function removeMember(idx:int, userId:int, userIndex:int, _yesFun:Function = null, _noFun:Function = null) : void
      {
         this._removeMemberYesFun = null;
         this._removeMemberNoFun = null;
         this._removeMemberYesFun = _yesFun;
         this._removeMemberNoFun = _noFun;
         if(!Game.serviceHold)
         {
            if(_noFun is Function)
            {
               _noFun("单机公会不能移除当前玩家！");
            }
            this._removeMemberYesFun = null;
            this._removeMemberNoFun = null;
            return;
         }
         if(Boolean(Game.serviceHold))
         {
            this.isShowLoading(true);
            Game.serviceHold.removeMember(idx,userId,userIndex);
         }
         else if(this._removeMemberNoFun is Function)
         {
            this._removeMemberNoFun("网络错误！");
            this._removeMemberYesFun = null;
            this._removeMemberNoFun = null;
         }
      }
      
      public function dissolveUnion(idx:int, actionType:int, _yesFun:Function = null, _noFun:Function = null) : void
      {
         this._dissolveUnionYesFun = null;
         this._dissolveUnionNoFun = null;
         this._dissolveUnionYesFun = _yesFun;
         this._dissolveUnionNoFun = _noFun;
         if(!Game.serviceHold)
         {
            var dissolveState:Object = this.getLocalState(false);
            if(dissolveState.exists)
            {
               dissolveState.unionInfo.dissolveDate = actionType == 0 ? "0" : "1";
               this.saveLocalState();
               if(_yesFun is Function)
               {
                  _yesFun(actionType == 0 ? "已取消" : "离线存档保留期间");
               }
            }
            this._dissolveUnionYesFun = null;
            this._dissolveUnionNoFun = null;
            return;
         }
         if(Boolean(Game.serviceHold))
         {
            this.isShowLoading(true);
            Game.serviceHold.dissolveUnion(idx,actionType);
         }
         else if(this._dissolveUnionNoFun is Function)
         {
            this._dissolveUnionNoFun("网络错误！");
            this._dissolveUnionYesFun = null;
            this._dissolveUnionNoFun = null;
         }
      }
      
      public function getVariables(idx:int, ids:Array, _yesFun:Function = null, _noFun:Function = null) : void
      {
         this._getVariablesYesFun = null;
         this._getVariablesNoFun = null;
         this._getVariablesYesFun = _yesFun;
         this._getVariablesNoFun = _noFun;
         if(!Game.serviceHold)
         {
            if(_yesFun is Function)
            {
               _yesFun(this.getLocalVariables(ids));
            }
            this._getVariablesYesFun = null;
            this._getVariablesNoFun = null;
            return;
         }
         if(Boolean(Game.serviceHold))
         {
            this.isShowLoading(true);
            Game.serviceHold.getVariables(idx,ids);
         }
         else if(this._getVariablesNoFun is Function)
         {
            this._getVariablesNoFun("网络错误！");
            this._getVariablesYesFun = null;
            this._getVariablesNoFun = null;
         }
      }
      
      public function doVariable(idx:int, id:int, _yesFun:Function = null, _noFun:Function = null) : void
      {
         this._doVariableYesFun = null;
         this._doVariableNoFun = null;
         this._doVariableYesFun = _yesFun;
         this._doVariableNoFun = _noFun;
         if(!Game.serviceHold)
         {
            this.changeLocalVariable(id);
            if(_yesFun is Function)
            {
               _yesFun(true);
            }
            this._doVariableYesFun = null;
            this._doVariableNoFun = null;
            return;
         }
         if(Boolean(Game.serviceHold))
         {
            this.isShowLoading(true);
            Game.serviceHold.doVariable(idx,id);
         }
         else if(this._doVariableNoFun is Function)
         {
            this._doVariableNoFun("网络错误！");
            this._doVariableYesFun = null;
            this._doVariableNoFun = null;
         }
      }
      
      private function onVisitorSuccess(e:UnionEvent) : void
      {
         var dataObj:Object = e.data;
         trace("apiName:" + dataObj.apiName + "\n");
         var data:* = dataObj.data;
         if(dataObj.data is String && dataObj.data.indexOf("{") >= 0)
         {
            data = JSON2.decode(dataObj.data);
         }
         switch(dataObj.apiName)
         {
            case UnionEvent.UNI_API_BHCJ:
               trace("帮会创建结果:\n" + Boolean(data) + "\n");
               this.isShowLoading(false);
               if(Boolean(data))
               {
                  this._unionCreateYesFun();
                  this._unionCreateYesFun = null;
                  this._unionCreateNoFun = null;
               }
               break;
            case UnionEvent.UNI_API_BHLB:
               trace("帮会列表:\n" + String(data) + "\n");
               this._getUnionListYesFun(data.unionList);
               this._getUnionListObj = data.unionList;
               this.isShowLoading(false);
               this._getUnionListNoFun = null;
               this._getUnionListYesFun = null;
               break;
            case UnionEvent.UNI_API_BHSQ:
               trace("帮会申请结果:\n" + Boolean(data) + "\n");
               this.isShowLoading(false);
               if(Boolean(data))
               {
                  this._applyUnionYesFun();
                  this._applyUnionYesFun = null;
                  this._applyUnionNoFun = null;
               }
               break;
            case UnionEvent.UNI_API_SSBH:
               trace("当前用户所属帮会信息:\n" + String(data) + "\n");
               this.isShowLoading(false);
               this._getOwnUnionYesFun(data);
               this._getOwnUnionObj = data;
               this._getOwnUnionNoFun = null;
               this._getOwnUnionYesFun = null;
         }
      }
      
      private function onMemberSuccess(e:UnionEvent) : void
      {
         var dataObj:Object = e.data;
         trace("apiName:" + dataObj.apiName + "\n");
         var data:* = dataObj.data;
         if(dataObj.data is String && dataObj.data.indexOf("{") >= 0)
         {
            data = JSON2.decode(dataObj.data);
         }
         switch(dataObj.apiName)
         {
            case UnionEvent.UNI_API_BHMX:
               trace("帮会明细结果:\n" + String(data) + "\n");
               break;
            case UnionEvent.UNI_API_BHCY:
               trace("帮会成员列表:\n" + String(data) + "\n");
               this.isShowLoading(false);
               this._getUnionMembersYesFun(data);
               this._getUnionMembersYesFun = null;
               this._getUnionMembersNoFun = null;
               this._getUnionMembersObj = data;
               break;
            case UnionEvent.UNI_API_CYTZBG:
               trace("成员拓展信息变更:\n" + Boolean(data) + "\n");
               if(Boolean(data) && Boolean(this._setMemberExtraYesFun))
               {
                  this._setMemberExtraYesFun();
                  this._setMemberExtraYesFun = null;
                  this._setMemberExtraNoFun = null;
               }
               break;
            case UnionEvent.UNI_API_BHTZBG:
               trace("帮会拓展信息变更:\n" + Boolean(data) + "\n");
               this.isShowLoading(false);
               if(Boolean(data) && Boolean(this._setUnionExtraYesFun))
               {
                  this._setUnionExtraYesFun();
                  this._setUnionExtraYesFun = null;
                  this._setUnionExtraNoFun = null;
               }
               break;
            case UnionEvent.UNI_API_BHRZ:
               trace("帮会行为记录列表:\n" + String(data) + "\n");
               break;
            case UnionEvent.UNI_API_TCBH:
               trace("退出帮会信息:\n" + Boolean(data) + "\n");
               if(Boolean(data))
               {
                  this.isShowLoading(false);
                  this._quitUionYesFun();
                  this._quitUionYesFun = null;
                  this._quitUionNoFun = null;
               }
         }
      }
      
      private function onGrowSuccess(e:UnionEvent) : void
      {
         var dataObj:Object = e.data;
         trace("apiName:" + dataObj.apiName + "\n");
         var data:* = dataObj.data;
         if(dataObj.data is String && dataObj.data.indexOf("{") >= 0)
         {
            data = JSON2.decode(dataObj.data);
         }
         switch(dataObj.apiName)
         {
            case UnionEvent.UNI_API_BHRW:
               trace("帮会任务结果:\n" + Boolean(data) + "\n");
               this.isShowLoading(false);
               if(Boolean(data) && this._doTaskYesFun != null)
               {
                  this._doTaskYesFun();
                  this._doTaskYesFun = null;
                  this._doTaskNoFun = null;
               }
               if(!Boolean(data) && this._doTaskNoFun != null)
               {
                  this._doTaskNoFun("审核失败");
                  this._doTaskYesFun = null;
                  this._doTaskNoFun = null;
               }
               break;
            case UnionEvent.UNI_API_BHDH:
               trace("帮会兑换信息:\n" + Boolean(data) + "\n");
               this.isShowLoading(false);
               if(Boolean(data))
               {
                  this._doExchangeYesFun();
                  this._doExchangeYesFun = null;
                  this._doExchangeNoFun = null;
               }
               else
               {
                  this._doExchangeNoFun("兑换失败");
                  this._doExchangeYesFun = null;
                  this._doExchangeNoFun = null;
               }
               break;
            case UnionEvent.UNI_API_BHRWWC:
               trace("帮会任务完成情况:\n" + String(data) + "\n");
         }
      }
      
      private function onMasterSuccess(e:UnionEvent) : void
      {
         var dataObj:Object = e.data;
         trace("apiName:" + dataObj.apiName + "\n");
         var data:* = dataObj.data;
         if(dataObj.data is String && dataObj.data.indexOf("{") >= 0)
         {
            data = JSON2.decode(dataObj.data);
         }
         switch(dataObj.apiName)
         {
            case UnionEvent.UNI_API_DSHLB:
               trace("待审核列表:\n" + String(data) + "\n");
               this.isShowLoading(false);
               this._getApplyListYesFun(data.applyList);
               this._getApplyListYesFun = null;
               this._getApplyListNoFun = null;
               break;
            case UnionEvent.UNI_API_CYSH:
               trace("成员审核信息:\n" + Boolean(data) + "\n");
               this.isShowLoading(false);
               if(Boolean(data))
               {
                  this._auditMemberYesFun();
                  this._auditMemberYesFun = null;
                  this._auditMemberNoFun = null;
               }
               else
               {
                  this._auditMemberNoFun("审核失败");
                  this._auditMemberYesFun = null;
                  this._auditMemberNoFun = null;
               }
               break;
            case UnionEvent.UNI_API_CYYC:
               trace("移除成员信息:\n" + Boolean(data) + "\n");
               this.isShowLoading(false);
               if(Boolean(data))
               {
                  this._removeMemberYesFun();
                  this._removeMemberYesFun = null;
                  this._removeMemberNoFun = null;
               }
               break;
            case UnionEvent.UNI_API_JSBH:
               trace("解散帮会信息:\n" + String(data) + "\n");
               this.isShowLoading(false);
               if(Boolean(this._dissolveUnionYesFun))
               {
                  this._dissolveUnionYesFun(String(data));
                  this._dissolveUnionYesFun = null;
                  this._dissolveUnionNoFun = null;
               }
         }
      }
      
      private function onVariablesSuccess(e:UnionEvent) : void
      {
         var dataObj:Object = e.data;
         trace("apiName:" + dataObj.apiName + "\n");
         var data:* = dataObj.data;
         if(dataObj.data is String && dataObj.data.indexOf("{") >= 0)
         {
            data = JSON2.decode(dataObj.data);
         }
         switch(dataObj.apiName)
         {
            case UnionEvent.UNI_API_HQBL:
               trace("公共变量列表:\n" + String(data) + "\n");
               this.isShowLoading(false);
               if(data != "null" && Boolean(this._getVariablesYesFun))
               {
                  this._getVariablesYesFun(data);
                  this._getVariablesYesFun = null;
                  this._getVariablesNoFun = null;
               }
               break;
            case UnionEvent.UNI_API_XGBL:
               trace("公共变量修改信息:\n" + Boolean(data) + "\n");
               this.isShowLoading(false);
               if(Boolean(this._doVariableYesFun) && Boolean(data))
               {
                  this._doVariableYesFun(data);
                  this._doVariableYesFun = null;
                  this._doVariableNoFun = null;
               }
         }
      }
      
      private function isShowLoading(show:Boolean) : void
      {
         if(show)
         {
            Game.loadingUI.show();
         }
         else
         {
            Game.loadingUI.hide();
         }
      }
      
      private function unionCreateError(e:UnionEvent) : void
      {
         var errstr:String = "";
         switch(int(e.data.eId))
         {
            case 10002:
               errstr = "参数错误!";
               break;
            case 10003:
               errstr = "游戏未开通公会API!";
               break;
            case 10004:
               errstr = "只有帮主有权限!";
               break;
            case 10005:
               errstr = "用户未登陆!";
               break;
            case 20001:
               errstr = "用户没有钱!";
               break;
            case 20002:
               errstr = "余额不足!";
               break;
            case 20003:
               errstr = "扣款失败!";
               break;
            case 20004:
               errstr = "公会名称已存在!";
               break;
            case 20005:
               errstr = "一个用户的一个存档，只能建一个帮派!";
               break;
            case 20006:
               errstr = "超过申请数量上限!";
               break;
            case 20007:
               errstr = "该公会的申请列表已满!";
               break;
            case 20008:
               errstr = "用户已经有公会了!";
               break;
            case 20009:
               errstr = "已经申请过了!";
               break;
            case 20010:
               errstr = "用户还没有加入任何公会!";
               break;
            case 20011:
               errstr = "不存在该公会!";
               break;
            case 20012:
               errstr = "移除成员失败，用户不属于该公会!";
               break;
            case 20013:
               errstr = "移除成员失败，帮主不能被移除!";
               break;
            case 20014:
               errstr = "审核失败，公会成员已满!";
               break;
            case 20015:
               errstr = "编辑extra失败，只有帮主有该权限!";
               break;
            case 20016:
               errstr = "超过最大贡献值!";
               break;
            case 20017:
               errstr = "不存在该公共变量!";
               break;
            case 20018:
               errstr = "超过最大数量!";
               break;
            case 20019:
               errstr = "extra的字符数超过最大个数限制（1500）!";
               break;
            case 20020:
               errstr = "退出公会后，24小时内不能申请加公会!";
               break;
            case 20021:
               errstr = "没有兑换配置!";
               break;
            case 20022:
               errstr = "用户的申请信息已经过期!";
               break;
            case 20023:
               errstr = "公会id错误!";
               break;
            case 20024:
               errstr = "已经申请过解散公会了!";
               break;
            case 20025:
               errstr = "没有该任务!";
               break;
            case 20026:
               errstr = "用户不在审核列表中!";
               break;
            case 20027:
               errstr = "只有在加入公会的24小时后才能进行贡献!";
               break;
            case 20028:
               errstr = "没有解散过公会，不能进行取消解散!";
               break;
            case 20029:
               errstr = "公共变量未到生效时间!";
               break;
            case 20030:
               errstr = "账号不能变换存档加入同一个公会!";
               break;
            case 30001:
               errstr = "数据库添加失败!";
               break;
            case 30002:
               errstr = "数据库删除失败!";
               break;
            case 40001:
               errstr = "特殊用户的type填写错误!";
               break;
            case 40002:
               errstr = "没有这个用户!";
         }
         trace("eId:" + e.data.eId + "  message:" + e.data.msg + "\n");
         this.isShowLoading(false);
         if(Boolean(this._getApplyListNoFun))
         {
            this._getApplyListNoFun(errstr);
            this._getApplyListNoFun = null;
            this._getApplyListYesFun = null;
         }
         if(Boolean(this._getUnionListNoFun))
         {
            this._getUnionListNoFun(errstr);
            this._getUnionListNoFun = null;
            this._getUnionListYesFun = null;
         }
         if(Boolean(this._unionCreateNoFun))
         {
            this._unionCreateNoFun(errstr);
            this._unionCreateNoFun = null;
            this._unionCreateYesFun = null;
         }
         if(Boolean(this._applyUnionNoFun))
         {
            this._applyUnionNoFun(errstr);
            this._applyUnionYesFun = null;
            this._applyUnionNoFun = null;
         }
         if(Boolean(this._getOwnUnionNoFun))
         {
            this._getOwnUnionNoFun(errstr);
            this._getOwnUnionNoFun = null;
            this._getOwnUnionYesFun = null;
         }
         if(Boolean(this._setUnionExtraNoFun))
         {
            this._setUnionExtraNoFun(errstr);
            this._setUnionExtraYesFun = null;
            this._setUnionExtraNoFun = null;
         }
         if(Boolean(this._getUnionMembersNoFun))
         {
            this._getUnionMembersNoFun(errstr);
            this._getUnionMembersNoFun = null;
            this._getUnionMembersYesFun = null;
         }
         if(Boolean(this._removeMemberNoFun))
         {
            this._removeMemberNoFun(errstr);
            this._removeMemberYesFun = null;
            this._removeMemberNoFun = null;
         }
         if(Boolean(this._auditMemberNoFun))
         {
            this._auditMemberNoFun(errstr);
            this._auditMemberYesFun = null;
            this._auditMemberNoFun = null;
         }
         if(Boolean(this._quitUionNoFun))
         {
            this._quitUionNoFun(errstr);
            this._quitUionYesFun = null;
            this._quitUionNoFun = null;
         }
         if(Boolean(this._setMemberExtraNoFun))
         {
            this._setMemberExtraNoFun(errstr);
            this._setMemberExtraYesFun = null;
            this._setMemberExtraNoFun = null;
         }
         if(Boolean(this._dissolveUnionNoFun))
         {
            this._dissolveUnionNoFun(errstr);
            this._dissolveUnionYesFun = null;
            this._dissolveUnionNoFun = null;
         }
         if(Boolean(this._doExchangeNoFun))
         {
            this._doExchangeNoFun(errstr);
            this._doExchangeYesFun = null;
            this._doExchangeNoFun = null;
         }
         if(Boolean(this._doTaskNoFun))
         {
            this._doTaskNoFun(errstr);
            this._doTaskYesFun = null;
            this._doTaskNoFun = null;
         }
         if(Boolean(this._getVariablesNoFun))
         {
            this._getVariablesNoFun(errstr);
            this._getVariablesYesFun = null;
            this._getVariablesNoFun = null;
         }
         if(Boolean(this._doVariableNoFun))
         {
            this._doVariableNoFun(errstr);
            this._doVariableYesFun = null;
            this._doVariableNoFun = null;
         }
      }

      private function localPlayerName() : String
      {
         var name:String = Game.gameData.username;
         if(name == null || name == "" || name == "0")
         {
            name = Game.gameData.playerName;
         }
         if(name == null || name == "")
         {
            name = "离线玩家";
         }
         return name;
      }

      private function makeLocalVariables() : Object
      {
         return {"30":50,"31":60,"32":60,"33":60,"34":60,"35":60,"36":0};
      }

      private function makeEmptyLocalState() : Object
      {
         return {"version":1,"exists":false,"unionInfo":null,"member":null,"variables":this.makeLocalVariables()};
      }

      private function makeLocalUnion(title:String, idx:int, extra:String) : Object
      {
         var name:String = this.localPlayerName();
         if(title == null || title == "")
         {
            title = "离线公会";
         }
         if(extra == null || extra == "")
         {
            extra = JSON2.encode({"notice":"本地单机公会","playerName":Game.gameData.playerName,"zdl":Game.gameData.getAllDps(),"count":1});
         }
         var memberExtra:String = JSON2.encode({"playerName":Game.gameData.playerName,"level":Game.gameData.level + 1,"zdl":Game.gameData.getAllDps(),"post":"会长"});
         var member:Object = {"uId":Game.gameData.uid > 0 ? Game.gameData.uid : 1,"index":idx,"userName":name,"contribution":450,"extra":memberExtra};
         var unionInfo:Object = {"id":1,"unionId":1,"title":title,"userName":name,"username":name,"index":idx,"level":3,"count":1,"contribution":20600,"extra":extra,"extra2":JSON2.encode({"zdl":Game.gameData.getAllDps()}),"dissolveDate":"0"};
         return {"version":1,"exists":true,"unionInfo":unionInfo,"member":member,"variables":this.makeLocalVariables()};
      }

      private function getLocalState(bootstrap:Boolean) : Object
      {
         var state:Object = Game.gameData.offlineUnion;
         if(state == null || !state.hasOwnProperty("version"))
         {
            if(bootstrap)
            {
               state = this.makeLocalUnion("离线公会",Game.nowSaveIndex,JSON2.encode({"notice":"欢迎来到本地单机公会","playerName":Game.gameData.playerName,"zdl":Game.gameData.getAllDps(),"count":1}));
            }
            else
            {
               state = this.makeEmptyLocalState();
            }
            Game.gameData.offlineUnion = state;
            this.saveLocalState();
         }
         if(!state.hasOwnProperty("variables") || state.variables == null)
         {
            state.variables = this.makeLocalVariables();
            this.saveLocalState();
         }
         return state;
      }

      private function getLocalListItem(unionInfo:Object) : Object
      {
         return {"unionId":unionInfo.id,"title":unionInfo.title,"username":unionInfo.userName,"level":unionInfo.level,"count":1,"contribution":unionInfo.contribution,"extra":unionInfo.extra};
      }

      private function refreshLocalUnionLevel(state:Object) : void
      {
         var exp:Array = [0,4400,20600,65400,139400,265400,473400,785400,1409400,3281400,99999999];
         var level:int = 1;
         while(level < exp.length - 1 && int(state.unionInfo.contribution) >= int(exp[level]))
         {
            level++;
         }
         state.unionInfo.level = level;
      }

      private function addLocalContribution(memberValue:int, unionValue:int) : void
      {
         var state:Object = this.getLocalState(false);
         if(!state.exists)
         {
            return;
         }
         state.member.contribution = int(state.member.contribution) + memberValue;
         state.unionInfo.contribution = int(state.unionInfo.contribution) + unionValue;
         this.refreshLocalUnionLevel(state);
         this.saveLocalState();
      }

      private function getLocalVariables(ids:Array) : Array
      {
         var state:Object = this.getLocalState(false);
         var result:Array = [];
         for(var i:int = 0; i < ids.length; i++)
         {
            var id:String = String(ids[i]);
            if(!state.variables.hasOwnProperty(id))
            {
               state.variables[id] = 0;
            }
            result.push({"id":int(ids[i]),"value":int(state.variables[id])});
         }
         return result;
      }

      private function changeLocalVariable(id:int) : void
      {
         var state:Object = this.getLocalState(false);
         var key:String = String(id);
         if(!state.variables.hasOwnProperty(key))
         {
            state.variables[key] = 0;
         }
         var value:int = int(state.variables[key]);
         if(id >= 30 && id <= 35)
         {
            if(value > 0)
            {
               value--;
            }
         }
         else
         {
            value++;
         }
         state.variables[key] = value;
         this.saveLocalState();
      }

      private function saveLocalState() : void
      {
         this._getUnionListLT = {"time":-1};
         this._getOwnUnionLT = {"time":-1};
         this._getUnionMembersLT = {"time":-1};
         this._getUnionListObj = null;
         this._getOwnUnionObj = null;
         this._getUnionMembersObj = null;
         if(Boolean(Game.uiGroup))
         {
            Game.uiGroup.saveDataNoUI();
         }
      }
      
      private function checkCanAsk(lastTimeObj:Object) : Boolean
      {
         var lastTime:Number = Number(lastTimeObj.time);
         var nowTime:Number = getTimer();
         if(lastTime < 0)
         {
            lastTimeObj.time = nowTime;
            return true;
         }
         if(nowTime - lastTime < this.ASKDELAY)
         {
            return false;
         }
         lastTimeObj.time = nowTime;
         return true;
      }
      
      public function Clear() : void
      {
         this._applyUnionYesFun = null;
         this._applyUnionNoFun = null;
         this._auditMemberNoFun = null;
         this._auditMemberYesFun = null;
         this._dissolveUnionNoFun = null;
         this._dissolveUnionYesFun = null;
         this._doExchangeYesFun = null;
         this._doExchangeNoFun = null;
         this._doTaskYesFun = null;
         this._doTaskNoFun = null;
         this._getApplyListNoFun = null;
         this._getApplyListYesFun = null;
         this._getOwnUnionLT = {"time":-1};
         this._getOwnUnionNoFun = null;
         this._getOwnUnionObj = null;
         this._getOwnUnionYesFun = null;
         this._getUnionListLT = {"time":-1};
         this._getUnionListNoFun = null;
         this._getUnionListObj = null;
         this._getUnionListYesFun = null;
         this._getUnionLogNoFun = null;
         this._getUnionLogYesFun = null;
         this._getUnionMembersLT = {"time":-1};
         this._getUnionMembersNoFun = null;
         this._getUnionMembersObj = null;
         this._getUnionMembersYesFun = null;
         this._quitUionNoFun = null;
         this._quitUionYesFun = null;
         this._removeMemberNoFun = null;
         this._removeMemberYesFun = null;
         this._setMemberExtraNoFun = null;
         this._setMemberExtraYesFun = null;
         this._setUnionExtraNoFun = null;
         this._setUnionExtraYesFun = null;
         this._unionCreateNoFun = null;
         this._unionCreateYesFun = null;
         this._getVariablesYesFun = null;
         this._getVariablesNoFun = null;
         this._doVariableYesFun = null;
         this._doVariableNoFun = null;
      }
   }
}

