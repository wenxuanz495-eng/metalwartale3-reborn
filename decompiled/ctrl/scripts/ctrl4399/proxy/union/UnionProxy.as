package ctrl4399.proxy.union
{
   import ctrl4399.proxy.LogData;
   import ctrl4399.proxy.MainProxy;
   import ctrl4399.proxy.unionApi.ApiHeader;
   import ctrl4399.proxy.unionApi.Err;
   import ctrl4399.strconst.AllConst;
   import frame4399.simplePureMvc.core.Facade;
   import frame4399.simplePureMvc.interfaces.IProxy;
   import frame4399.simplePureMvc.proxy.Proxy;
   import unit4399.events.UnionEvent;
   
   public class UnionProxy extends Proxy implements IProxy
   {
      
      protected static const ERROR_PARAM_CODE:String = "10002";
      
      protected static const ERROR_UNKOWN_CODE:String = "99999";
      
      protected static const ERROR_PARAM_MSG:String = "参数错误";
      
      protected static const ERROR_UNKOWN_MSG:String = "未知错误";
      
      protected var mainProxy:MainProxy;
      
      protected var _facade:Facade = Facade.getInstance();
      
      public var realStage:*;
      
      protected var logData:LogData;
      
      public function UnionProxy(param1:String = null)
      {
         super(param1);
         this.mainProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_MAIN) as MainProxy;
      }
      
      protected function getApiHeader(param1:int = -1) : ApiHeader
      {
         var _loc2_:ApiHeader = new ApiHeader();
         _loc2_.gameId = this.mainProxy.gameID;
         _loc2_.index = String(param1);
         _loc2_.tag = new Date().getTime().toString();
         return _loc2_;
      }
      
      protected function errorObj(param1:String, param2:String) : Object
      {
         var _loc3_:Object = new Object();
         _loc3_.eId = param1;
         _loc3_.msg = param2;
         return _loc3_;
      }
      
      protected function setSuccessInfo(param1:String, param2:*) : Object
      {
         var _loc3_:Object = new Object();
         _loc3_.apiName = param1;
         _loc3_.data = param2;
         return _loc3_;
      }
      
      protected function _dispatch(param1:String, param2:Object) : void
      {
         if(this.realStage == null)
         {
            return;
         }
         this.realStage.dispatchEvent(new UnionEvent(param1,param2));
      }
      
      protected function trim(param1:String) : String
      {
         return this.ltrim(this.rtrim(param1));
      }
      
      protected function ltrim(param1:String) : String
      {
         return param1.replace(/^\s*/g,"");
      }
      
      protected function rtrim(param1:String) : String
      {
         return param1.replace(/\s*$/g,"");
      }
      
      protected function emptyTxt(param1:String) : Boolean
      {
         if(!this.trim(param1))
         {
            return true;
         }
         return false;
      }
      
      protected function checkIdx(param1:int) : *
      {
         if(param1 < 0 || param1 > 7)
         {
            return true;
         }
         return false;
      }
      
      protected function showParamError() : void
      {
         this._dispatch(UnionEvent.UNION_ERROR,this.errorObj(ERROR_PARAM_CODE,ERROR_PARAM_MSG));
      }
      
      protected function onError(param1:Error) : void
      {
         var _loc2_:Err = null;
         if(param1 is Err)
         {
            _loc2_ = param1 as Err;
            trace("errorId:" + _loc2_.code + ",message:" + _loc2_.msg);
            this._dispatch(UnionEvent.UNION_ERROR,this.errorObj(String(_loc2_.code),_loc2_.msg));
         }
         else
         {
            if(Boolean(this.logData) && !this.logData.isSubmit)
            {
               this.logData.exception = param1.toString();
               this.logData.submit();
            }
            this._dispatch(UnionEvent.UNION_ERROR,this.errorObj(ERROR_UNKOWN_CODE,ERROR_UNKOWN_MSG));
         }
      }
   }
}

