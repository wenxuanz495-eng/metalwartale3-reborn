package UI.change
{
   import body.hero.CarDefine;
   import body.hurt.HurtCount;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.text.TextField;
   import gameAll.data.CarItemsData;
   import gameAll.data.car.CarDataCreator;
   import gameAll.high.HighArena_All;
   
   public class CarItemsTip extends Sprite
   {
      
      public var title_txt:TextField;
      
      public var txt:TextField;
      
      public function CarItemsTip()
      {
         super();
         this.txt.autoSize = "left";
         this.txt.wordWrap = true;
         this.mouseChildren = false;
         this.mouseEnabled = false;
      }
      
      public function inData(aid:CarItemsData, noDefenceTypeB:Boolean = false) : *
      {
         var define0:CarDefine = aid.getDefine();
         var carColor0:String = CarDataCreator.getColorColor(aid.color);
         if(!carColor0)
         {
            carColor0 = "#FFFFFF";
         }
         var title_str0:String = define0.name;
         if(define0.getType() != "G")
         {
            title_str0 += "(" + aid.getNowLevel() + ")";
         }
         var str02:String = this.getColor(title_str0,carColor0);
         if(aid.strengthenNum > 0)
         {
            str02 += this.getColor("+" + aid.strengthenNum + "","#FF33FF");
         }
         this.title_txt.htmlText = str02;
         var str:String = "";
         var nolevelStr:String = "";
         if(define0.installLevel > Game.gameData.level + 1)
         {
            nolevelStr = this.getColor("（不足）","#FF0000");
         }
         str += this.getFontColor("品质：") + this.getColor(CarDataCreator.getColorCn(aid.color),carColor0) + "<br />";
         str += this.getFontColor("装备等级：") + aid.getNowInstallLevel() + "级" + nolevelStr + "<br />";
         str += this.getFontColor("战车等级：") + aid.getNowLevel() + "级" + "<br />";
         str += this.getFontColor("当前耐久：") + aid.getNowLife() + "<br />";
         str += this.getFontColor("当前防御：") + aid.getNowDefence() + "<br />";
         if(!noDefenceTypeB)
         {
            str += this.getFontColor("防御类型：") + HurtCount.getDefenceCn(aid.getDefenceType()) + "<br />";
         }
         var extraStr0:String = aid.getExtraObjText();
         if(extraStr0 != "")
         {
            str += this.getColor("附加属性：","#FFFF00") + "<br />";
            str += this.getColor(extraStr0,"#FFFF00") + "<br />";
         }
         str += this.getColor(define0.description,"#FF66FF") + "<br />";
         this.txt.htmlText = str;
      }
      
      public function inData_byDefine(define0:CarDefine, specialType:String = "") : *
      {
         var da0:CarItemsData = new CarItemsData();
         da0.baseLabel = define0.id;
         da0.color = "green";
         this.inData(da0,true);
      }
      
      public function inData_byHighArena_All(d0:HighArena_All) : *
      {
         this.title_txt.text = d0.extra.name;
         var str:String = "";
         str += this.getColor("积分：" + d0.score,"#FFFF00") + "<br />";
         var nolevelStr:String = this.getColor("(比你高)","#FF0000");
         var dps0:Number = Game.gameData.getAllDps();
         if(d0.extra.dps < dps0)
         {
            nolevelStr = this.getColor("(比你低)","#00FF00");
         }
         else if(d0.extra.dps == dps0)
         {
            nolevelStr = this.getColor("(打平)","#00FFFF");
         }
         str += this.getColor("战斗力：" + d0.extra.dps,"#FF66FF") + nolevelStr + "<br />";
         str += this.getFontColor("耐久值：") + d0.extra.life + "<br />";
         str += this.getFontColor("防御值：") + d0.extra.defence;
         this.txt.htmlText = str;
      }
      
      public function inData_bySkill(btn0:SimpleButton) : *
      {
         trace("显示：" + btn0.name);
         var str:String = "sdfasdfadsf";
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

