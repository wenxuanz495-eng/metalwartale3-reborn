package ctrl4399.proxy.union
{
   import com.adobe.serialization.json.JSON;
   import ctrl4399.proxy.LogData;
   import ctrl4399.proxy.ThriftClient;
   import ctrl4399.proxy.unionApi.MemberApi;
   import ctrl4399.proxy.unionApi.MemberApiImpl;
   import ctrl4399.proxy.unionApi.RES_LogList;
   import ctrl4399.proxy.unionApi.RES_UnionInfo;
   import ctrl4399.proxy.unionApi.RES_UnionMembers;
   import ctrl4399.proxy.unionApi.UnionBool;
   import ctrl4399.proxy.unionApi.UnionInt;
   import ctrl4399.strconst.AllConst;
   import unit4399.events.UnionEvent;
   
   public class MemberProxy extends UnionProxy
   {
      
      public function MemberProxy(param1:String = null)
      {
         super(param1);
      }
      
      private function get memberApi() : MemberApi
      {
         return new MemberApiImpl(ThriftClient.createClient(AllConst.URL_UNION_MEMBER));
      }
      
      public function getUnionDetail(param1:int, param2:int) : *
      {
         trace("-getUnionDetail-",param1,param2);
         if(Boolean(checkIdx(param1)) || param2 < 0)
         {
            showParamError();
            return;
         }
         logData = new LogData(LogData.API_UNION,"unionInfo");
         this.memberApi.unionInfo(getApiHeader(param1),param2,onError,this.unionDetailSucc);
      }
      
      public function getUnionMembers(param1:int, param2:int) : *
      {
         trace("-getUnionDetail-",param1,param2);
         if(Boolean(checkIdx(param1)) || param2 < 0)
         {
            showParamError();
            return;
         }
         logData = new LogData(LogData.API_UNION,"unionMembers");
         this.memberApi.unionMembers(getApiHeader(param1),param2,onError,this.unionMembersSucc);
      }
      
      public function setMemberExtra(param1:int, param2:int, param3:String, param4:int, param5:int, param6:int) : *
      {
         trace("---setMemberExtra--idx=" + param1,param2,param3,param4);
         if(Boolean(checkIdx(param1)) || emptyTxt(param3))
         {
            showParamError();
            return;
         }
         trace("-xx setMemberExtra--idx=" + param1,param2,param3,param4,param5,param6);
         if(param2 != 1 && (Boolean(param4 <= 0) || Boolean(checkIdx(param6))))
         {
            showParamError();
            return;
         }
         logData = new LogData(LogData.API_UNION,"setMemberExtra");
         this.memberApi.setMemberExtra(getApiHeader(param1),param2,param3,param4,param5,param6,onError,this.setMemberExtraSucc);
      }
      
      public function setUnionExtra(param1:int, param2:int, param3:String, param4:int) : *
      {
         trace("-----idx=" + param1,param2,param3,param4);
         if(Boolean(checkIdx(param1)) || emptyTxt(param3))
         {
            showParamError();
            return;
         }
         trace("-xxxx-idx=" + param1,param2,param3,param4);
         if(param2 != 1 && param4 < 0)
         {
            showParamError();
            return;
         }
         logData = new LogData(LogData.API_UNION,"setUnionExtra");
         this.memberApi.setUnionExtra(getApiHeader(param1),param2,param3,param4,onError,this.setUnionExtraSucc);
      }
      
      public function usePersonalContribution(param1:int, param2:int) : *
      {
         if(Boolean(checkIdx(param1)) || param2 < 1)
         {
            showParamError();
            return;
         }
         logData = new LogData(LogData.API_UNION,"deleteContributionPersonal");
         this.memberApi.deleteContributionPersonal(getApiHeader(param1),param2,onError,this.usePersonalContributionSucc);
      }
      
      public function getUnionLog(param1:int, param2:int, param3:Number) : *
      {
         if(Boolean(checkIdx(param1)) || Boolean(param2 < 1) || param3 < 1)
         {
            showParamError();
            return;
         }
         logData = new LogData(LogData.API_UNION,"unionLog");
         this.memberApi.unionLog(getApiHeader(param1),param2,param3,onError,this.getUnionLogSucc);
      }
      
      public function quitUion(param1:int) : *
      {
         if(checkIdx(param1))
         {
            showParamError();
            return;
         }
         logData = new LogData(LogData.API_UNION,"unionQuit");
         this.memberApi.unionQuit(getApiHeader(param1),onError,this.quitUninSucc);
      }
      
      public function setRole(param1:int, param2:int, param3:int, param4:int) : void
      {
         if(Boolean(checkIdx(param1)) || Boolean(checkIdx(param3)) || param4 < 0)
         {
            showParamError();
            return;
         }
         logData = new LogData(LogData.API_UNION,"setRole");
         this.memberApi.setRole(getApiHeader(param1),param2,param3,param4,onError,this.setRoleSucc);
      }
      
      private function setRoleSucc(param1:UnionBool) : void
      {
         logData.submit(true);
         _dispatch(UnionEvent.UNION_MEMBER_SUCCESS,setSuccessInfo(UnionEvent.UNI_API_SZJS,param1.result));
      }
      
      private function unionDetailSucc(param1:RES_UnionInfo) : void
      {
         logData.submit(true);
         var _loc2_:* = com.adobe.serialization.json.JSON.encode(param1.unionInfo);
         trace("uninDetail",param1.tag,_loc2_);
         _dispatch(UnionEvent.UNION_MEMBER_SUCCESS,setSuccessInfo(UnionEvent.UNI_API_BHMX,_loc2_));
      }
      
      private function unionMembersSucc(param1:RES_UnionMembers) : void
      {
         var _loc2_:* = undefined;
         logData.submit(true);
         trace("unionMembersSucc",param1.tag,_loc2_);
         _loc2_ = com.adobe.serialization.json.JSON.encode(param1.memberList);
         _dispatch(UnionEvent.UNION_MEMBER_SUCCESS,setSuccessInfo(UnionEvent.UNI_API_BHCY,_loc2_));
      }
      
      private function setMemberExtraSucc(param1:UnionBool) : void
      {
         logData.submit(true);
         trace("setMemberExtraSucc",String(param1.result));
         _dispatch(UnionEvent.UNION_MEMBER_SUCCESS,setSuccessInfo(UnionEvent.UNI_API_CYTZBG,param1.result));
      }
      
      private function setUnionExtraSucc(param1:UnionBool) : void
      {
         logData.submit(true);
         trace("setUnionExtraSucc",String(param1.result));
         _dispatch(UnionEvent.UNION_MEMBER_SUCCESS,setSuccessInfo(UnionEvent.UNI_API_BHTZBG,param1.result));
      }
      
      private function getUnionLogSucc(param1:RES_LogList) : *
      {
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:* = undefined;
         logData.submit(true);
         trace("getUnionLogSucc",param1.logList,param1.count);
         var _loc2_:Object = new Object();
         if(int(param1.count) > 0)
         {
            _loc4_ = new Array();
            _loc5_ = 0;
            while(_loc5_ < param1.logList.length)
            {
               _loc6_ = com.adobe.serialization.json.JSON.decode(param1.logList[_loc5_]);
               _loc4_.push(_loc6_);
               _loc5_++;
            }
            _loc2_.logList = _loc4_;
         }
         else
         {
            _loc2_.logList = null;
         }
         _loc2_.rowCount = int(param1.count);
         var _loc3_:* = com.adobe.serialization.json.JSON.encode(_loc2_);
         _dispatch(UnionEvent.UNION_MEMBER_SUCCESS,setSuccessInfo(UnionEvent.UNI_API_BHRZ,_loc3_));
      }
      
      private function quitUninSucc(param1:UnionBool) : *
      {
         logData.submit(true);
         trace("quitUninSucc",param1.result);
         _dispatch(UnionEvent.UNION_MEMBER_SUCCESS,setSuccessInfo(UnionEvent.UNI_API_TCBH,param1.result));
      }
      
      private function usePersonalContributionSucc(param1:UnionInt) : *
      {
         logData.submit(true);
         trace("usePersonalContributionSucc",param1.result);
         _dispatch(UnionEvent.UNION_MEMBER_SUCCESS,setSuccessInfo(UnionEvent.UNI_API_XHGRGXD,param1.result));
      }
   }
}

