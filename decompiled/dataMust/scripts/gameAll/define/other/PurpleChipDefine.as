package gameAll.define.other
{
   public class PurpleChipDefine
   {
      
      public function PurpleChipDefine()
      {
         super();
      }
      
      public function getAddArr(param1:String) : Array
      {
         return this[param1]();
      }
      
      private function ben_purple_chip() : Array
      {
         var _loc1_:Array = ["dps","dps_pro","crit_pro","crit_mul","allAdd","subAdd","attackAdd","lifeAdd"];
         var _loc2_:Array = [[101,150],[0.09,0.12],[0.08,0.1],[0.21,0.3],[0.02],[0.02],[0.02],[0.02]];
         return this.getArr(_loc1_,_loc2_);
      }
      
      private function zhui_purple_chip() : Array
      {
         var _loc1_:Array = ["life_max","defence_max","life_rate","lifeBall","allAdd","lifeAdd","defenceAdd","attackAdd"];
         var _loc2_:Array = [[0.08,0.1],[51,60],[61,80],[0.08,0.1],[0.02],[0.02],[0.02],[0.02]];
         return this.getArr(_loc1_,_loc2_);
      }
      
      private function jing_purple_chip() : Array
      {
         var _loc1_:Array = ["dps","dps_pro","crit_pro","crit_mul","allAdd","subAdd","attackAdd","lifeAdd"];
         var _loc2_:Array = [[601,800],[0.21,0.25],[0.21,0.25],[0.81,1],[0.04],[0.04],[0.04],[0.04]];
         return this.getArr(_loc1_,_loc2_);
      }
      
      private function zu_purple_chip() : Array
      {
         var _loc1_:Array = ["life_max","defence_max","life_rate","lifeBall","allAdd","lifeAdd","defenceAdd","attackAdd"];
         var _loc2_:Array = [[0.26,0.3],[151,200],[201,250],[0.26,0.3],[0.04],[0.04],[0.04],[0.04]];
         return this.getArr(_loc1_,_loc2_);
      }
      
      private function zhen_purple_chip() : Array
      {
         var _loc1_:Array = ["dps","dps_pro","crit_pro","crit_mul","allAdd","subAdd","attackAdd","lifeAdd"];
         var _loc2_:Array = [[1201,1500],[0.31,0.4],[0.31,0.4],[1.21,1.6],[0.06],[0.06],[0.06],[0.06]];
         return this.getArr(_loc1_,_loc2_);
      }
      
      private function lie_purple_chip() : Array
      {
         var _loc1_:Array = ["life_max","defence_max","life_rate","lifeBall","allAdd","lifeAdd","defenceAdd","attackAdd"];
         var _loc2_:Array = [[0.41,0.45],[801,1000],[601,800],[0.41,0.45],[0.06],[0.06],[0.06],[0.06]];
         return this.getArr(_loc1_,_loc2_);
      }
      
      private function nu_purple_chip() : Array
      {
         var _loc1_:Array = ["dps","dps_pro","crit_pro","crit_mul","allAdd","subAdd","attackAdd","lifeAdd"];
         var _loc2_:Array = [[1801,2200],[0.41,0.45],[0.41,0.45],[1.61,1.8],[0.08],[0.08],[0.08],[0.08]];
         return this.getArr(_loc1_,_loc2_);
      }
      
      private function kuang_purple_chip() : Array
      {
         var _loc1_:Array = ["life_max","defence_max","life_rate","lifeBall","allAdd","lifeAdd","defenceAdd","attackAdd"];
         var _loc2_:Array = [[0.46,0.5],[1801,2200],[1401,1600],[0.46,0.5],[0.08],[0.08],[0.08],[0.08]];
         return this.getArr(_loc1_,_loc2_);
      }
      
      private function jinian_chip() : Array
      {
         var _loc1_:Array = ["dps","dps_pro","crit_pro","crit_mul","allAdd","subAdd","attackAdd"];
         var _loc2_:Array = [[3000],[0.5],[0.5],[2],[0.2],[0.2],[0.2]];
         return this.getArr(_loc1_,_loc2_);
      }
      
      private function getArr(param1:Array, param2:Array) : Array
      {
         var _loc4_:* = undefined;
         var _loc5_:Array = null;
         var _loc6_:Number = NaN;
         var _loc3_:Array = [];
         for(_loc4_ in param1)
         {
            _loc5_ = param2[_loc4_];
            _loc6_ = 0;
            if(_loc5_.length >= 2)
            {
               _loc6_ = this.getRa(_loc5_);
            }
            else
            {
               _loc6_ = Number(_loc5_[0]);
            }
            _loc3_.push(param1[_loc4_] + ":" + _loc6_);
         }
         return _loc3_;
      }
      
      public function getRa(param1:Array) : Number
      {
         return param1[0] + Math.random() * (param1[1] - param1[0]);
      }
   }
}

