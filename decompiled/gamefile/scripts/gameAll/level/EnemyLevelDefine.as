package gameAll.level
{
   public class EnemyLevelDefine
   {
      
      public var level:int = 0;
      
      public var baseLife:Number = 1;
      
      public var baseAttack:Number = 1;
      
      public var baseExp:Number = 1;
      
      public var baseCoin:Number = 1;
      
      public function EnemyLevelDefine()
      {
         super();
      }
      
      public function inData_byXML(xml0:XML) : *
      {
         this.level = int(xml0.@id);
         this.baseLife = Number(xml0.baseLife);
         this.baseAttack = Number(xml0.baseAttack);
         this.baseExp = Number(xml0.baseExp);
         this.baseCoin = Number(xml0.baseCoin);
      }
   }
}

