package UI.change
{
   import body.define.OneArmsDefine;
   import body.hurt.HurtCount;
   import flash.display.Sprite;
   import flash.text.TextField;
   import gameAll.data.ArmsItemsData;
   import gameAll.data.GoodsItemsData;
   
   public class ArmsItemsTip extends Sprite
   {
      
      public var title_txt:TextField;
      
      public var titleTxt2:TextField;
      
      public var txt:TextField;
      
      public var dpsTxt:TextField;
      
      public var dpsTxt2:TextField;
      
      internal var colorArr:Array = [16777215,65280,1426687,12467964];
      
      public function ArmsItemsTip()
      {
         super();
         this.title_txt.autoSize = "center";
         this.title_txt.wordWrap = false;
         this.txt.autoSize = "left";
         this.txt.wordWrap = true;
         this.dpsTxt.autoSize = "left";
         this.dpsTxt.wordWrap = false;
         this.mouseChildren = false;
         this.mouseEnabled = false;
      }
      
      public function inData(aid:ArmsItemsData) : *
      {
         var define0:OneArmsDefine = aid.define;
         aid.fleshData();
         this.title_txt.text = define0.name;
         this.titleTxt2.x = this.title_txt.x + this.title_txt.width;
         this.title_txt.textColor = this.colorArr[aid.color];
         if(aid.strengLevel > 0)
         {
            this.titleTxt2.visible = true;
            this.titleTxt2.text = "+" + aid.strengLevel;
         }
         else
         {
            this.titleTxt2.visible = false;
         }
         this.dpsTxt.text = String(this.setPer(define0.getAllDps()));
         this.dpsTxt2.x = this.dpsTxt.width + this.dpsTxt.x;
         var str:String = "";
         var nolevelStr:String = "";
         if(define0.installLevel > Game.gameData.level + 1)
         {
            nolevelStr = this.getColor("（不足）","#FF0000");
         }
         str += this.getFontColor("基础战斗力：") + define0.baseDps + "<br />";
         str += this.getFontColor("武器类型：") + define0.type + "<br />";
         str += this.getFontColor("武器属性：") + HurtCount.getAttackCn(define0.attackType) + "<br />";
         if(define0.specialProperty != "")
         {
            str += this.getColor("特殊属性：" + define0.specialProperty,"#00FF00") + "<br />";
         }
         if(define0.specialType.indexOf("Level_Growth") >= 0)
         {
            str += this.getColor("原生成长：人物等级+" + aid.getNativeGrowthLevel(),"#66CCFF") + "<br />";
         }
         str += this.getColor("装备等级：" + define0.installLevel + "级","#993300") + nolevelStr + "<br />";
         str += this.getColor("武器等级：" + define0.commonLevel + "级","#FFFF00") + "<br />";
         if(aid.chipHole is GoodsItemsData && aid.chipHole.isPurpleChip())
         {
            var growth0:int = aid.chipHole.getPurpleGrowthLevel();
            var combinedGrowth0:int = aid.getNativeGrowthLevel() + growth0;
            var chipLevel0:int = Game.gameData.level + combinedGrowth0 + 1;
            if(!aid.allowsGrowthBeyond200())
            {
               chipLevel0 = Math.min(200,chipLevel0);
            }
            str += this.getColor("紫芯片共鸣：原生+" + aid.getNativeGrowthLevel() + "，芯片+" + growth0 + "，计算等级" + chipLevel0 + "级" + (chipLevel0 > define0.originalCommonLevel ? "（已生效）" : "（未超过武器原始等级）"),"#FF66FF") + "<br />";
         }
         str += this.getFontColor("武器伤害：") + int(define0.getAllDataHurt()) + "<br />";
         str += this.getFontColor("攻击速度：") + define0.getShootSpeed() + "发/秒<br />";
         if(define0.father == "arms")
         {
            str += this.getFontColor("能量总值：") + int(aid.maxEnergy) + "<br />";
            str += this.getFontColor("能量回复：") + int(aid.maxEnergyRate * 100) + "% 每秒<br />";
         }
         str += this.getColor(define0.description,"#FF66FF") + "<br />";
         str += this.getColor(aid.add.getInfo(),"#FF99FF");
         this.txt.htmlText = str;
      }
      
      public function setPer(num0:Number) : Number
      {
         if(num0 >= 100)
         {
            return int(Math.round(num0));
         }
         if(num0 >= 1)
         {
            return int(Math.round(num0));
         }
         return int(Math.round(num0));
      }
      
      public function inData_byDefine(define0:OneArmsDefine, specialType:String = "") : *
      {
         if(define0.specialType.indexOf("Level_Growth") >= 0)
         {
            define0.fleshData();
         }
         this.title_txt.htmlText = define0.name;
         this.titleTxt2.x = this.title_txt.x + this.title_txt.width;
         this.titleTxt2.visible = false;
         if(define0.itemsData.baseLabel == "")
         {
            this.titleTxt2.visible = true;
            this.titleTxt2.text = "基础";
         }
         else
         {
            this.titleTxt2.visible = false;
         }
         this.dpsTxt.text = String(this.setPer(define0.getAllDps()));
         this.dpsTxt2.x = this.dpsTxt.width + this.dpsTxt.x;
         var str:String = "";
         var nolevelStr:String = "";
         if(define0.installLevel > Game.gameData.level + 1)
         {
            nolevelStr = this.getColor("（不足）","#FF0000");
         }
         str += this.getFontColor("基础战斗力：") + define0.baseDps + "<br />";
         str += this.getFontColor("武器类型：") + define0.type + "<br />";
         str += this.getFontColor("武器属性：") + HurtCount.getAttackCn(define0.attackType) + "<br />";
         if(define0.specialProperty != "")
         {
            str += this.getColor("特殊属性：" + define0.specialProperty,"#00FF00") + "<br />";
         }
         if(define0.specialType.indexOf("Level_Growth") >= 0)
         {
            str += this.getColor("原生成长：人物等级+" + int(define0.specialType.split("_Growth_")[1]),"#66CCFF") + "<br />";
         }
         str += this.getColor("装备等级：" + define0.installLevel + "级","#993300") + nolevelStr + "<br />";
         str += this.getColor("武器等级：" + define0.commonLevel + "级","#FFFF00") + "<br />";
         if(define0.itemsData.baseLabel == "")
         {
            str += this.getFontColor("武器伤害：") + int(define0.getAllHurt()) + "<br />";
         }
         else
         {
            str += this.getFontColor("武器伤害：") + int(define0.getAllDataHurt()) + "<br />";
         }
         str += this.getFontColor("攻击速度：") + define0.getShootSpeed() + "发/秒<br />";
         if(define0.father == "arms")
         {
            str += this.getFontColor("能量总值：") + int(define0.energyUse) + "<br />";
            str += this.getFontColor("能量回复：") + int(define0.energyRate * 300) / 10 + "点/秒<br />";
         }
         str += this.getColor(define0.description,"#FF66FF") + "<br />";
         this.txt.htmlText = str;
      }
      
      private function getFontColor(str:String) : String
      {
         var _color1:String = "#CCCCCC";
         return "<font color=\'" + _color1 + "\'>" + str + "</font>";
      }
      
      private function getColor(str:String, _color1:String = "#999999") : String
      {
         return "<font color=\'" + _color1 + "\'>" + str + "</font>";
      }
   }
}

