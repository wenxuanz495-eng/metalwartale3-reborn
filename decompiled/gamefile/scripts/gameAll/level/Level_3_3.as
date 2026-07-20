package gameAll.level
{
   import enemy._normal.Normal_FlyBody;
   
   public class Level_3_3 extends GhostLevel
   {
      
      public function Level_3_3()
      {
         super();
      }
      
      override public function bodyAdd(b0:*) : *
      {
         super.bodyAdd(b0);
         if(b0.type == "boss")
         {
            if(b0 is Normal_FlyBody)
            {
               if(b0.define.name == "暴君")
               {
                  b0.toDieB = false;
                  nowBoss = b0;
               }
            }
         }
      }
      
      public function timeTimer() : *
      {
         if(Boolean(nowBoss))
         {
            if(nowBoss.define.getLifePer() < 0.5)
            {
               nowBoss.hitHurtB = 1;
               Game.eventGroup.dieDelay.addFisrtDialogue(nowBoss.define.dialogue,nowBoss);
               nowBoss = null;
               Game.dialogboxGroup.showGameTip("g1-3-2",15);
               unlockView();
            }
         }
      }
      
      override public function firstDialogueOver(b0:*) : *
      {
         if(b0.define.getLifePer() < 0.5)
         {
            b0.hitHurtB = 1;
            b0.ai.attackBody(hero);
         }
      }
      
      override public function levelTimer() : *
      {
         if(enabled)
         {
            super.levelTimer();
            this.timeTimer();
         }
      }
   }
}

