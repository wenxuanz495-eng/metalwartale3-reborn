package gameAll.data.weekExtra
{
   import data.TextWay;
   import gameAll.define.WeekExtraOneDefine;
   
   public class WeekExtraOneData
   {
      
      public var id:String = "";
      
      private var _nowLife:String = "";
      
      public var winB:Boolean = false;

      public var readyAt:Number = 0;
      
      public var define:WeekExtraOneDefine = null;
      
      public function WeekExtraOneData()
      {
         super();
         this.nowLife = 0;
      }
      
      public function inData_byObj(obj:Object) : *
      {
         var n:* = undefined;
         var pro0:String = null;
         var pro_arr:Array = ["id","nowLife","winB"];
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            this[pro0] = obj[pro0];
         }
         this.readyAt = obj.hasOwnProperty("readyAt") ? Number(obj.readyAt) : 0;
      }
      
      public function fleshDefine() : *
      {
         this.define = Game.gameDefine.weekExtra.getDefine(this.id);
         // Legacy saves only persisted winB. After readyAt was introduced,
         // winB=true plus readyAt=0 became a permanent "cooldown 0 seconds".
         if(this.winB && this.readyAt <= 0)
         {
            this.winB = false;
            this.nowLife = this.define.maxLife;
         }
         else if(!this.winB && this.readyAt > 0)
         {
            this.readyAt = 0;
         }
         if(this.nowLife > this.define.maxLife)
         {
            this.nowLife = this.define.maxLife;
         }
      }
      
      public function set nowLife(value0:Number) : *
      {
         this._nowLife = TextWay.toCode(String(value0));
      }
      
      public function get nowLife() : Number
      {
         return Number(TextWay.getText(this._nowLife));
      }
   }
}

