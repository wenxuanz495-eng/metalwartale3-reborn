package gameAll.data
{
   import com.adobe.serialization.json.JSON2;
   
   public class PassScore
   {
      
      public static var diffText:Array = ["","knowing","ghost","3"];
      
      public var OBJ:Object = new Object();
      
      public function PassScore()
      {
         super();
      }
      
      public function init() : *
      {
         this.OBJ = new Object();
      }
      
      public function inData_byObj(obj:Object) : *
      {
         if(obj.OBJ is Object)
         {
            this.OBJ = JSON2.decode(JSON2.encode(obj.OBJ));
         }
         else
         {
            this.OBJ = new Object();
         }
      }
      
      public function setScore(score0:int, level0:int, diff0:int, packName:String) : *
      {
         var pack0:int = diffText.indexOf(packName);
         var name0:String = "l" + pack0 + "_" + diff0 + "_" + level0;
         if(this.OBJ.hasOwnProperty(name0))
         {
            if(this.OBJ[name0] < score0)
            {
               this.OBJ[name0] = score0;
            }
         }
         else
         {
            this.OBJ[name0] = score0;
         }
      }
      
      public function getScore(level0:int, diff0:int, packName:String) : int
      {
         var pack0:int = diffText.indexOf(packName);
         var name0:String = "l" + pack0 + "_" + diff0 + "_" + level0;
         if(this.OBJ.hasOwnProperty(name0))
         {
            return this.OBJ[name0];
         }
         return -1;
      }
      
      public function plusAllStar() : int
      {
         var n:* = undefined;
         var num0:int = 0;
         for(n in this.OBJ)
         {
            num0 += Game.gameDefine.getPassGradeIndex(this.OBJ[n]);
         }
         return num0;
      }
   }
}

