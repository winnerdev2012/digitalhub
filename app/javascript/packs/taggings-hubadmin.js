$(() => {
  $('button.validation__button--open').on('click', (event) => {
    event.preventDefault()
    $.get({
      url: '/data_validation.json',
      dataType: 'json',
    }).done((response) => {
      const errorItems = []
      const validItems = []
      const keys = Object.keys(response)

      keys.forEach(key => {
        if (typeof response[key][0] === 'string') {
          validItems.push(response[key][0]);
        } else {
          errorItems.push(response[key][0])
        }
      })

      const renderValidItems = validItems.map(item => {
        return (`
          <div class="validation__data--valid">${item}</div>
        `)
      }).join(' ')

      const renderErrorItems = errorItems.map((item) => {
        if (item) {
          const errors = item.errors.map(err => `<li class="validation__data--invalid">${err}</li>`).join(' ')
          return (`
            <div class="validation__data--invalid">${item.type} errors, <strong>click here to correct:</strong>
              <a href=${item.edit_url}>${errors}</a>
            </div>
          `)
        }
      }).join(' ')

      const validationDiv = (`
        <div class="validation__data">
          <div class="validation__message">
            ${renderValidItems}
            ${renderErrorItems}
          </div>
        </div>
      `)

      $('.validation__data').html(validationDiv)
      $('button.validation__button--close').show()
      $('div.validation__data').show()
    })

    $('button.validation__button--close').on('click', () => {
      $('.validation__data').html('')
      $('button.validation__button--close').hide()
    })
  })
})
