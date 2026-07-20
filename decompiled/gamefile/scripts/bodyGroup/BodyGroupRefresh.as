package bodyGroup
{
   import UI.gaming.EnemyLifeBar;
   import effect.EffectGroup;
   import enemy.AI.EnemySkill;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public class BodyGroupRefresh
   {
      
      private var BG:BodyGroup;
      
      private var EG:EffectGroup;
      
      public function BodyGroupRefresh()
      {
         super();
      }
      
      public function init() : *
      {
         this.BG = Game.BG;
         this.EG = Game.EG;
      }
      
      private function refreshTimer2(arr0:Array) : *
      {
         var m:* = undefined;
         var arr1:Array = null;
         var n:* = undefined;
         for(m in arr0)
         {
            arr1 = arr0[m];
            for(n in arr1)
            {
               arr1[n].bodyTimer();
            }
         }
      }
      
      private function refreshTimer(arr0:Array) : *
      {
         var n:* = undefined;
         for(n in arr0)
         {
            arr0[n].bodyTimer();
         }
      }
      
      private function bodyDel(arr0:Array) : *
      {
         var n:* = undefined;
         var b0:* = undefined;
         for(n in arr0)
         {
            b0 = arr0[n];
            if(b0.die == 2)
            {
               b0.img.clear();
               b0.img.parent.removeChild(b0.img);
               arr0.splice(n,1);
               return;
            }
         }
      }
      
      private function bodyArrDel(arr1:Array) : *
      {
         var m:* = undefined;
         var arr0:Array = null;
         var n:* = undefined;
         var b0:* = undefined;
         for(m in arr1)
         {
            arr0 = arr1[m];
            for(n in arr0)
            {
               b0 = arr0[n];
               if(b0.die == 2)
               {
                  b0.img.clear();
                  b0.img.parent.removeChild(b0.img);
                  if(Boolean(b0.hasOwnProperty("ai")))
                  {
                     if(Boolean(b0.ai.hasOwnProperty("skill")))
                     {
                        if(b0.ai.skill is EnemySkill)
                        {
                           b0.ai.skill.clearPlasma();
                        }
                     }
                  }
                  arr0.splice(n,1);
                  return;
               }
            }
         }
      }
      
      private function bulletDel_Follow() : *
      {
         var arr1:Array = null;
         var arr2:Array = null;
         var n:* = undefined;
         var b0:* = undefined;
         var tp:Point = null;
         var smc:* = undefined;
         for(var m:int = 0; m < 2; m++)
         {
            arr1 = this.BG.bullet_arr[m];
            arr2 = [];
            for(n in arr1)
            {
               b0 = arr1[n];
               if(b0.die == 2)
               {
                  if(b0.bulletType == "laser")
                  {
                     if(Boolean(b0.imgB))
                     {
                        if(Boolean(b0.img.endFrameB))
                        {
                           b0.img.clear();
                           b0.img.mc.parent.removeChild(b0.img.mc);
                        }
                        else
                        {
                           arr2.push(b0);
                        }
                     }
                  }
                  else
                  {
                     b0.img.clear();
                     b0.img.mc.parent.removeChild(b0.img.mc);
                     b0.mot.updated = false;
                     if(b0.selfBoom > 0)
                     {
                        if(Boolean(b0.selfDie))
                        {
                           this.EG.addEffect(b0.imgFather,b0.hitImgLabel,Game.gameSprite.effectL,b0.mot.x0,b0.mot.y0);
                        }
                     }
                  }
               }
               else
               {
                  if(b0.bulletType == "bullet")
                  {
                     if(b0.followB > 0)
                     {
                        if(b0.targetBody == null)
                        {
                           if(b0.attackBody.camp == "we")
                           {
                              b0.targetBody = this.BG.getHurt_RandomEnemy();
                           }
                           else
                           {
                              b0.targetBody = this.BG.heroCar_arr[0];
                           }
                        }
                     }
                     if(b0.backTime > 0)
                     {
                        if(b0.live_t >= b0.backTime)
                        {
                           b0.followAttackBody();
                        }
                     }
                     if(b0.smokeImgLabel != "")
                     {
                        tp = b0.mot.getTailPoint(20);
                        smc = this.EG.addEffect(b0.imgFather,b0.smokeImgLabel,Game.gameSprite.smokeL,tp.x,tp.y,b0.ra,true);
                     }
                  }
                  arr2.push(b0);
               }
            }
            this.BG.bullet_arr[m] = arr2;
         }
         this.BG.we_bullet = this.BG.bullet_arr[0];
         this.BG.enemy_bullet = this.BG.bullet_arr[1];
      }
      
      public function refreshLifeBarTimer() : *
      {
         var n:* = undefined;
         var l0:EnemyLifeBar = null;
         var arr0:Array = this.BG.lifeBar_arr;
         var arr1:Array = [];
         for(n in arr0)
         {
            l0 = arr0[n];
            l0.bodyTimer();
            if(l0.BB.die == 0)
            {
               arr1.push(l0);
            }
            else
            {
               Game.gameSprite.textL.removeChild(l0);
               l0.BB.define.lifeBar = null;
               l0.BB = null;
            }
         }
         this.BG.lifeBar_arr = arr1;
      }
      
      public function FTimer() : *
      {
         var tt:int = getTimer();
         this.refreshTimer(this.BG.enemy_bullet);
         this.refreshTimer(this.BG.we_bullet);
         this.bulletDel_Follow();
         this.refreshTimer(this.BG.heroCar_arr);
         this.refreshTimer(this.BG.sub_arr);
         this.refreshTimer(this.BG.weAir_arr);
         this.refreshTimer(this.BG.weLand_arr);
         this.refreshTimer2(this.BG.enemy_arr);
         this.refreshTimer(this.BG.GundamFunnel_arr);
         this.refreshTimer(this.BG.enemySub_arr);
         this.refreshTimer(this.BG.weBanshee_arr);
         this.refreshTimer(this.BG.things_arr);
         this.refreshLifeBarTimer();
         this.bodyArrDel(this.BG.enemy_arr);
         this.bodyDel(this.BG.GundamFunnel_arr);
      }
   }
}

