package body.define
{
   import body.hero.CarDefine;
   import body.skill.SkillDefineGroup;
   import flash.geom.Point;
   import gameAll.data.ArmsItemsData;
   
   public class DefineGroup
   {
      
      public var skill:SkillDefineGroup = new SkillDefineGroup();
      
      public var carArr:Array = [];
      
      private var armsArr:Array = [];
      
      private var armsRange:Array = [0,0];
      
      private var subArmsRange:Array = [0,0];
      
      private var enemyArmsRange:Array = [0,0];
      
      public var armsImgLabelArr:Array;
      
      public var subImgLabelArr:Array;
      
      public var carImgLabelArr:Array = [];
      
      public var enemyNameList:Array = [];
      
      public var enemyDefineArr:Array = [];
      
      public function DefineGroup()
      {
         super();
      }
      
      public function get ArmsArr() : Array
      {
         return this.armsArr;
      }
      
      public function addData_byXML(xml0:XML, armsFather:String = "") : *
      {
         var n:* = undefined;
         var xml1:XML = null;
         var maxLevel0:int = 0;
         var m:* = undefined;
         var xml2:XML = null;
         var define0:OneArmsDefine = null;
         var mar:Array = null;
         var gd0:* = Game.gameDefine;
         var firstIndex:int = int(this.armsArr.length);
         for(n in xml0.arms)
         {
            xml1 = xml0.arms[n];
            this.armsArr.push([]);
            maxLevel0 = xml1.armsLevel.length();
            for(m in xml1.armsLevel)
            {
               xml2 = xml1.armsLevel[m];
               define0 = new OneArmsDefine();
               define0.father = xml0.father;
               define0.id = xml1.@id;
               define0.index = xml1.@index;
               define0.level = m;
               define0.maxLevel = maxLevel0;
               define0.inData_byXML(xml2);
               this.armsArr[this.armsArr.length - 1][m] = define0;
               if(armsFather == "arms" || armsFather == "subArms")
               {
                  if(define0.level > 0 && define0.id == "darkpower")
                  {
                     // 黯灭 -> 湮灭 -> 泯灭: guild medal research costs = 1/5.
                     define0.mustItems = this.scaleGuildArmsMustItems(define0.mustItems,0.2);
                  }
                  else if(define0.level > 0 && define0.index < 50)
                  {
                     mar = define0.mustItems;
                     define0.mustItems = gd0.getArmsMustItems(define0.attackType,mar);
                  }
                  else if(define0.level > 0 && define0.index >= 50 && define0.index < 90)
                  {
                     // Guild/extra weapons (including 湮灭 line): materials = 1/10 of original.
                     define0.mustItems = this.scaleGuildArmsMustItems(define0.mustItems,0.1);
                  }
               }
            }
         }
         if(armsFather == "arms")
         {
            this.armsRange[0] = firstIndex;
            this.armsRange[1] = this.armsArr.length - 1;
         }
         else if(armsFather == "subArms")
         {
            this.subArmsRange[0] = firstIndex;
            this.subArmsRange[1] = this.armsArr.length - 1;
         }
         else if(armsFather == "enemyArms")
         {
            this.enemyArmsRange[0] = firstIndex;
            this.enemyArmsRange[1] = this.armsArr.length - 1;
         }
      }
      
      public function addCarData_byXML(xml0:XML) : *
      {
         var n:* = undefined;
         var xml1:XML = null;
         var define0:CarDefine = null;
         var list0:XMLList = xml0.gather.car;
         for(n in list0)
         {
            xml1 = list0[n];
            define0 = new CarDefine();
            define0.inData_byXML(xml1);
            define0.father = xml0.father;
            this.carArr.push(define0);
         }
      }
      
      public function addEnemyName_byXML(xml0:XML) : *
      {
         var n:* = undefined;
         var xml2:XML = null;
         var d0:EnemyDefine = null;
         for(n in xml0.enemy)
         {
            xml2 = xml0.enemy[n];
            this.enemyNameList.push([String(xml2.child("name")),String(xml2.@id)]);
            d0 = new EnemyDefine();
            d0.inData_byXML(xml2);
            d0.id = String(xml2.@id);
            this.enemyDefineArr.unshift(d0);
         }
      }
      
      public function getEnemyName(name0:String) : String
      {
         var n:* = undefined;
         for(n in this.enemyNameList)
         {
            if(this.enemyNameList[n][0] == name0)
            {
               return this.enemyNameList[n][1];
            }
         }
         return "";
      }
      
      public function getEnemyNameArr(arr0:Array) : Array
      {
         var n:* = undefined;
         var name0:String = null;
         var name1:String = null;
         var arr1:Array = [];
         for(n in arr0)
         {
            name0 = arr0[n];
            name1 = this.getEnemyName(name0);
            if(name1 != "")
            {
               arr1.push(name1);
            }
         }
         return arr1;
      }
      
      public function getEnemyDefine_byCnName(name0:String) : EnemyDefine
      {
         var n:* = undefined;
         var d0:EnemyDefine = null;
         for(n in this.enemyDefineArr)
         {
            d0 = this.enemyDefineArr[n];
            if(d0.name == name0)
            {
               return d0;
            }
         }
         return null;
      }
      
      public function getCarDefine(id0:String) : CarDefine
      {
         var n:* = undefined;
         var define0:CarDefine = null;
         for(n in this.carArr)
         {
            define0 = this.carArr[n];
            if(define0.id == id0)
            {
               return define0;
            }
         }
         return null;
      }
      
      public function getCarArr_byLabelArr(arr0:Array) : Array
      {
         var n:* = undefined;
         var str0:String = null;
         var d0:CarDefine = null;
         var arr1:Array = [];
         for(n in arr0)
         {
            str0 = arr0[n];
            d0 = this.getCarDefine(str0);
            if(d0 != null)
            {
               arr1.push(d0);
            }
         }
         return arr1;
      }
      
      public function getCarDefine_byMustLevel(level0:int, carType0:String = "") : CarDefine
      {
         var n:* = undefined;
         var define0:CarDefine = null;
         var min0:CarDefine = null;
         for(n in this.carArr)
         {
            define0 = this.carArr[n];
            if(define0.discount != -1000)
            {
               if(define0.mustLevel > level0)
               {
                  break;
               }
               if(carType0 != "")
               {
                  if(define0.getType() != carType0)
                  {
                     break;
                  }
               }
               min0 = define0;
            }
         }
         return min0;
      }
      
      public function getCarDefine_byInstallLevel(level0:int, carType0:String = "") : CarDefine
      {
         var n:* = undefined;
         var define0:CarDefine = null;
         var min0:CarDefine = null;
         for(n in this.carArr)
         {
            define0 = this.carArr[n];
            if(define0.discount != -1000)
            {
               if(define0.installLevel > level0)
               {
                  break;
               }
               if(carType0 != "")
               {
                  if(define0.getType() != carType0)
                  {
                     break;
                  }
               }
               min0 = define0;
            }
         }
         return min0;
      }
      
      public function init() : *
      {
         var n:* = undefined;
         var define0:CarDefine = null;
         this.armsImgLabelArr = this.getImgLabelArr("arms");
         this.subImgLabelArr = this.getImgLabelArr("subArms");
         for(n in this.carArr)
         {
            define0 = this.carArr[n];
            this.carImgLabelArr[n] = define0.imgLabel;
         }
      }
      
      public function getAll(armsFather:String = "") : Array
      {
         var d0:OneArmsDefine = null;
         var arr0:Array = [];
         var n:int = 0;
         var n2:int = this.armsArr.length - 1;
         if(armsFather == "arms")
         {
            n = int(this.armsRange[0]);
            n2 = int(this.armsRange[1]);
         }
         else if(armsFather == "subArms")
         {
            n = int(this.subArmsRange[0]);
            n2 = int(this.subArmsRange[1]);
         }
         else if(armsFather == "enemyArms")
         {
            n = int(this.enemyArmsRange[0]);
            n2 = int(this.enemyArmsRange[1]);
         }
         while(n <= n2)
         {
            d0 = this.armsArr[n][0];
            if(d0.index < 100)
            {
               arr0.push(this.armsArr[n]);
            }
            n++;
         }
         return arr0;
      }
      
      public function getArmsDefine(id0:String, level0:int, armsFather:String = "", itemsData:ArmsItemsData = null) : OneArmsDefine
      {
         var ad:OneArmsDefine = null;
         var arr0:Array = this.getArmsDefineArr(id0,armsFather);
         if(arr0.length >= level0 + 1)
         {
            return arr0[level0];
         }
         trace("没找到这个武器的数据：" + id0 + ":" + level0);
         return null;
      }
      
      public function getAD_byStr(str0:String, armsFather:String = "", itemsData:ArmsItemsData = null) : OneArmsDefine
      {
         var arr0:Array = str0.split("_lv");
         return this.getArmsDefine(arr0[0],arr0[1] - 1,armsFather,itemsData);
      }
      
      public function getArmsDefineArr(id0:String, armsFather:String = "", copyB:Boolean = false) : Array
      {
         var define0:OneArmsDefine = null;
         var arr12:Array = null;
         var i:* = undefined;
         var n:int = 0;
         var n2:int = this.armsArr.length - 1;
         if(armsFather == "arms")
         {
            n = int(this.armsRange[0]);
            n2 = int(this.armsRange[1]);
         }
         else if(armsFather == "subArms")
         {
            n = int(this.subArmsRange[0]);
            n2 = int(this.subArmsRange[1]);
         }
         else if(armsFather == "enemyArms")
         {
            n = int(this.enemyArmsRange[0]);
            n2 = int(this.enemyArmsRange[1]);
         }
         for(var loopNum:int = 0; n <= n2; )
         {
            if(this.armsArr[n] == null || this.armsArr[n].length == 0)
            {
               n++;
               continue;
            }
            define0 = this.armsArr[n][0];
            loopNum++;
            if(define0 == null)
            {
               n++;
               continue;
            }
            if(define0.id == id0)
            {
               if(copyB)
               {
                  arr12 = [];
                  for(i in this.armsArr[n])
                  {
                     arr12.push(this.armsArr[n][i].copy());
                  }
                  return arr12;
               }
               return this.armsArr[n];
            }
            n++;
         }
         return [];
      }
      
      public function getStrArr_byMustLevel(level0:int, armsFather:String = "") : Array
      {
         var mind:OneArmsDefine = null;
         var m:* = undefined;
         var define0:OneArmsDefine = null;
         var l0:String = null;
         var n:int = 0;
         var n2:int = this.armsArr.length - 1;
         if(armsFather == "arms")
         {
            n = int(this.armsRange[0]);
            n2 = int(this.armsRange[1]);
         }
         else if(armsFather == "subArms")
         {
            n = int(this.subArmsRange[0]);
            n2 = int(this.subArmsRange[1]);
         }
         else if(armsFather == "enemyArms")
         {
            n = int(this.enemyArmsRange[0]);
            n2 = int(this.enemyArmsRange[1]);
         }
         for(var arr0:Array = []; n <= n2; )
         {
            mind = null;
            for(m in this.armsArr[n])
            {
               define0 = this.armsArr[n][m];
               if(define0.mustLevel <= level0 && define0.index < 50)
               {
                  mind = define0;
               }
            }
            if(mind is OneArmsDefine)
            {
               l0 = mind.getLabel();
               if(l0 != "")
               {
                  arr0.push(mind.getLabel());
               }
            }
            n++;
         }
         return arr0;
      }
      
      public function getArr2(armsFather:String = "", specialB:Boolean = false) : Array
      {
         var p0:Point = this.getArmsRange(armsFather);
         var n:int = p0.x;
         var n2:int = p0.y;
         for(var arr2:Array = []; n <= n2; )
         {
            if(this.armsArr[n][0].index < 50)
            {
               arr2.push(this.armsArr[n]);
            }
            n++;
         }
         return arr2;
      }
      
      public function getArmsRange(armsFather:String = "") : Point
      {
         var n:int = 0;
         var n2:int = this.armsArr.length - 1;
         if(armsFather == "arms")
         {
            n = int(this.armsRange[0]);
            n2 = int(this.armsRange[1]);
         }
         else if(armsFather == "subArms")
         {
            n = int(this.subArmsRange[0]);
            n2 = int(this.subArmsRange[1]);
         }
         else if(armsFather == "enemyArms")
         {
            n = int(this.enemyArmsRange[0]);
            n2 = int(this.enemyArmsRange[1]);
         }
         return new Point(n,n2);
      }
      
      private function getImgLabelArr(armsFather:String = "", numLimit:int = 10) : Array
      {
         var m:* = undefined;
         var define0:OneArmsDefine = null;
         var arr0:Array = [];
         var n:int = 0;
         var n2:int = this.armsArr.length - 1;
         if(armsFather == "arms")
         {
            n = int(this.armsRange[0]);
            n2 = int(this.armsRange[1]);
         }
         else if(armsFather == "subArms")
         {
            n = int(this.subArmsRange[0]);
            n2 = int(this.subArmsRange[1]);
         }
         else if(armsFather == "enemyArms")
         {
            n = int(this.enemyArmsRange[0]);
            n2 = int(this.enemyArmsRange[1]);
         }
         while(n <= n2)
         {
            for(m in this.armsArr[n])
            {
               if(m > numLimit - 1)
               {
                  break;
               }
               define0 = this.armsArr[n][m];
               if(define0.index < 100)
               {
                  arr0.push(define0.imgLabel);
               }
            }
            n++;
         }
         return arr0;
      }
      
      public function getArr_byLabelArr(arr0:Array, armsFather:String = "") : Array
      {
         var m:* = undefined;
         var define0:OneArmsDefine = null;
         var i:* = undefined;
         var p0:Point = this.getArmsRange(armsFather);
         var n:int = p0.x;
         var n2:int = p0.y;
         for(var arr2:Array = []; n <= n2; )
         {
            for(m in this.armsArr[n])
            {
               define0 = this.armsArr[n][m];
               for(i in arr0)
               {
                  if(define0.getLabel() == arr0[i])
                  {
                     arr2.push(define0);
                     arr0.splice(i,1);
                     break;
                  }
               }
               if(arr0.length == 0)
               {
                  return arr2;
               }
            }
            n++;
         }
         return arr2;
      }
      
      
      private function scaleGuildArmsMustItems(arr0:Array, rate:Number) : Array
      {
         var n:* = undefined;
         var txt0:String = null;
         var parts:Array = null;
         var num0:Number = NaN;
         var out:Array = [];
         if(arr0 == null)
         {
            return [];
         }
         for(n in arr0)
         {
            txt0 = String(arr0[n]);
            if(txt0.indexOf("_num") >= 0)
            {
               parts = txt0.split("_num");
               num0 = Number(parts[1]);
               if(isNaN(num0))
               {
                  num0 = 1;
               }
               num0 = Math.max(1,Math.ceil(num0 * rate));
               out.push(parts[0] + "_num" + num0);
            }
            else
            {
               out.push(txt0);
            }
         }
         return out;
      }

      public function getExtraArmsArr() : Array
      {
         var m:* = undefined;
         var n:* = undefined;
         var ad:OneArmsDefine = null;
         var arr1:Array = [];
         for(m in this.armsArr)
         {
            for(n in this.armsArr[m])
            {
               ad = this.armsArr[m][n];
               if(ad.index >= 50 && ad.index < 90)
               {
                  arr1.push(ad);
               }
            }
         }
         return arr1;
      }
      
      public function getAllDps_byStrArr(arr0:Array) : Number
      {
         var n:* = undefined;
         var d0:OneArmsDefine = null;
         var num0:Number = NaN;
         var dps0:Number = 0;
         for(n in arr0)
         {
            d0 = this.getAD_byStr(arr0[n]);
            num0 = Game.gameDefine.getDpsByLevel(d0.commonLevel);
            if(d0.father == "arms")
            {
               num0 *= 2;
            }
            dps0 += num0;
         }
         return dps0;
      }
      
      public function getGoodsType(id:int) : String
      {
         if(id >= this.armsRange[0] && id < this.armsRange[1])
         {
            return "arms";
         }
         if(id >= this.subArmsRange[0] && id < this.subArmsRange[1])
         {
            return "sub";
         }
         return "";
      }
      
      public function getConDefineArr() : Array
      {
         var m:* = undefined;
         var define0:OneArmsDefine = null;
         var arr0:Array = [];
         var n:* = this.armsRange[0];
         for(var n2:* = this.armsRange[1]; n <= n2; )
         {
            for(m in this.armsArr[n])
            {
               define0 = this.armsArr[n][m];
               if(define0.index >= 61 && define0.index <= 72)
               {
                  arr0.push(define0);
               }
            }
            n++;
         }
         return arr0;
      }
      
      public function toString() : *
      {
         var n:* = undefined;
         var m:* = undefined;
         var define0:OneArmsDefine = null;
         for(n in this.armsArr)
         {
            for(m in this.armsArr[n])
            {
               define0 = this.armsArr[n][m];
            }
         }
      }
   }
}

