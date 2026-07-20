package gameAll.define.property
{
   public class NormalPropertyDefine
   {
      
      public var name:String = "";
      
      public var cnName:String = "";
      
      public var unit:String = "";
      
      public var decimal:int = 0;
      
      public var levelArr:Array = [];
      
      public function NormalPropertyDefine()
      {
         super();
      }
      
      public function inData_byXML(xml0:XML) : *
      {
         var n:* = undefined;
         var xml2:XML = null;
         var d0:NormalPropertyLevelDefine = null;
         this.name = String(xml0.child("name"));
         this.cnName = String(xml0.cnName);
         this.unit = String(xml0.unit);
         this.decimal = int(xml0.decimal);
         var level_xml0:XMLList = xml0.level;
         for(n in level_xml0)
         {
            xml2 = level_xml0[n];
            d0 = new NormalPropertyLevelDefine();
            d0.inData_byXML(xml2);
            this.levelArr.push(d0);
         }
      }
      
      public function getValueText(value0:Number) : String
      {
         if(this.unit == "%")
         {
            return Number(Number(value0 * 100).toFixed(2)) + "%";
         }
         return value0 + this.unit;
      }
      
      public function getRandomValue(lv0:int, maxB:Boolean = false) : Number
      {
         var n:* = undefined;
         var d0:NormalPropertyLevelDefine = null;
         var value0:Number = NaN;
         var _loc6_:int = 0;
         var _loc7_:* = this.levelArr;
         do
         {
            for(n in _loc7_)
            {
               d0 = this.levelArr[n];
               if(lv0 >= d0.minLevel && lv0 <= d0.maxLevel)
               {
                  break;
               }
               if(n == 0 && lv0 < d0.minLevel)
               {
                  break;
               }
            }
            return 0;
         }
         while(!(n == this.levelArr.length - 1 && lv0 > d0.maxLevel));
         value0 = d0.minValue + (d0.maxValue - d0.minValue) * Math.random();
         if(maxB)
         {
            value0 = d0.maxValue;
         }
         return Number(value0.toFixed(this.decimal));
      }
   }
}

