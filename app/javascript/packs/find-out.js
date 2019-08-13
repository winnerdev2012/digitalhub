$(() => {
  const allTaggings = {
    content_type: 'everything',
    topic_area: 'all topic areas'
  }
  fetchTaggings(allTaggings)
  loadDropdowns()
})

function loadDropdowns() {
  $.get({
    url: '/tags.json',
    dataType: 'json',
  }).done((response) => {
    const contentTypes = response.filter(tag => tag.data.attributes.tag_type === 'content_type')
    const contentTypeSelectOptions = contentTypes.slice(0, 3).map(tag => `<option data-id=${tag.data.attributes.id} value=${tag.data.attributes.title} class="find-out__tag-title">${tag.data.attributes.title}</option>`).join('')
    const contentTypeDropdown = (`<select class="filter__select--content-type"><option id='all-content-types' value='everything' selected>everything</option>${contentTypeSelectOptions}</select>`)
    document.getElementsByClassName('filter__content-type--dropdown')[0].innerHTML = contentTypeDropdown

    const topicAreas = response.filter(tag => tag.data.attributes.tag_type === 'topic_area')
    const topicAreaSelectOptions = topicAreas.map(tag => `<option data-id=${tag.data.attributes.id} value=${tag.data.attributes.title} class="find-out__tag-title">${tag.data.attributes.title}</option>`).join('')
    const topicAreaDropdown = (`<select class="filter__select--topic-area"><option id='all-topic-areas' value='all topic areas' selected>all topic areas</option>${topicAreaSelectOptions}</select>`)
    document.getElementsByClassName('filter__topic-area--dropdown')[0].innerHTML = topicAreaDropdown
    onDropdownChange()
    cueOverlay()
  })
}

const cueOverlay = () => {
  $('.filter__select--content-type').on('click', (event) => {
    event.preventDefault()
    $('div#find-out__overlay').addClass('find-out__overlay')
  })

  $('.filter__select--topic-area').on('click', (event) => {
    event.preventDefault()
    $('div#find-out__overlay').addClass('find-out__overlay')
  })
  onClickOverlay()
}

const openOverlay = () => {
  $('span.current').on('click', (event) => {
    event.preventDefault()
    $('div#find-out__overlay').addClass('find-out__overlay')
    onClickOverlay()
  })
}

const onClickOverlay = () => {
  $('div#find-out__overlay').on('click', (event) => {
    event.preventDefault()
    closeOverlay()
  })
}

const closeOverlay = () => {
  $('div#find-out__overlay').removeClass('find-out__overlay')
}

const onDropdownChange = () => {
  $('select').niceSelect().on('change', (event) => {
    openOverlay()
    event.preventDefault()
    const dropdownSelections = Array.from(document.getElementsByTagName('option')).filter(tag => tag.selected)
    const dropdownsObject = {
      content_type: dropdownSelections[0].innerText,
      topic_area: dropdownSelections[1].innerText
    }
    fetchTaggings(dropdownsObject)
    closeOverlay()
  })
}

const loadTopicAreaNarrative = (title, body) => {
  $('.narrative-text').text(body)
}

const fetchTaggings = (dropdownsObject) => {
  $.get({
    url: '/taggings.json',
    dataType: 'json',
    data: dropdownsObject,
  }).done(response => {
    const resultsDiv = $('.results.container')
    const headerShort = () => {
      $('.find-out__header').css('height', '29.05rem')
    }

    const headerTall = () => {
      $('.find-out__header').css('height', '45.25rem')
    }

    const nextThreeEvents = () => {
      if (dropdownsObject.content_type === 'events') {
        loadNextThreeEvents(response.next_three_events, resultsDiv)
      }
    }

    const cardsHigh = () => {
      resultsDiv.css('bottom', '14rem')
    }

    const cardsLow = () => {
      resultsDiv.css('bottom', '0rem')
    }

    const resetDisplay = () => {
      $('.narrative-text').empty()
      resultsDiv.empty()
    }

    resetDisplay()
    loadTopicAreaNarrative(dropdownsObject.topic_area, response.topic_area_narrative)
    if (dropdownsObject.content_type === 'everything' && dropdownsObject.topic_area === 'all topic areas') {
      cardsLow()
    } else if ((dropdownsObject.content_type === 'events' || (dropdownsObject.topic_area !== 'all topic areas')) && response.taggings.length > 0) {
      headerTall()
      nextThreeEvents()
      cardsHigh()
    } else if (dropdownsObject.content_type !== 'events' && (dropdownsObject.topic_area === 'all topic areas')) {
      headerTall()
      nextThreeEvents()
      cardsLow()
    } else if (dropdownsObject.content_type === 'everything' && (dropdownsObject.topic_area !== 'all topic areas')) {
      headerTall()
      cardsLow()
    } else if (response.taggings.length === 0) {
      cardsLow()
      headerShort()
    }

    loadInitialCards(response.taggings, resultsDiv)
    onClickOverlay()
  })
}

const createCards = (taggings, resultsDiv) => {
  taggings.forEach(tagging => {
    if (tagging.data.attributes.announcement_id) {
      const announcement = new Announcement(tagging.data.attributes.tagged_item)
      const announcementCard = announcement.announcementCardHtml()
      resultsDiv.append(announcementCard)
    } else if (tagging.data.attributes.report_id) {
      const report = new Report(tagging.data.attributes.tagged_item)
      const reportCard = report.reportCardHtml()
      resultsDiv.append(reportCard)
    } else if (tagging.data.attributes.event_id) {
      const event = new Event(tagging.data.attributes.tagged_item)
      const eventCard = event.eventCardHtml()
      resultsDiv.append(eventCard)
    }
  })
}

const loadInitialCards = (taggings, resultsDiv) => {
  if (taggings.length === 0) {
    $('.results').html('<div class="results__message--none">There are currently no results for the selected filters.</div>')
    hideLoadMoreButton()
  } else {
    createCards(taggings.slice(0, 9), resultsDiv)
    if (taggings.length > 9) {
      showLoadMoreButton(taggings.slice(9, taggings.length - 1), resultsDiv)
    } else {
      hideLoadMoreButton()
    }
  }
}

const loadNextThreeEvents = (events, resultsDiv) => {
  const nextThree = events.map(event => {
    return new Event(event)
  })
  const nextThreeEventsHtml = Event.nextThree(nextThree)
  resultsDiv.prepend(nextThreeEventsHtml)
}

const loadRemainingCards = (taggings, resultsDiv) => {
  createCards(taggings, resultsDiv)
  hideLoadMoreButton()
}

const hideLoadMoreButton = () => {
  $('#load-more').hide()
}

const showLoadMoreButton = (remainingCards, resultsDiv) => {
  $('#load-more').show()
  $('#load-more').on('click', (event) => {
    event.preventDefault()
    loadRemainingCards(remainingCards, resultsDiv)
  })
}

// Report class
class Report {
  constructor(reportResponse) {
    this.title = reportResponse.data.attributes.title
    this.tags = reportResponse.data.attributes.tags
    this.id = reportResponse.data.id
    this.title = reportResponse.data.attributes.title
    this.link = reportResponse.data.attributes.link
    this.image_url = reportResponse.included[0].attributes.url
    this.position = reportResponse.data.attributes.position
    this.date = reportResponse.data.attributes.date
  }
}

Report.prototype.reportCardHtml = function reportCardHtml() {
  const tagsHtml = this.tags.map(tag => {
    if (tag.tag_type !== 'content_type') {
      return (`
      <span><em>${tag.title}</em></span>
      `)
    }
  }).join('')

  return (`
    <div class="results__card" data-sortdate="${Date.parse(this.date)}">
      <a href="/reports/${this.id}">
        <img class="results__card--image" src=${this.image_url} />
      </a>
      <div class="results__card--content-type">PUBLICATION</div>
      <div class="results__card--title-link">
        <a class="results__card--title-link" href="/reports/${this.id}">${this.title}</a>
      </div>
      <div class="results__card--tags">
        tags: ${tagsHtml}
      </div>
    </div>
  `)
}

// Event class
class Event {
  constructor(eventResponse) {
    this.id = eventResponse.data.id
    this.type = eventResponse.data.type
    this.tags = eventResponse.data.attributes.tags
    this.title = eventResponse.data.attributes.title
    this.event_type = eventResponse.data.attributes.event_type
    this.image_url = eventResponse.included[0].attributes.url
    this.description = eventResponse.data.attributes.description
    this.registration_link = eventResponse.data.attributes.registration_link
    this.start = eventResponse.data.attributes.start
    this.end = eventResponse.data.attributes.end
    this.address = eventResponse.data.attributes.address
    this.city = eventResponse.data.attributes.city
    this.state = eventResponse.data.attributes.state
    this.zipcode = eventResponse.data.attributes.zipcode
  }

  static nextThree(events) {
    const receiveUpdatesUrl = $('.next3events__receive-updates-url')[0].innerHTML
    const noEventsMessageHtml = (`
      <div>
        <div class="next3events__events-event--title">No upcoming events at this time.</div>
        <div class="next3events__button-receive-updates">
        <a class="button" rel="noopener noreferrer" href="${receiveUpdatesUrl}" target="_blank">Receive Updates</a>
        </div>
      </div>
      `)

    const nextThreeEventsHtml = events.map(event => {
      const eventDateAndHours = `${moment(event.start).format('MMM Do, h:mmA')} - ${moment(event.end).format('h:mmA')}`
      return (`
      <a href='/events/${event.id}' style='text-decoration: none'>
        <div class='next3events__events-event'>
          <div class='next3events__events-event--title'>${event.title}</div>
          <div class='next3events__events-event--content'>${eventDateAndHours} | ${event.city}</div>
        </div>
      </a>
      `)
    }).join('')

    return (`
      <div class="results__card">
        <div class="next3events">
          <div class="next3events__header">Join us for an event!<span class="next3events__triangle"></span></div>
          <div class="next3events__events">
            ${events.length > 0 ? nextThreeEventsHtml : noEventsMessageHtml}
          </div>
        </div>
      </div>
    `)
  }
}

Event.prototype.eventCardHtml = function eventCardHtml() {
  const tagsHtml = this.tags.map(tag => {
    if (tag.tag_type !== 'content_type') {
      return (`
      <span><em>${tag.title}</em></span>
      `)
    }
  }).join('')

  return (`
    <div class="results__card" data-sortdate="${Date.parse(this.start)}">
      <a href="/events/${this.id}">
        <img class="results__card--image" src=${this.image_url} />
      </a>
      <div class="results__card--content-type">EVENT</div>
      <div class="results__card--title-link">
        <a class="results__card--title-link" href="/events/${this.id}">${this.title}</a>
      </div>
      <div class="results__card--tags">
        tags: ${tagsHtml}
      </div>
    </div>
  `)
}

// Announcement class
class Announcement {
  constructor(announcementResponse) {
    this.id = announcementResponse.data.id
    this.title = announcementResponse.data.attributes.title
    this.body = announcementResponse.data.attributes.body
    this.tags = announcementResponse.data.attributes.tags
    this.link = announcementResponse.data.attributes.link
    this.image_url = announcementResponse.included[0].attributes.url
    this.published_date = announcementResponse.data.attributes.published_date
  }
}

Announcement.prototype.announcementCardHtml = function announcementCardHtml() {
  const tagsHtml = this.tags.map(tag => {
    if (tag.tag_type !== 'content_type') {
      return (`
      <span><em>${tag.title}</em></span>
      `)
    }
  }).join('')

  return (`
    <div class="results__card" data-sortdate="${Date.parse(this.published_date)}">
      <a href="/announcements/${this.id}">
        <img class="results__card--image" src=${this.image_url} />
      </a>
      <div class="results__card--content-type">NEWS</div>
      <div class="results__card---title-link">
        <a class="results__card--title-link" href="/announcements/${this.id}">${this.title}</a>
      </div>
      <div class="results__card--tags">
        tags: ${tagsHtml}
      </div>
    </div>
  `)
}
