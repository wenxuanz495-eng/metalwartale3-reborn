package gameAll.define.property
{
   public class NormalPropertyDefineGroup
   {
      
      public var pro_arr:Array = [];
      
      public var obj:Object = {};
      
      public function NormalPropertyDefineGroup()
      {
         super();
      }
      
      public function inData_byXML(xml0:XML) : *
      {
         var n:* = undefined;
         var xml2:XML = null;
         var d0:NormalPropertyDefine = null;
         var pro_xml0:XMLList = xml0.property;
         for(n in pro_xml0)
         {
            xml2 = pro_xml0[n];
            d0 = new NormalPropertyDefine();
            d0.inData_byXML(xml2);
            this.obj[d0.name] = d0;
            this.pro_arr.push(d0.name);
         }
      }
      
      public function test() : *
      {
         for(var i:int = 1; i <= 20; i++)
         {
            trace("-----------------");
            trace(this.getText_byObj(this.getRandomObj(i,7,4)));
         }
      }
      
      public function getText_byObj(obj0:Object) : String
      {
         var i:* = undefined;
         var n:* = undefined;
         var index0:int = 0;
         var pro0:String = null;
         var d0:NormalPropertyDefine = null;
         var value0:Number = NaN;
         var valueString0:String = null;
         var str0:String = "";
         var loopNum0:int = 0;
         var pro_arr2:Array = this.pro_arr;
         var pro_arr3:Array = new Array(pro_arr2.length);
         for(i in obj0)
         {
            index0 = pro_arr2.indexOf(i);
            pro_arr3[index0] = i;
         }
         for(n in pro_arr3)
         {
            pro0 = pro_arr3[n];
            if(!(!pro0 || pro0 == ""))
            {
               d0 = this.obj[pro0];
               value0 = Number(obj0[pro0]);
               valueString0 = d0.getValueText(value0);
               str0 += "\n" + d0.cnName + valueString0;
               loopNum0++;
            }
         }
         if(loopNum0 == 0)
         {
            str0 = "";
         }
         else
         {
            str0 = str0.substr(1);
         }
         return str0;
      }
      
      public function getRandomObj(lv0:int, lvRange0:int, num0:int, maxB:Boolean = false) : Object
      {
         var index0:int = 0;
         var pro0:String = null;
         var value0:Number = NaN;
         var obj0:Object = {};
         var pro_arr2:Array = this.pro_arr.concat([]);
         for(var i:int = 0; i < num0; i++)
         {
            index0 = int(pro_arr2.length * Math.random());
            pro0 = pro_arr2[index0];
            pro_arr2.splice(index0,1);
            lv0 -= Math.random() * lvRange0;
            if(lv0 < 1)
            {
               lv0 = 1;
            }
            value0 = this.getRandomValue(pro0,lv0,maxB);
            obj0[pro0] = value0;
         }
         return obj0;
      }
      
      public function getDingzhiObj(lv0:int, lvRange0:int, num0:int, maxB:Boolean = false) : Object
      {
         var obj0:Object = {};
         obj0.allAdd = 0.35;
         obj0.attackAdd = 0.7;
         obj0.subAdd = 0.7;
         obj0.lifeAdd = 0.7;
         obj0.defence_mul = 0.7;
         obj0.life_value = 100000;
         obj0.life_max = 0.7;
         return obj0;
      }
      
      public function getRandomValue(pro0:String, lv0:int, maxB:Boolean = false) : Number
      {
         var d0:NormalPropertyDefine = this.obj[pro0];
         return d0.getRandomValue(lv0,maxB);
      }
      
      public function getRandomObj_before(b_obj0:Object, lv0:int, lvRange0:int, maxB:Boolean = false) : Object
      {
         var n:* = undefined;
         var pro0:String = null;
         var value0:Number = NaN;
         var obj0:Object = {};
         for(n in b_obj0)
         {
            pro0 = n;
            lv0 -= Math.random() * lvRange0;
            if(lv0 < 1)
            {
               lv0 = 1;
            }
            value0 = this.getRandomValue(pro0,lv0,maxB);
            obj0[pro0] = value0;
         }
         return obj0;
      }
   }
}

