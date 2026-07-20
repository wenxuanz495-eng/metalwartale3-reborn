package unit4399.picLoad
{
   public interface IJPGLoader
   {
      
      function loadSync(param1:Function = null, param2:int = 1) : void;
      
      function cancel() : void;
      
      function isStarted() : Boolean;
   }
}

