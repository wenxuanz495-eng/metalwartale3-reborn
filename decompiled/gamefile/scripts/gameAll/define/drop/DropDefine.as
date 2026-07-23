package gameAll.define.drop
{
   public class DropDefine
   {
      
      public var items:Array = [];
      
      public var car:Array = [];
      
      public var material_level:Array = [0,1,18,36,51,61,81];
      
      public var crystal_level:Array = [0,1];
      
      public function DropDefine()
      {
         super();
      }
      
      public function test() : *
      {
         trace("-----------------------------------------");
         for(var i:int = 0; i < 100; i++)
         {
            trace(i + ":" + this.getCarItemsType("super",0));
         }
      }
      
      public function inData_byXML(xml0:XML) : *
      {
         this.inDiffData_byXML(xml0.items[0],this.items);
         this.inCarDiffData_byXML(xml0.car[0],this.car);
      }
      
      private function inDiffData_byXML(xml0:XML, arr0:Array) : *
      {
         var n:* = undefined;
         var diff_xml0:XML = null;
         var d0:DropDiffDefine = null;
         var xml_list0:XMLList = xml0.diff;
         for(n in xml_list0)
         {
            diff_xml0 = xml_list0[n];
            d0 = new DropDiffDefine();
            d0.inData_byXML(diff_xml0);
            arr0.push(d0);
         }
      }
      
      private function inCarDiffData_byXML(xml0:XML, arr0:Array) : *
      {
         var n:* = undefined;
         var diff_xml0:XML = null;
         var d0:DropCarDiffDefine = null;
         var xml_list0:XMLList = xml0.diff;
         for(n in xml_list0)
         {
            diff_xml0 = xml_list0[n];
            d0 = new DropCarDiffDefine();
            d0.inData_byXML(diff_xml0);
            arr0.push(d0);
         }
      }
      
      public function getTaskCrystalLevel(level0:int) : int
      {
         var n:* = undefined;
         level0++;
         for(n in this.crystal_level)
         {
            if(level0 < this.crystal_level[n])
            {
               return n - 1;
            }
         }
         return 1;
      }
      
      public function getDropSuperalloy_Z(b_lv:int, e_lv:int) : Number
      {
         var cx:int = Math.abs(b_lv - e_lv);
         var num0:Number = 0.5 - cx * 0.1;
         if(cx >= 5)
         {
            num0 = 0;
         }
         return 0.5;
      }
      
      public function getItemsLevel(b_lv:int, b_type:String = "") : int
      {
         var minLv:int = b_lv - 4;
         if(minLv < 0)
         {
            minLv = 0;
         }
         var num0:int = minLv + (b_lv - minLv + 1) * Math.random();
         if(num0 <= 0)
         {
            num0 = 0;
         }
         return num0;
      }
      
      public function getMinLevel(type0:String, maxLevel0:int) : int
      {
         var arr0:Array = null;
         var n:* = undefined;
         var num1:int = 0;
         maxLevel0++;
         var minLevel0:int = 0;
         if(type0 == "material" || type0 == "crystal")
         {
            arr0 = this[type0 + "_level"];
            for(n in arr0)
            {
               num1 = int(arr0[n]);
               if(maxLevel0 < num1)
               {
                  minLevel0 = int(arr0[n - 1]);
                  break;
               }
               if(n == arr0.length - 1)
               {
                  minLevel0 = int(arr0[n]);
               }
            }
            return minLevel0 - 1;
         }
         return 0;
      }
      
      public function getItemsType(bType:String, diff0:int, num0:int = 1) : String
      {
         if(diff0 > this.items.length - 1)
         {
            diff0 = this.items.length - 1;
         }
         var d0:DropDiffDefine = this.items[diff0];
         return d0.items.getRandom(bType);
      }

      public function getItemsTypeProbability(bType:String, diff0:int, type0:String) : Number
      {
         if(diff0 > this.items.length - 1)
         {
            diff0 = this.items.length - 1;
         }
         var d0:DropDiffDefine = this.items[diff0];
         return d0.items.getTypeProbability(bType,type0);
      }
      
      public function getChipType(bType:String, diff0:int) : String
      {
         if(diff0 > this.items.length - 1)
         {
            diff0 = this.items.length - 1;
         }
         var d0:DropDiffDefine = this.items[diff0];
         return d0.chip.getRandom(bType);
      }
      
      public function getCarItemsType(bType:String, diff0:int) : String
      {
         if(diff0 > this.car.length - 1)
         {
            diff0 = this.car.length - 1;
         }
         var d0:DropCarDiffDefine = this.car[diff0];
         return d0.items.getRandom(bType);
      }
      
      public function getCarColorType(bType:String, diff0:int) : String
      {
         if(diff0 > this.car.length - 1)
         {
            diff0 = this.car.length - 1;
         }
         var d0:DropCarDiffDefine = this.car[diff0];
         return d0.car.getRandom(bType);
      }
   }
}

