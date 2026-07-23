package gameAll.define.drop
{
   import data.StringToDefine;
   import data.TextWay;
   
   public class oneDropDefine
   {
      
      public static var enemyType:Array = ["soldier","super","champion","boss"];
      
      public var type:Array = [];
      
      public var soldierArr:Array = [];
      
      public var superArr:Array = [];
      
      public var championArr:Array = [];
      
      public var bossArr:Array = [];
      
      public function oneDropDefine()
      {
         super();
      }
      
      public function inData_byXML(xml0:XML) : *
      {
         var n:* = undefined;
         var name0:String = null;
         this.type = String(xml0.type).split(",");
         for(n in enemyType)
         {
            name0 = enemyType[n];
            this[name0 + "Arr"] = TextWay.xmlToNumberArr(String(xml0[name0]));
         }
      }
      
      public function getRandom(bType0:String) : String
      {
         var arr0:Array = this[bType0 + "Arr"];
         return this.type[StringToDefine.getPro_byArr(arr0)];
      }

      public function getTypeProbability(bType0:String, type0:String) : Number
      {
         var arr0:Array = this[bType0 + "Arr"];
         var result0:Number = 0;
         for(var i:int = 0; i < this.type.length && i < arr0.length; i++)
         {
            if(this.type[i] == type0)
            {
               result0 += Number(arr0[i]);
            }
         }
         return result0;
      }
   }
}

