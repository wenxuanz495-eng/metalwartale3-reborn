package gameAll.define.other
{
   import data.StringToDefine;
   
   public class DropBox3Define
   {
      
      public var type_arr:Array = [];
      
      public var pro_arr:Array = [];
      
      public function DropBox3Define()
      {
         super();
         this.type_arr.push("GCoin,\t\t200000,\t\t\t1");
         this.type_arr.push("materials,\tsuperalloy,\t\t10");
         this.type_arr.push("materials,\tsuperalloy_Z,\t\t10");
         this.type_arr.push("materials,\tsuperalloy_X,\t\t10");
         this.type_arr.push("materials,\torange_chip,\t\t1");
         this.type_arr.push("materials,\tgreen_chip,\t\t1");
         this.type_arr.push("crystal_4,\t1,\t\t\t\t\t1");
         this.type_arr.push("crystal_5,\t1,\t\t\t\t\t1");
         this.type_arr.push("crystal_6,\t1,\t\t\t\t\t1");
         this.type_arr.push("arms,\t\tarc,\t\t\t\t1");
         this.type_arr.push("sub,\t\t\tcutter_gold_lv1,\t1");
         this.type_arr.push("props,\t\tchipBag20,\t\t\t1");
         this.type_arr.push("props,\t\tchipBag40,\t\t\t1");
         this.type_arr.push("props,\t\tchipBag60,\t\t\t1");
         this.type_arr.push("props,\t\tchipBag80,\t\t\t1");
         this.type_arr.push("props,\t\tchipBag100,\t\t1");
         this.pro_arr = [0.27,0.1,0.1,0.1,0.05,0.05,0.05,0.05,0.05,0.015,0.015,0.05,0.04,0.03,0.02,0.01];
      }
      
      public function getGift(than8:Boolean = false) : String
      {
         var str0:String = "";
         var index0:int = StringToDefine.getPro_byArr(this.pro_arr);
         return this.type_arr[index0];
      }
   }
}

