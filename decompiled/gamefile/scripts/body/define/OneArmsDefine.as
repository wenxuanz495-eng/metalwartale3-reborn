package body.define
{
   import body.bullet.BulletLink;
   import data.StringToDefine;
   import data.TextWay;
   import flash.geom.Point;
   import gameAll.data.ArmsItemsData;
   
   public class OneArmsDefine
   {
      
      public var xmlData:XML;
      
      public var index:int;
      
      public var id:String = "";
      
      public var level:int = 0;
      
      public var maxLevel:int = 0;
      
      public var father:String;
      
      public var shootPoint:Point;
      
      public var _baseHurt:String = "";
      
      public var mulHurt:Number = 0;
      
      public var name:String;
      
      public var type:String;
      
      public var attackType:String = "mixed";
      
      public var recoilValue:Number;
      
      public var description:String = "";
      
      public var specialProperty:String = "";
      
      public var energyUse:int = 1;
      
      public var energyRate:Number = 0;
      
      private var _commonLevel:String = "";

      public var originalCommonLevel:int = 0;
      
      public var installLevel:int = 1;
      
      public var mustLevel:int = 0;
      
      public var mustItems:Array = [];
      
      public var mustArms:String = "";
      
      public var mustArenaScore:int = -1;
      
      public var propId:String = "0";
      
      public var propId2:String = "0";
      
      private var _price:String = "0";
      
      private var _Mprice:String = "0";
      
      private var _Xprice:String = "0";
      
      private var _Yprice:String = "0";
      
      private var _Zprice:String = "0";
      
      private var _Jprice:String = "0";
      
      public var discount:Number = 0;
      
      public var priceLevel:int = 0;
      
      public var _attackGap:Number;
      
      public var attackGap:Number;
      
      public var attackDelay:Number;
      
      public var bulletNum:int;
      
      public var shootGap:Number;
      
      public var shootNum:int;
      
      public var bulletLink:BulletLink;
      
      public var bulletSpeed:Number;
      
      public var bulletMaxV:Number;
      
      public var bulletMaxVa:Number;
      
      public var bulletAngle:Number = -1;
      
      public var angleRange:Number;
      
      public var bulletTranslation:Number;
      
      public var tranArr:Array = [];
      
      public var bulletType:String = "bullet";
      
      public var hurtArr:Array;
      
      public var gravity:Number;
      
      public var floorBounce:Number;
      
      public var bulletVra:Number;
      
      public var bulletLife:Number = 2;
      
      public var backTime:Number = 0;
      
      public var followB:Number = 0;
      
      public var followDelay:Number = 0;
      
      public var followMaxTime:Number = 10000;
      
      public var bounceNum:int = 0;
      
      public var bulletWidth:int;
      
      public var penetrationB:int = 0;
      
      public var beatBack:Number = 0;
      
      public var scale:Number = 0;
      
      public var lightning:Number = 0;
      
      public var selfBoom:int = 0;
      
      public var specialType:String = "";
      
      public var Broken_PlasmaB:int = 0;
      
      public var crit_pro:Number = 0;
      
      public var crit_mul:Number = 0;
      
      public var imgLabel:String;
      
      public var imgLoopTime:Number = 0;
      
      public var bulletImgLabel:String;
      
      public var secondBulletImg:String;
      
      public var hitImgLabel:String;
      
      public var smokeImgLabel:String;
      
      public var unitImgLabel:String;
      
      public var grapRectIndex:int = -1;
      
      public var itemsData:ArmsItemsData = new ArmsItemsData();
      
      public var addArr:Array = [];
      
      public var baseDps:int = 0;
      
      public var reduceRa:Number = 1;
      
      public var hurt_0_B:Boolean = true;
      
      internal var firstCount:int = 1;
      
      public function OneArmsDefine()
      {
         super();
      }
      
      public function copy() : OneArmsDefine
      {
         var d0:OneArmsDefine = new OneArmsDefine();
         d0.inData_byXML(this.xmlData);
         d0.father = this.father;
         d0.id = this.id;
         d0.index = this.index;
         d0.level = this.level;
         d0.mustItems = this.mustItems;
         return d0;
      }
      
      public function inData_byXML(xml0:XML) : *
      {
         if(xml0.shootPoint.length() > 1)
         {
            throw new Error("配置表重复属性!");
         }
         this.xmlData = xml0;
         this.price = int(xml0.price);
         this.Mprice = int(xml0.Mprice);
         this.Xprice = Number(xml0.Xprice);
         this.Yprice = Number(xml0.Yprice);
         this.Zprice = Number(xml0.Zprice);
         this.Jprice = Number(xml0.Jprice);
         this.priceLevel = int(xml0.priceLevel);
         this.discount = Number(xml0.discount);
         this.propId = String(xml0.propId);
         this.propId2 = String(xml0.propId2);
         this.mulHurt = Number(xml0.mulHurt);
         var shootStr:String = String(xml0.shootPoint);
         if(shootStr != "")
         {
            this.shootPoint = StringToDefine.getPoint(shootStr);
         }
         this.installLevel = int(xml0.installLevel);
         if(this.installLevel < 1)
         {
            this.installLevel = 1;
         }
         this.commonLevel = int(xml0.commonLevel);
         this.originalCommonLevel = this.commonLevel;
         this.name = String(xml0.child("name"));
         this.type = String(xml0.type);
         this.attackType = String(xml0.attackType);
         this.recoilValue = Number(xml0.recoilValue);
         this.hurtArr = String(xml0.hurt).split(",");
         this.bulletNum = int(xml0.bulletNum);
         if(this.bulletNum == 0)
         {
            this.bulletNum = 1;
         }
         this.shootGap = Number(xml0.shootGap);
         this.bulletSpeed = Number(xml0.bulletSpeed);
         if(xml0.bulletMaxV.length() > 0)
         {
            this.bulletMaxV = Number(xml0.bulletMaxV);
         }
         else
         {
            this.bulletMaxV = this.bulletSpeed;
         }
         this.bulletMaxVa = Number(xml0.bulletMaxVa);
         this.gravity = Number(xml0.gravity);
         this.floorBounce = Number(xml0.floorBounce);
         this.bulletVra = Number(xml0.bulletVra);
         var laserAngle2:String = String(xml0.bulletAngle);
         if(laserAngle2 != "")
         {
            this.bulletAngle = Number(xml0.bulletAngle);
         }
         else
         {
            this.bulletAngle = -1;
         }
         this.bulletWidth = int(xml0.bulletWidth);
         this.penetrationB = int(xml0.penetrationB);
         this.angleRange = Number(xml0.angleRange);
         this.bulletTranslation = Number(xml0.bulletTranslation);
         if(xml0.tranArr.length() > 0)
         {
            this.tranArr = String(xml0.tranArr).split(",");
         }
         else
         {
            this.tranArr = [];
         }
         this.bulletLife = Number(xml0.bulletLife);
         if(this.bulletLife == 0)
         {
            this.bulletLife = 2;
         }
         this.backTime = Number(xml0.backTime);
         this.bulletType = String(xml0.bulletType);
         if(this.bulletType == "")
         {
            this.bulletType = "bullet";
         }
         this.followB = Number(xml0.followB);
         this.followDelay = Number(xml0.followDelay);
         if(xml0.followMaxTime.length() > 0)
         {
            this.followMaxTime = Number(xml0.followMaxTime);
         }
         else
         {
            this.followMaxTime = 10000;
         }
         this.bounceNum = int(xml0.bounceNum);
         this.beatBack = Number(xml0.beatBack);
         this._attackGap = Number(xml0.attackGap);
         this.attackGap = this._attackGap;
         this.shootNum = int(xml0.shootNum);
         if(this.shootNum == 0)
         {
            this.shootNum = 1;
         }
         this.attackDelay = Number(xml0.attackDelay);
         this.description = String(xml0.description);
         this.description = StringToDefine.replaceStr(this.description,"{","<");
         this.description = StringToDefine.replaceStr(this.description,"}",">");
         this.specialProperty = String(xml0.specialProperty);
         this.energyUse = Game.gameDefine.getArmsEnergyMax(this.attackGap);
         this.energyRate = Game.gameDefine.getArmsEnergyRa(this.attackGap);
         if(this.energyUse <= 0)
         {
            this.energyUse = 1;
         }
         this.scale = Number(xml0.scale);
         this.lightning = Number(xml0.lightning) * 30;
         this.Broken_PlasmaB = int(xml0.Broken_PlasmaB);
         this.imgLabel = String(xml0.imgLabel);
         this.imgLoopTime = int(xml0.imgLoopTime);
         this.bulletImgLabel = String(xml0.bulletImgLabel);
         if(this.bulletType == "bullet" || this.bulletType == "missile")
         {
            if(this.bulletImgLabel == "")
            {
               this.bulletImgLabel = this.imgLabel + "_bullet";
            }
         }
         this.secondBulletImg = String(xml0.secondBulletImg);
         this.hitImgLabel = String(xml0.hitImgLabel);
         this.smokeImgLabel = String(xml0.smokeImgLabel);
         this.unitImgLabel = String(xml0.unitImgLabel);
         if(String(xml0.grapRectIndex) == "")
         {
            this.grapRectIndex = -1;
         }
         else
         {
            this.grapRectIndex = int(xml0.grapRectIndex);
         }
         var bulletLinkStr:String = String(xml0.bulletLink);
         if(bulletLinkStr != "")
         {
            this.bulletLink = new BulletLink();
            this.bulletLink.index = int(xml0.bulletLink.@index);
            this.bulletLink.bulletName = bulletLinkStr;
            this.bulletLink.inData_byName();
         }
         else
         {
            this.bulletLink = null;
         }
         if(xml0.mustLevel.length() > 0)
         {
            this.mustLevel = int(xml0.mustLevel);
         }
         else
         {
            this.mustLevel = 1;
         }
         if(xml0.hasOwnProperty("mustArenaScore"))
         {
            this.mustArenaScore = int(xml0.mustArenaScore);
         }
         this.mustItems = String(xml0.mustItems).split(",");
         this.mustArms = String(xml0.mustArms);
         if(this.mustArms == "plasma_lv4")
         {
            this.mustArms = "plasma_lv1";
         }
         if(this.mustArms == "chipped_lv4")
         {
            this.mustArms = "chipped_lv1";
         }
         this.selfBoom = Number(xml0.selfBoom);
         this.specialType = String(xml0.specialType);
         if(String(xml0.addArr) != "")
         {
            this.addArr = String(xml0.addArr).split(",");
         }
         this.crit_pro = Number(xml0.crit_pro) + 0.05;
         this.crit_mul = Number(xml0.crit_mul) + 0.5;
         if(xml0.reduceRa.length() > 0)
         {
            this.reduceRa = Number(xml0.reduceRa);
         }
         else
         {
            this.reduceRa = 1;
         }
         this.itemsData.define = this;
         this.fleshData();
      }
      
      public function fleshData() : *
      {
         var nativeGrowth0:int = 0;
         var chipGrowth0:int = 0;
         var growthLevel0:int = this.originalCommonLevel;
         if(this.specialType.indexOf("Level_Growth") >= 0)
         {
            nativeGrowth0 = int(this.specialType.split("_Growth_")[1]);
            if(this.id.indexOf("con") == 0)
            {
               nativeGrowth0 += this.itemsData.strengLevel;
            }
            growthLevel0 = Game.gameData.level + nativeGrowth0 + 1;
         }
         chipGrowth0 = this.itemsData.getPurpleChipGrowthLevel();
         if(chipGrowth0 > 0)
         {
            growthLevel0 = this.itemsData.getPurpleGrowthCalculatedLevel();
         }
         this.commonLevel = Math.max(this.originalCommonLevel,growthLevel0);
         this.baseDps = Game.gameDefine.getDpsByLevel(this.commonLevel);
         if(this.father == "arms")
         {
            this.baseDps *= 4 * 1.2;
         }
         else if(this.father == "sub")
         {
            this.baseDps *= 1.15 * 1.2;
         }
         var allDps:Number = this.getDps();
         this.baseHurt = this.getHurtByDps(allDps) * this.reduceRa;
      }
      
      public function set baseHurt(_value:Number) : *
      {
         this._baseHurt = String(_value);
      }
      
      public function get baseHurt() : Number
      {
         return int(this._baseHurt);
      }
      
      public function getBaseHurt() : int
      {
         return this.getHurtByDps(this.baseDps) * this.reduceRa;
      }
      
      public function getAllHurt() : int
      {
         return this.getHurtByDps(this.getDps()) * this.reduceRa;
      }
      
      public function getAllDataHurt() : int
      {
         return this.getHurtByDps(this.getAllDps()) * this.reduceRa;
      }
      
      public function get hurt() : Number
      {
         if(this.father == "arms" || this.father == "sub")
         {
            return Number(this.baseHurt);
         }
         return Number(this.hurtArr[0]);
      }
      
      public function getLabel() : String
      {
         return this.id + "_lv" + (this.level + 1);
      }
      
      public function getShootSpeed() : Number
      {
         return int(1 / (this.attackGap + 0.067) * 10 / 10 * this.shootNum * this.bulletNum * 10) / 10;
      }
      
      public function getDps() : Number
      {
         return this.baseDps + this.itemsData.dpsHurt;
      }
      
      public function getAllDps() : Number
      {
         this.itemsData.fleshData();
         var pd:* = Game.gameData.playerData;
         if(this.father == "arms")
         {
            return this.getDps() * (1 + this.itemsData.getCritDps()) * Game.gameData.getAllArmsAdd();
         }
         return this.getDps() * (1 + this.itemsData.getCritDps()) * Game.gameData.getAllSubAdd();
      }
      
      public function getDps_byHurt(value:Number) : Number
      {
         var dps0:Number = NaN;
         if(this.bulletType == "bullet")
         {
            if(this.bulletLink is BulletLink)
            {
               dps0 = value * (this.shootNum + this.bulletNum) / (this.attackGap + 0.1);
            }
            else
            {
               dps0 = value * this.shootNum * this.bulletNum / (this.attackGap + 0.1);
            }
            if(this.lightning > 0)
            {
               dps0 = value * this.shootNum * this.bulletNum / this.lightning * 30 / (this.attackGap + 0.1);
            }
         }
         else
         {
            dps0 = value * this.bulletLife * 30 / (this.attackGap + 0.1);
         }
         return dps0;
      }
      
      public function getHurtByDps(dps0:Number) : Number
      {
         var hurt00:Number = 0;
         if(this.bulletType == "bullet")
         {
            if(this.lightning > 0)
            {
               hurt00 = dps0 * (this.attackGap + 0.1) * this.lightning / 30 / this.bulletLife;
            }
            else
            {
               hurt00 = dps0 * (this.attackGap + 0.1) / (this.shootNum * this.bulletNum);
            }
         }
         else
         {
            hurt00 = dps0 * (this.attackGap + 0.1) / (this.bulletLife * 30);
         }
         return hurt00;
      }
      
      public function getSellPrice() : int
      {
         return this.price / 2;
      }
      
      public function get price() : int
      {
         return int(TextWay.getText(this._price));
      }
      
      public function set price(v0:int) : *
      {
         this._price = TextWay.toCode(String(v0));
      }
      
      public function get Mprice() : int
      {
         return int(TextWay.getText(this._Mprice));
      }
      
      public function set Mprice(v0:int) : *
      {
         this._Mprice = TextWay.toCode(String(v0));
      }
      
      public function get Xprice() : Number
      {
         return int(TextWay.getText(this._Xprice));
      }
      
      public function set Xprice(v0:Number) : *
      {
         this._Xprice = TextWay.toCode(String(v0));
      }
      
      public function get Yprice() : Number
      {
         return Number(TextWay.getText(this._Yprice));
      }
      
      public function set Yprice(v0:Number) : *
      {
         this._Yprice = TextWay.toCode(String(v0));
      }
      
      public function get Zprice() : Number
      {
         return Number(TextWay.getText(this._Zprice));
      }
      
      public function set Zprice(v0:Number) : *
      {
         this._Zprice = TextWay.toCode(String(v0));
      }
      
      public function get Jprice() : Number
      {
         return Number(TextWay.getText(this._Jprice));
      }
      
      public function set Jprice(v0:Number) : *
      {
         this._Jprice = TextWay.toCode(String(v0));
      }
      
      public function get commonLevel() : Number
      {
         return Number(TextWay.getText(this._commonLevel));
      }
      
      public function set commonLevel(v0:Number) : *
      {
         this._commonLevel = TextWay.toCode(String(v0));
      }
   }
}

