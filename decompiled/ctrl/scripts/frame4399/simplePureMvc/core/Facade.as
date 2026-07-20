package frame4399.simplePureMvc.core
{
   import frame4399.simplePureMvc.interfaces.IMediator;
   import frame4399.simplePureMvc.interfaces.IProxy;
   
   public class Facade
   {
      
      private static var instance:Facade;
      
      private var _model:Model;
      
      private var _controller:Controller;
      
      private var _view:View;
      
      public function Facade()
      {
         super();
         this.initializeFacade();
      }
      
      public static function getInstance() : Facade
      {
         if(instance == null)
         {
            instance = new Facade();
         }
         return instance;
      }
      
      protected function initializeFacade() : void
      {
         this.initializeController();
         this.initializeView();
         this.initializeModel();
      }
      
      protected function initializeController() : void
      {
         if(this._controller != null)
         {
            return;
         }
         this._controller = Controller.getInstance();
      }
      
      protected function initializeView() : void
      {
         if(this._view != null)
         {
            return;
         }
         this._view = View.getInstance();
      }
      
      public function registerCommand(param1:String, param2:Function, param3:Object) : void
      {
         this._controller.registerCommand(param1,param2,param3);
      }
      
      public function removeCommand(param1:String) : void
      {
         this._controller.removeCommand(param1);
      }
      
      public function hasCommand(param1:String) : Boolean
      {
         return this._controller.hasCommand(param1);
      }
      
      public function registerMediator(param1:IMediator) : void
      {
         if(this._view != null)
         {
            this._view.registerMediator(param1);
         }
      }
      
      public function retrieveMediator(param1:String) : IMediator
      {
         return this._view.retrieveMediator(param1) as IMediator;
      }
      
      public function removeMediator(param1:String) : IMediator
      {
         var _loc2_:IMediator = null;
         if(this._view != null)
         {
            _loc2_ = this._view.removeMediator(param1);
         }
         return _loc2_;
      }
      
      public function hasMediator(param1:String) : Boolean
      {
         return this._view.hasMediator(param1);
      }
      
      public function sendNotification(param1:String, param2:Object = null, param3:String = null) : void
      {
         var _loc4_:Notification = null;
         _loc4_ = new Notification(param1,param2,param3);
         this.notifyObservers(_loc4_);
         if(this._controller != null)
         {
            this._controller.sendNotification(_loc4_);
         }
      }
      
      public function notifyObservers(param1:Notification) : void
      {
         if(this._view != null)
         {
            this._view.notifyObservers(param1);
         }
      }
      
      protected function initializeModel() : void
      {
         if(this._model != null)
         {
            return;
         }
         this._model = Model.getInstance();
      }
      
      public function registerProxy(param1:IProxy) : void
      {
         this._model.registerProxy(param1);
      }
      
      public function retrieveProxy(param1:String) : IProxy
      {
         return this._model.retrieveProxy(param1);
      }
      
      public function removeProxy(param1:String) : IProxy
      {
         var _loc2_:IProxy = null;
         if(this._model != null)
         {
            _loc2_ = this._model.removeProxy(param1);
         }
         return _loc2_;
      }
      
      public function hasProxy(param1:String) : Boolean
      {
         return this._model.hasProxy(param1);
      }
   }
}

