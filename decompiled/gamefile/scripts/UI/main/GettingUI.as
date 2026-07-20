package UI.main
{
   import gameAll.data.GameData;
   import gameAll.data.GoodsItemsDataGroup;
   import items.ItemsDefine;
   
   public class GettingUI
   {
      
      public function GettingUI()
      {
         super();
      }
      
      public function getTxt(num0:int) : String
      {
         var str0:String = "";
         var xstr0:String = "\n<font color=\'#FFFF00\'>20个超合金X</font>";
         if(num0 == 0)
         {
            str0 += "10000 G币";
         }
         else if(num0 == 1)
         {
            str0 += "20000 G币";
            str0 += "\n2个超合金Z";
         }
         else if(num0 == 2)
         {
            str0 += "40000 G币";
            str0 += "\n4个超合金Z";
         }
         else if(num0 == 3)
         {
            str0 += "80000 G币";
            str0 += "\n6个超合金Z";
         }
         else if(num0 == 4)
         {
            str0 += "160000 G币";
            str0 += "\n8个超合金Z";
         }
         else if(num0 == 5)
         {
            str0 += "240000 G币";
            str0 += "\n10个超合金Z";
         }
         else if(num0 == 6)
         {
            str0 += "360000 G币";
            str0 += "\n20个超合金Z";
            xstr0 = "\n<font color=\'#FFFF00\'>30个超合金X</font>";
         }
         return str0 + xstr0;
      }
      
      public function getGift(num0:int) : *
      {
         var crystal_arr:Array = ["purple","green","red","yellow"];
         var crystal_name:String = crystal_arr[int(crystal_arr.length * Math.random())] + "_crystal";
         var affixLevel0:int = Game.gameData.level - 4 + Math.random() * 7;
         if(affixLevel0 < 0)
         {
            affixLevel0 = 0;
         }
         var gidg:GoodsItemsDataGroup = Game.gameData.materialsItems;
         var GD:GameData = Game.gameData;
         if(gidg.getSurplus() < 4)
         {
            Game.uiGroup.checkTip.showCheck2("材料背包必须有至少4个空位，才能领取奖励。",2,null,null,2);
            Game.SG.playSound("failureItems");
            return;
         }
         if(num0 == 0)
         {
            GD.addCoin(10000);
         }
         else if(num0 == 1)
         {
            GD.addCoin(20000);
            GD.materialsItems.addItems("superalloy_Z",2);
         }
         else if(num0 == 2)
         {
            GD.addCoin(40000);
            GD.materialsItems.addItems("superalloy_Z",4);
         }
         else if(num0 == 3)
         {
            GD.addCoin(80000);
            GD.materialsItems.addItems("superalloy_Z",6);
         }
         else if(num0 == 4)
         {
            GD.addCoin(160000);
            GD.materialsItems.addItems("superalloy_Z",8);
         }
         else if(num0 == 5)
         {
            GD.addCoin(240000);
            GD.materialsItems.addItems("superalloy_Z",10);
            GD.materialsItems.addItems("yellow_chip",1,affixLevel0);
         }
         else if(num0 == 6)
         {
            GD.addCoin(360000);
            GD.materialsItems.addItems("superalloy_Z",20);
            GD.materialsItems.addItems("superalloy_X",10);
         }
         GD.materialsItems.addItems("superalloy_X",20);
         Game.uiGroup.checkTip.showTip("领取成功！",1);
         Game.SG.playSound("upgradeArms");
         Game.uiGroup.infoUI.fleshData();
         Game.timeDate.getLoginGift();
      }
      
      public function rankGiftClick(e:* = null) : *
      {
         var crystal_arr:Array = null;
         var crystal_name:String = null;
         var affixLevel0:int = 0;
         var rankLevel:int = 0;
         var arr2:Array = null;
         var arr1:Array = null;
         var str1:String = null;
         var num0:int = 0;
         var name0:String = null;
         var showTextStr:String = null;
         var arr10:Array = null;
         var d0:ItemsDefine = null;
         var crystal_name2:String = null;
         var chip_name2:String = null;
         var level00:int = 0;
         var gidg:GoodsItemsDataGroup = Game.gameData.materialsItems;
         if(gidg.getSurplus() < 2)
         {
            Game.uiGroup.checkTip.showCheck2("材料背包必须有至少2个空位，才能领取奖励。",2,null,null,2);
            Game.SG.playSound("failureItems");
            return;
         }
         crystal_arr = ["purple","green","red","yellow"];
         crystal_name = crystal_arr[int(crystal_arr.length * Math.random())];
         affixLevel0 = Game.gameData.level - 4 + Math.random() * 7;
         if(affixLevel0 < 0)
         {
            affixLevel0 = 0;
         }
         rankLevel = Game.gameData.rankLevel;
         arr2 = Game.gameDefine.rankGift;
         arr1 = arr2[rankLevel - 4];
         str1 = arr1[int(arr1.length * Math.random())];
         trace("随机到一个：" + str1);
         num0 = 0;
         name0 = "";
         showTextStr = "";
         if(str1.indexOf("random_") >= 0)
         {
            num0 = int(str1.split("_")[1]);
            arr10 = Game.itemsDefineGroup.getArr_byOneLevel("material",Game.gameData.level);
            d0 = arr10[int(arr10.length * Math.random())];
            name0 = d0.name;
            Game.gameData.materialsItems.addItems(name0,num0);
            showTextStr = num0 + " 个 " + d0.cnName;
         }
         else if(str1.indexOf("z_") >= 0)
         {
            num0 = int(str1.split("_")[1]);
            Game.gameData.materialsItems.addItems("superalloy_Z",num0);
            showTextStr = num0 + " 个 超合金Z";
         }
         else if(str1.indexOf("crystal_") >= 0)
         {
            num0 = int(str1.split("_")[2]);
            crystal_name2 = str1.split("_")[0] + "_" + str1.split("_")[1];
            name0 = Game.gameData.materialsItems.addItems(crystal_name + "_" + crystal_name2,num0).cnName;
            showTextStr = num0 + " 个 " + name0;
         }
         else if(str1.indexOf("chip_") >= 0)
         {
            num0 = int(str1.split("_")[2]);
            chip_name2 = str1.split("_")[0] + "_" + str1.split("_")[1];
            level00 = Game.gameData.level - 4 + 5 * Math.random();
            if(level00 < 0)
            {
               level00 = 1;
            }
            if(num0 == 2)
            {
               name0 = Game.gameData.materialsItems.addItems(chip_name2,1,level00).cnName;
               Game.gameData.materialsItems.addItems(chip_name2,1,level00);
            }
            else if(num0 == 1)
            {
               name0 = Game.gameData.materialsItems.addItems(chip_name2,1,level00).cnName;
            }
            showTextStr = num0 + " 个 " + name0;
         }
         else
         {
            num0 = int(str1);
            Game.gameData.addCoin(num0);
            showTextStr = num0 + " G币 ";
         }
         Game.timeDate.getRankGift();
         Game.gameData.rankAdd.rankGiftB = true;
         Game.uiGroup.rankUI.fleshData();
         Game.uiGroup.checkTip.showCheck2("领取成功！你获得了：\n" + showTextStr,2,null,null,1);
         Game.SG.playSound("upgradeArms");
         Game.uiGroup.infoUI.fleshData();
         Game.uiGroup.saveDataNoUI();
      }
   }
}

