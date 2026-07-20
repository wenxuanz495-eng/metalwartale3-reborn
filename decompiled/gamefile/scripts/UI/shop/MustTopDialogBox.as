package UI.shop
{
   import gameAll.NormalMustDefine;
   
   public class MustTopDialogBox extends TopDialogBox
   {
      
      public var nowGCoin:Number = 0;
      
      public var nowMCoin:int = 0;
      
      public var nowLevel:int = 0;
      
      public var nowRankLevel:int = 0;
      
      public function MustTopDialogBox()
      {
         super();
      }
      
      public function showMustCheck(mustDefine:NormalMustDefine, str0:String, yesFun0:Function = null, noFun0:Function = null, mustText:String = "") : *
      {
         this.nowMCoin = Game.gameData.MCoin;
         this.nowGCoin = Game.gameData.GCoin;
         this.nowLevel = Game.gameData.level;
         this.nowRankLevel = Game.gameData.rankLevel;
         var btnState0:int = 1;
         var yesFun:Function = yesFun0;
         var str1:String = "";
         var str2:String = "";
         var str_level:String = "";
         var nostr1:String = "";
         var nostr2:String = "";
         if(mustDefine.mustLevel > 0 && mustDefine.mustLevel > this.nowLevel)
         {
            str_level = "  " + mustText + "人物等级：" + "<font color=\'#FFFF00\'>" + (mustDefine.mustLevel + 1) + "</font><font color=\'#FF0000\'>（不足)</font>" + "  ";
            btnState0 = 3;
         }
         if(mustDefine.mustRankLevel > 0 && mustDefine.mustRankLevel > this.nowRankLevel)
         {
            str_level += "  " + mustText + "军衔：" + "<font color=\'#FFFF00\'>" + Game.gameDefine.getRankName(mustDefine.mustRankLevel) + "</font><font color=\'#FF0000\'>（不足)</font>" + "  ";
            btnState0 = 3;
         }
         if(mustDefine.GCoin > 0)
         {
            if(this.nowGCoin < mustDefine.GCoin)
            {
               nostr1 = "<font color=\'#FF0000\'>（不足)</font>";
               btnState0 = 3;
               yesFun = null;
            }
            str1 = "  " + mustText + "G币：" + "<font color=\'#FFFF00\'>" + mustDefine.GCoin + "</font>" + nostr1 + "  ";
         }
         if(mustDefine.MCoin > 0)
         {
            if(this.nowMCoin < mustDefine.MCoin)
            {
               nostr2 = "<font color=\'#FF0000\'>（不足)</font>";
               btnState0 = 4;
               yesFun = null;
            }
            str2 = "  " + mustText + "M币：" + "<font color=\'#FFFF00\'>" + mustDefine.MCoin + "</font>" + nostr2 + "  ";
         }
         var str3:String = str_level + str1 + str2;
         showCheck2(str0 + "\n" + str3,btnState0,yesFun,noFun0);
      }
   }
}

