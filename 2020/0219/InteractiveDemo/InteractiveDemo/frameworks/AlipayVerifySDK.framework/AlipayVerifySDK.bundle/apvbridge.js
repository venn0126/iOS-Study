window.APVJSBridge || (function () {
  const pool = {};
  window.APVJSBridge = {
    /**
     * 调用native 方法
     * @param {*} action 方法名
     * @param {*} data 参数
     * @param {*} callback 回调方法
     */
    call(action, data, callback) {
      if (typeof action !== 'string') {
        return;
      }

      if (typeof data === 'function') {
        callback = data;
        data = null;
      } else if (typeof data !== 'object') {
        data = null;
      }

      const eventId = `${new Date().getTime()}${Math.random()}`;
      if (typeof callback === 'function') {
        pool[eventId] = callback;
      }

      const msg = JSON.stringify({
        action,
        data,
        eventId
      });
      //console.log(`bridge.log.message: ${msg}`);
      this.iframeCall(msg);
    },
                      
    iframeCall(paramStr) {
      var iframe = document.createElement("iframe");
      iframe.style.width = "1px";
      iframe.style.height = "1px";
      iframe.style.display = "none";
      iframe.src = "apvbridge://callNativeFunc?" + paramStr;
      var parent = document.body || document.documentElement;
      parent.appendChild(iframe);
      setTimeout(function() {
        parent.removeChild(iframe)},
                 0);
    },
        
    callback(response) {
      const { eventId, data } = response;
      const func = pool[eventId];
      delete pool[eventId];

      if (typeof func === 'function') {
        setTimeout(() => {
          func(data);
        }, 1);
      }
    }
  };

  // 通知JS 已经获得了bridge
  const readyEvent = document.createEvent('Events');
  readyEvent.initEvent('APVJSBridgeReady', 0, 0);
  const addEventListenerMethod = document.addEventListener;
  document.addEventListener = (eventType, callback, ...args) => {
    if (eventType === readyEvent.type) {
      setTimeout(() => {
        callback(readyEvent);
      }, 1);
    }
    addEventListenerMethod.call(document, eventType, callback, args);
  };
  document.dispatchEvent(readyEvent);
}());
