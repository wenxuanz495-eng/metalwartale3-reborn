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
         this.type_arr.push("GCoin,\t\t50000,\t\t\t\t1");
         this.type_arr.push("materials,\tsuperalloy,\t\t10");
         this.type_arr.push("materials,\tsuperalloy_Z,\t\t10");
         this.type_arr.push("materials,\tsuperalloy_X,\t\t10");
         this.type_arr.push("materials,\torange_chip,\t\t1");
         this.type_arr.push("crystal_4,\t1,\t\t\t\t\t1");
         this.type_arr.push("arms,\t\tarc,\t\t\t\t1");
         this.type_arr.push("sub,\t\t\tcutter_gold_lv1,\t1");
         this.type_arr.push("props,\t\tdisassemble_2,\t1");
         this.pro_arr = [0.49,0.1,0.1,0.1,0.1,0.05,0.005,0.005,0.05];
      }
      
      public function getGift(than8:Boolean = false) : String
      {
         var str0:String = "";
         var index0:int = StringToDefine.getPro_byArr(this.pro_arr);
         return this.type_arr[index0];
      }
   }
}

