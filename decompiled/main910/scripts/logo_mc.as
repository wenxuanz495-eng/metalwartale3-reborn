package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol116")]
   public dynamic class logo_mc extends MovieClip
   {
      
      public var continueBn:SimpleButton;
      
      public var clickMc:MovieClip;
      
      public var loadMc:MovieClip;
      
      public function logo_mc()
      {
         super();
         addFrameScript(0,this.frame1,99,this.frame100,267,this.frame268,432,this.frame433);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame100() : *
      {
         this.clickMc.buttonMode = false;
      }
      
      internal function frame268() : *
      {
      }
      
      internal function frame433() : *
      {
         stop();
      }
   }
}

