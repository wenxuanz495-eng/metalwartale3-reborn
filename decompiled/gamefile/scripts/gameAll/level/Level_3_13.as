package gameAll.level
{
   import flash.geom.Point;
   
   public class Level_3_13 extends GhostLevel
   {
      
      public function Level_3_13()
      {
         super();
      }
      
      override public function gotoPortal() : *
      {
         Game.eventGroup.pauseGame();
         Game.uiGroup.checkTip.showCheck("进入这个传送门，你将挑战一个强大的敌人！\n是否前往？",this.yes_gotoPortal,this.no_gotoPortal,1);
      }
      
      public function yes_gotoPortal() : *
      {
         var mc0:* = undefined;
         Game.eventGroup.resumeGame();
         if(Boolean(nowPortal))
         {
            area.splice(area.indexOf(nowPortal),1);
            mc0 = BG.supply_arr[nowPortal.index];
            mc0.stop();
            mc0.visible = false;
         }
         nowPortal = null;
         supplyB = 0;
         Game.LG.doOrder_byID("enemy_4",new Point(hero.MX,hero.MY),true);
      }
      
      public function no_gotoPortal() : *
      {
         Game.eventGroup.resumeGame();
      }
      
      override public function bodyAdd(b0:*) : *
      {
         var arr0:Array = null;
         super.bodyAdd(b0);
         if(b0.type == "boss")
         {
            arr0 = [0.9,1.3,1.8,2.7];
            b0.define.maxLife = arr0[Game.gameData.nowDifficult] * 100000000;
            b0.define.mulLife();
         }
      }
   }
}

