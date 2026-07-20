package gameAll.data.car
{
   import body.hero.CarDefine;
   import body.hurt.HurtCount;
   import gameAll.data.CarItemsData;
   import items.ItemsBody;
   
   public class CarDataCreator
   {
      
      public static var colorArr:Array = ["white","blue","yellow","orange","green"];
      
      public static var colorCnArr:Array = ["白色","蓝色","金色","橙色","绿色","紫色"];
      
      public static var colorNumArr:Array = [[0],[2,4],[3,5],[5,7],[7],[7]];
      
      public static var colorMulArr:Array = [1,1.2,1.5,1.8,2.8,2.8];
      
      public static var colorColorArr:Array = ["#FFFFFF","#00FFFF","#FFFF00","#FF6600","#00FF00","#FF33FF"];
      
      public function CarDataCreator()
      {
         super();
      }
      
      public static function test() : *
      {
         for(var i:int = 0; i < 10; i++)
         {
            trace(getColorNum("blue"));
         }
      }
      
      public static function hitAddData(items0:ItemsBody) : *
      {
         var da0:CarItemsData = null;
         var lv0:int = items0.define.affixLevel + 1;
         var lv2:int = lv0 - Math.random() * 5;
         if(lv2 < 1)
         {
            lv2 = 1;
         }
         var enemyType0:String = items0.enemyType;
         var d0:CarDefine = Game.defineGroup.getCarDefine_byInstallLevel(lv2,"G");
         if(Boolean(d0))
         {
            da0 = Game.gameData.carItems.addItems(d0.id,true,null);
            if(!(Game.LG.state == "specialExtra" && Game.LG.index == 10))
            {
               setNormalData(da0,lv2,enemyType0);
            }
            return;
         }
         throw new Error("没找到等级" + lv2 + "的G币车。");
      }
      
      public static function getNormalData(lv0:int, color0:String) : CarItemsData
      {
         var d0:CarDefine = Game.defineGroup.getCarDefine_byInstallLevel(lv0,"G");
         var da0:CarItemsData = new CarItemsData();
         if(Boolean(d0))
         {
            da0.baseLabel = d0.id;
            setNormalData(da0,lv0,"super",color0);
            return da0;
         }
         throw new Error("没找到等级" + lv0 + "的G币车。");
      }
      
      public static function setNormalData(da0:CarItemsData, lv0:int, enemyType0:String, setColor0:String = "") : *
      {
         var defence0:String = null;
         var carColor:String = Game.gameDefine.drop.getCarColorType(enemyType0,Game.gameData.nowDifficult);
         if(setColor0 != "")
         {
            carColor = setColor0;
         }
         var d_arr0:Array = HurtCount.defence_type;
         defence0 = d_arr0[int(d_arr0.length * Math.random())];
         var num0:int = getColorNum(carColor);
         var obj0:Object = Game.newDG.car.getRandomObj(lv0,9,num0);
         da0.affixLevel = lv0;
         da0.color = carColor;
         da0.extraObj = obj0;
         da0.defenceType = defence0;
      }
      
      public static function setShopData(da0:CarItemsData, levelRange0:int = 9) : *
      {
         var lv0:int = da0.getNowLevel();
         var carColor:String = "green";
         var d_arr0:Array = HurtCount.defence_type;
         var defence0:String = d_arr0[int(d_arr0.length * Math.random())];
         var num0:int = getColorNum(carColor);
         var obj0:Object = Game.newDG.car.getRandomObj(lv0,levelRange0,num0,true);
         if(da0.getDefine().isCustom())
         {
            obj0 = Game.newDG.car.getDingzhiObj(lv0,levelRange0,num0,true);
         }
         da0.affixLevel = lv0;
         da0.color = carColor;
         da0.extraObj = obj0;
         da0.defenceType = defence0;
      }
      
      public static function setExchangeData(da0:CarItemsData, levelRange0:int = 9, color:String = "green") : *
      {
         var lv0:int = da0.getNowLevel();
         var carColor:String = color;
         var d_arr0:Array = HurtCount.defence_type;
         var defence0:String = d_arr0[int(d_arr0.length * Math.random())];
         var num0:int = getColorNum(carColor);
         var obj0:Object = Game.newDG.car.getRandomObj(lv0,levelRange0,num0,true);
         da0.affixLevel = lv0;
         da0.color = carColor;
         da0.extraObj = obj0;
         da0.defenceType = defence0;
      }
      
      public static function setCustomData(da0:CarItemsData) : *
      {
         setShopData(da0,0);
         da0.strengthenNum = da0.getMaxStrengthenLevel();
      }
      
      public static function setUpgradeData(da0:CarItemsData) : *
      {
         da0.affixLevel = da0.getNowLevel();
         da0.extraObj = Game.newDG.car.getRandomObj_before(da0.extraObj,da0.affixLevel,0,true);
      }
      
      public static function getColorNum(color0:String) : int
      {
         var index0:int = colorArr.indexOf(color0);
         var arr0:Array = colorNumArr[index0];
         if(arr0.length == 1)
         {
            return arr0[0];
         }
         return int(arr0[0] + Math.random() * (arr0[1] - arr0[0] + 1));
      }
      
      public static function getColorCn(color0:String) : String
      {
         var index0:int = colorArr.indexOf(color0);
         return colorCnArr[index0];
      }
      
      public static function getColorCEn(color0:String) : String
      {
         var index0:int = colorCnArr.indexOf(color0);
         return colorArr[index0];
      }
      
      public static function getColorColor(color0:String) : String
      {
         var index0:int = colorArr.indexOf(color0);
         return colorColorArr[index0];
      }
      
      public static function getColorMul(color0:String) : Number
      {
         var index0:int = colorArr.indexOf(color0);
         return colorMulArr[index0];
      }
   }
}

