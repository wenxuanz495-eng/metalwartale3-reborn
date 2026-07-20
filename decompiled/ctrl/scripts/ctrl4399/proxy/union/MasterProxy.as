package ctrl4399.proxy.union
{
   import com.adobe.serialization.json.JSON;
   import ctrl4399.proxy.LogData;
   import ctrl4399.proxy.ThriftClient;
   import ctrl4399.proxy.unionApi.MasterApi;
   import ctrl4399.proxy.unionApi.MasterApiImpl;
   import ctrl4399.proxy.unionApi.RES_ApplyList;
   import ctrl4399.proxy.unionApi.RES_Dissolve;
   import ctrl4399.proxy.unionApi.UnionBool;
   import ctrl4399.proxy.unionApi.UnionInt;
   import ctrl4399.proxy.unionApi.Users;
   import ctrl4399.strconst.AllConst;
   import unit4399.events.UnionEvent;
   
   public class MasterProxy extends UnionProxy
   {
      
      public function MasterProxy(param1:String = null)
      {
         super(param1);
      }
      
      private function get masterApi() : MasterApi
      {
         return new MasterApiImpl(ThriftClient.createClient(AllConst.URL_UNION_MASTER));
      }
      
      public function getApplyList(param1:int, param2:int, param3:int) : *
      {
         if(Boolean(checkIdx(param1)) || Boolean(param2 < 1) || param3 < 1)
         {
            showParamError();
            return;
         }
         logData = new LogData(LogData.API_UNION,"applyList");
         this.masterApi.applyList(getApiHeader(param1),param2,param3,onError,this.getApplyListSucc);
      }
      
      public function auditMember(param1:int, param2:int, param3:int, param4:int) : *
      {
         if(Boolean(checkIdx(param1)) || Boolean(checkIdx(param3)) || param4 != 0 && param4 != 1)
         {
            showParamError();
            return;
         }
         logData = new LogData(LogData.API_UNION,"applyAudit");
         this.masterApi.applyAudit(getApiHeader(param1),param2,String(param3),param4,onError,this.auditMemberSucc);
      }
      
      public function removeMember(param1:int, param2:int, param3:int) : *
      {
         if(Boolean(checkIdx(param1)) || Boolean(checkIdx(param3)))
         {
            showParamError();
            return;
         }
         logData = new LogData(LogData.API_UNION,"memberRemove");
         this.masterApi.memberRemove(getApiHeader(param1),param2,String(param3),onError,this.removeMemberSucc);
      }
      
      public function dissolveUnion(param1:int, param2:int) : *
      {
         if(Boolean(checkIdx(param1)) || param2 != 0 && param2 != 1)
         {
            showParamError();
            return;
         }
         logData = new LogData(LogData.API_UNION,"dissolve");
         this.masterApi.dissolve(getApiHeader(param1),param2,onError,this.dissolveUnionSucc);
      }
      
      public function useUnionContribution(param1:int, param2:int) : *
      {
         if(Boolean(checkIdx(param1)) || param2 < 1)
         {
            showParamError();
            return;
         }
         logData = new LogData(LogData.API_UNION,"deleteContributionUnion");
         this.masterApi.deleteContributionUnion(getApiHeader(param1),param2,onError,this.useUnionContributionSucc);
      }
      
      public function applyMultiAudit(param1:int, param2:Array, param3:int) : *
      {
         var _loc4_:Array = null;
         var _loc6_:Object = null;
         var _loc7_:Users = null;
         if(Boolean(checkIdx(param1)) || param3 != 0 && param3 != 1)
         {
            showParamError();
            return;
         }
         if(param2 == null || param2.length <= 0)
         {
            showParamError();
            return;
         }
         _loc4_ = new Array();
         var _loc5_:int = 0;
         while(_loc5_ < param2.length)
         {
            _loc6_ = param2[_loc5_];
            _loc7_ = new Users();
            _loc7_.uid = _loc6_.uid;
            _loc7_.index = _loc6_.index;
            _loc4_.push(_loc7_);
            _loc5_++;
         }
         logData = new LogData(LogData.API_UNION,"applyAuditMuch");
         this.masterApi.applyAuditMuch(getApiHeader(param1),_loc4_,param3,onError,this.applyMultiAuditSucc);
      }
      
      public function transferUnion(param1:int, param2:int, param3:int, param4:int) : *
      {
         if(Boolean(checkIdx(param1)) || Boolean(checkIdx(param3)) || param4 != 0 && param4 != 1)
         {
            showParamError();
            return;
         }
         logData = new LogData(LogData.API_UNION,"transfer");
         this.masterApi.transfer(getApiHeader(param1),param2,String(param3),param4,onError,this.transferUnionSucc);
      }
      
      private function getApplyListSucc(param1:RES_ApplyList) : *
      {
         var _loc3_:* = undefined;
         logData.submit(true);
         trace("getApplyListSucc",_loc3_,param1.count);
         var _loc2_:Object = new Object();
         _loc2_.applyList = param1.applyList;
         _loc2_.rowCount = int(param1.count);
         _loc3_ = com.adobe.serialization.json.JSON.encode(_loc2_);
         _dispatch(UnionEvent.UNION_MASTER_SUCCESS,setSuccessInfo(UnionEvent.UNI_API_DSHLB,_loc3_));
      }
      
      private function auditMemberSucc(param1:UnionBool) : *
      {
         logData.submit(true);
         trace("getApplyListSucc",param1.result);
         _dispatch(UnionEvent.UNION_MASTER_SUCCESS,setSuccessInfo(UnionEvent.UNI_API_CYSH,param1.result));
      }
      
      private function removeMemberSucc(param1:UnionBool) : *
      {
         logData.submit(true);
         trace("removeMemberSucc",param1.result);
         _dispatch(UnionEvent.UNION_MASTER_SUCCESS,setSuccessInfo(UnionEvent.UNI_API_CYYC,param1.result));
      }
      
      private function dissolveUnionSucc(param1:RES_Dissolve) : *
      {
         logData.submit(true);
         trace("dissolveUnionSucc",param1.result);
         _dispatch(UnionEvent.UNION_MASTER_SUCCESS,setSuccessInfo(UnionEvent.UNI_API_JSBH,param1.result));
      }
      
      private function useUnionContributionSucc(param1:UnionInt) : *
      {
         logData.submit(true);
         trace("useUnionContributionSucc",param1.result);
         _dispatch(UnionEvent.UNION_MASTER_SUCCESS,setSuccessInfo(UnionEvent.UNI_API_XHBHGXD,param1.result));
      }
      
      private function applyMultiAuditSucc(param1:UnionBool) : *
      {
         logData.submit(true);
         trace("applyMultiAuditSucc",param1.result);
         _dispatch(UnionEvent.UNION_MASTER_SUCCESS,setSuccessInfo(UnionEvent.UNI_API_SHDGCY,param1.result));
      }
      
      private function transferUnionSucc(param1:UnionBool) : *
      {
         logData.submit(true);
         trace("transferUnionSucc",param1.result);
         _dispatch(UnionEvent.UNION_MASTER_SUCCESS,setSuccessInfo(UnionEvent.UNI_API_ZRBH,param1.result));
      }
   }
}

