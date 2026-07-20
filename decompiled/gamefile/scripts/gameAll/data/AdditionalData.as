package gameAll.data
{
   import data.Base64;
   
   public class AdditionalData
   {
      
      public static var allName:Array = ["dps_pro","dps","crit_pro","crit_mul","coin","exp","achieve","energy_max","energy_rate","life_max","life_rate","life_steal","defence_max","lifeBall","allAdd","lifeAdd","attackAdd","subAdd","defenceAdd"];
      
      public static var maxArr:Array = [999,999999,999,999999,999,999999,999,999,999,999,999999,999999,999999,999,999,999,999,999,999];
      
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
      
      public static function getMaxAddArr_byNameArr(arr0:Array) : Array
      {
         var n:* = undefined;
         var name0:String = null;
         var index0:int = 0;
         var max0:Number = NaN;
         var arr1:Array = [];
         for(n in arr0)
         {
            name0 = arr0[n];
            index0 = allName.indexOf(name0);
            max0 = maxArr[index0] - 0.00001;
            arr1.push(name0 + ":" + max0);
         }
         return arr1;
      }
      
      public function getInfo() : String
      {
         var n:* = undefined;
         var name0:String = null;
         var cn0:String = null;
         var baifen0:* = undefined;
         var units:String = null;
         var v0:Number = NaN;
         var baifenhao:String = null;
         var str:String = "";
         for(n in allName)
         {
            name0 = allName[n];
            cn0 = allCn[n];
            baifen0 = allBaifen[n];
            units = allUnits[n];
            v0 = Number(this[name0]);
            baifenhao = "";
            if(baifen0 == 100)
            {
               baifenhao = "%";
               if(v0 > 1)
               {
                  v0 = Math.ceil(v0 * 100);
               }
               else
               {
                  v0 = Math.ceil(v0 * 1000) / 10;
               }
            }
            else if(baifen0 == 30)
            {
               v0 = Math.ceil(v0 * baifen0);
            }
            else if(v0 > 10)
            {
               v0 = Math.ceil(v0);
            }
            else
            {
               v0 = Math.ceil(v0 * 10) / 10;
            }
            if(v0 > 0)
            {
               str += this.getColor(cn0 + "" + this.getColor(v0 + baifenhao + units,"#FFFFFF") + "\n","#66FF00");
            }
         }
         return str;
      }
      
      public function getPlainInfo() : String
      {
         var n:* = undefined;
         var name0:String = null;
         var cn0:String = null;
         var baifen0:* = undefined;
         var units:String = null;
         var v0:Number = NaN;
         var baifenhao:String = null;
         var str:String = "";
         for(n in allName)
         {
            name0 = allName[n];
            cn0 = allCn[n];
            baifen0 = allBaifen[n];
            units = allUnits[n];
            v0 = Number(this[name0]);
            baifenhao = "";
            if(baifen0 == 100)
            {
               baifenhao = "%";
               if(v0 > 1)
               {
                  v0 = Math.ceil(v0 * 100);
               }
               else
               {
                  v0 = Math.ceil(v0 * 1000) / 10;
               }
            }
            else if(baifen0 == 30)
            {
               v0 = Math.ceil(v0 * baifen0);
            }
            else if(v0 > 10)
            {
               v0 = Math.ceil(v0);
            }
            else
            {
               v0 = Math.ceil(v0 * 10) / 10;
            }
            if(v0 > 0)
            {
               str += cn0 + "：" + (v0 + baifenhao + units) + "\n";
            }
         }
         return str;
      }
      
      public function getOneStr_byName(name0:String) : String
      {
         var str:String = "";
         var n:* = allName.indexOf(name0);
         var cn0:String = allCn[n];
         var baifen0:* = allBaifen[n];
         var units:String = allUnits[n];
         var v0:Number = Number(this[name0]);
         var baifenhao:String = "";
         if(baifen0 == 100)
         {
            baifenhao = "%";
            if(v0 > 1)
            {
               v0 = Math.ceil(v0 * 100);
            }
            else
            {
               v0 = Math.ceil(v0 * 1000) / 10;
            }
         }
         else if(baifen0 == 30)
         {
            v0 = Math.ceil(v0 * baifen0);
         }
         else if(v0 > 10)
         {
            v0 = Math.ceil(v0);
         }
         else
         {
            v0 = Math.ceil(v0 * 10) / 10;
         }
         if(v0 > 0)
         {
            str += cn0 + "：" + (v0 + baifenhao + units) + "\n";
         }
         return str;
      }
      
      public function getColorInfo(color1:String, color2:String) : String
      {
         var n:* = undefined;
         var name0:String = null;
         var cn0:String = null;
         var baifen0:* = undefined;
         var units:String = null;
         var v0:Number = NaN;
         var baifenhao:String = null;
         var str:String = "";
         for(n in allName)
         {
            name0 = allName[n];
            cn0 = allCn[n];
            baifen0 = allBaifen[n];
            units = allUnits[n];
            v0 = Number(this[name0]);
            baifenhao = "";
            if(baifen0 == 100)
            {
               baifenhao = "%";
               if(v0 > 1)
               {
                  v0 = Math.ceil(v0 * 100);
               }
               else
               {
                  v0 = Math.ceil(v0 * 1000) / 10;
               }
            }
            else if(baifen0 == 30)
            {
               v0 = Math.ceil(v0 * baifen0);
            }
            else if(v0 > 10)
            {
               v0 = Math.ceil(v0);
            }
            else
            {
               v0 = Math.ceil(v0 * 10) / 10;
            }
            if(v0 > 0)
            {
               str += this.getColor(cn0 + "：",color1) + this.getColor(String(v0 + baifenhao),color2) + units + "\n";
            }
         }
         return str;
      }
      
      private function getColor(str:String, _color1:String = "#999999") : String
      {
         return "<font color=\'" + _color1 + "\'>" + str + "</font>";
      }
      
      public function getInfo2() : Object
      {
         var n:* = undefined;
         var name0:String = null;
         var cn0:String = null;
         var baifen0:* = undefined;
         var units:String = null;
         var v0:Number = NaN;
         var baifenhao:String = null;
         var obj:Object = new Object();
         var str1:String = "";
         var str2:String = "";
         for(n in allName)
         {
            name0 = allName[n];
            cn0 = allCn[n];
            baifen0 = allBaifen[n];
            units = allUnits[n];
            v0 = Number(this[name0]);
            baifenhao = "";
            if(baifen0 == 100)
            {
               baifenhao = "%";
               if(v0 > 1)
               {
                  v0 = Math.ceil(v0 * 100);
               }
               else
               {
                  v0 = Math.ceil(v0 * 1000) / 10;
               }
            }
            else if(baifen0 == 30)
            {
               v0 = Math.ceil(v0 * baifen0);
            }
            else if(v0 > 10)
            {
               v0 = Math.ceil(v0);
            }
            else
            {
               v0 = Math.ceil(v0 * 10) / 10;
            }
            if(v0 > 0)
            {
               str1 += cn0 + "\n";
               str2 += v0 + baifenhao + units + "\n";
            }
         }
         obj.name = str1;
         obj.value = str2;
         return obj;
      }
      
      public function addData(aid:AdditionalData) : *
      {
         var n:* = undefined;
         var name0:String = null;
         for(n in allName)
         {
            name0 = allName[n];
            this[name0] += aid[name0];
         }
      }
      
      public function clearData() : *
      {
         var ad0:AdditionalData = new AdditionalData();
         this.inData_byObj(ad0);
      }
      
      public function inData_byArr(arr0:Array) : *
      {
         var n:* = undefined;
         var str1:String = null;
         for(n in arr0)
         {
            str1 = arr0[n];
            this.inData_byStr(str1);
         }
      }
      
      public function inData_byStr(str0:String) : *
      {
         var arr00:Array = str0.split(":");
         var str1:String = arr00[0];
         if(str1 == "")
         {
            return;
         }
         var value1:Number = Number(arr00[1]);
         this[str1] = value1;
      }
      
      public function inData_byObj(obj0:Object) : *
      {
         var n:* = undefined;
         var name0:String = null;
         for(n in allName)
         {
            name0 = allName[n];
            if(this.hasOwnProperty(name0))
            {
               this[name0] = obj0[name0];
            }
            else
            {
               this[name0] = 0;
            }
         }
      }
      
      public function randomData() : *
      {
         var ran0:int = Math.random() * allName.length;
         var name0:String = allName[ran0];
         this[name0] = int(Math.random() * 100) / 100;
      }
      
      public function getStrArr() : Array
      {
         var n:* = undefined;
         var name0:String = null;
         var v0:Number = NaN;
         var arr0:Array = [];
         for(n in allName)
         {
            name0 = allName[n];
            v0 = Number(this[name0]);
            if(v0 > 0)
            {
               arr0.push(name0 + ":" + v0);
            }
         }
         return arr0;
      }
      
      public function getNameArr() : Array
      {
         var n:* = undefined;
         var name0:String = null;
         var v0:Number = NaN;
         var arr0:Array = [];
         for(n in allName)
         {
            name0 = allName[n];
            v0 = Number(this[name0]);
            if(v0 > 0)
            {
               arr0.push(name0);
            }
         }
         return arr0;
      }
      
      public function getCheating() : String
      {
         var n:* = undefined;
         var value0:Number = NaN;
         var max0:Number = NaN;
         for(n in allName)
         {
            value0 = Number(this[allName[n]]);
            max0 = Number(maxArr[n]);
            if(value0 > max0 + 0.0001)
            {
               return allName[n] + ":" + value0;
            }
         }
         return "";
      }
      
      public function set dps(v0:Number) : *
      {
         this._dps = v0 * this.V64;
      }
      
      public function get dps() : Number
      {
         return this._dps / this.V64;
      }
      
      public function set dps_pro(v0:Number) : *
      {
         this._dps_pro = v0 * this.V64;
      }
      
      public function get dps_pro() : Number
      {
         return this._dps_pro / this.V64;
      }
      
      public function set crit_pro(v0:Number) : *
      {
         this._crit_pro = v0 * this.V64;
      }
      
      public function get crit_pro() : Number
      {
         return this._crit_pro / this.V64;
      }
      
      public function set crit_mul(v0:Number) : *
      {
         this._crit_mul = v0 * this.V64;
      }
      
      public function get crit_mul() : Number
      {
         return this._crit_mul / this.V64;
      }
      
      public function set attack_speed(v0:Number) : *
      {
         this._attack_speed = v0 * this.V64;
      }
      
      public function get attack_speed() : Number
      {
         return this._attack_speed / this.V64;
      }
      
      public function set life_max(v0:Number) : *
      {
         this._life_max = v0 * this.V64;
      }
      
      public function get life_max() : Number
      {
         return this._life_max / this.V64;
      }
      
      public function set life_rate(v0:Number) : *
      {
         this._life_rate = v0 * this.V64;
      }
      
      public function get life_rate() : Number
      {
         return this._life_rate / this.V64;
      }
      
      public function set life_steal(v0:Number) : *
      {
         this._life_steal = v0 * this.V64;
      }
      
      public function get life_steal() : Number
      {
         return this._life_steal / this.V64;
      }
      
      public function set coin(v0:Number) : *
      {
         this._coin = v0 * this.V64;
      }
      
      public function get coin() : Number
      {
         return this._coin / this.V64;
      }
      
      public function set exp(v0:Number) : *
      {
         this._exp = v0 * this.V64;
      }
      
      public function get exp() : Number
      {
         return this._exp / this.V64;
      }
      
      public function set achieve(v0:Number) : *
      {
         this._achieve = v0 * this.V64;
      }
      
      public function get achieve() : Number
      {
         return this._achieve / this.V64;
      }
      
      public function set energy_max(v0:Number) : *
      {
         this._energy_max = v0 * this.V64;
      }
      
      public function get energy_max() : Number
      {
         return this._energy_max / this.V64;
      }
      
      public function set energy_rate(v0:Number) : *
      {
         this._energy_rate = v0 * this.V64;
      }
      
      public function get energy_rate() : Number
      {
         return this._energy_rate / this.V64;
      }
      
      public function set defence_max(v0:Number) : *
      {
         this._defence_max = v0 * this.V64;
      }
      
      public function get defence_max() : Number
      {
         return this._defence_max / this.V64;
      }
      
      public function set lifeBall(v0:Number) : *
      {
         this._lifeBall = v0 * this.V64;
      }
      
      public function get lifeBall() : Number
      {
         return this._lifeBall / this.V64;
      }
      
      public function set allAdd(v0:Number) : *
      {
         this._allAdd = v0 * this.V64;
      }
      
      public function get allAdd() : Number
      {
         return this._allAdd / this.V64;
      }
      
      public function set lifeAdd(v0:Number) : *
      {
         this._lifeAdd = v0 * this.V64;
      }
      
      public function get lifeAdd() : Number
      {
         return this._lifeAdd / this.V64;
      }
      
      public function set attackAdd(v0:Number) : *
      {
         this._attackAdd = v0 * this.V64;
      }
      
      public function get attackAdd() : Number
      {
         return this._attackAdd / this.V64;
      }
      
      public function set subAdd(v0:Number) : *
      {
         this._subAdd = v0 * this.V64;
      }
      
      public function get subAdd() : Number
      {
         return this._subAdd / this.V64;
      }
      
      public function set defenceAdd(v0:Number) : *
      {
         this._defenceAdd = v0 * this.V64;
      }
      
      public function get defenceAdd() : Number
      {
         return this._defenceAdd / this.V64;
      }
   }
}

