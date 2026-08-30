package gameAll.honor
{
   import gameAll.data.AdditionalData;
   
   public class HonorData
   {
      
      public var honor_arr:Array = [];
      
      public var nowHonor:String = "no";

      public var add:AdditionalData = new AdditionalData();
      
      public var ac:AchievementData = new AchievementData();
      
      public function HonorData()
      {
         super();
      }
      
      public function init() : *
      {
         this.honor_arr.length = 0;
         this.addHonor("no");
         this.addHonor("superalloy_hero");
         this.nowHonor = "no";
         this.add.clearData();
         this.ac.init();
      }
      
      public function fleshAdd() : *
      {
         var m:* = undefined;
         var add_name0:String = null;
         var nameArr0:Array = null;
         var num0:Number = NaN;
         this.add.clearData();
         var d0:OneHonorDefine = this.getData(this.nowHonor);
         if(Boolean(d0))
         {
            for(m in d0.add)
            {
               add_name0 = d0.add[m];
               nameArr0 = add_name0.split("+");
               num0 = Number(nameArr0[1]);
               if(num0 > 0)
               {
                  this.add[nameArr0[0]] += num0;
               }
            }
         }
      }
      
      public function addHonor(name0:String) : *
      {
         var d0:OneHonorDefine = this.getDefine(name0);
         if(Boolean(d0))
         {
            this.honor_arr.push(d0.copy());
         }
      }
      
      public function addHonorDefine(d0:OneHonorDefine) : *
      {
         if(Boolean(d0))
         {
            this.honor_arr.push(d0.copy());
         }
      }
      
      public function inData_byObj(obj:Object) : *
      {
         var n:* = undefined;
         var m:* = undefined;
         var pro0:String = null;
         var data0:OneHonorDefine = null;
         var d0:OneHonorDefine = null;
         var pro_arr:Array = ["nowHonor"];
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            this[pro0] = obj[pro0];
         }
         this.honor_arr.length = 0;
         for(m in obj.honor_arr)
         {
            data0 = new OneHonorDefine();
            data0.inData_byObj(obj.honor_arr[m]);
            d0 = this.getDefine(data0.name);
            if(d0 is OneHonorDefine)
            {
               data0.inData_byObj(d0);
            }
            this.honor_arr.push(data0);
         }
         if(this.getData("no") == null)
         {
            this.addHonor("no");
         }
         if(this.getData("superalloy_hero") == null)
         {
            this.addHonor("superalloy_hero");
         }
         if(obj.hasOwnProperty("ac"))
         {
            this.ac.inData_byObj(obj.ac);
         }
         else
         {
            this.ac.init();
         }
      }
      
      public function getArray2() : Array
      {
         var n:* = undefined;
         var d0:OneHonorDefine = null;
         var arr0:Array = Game.gameDefine.honor.honor_arr;
         var arr2:Array = [];
         for(n in arr0)
         {
            d0 = arr0[n];
            if(this.getData(d0.name) == null)
            {
               arr2.push(d0);
            }
         }
         return arr2;
      }
      
      public function getData(name0:String) : OneHonorDefine
      {
         var n:* = undefined;
         var data0:OneHonorDefine = null;
         for(n in this.honor_arr)
         {
            data0 = this.honor_arr[n];
            if(data0.name == name0)
            {
               return data0;
            }
         }
         return null;
      }
      
      public function getDefine(name0:String) : OneHonorDefine
      {
         return Game.gameDefine.honor.getDefine(name0);
      }
      
      public function getNowDefine() : OneHonorDefine
      {
         return this.getData(this.nowHonor);
      }
      
      public function getNowHonorName() : String
      {
         var d0:OneHonorDefine = this.getNowDefine();
         if(Boolean(d0))
         {
            return d0.cnName;
         }
         return "无";
      }

      public function checkWeaponMasterHonor(showTip:Boolean = true) : Boolean
      {
         var cutter:* = undefined;
         var darkpower:* = undefined;
         var conArr:Array = null;
         var n:* = undefined;
         var conArms:* = undefined;
         var conMaxB:Boolean = false;
         if(this.getData("su_xunzong") != null || Game.gameData == null)
         {
            return false;
         }
         cutter = Game.gameData.subItems.getItemsByBase("cutter",false);
         darkpower = Game.gameData.subItems.getItemsByBase("darkpower",false);
         if(cutter == null || cutter.getResearchMaxLevel() < 5 || darkpower == null || darkpower.getResearchMaxLevel() < 2)
         {
            return false;
         }
         conArr = Game.gameData.armsItems.getConArms();
         for(n in conArr)
         {
            conArms = conArr[n];
            if(conArms.strengLevel >= 35)
            {
               conMaxB = true;
               break;
            }
         }
         if(!conMaxB)
         {
            return false;
         }
         this.addHonor("su_xunzong");
         if(showTip)
         {
            Game.uiGroup.checkTip.showCheck2("已获得新称号：苏勋宗\n勋章收集大师。你滴勋皇，无限猖狂！！！",2);
         }
         return true;
      }
   }
}

