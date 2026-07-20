package UI.gaming
{
   import UI.button.PicButton;
   import flash.display.Sprite;
   
   public class GamingPauseUI extends Sprite
   {
      
      public var resumeGame_btn:PicButton;
      
      public var restartLevel_btn:PicButton;
      
      public var overLevel_btn:PicButton;
      
      private var btn_arr:Array;
      
      public function GamingPauseUI()
      {
         super();
      }
      
      public function init() : *
      {
         this.btn_arr = [this.resumeGame_btn,this.restartLevel_btn,this.overLevel_btn];
         this.resumeGame_btn.setBack("orange1");
         this.initBtn();
      }
      
      private function initBtn() : *
      {
         var n:* = undefined;
         var name0:String = null;
         for(n in this.btn_arr)
         {
            name0 = this.btn_arr[n].name;
            name0 = name0.split("_btn")[0];
            this.btn_arr[n].setText(name0);
         }
      }
      
      public function setState(levelState0:String = "normal") : *
      {
         this.restartLevel_btn.actived = true;
         if(levelState0 == "normal")
         {
            this.restartLevel_btn.setText("restartLevel");
            this.overLevel_btn.setText("overLevel");
            if(Game.gameData.nowGameLevel >= 999)
            {
               this.restartLevel_btn.noLabelB = true;
               this.restartLevel_btn.actived = false;
            }
            else
            {
               this.restartLevel_btn.actived = true;
            }
         }
         else if(levelState0 == "extra" || levelState0 == "weekExtra" || levelState0 == "specialExtra")
         {
            this.restartLevel_btn.setText("restartExtra");
            this.overLevel_btn.setText("closeExtra");
         }
         else if(levelState0 == "arena")
         {
            this.restartLevel_btn.noLabelB = true;
            this.restartLevel_btn.actived = false;
         }
      }
   }
}

