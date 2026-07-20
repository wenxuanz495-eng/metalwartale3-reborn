package ctrl4399.proxy.union
{
   import com.adobe.serialization.json.JSON;
   import ctrl4399.proxy.LogData;
   import ctrl4399.proxy.ThriftClient;
   import ctrl4399.proxy.unionApi.RES_UnionList;
   import ctrl4399.proxy.unionApi.RES_UnionOfMe;
   import ctrl4399.proxy.unionApi.UnionBool;
   import ctrl4399.proxy.unionApi.VisitorApi;
   import ctrl4399.proxy.unionApi.VisitorApiImpl;
   import ctrl4399.strconst.AllConst;
   import unit4399.events.UnionEvent;
   
   public class VisitorProxy extends UnionProxy
   {
      
      public function VisitorProxy(param1:String = null)
      {
         super(param1);
      }
      
      private function get vistorApi() : VisitorApi
      {
         return new VisitorApiImpl(ThriftClient.createClient(AllConst.URL_UNION_VISITOR));
      }
      
      public function createUion(param1:int, param2:String, param3:String) : *
      {
         if(Boolean(checkIdx(param1)) || Boolean(emptyTxt(param2)) || emptyTxt(param3))
         {
            showParamError();
            return;
         }
         logData = new LogData(LogData.API_UNION,"unionCreate");
         this.vistorApi.unionCreate(getApiHeader(param1),param2,param3,onError,this.createUnionSucc);
      }
      
      public function getUnionList(param1:int, param2:int, param3:int) : *
      {
         if(Boolean(checkIdx(param1)) || Boolean(param2 < 1) || param3 < 1)
         {
            showParamError();
            return;
         }
         logData = new LogData(LogData.API_UNION,"unionList");
         this.vistorApi.unionList(getApiHeader(param1),param2,param3,onError,this.onGetListSucc);
      }
      
      public function applyUnion(param1:int, param2:int, param3:String) : *
      {
         if(Boolean(checkIdx(param1)) || Boolean(param2 <= 0) || emptyTxt(param3))
         {
            showParamError();
            return;
         }
         logData = new LogData(LogData.API_UNION,"unionApply");
         this.vistorApi.unionApply(getApiHeader(param1),param2,param3,onError,this.onApplySucc);
      }
      
      public function getOwnUnion(param1:int) : *
      {
         if(checkIdx(param1))
         {
            showParamError();
            return;
         }
         logData = new LogData(LogData.API_UNION,"unionOfMe");
         this.vistorApi.unionOfMe(getApiHeader(param1),onError,this.onGetOwnUSucc);
      }
      
      private function createUnionSucc(param1:UnionBool) : void
      {
         logData.submit(true);
         trace("success result:" + param1.result + ",tag:" + param1.tag);
         _dispatch(UnionEvent.UNION_VISITOR_SUCCESS,setSuccessInfo(UnionEvent.UNI_API_BHCJ,param1.result));
      }
      
      private function onGetListSucc(param1:RES_UnionList) : *
      {
         logData.submit(true);
         trace(param1.tag,param1.unionList,param1.count);
         var _loc2_:Object = new Object();
         _loc2_.unionList = param1.unionList;
         _loc2_.rowCount = int(param1.count);
         var _loc3_:* = com.adobe.serialization.json.JSON.encode(_loc2_);
         _dispatch(UnionEvent.UNION_VISITOR_SUCCESS,setSuccessInfo(UnionEvent.UNI_API_BHLB,_loc3_));
      }
      
      private function onApplySucc(param1:UnionBool) : *
      {
         trace("success result:" + param1.result + ",tag:" + param1.tag);
         logData.submit(true);
         _dispatch(UnionEvent.UNION_VISITOR_SUCCESS,setSuccessInfo(UnionEvent.UNI_API_BHSQ,param1.result));
      }
      
      private function onGetOwnUSucc(param1:RES_UnionOfMe) : *
      {
         logData.submit(true);
         var _loc2_:String = param1.tag;
         if(!param1.me.unionInfo.isSetId())
         {
            trace("--isSetUnionInfo---");
            param1.me.unionInfo = null;
         }
         if(param1.me.member.unionId == 0)
         {
            param1.me.member = null;
         }
         var _loc3_:* = com.adobe.serialization.json.JSON.encode(param1.me);
         trace("getown=" + _loc3_);
         _dispatch(UnionEvent.UNION_VISITOR_SUCCESS,setSuccessInfo(UnionEvent.UNI_API_SSBH,_loc3_));
      }
   }
}

