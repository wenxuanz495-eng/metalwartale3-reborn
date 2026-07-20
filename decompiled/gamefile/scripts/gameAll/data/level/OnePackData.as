package gameAll.data.level
{
   import data.TextWay;
   
   public class OnePackData
   {
      
      private var _lockNum:String = "";
      
      public var levelsMax:int = 60;
      
      public function OnePackData()
      {
         super();
         this.lockNum = 0;
      }
      
      public function inData_byObj(obj:*) : *
      {
         var n:* = undefined;
         var pro0:String = null;
         var pro_arr:Array = ["lockNum"];
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            this[pro0] = obj[pro0];
         }
      }
      
      public function get lockNum() : int
      {
         return Number(TextWay.getText(this._lockNum));
      }
      
      public function set lockNum(v0:int) : *
      {
         this._lockNum = TextWay.toCode(String(v0));
      }
   }
}

