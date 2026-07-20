package UI.icon
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class AllIconLoader extends Sprite
   {
      
      public var icon_mc:MovieClip;
      
      public function AllIconLoader()
      {
         super();
      }
      
      public function clear() : *
      {
         if(this.icon_mc != null)
         {
            removeChild(this.icon_mc);
            this.icon_mc = null;
         }
      }
      
      public function addIcon(imgLabel:*) : *
      {
         var icon0:MovieClip = Game.swfLoaderManager.getResource("",imgLabel);
         if(Boolean(icon0))
         {
            this.setIcon(icon0);
         }
      }
      
      private function setIcon(mc0:MovieClip) : *
      {
         this.clear();
         this.icon_mc = mc0;
         mc0.stop();
         addChild(mc0);
         var mc1:* = mc0.getChildByName("shootPoint");
         var mc2:* = mc0.getChildByName("basePoint");
         if(mc1 is MovieClip)
         {
            mc0.removeChild(mc1);
            mc0.removeChild(mc2);
         }
         var rect0:Rectangle = mc0.getRect(mc0);
         mc0.x = -rect0.x - rect0.width / 2;
         mc0.y = -rect0.y - rect0.height / 2;
      }
   }
}

