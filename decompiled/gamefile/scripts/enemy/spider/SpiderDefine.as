package enemy.spider
{
   import body.define.EnemyDefine;
   
   public class SpiderDefine extends EnemyDefine
   {
      
      public var _hurt:Number = 0;
      
      public var attackType:String = "";
      
      public var recoilValue:Number;
      
      public var mulHurt:Number = 0;
      
      public function SpiderDefine()
      {
         super();
      }
      
      override public function inData_byXML(xml0:XML) : *
      {
         this.attackType = String(xml0.attackType);
         this.recoilValue = Number(xml0.recoilValue);
         this._hurt = Number(xml0.hurt);
         super.inData_byXML(xml0);
      }
      
      public function get hurt() : Number
      {
         return this._hurt;
      }
   }
}

