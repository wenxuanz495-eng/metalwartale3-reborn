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
      
      public function getAdditionalData(param1:int, param2:int, param3:Array = null, param4:Array = null) : AdditionalData
      {
         var _loc7_:* = undefined;
         var _loc8_:String = null;
         var _loc9_:Number = NaN;
         var _loc5_:AdditionalData = new AdditionalData();
         var _loc6_:Array = param3;
         if(param3 == null)
         {
            _loc6_ = this.getLabelArr(param1,param2,param4);
         }
         for(_loc7_ in _loc6_)
         {
            _loc8_ = _loc6_[_loc7_];
            _loc9_ = this.getValue(this.getRandomLevel(param2),_loc8_);
            _loc5_[_loc8_] = _loc9_;
         }
         _loc5_.affixLevel = param2;
         return _loc5_;
      }
      
      public function getRandomLevel(param1:int) : int
      {
         var _loc2_:int = 0;
         _loc2_ = param1 - 4;
         if(_loc2_ < 1)
         {
            _loc2_ = 1;
         }
         return int(this.getRa(_loc2_,param1)) + 1;
      }
      
      public function getLabelArr(param1:int, param2:int, param3:Array = null) : Array
      {
         var _loc6_:* = undefined;
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc4_:Array = param3;
         if(_loc4_ == null)
         {
            _loc4_ = AdditionalData.allName;
         }
         var _loc5_:Array = [];
         for(_loc6_ in _loc4_)
         {
            if(param2 < 49)
            {
               if(_loc4_[_loc6_].indexOf("Add") == -1)
               {
                  _loc5_.push(_loc4_[_loc6_]);
               }
            }
            else
            {
               _loc5_.push(_loc4_[_loc6_]);
            }
         }
         _loc7_ = [];
         _loc8_ = 0;
         while(_loc8_ < param1)
         {
            _loc9_ = _loc5_.length * Math.random();
            _loc7_.push(_loc5_[_loc9_]);
            _loc5_.splice(_loc9_,1);
            _loc8_++;
         }
         return _loc7_;
      }
      
      public function getValue(param1:int, param2:String) : Number
      {
         return int(this[param2](param1) * 1000) / 1000;
      }

      public function getMaxValue(param1:int, param2:String) : Number
      {
         var value0:Number = NaN;
         this.forceMaxValue = true;
         try
         {
            value0 = this.getValue(param1,param2);
         }
         finally
         {
            this.forceMaxValue = false;
         }
         return value0;
      }
      
      public function getRa(param1:Number, param2:Number) : Number
      {
         if(this.forceMaxValue)
         {
            return param2 == param1 ? param2 : param2 - 0.000001;
         }
         return param1 + Math.random() * (param2 - param1);
      }
      
      public function setPer(param1:Number) : Number
      {
         if(param1 >= 100)
         {
            return int(param1);
         }
         if(param1 >= 1)
         {
            return int(param1 * 10) / 10;
         }
         return int(param1 * 1000) / 1000;
      }
      
      public function getValueByArr2(param1:int, param2:Array, param3:Array) : Number
      {
         var _loc5_:* = undefined;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc4_:int = 0;
         for(_loc5_ in param2)
         {
            if(param1 < param2[_loc5_] || _loc5_ == param2.length - 1)
            {
               _loc4_ = _loc5_;
               break;
            }
         }
         _loc6_ = Number(param3[_loc4_][0]);
         _loc7_ = Number(param3[_loc4_][1]);
         return this.getRa(_loc6_,_loc7_);
      }
      
      public function dps(param1:int) : Number
      {
         param1++;
         var _loc2_:Array = [11,21,31,41,51,55,56,61,71,74,80,99999];
         var _loc3_:Array = [[11,20],[21,40],[41,100],[101,150],[151,200],[201,400],[401,600],[601,800],[801,1000],[1000,1200],[1200,1500],[1501,2000]];
         return int(this.getValueByArr2(param1,_loc2_,_loc3_));
      }
      
      public function dps_pro(param1:int) : Number
      {
         param1++;
         var _loc2_:Array = [11,21,31,41,51,55,56,61,71,74,80,99999];
         var _loc3_:Array = [[0.01,0.03],[0.04,0.06],[0.07,0.1],[0.1,0.12],[0.12,0.14],[0.14,0.17],[0.17,0.2],[0.2,0.25],[0.26,0.3],[0.31,0.35],[0.36,0.4],[0.41,0.43]];
         var _loc4_:* = this.getValueByArr2(param1,_loc2_,_loc3_);
         return this.setPer(_loc4_);
      }
      
      public function crit_pro(param1:int) : Number
      {
         param1++;
         var _loc2_:Array = [26,41,51,55,56,61,71,74,80,99999];
         var _loc3_:Array = [[0.01,0.03],[0.04,0.06],[0.07,0.09],[0.1,0.15],[0.15,0.2],[0.2,0.25],[0.26,0.3],[0.31,0.35],[0.36,0.4],[0.41,0.43]];
         var _loc4_:* = this.getValueByArr2(param1,_loc2_,_loc3_);
         return int(_loc4_ * 100) / 100;
      }
      
      public function crit_mul(param1:int) : Number
      {
         param1++;
         var _loc2_:Array = [26,41,51,55,56,61,71,74,80,99999];
         var _loc3_:Array = [[0.1,0.15],[0.16,0.3],[0.35,0.5],[0.5,0.6],[0.6,0.8],[0.8,1],[1,1.2],[1.2,1.4],[1.4,1.6],[1.6,1.7]];
         var _loc4_:* = this.getValueByArr2(param1,_loc2_,_loc3_);
         return int(_loc4_ * 100) / 100;
      }
      
      public function attack_speed(param1:int) : Number
      {
         param1++;
         var _loc2_:Array = [26,41,51,55,56,99999];
         var _loc3_:Array = [[0.04,0.04],[0.06,0.06],[0.06,0.09],[0.09,0.12],[0.12,0.15],[0.15,0.18]];
         var _loc4_:* = this.getValueByArr2(param1,_loc2_,_loc3_);
         return this.setPer(_loc4_);
      }
      
      public function life_max(param1:int) : Number
      {
         param1++;
         var _loc2_:Array = [26,41,51,55,56,61,71,74,80,99999];
         var _loc3_:Array = [[0.01,0.05],[0.06,0.1],[0.11,0.15],[0.16,0.2],[0.21,0.25],[0.25,0.3],[0.31,0.35],[0.36,0.4],[0.41,0.45],[0.46,0.48]];
         var _loc4_:* = this.getValueByArr2(param1,_loc2_,_loc3_);
         return this.setPer(_loc4_);
      }
      
      public function life_rate(param1:int) : Number
      {
         param1++;
         var _loc2_:Array = [11,21,31,41,51,55,56,61,71,74,80,99999];
         var _loc3_:Array = [[5,10],[21,40],[41,60],[61,80],[81,100],[101,150],[151,200],[201,250],[251,300],[301,500],[501,800],[1000,1500]];
         return int(this.getValueByArr2(param1,_loc2_,_loc3_));
      }
      
      public function life_steal(param1:int) : Number
      {
         param1++;
         var _loc2_:Array = [11,21,31,41,51,55,56,61,71,74,80,99999];
         var _loc3_:Array = [[1,3],[8,20],[21,50],[51,100],[101,200],[201,300],[301,500],[501,800],[801,1000],[1001,1500],[1501,2000],[2500,4000]];
         return int(this.getValueByArr2(param1,_loc2_,_loc3_));
      }
      
      public function energy_max(param1:int) : Number
      {
         var _loc2_:Number = 0;
         if(param1 <= this.lvl[1])
         {
            _loc2_ = this.getRa(0.05,0.1);
         }
         else if(param1 <= this.lvl[2])
         {
            _loc2_ = this.getRa(0.1,0.15);
         }
         else if(param1 <= this.lvl[3])
         {
            _loc2_ = this.getRa(0.16,0.2);
         }
         else if(param1 <= this.lvl[4])
         {
            _loc2_ = this.getRa(0.2,0.25);
         }
         else if(param1 <= 56)
         {
            _loc2_ = this.getRa(0.25,0.3);
         }
         else if(param1 <= 61)
         {
            _loc2_ = this.getRa(0.3,0.4);
         }
         else if(param1 <= 71)
         {
            _loc2_ = this.getRa(0.41,0.45);
         }
         else if(param1 <= 74)
         {
            _loc2_ = this.getRa(0.46,0.5);
         }
         else if(param1 <= 81)
         {
            _loc2_ = this.getRa(0.51,0.55);
         }
         else
         {
            _loc2_ = this.getRa(0.56,0.6);
         }
         return this.setPer(_loc2_);
      }
      
      public function energy_rate(param1:int) : Number
      {
         var _loc2_:Number = 0;
         if(param1 <= this.lvl[1])
         {
            _loc2_ = this.getRa(0.05,0.1);
         }
         else if(param1 <= this.lvl[2])
         {
            _loc2_ = this.getRa(0.1,0.15);
         }
         else if(param1 <= this.lvl[3])
         {
            _loc2_ = this.getRa(0.16,0.2);
         }
         else if(param1 <= this.lvl[4])
         {
            _loc2_ = this.getRa(0.2,0.25);
         }
         else if(param1 <= 56)
         {
            _loc2_ = this.getRa(0.25,0.3);
         }
         else if(param1 <= 61)
         {
            _loc2_ = this.getRa(0.3,0.4);
         }
         else if(param1 <= 71)
         {
            _loc2_ = this.getRa(0.41,0.45);
         }
         else if(param1 <= 74)
         {
            _loc2_ = this.getRa(0.46,0.5);
         }
         else if(param1 <= 80)
         {
            _loc2_ = this.getRa(0.51,0.55);
         }
         else
         {
            _loc2_ = this.getRa(0.56,0.6);
         }
         return this.setPer(_loc2_);
      }
      
      public function coin(param1:int) : Number
      {
         param1++;
         var _loc2_:Array = [26,41,51,55,56,61,71,74,80,99999];
         var _loc3_:Array = [[0.05,0.05],[0.06,0.06],[0.07,0.1],[0.1,0.15],[0.16,0.2],[0.21,0.25],[0.26,0.3],[0.31,0.35],[0.36,0.4],[0.41,0.45]];
         var _loc4_:* = this.getValueByArr2(param1,_loc2_,_loc3_);
         return this.setPer(_loc4_);
      }
      
      public function exp(param1:int) : int
      {
         param1++;
         var _loc2_:Array = [11,21,31,41,50,61,71,99999];
         var _loc3_:Array = [[1,2],[3,4],[5,6],[7,10],[11,15],[31,50],[51,100],[101,150]];
         return int(this.getValueByArr2(param1,_loc2_,_loc3_));
      }
      
      public function achieve(param1:int) : Number
      {
         param1++;
         var _loc2_:Array = [26,41,51,55,56,61,71,74,80,99999];
         var _loc3_:Array = [[0.05,0.05],[0.06,0.06],[0.07,0.07],[0.08,0.08],[0.09,0.11],[0.12,0.14],[0.15,0.2],[0.21,0.25],[0.26,0.3],[0.31,0.35]];
         var _loc4_:* = this.getValueByArr2(param1,_loc2_,_loc3_);
         return this.setPer(_loc4_);
      }
      
      public function defence_max(param1:int) : Number
      {
         param1++;
         var _loc2_:Array = [21,31,41,51,55,56,61,71,74,80,99999];
         var _loc3_:Array = [[21,30],[31,41],[41,60],[61,80],[81,100],[101,150],[151,200],[201,250],[251,500],[501,1000],[1500,2000]];
         var _loc4_:* = this.getValueByArr2(param1,_loc2_,_loc3_);
         return int(_loc4_);
      }
      
      public function lifeBall(param1:int) : Number
      {
         param1++;
         var _loc2_:Array = [26,41,51,55,56,61,71,74,80,99999];
         var _loc3_:Array = [[0.01,0.05],[0.06,0.1],[0.11,0.15],[0.16,0.2],[0.2,0.25],[0.26,0.3],[0.31,0.35],[0.36,0.4],[0.41,0.45],[0.46,0.48]];
         var _loc4_:* = this.getValueByArr2(param1,_loc2_,_loc3_);
         return this.setPer(_loc4_);
      }
      
      public function allAdd(param1:int) : Number
      {
         if(++param1 <= 71)
         {
            return this.getRa(0.01,0.03);
         }
         if(param1 <= 80)
         {
            return this.getRa(0.04,0.06);
         }
         return this.getRa(0.07,0.08);
      }
      
      public function lifeAdd(param1:int) : Number
      {
         return this.allAdd(param1);
      }
      
      public function attackAdd(param1:int) : Number
      {
         return this.allAdd(param1);
      }
      
      public function subAdd(param1:int) : Number
      {
         return this.allAdd(param1);
      }
      
      public function defenceAdd(param1:int) : Number
      {
         return this.allAdd(param1);
      }
   }
}

