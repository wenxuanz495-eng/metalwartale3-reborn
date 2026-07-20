package data
{
   import flash.utils.describeType;
   
   public class ClassProperty
   {
      
      public function ClassProperty()
      {
         super();
      }
      
      public static function getProArr(obj:*) : Array
      {
         var n:* = undefined;
         var arr0:Array = [];
         var xml0:XML = describeType(obj);
         for(n in xml0.variable)
         {
            arr0.push(String(xml0.variable[n].@name));
         }
         return arr0;
      }
      
      public static function inData(target:Object, obj:Object, pro_arr:Array) : *
      {
         var n:* = undefined;
         var name0:String = null;
         for(n in pro_arr)
         {
            name0 = pro_arr[n];
            if(obj[name0] == null)
            {
               target[name0] = null;
            }
            else if(Boolean(obj[name0].hasOwnProperty("clone2")))
            {
               target[name0] = obj[name0].clone2();
            }
            else if(Boolean(obj[name0].hasOwnProperty("clone")))
            {
               target[name0] = obj[name0].clone();
            }
            else if(obj[name0] is Array)
            {
               target[name0] = copyArray(obj[name0]);
            }
            else
            {
               target[name0] = obj[name0];
            }
         }
      }
      
      public static function copyArray(arr0:Array) : Array
      {
         var n:* = undefined;
         var obj0:* = undefined;
         var arr1:Array = [];
         for(n in arr0)
         {
            obj0 = arr0[n];
            if(Boolean(obj0.hasOwnProperty("clone2")))
            {
               arr1.push(obj0.clone2());
            }
            else if(Boolean(obj0.hasOwnProperty("clone")))
            {
               arr1.push(obj0.clone());
            }
            else
            {
               arr1.push(obj0);
            }
         }
         return arr1;
      }
   }
}

