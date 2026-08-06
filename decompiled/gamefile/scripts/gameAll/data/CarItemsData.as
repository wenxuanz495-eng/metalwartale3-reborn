package gameAll.data
{
   import body.hero.CarDefine;
   import data.StringToDefine;
   import data.TextWay;
   import gameAll.data.car.CarDataCreator;
   import gameAll.define.car.CarStrengthenDefine;
   import gameAll.define.car.CarUpgradeDefine;
   
   public class CarItemsData extends ItemsData
   {
      
      public static var maxUpgrageNum:int = 20;
      
      public var baseLabel:String = "";
      
      private var _upgradeNum:String = "0";
      
      private var _strengthenNum:String = "0";
      
      public var affixLevel:int = 0;
      
      public var color:String = "white";
      
      public var defenceType:String = "mixed";
      
      public var extraObj:Object = {};

      public var skinB:Boolean = false;
      
      private var _define:CarDefine = null;
      
      public function CarItemsData()
      {
         super();
      }
      
      override public function inData_byObj(obj:Object) : *
      {
         this.baseLabel = obj.baseLabel;
         super.inData_byObj(obj);
         if(obj.hasOwnProperty("upgradeNum"))
         {
            this.upgradeNum = obj.upgradeNum;
         }
         else
         {
            this.upgradeNum = 0;
         }
         if(obj.hasOwnProperty("extraObj"))
         {
            this.extraObj = obj.extraObj;
            this.affixLevel = obj.affixLevel;
            this.color = obj.color;
            this.defenceType = obj.defenceType;
         }
         else
         {
            this.extraObj = {};
            this.affixLevel = 0;
            this.color = "white";
            this.defenceType = "mixed";
         }
         if(obj.hasOwnProperty("strengthenNum"))
         {
            this.strengthenNum = obj.strengthenNum;
         }
         else
         {
            this.strengthenNum = 0;
         }
         this.skinB = obj.hasOwnProperty("skinB") && Boolean(obj.skinB);
      }
      
      public function swapToData(da0:CarItemsData) : *
      {
         var n:* = undefined;
         var pro0:String = null;
         var pro_arr:Array = ["baseLabel","upgradeNum","strengthenNum","affixLevel","color","defenceType","extraObj"];
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            this[pro0] = da0[pro0];
         }
         this._define = null;
      }
      
      public function getArmsDefine() : CarDefine
      {
         return Game.defineGroup.getCarDefine(this.baseLabel);
      }
      
      public function getDefine() : CarDefine
      {
         if(Boolean(this._define))
         {
            return this._define;
         }
         this._define = this.getArmsDefine();
         return this._define;
      }
      
      public function getDefenceType() : String
      {
         if(this.defenceType == "")
         {
            return this.getDefine().defenceType;
         }
         return this.defenceType;
      }
      
      public function getExtraObjText() : String
      {
         return Game.newDG.car.getText_byObj(this.extraObj);
      }
      
      public function getSellPrice() : int
      {
         var mul0:Number = CarDataCreator.getColorMul(this.color);
         return Game.newDG.getCarPrice_byLevel(this.getNowLevel()) * mul0;
      }

      public function getSkinSellPrice() : int
      {
         return this.getDefine().price;
      }
      
      public function fleshByDefine() : *
      {
         var d0:CarDefine = this.getDefine();
         type = "car";
         name = d0.id;
         cnName = d0.name;
         imgLabel = d0.getImgLabel();
      }

      public function convertToSkin() : *
      {
         this.skinB = true;
         this.upgradeNum = 0;
         this.strengthenNum = 0;
         this.affixLevel = 0;
         this.defenceType = "";
         this.extraObj = {};
         this.buyDate = "";
         this.newB = true;
      }
      
      public function setMcarNowLevel(lv0:int) : *
      {
         var num0:int = (lv0 - 7) / 6;
         if(num0 < 0)
         {
            num0 = 0;
         }
         else if(num0 > maxUpgrageNum)
         {
            num0 = maxUpgrageNum;
         }
         this.upgradeNum = num0;
      }
      
      private function getLevel_byUpgradeNum(num0:int) : int
      {
         if(num0 >= 15)
         {
            return 70 + num0 * 6;
         }
         if(num0 >= 13)
         {
            return 50 + num0 * 6;
         }
         return 7 + num0 * 6;
      }
      
      private function getInstallLevel_byUpgradeNum(num0:int) : int
      {
         return 4 + num0 * 6;
      }
      
      public function getNowLevel() : int
      {
         var type0:String = this.getDefine().getType();
         if(type0 == "G")
         {
            return this.getDefine().mustLevel;
         }
         return this.getLevel_byUpgradeNum(this.upgradeNum);
      }
      
      public function getNowInstallLevel() : int
      {
         var type0:String = this.getDefine().getType();
         if(type0 == "G")
         {
            return this.getDefine().installLevel;
         }
         return 1;
      }
      
      public function getNowLife() : int
      {
         var mul0:Number = CarDataCreator.getColorMul(this.color);
         var s_mul0:Number = 1;
         var d0:CarStrengthenDefine = this.getNowStrengthenDefine();
         if(Boolean(d0))
         {
            s_mul0 += d0.lifeMul;
         }
         var mul2:Number = 1;
         if(this.getDefine().type == "G" && this.getDefine().discount == -1000)
         {
            mul2 = 1.5;
         }
         return int(Math.round(this.getBaseLife() * mul0 * s_mul0 * mul2));
      }
      
      public function getNowDefence() : int
      {
         var mul0:Number = CarDataCreator.getColorMul(this.color);
         var s_mul0:Number = 1;
         var d0:CarStrengthenDefine = this.getNowStrengthenDefine();
         if(Boolean(d0))
         {
            s_mul0 += d0.defenceMul;
         }
         var mul2:Number = 1;
         if(this.getDefine().type == "G" && this.getDefine().discount == -1000)
         {
            mul2 = 1.5;
         }
         return int(Math.round(this.getBaseDefence() * mul0 * s_mul0 * mul2));
      }
      
      public function getBaseLife() : int
      {
         return Game.newDG.getCarLife_byLevel(this.getNowLevel());
      }
      
      public function getBaseDefence() : int
      {
         return Game.newDG.getCarDefence_byLevel(this.getNowLevel());
      }
      
      public function getMaxUpgradeB() : Boolean
      {
         return this.upgradeNum >= maxUpgrageNum;
      }
      
      public function getMaxUpgradeLevel() : int
      {
         return maxUpgrageNum;
      }
      
      public function getNextLevel() : int
      {
         return this.getLevel_byUpgradeNum(this.upgradeNum + 1);
      }
      
      public function getNextBaseLife() : int
      {
         return Game.newDG.getCarLife_byLevel(this.getNextLevel());
      }
      
      public function getNextBaseDefence() : int
      {
         return Game.newDG.getCarDefence_byLevel(this.getNextLevel());
      }
      
      public function getNextMustHeroLevel() : int
      {
         return this.getInstallLevel_byUpgradeNum(this.upgradeNum + 1);
      }
      
      public function getNextMustM() : int
      {
         var d0:CarUpgradeDefine = Game.newDG.getCarUpgradeDefine(this.upgradeNum);
         return d0.M;
      }
      
      public function getNowUpgradeText() : String
      {
         var str0:String = "";
         str0 += "等级：" + this.getNowLevel() + "\n";
         str0 += "基础耐久：" + this.getBaseLife() + "\n";
         return str0 + ("基础防御：" + this.getBaseDefence());
      }
      
      public function getNextUpgradeText() : String
      {
         var str0:String = null;
         if(this.getMaxUpgradeB())
         {
            return "        无";
         }
         str0 = "";
         str0 += "等级：" + this.getNextLevel() + "\n";
         str0 += "基础耐久：" + this.getNextBaseLife() + "\n";
         return str0 + ("基础防御：" + this.getNextBaseDefence());
      }
      
      public function upgrade() : *
      {
         if(this.upgradeNum < this.getDefine().maxUpgradeLevel)
         {
            ++this.upgradeNum;
            CarDataCreator.setUpgradeData(this);
         }
      }
      
      public function getMaxStrengthenB() : Boolean
      {
         return this.strengthenNum >= Game.newDG.carStrengthen.length;
      }
      
      public function getMaxStrengthenLevel() : int
      {
         return Game.newDG.carStrengthen.length;
      }
      
      public function getNowStrengthenDefine() : CarStrengthenDefine
      {
         return Game.newDG.getCarStrengthenDefine(this.strengthenNum);
      }
      
      public function getNextStrengthenDefine() : CarStrengthenDefine
      {
         return Game.newDG.getCarStrengthenDefine(this.strengthenNum + 1);
      }
      
      public function getNowStrengthenText() : String
      {
         return this.getOneStrengthenText(this.strengthenNum);
      }
      
      public function getNextStrengthenText() : String
      {
         return this.getOneStrengthenText(this.strengthenNum + 1);
      }
      
      private function getOneStrengthenText(num0:*) : String
      {
         var str0:String = "";
         var d0:CarStrengthenDefine = Game.newDG.getCarStrengthenDefine(num0);
         if(Boolean(d0))
         {
            str0 += "强化等级：" + num0 + "\n";
            str0 += "耐久加成：" + StringToDefine.getBaifen(d0.lifeMul) + "\n";
            str0 += "防御加成：" + StringToDefine.getBaifen(d0.defenceMul);
         }
         else
         {
            str0 = "        无";
         }
         return str0;
      }
      
      public function strengthen() : *
      {
         if(this.strengthenNum < Game.newDG.carStrengthen.length)
         {
            ++this.strengthenNum;
         }
      }
      
      public function get strengthenNum() : Number
      {
         return Number(TextWay.getText(this._strengthenNum));
      }
      
      public function set strengthenNum(v0:Number) : *
      {
         this._strengthenNum = TextWay.toCode(String(v0));
      }
      
      public function get upgradeNum() : Number
      {
         return Number(TextWay.getText(this._upgradeNum));
      }
      
      public function set upgradeNum(v0:Number) : *
      {
         this._upgradeNum = TextWay.toCode(String(v0));
      }
   }
}

