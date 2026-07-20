package body.define
{
   import body.attack.AttackHitDataGroup;
   import data.StringToDefine;
   import effect.EffectSMC;
   import enemy._die.DieDelay;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class EnemyDefine extends LifeBodyDefine
   {
      
      public var lifeBar:*;
      
      public var certainChip:String = "";
      
      public var dialogue:String = "";
      
      public var firstDialogue:String = "";
      
      public var dieDelay:DieDelay;
      
      public var superNum:int = 0;
      
      public var breakB:Boolean = false;
      
      public var eventOrderDefineGroupID:String = "";
      
      public var hitEffectImg:EffectSMC = null;
      
      public var aiLevel:int = 0;
      
      public var rectLevel:int = 0;
      
      public var attackData:AttackHitDataGroup;
      
      public var imgList:Array = [];
      
      public var FBSkillArr:Array = [];
      
      public var dropState:String = "noing";
      
      public var lifeDropNum:int = 0;
      
      private var _grapRect:Array = [];
      
      public var attackRectIndexArr:Array = [];
      
      private var _hoverRect:Array = [new Rectangle(70,-50,300,80)];
      
      private var _affterAttack:Array = [];
      
      private var _nextAttackTime:Array = [];
      
      private var _attackDelay:Array = [];
      
      public var airRange:Point;
      
      public var tweenValue:Number = 0;
      
      public var jumpHeight:Number = 0;
      
      private var _jumpNum:Array = [];
      
      private var _vx:Array = [];
      
      private var _vy:Array = [];
      
      public var jumpDelay:Number = 0;
      
      public function EnemyDefine()
      {
         super();
      }
      
      public function get vx() : Number
      {
         return Number(this.getValue(this._vx,this.aiLevel));
      }
      
      public function get vy() : Number
      {
         return Number(this.getValue(this._vy,this.aiLevel));
      }
      
      public function get jumpNum() : int
      {
         return int(this.getValue(this._jumpNum,this.aiLevel));
      }
      
      public function get affterAttack() : String
      {
         return String(this.getValue(this._affterAttack,this.aiLevel));
      }
      
      public function get nextAttackTime() : Number
      {
         return Number(this.getValue(this._nextAttackTime,this.aiLevel));
      }
      
      public function get attackDelay() : Number
      {
         return Number(this.getValue(this._attackDelay,this.aiLevel));
      }
      
      public function get hoverRect() : Rectangle
      {
         return this.getValue(this._hoverRect,this.rectLevel);
      }
      
      public function get grapRect() : Rectangle
      {
         return this.getValue(this._grapRect,this.rectLevel);
      }
      
      private function getValue(arr0:Array, level0:int) : *
      {
         var l0:int = level0;
         if(l0 > arr0.length - 1)
         {
            l0 = arr0.length - 1;
         }
         return arr0[l0];
      }
      
      override public function inData_byXML(xml0:XML) : *
      {
         this.imgList = String(xml0.imgList).split(",");
         this.FBSkillArr = String(xml0.FBSkill).split(",");
         if(xml0.attackHitData.length() > 0)
         {
            this.attackData = new AttackHitDataGroup();
            this.attackData.inData_byXML(xml0.attackHitData);
         }
         this._attackDelay = StringToDefine.xmlToArr(xml0.attackDelay);
         this._affterAttack = StringToDefine.xmlToArr(xml0.affterAttack);
         this._nextAttackTime = StringToDefine.xmlToArr(xml0.nextAttackTime);
         this._grapRect = StringToDefine.xmlToRectArr(xml0.grapRect);
         var hovestr:String = String(xml0.hoverRect);
         if(xml0.hoverRect.length() > 0)
         {
            this._hoverRect = StringToDefine.xmlToRectArr(xml0.hoverRect);
         }
         var airRangeStr:String = String(xml0.airRange);
         if(airRangeStr != "")
         {
            this.airRange = StringToDefine.getPoint(airRangeStr);
         }
         this.tweenValue = Number(xml0.tweenValue);
         this.jumpHeight = Number(xml0.jumpHeight);
         this._vx = StringToDefine.xmlToArr(xml0.vx);
         this._vy = StringToDefine.xmlToArr(xml0.vy);
         this._jumpNum = StringToDefine.xmlToArr(xml0.jumpNum);
         this.jumpDelay = Number(xml0.jumpDelay);
         if(xml0.attackRectIndexArr.length() > 0)
         {
            this.attackRectIndexArr = String(xml0.attackRectIndexArr).split(",");
         }
         super.inData_byXML(xml0);
         if(StringToDefine.rectArrIsNaN(this._grapRect))
         {
            throw new Error("怪物：" + name + "的grapRect填写有错误。");
         }
      }
      
      public function isAir() : Boolean
      {
         if(this.imgList.indexOf("stand") >= 0)
         {
            return false;
         }
         return true;
      }
      
      public function haveAttackRectB() : Boolean
      {
         if(Boolean(this.attackData))
         {
            return true;
         }
         return false;
      }
   }
}

