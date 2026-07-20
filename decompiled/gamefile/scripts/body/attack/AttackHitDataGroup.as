package body.attack
{
   public class AttackHitDataGroup
   {
      
      public var arr:Array = [];
      
      public function AttackHitDataGroup()
      {
         super();
      }
      
      public function inData_byXML(xml0:*) : *
      {
         var n:* = undefined;
         var ahd:AttackHitData = null;
         var xml1:* = xml0.data;
         for(n in xml1)
         {
            ahd = new AttackHitData();
            ahd.inData_byXML(xml1[n]);
            this.arr.push(ahd);
         }
      }
      
      public function setLevel(num:int) : *
      {
         var n:* = undefined;
         var adh:AttackHitData = null;
         for(n in this.arr)
         {
            adh = this.arr[n];
            adh.level = num;
         }
      }
      
      public function setMulHurt(value0:Number) : *
      {
         var n:* = undefined;
         var adh:AttackHitData = null;
         for(n in this.arr)
         {
            adh = this.arr[n];
            adh.mulHurt = value0;
         }
      }
      
      public function setHurt(value0:Number, hurt_0_B:Boolean = true) : *
      {
         var n:* = undefined;
         var adh:AttackHitData = null;
         for(n in this.arr)
         {
            adh = this.arr[n];
            adh._hurt = value0;
            adh.hurt_0_B = hurt_0_B;
         }
      }
      
      public function getAttackHitDataGroup(label0:String) : AttackHitDataGroup
      {
         var n:* = undefined;
         var adh:AttackHitData = null;
         var m:int = 0;
         var m2:int = 0;
         var ahdg:AttackHitDataGroup = new AttackHitDataGroup();
         for(n in this.arr)
         {
            adh = this.arr[n];
            if(adh.label == label0)
            {
               m = adh.frame;
               for(m2 = adh.endFrame; m <= m2; )
               {
                  ahdg.arr[m] = adh;
                  m++;
               }
            }
         }
         if(ahdg.arr.length > 0)
         {
            return ahdg;
         }
         return null;
      }
   }
}

