package body.define
{
   import flash.geom.Rectangle;
   import gameAll.level.EnemyLevelDefine;
   
   public class LifeBodyDefine
   {
      
      public var level:int = 0;
      
      public var id:String = "";
      
      public var name:String = "";
      
      public var trueName:String = "";
      
      public var hitRect:Rectangle = new Rectangle();
      
      public var hurtRectArr:Array = [];
      
      public var baseLife:Number = 1;
      
      public var _maxLife:Number = 1;
      
      public var baseExp:Number = 0;
      
      public var exp:Number = 0;
      
      public var baseCoin:Number = 0;
      
      public var coin:Number = 0;
      
      public var life_0:Number = 1;
      
      public var _hurt_0:Number = 1;
      
      public var coin_0:Number = 1;
      
      public var exp_0:Number = 1;
      
      public var dropItemsArr:Array = [];
      
      public var fleshB:Boolean = false;
      
      public var defenceType:String = "mixed";
      
      public var defenceValue:int = 0;
      
      public var _nowLife:Number = this.baseLife;
      
      public var isBossB:Boolean = false;
      
      public function LifeBodyDefine()
      {
         super();
      }
      
      public function setLevel(num:int) : *
      {
         this.level = num;
         if(!this.fleshB)
         {
            this.fleshAll_byLevel();
         }
      }
      
      public function fleshAll_byLevel() : *
      {
         var GD:* = Game.gameDefine;
         var levelPack0:String = Game.gameData.newLevelData.getBeforeLevelPackNow(Game.LG.index);
         var d_ra:Number = Game.LG.filter.getDifficultRaNow();
         if(Game.LG.state == "extra" || Game.LG.state == "weekExtra")
         {
            d_ra = Game.gameData.extraData.nowDiff + 1;
         }
         else if(Game.LG.state == "specialExtra")
         {
            d_ra = 1;
         }
         var baseD:EnemyLevelDefine = Game.LG.filter.getEnemyLevelDefine(this.level + 1);
         var life_ra:Number = Number(Game.LG.level.enemyLife_ra);
         var exp_ra:Number = Number(Game.LG.level.enemyExp_ra);
         var coin_ra:Number = Number(Game.LG.level.enemyCoin_ra);
         var hurt_ra:Number = Number(Game.LG.level.enemyHurt_ra);
         this.life_0 = baseD.baseLife * life_ra * d_ra;
         this.exp_0 = baseD.baseExp * exp_ra;
         this.coin_0 = baseD.baseCoin * coin_ra;
         this.hurt_0 = baseD.baseAttack * hurt_ra * d_ra;
         this.fleshAll_by(this.life_0,this.exp_0,this.coin_0,this.hurt_0);
         var text1:String = this.name + "   等级：" + (this.level + 1) + "  难度系数：" + d_ra;
         var text0:String = "  生命基数：" + int(this.life_0) + " 攻击基数：" + int(this.hurt_0) + "    经验基数：" + int(this.exp_0) + "   金币基数：" + int(this.coin_0);
         Game.uiGroup.gamingUI.addTestText(text1);
         Game.uiGroup.gamingUI.addTestText(text0);
      }
      
      public function fleshAll_by(life0:Number, exp0:Number, coin0:Number, hurt0:Number, _fleshB:Boolean = false) : *
      {
         var pro0:Number = this.nowLife / this.maxLife;
         this.life_0 = life0;
         this.hurt_0 = hurt0;
         this.exp_0 = exp0;
         this.coin_0 = coin0;
         this.maxLife = this.life_0 * this.baseLife;
         var levelPack0:String = Game.gameData.newLevelData.getBeforeLevelPackNow(Game.LG.index);
         this.exp = this.exp_0 * this.baseExp;
         this.coin = this.coin_0 * this.baseCoin;
         this.fleshB = _fleshB;
         this.nowLife = this.maxLife * pro0;
      }
      
      public function set maxLife(value:Number) : *
      {
         this._maxLife = value / 57;
      }
      
      public function get maxLife() : Number
      {
         return this._maxLife * 57;
      }
      
      public function set nowLife(value:Number) : *
      {
         this._nowLife = value / 57;
      }
      
      public function get nowLife() : Number
      {
         return this._nowLife * 57;
      }
      
      public function set hurt_0(value:Number) : *
      {
         this._hurt_0 = value;
      }
      
      public function get hurt_0() : Number
      {
         return this._hurt_0;
      }
      
      public function mulLife(value:Number = 1) : *
      {
         this.maxLife *= value;
         this.nowLife = this.maxLife;
      }
      
      public function addLifePer(value:Number) : *
      {
         var pro0:Number = this.nowLife / this.maxLife;
         pro0 += value;
         if(pro0 < 0)
         {
            pro0 = 0;
         }
         if(pro0 > 1)
         {
            pro0 = 1;
         }
         this.nowLife = this.maxLife * pro0;
      }
      
      public function getLifePer() : Number
      {
         return this.nowLife / this.maxLife;
      }
      
      public function inData_byXML(xml0:XML) : *
      {
         var n:* = undefined;
         var hitr:Array = null;
         var hurtRect:Rectangle = null;
         this.id = String(xml0.@id);
         this.name = String(xml0.child("name"));
         this.baseLife = Number(xml0.baseLife);
         this.baseExp = Number(xml0.baseExp);
         this.baseCoin = Number(xml0.baseCoin);
         this.defenceType = String(xml0.defenceType);
         var hitRectArr:Array = String(xml0.hitRect).split(",");
         this.hitRect.x = hitRectArr[0];
         this.hitRect.y = hitRectArr[1];
         this.hitRect.width = hitRectArr[2];
         this.hitRect.height = hitRectArr[3];
         var hitXML:* = xml0.hurtRect;
         for(n in hitXML)
         {
            hitr = String(hitXML[n]).split(",");
            hurtRect = new Rectangle();
            hurtRect.x = int(hitr[0]);
            hurtRect.y = int(hitr[1]);
            hurtRect.width = int(hitr[2]);
            hurtRect.height = int(hitr[3]);
            this.hurtRectArr[n] = hurtRect;
         }
         if(xml0.hitRect.length() > 1)
         {
            throw new Error("怪物：" + this.name + "的hitRect数量不能超过1个。");
         }
      }
      
      public function getDiff(diff0:int) : Number
      {
         var arr0:Array = [0.8,1.6,2.4,3.2];
         return arr0[diff0];
      }
      
      public function getUnit(str:String) : *
      {
         if(str == "悬浮自动激光炮台")
         {
            return 0.4;
         }
         if(str == "悬浮自动激光炮台2号")
         {
            return 0.4;
         }
         if(str == "蓝光飞碟")
         {
            return 1;
         }
         if(str == "游隼战机")
         {
            return 1.4;
         }
         if(str == "天隼战机")
         {
            return 1.6;
         }
         if(str == "女妖战机")
         {
            return 4;
         }
         if(str == "女妖战机2")
         {
            return 4;
         }
         if(str == "电锯机器人")
         {
            return 1.2;
         }
         if(str == "突击者")
         {
            return 4;
         }
         if(str == "杀戮者")
         {
            return 4;
         }
         if(str == "自爆蜘蛛机")
         {
            return 0.3;
         }
         if(str == "自动钻机")
         {
            return 0.5;
         }
         if(str == "超级自动钻机")
         {
            return 0.7;
         }
         if(str == "切割者")
         {
            return 1.5;
         }
         if(str == "冲刺者")
         {
            return 1.2;
         }
         if(str == "鸵鸟机器人")
         {
            return 1.6;
         }
         if(str == "追踪者")
         {
            return 1.6;
         }
         if(str == "追猎者")
         {
            return 1.6;
         }
         if(str == "攻城坦克")
         {
            return 4;
         }
         if(str == "冲锋坦克")
         {
            return 2;
         }
         if(str == "飞轮机器人")
         {
            return 4;
         }
         if(str == "蜘蛛炮台")
         {
            return 1;
         }
         if(str == "碾压者")
         {
            return 4;
         }
         if(str == "强袭者")
         {
            return 4;
         }
         if(str == "仲裁者")
         {
            return 4;
         }
         if(str == "判决者")
         {
            return 4;
         }
         if(str == "炮装审判者")
         {
            return 4;
         }
         if(str == "剑装审判者")
         {
            return 4;
         }
         if(str == "地面自动炮台")
         {
            return 1;
         }
         if(str == "警报塔")
         {
            return 1;
         }
         if(str == "原子塔")
         {
            return 4;
         }
         if(str == "原子反应堆")
         {
            return 4;
         }
         if(str == "巨型压路机")
         {
            return 999;
         }
         if(str == "叛军")
         {
            return 1;
         }
         if(str == "闪电球")
         {
            return 1;
         }
         if(str == "七彩球")
         {
            return 1;
         }
         return 1;
      }
   }
}

