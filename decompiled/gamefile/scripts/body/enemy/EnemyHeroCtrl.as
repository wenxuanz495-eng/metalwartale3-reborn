package body.enemy
{
   import body.hero.CarDefine;
   import gameAll.define.WeekExtraOneDefine;
   
   public class EnemyHeroCtrl
   {
      
      public function EnemyHeroCtrl()
      {
         super();
      }
      
      public function changeAll(b0:EnemyHeroBody, level0:int = 0) : *
      {
         this.changeArms(b0,level0);
         this.changeSub(b0,level0);
         this.changeCar(b0,level0);
         b0.ai.fleshArms();
      }
      
      public function changeAll_byName(b0:EnemyHeroBody) : *
      {
         var d0:WeekExtraOneDefine = null;
         var diff:int = Game.gameData.nowDifficult;
         var hurt_0:Number = 1;
         var life_0:Number = 0;
         if(b0.define.trueName == "铁鸦背叛者")
         {
            b0.ai.armsArr = ["soya_lv2","fireFairy_lv4","cannon_lv4","laserPulse_lv4"];
            b0.ai.subArr = ["missile_lv4","elastic_lv4"];
            b0.ai.skillNum = [8,4,3];
            b0.ai.carLabel = "nightrider";
            if(diff == 0)
            {
               hurt_0 = 0.038;
            }
            else if(diff == 1)
            {
               hurt_0 = 0.9;
            }
            else if(diff == 2)
            {
               hurt_0 = 3.8;
            }
            else if(diff == 3)
            {
               hurt_0 = 16;
            }
         }
         else if(b0.define.trueName == "铁鸦队长")
         {
            b0.ai.armsArr = ["soya_lv3","shotgun_lv4","induction_lv4","wave_lv4"];
            b0.ai.subArr = ["laser_lv4","cutter_lv4"];
            b0.ai.skillNum = [10,5,5];
            b0.ai.carLabel = "fireDemon";
            if(diff == 0)
            {
               hurt_0 = 0.047;
            }
            else if(diff == 1)
            {
               hurt_0 = 0.72;
            }
            else if(diff == 2)
            {
               hurt_0 = 2.4;
            }
            else if(diff == 3)
            {
               hurt_0 = 12;
            }
         }
         else if(b0.define.trueName == "铁鸦战队指挥官")
         {
            b0.ai.armsArr = ["soya_lv4","etcg_lv4","lightning_lv4","charged_lv4"];
            b0.ai.subArr = ["hotline_lv4","lightningBall_lv4"];
            b0.ai.skillNum = [15,8,8];
            b0.ai.carLabel = "predator";
            if(diff == 0)
            {
               hurt_0 = 0.076;
            }
            else if(diff == 1)
            {
               hurt_0 = 0.63;
            }
            else if(diff == 2)
            {
               hurt_0 = 4;
            }
            else if(diff == 3)
            {
               hurt_0 = 11.5;
            }
         }
         else if(b0.define.trueName == "Vincent")
         {
            d0 = Game.gameDefine.weekExtra.getDefine("3-1-0");
            b0.ai.armsArr = d0.armsArr;
            b0.ai.subArr = d0.subArr;
            b0.ai.skillNum = d0.skillNum;
            b0.ai.carLabel = d0.carLabel;
            if(diff == 0)
            {
               hurt_0 = 10;
               life_0 = 6000000;
            }
            else if(diff == 1)
            {
               hurt_0 = 25;
               life_0 = 25000000;
            }
            else if(diff == 2)
            {
               hurt_0 = 40;
               life_0 = 30000000;
            }
            else if(diff == 3)
            {
               hurt_0 = 60;
               life_0 = 40000000;
            }
            hurt_0 *= 0.5;
            life_0 *= 0.5;
            b0.define.maxLife = life_0;
            b0.define.mulLife();
         }
         else if(b0.define.trueName == "炮王")
         {
            d0 = Game.gameDefine.weekExtra.getDefine("3-1-2");
            b0.ai.armsArr = d0.armsArr;
            b0.ai.subArr = d0.subArr;
            b0.ai.skillNum = d0.skillNum;
            b0.ai.carLabel = d0.carLabel;
            if(diff == 0)
            {
               hurt_0 = 10;
               life_0 = 6000000;
            }
            else if(diff == 1)
            {
               hurt_0 = 25;
               life_0 = 25000000;
            }
            else if(diff == 2)
            {
               hurt_0 = 40;
               life_0 = 30000000;
            }
            else if(diff == 3)
            {
               hurt_0 = 60;
               life_0 = 40000000;
            }
            b0.define.maxLife = life_0;
            b0.define.mulLife();
         }
         else if(b0.define.trueName == "叫兽")
         {
            d0 = Game.gameDefine.weekExtra.getDefine("3-1-3");
            b0.ai.armsArr = d0.armsArr;
            b0.ai.subArr = d0.subArr;
            b0.ai.skillNum = d0.skillNum;
            b0.ai.carLabel = d0.carLabel;
            if(diff == 0)
            {
               hurt_0 = 10;
               life_0 = 6000000;
            }
            else if(diff == 1)
            {
               hurt_0 = 25;
               life_0 = 25000000;
            }
            else if(diff == 2)
            {
               hurt_0 = 40;
               life_0 = 30000000;
            }
            else if(diff == 3)
            {
               hurt_0 = 60;
               life_0 = 40000000;
            }
            b0.define.maxLife = life_0;
            b0.define.mulLife();
         }
         b0.ai.fleshArms();
         b0.define.hurt_0 = hurt_0;
      }
      
      public function changeArms(b0:EnemyHeroBody, level0:int = 0) : *
      {
         var num1:int = 0;
         var num0:int = int(2 + Math.random() * 5);
         var arr0:Array = Game.defineGroup.getStrArr_byMustLevel(level0,"arms");
         var arr1:Array = [];
         for(var n:int = 0; n < num0; n++)
         {
            num1 = Math.random() * arr0.length;
            arr1.push(arr0[num1]);
            arr0.splice(num1,1);
            if(arr0.length <= 0)
            {
               break;
            }
         }
         trace("主武器列表：" + arr1);
         b0.ai.armsArr = arr1;
      }
      
      public function getSubNum_byLevel(level0:int) : int
      {
         var num0:int = 1;
         if(level0 < 10)
         {
            num0 = 1;
         }
         else if(level0 < 20)
         {
            num0 = 2;
         }
         else
         {
            num0 = 3;
         }
         return num0;
      }
      
      public function changeSub(b0:EnemyHeroBody, level0:int = 0) : *
      {
         var num1:int = 0;
         var num0:int = this.getSubNum_byLevel(level0);
         var arr0:Array = Game.defineGroup.getStrArr_byMustLevel(level0,"subArms");
         var arr1:Array = [];
         for(var n:int = 0; n < num0; n++)
         {
            num1 = Math.random() * arr0.length;
            arr1.push(arr0[num1]);
            arr0.splice(num1,1);
            if(arr0.length <= 0)
            {
               break;
            }
         }
         trace("副武器列表：" + arr1);
         b0.ai.subArr = arr1;
      }
      
      public function changeCar(b0:EnemyHeroBody, level0:int = 0) : *
      {
         var d0:CarDefine = Game.defineGroup.getCarDefine_byMustLevel(level0 + 1);
         if(!d0)
         {
            throw new Error("敌方战车随机为空！");
         }
         var label0:String = d0.id;
         if(label0 != "")
         {
            b0.ai.carLabel = label0;
         }
      }
   }
}

