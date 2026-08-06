package gameAll.define
{
   import gameAll.data.AdditionalData;
   
   public class AdditionalDefine
   {

      private var forceMaxValue:Boolean = false;
      
      public var lvl:Array = [1,26,41,51,55];
      
      public function AdditionalDefine()
      {
         super();
      }
      
      public function getAdditionalData(num0:int, level0:int, labelArr:Array = null, rangeArr:Array = null) : AdditionalData
      {
         var n:* = undefined;
         var type0:String = null;
         var v0:Number = NaN;
         var add0:AdditionalData = new AdditionalData();
         var arr0:Array = labelArr;
         if(labelArr == null)
         {
            arr0 = this.getLabelArr(num0,level0,rangeArr);
         }
         for(n in arr0)
         {
            type0 = arr0[n];
            v0 = this.getValue(this.getRandomLevel(level0),type0);
            add0[type0] = v0;
         }
         add0.affixLevel = level0;
         return add0;
      }
      
      public function getRandomLevel(level0:int) : int
      {
         var minLv:int = 0;
         minLv = level0 - 4;
         if(minLv < 1)
         {
            minLv = 1;
         }
         return int(this.getRa(minLv,level0)) + 1;
      }
      
      public function getLabelArr(num0:int, level0:int, rangeArr:Array = null) : Array
      {
         var m:* = undefined;
         var arr3:Array = null;
         var n:int = 0;
         var ran0:int = 0;
         var arr1:Array = rangeArr;
         if(arr1 == null)
         {
            arr1 = AdditionalData.allName;
         }
         var arr2:Array = [];
         for(m in arr1)
         {
            if(level0 < 49)
            {
               if(arr1[m].indexOf("Add") == -1)
               {
                  arr2.push(arr1[m]);
               }
            }
            else
            {
               arr2.push(arr1[m]);
            }
         }
         arr3 = [];
         for(n = 0; n < num0; n++)
         {
            ran0 = arr2.length * Math.random();
            arr3.push(arr2[ran0]);
            arr2.splice(ran0,1);
         }
         return arr3;
      }
      
      public function getValue(lvl0:int, type0:String) : Number
      {
         return int(this[type0](lvl0) * 1000) / 1000;
      }

      public function getMaxValue(lvl0:int, type0:String) : Number
      {
         var value0:Number = NaN;
         this.forceMaxValue = true;
         try
         {
            value0 = this.getValue(lvl0,type0);
         }
         finally
         {
            this.forceMaxValue = false;
         }
         return value0;
      }
      
      public function getRa(v0:Number, v1:Number) : Number
      {
         if(this.forceMaxValue)
         {
            // Random ranges are open at the upper end.  Use the greatest
            // representable value below the endpoint so setPer()/int()
            // produce the actual maximum a roll can reach.  Preserve
            // fixed ranges such as 0.04..0.04 exactly.
            return v1 == v0 ? v1 : v1 - 0.000001;
         }
         return v0 + Math.random() * (v1 - v0);
      }
      
      public function setPer(num0:Number) : Number
      {
         if(num0 >= 100)
         {
            return int(num0);
         }
         if(num0 >= 1)
         {
            return int(num0 * 10) / 10;
         }
         // Percentage affixes are stored with three decimal places in the
         // original data (for example 0.111 -> 11.1%).  Keeping only two
         // decimals here makes legitimate one-decimal UI values impossible.
         return int(num0 * 1000) / 1000;
      }
      
      public function getValueByArr2(lv0:int, lvArr:Array, valueArr:Array) : Number
      {
         var n:* = undefined;
         var minValue:Number = NaN;
         var maxValue:Number = NaN;
         var index0:int = 0;
         for(n in lvArr)
         {
            if(lv0 < lvArr[n] || n == lvArr.length - 1)
            {
               index0 = n;
               break;
            }
         }
         minValue = Number(valueArr[index0][0]);
         maxValue = Number(valueArr[index0][1]);
         return this.getRa(minValue,maxValue);
      }
      
      public function dps(lvl0:int) : Number
      {
         lvl0++;
         var lvArr:Array = [11,21,31,41,51,61,71,81,91,101,111,121,131,141,99999];
         var valueArr:Array = [[25,152],[176,430],[462,789],[829,1215],[1261,1698],[1749,2231],[2287,2812],[2872,3436],[3500,4099],[4167,4800],[4873,5538],[5614,6310],[6500,8000],[8500,10000],[8000,12000]];
         return int(this.getValueByArr2(lvl0,lvArr,valueArr));
      }
      
      public function dps_pro(lvl0:int) : Number
      {
         lvl0++;
         var lvArr:Array = [11,21,31,41,51,61,71,81,91,101,111,121,131,141,99999];
         var valueArr:Array = [[0.01,0.05],[0.06,0.1],[0.11,0.15],[0.16,0.2],[0.21,0.25],[0.26,0.3],[0.31,0.35],[0.36,0.4],[0.41,0.45],[0.46,0.5],[0.51,0.55],[0.56,0.6],[0.61,0.65],[0.66,0.7],[0.66,0.75]];
         var num0:* = this.getValueByArr2(lvl0,lvArr,valueArr);
         return this.setPer(num0);
      }
      
      public function crit_pro(lvl0:int) : Number
      {
         lvl0++;
         var lvArr:Array = [11,21,31,41,51,61,71,81,91,101,111,121,131,141,99999];
         var valueArr:Array = [[0.01,0.05],[0.06,0.1],[0.11,0.15],[0.16,0.2],[0.21,0.25],[0.26,0.3],[0.31,0.35],[0.36,0.4],[0.41,0.45],[0.46,0.5],[0.51,0.55],[0.56,0.6],[0.61,0.65],[0.66,0.7],[0.66,0.75]];
         var num0:* = this.getValueByArr2(lvl0,lvArr,valueArr);
         return int(num0 * 100) / 100;
      }
      
      public function crit_mul(lvl0:int) : Number
      {
         lvl0++;
         var lvArr:Array = [11,21,31,41,51,61,71,81,91,101,111,121,131,141,99999];
         var valueArr:Array = [[0.11,0.2],[0.21,0.3],[0.31,0.4],[0.41,0.5],[0.51,0.6],[0.61,0.8],[0.81,1],[1.01,1.2],[1.21,1.4],[1.41,1.6],[1.61,1.8],[1.81,2],[2.01,2.2],[2.21,2.4],[2.3,2.6]];
         var num0:* = this.getValueByArr2(lvl0,lvArr,valueArr);
         return int(num0 * 100) / 100;
      }
      
      public function attack_speed(lvl0:int) : Number
      {
         lvl0++;
         var lvArr:Array = [11,21,31,41,51,61,71,81,91,101,111,121,131,141,99999];
         var valueArr:Array = [[0.04,0.04],[0.06,0.06],[0.06,0.09],[0.09,0.12],[0.12,0.15],[0.15,0.18],[0.18,0.21]];
         var num0:* = this.getValueByArr2(lvl0,lvArr,valueArr);
         return this.setPer(num0);
      }
      
      public function life_max(lvl0:int) : Number
      {
         lvl0++;
         var lvArr:Array = [11,21,31,41,51,61,71,81,91,101,111,121,131,141,99999];
         var valueArr:Array = [[0.01,0.05],[0.06,0.1],[0.11,0.15],[0.16,0.2],[0.21,0.25],[0.26,0.3],[0.31,0.35],[0.36,0.4],[0.41,0.45],[0.46,0.5],[0.51,0.55],[0.56,0.6],[0.61,0.65],[0.66,0.7],[0.66,0.75]];
         var num0:* = this.getValueByArr2(lvl0,lvArr,valueArr);
         return this.setPer(num0);
      }
      
      public function life_rate(lvl0:int) : Number
      {
         lvl0++;
         var lvArr:Array = [11,21,31,41,51,61,71,81,91,101,111,121,131,141,99999];
         var valueArr:Array = [[10,39],[47,151],[167,339],[362,601],[632,939],[977,1351],[1397,1839],[1892,2401],[2462,3039],[3107,3751],[3827,4539],[4624,5401],[5500,6500],[6500,7500],[10000,20000]];
         return int(this.getValueByArr2(lvl0,lvArr,valueArr));
      }
      
      public function life_steal(lvl0:int) : Number
      {
         lvl0++;
         var lvArr:Array = [11,21,31,41,51,61,71,81,91,101,111,121,131,141,99999];
         var valueArr:Array = [[20,65],[78,253],[278,565],[603,1003],[1053,1565],[1628,2253],[2328,3062],[3153,4003],[4103,5065],[5178,6253],[6378,7565],[7703,9003],[10000,12000],[12000,14000],[15000,20000]];
         return int(this.getValueByArr2(lvl0,lvArr,valueArr));
      }
      
      public function energy_max(lvl0:int) : Number
      {
         var num0:Number = 0;
         if(lvl0 <= 11)
         {
            num0 = this.getRa(0.06,0.1);
         }
         else if(lvl0 <= 21)
         {
            num0 = this.getRa(0.11,0.15);
         }
         else if(lvl0 <= 31)
         {
            num0 = this.getRa(0.16,0.2);
         }
         else if(lvl0 <= 41)
         {
            num0 = this.getRa(0.21,0.25);
         }
         else if(lvl0 <= 51)
         {
            num0 = this.getRa(0.26,0.3);
         }
         else if(lvl0 <= 61)
         {
            num0 = this.getRa(0.31,0.35);
         }
         else if(lvl0 <= 71)
         {
            num0 = this.getRa(0.36,0.4);
         }
         else if(lvl0 <= 81)
         {
            num0 = this.getRa(0.41,0.45);
         }
         else if(lvl0 <= 91)
         {
            num0 = this.getRa(0.46,0.5);
         }
         else if(lvl0 <= 101)
         {
            num0 = this.getRa(0.51,0.55);
         }
         else if(lvl0 <= 111)
         {
            num0 = this.getRa(0.56,0.6);
         }
         else if(lvl0 <= 121)
         {
            num0 = this.getRa(0.61,0.65);
         }
         else if(lvl0 <= 131)
         {
            num0 = this.getRa(0.66,0.7);
         }
         else if(lvl0 <= 141)
         {
            num0 = this.getRa(0.71,0.75);
         }
         else
         {
            num0 = this.getRa(0.71,0.8);
         }
         return this.setPer(num0);
      }
      
      public function energy_rate(lvl0:int) : Number
      {
         var num0:Number = 0;
         if(lvl0 <= 11)
         {
            num0 = this.getRa(0.06,0.1);
         }
         else if(lvl0 <= 21)
         {
            num0 = this.getRa(0.11,0.15);
         }
         else if(lvl0 <= 31)
         {
            num0 = this.getRa(0.16,0.2);
         }
         else if(lvl0 <= 41)
         {
            num0 = this.getRa(0.21,0.25);
         }
         else if(lvl0 <= 51)
         {
            num0 = this.getRa(0.26,0.3);
         }
         else if(lvl0 <= 61)
         {
            num0 = this.getRa(0.31,0.35);
         }
         else if(lvl0 <= 71)
         {
            num0 = this.getRa(0.36,0.4);
         }
         else if(lvl0 <= 81)
         {
            num0 = this.getRa(0.41,0.45);
         }
         else if(lvl0 <= 91)
         {
            num0 = this.getRa(0.46,0.5);
         }
         else if(lvl0 <= 101)
         {
            num0 = this.getRa(0.51,0.55);
         }
         else if(lvl0 <= 111)
         {
            num0 = this.getRa(0.56,0.6);
         }
         else if(lvl0 <= 121)
         {
            num0 = this.getRa(0.61,0.65);
         }
         else if(lvl0 <= 131)
         {
            num0 = this.getRa(0.66,0.7);
         }
         else if(lvl0 <= 141)
         {
            num0 = this.getRa(0.71,0.75);
         }
         else
         {
            num0 = this.getRa(0.71,0.8);
         }
         return this.setPer(num0);
      }
      
      public function coin(lvl0:int) : Number
      {
         lvl0++;
         var lvArr:Array = [11,31,51,71,91,111,131,141,99999];
         var valueArr:Array = [[0.01,0.1],[0.11,0.2],[0.21,0.3],[0.31,0.4],[0.41,0.5],[0.51,0.6],[0.61,0.7],[0.71,0.8],[0.71,0.9]];
         var num0:* = this.getValueByArr2(lvl0,lvArr,valueArr);
         return this.setPer(num0);
      }
      
      public function exp(lvl0:int) : int
      {
         lvl0++;
         var lvArr:Array = [11,31,51,71,91,111,131,141,99999];
         var valueArr:Array = [[1,20],[21,40],[41,60],[61,80],[81,100],[101,120],[121,140],[141,160],[161,180]];
         return int(this.getValueByArr2(lvl0,lvArr,valueArr));
      }
      
      public function achieve(lvl0:int) : Number
      {
         lvl0++;
         var lvArr:Array = [11,31,51,71,91,111,131,141,99999];
         var valueArr:Array = [[0.01,0.1],[0.11,0.2],[0.21,0.3],[0.31,0.4],[0.41,0.5],[0.51,0.6],[0.61,0.7],[0.71,0.8],[0.71,0.9]];
         var num0:* = this.getValueByArr2(lvl0,lvArr,valueArr);
         return this.setPer(num0);
      }
      
      public function defence_max(lvl0:int) : Number
      {
         lvl0++;
         var lvArr:Array = [11,21,31,41,51,61,71,81,91,101,111,121,131,141,99999];
         var valueArr:Array = [[20,64],[70,128],[135,192],[199,257],[263,321],[327,385],[392,450],[456,514],[520,578],[585,642],[649,707],[713,771],[800,900],[901,1000],[1000,1200]];
         var num0:* = this.getValueByArr2(lvl0,lvArr,valueArr);
         return int(num0);
      }
      
      public function lifeBall(lvl0:int) : Number
      {
         lvl0++;
         var lvArr:Array = [11,31,51,71,91,111,131,141,99999];
         var valueArr:Array = [[0.01,0.08],[0.09,0.16],[0.17,0.24],[0.25,0.32],[0.33,0.4],[0.41,0.48],[0.49,0.56],[0.57,0.64],[0.6,0.7]];
         var num0:* = this.getValueByArr2(lvl0,lvArr,valueArr);
         return this.setPer(num0);
      }
      
      public function allAdd(lvl0:int) : Number
      {
         lvl0++;
         if(lvl0 <= 71)
         {
            return this.getRa(0.01,0.03);
         }
         if(lvl0 <= 81)
         {
            return this.getRa(0.04,0.06);
         }
         if(lvl0 <= 91)
         {
            return this.getRa(0.07,0.08);
         }
         if(lvl0 <= 101)
         {
            return this.getRa(0.09,0.1);
         }
         if(lvl0 <= 111)
         {
            return this.getRa(0.11,0.12);
         }
         if(lvl0 <= 131)
         {
            return this.getRa(0.13,0.14);
         }
         if(lvl0 <= 141)
         {
            return this.getRa(0.15,0.16);
         }
         return this.getRa(0.15,0.18);
      }
      
      public function lifeAdd(lvl0:int) : Number
      {
         return this.allAdd(lvl0);
      }
      
      public function attackAdd(lvl0:int) : Number
      {
         return this.allAdd(lvl0);
      }
      
      public function subAdd(lvl0:int) : Number
      {
         return this.allAdd(lvl0);
      }
      
      public function defenceAdd(lvl0:int) : Number
      {
         return this.allAdd(lvl0);
      }
   }
}

