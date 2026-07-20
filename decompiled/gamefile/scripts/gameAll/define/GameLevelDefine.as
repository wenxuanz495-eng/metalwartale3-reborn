package gameAll.define
{
   public class GameLevelDefine
   {
      
      public var knowLevelLevel:Array = [];
      
      public var ghostLevelLevel:Array = [];
      
      public function GameLevelDefine()
      {
         super();
         this.knowLevelLevel[0] = [25,28,30,32,35,40,45,50,50,50,60,60,60,60,60,60];
         this.knowLevelLevel[1] = [54,54,54,55,55,56,56,60,60,60,60,60,60,60,60,60];
         this.knowLevelLevel[2] = [56,56,56,57,57,58,58,61,61,62,62,62,62,62,62,62];
         this.knowLevelLevel[3] = [58,58,58,59,59,60,60,63,63,64,64,64,64,64,64,64];
         this.ghostLevelLevel[0] = [60,60,61,61,62,62,63,63,64,64,71,72,73,74,75,76,77,78,79,80];
         this.ghostLevelLevel[1] = [65,65,65,66,66,66,67,67,67,68,72,73,74,75,76,77,78,79,80,81];
         this.ghostLevelLevel[2] = [68,68,68,69,69,70,70,70,70,70,73,74,75,76,77,78,79,80,81,82];
         this.ghostLevelLevel[3] = [71,71,71,71,72,72,72,72,73,73,74,75,76,77,78,79,80,81,82,83];
      }
      
      public function setLevel(id0:String, arr0:Array) : *
      {
         var l_arr0:Array = null;
         if(arr0.length <= 0)
         {
            return;
         }
         var l_arr:Array = [[],this.knowLevelLevel,this.ghostLevelLevel];
         var id1:int = int(id0.split("-")[0]);
         var id2:int = int(id0.split("-")[1]);
         var id3:int = int(id0.split("-")[2]);
         if(id1 == 1)
         {
            l_arr0 = l_arr[int(id2) - 1];
            if(l_arr0.length > 0)
            {
               l_arr0[0][id3] = arr0[0];
               l_arr0[1][id3] = arr0[1];
               l_arr0[2][id3] = arr0[2];
               l_arr0[3][id3] = arr0[3];
            }
         }
      }
      
      public function getEnemyLevel_byLevel(level0:int, diff0:int, levelPack0:String = "") : int
      {
         var lv0:int = 0;
         if(levelPack0 == "knowing")
         {
            lv0 = int(this.knowLevelLevel[diff0][level0]);
            if(lv0 == 0)
            {
               lv0 = 60;
            }
         }
         else if(levelPack0 == "ghost")
         {
            lv0 = int(this.ghostLevelLevel[diff0][level0]);
            if(lv0 == 0)
            {
               lv0 = 60;
            }
         }
         else
         {
            if(diff0 == 0)
            {
               if(level0 < 21)
               {
                  lv0 = level0;
               }
               else
               {
                  lv0 = 20 + int((level0 - 20) / 2);
               }
            }
            else if(diff0 == 1)
            {
               if(level0 < 13)
               {
                  lv0 = int((level0 - 1) / 2) + 26;
               }
               else
               {
                  lv0 = int(level0 / 2) + 26;
               }
               if(lv0 > 40)
               {
                  lv0 = 40;
               }
            }
            else if(diff0 == 2)
            {
               if(level0 < 13)
               {
                  lv0 = int((level0 - 1) / 3) + 41;
               }
               else
               {
                  lv0 = int((level0 + 1) / 3) + 41;
               }
               if(lv0 > 50)
               {
                  lv0 = 50;
               }
               if(level0 == 22)
               {
                  lv0 = 49;
               }
            }
            else if(diff0 == 3)
            {
               lv0 = int(level0 / 7) + 51;
               if(lv0 > 54)
               {
                  lv0 = 54;
               }
            }
            if(lv0 < 1)
            {
               lv0 = 1;
            }
         }
         return lv0 - 1;
      }
   }
}

