package ctrl4399.proxy.unionApi
{
   public interface MemberApi
   {
      
      function unionInfo(param1:ApiHeader, param2:int, param3:Function, param4:Function) : void;
      
      function unionMembers(param1:ApiHeader, param2:int, param3:Function, param4:Function) : void;
      
      function setMemberExtra(param1:ApiHeader, param2:int, param3:String, param4:int, param5:int, param6:int, param7:Function, param8:Function) : void;
      
      function setUnionExtra(param1:ApiHeader, param2:int, param3:String, param4:int, param5:Function, param6:Function) : void;
      
      function unionLog(param1:ApiHeader, param2:int, param3:int, param4:Function, param5:Function) : void;
      
      function deleteContributionPersonal(param1:ApiHeader, param2:int, param3:Function, param4:Function) : void;
      
      function unionQuit(param1:ApiHeader, param2:Function, param3:Function) : void;
      
      function setRole(param1:ApiHeader, param2:int, param3:int, param4:int, param5:Function, param6:Function) : void;
      
      function test(param1:Function, param2:Function) : void;
   }
}

