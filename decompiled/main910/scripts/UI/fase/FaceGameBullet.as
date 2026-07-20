package UI.fase
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol169")]
   public dynamic class FaceGameBullet extends MovieClip
   {
      
      public function FaceGameBullet()
      {
         super();
         addFrameScript(11,this.frame12);
      }
      
      internal function frame12() : *
      {
         stop();
      }
   }
}

