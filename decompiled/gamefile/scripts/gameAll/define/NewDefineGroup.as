package gameAll.define
{
   import gameAll.define.car.CarStrengthenDefine;
   import gameAll.define.car.CarUpgradeDefine;
   import gameAll.define.car.NormalCarLevelDefine;
   import gameAll.define.property.NormalPropertyDefineGroup;
   
   public class NewDefineGroup
   {
      
      public var car:NormalPropertyDefineGroup = new NormalPropertyDefineGroup();
      
      public var carLevel:Array = [];
      
      public var carUpgrade:Array = [];
      
      public var carStrengthen:Array = [];
      
      public function NewDefineGroup()
      {
         super();
      }
      
      public function inCarData_byXML(xml0:XML) : *
      {
         this.car.inData_byXML(xml0.extra[0]);
         this.inCarLevelData_byXML(xml0.base[0]);
         this.inCarUpgradeData_byXML(xml0.upgrade[0]);
         this.inCarStrengthenData_byXML(xml0.strengthen[0]);
      }
      
      private function inCarLevelData_byXML(xml0:XML) : *
      {
         var n:* = undefined;
         var level_xml0:XML = null;
         var d0:NormalCarLevelDefine = null;
         var list0:XMLList = xml0.level;
         for(n in list0)
         {
            level_xml0 = list0[n];
            d0 = new NormalCarLevelDefine();
            d0.inData_byXML(level_xml0);
            this.carLevel.push(d0);
         }
      }
      
      private function inCarUpgradeData_byXML(xml0:XML) : *
      {
         var n:* = undefined;
         var level_xml0:XML = null;
         var d0:CarUpgradeDefine = null;
         var list0:XMLList = xml0.level;
         for(n in list0)
         {
            level_xml0 = list0[n];
            d0 = new CarUpgradeDefine();
            d0.inData_byXML(level_xml0);
            this.carUpgrade.push(d0);
         }
      }
      
      private function inCarStrengthenData_byXML(xml0:XML) : *
      {
         var n:* = undefined;
         var level_xml0:XML = null;
         var d0:CarStrengthenDefine = null;
         var list0:XMLList = xml0.level;
         for(n in list0)
         {
            level_xml0 = list0[n];
            d0 = new CarStrengthenDefine();
            d0.inData_byXML(level_xml0);
            this.carStrengthen.push(d0);
         }
      }
      
      public function getCarLevelDefine(lv0:int) : NormalCarLevelDefine
      {
         if(lv0 < 1)
         {
            lv0 = 1;
         }
         else if(lv0 > this.carLevel.length)
         {
            lv0 = int(this.carLevel.length);
         }
         return this.carLevel[lv0 - 1];
      }
      
      public function getCarLife_byLevel(lv0:int) : Number
      {
         return this.getCarLevelDefine(lv0).life;
      }
      
      public function getCarDefence_byLevel(lv0:int) : Number
      {
         return this.getCarLevelDefine(lv0).defence;
      }
      
      public function getCarPrice_byLevel(lv0:int) : Number
      {
         return this.getCarLevelDefine(lv0).price;
      }
      
      public function getCarUpgradeDefine(num0:int) : CarUpgradeDefine
      {
         if(num0 < 0)
         {
            num0 = 0;
         }
         else if(num0 > this.carUpgrade.length - 1)
         {
            num0 = this.carUpgrade.length - 1;
         }
         return this.carUpgrade[num0];
      }
      
      public function getCarStrengthenDefine(lv0:int) : CarStrengthenDefine
      {
         return this.carStrengthen[lv0 - 1];
      }
   }
}

