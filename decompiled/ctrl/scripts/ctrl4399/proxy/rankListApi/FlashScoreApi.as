package ctrl4399.proxy.rankListApi
{
   public interface FlashScoreApi
   {
      
      function submit(param1:ApiHeader, param2:int, param3:Array, param4:Function, param5:Function) : void;
      
      function getRankingByArounds(param1:ApiHeader, param2:int, param3:int, param4:int, param5:Function, param6:Function) : void;
      
      function getRankingByPage(param1:ApiHeader, param2:int, param3:int, param4:int, param5:Function, param6:Function) : void;
      
      function getRank(param1:ApiHeader, param2:int, param3:String, param4:Function, param5:Function) : void;
      
      function test(param1:Function, param2:Function) : void;
   }
}

