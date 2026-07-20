package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol254")]
   public dynamic class LogSucTipMc extends MovieClip
   {
      
      public function LogSucTipMc()
      {
         super();
         addFrameScript(0,this.frame1,56,this.frame57);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame57() : *
      {
         if(Boolean(this) && Boolean(this.parent))
         {
            if(this.parent.contains(this))
            {
               this.parent.removeChild(this);
            }
         }
         stop();
      }
   }
}

