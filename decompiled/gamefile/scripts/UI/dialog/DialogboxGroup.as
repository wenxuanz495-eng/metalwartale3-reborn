package UI.dialog
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class DialogboxGroup
   {
      
      public var arr:Array = [];
      
      public var dialogbox:Dialogbox = new Dialogbox();
      
      public var dialogbox2:Dialogbox2 = new Dialogbox2();
      
      public function DialogboxGroup()
      {
         super();
      }
      
      public function init() : *
      {
         this.dialogbox.inBackData(Game.swfLoaderManager.getResource("dialogbox","Dialogbox_mc"));
         this.dialogbox.init();
         this.dialogbox2.inBackData(Game.swfLoaderManager.getResource("dialogbox","Dialogbox_mc2"));
         this.dialogbox2.init();
      }
      
      public function showDialog(b0:*, str0:String, _point:Point = null, _time:Number = 4, _truePoint:Point = null) : *
      {
         var pp0:Point = null;
         str0 = str0.replace("player",Game.gameData.playerName);
         var rect0:Rectangle = b0.hitRect;
         var xmax0:int = rect0.width / 2 + 50;
         var ymax0:int = rect0.height / 3 - 25;
         if(_point == null)
         {
            pp0 = new Point(xmax0,-ymax0);
         }
         else
         {
            pp0 = _point;
         }
         var px0:int = 0;
         var mx0:Number = 0;
         var lpx:Number = 10;
         var p0:Point = Game.oneScene.getPositionMiddle();
         var cx:Number = b0.MX - p0.x;
         if(cx > 0)
         {
            lpx = 10;
            mx0 = 0.7;
            pp0.x = -xmax0;
         }
         else
         {
            lpx = -10;
            mx0 = 0.3;
            pp0.x = xmax0;
         }
         var py0:int = 0;
         var my0:Number = 0;
         var lpy:Number = 10;
         var cy:Number = b0.MY - p0.y;
         if(cy > -80)
         {
            lpy = 10;
            my0 = 1;
            pp0.y = -ymax0;
         }
         else
         {
            lpy = -10;
            my0 = 0;
            pp0.y = ymax0;
         }
         px0 = pp0.x + lpx;
         py0 = pp0.y;
         this.dialogbox.show(Game.gameSprite.dialopL,str0,px0,py0,mx0,my0,b0,_time,100,new Point(lpx,lpy));
      }
      
      public function showGameTip(str0:String, _time:Number = 5, textOrMc:Boolean = false) : *
      {
         this.dialogbox2.show(Game.gameSprite.gameTipL,str0,Game.stageWidth / 2,90,0.5,0,null,_time,null,textOrMc);
      }
      
      public function showSkillTip(str0:String, linePoint:Point, _time:Number = 5) : *
      {
         var px0:int = 0;
         var py0:int = 0;
         var mx0:Number = 0;
         if(linePoint.x < 200 || linePoint.x > 450 && linePoint.x < 700)
         {
            px0 = linePoint.x + 50 + 10;
            mx0 = 0;
         }
         else
         {
            px0 = linePoint.x - (50 + 10);
            mx0 = 1;
         }
         if(linePoint.y > 240)
         {
            py0 = linePoint.y - 50;
         }
         else
         {
            py0 = linePoint.y + 50;
         }
         this.dialogbox2.show(Game.gameSprite.topTipL,str0,px0,py0,mx0,0.5,null,_time,new Point(linePoint.x - px0,linePoint.y - py0));
      }
      
      public function clearAllDialog() : *
      {
         this.dialogbox.clear();
         this.dialogbox.refreshB = false;
         this.dialogbox2.clear();
         this.dialogbox.refreshB = false;
      }
      
      public function stopAllDialog() : *
      {
         this.dialogbox.refreshB = false;
         this.dialogbox.refreshB = false;
      }
      
      public function continueAllDialog() : *
      {
         this.dialogbox.refreshB = true;
         this.dialogbox.refreshB = true;
      }
      
      public function dialogTimer() : *
      {
         this.dialogbox.timer();
         this.dialogbox2.timer();
      }
   }
}

