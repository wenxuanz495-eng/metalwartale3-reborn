package UI.items
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import gameAll.data.AdditionalData;
   import gameAll.data.GoodsItemsData;
   import items.ItemsDefine;
   
   public class ItemsInfoTip extends Sprite
   {
      
      public var title_txt:TextField;
      
      public var titleTxt2:TextField;
      
      public var txt:TextField;
      
      public var dpsTxt:TextField;
      
      public var dpsTxt2:TextField;
      
      internal var colorArr:Array = ["#FFFFFF","#00FFFF","#FFFF00","#FF6600","#66FF00"];
      
      public function ItemsInfoTip()
      {
         super();
         this.mouseChildren = false;
         this.mouseEnabled = false;
         this.title_txt.autoSize = "center";
         this.title_txt.wordWrap = false;
         this.txt.autoSize = "left";
         this.txt.wordWrap = true;
      }
      
      public function inData(aid:GoodsItemsData) : *
      {
         var add0:AdditionalData = null;
         var define0:ItemsDefine = aid.getDefine();
         this.title_txt.htmlText = this.getFontColor(aid.cnName,this.colorArr[define0.dropLevel - 1]);
         this.titleTxt2.x = this.title_txt.x + this.title_txt.width;
         if(aid.type == "chip")
         {
            this.titleTxt2.text = aid.affixLevel + 1 + "级";
         }
         else
         {
            this.titleTxt2.text = "";
         }
         var str0:String = "";
         str0 += this.getFontColor(define0.description,"#CCCCCC") + "\n";
         if(aid.type != "card")
         {
            str0 += this.getFontColor("\n价格：","#FFFF00") + aid.getSellPrice() + " G币";
         }
         if(aid.addArr.length > 0)
         {
            add0 = new AdditionalData();
            add0.inData_byArr(aid.addArr);
            str0 += this.getFontColor("\n装备后效果：\n","#FFFF00") + this.getFontColor(add0.getInfo(),"#FF99FF") + "\n";
         }
         this.txt.htmlText = str0;
      }
      
      public function inData_byDefine(define0:ItemsDefine, shopChipShowB:Boolean = false, specialType:String = "", showRandomB:Boolean = false) : *
      {
         var nowLevel0:int = 0;
         var minLevel0:int = 0;
         var add0:AdditionalData = null;
         if(showRandomB)
         {
            this.showRandom();
            return;
         }
         if(specialType.indexOf("offlineMCoin:") == 0)
         {
            this.showMCoinFast(specialType.split(":")[1]);
            return;
         }
         if(int(specialType) > 0)
         {
            this.showFast(define0,specialType);
            return;
         }
         this.titleTxt2.x = this.title_txt.x + this.title_txt.width;
         this.titleTxt2.text = "";
         var affixLevelText0:String = "";
         if(define0.type == "chip")
         {
            if(define0.affixLevel >= 1)
            {
               this.titleTxt2.text = define0.affixLevel + 1 + "级";
               affixLevelText0 = this.titleTxt2.text;
            }
         }
         this.title_txt.text = affixLevelText0 + define0.cnName;
         this.titleTxt2.text = "";
         var str0:String = "";
         str0 += this.getFontColor(define0.description,"#CCCCCC") + "\n";
         if(shopChipShowB)
         {
            if(define0.name.indexOf("_chip") > 0)
            {
               nowLevel0 = Game.gameData.level + 1;
               minLevel0 = nowLevel0 - 4;
               if(minLevel0 < 1)
               {
                  minLevel0 = 1;
               }
               str0 += this.getFontColor("芯片等级与你的人物等级相关，当前芯片等级在" + minLevel0 + "~" + (nowLevel0 + 6) + "级之间。","#FF72FF") + "\n";
            }
         }
         if(define0.addArr.length > 0)
         {
            add0 = new AdditionalData();
            add0.inData_byArr(define0.addArr);
            str0 += this.getFontColor(add0.getInfo(),"#FF99FF") + "\n";
         }
         this.txt.htmlText = str0;
      }

      public function showMCoinFast(value0:String) : *
      {
         this.title_txt.text = "直接获得M币";
         this.titleTxt2.text = "";
         this.txt.htmlText = "直接获得 " + value0 + " M币";
      }
      
      public function showFast(define0:ItemsDefine, specialType:String = "") : *
      {
         var title0:String = "";
         var back0:String = "";
         if(define0.name == "GCoin_card_4")
         {
            title0 = "直接获得G币";
            back0 = "G币";
         }
         else if(define0.name == "exp_card_directly")
         {
            title0 = "直接获得经验值";
            back0 = "经验值";
         }
         this.title_txt.text = title0;
         this.titleTxt2.text = "";
         var str0:String = "" + "直接获得 " + specialType + " " + back0;
         this.txt.htmlText = str0;
      }
      
      public function showRandom() : *
      {
         this.title_txt.text = "随机材料";
         this.titleTxt2.text = "";
         var str0:String = "根据人物等级获得随机材料";
         this.txt.htmlText = str0;
      }
      
      private function getFontColor(str:String, _color1:String = "#999999") : String
      {
         return "<font color=\'" + _color1 + "\'>" + str + "</font>";
      }
   }
}

