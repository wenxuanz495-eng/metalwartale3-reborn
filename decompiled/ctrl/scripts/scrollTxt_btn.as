package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol450")]
   public dynamic class scrollTxt_btn extends MovieClip
   {
      
      public var txt:TextField;
      
      public function scrollTxt_btn()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}

