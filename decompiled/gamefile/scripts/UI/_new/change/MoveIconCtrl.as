package UI._new.change
{
   import UI._new.icon.ChangeIconBox;
   import UI._new.icon.NormalAllIcon;
   
   public class MoveIconCtrl
   {
      
      public function MoveIconCtrl()
      {
         super();
      }
      
      public static function move(ic0:NormalAllIcon, fa0:ChangeIconBox, ic2:NormalAllIcon, fa2:ChangeIconBox) : *
      {
         var type0:String = null;
         var type2:String = null;
         var funName0:String = null;
         var dg:* = fa0.dataGroup;
         if(dg == fa2.dataGroup)
         {
            type0 = fa0.dataType;
            type2 = fa2.dataType;
            funName0 = type0 + "_to_" + type2;
            trace("命令：" + funName0);
            dg[funName0](ic0.index,ic2.index);
         }
      }
   }
}

