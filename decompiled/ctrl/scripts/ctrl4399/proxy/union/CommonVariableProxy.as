package ctrl4399.proxy.union
{
   import com.adobe.serialization.json.JSON;
   import ctrl4399.proxy.LogData;
   import ctrl4399.proxy.ThriftClient;
   import ctrl4399.proxy.unionApi.RES_Variables;
   import ctrl4399.proxy.unionApi.UnionBool;
   import ctrl4399.proxy.unionApi.VariableApi;
   import ctrl4399.proxy.unionApi.VariableApiImpl;
   import ctrl4399.strconst.AllConst;
   import unit4399.events.UnionEvent;
   
   public class CommonVariableProxy extends UnionProxy
   {
      
      public function CommonVariableProxy(param1:String = null)
      {
         super(param1);
      }
      
      private function get variableApi() : VariableApi
      {
         return new VariableApiImpl(ThriftClient.createClient(AllConst.URL_UNION_VARIABLE));
      }
      
      public function getVariables(param1:int, param2:Array) : *
      {
         if(Boolean(checkIdx(param1)) || Boolean(param2 == null) || param2.length == 0)
         {
            showParamError();
            return;
         }
         logData = new LogData(LogData.API_UNION,"getVariables");
         this.variableApi.getVariables(getApiHeader(param1),param2,onError,this.getVariablesSucc);
      }
      
      public function doVariable(param1:int, param2:int) : *
      {
         if(Boolean(checkIdx(param1)) || param2 <= 0)
         {
            showParamError();
            return;
         }
         logData = new LogData(LogData.API_UNION,"doVariable");
         this.variableApi.doVariable(getApiHeader(param1),param2,onError,this.doVariableSucc);
      }
      
      public function getVariablesSucc(param1:RES_Variables) : *
      {
         trace("getVariablesSucc",param1.variables);
         logData.submit(true);
         _dispatch(UnionEvent.UNION_VARIABLES_SUCCESS,setSuccessInfo(UnionEvent.UNI_API_HQBL,com.adobe.serialization.json.JSON.encode(param1.variables)));
      }
      
      public function doVariableSucc(param1:UnionBool) : *
      {
         logData.submit(true);
         trace("doVariableSucc",param1.result);
         _dispatch(UnionEvent.UNION_VARIABLES_SUCCESS,setSuccessInfo(UnionEvent.UNI_API_XGBL,param1.result));
      }
   }
}

