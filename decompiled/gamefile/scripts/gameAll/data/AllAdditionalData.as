package gameAll.data
{
   public class AllAdditionalData extends AdditionalData
   {
      
      private var _life_value:Number = 0;
      
      private var _defence_mul:Number = 0;
      
      public function AllAdditionalData()
      {
         super();
      }
      
      public function addCarData(obj:*) : *
      {
         var n:* = undefined;
         var name0:String = null;
         var pro_arr0:Array = Game.newDG.car.pro_arr;
         for(n in pro_arr0)
         {
            name0 = pro_arr0[n];
            if(Boolean(obj.hasOwnProperty(name0)))
            {
               this[name0] += obj[name0];
            }
         }
      }
      
      public function set life_value(v0:Number) : *
      {
         this._life_value = v0 * V64;
      }
      
      public function get life_value() : Number
      {
         return this._life_value / V64;
      }
      
      public function set defence_mul(v0:Number) : *
      {
         this._defence_mul = v0 * V64;
      }
      
      public function get defence_mul() : Number
      {
         return this._defence_mul / V64;
      }
   }
}

