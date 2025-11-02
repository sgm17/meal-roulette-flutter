---
to: _templates/<%= h.changeCase.snake(name) %>/<%= action || 'new' %>/prompt.js
---

// see types of prompts:
// https://github.com/enquirer/enquirer/tree/master/examples
//
modules.exports = [
  {
    type: 'input',
    name: 'message',
    message: "What's your message?"
  }
]
