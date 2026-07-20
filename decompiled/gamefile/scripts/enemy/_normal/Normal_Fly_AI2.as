package enemy._normal
{
   public class Normal_Fly_AI2 extends Normal_Fly_AI
   {
      
      public function Normal_Fly_AI2(_baba:*)
      {
         super(_baba);
      }
      
      override protected function attackOver() : *
      {
         var index0:int = Math.random() * armsNum;
         baba.armsDefine.inData(armsName,index0);
         super.attackOver();
         baba.define.rectLevel = index0;
         baba.flesh_byDefine();
      }
   }
}

