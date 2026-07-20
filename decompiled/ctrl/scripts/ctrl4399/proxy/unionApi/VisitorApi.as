package ctrl4399.proxy.unionApi
{
   public interface VisitorApi
   {
      
      function unionCreate(param1:ApiHeader, param2:String, param3:String, param4:Function, param5:Function) : void;
      
      function unionList(param1:ApiHeader, param2:int, param3:int, param4:Function, param5:Function) : void;
      
      function unionApply(param1:ApiHeader, param2:int, param3:String, param4:Function, param5:Function) : void;
      
      function unionOfMe(param1:ApiHeader, param2:Function, param3:Function) : void;
      
      function test(param1:Function, param2:Function) : void;
   }
}

