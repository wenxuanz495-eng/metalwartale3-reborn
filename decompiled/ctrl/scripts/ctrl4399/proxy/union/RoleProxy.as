package ctrl4399.proxy.union
{
   import com.adobe.serialization.json.JSON;
   import ctrl4399.proxy.LogData;
   import ctrl4399.proxy.ThriftClient;
   import ctrl4399.proxy.unionApi.RES_RoleList;
   import ctrl4399.proxy.unionApi.Role;
   import ctrl4399.proxy.unionApi.RoleApi;
   import ctrl4399.proxy.unionApi.RoleApiImpl;
   import ctrl4399.strconst.AllConst;
   import unit4399.events.UnionEvent;
   
   public class RoleProxy extends UnionProxy
   {
      
      public function RoleProxy(param1:String = null)
      {
         super(param1);
      }
      
      private function get roleApi() : RoleApi
      {
         return new RoleApiImpl(ThriftClient.createClient(AllConst.URL_UNION_ROLE));
      }
      
      public function getRoleList(param1:int, param2:int) : void
      {
         if(param1 < 1 || param2 < 1)
         {
            showParamError();
            return;
         }
         logData = new LogData(LogData.API_UNION,"getRoleList");
         this.roleApi.getRoleList(getApiHeader(),param1,param2,onError,this.getRoleListSucc);
      }
      
      private function getRoleListSucc(param1:RES_RoleList) : void
      {
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:Role = null;
         var _loc7_:Object = null;
         logData.submit(true);
         var _loc2_:Object = new Object();
         if(int(param1.count) > 0)
         {
            _loc4_ = new Array();
            _loc5_ = 0;
            while(_loc5_ < param1.roleList.length)
            {
               _loc6_ = param1.roleList[_loc5_];
               _loc7_ = new Object();
               _loc7_.id = _loc6_.id;
               _loc7_.name = _loc6_.name;
               _loc7_.create_time = _loc6_.create_time;
               _loc7_.memo = _loc6_.memo;
               _loc7_.privilegeList = _loc6_.privilegeList;
               _loc4_.push(_loc7_);
               _loc5_++;
            }
            _loc2_.roleList = _loc4_;
         }
         else
         {
            _loc2_.roleList = null;
         }
         _loc2_.rowCount = int(param1.count);
         var _loc3_:* = com.adobe.serialization.json.JSON.encode(_loc2_);
         _dispatch(UnionEvent.UNION_ROLE_SUCCESS,setSuccessInfo(UnionEvent.UNI_API_JSQXLB,_loc3_));
      }
   }
}

