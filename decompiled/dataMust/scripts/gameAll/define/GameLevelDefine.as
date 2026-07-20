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
      
      public function setLevel(param1:String, param2:Array) : *
      {
         var _loc7_:Array = null;
         if(param2.length <= 0)
         {
            return;
         }
         var _loc3_:Array = [[],this.knowLevelLevel,this.ghostLevelLevel];
         var _loc4_:int = int(param1.split("-")[0]);
         var _loc5_:int = int(param1.split("-")[1]);
         var _loc6_:int = int(param1.split("-")[2]);
         if(_loc4_ == 1)
         {
            _loc7_ = _loc3_[int(_loc5_) - 1];
            if(_loc7_.length > 0)
            {
               _loc7_[0][_loc6_] = param2[0];
               _loc7_[1][_loc6_] = param2[1];
               _loc7_[2][_loc6_] = param2[2];
               _loc7_[3][_loc6_] = param2[3];
            }
         }
      }
      
      public function getEnemyLevel_byLevel(param1:int, param2:int, param3:String = "") : int
      {
         var _loc4_:int = 0;
         if(param3 == "knowing")
         {
            _loc4_ = int(this.knowLevelLevel[param2][param1]);
            if(_loc4_ == 0)
            {
               _loc4_ = 60;
            }
         }
         else if(param3 == "ghost")
         {
            _loc4_ = int(this.ghostLevelLevel[param2][param1]);
            if(_loc4_ == 0)
            {
               _loc4_ = 60;
            }
         }
         else
         {
            if(param2 == 0)
            {
               if(param1 < 21)
               {
                  _loc4_ = param1;
               }
               else
               {
                  _loc4_ = 20 + int((param1 - 20) / 2);
               }
            }
            else if(param2 == 1)
            {
               if(param1 < 13)
               {
                  _loc4_ = int((param1 - 1) / 2) + 26;
               }
               else
               {
                  _loc4_ = int(param1 / 2) + 26;
               }
               if(_loc4_ > 40)
               {
                  _loc4_ = 40;
               }
            }
            else if(param2 == 2)
            {
               if(param1 < 13)
               {
                  _loc4_ = int((param1 - 1) / 3) + 41;
               }
               else
               {
                  _loc4_ = int((param1 + 1) / 3) + 41;
               }
               if(_loc4_ > 50)
               {
                  _loc4_ = 50;
               }
               if(param1 == 22)
               {
                  _loc4_ = 49;
               }
            }
            else if(param2 == 3)
            {
               _loc4_ = int(param1 / 7) + 51;
               if(_loc4_ > 54)
               {
                  _loc4_ = 54;
               }
            }
            if(_loc4_ < 1)
            {
               _loc4_ = 1;
            }
         }
         return _loc4_ - 1;
      }
   }
}

