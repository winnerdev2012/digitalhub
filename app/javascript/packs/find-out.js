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
    const contentTypeDropdown = (`<select class="find-out__select-content-types"><option id='all-content-types' value='everything' selected>everything</option>${contentTypeSelectOptions}</select>`)
    document.getElementsByClassName('find-out__filter-content-type-dropdown')[0].innerHTML = contentTypeDropdown

    const topicAreas = response.filter(tag => tag.data.attributes.tag_type === 'topic_area')
    const topicAreaSelectOptions = topicAreas.map(tag => `<option data-id=${tag.data.attributes.id} value=${tag.data.attributes.title} class="find-out__tag-title">${tag.data.attributes.title}</option>`).join('')
    const topicAreaDropdown = (`<select class="find-out__select-topic-areas"><option id='all-topic-areas' value='all topic areas' selected>all topic areas</option>${topicAreaSelectOptions}</select>`)
    document.getElementsByClassName('find-out__filter-topic-area-dropdown')[0].innerHTML = topicAreaDropdown
    onDropdownChange()
  })
}

const openOverlay = () => {
  $('body').append("<div class='find-out__overlay'></div>")
  onClickOverlay()
}

const onClickOverlay = () => {
  $('div.find-out__overlay').on('click', (event) => {
    event.preventDefault()
    closeOverlay()
  })
}

const closeOverlay = () => {
  $('div.find-out__overlay').html('').removeClass('find-out__overlay')
}

const onDropdownChange = () => {
  $('select').on('click', (event) => {
    event.preventDefault()
    openOverlay()
  })

  $('select').on('change', (event) => {
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
  $('.find-out__topic-area-narrative').text(body)
}

const fetchTaggings = (dropdownsObject) => {
  $.get({
    url: '/taggings.json',
    dataType: 'json',
    data: dropdownsObject,
  }).done(response => {
    loadTopicAreaNarrative(dropdownsObject.topic_area, response.topic_area_narrative)

    let resultsDiv = $('.find-out__results')
    resultsDiv.empty()

    const topicAreaResultsDiv = $('.find-out__topic-area-results')
    topicAreaResultsDiv.empty()

    const footer = $('footer')

    if (dropdownsObject.topic_area !== 'all topic areas') {
      $('.find-out__header').css('height', '45.25rem')
      $('body').css('height', '1850px')

      resultsDiv = topicAreaResultsDiv

      $('body').parent().append(footer)
    }

    if (response.taggings.length === 0) {
      $('.find-out__results').html('<div class="find-out__results-message-none">There are currently no results for the selected filters.</div>')
    } else {
      response.taggings.forEach(res => {
        if (res.data.attributes.announcement_id) {
          createAnnouncement(res, resultsDiv)
        }
        if (res.data.attributes.report_id) {
          createReport(res, resultsDiv)
        }
        if (res.data.attributes.event_id) {
          createEvent(res, resultsDiv)
        }
      })
    }
    onSelectAllTopicAreas()
    onClickOverlay()
  })
}

const onSelectAllTopicAreas = () => {
  if ($('select')[1] && $('select')[1].value === 'all topic areas') {
    $('.find-out__header').css('height', '29.05rem')
  }
}

// Report api, class and find-out card html
function createReport(reportObject, resultsDiv) {
  $.get(`/reports/${reportObject.data.attributes.report_id}.json`)
    .then(reportResponse => {
      const report = new Report(reportResponse)
      const reportCard = report.reportCardHtml()
      resultsDiv.append(reportCard)
    })
}

class Report {
  constructor(reportResponse) {
    this.title = reportResponse.data.attributes.title
    this.tags = reportResponse.data.attributes.tags
    this.id = reportResponse.data.id
    this.title = reportResponse.data.attributes.title
    this.link = reportResponse.data.attributes.link
    this.image_url = reportResponse.included[0].attributes.url
    this.position = reportResponse.data.attributes.position
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
  <div class="find-out__results-tagged-item-report">
    <a href="/reports/${this.id}">
      <img class="find-out__results-tagged-item-report-image" src=${this.image_url} />
    </a>
    <div class="find-out__results-tagged-item-report-info">
      <div class="find-out__results-tagged-item-report-info-content-type">PUBLICATION</div>
      <div class="find-out__results-tagged-item-report-info-title-link">
        <a href="/reports/${this.id}">${this.title}</a>
      </div>
      <div class="find-out__results-tagged-item-report-info-tags">
        tags: ${tagsHtml}
      </div>
    </div>
  </div>
  `)
}

// Event api, class and find-out card html
function createEvent(obj, resultsDiv) {
  $.get(`/events/${obj.data.attributes.event_id}.json`)
    .then(eventResponse => {
      const event = new Event(eventResponse)
      const eventCard = event.eventCardHtml()
      resultsDiv.append(eventCard)
    })
}

class Event {
  constructor(eventResponse) {
    this.id = eventResponse.data.id // note: not nested under attributes
    this.type = eventResponse.data.type // note: not nested under attributes
    this.tags = eventResponse.data.attributes.tags // note: this is a nested array
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
    <div class="find-out__results-tagged-item-event">
    <a href="/events/${this.id}">
      <img class="find-out__results-tagged-item-event-image" src=${this.image_url} />
    </a>
      <div class="find-out__results-tagged-item-event-info">
        <div class="find-out__results-tagged-item-event-info-content-type">EVENT</div>
        <div class="find-out__results-tagged-item-event-info-title-link">
          <a class="tagged-item-title-link" href="/events/${this.id}">${this.title}</a>
        </div>
        <div class="find-out__results-tagged-item-event-info-tags">
          tags: ${tagsHtml}
        </div>
      </div>
    </div>
  `)
}

// Announcement api, class and find-out card html
function createAnnouncement(announcementObject, resultsDiv) {
  $.get(`/announcements/${announcementObject.data.attributes.announcement_id}.json`)
    .then(announcementResponse => {
      const announcement = new Announcement(announcementResponse)
      const announcementCard = announcement.announcementCardHtml()
      resultsDiv.append(announcementCard)
    })
}

class Announcement {
  constructor(announcementResponse) {
    this.id = announcementResponse.data.id
    this.title = announcementResponse.data.attributes.title
    this.body = announcementResponse.data.attributes.body
    this.tags = announcementResponse.data.attributes.tags
    this.link = announcementResponse.data.attributes.link
    this.image_url = announcementResponse.included[0].attributes.url
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
    <div class="find-out__results-tagged-item-announcement">
    <a href="/announcements/${this.id}">
      <img class="find-out__results-tagged-item-announcement-image" src=${this.image_url} />
    </a>
      <div class="find-out__results-tagged-item-announcement-info">
        <div class="find-out__results-tagged-item-announcement-info-content-type">NEWS</div>
        <div class="find-out__results-tagged-item-announcement-info-title-link">
          <a class="tagged-item-title-link" href="/announcements/${this.id}">${this.title}</a>
        </div>
        <div class="find-out__results-tagged-item-announcement-info-tags">
          tags: ${tagsHtml}
        </div>
      </div>
    </div>
  `)
}
