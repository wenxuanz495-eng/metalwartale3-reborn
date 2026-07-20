package ctrl4399.view.components.as3Ad4399Frame
{
   import ctrl4399.strconst.AllConst;
   import flash.display.Sprite;
   
   public class LoaderBrandAd extends Sprite
   {
      
      private var _gameId:String;
      
      private var _adContent:ADContent;
      
      public function LoaderBrandAd(param1:String)
      {
         super();
         this._gameId = param1;
      }
      
      public function loadBrandAD(param1:String, param2:String) : void
      {
         var adPath:String = param1;
         var clickPath:String = param2;
         if(this._adContent != null)
         {
            try
            {
               this._adContent.dispose();
            }
            catch(e:Error)
            {
               _adContent = null;
            }
            this._adContent = null;
         }
         this._adContent = new ADContent();
         this._adContent.setData(adPath,AllConst.URL_GAME_LIST_AD_REDICT + "&link=" + clickPath,484,64,this._gameId);
         addChild(this._adContent);
      }
   }
}

