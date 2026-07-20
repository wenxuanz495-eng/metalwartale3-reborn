package ctrl4399.proxy.union
{
   import com.adobe.serialization.json.JSON;
   import ctrl4399.proxy.LogData;
   import ctrl4399.proxy.ThriftClient;
   import ctrl4399.proxy.unionApi.GrowApi;
   import ctrl4399.proxy.unionApi.GrowApiImpl;
   import ctrl4399.proxy.unionApi.RES_TaskValue;
   import ctrl4399.proxy.unionApi.UnionBool;
   import ctrl4399.strconst.AllConst;
   import unit4399.events.UnionEvent;
   
   public class GrowProxy extends UnionProxy
   {
      
      public function GrowProxy(param1:String = null)
      {
         super(param1);
      }
      
      private function get growApi() : GrowApi
      {
         return new GrowApiImpl(ThriftClient.createClient(AllConst.URL_UNION_GROW));
      }
      
      public function doTask(param1:int, param2:String) : *
      {
         if(Boolean(checkIdx(param1)) || emptyTxt(param2))
         {
            showParamError();
            return;
         }
         logData = new LogData(LogData.API_UNION,"doTask");
         this.growApi.doTask(getApiHeader(param1),param2,onError,this.doTaskSucc);
      }
      
      public function doExchange(param1:int, param2:int) : *
      {
         if(Boolean(checkIdx(param1)) || param2 <= 0)
         {
            showParamError();
            return;
         }
         logData = new LogData(LogData.API_UNION,"exchange");
         this.growApi.exchange(getApiHeader(param1),param2,onError,this.doExchangeSucc);
      }
      
      public function getTaskValue(param1:int) : *
      {
         if(checkIdx(param1))
         {
            showParamError();
            return;
         }
         logData = new LogData(LogData.API_UNION,"getTaskValue");
         this.growApi.getTaskValue(getApiHeader(param1),onError,this.getTaskValueSucc);
      }
      
      private function doTaskSucc(param1:UnionBool) : *
      {
         logData.submit(true);
         trace("doTaskSucc",param1.result);
         _dispatch(UnionEvent.UNION_GROW_SUCCESS,setSuccessInfo(UnionEvent.UNI_API_BHRW,param1.result));
      }
      
      private function doExchangeSucc(param1:UnionBool) : *
      {
         logData.submit(true);
         trace("doExchangeSucc",param1.result);
         _dispatch(UnionEvent.UNION_GROW_SUCCESS,setSuccessInfo(UnionEvent.UNI_API_BHDH,param1.result));
      }
      
      private function getTaskValueSucc(param1:RES_TaskValue) : *
      {
         logData.submit(true);
         var _loc2_:Object = new Object();
         _loc2_.tasklist = param1.value;
         _loc2_.exchange = param1.exchange;
         _loc2_.total = param1.total;
         var _loc3_:* = com.adobe.serialization.json.JSON.encode(_loc2_);
         trace("getTaskValueSucc",_loc3_);
         _dispatch(UnionEvent.UNION_GROW_SUCCESS,setSuccessInfo(UnionEvent.UNI_API_BHRWWC,_loc3_));
      }
   }
}

