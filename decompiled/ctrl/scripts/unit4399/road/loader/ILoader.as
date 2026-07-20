package unit4399.road.loader
{
   public interface ILoader
   {
      
      function loadSync(param1:Function = null, param2:int = 1) : void;
      
      function cancel() : void;
      
      function isStarted() : Boolean;
   }
}

