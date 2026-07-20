package ctrl4399.proxy.unionApi
{
   public interface GrowApi
   {
      
      function doTask(param1:ApiHeader, param2:String, param3:Function, param4:Function) : void;
      
      function getTaskValue(param1:ApiHeader, param2:Function, param3:Function) : void;
      
      function exchange(param1:ApiHeader, param2:int, param3:Function, param4:Function) : void;
      
      function test(param1:Function, param2:Function) : void;
   }
}

