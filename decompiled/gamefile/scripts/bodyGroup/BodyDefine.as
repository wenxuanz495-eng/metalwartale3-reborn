package bodyGroup
{
   public class BodyDefine
   {
      
      public static const bodyDefine_arr:Array = ["stand","climb_up","move","jump_down__","__jump_up","jump_up__jump_down","jump_up","jump_down","die","hurt","__fell_up","fell_up","fell_up__fell_down","fell_down","fell_down__","attack1","attack2","attack3","attack_combo"];
      
      public static const effectDefine_arr:Array = ["yh_attack1","yh_attack2","yh_attack3","xxw_attack1","xxw_attack2","xxw_attack3"];
      
      public static const erlangDefine_arr:Array = ["attack_cut","attack_lightning","attack_laser"];
      
      public function BodyDefine()
      {
         super();
      }
      
      public static function getToLabel(l0:String, l1:String) : String
      {
         var tl:String = "";
         tl = l0 + "__" + l1;
         if(l1 == "jump_up")
         {
            tl = "__jump_up";
         }
         else if(l1 == "fell_up")
         {
            tl = "__fell_up";
         }
         else if(l1 == "fly")
         {
            tl = "__fly";
         }
         else if(l1 == "defence")
         {
            tl = "__defence";
         }
         else if(l1 == "plane")
         {
            tl = "__plane";
         }
         if(l0 == "fell_down")
         {
            tl = "fell_down__";
         }
         else if(l0 == "jump_down")
         {
            tl = "jump_down__";
         }
         else if(l0 == "fly")
         {
            tl = "fly__";
         }
         else if(l0 == "defence")
         {
            tl = "defence__";
         }
         else if(l0 == "plane")
         {
            tl = "plane__";
         }
         return tl;
      }
   }
}

