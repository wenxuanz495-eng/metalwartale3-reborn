package gameAll.define.other
{
   import data.StringToDefine;
   
   public class DropBoxDefine
   {
      
      public var type_arr:Array = [];
      
      public var pro_arr:Array = [];
      
      public function DropBoxDefine()
      {
         super();
         this.type_arr.push("GCoin,\t\t\t500000,\t\t\t\t1");
         this.type_arr.push("arms,\t\t\tarc_lv1,\t\t\t\t1");
         this.type_arr.push("props,\t\t\trebirth_crystal,\t1");
         this.type_arr.push("materials,\tsuperalloy,\t\t\t30");
         this.type_arr.push("materials,\tsuperalloy_Z,\t\t20");
         this.type_arr.push("materials,\tsuperalloy_X,\t\t20");
         this.type_arr.push("crystal_5,\t1,\t\t\t\t\t\t\t1");
         this.type_arr.push("crystal_6,\t1,\t\t\t\t\t\t\t1");
         this.type_arr.push("crystal_7,\t1,\t\t\t\t\t\t\t1");
         this.type_arr.push("materials,\tgreen_chip,\t\t\t1");
         this.type_arr.push("materials,\tpurple_chip,\t\t\t1");
         this.type_arr.push("props,\t\t\tjustice_badge,\t\t1");
         this.pro_arr = [0.5,0.01,0.05,0.1,0.05,0.05,0.05,0.02,0.01,0.1,0.05,0.01];
      }
      
      public function getGift(param1:Boolean = false) : String
      {
         var _loc2_:String = "";
         var _loc3_:int = StringToDefine.getPro_byArr(this.pro_arr);
         return this.type_arr[_loc3_];
      }
   }
}

