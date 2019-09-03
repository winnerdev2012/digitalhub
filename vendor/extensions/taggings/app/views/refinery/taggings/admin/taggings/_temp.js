
let renderValidItems = validItems.map(item => {
  return (`
          <li class="validation__data--valid">${item}</li>
        `)
}).join('')

let renderErrorItems = errorItems.map(item => {
  return (`
          <li class="validation__data--invalid">
            <a href='/hubadmin/${item}s/${id}/edit'>Error: ${item}:${id} >> ${modelErrors}</a>
          </li>
        `)
}).join('')
