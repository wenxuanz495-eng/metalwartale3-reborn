package gameAll.define.other
{
   import gameAll.define.ExtraDefine;
   
   public class DailySignDefine
   {
      
      private var _mustNum:Array = [2,5,10,17,26];
      
      public var allGift:Array = [];
      
      public var vipGift:Array = [];
      
      public function DailySignDefine()
      {
         super();
         var arr0:Array = [];
         arr0 = [];
         arr0.push("GCoin,\t\t\t200000,\t\t\t\t1");
         arr0.push("achieve,\t\t\t2000,\t\t\t\t2");
         arr0.push("materials,\t\tsuperalloy_X,\t\t20");
         arr0.push("props,\t\t\tjustice_badge,\t\t2");
         arr0.push("props,\t\t\tdisassemble_3,\t\t1");
         arr0.push("green_crystal,\t8,\t\t\t\t\t1");
         this.allGift.push(arr0);
         arr0 = [];
         arr0.push("GCoin,\t\t\t500000,\t\t\t\t1");
         arr0.push("achieve,\t\t\t5000,\t\t\t\t5");
         arr0.push("materials,\t\tsuperalloy_X,\t\t50");
         arr0.push("props,\t\t\tjustice_badge,\t\t5");
         arr0.push("props,\t\t\tdisassemble_3,\t\t2");
         arr0.push("green_crystal,\t8,\t\t\t\t\t2");
         this.allGift.push(arr0);
         arr0 = [];
         arr0.push("GCoin,\t\t\t1000000,\t\t\t1");
         arr0.push("achieve,\t\t\t10000,\t\t\t\t10");
         arr0.push("materials,\t\tsuperalloy_X,\t\t100");
         arr0.push("props,\t\t\tjustice_badge,\t\t10");
         arr0.push("props,\t\t\tdisassemble_3,\t\t3");
         arr0.push("green_crystal,\t8,\t\t\t\t\t3");
         this.allGift.push(arr0);
         arr0 = [];
         arr0.push("GCoin,\t\t\t1700000,\t\t\t1");
         arr0.push("achieve,\t\t\t17000,\t\t\t\t17");
         arr0.push("materials,\t\tsuperalloy_X,\t\t170");
         arr0.push("props,\t\t\tjustice_badge,\t\t17");
         arr0.push("props,\t\t\tdisassemble_3,\t\t4");
         arr0.push("green_crystal,\t8,\t\t\t\t\t4");
         this.allGift.push(arr0);
         arr0 = [];
         arr0.push("GCoin,\t\t\t2600000,\t\t\t1");
         arr0.push("achieve,\t\t\t26000,\t\t\t\t26");
         arr0.push("materials,\t\tsuperalloy_X,\t\t260");
         arr0.push("props,\t\t\tjustice_badge,\t\t26");
         arr0.push("props,\t\t\tdisassemble_3,\t\t5");
         arr0.push("green_crystal,\t8,\t\t\t\t\t5");
         this.allGift.push(arr0);
         arr0 = [];
         arr0.push("props,\tdisassemble_3,\t\t2");
         this.vipGift.push(arr0);
         arr0 = [];
         arr0.push("props,\tdisassemble_3,\t\t4");
         this.vipGift.push(arr0);
         arr0 = [];
         arr0.push("props,\tdisassemble_3,\t\t6");
         this.vipGift.push(arr0);
         arr0 = [];
         arr0.push("props,\tdisassemble_3,\t\t8");
         this.vipGift.push(arr0);
         arr0 = [];
         arr0.push("props,\tdisassemble_3,\t\t10");
         this.vipGift.push(arr0);
         ExtraDefine.swapToCode2(this.allGift);
         ExtraDefine.swapToCode2(this.vipGift);
         ExtraDefine.swapToCode(this._mustNum);
      }
      
      public function getMustNum() : Array
      {
         return ExtraDefine.swapToNumber(this._mustNum);
      }
      
      public function getGift_byIndex(index0:int) : *
      {
         return ExtraDefine.swapToText(this.allGift[index0]);
      }
      
      public function getVipGift_byIndex(index0:int) : *
      {
         return ExtraDefine.swapToText(this.vipGift[index0]);
      }
   }
}

