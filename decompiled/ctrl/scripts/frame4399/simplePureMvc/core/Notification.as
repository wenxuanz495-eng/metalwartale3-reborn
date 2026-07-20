package frame4399.simplePureMvc.core
{
   public class Notification
   {
      
      private var _name:String;
      
      private var _body:Object;
      
      private var _type:String;
      
      public function Notification(param1:String = "", param2:Object = null, param3:String = null)
      {
         super();
         this._name = param1;
         this._body = param2;
         this._type = param3;
      }
      
      public function getName() : String
      {
         return this._name;
      }
      
      public function getBody() : Object
      {
         return this._body;
      }
      
      public function getType() : String
      {
         return this._type;
      }
   }
}

