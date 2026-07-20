package gameAll.define
{
   import data.StringToDefine;
   
   public class FlipCardDefine
   {
      
      public var exp_arr:Array = [1000,1200,1400,1600,1800,2000,2200,2400,2600,4000,5000,7000,9000,11000,13000,16000,19000,22000,27000,32000,37000,42000,48000,55000,90000,100000,110000,130000,140000,160000,180000,200000,220000,240000,260000,280000,300000,320000,340000,400000,450000,500000,550000,600000,650000,700000,750000,800000,850000,900000,950000,1000000,1050000,1100000,1150000,1200000,1250000,1300000,1350000,1400000];
      
      public var coin_arr:Array = [1000,1500,2000,2500,3000,3500,4000,4500,5000,5500,6000,6500,7000,7500,8000,8500,9000,9500,10000,10500,11000,11500,12000,12500,13000,13500,14000,14500,15000,15500,16000,16500,17000,17500,18000,18500,19000,19500,20000,20500,21000,21500,22000,22500,23000,23500,24000,24500,25000,25500,26000,26500,27000,27500,28000,28500,29000,29500,30000,30500];
      
      public var superalloyName_arr:Array = ["superalloy","superalloy_Z","superalloy_X"];
      
      public var superalloyNum_arr:Array = [100,15,20];
      
      public var materialName_arr:Array = ["buncher","boom","thorn"];
      
      public var materialNum_arr:Array = [70,70,70];
      
      public var material_level:Array = [1,18,36,51,99999];
      
      public var armsArr:Array = ["sub,positron_lv1","arms,snow_lv1","sub,banger_lv1"];
      
      public var type_arr:Array = ["arms","exp","coin","superalloy","material"];
      
      public var pro_arr:Array = [0.001,0.45,0.45,0.0495,0.0495];
      
      public function FlipCardDefine()
      {
         super();
         this.exp_arr = this.exp_arr.concat([1000000,1000000,1000000,1000000,1000000,1000000,1000000,1000000,1000000,1000000,1000000,1000000]);
         this.coin_arr = this.coin_arr.concat([50000,50000,50000,50000,50000,50000,50000,50000,50000,50000,50000,50000]);
      }
      
      public function getFlipNum(param1:int) : int
      {
         return 1;
      }
      
      public function getDefine(param1:Array) : *
      {
      }
      
      public function test() : *
      {
         var _loc3_:String = null;
         var _loc1_:Array = [];
         var _loc2_:int = 0;
         while(_loc2_ < 5)
         {
            _loc3_ = this.getType_byArr(_loc1_);
            _loc1_.push(_loc3_);
            trace(_loc1_);
            trace("文本：" + this.getGoodsDefineStr_byType(_loc3_,30));
            _loc2_++;
         }
         trace("-----------------------------------");
      }
      
      public function getType_byArr(param1:Array) : String
      {
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:* = undefined;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc2_:String = "";
         if(param1.indexOf("") == -1)
         {
            _loc2_ = "";
         }
         else
         {
            _loc3_ = [];
            _loc4_ = [];
            for(_loc5_ in this.type_arr)
            {
               _loc7_ = this.type_arr[_loc5_];
               if(param1.indexOf(_loc7_) == -1)
               {
                  _loc3_.push(_loc7_);
                  _loc4_.push(this.getPro_byType(_loc7_));
               }
            }
            _loc6_ = StringToDefine.getPro_byArr2(_loc4_);
            _loc2_ = _loc3_[_loc6_];
         }
         return _loc2_;
      }
      
      public function getGoodsDefineStr_byType(param1:String, param2:int) : String
      {
         var _loc3_:String = "";
         var _loc4_:String = "";
         var _loc5_:Array = [0.75,1,1.25];
         var _loc6_:Number = Number(_loc5_[int(_loc5_.length * Math.random())]);
         if(param1 == "exp")
         {
            if(param2 > this.exp_arr.length - 1)
            {
               param2 = this.exp_arr.length - 1;
            }
            _loc3_ = "exp," + int(this.exp_arr[param2] * _loc6_) + ",1";
         }
         else if(param1 == "coin")
         {
            if(param2 > this.coin_arr.length - 1)
            {
               param2 = this.coin_arr.length - 1;
            }
            _loc3_ = "GCoin," + int(this.coin_arr[param2]) + ",1";
         }
         else if(param1 == "superalloy")
         {
            _loc4_ = this.superalloyName_arr[int(this.superalloyName_arr.length * Math.random())];
            _loc3_ = "materials," + _loc4_ + "," + this.getSuperalloyNum(param2,_loc4_);
         }
         else if(param1 == "material")
         {
            _loc4_ = this.materialName_arr[int(this.materialName_arr.length * Math.random())];
            _loc3_ = "materials," + _loc4_ + "_" + this.getMaterialLevel(param2) + "," + this.getMaterialNum(param2);
         }
         else if(param1 == "arms")
         {
            _loc3_ = this.armsArr[int(this.armsArr.length * Math.random())] + ",1";
         }
         return _loc3_;
      }
      
      public function getMaterialLevel(param1:int) : int
      {
         var _loc3_:* = undefined;
         var _loc2_:int = 1;
         for(_loc3_ in this.material_level)
         {
            if(param1 < this.material_level[_loc3_] - 1)
            {
               _loc2_ = _loc3_;
               break;
            }
         }
         return _loc2_;
      }
      
      public function getMaterialNum(param1:int) : int
      {
         var _loc2_:int = 1;
         if(++param1 < 18)
         {
            _loc2_ = 1 + Math.random() * 10;
         }
         else if(param1 < 36)
         {
            _loc2_ = 5 + Math.random() * 10;
         }
         else if(param1 < 51)
         {
            _loc2_ = 8 + Math.random() * 12;
         }
         else
         {
            _loc2_ = 10 + Math.random() * 30;
         }
         return _loc2_;
      }
      
      public function getSuperalloyNum(param1:int, param2:String) : int
      {
         var _loc3_:int = 1;
         if(param2 == "superalloy")
         {
            _loc3_ = this.getMaterialNum(param1);
         }
         else
         {
            _loc3_ = 1;
         }
         return _loc3_;
      }
      
      private function getPro_byType(param1:String) : Number
      {
         return this.pro_arr[this.type_arr.indexOf(param1)];
      }
   }
}

