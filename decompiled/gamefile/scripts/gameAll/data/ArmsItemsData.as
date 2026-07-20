package gameAll.data
{
   import body.define.OneArmsDefine;
   import data.TextWay;
   
   public class ArmsItemsData extends ItemsData
   {
      
      public var baseLabel:String = "";
      
      public var type2:String = "arms";
      
      public var color:int = 0;
      
      private var _strengLevel:String = "";
      
      public var baseEnergy:Number = 0;
      
      public var baseEnergyRate:Number = 0;
      
      public var nowEnergy:Number = 0;
      
      public var maxEnergy:Number = 0;
      
      public var maxEnergyRate:Number = 0;
      
      public var add:AdditionalData = new AdditionalData();
      
      public var addSelf:AdditionalData = new AdditionalData();
      
      public var maxHoleNum:int = 4;
      
      public var nowHoleNum:int = 0;
      
      public var holeArr:Array = [];
      
      public var chipHole:* = new Object();
      
      public var dpsHurt:Number = 0;
      
      public var define:OneArmsDefine;
      
      public function ArmsItemsData()
      {
         super();
         this.strengLevel = 0;
      }
      
      public function fleshData() : *
      {
         var n:* = undefined;
         var addArr0:Array = null;
         var add1:AdditionalData = null;
         var add2:AdditionalData = null;
         var zuobi0:String = null;
         this.add = new AdditionalData();
         for(n in this.holeArr)
         {
            if(Boolean(this.holeArr[n].hasOwnProperty("affixLevel")))
            {
               addArr0 = this.holeArr[n].addArr;
               add1 = new AdditionalData();
               add1.inData_byArr(addArr0);
               this.add.addData(add1);
            }
         }
         if(Boolean(this.chipHole.hasOwnProperty("affixLevel")))
         {
            add2 = new AdditionalData();
            add2.inData_byArr(this.chipHole.addArr);
            zuobi0 = add2.getCheating();
            if(zuobi0 != "")
            {
               Game.uiGroup.showZuobile("芯片：" + zuobi0 + "属性值过高！！");
            }
            this.add.addData(add2);
         }
         this.add.addData(this.addSelf);
         this.maxEnergy = 2 * this.baseEnergy * (this.add.energy_max + 1);
         this.maxEnergyRate = this.baseEnergyRate * (1 + this.add.energy_rate);
         var d0:OneArmsDefine = this.define;
         this.dpsHurt = d0.baseDps * this.add.dps_pro + this.add.dps;
         this.define.fleshData();
         if(Game.gameState != "gaming")
         {
            this.nowEnergy = this.maxEnergy;
         }
      }
      
      public function fillEnergy() : *
      {
         this.nowEnergy = this.maxEnergy;
      }
      
      public function addEnergy(value:Number) : *
      {
         this.nowEnergy += value * this.maxEnergy;
         if(this.nowEnergy < 0)
         {
            this.nowEnergy = 0;
         }
         else if(this.nowEnergy > this.maxEnergy)
         {
            this.nowEnergy = this.maxEnergy;
         }
      }
      
      public function setEnergy(value:Number) : *
      {
         this.nowEnergy += value;
         if(this.nowEnergy < 0)
         {
            this.nowEnergy = 0;
         }
         else if(this.nowEnergy > this.maxEnergy)
         {
            this.nowEnergy = this.maxEnergy;
         }
      }
      
      public function getEnergyPer() : Number
      {
         return this.nowEnergy / this.maxEnergy;
      }
      
      override public function inData_byObj(obj:Object) : *
      {
         var n:* = undefined;
         var m:* = undefined;
         var pro0:String = null;
         var gd0:* = undefined;
         var gd1:* = undefined;
         var pro_arr:Array = ["baseLabel","type2","color","strengLevel","baseEnergy","baseEnergyRate","nowEnergy","nowHoleNum","dpsHurt"];
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            this[pro0] = obj[pro0];
         }
         super.inData_byObj(obj);
         if(Boolean(obj.chipHole.hasOwnProperty("affixLevel")))
         {
            this.chipHole = new GoodsItemsData();
            this.chipHole.inData_byObj(obj.chipHole);
         }
         else
         {
            this.chipHole = new Object();
         }
         this.holeArr.length = 0;
         for(m in obj.holeArr)
         {
            gd0 = obj.holeArr[m];
            gd1 = new GoodsItemsData();
            if(Boolean(gd0.hasOwnProperty("affixLevel")))
            {
               gd1.inData_byObj(gd0);
            }
            else
            {
               gd1 = new Object();
            }
            this.holeArr.push(gd1);
         }
      }
      
      public function copy() : ArmsItemsData
      {
         var newid:ArmsItemsData = new ArmsItemsData();
         newid.inData_byObj(this);
         return newid;
      }
      
      public function getCritDps() : Number
      {
         return this.getCrit_pro() * this.getCrit_mul();
      }
      
      public function getCrit_pro() : Number
      {
         return this.add.crit_pro + this.define.crit_pro;
      }
      
      public function getCrit_mul() : Number
      {
         return this.add.crit_mul + this.define.crit_mul;
      }
      
      public function upgradeStrengLevel(lv0:int = 1) : *
      {
         this.strengLevel += 1;
      }
      
      public function getArmsDefine() : OneArmsDefine
      {
         if(this.baseLabel == null || this.baseLabel == "")
         {
            if(Boolean(imgLabel))
            {
               this.baseLabel = imgLabel.split("/")[1];
            }
         }
         var d0:OneArmsDefine = Game.defineGroup.getAD_byStr(this.baseLabel,"",this);
         d0.itemsData = this;
         return d0;
      }
      
      public function addData(aid:ArmsItemsData) : *
      {
         this.add.addData(aid.add);
      }
      
      public function inData_byDefine() : *
      {
         var oad:OneArmsDefine = this.getArmsDefine();
         this.inData_byOther(oad);
      }
      
      public function inData_byOther(oad:OneArmsDefine) : *
      {
         this.define = oad;
         name = oad.name;
         cnName = oad.name;
         imgLabel = oad.father + "/" + oad.imgLabel;
         this.baseEnergy = oad.energyUse;
         this.baseEnergyRate = oad.energyRate;
         this.addSelf.inData_byArr(oad.addArr);
         this.define.itemsData = this;
      }
      
      public function getLevel() : int
      {
         var arr2:Array = this.baseLabel.split("_lv");
         return int(arr2[1]) - 1;
      }
      
      public function getID() : String
      {
         var arr2:Array = this.baseLabel.split("_lv");
         return String(arr2[0]);
      }
      
      public function get strengLevel() : Number
      {
         return Number(TextWay.getText(this._strengLevel));
      }
      
      public function set strengLevel(v0:Number) : *
      {
         this._strengLevel = TextWay.toCode(String(v0));
      }
      
      public function toString() : String
      {
         var n:String = null;
         var str:String = "";
         for(n in this)
         {
            str += n + ":" + this[n] + ",";
         }
         return "*** site:" + site + "   baseLabel:" + this.baseLabel;
      }
   }
}

