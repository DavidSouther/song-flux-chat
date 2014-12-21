angular.module('song.dispatcher', [

]).factory('dispatcher', function(){
  function Dispatcher(id){
    this.id = 'D_' + id;
    this._callbacks = new WeakMap();
  }

  Dispatcher.prototype.nextId = (function(){
    var id = 0;
    var prefix = this.id + 'ID_';
    return function(){
      return prefix + (++id);
    };
  });

  Dispatcher.prototype.register = function(ctor, callback){
    if(!this._callbacks.has(ctor)){
      this._callbacks.set(ctor, {});
    }

    var id = this.nextId();
    var cbs = this._callbacks.get(ctor);
    cbs[id] = callback;
    return id;
  };

  Dispatcher.prototype.dispatch = function(action){
    var actionType = action.constructor;
    if(!this._callbacks.has(actionType)){
      return;
    }
    var cbs = this._callbacks.get(actionType);
    for(var id in cbs){
      // Do checks, assertions, etc.
      cbs[id](action);
    }
  };

  var dispatcherID = 0;
  var dispatchers = new WeakMap();

  return {
    get: function(moduleName){
      var ngModule = angular.module(moduleName);
      if ( !dispatchers.has(ngModule) ) {
        dispatchers.set(ngModule, new Dispatcher(dispatcherID++));
      }
      return dispatchers.get(ngModule);
    }
  };
});
