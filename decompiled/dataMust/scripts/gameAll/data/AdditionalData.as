package gameAll.data
{
   import data.Base64;
   
   public class AdditionalData
   {
      
      public static var allName:Array = ["dps_pro","dps","crit_pro","crit_mul","coin","exp","achieve","energy_max","energy_rate","life_max","life_rate","life_steal","defence_max","lifeBall","allAdd","lifeAdd","attackAdd","subAdd","defenceAdd"];
      
      public static var maxArr:Array = [4.3,20000,4.3,17,4.5,1500,3.5,6,6,4.8,15000,40000,20000,4.8,0.8,0.8,0.8,0.8,0.8];
      
      public static var allCn:Array = ["DPS百分比提升","DPS提升","暴击几率提升","暴击伤害提升","金币获取提升","经验获取提升","功勋获取提升","能量上限提升","能量回复提升","耐久上限提升","耐久回复提升","击中回复耐久","防御上限提升","药箱回复提高","全能训练提升","体能训练提升","射击训练提升","控制训练提升","防御训练提升"];
      
      public static var allBaifen:Array = [100,1,100,100,100,1,100,100,100,100,1,1,1,100,100,100,100,100,100];
      
      public static var allUnits:Array = ["","","","","","点","","","","","点/秒","点","点","","","","","",""];
      
      public var affixLevel:int = 0;
      
      public var V64:Number = Number(Base64.decode("Mzc="));
      
      private var _dps:Number = 0;
      
      private var _dps_pro:Number = 0;
      
      private var _crit_pro:Number = 0;
      
      private var _crit_mul:Number = 0;
      
      private var _attack_speed:Number = 0;
      
      private var _life_max:Number = 0;
      
      private var _life_rate:Number = 0;
      
      private var _life_steal:Number = 0;
      
      private var _coin:Number = 0;
      
      private var _exp:Number = 0;
      
      private var _achieve:Number = 0;
      
      private var _energy_max:Number = 0;
      
      private var _energy_rate:Number = 0;
      
      private var _defence_max:Number = 0;
      
      private var _lifeBall:Number = 0;
      
      private var _allAdd:Number = 0;
      
      private var _lifeAdd:Number = 0;
      
      private var _attackAdd:Number = 0;
      
      private var _subAdd:Number = 0;
      
      private var _defenceAdd:Number = 0;
      
      public function AdditionalData()
      {
         super();
      }
      
      public static function getMaxAddArr_byNameArr(param1:Array) : Array
      {
         var _loc3_:* = undefined;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:Number = NaN;
         var _loc2_:Array = [];
         for(_loc3_ in param1)
         {
            _loc4_ = param1[_loc3_];
            _loc5_ = allName.indexOf(_loc4_);
            _loc6_ = maxArr[_loc5_] - 0.00001;
            _loc2_.push(_loc4_ + ":" + _loc6_);
         }
         return _loc2_;
      }
      
      public function getInfo() : String
      {
         var _loc2_:* = undefined;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:* = undefined;
         var _loc6_:String = null;
         var _loc7_:Number = NaN;
         var _loc8_:String = null;
         var _loc1_:String = "";
         for(_loc2_ in allName)
         {
            _loc3_ = allName[_loc2_];
            _loc4_ = allCn[_loc2_];
            _loc5_ = allBaifen[_loc2_];
            _loc6_ = allUnits[_loc2_];
            _loc7_ = Number(this[_loc3_]);
            _loc8_ = "";
            if(_loc5_ == 100)
            {
               _loc8_ = "%";
               if(_loc7_ > 1)
               {
                  _loc7_ = int(_loc7_ * 100);
               }
               else
               {
                  _loc7_ = int(_loc7_ * 1000) / 10;
               }
            }
            else if(_loc5_ == 30)
            {
               _loc7_ = int(_loc7_ * _loc5_);
            }
            else if(_loc7_ > 10)
            {
               _loc7_ = int(_loc7_);
            }
            else
            {
               _loc7_ = int(_loc7_ * 10) / 10;
            }
            if(_loc7_ > 0)
            {
               _loc1_ += this.getColor(_loc4_ + "" + this.getColor(_loc7_ + _loc8_ + _loc6_,"#FFFFFF") + "\n","#66FF00");
            }
         }
         return _loc1_;
      }
      
      public function getPlainInfo() : String
      {
         var _loc2_:* = undefined;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:* = undefined;
         var _loc6_:String = null;
         var _loc7_:Number = NaN;
         var _loc8_:String = null;
         var _loc1_:String = "";
         for(_loc2_ in allName)
         {
            _loc3_ = allName[_loc2_];
            _loc4_ = allCn[_loc2_];
            _loc5_ = allBaifen[_loc2_];
            _loc6_ = allUnits[_loc2_];
            _loc7_ = Number(this[_loc3_]);
            _loc8_ = "";
            if(_loc5_ == 100)
            {
               _loc8_ = "%";
               if(_loc7_ > 1)
               {
                  _loc7_ = int(_loc7_ * 100);
               }
               else
               {
                  _loc7_ = int(_loc7_ * 1000) / 10;
               }
            }
            else if(_loc5_ == 30)
            {
               _loc7_ = int(_loc7_ * _loc5_);
            }
            else if(_loc7_ > 10)
            {
               _loc7_ = int(_loc7_);
            }
            else
            {
               _loc7_ = int(_loc7_ * 10) / 10;
            }
            if(_loc7_ > 0)
            {
               _loc1_ += _loc4_ + "：" + (_loc7_ + _loc8_ + _loc6_) + "\n";
            }
         }
         return _loc1_;
      }
      
      public function getOneStr_byName(param1:String) : String
      {
         var _loc2_:String = "";
         var _loc3_:* = allName.indexOf(param1);
         var _loc4_:String = allCn[_loc3_];
         var _loc5_:* = allBaifen[_loc3_];
         var _loc6_:String = allUnits[_loc3_];
         var _loc7_:Number = Number(this[param1]);
         var _loc8_:String = "";
         if(_loc5_ == 100)
         {
            _loc8_ = "%";
            if(_loc7_ > 1)
            {
               _loc7_ = int(_loc7_ * 100);
            }
            else
            {
               _loc7_ = int(_loc7_ * 1000) / 10;
            }
         }
         else if(_loc5_ == 30)
         {
            _loc7_ = int(_loc7_ * _loc5_);
         }
         else if(_loc7_ > 10)
         {
            _loc7_ = int(_loc7_);
         }
         else
         {
            _loc7_ = int(_loc7_ * 10) / 10;
         }
         if(_loc7_ > 0)
         {
            _loc2_ += _loc4_ + "：" + (_loc7_ + _loc8_ + _loc6_) + "\n";
         }
         return _loc2_;
      }
      
      public function getColorInfo(param1:String, param2:String) : String
      {
         var _loc4_:* = undefined;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:* = undefined;
         var _loc8_:String = null;
         var _loc9_:Number = NaN;
         var _loc10_:String = null;
         var _loc3_:String = "";
         for(_loc4_ in allName)
         {
            _loc5_ = allName[_loc4_];
            _loc6_ = allCn[_loc4_];
            _loc7_ = allBaifen[_loc4_];
            _loc8_ = allUnits[_loc4_];
            _loc9_ = Number(this[_loc5_]);
            _loc10_ = "";
            if(_loc7_ == 100)
            {
               _loc10_ = "%";
               if(_loc9_ > 1)
               {
                  _loc9_ = int(_loc9_ * 100);
               }
               else
               {
                  _loc9_ = int(_loc9_ * 1000) / 10;
               }
            }
            else if(_loc7_ == 30)
            {
               _loc9_ = int(_loc9_ * _loc7_);
            }
            else if(_loc9_ > 10)
            {
               _loc9_ = int(_loc9_);
            }
            else
            {
               _loc9_ = int(_loc9_ * 10) / 10;
            }
            if(_loc9_ > 0)
            {
               _loc3_ += this.getColor(_loc6_ + "：",param1) + this.getColor(String(_loc9_ + _loc10_),param2) + _loc8_ + "\n";
            }
         }
         return _loc3_;
      }
      
      private function getColor(param1:String, param2:String = "#999999") : String
      {
         return "<font color=\'" + param2 + "\'>" + param1 + "</font>";
      }
      
      public function getInfo2() : Object
      {
         var _loc4_:* = undefined;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:* = undefined;
         var _loc8_:String = null;
         var _loc9_:Number = NaN;
         var _loc10_:String = null;
         var _loc1_:Object = new Object();
         var _loc2_:String = "";
         var _loc3_:String = "";
         for(_loc4_ in allName)
         {
            _loc5_ = allName[_loc4_];
            _loc6_ = allCn[_loc4_];
            _loc7_ = allBaifen[_loc4_];
            _loc8_ = allUnits[_loc4_];
            _loc9_ = Number(this[_loc5_]);
            _loc10_ = "";
            if(_loc7_ == 100)
            {
               _loc10_ = "%";
               if(_loc9_ > 1)
               {
                  _loc9_ = int(_loc9_ * 100);
               }
               else
               {
                  _loc9_ = int(_loc9_ * 1000) / 10;
               }
            }
            else if(_loc7_ == 30)
            {
               _loc9_ = int(_loc9_ * _loc7_);
            }
            else if(_loc9_ > 10)
            {
               _loc9_ = int(_loc9_);
            }
            else
            {
               _loc9_ = int(_loc9_ * 10) / 10;
            }
            if(_loc9_ > 0)
            {
               _loc2_ += _loc6_ + "\n";
               _loc3_ += _loc9_ + _loc10_ + _loc8_ + "\n";
            }
         }
         _loc1_.name = _loc2_;
         _loc1_.value = _loc3_;
         return _loc1_;
      }
      
      public function addData(param1:AdditionalData) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:String = null;
         for(_loc2_ in allName)
         {
            _loc3_ = allName[_loc2_];
            this[_loc3_] += param1[_loc3_];
         }
      }
      
      public function clearData() : *
      {
         var _loc1_:AdditionalData = new AdditionalData();
         this.inData_byObj(_loc1_);
      }
      
      public function inData_byArr(param1:Array) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:String = null;
         for(_loc2_ in param1)
         {
            _loc3_ = param1[_loc2_];
            this.inData_byStr(_loc3_);
         }
      }
      
      public function inData_byStr(param1:String) : *
      {
         var _loc2_:Array = param1.split(":");
         var _loc3_:String = _loc2_[0];
         if(_loc3_ == "")
         {
            return;
         }
         var _loc4_:Number = Number(_loc2_[1]);
         this[_loc3_] = _loc4_;
      }
      
      public function inData_byObj(param1:Object) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:String = null;
         for(_loc2_ in allName)
         {
            _loc3_ = allName[_loc2_];
            if(this.hasOwnProperty(_loc3_))
            {
               this[_loc3_] = param1[_loc3_];
            }
            else
            {
               this[_loc3_] = 0;
            }
         }
      }
      
      public function randomData() : *
      {
         var _loc1_:int = Math.random() * allName.length;
         var _loc2_:String = allName[_loc1_];
         this[_loc2_] = int(Math.random() * 100) / 100;
      }
      
      public function getStrArr() : Array
      {
         var _loc2_:* = undefined;
         var _loc3_:String = null;
         var _loc4_:Number = NaN;
         var _loc1_:Array = [];
         for(_loc2_ in allName)
         {
            _loc3_ = allName[_loc2_];
            _loc4_ = Number(this[_loc3_]);
            if(_loc4_ > 0)
            {
               _loc1_.push(_loc3_ + ":" + _loc4_);
            }
         }
         return _loc1_;
      }
      
      public function getNameArr() : Array
      {
         var _loc2_:* = undefined;
         var _loc3_:String = null;
         var _loc4_:Number = NaN;
         var _loc1_:Array = [];
         for(_loc2_ in allName)
         {
            _loc3_ = allName[_loc2_];
            _loc4_ = Number(this[_loc3_]);
            if(_loc4_ > 0)
            {
               _loc1_.push(_loc3_);
            }
         }
         return _loc1_;
      }
      
      public function getCheating() : String
      {
         var _loc1_:* = undefined;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         for(_loc1_ in allName)
         {
            _loc2_ = Number(this[allName[_loc1_]]);
            _loc3_ = Number(maxArr[_loc1_]);
            if(_loc2_ > _loc3_ + 0.0001)
            {
               return allName[_loc1_] + ":" + _loc2_;
            }
         }
         return "";
      }
      
      public function set dps(param1:Number) : *
      {
         this._dps = param1 * this.V64;
      }
      
      public function get dps() : Number
      {
         return this._dps / this.V64;
      }
      
      public function set dps_pro(param1:Number) : *
      {
         this._dps_pro = param1 * this.V64;
      }
      
      public function get dps_pro() : Number
      {
         return this._dps_pro / this.V64;
      }
      
      public function set crit_pro(param1:Number) : *
      {
         this._crit_pro = param1 * this.V64;
      }
      
      public function get crit_pro() : Number
      {
         return this._crit_pro / this.V64;
      }
      
      public function set crit_mul(param1:Number) : *
      {
         this._crit_mul = param1 * this.V64;
      }
      
      public function get crit_mul() : Number
      {
         return this._crit_mul / this.V64;
      }
      
      public function set attack_speed(param1:Number) : *
      {
         this._attack_speed = param1 * this.V64;
      }
      
      public function get attack_speed() : Number
      {
         return this._attack_speed / this.V64;
      }
      
      public function set life_max(param1:Number) : *
      {
         this._life_max = param1 * this.V64;
      }
      
      public function get life_max() : Number
      {
         return this._life_max / this.V64;
      }
      
      public function set life_rate(param1:Number) : *
      {
         this._life_rate = param1 * this.V64;
      }
      
      public function get life_rate() : Number
      {
         return this._life_rate / this.V64;
      }
      
      public function set life_steal(param1:Number) : *
      {
         this._life_steal = param1 * this.V64;
      }
      
      public function get life_steal() : Number
      {
         return this._life_steal / this.V64;
      }
      
      public function set coin(param1:Number) : *
      {
         this._coin = param1 * this.V64;
      }
      
      public function get coin() : Number
      {
         return this._coin / this.V64;
      }
      
      public function set exp(param1:Number) : *
      {
         this._exp = param1 * this.V64;
      }
      
      public function get exp() : Number
      {
         return this._exp / this.V64;
      }
      
      public function set achieve(param1:Number) : *
      {
         this._achieve = param1 * this.V64;
      }
      
      public function get achieve() : Number
      {
         return this._achieve / this.V64;
      }
      
      public function set energy_max(param1:Number) : *
      {
         this._energy_max = param1 * this.V64;
      }
      
      public function get energy_max() : Number
      {
         return this._energy_max / this.V64;
      }
      
      public function set energy_rate(param1:Number) : *
      {
         this._energy_rate = param1 * this.V64;
      }
      
      public function get energy_rate() : Number
      {
         return this._energy_rate / this.V64;
      }
      
      public function set defence_max(param1:Number) : *
      {
         this._defence_max = param1 * this.V64;
      }
      
      public function get defence_max() : Number
      {
         return this._defence_max / this.V64;
      }
      
      public function set lifeBall(param1:Number) : *
      {
         this._lifeBall = param1 * this.V64;
      }
      
      public function get lifeBall() : Number
      {
         return this._lifeBall / this.V64;
      }
      
      public function set allAdd(param1:Number) : *
      {
         this._allAdd = param1 * this.V64;
      }
      
      public function get allAdd() : Number
      {
         return this._allAdd / this.V64;
      }
      
      public function set lifeAdd(param1:Number) : *
      {
         this._lifeAdd = param1 * this.V64;
      }
      
      public function get lifeAdd() : Number
      {
         return this._lifeAdd / this.V64;
      }
      
      public function set attackAdd(param1:Number) : *
      {
         this._attackAdd = param1 * this.V64;
      }
      
      public function get attackAdd() : Number
      {
         return this._attackAdd / this.V64;
      }
      
      public function set subAdd(param1:Number) : *
      {
         this._subAdd = param1 * this.V64;
      }
      
      public function get subAdd() : Number
      {
         return this._subAdd / this.V64;
      }
      
      public function set defenceAdd(param1:Number) : *
      {
         this._defenceAdd = param1 * this.V64;
      }
      
      public function get defenceAdd() : Number
      {
         return this._defenceAdd / this.V64;
      }
   }
}

