export default class HyperElement {

  events = [];
  parentNode = null;
  isMounted = false;

  constructor(descriptor) {
    if (descriptor instanceof Element) {
      this.node = descriptor;
      this.parentNode = this.node.parentNode;
      this.tag = this.node.tagName;
      this.isMounted = true;
    }
    else {
      this.node = document.createElement(descriptor);
      this.tag = descriptor;
    }
  }

  setAttr(key, value) {
    this.node[key] = value;
    return this;
  }

  mount(parent) {
    if (this.isMounted) {
      this.unmount();
    }

    const parentOrBody = this.parentNode || document.querySelector('body');
    this.parentNode = parent ? document.querySelector(parent) : parentOrBody;
    this.parentNode.appendChild(this.node);
    this.isMounted = true;

    this._restoreEvents();

    return this;
  }

  unmount() {
    if (this.isMounted) {
      this.node.parentNode.removeChild(this.node);
      this.clearEvents();
      this.isMounted = false;
    }

    return this;
  }

  addEvent(type = 'click', listener) {
    this.node.addEventListener(type, listener);
    this.events.push({ type, listener });
    return this;
  }

  clearEvents() {
    this.events.forEach(event => {
      this.node.removeEventListener(event.type, event.listener);
    });
    return this;
  }

  _restoreEvents() {
    this.events.forEach(({ type, listener }) => this.node.addEventListener(type, listener));
  }

  destroy() {
    this.clearEvents().unmount();
  }

};
