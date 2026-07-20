package gameAll.define.other
{
   public class PurpleChipDefine
   {
      
      public function PurpleChipDefine()
      {
         super();
      }
      
      public function getAddArr(name0:String) : Array
      {
         return this[name0]();
      }
      
      private function ben_purple_chip() : Array
      {
         var nameArr:Array = ["dps","dps_pro","crit_pro","crit_mul","allAdd","subAdd","attackAdd","lifeAdd"];
         var proArr:Array = [[462,1215],[0.11,0.2],[0.11,0.2],[0.31,0.5],[0.01,0.03],[0.01,0.03],[0.01,0.03],[0.01,0.03]];
         return this.getArr(nameArr,proArr);
      }
      
      private function zhui_purple_chip() : Array
      {
         var nameArr:Array = ["life_max","defence_max","life_rate","lifeBall","allAdd","lifeAdd","defenceAdd","attackAdd"];
         var proArr:Array = [[0.11,0.2],[135,257],[167,601],[0.09,0.16],[0.01,0.03],[0.01,0.03],[0.01,0.03],[0.01,0.03]];
         return this.getArr(nameArr,proArr);
      }
      
      private function jing_purple_chip() : Array
      {
         var nameArr:Array = ["dps","dps_pro","crit_pro","crit_mul","allAdd","subAdd","attackAdd","lifeAdd"];
         var proArr:Array = [[1261,2231],[0.21,0.3],[0.21,0.3],[0.51,0.8],[0.01,0.03],[0.01,0.03],[0.01,0.03],[0.01,0.03]];
         return this.getArr(nameArr,proArr);
      }
      
      private function zu_purple_chip() : Array
      {
         var nameArr:Array = ["life_max","defence_max","life_rate","lifeBall","allAdd","lifeAdd","defenceAdd","attackAdd"];
         var proArr:Array = [[0.21,0.3],[263,385],[632,1351],[0.17,0.24],[0.01,0.03],[0.01,0.03],[0.01,0.03],[0.01,0.03]];
         return this.getArr(nameArr,proArr);
      }
      
      private function zhen_purple_chip() : Array
      {
         var nameArr:Array = ["dps","dps_pro","crit_pro","crit_mul","allAdd","subAdd","attackAdd","lifeAdd"];
         var proArr:Array = [[2287,3436],[0.31,0.4],[0.31,0.4],[0.81,1.2],[0.04,0.06],[0.04,0.06],[0.04,0.06],[0.04,0.06]];
         return this.getArr(nameArr,proArr);
      }
      
      private function lie_purple_chip() : Array
      {
         var nameArr:Array = ["life_max","defence_max","life_rate","lifeBall","allAdd","lifeAdd","defenceAdd","attackAdd"];
         var proArr:Array = [[0.31,0.4],[392,514],[1397,2401],[0.25,0.32],[0.04,0.06],[0.04,0.06],[0.04,0.06],[0.04,0.06]];
         return this.getArr(nameArr,proArr);
      }
      
      private function nu_purple_chip() : Array
      {
         var nameArr:Array = ["dps","dps_pro","crit_pro","crit_mul","allAdd","subAdd","attackAdd","lifeAdd"];
         var proArr:Array = [[3500,4800],[0.41,0.5],[0.41,0.5],[1.21,1.6],[0.07,0.1],[0.07,0.1],[0.07,0.1],[0.07,0.1]];
         return this.getArr(nameArr,proArr);
      }
      
      private function kuang_purple_chip() : Array
      {
         var nameArr:Array = ["life_max","defence_max","life_rate","lifeBall","allAdd","lifeAdd","defenceAdd","attackAdd"];
         var proArr:Array = [[0.41,0.5],[520,642],[2462,3751],[0.33,0.4],[0.07,0.1],[0.07,0.1],[0.07,0.1],[0.07,0.1]];
         return this.getArr(nameArr,proArr);
      }
      
      private function hong_purple_chip() : Array
      {
         var nameArr:Array = ["dps","dps_pro","crit_pro","crit_mul","allAdd","subAdd","attackAdd","lifeAdd"];
         var proArr:Array = [[4873,6310],[0.51,0.6],[0.51,0.6],[1.61,2],[0.11,0.14],[0.11,0.14],[0.11,0.14],[0.11,0.14]];
         return this.getArr(nameArr,proArr);
      }
      
      private function ji_purple_chip() : Array
      {
         var nameArr:Array = ["life_max","defence_max","life_rate","lifeBall","allAdd","lifeAdd","defenceAdd","attackAdd"];
         var proArr:Array = [[0.51,0.6],[649,771],[3827,5401],[0.41,0.48],[0.11,0.14],[0.11,0.14],[0.11,0.14],[0.11,0.14]];
         return this.getArr(nameArr,proArr);
      }
      
      private function jinian_chip() : Array
      {
         var nameArr:Array = ["dps","dps_pro","crit_pro","crit_mul","allAdd","subAdd","attackAdd"];
         var proArr:Array = [[3000],[0.5],[0.5],[2],[0.2],[0.2],[0.2]];
         return this.getArr(nameArr,proArr);
      }
      
      private function getArr(nameArr:Array, proArr:Array) : Array
      {
         var n:* = undefined;
         var pro0:Array = null;
         var value0:Number = NaN;
         var arr0:Array = [];
         for(n in nameArr)
         {
            pro0 = proArr[n];
            value0 = 0;
            if(pro0.length >= 2)
            {
               value0 = this.getRa(pro0);
            }
            else
            {
               value0 = Number(pro0[0]);
            }
            arr0.push(nameArr[n] + ":" + value0);
         }
         return arr0;
      }
      
      public function getRa(arr0:Array) : Number
      {
         return arr0[0] + Math.random() * (arr0[1] - arr0[0]);
      }
   }
}

