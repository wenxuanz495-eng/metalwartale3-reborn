package ctrl4399.proxy.unionApi
{
   public interface MasterApi
   {
      
      function applyList(param1:ApiHeader, param2:int, param3:int, param4:Function, param5:Function) : void;
      
      function applyAudit(param1:ApiHeader, param2:int, param3:String, param4:int, param5:Function, param6:Function) : void;
      
      function memberRemove(param1:ApiHeader, param2:int, param3:String, param4:Function, param5:Function) : void;
      
      function dissolve(param1:ApiHeader, param2:int, param3:Function, param4:Function) : void;
      
      function deleteContributionUnion(param1:ApiHeader, param2:int, param3:Function, param4:Function) : void;
      
      function applyAuditMuch(param1:ApiHeader, param2:Array, param3:int, param4:Function, param5:Function) : void;
      
      function transfer(param1:ApiHeader, param2:int, param3:String, param4:int, param5:Function, param6:Function) : void;
      
      function test(param1:Function, param2:Function) : void;
   }
}

