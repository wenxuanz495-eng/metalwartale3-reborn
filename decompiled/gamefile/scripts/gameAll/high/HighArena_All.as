package gameAll.high
{
   import com.adobe.serialization.json.JSON2;
   
   public class HighArena_All
   {
      
      public var rank:int = 10;
      
      public var score:Number = 0;
      
      public var userName:String = "";
      
      public var extra:HighArena_ExtraData = new HighArena_ExtraData();
      
      public function HighArena_All()
      {
         super();
      }
      
      public function inData_byObj(obj:Object) : *
      {
         var n:* = undefined;
         var pro0:String = null;
         var pro_arr:Array = ["rank","score","userName"];
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            this[pro0] = obj[pro0];
         }
         if(obj.extra is String)
         {
            if(obj.extra.indexOf("{") >= 0)
            {
               this.extra.inData_byObj(JSON2.decode(obj.extra));
            }
         }
      }
      
      public function inData_byData(obj:Object) : *
      {
         var n:* = undefined;
         var pro0:String = null;
         var pro_arr:Array = ["rank","score","userName","extra"];
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            this[pro0] = obj[pro0];
         }
      }
      
      public function getObj() : Object
      {
         var n:* = undefined;
         var pro0:String = null;
         var obj0:Object = new Object();
         var pro_arr:Array = ["rank","score","userName"];
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            obj0[pro0] = this[pro0];
            obj0.extra = JSON2.encode(this.extra);
         }
         return obj0;
      }
   }
}

