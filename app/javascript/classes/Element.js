export default class Element {

  events = [];

  constructor(tag = 'div', node = null) {
    if (node) {
      tag = node.tagName;
    }
    else {
      node = document.createElement(tag);
    }

    return this;
  }

  add(parent) {
    const parentOrBody = this.node.parentNode || document.querySelector('body');
    const parentNode = parent ? document.querySelector(parent) : parentOrBody;
    parentNode.appendChild(this.node);

    return this;
  }

  remove() {
    this.node.parentNode.removeChild(this.node);

    return this;
  }

  set(key, value) {
    this.node[key] = value;
  }

};
