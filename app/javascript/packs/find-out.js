$(() => {
  const allTaggings = {
    content_type: 'everything',
    topic_area: 'all topic areas'
  }
  fetchFilteredTaggings(allTaggings)
  loadDropDownTags()
})

function loadDropDownTags() {
  $.get({
    url: '/tags.json',
    dataType: 'json',
  }).done((response) => {
    const contentTypes = response.filter(tag => tag.data.attributes.tag_type === 'content_type')
    const contentTypesSelectOptions = contentTypes.slice(0, 3).map(tag => `<option data-id=${tag.data.attributes.id} value=${tag.data.attributes.title} class="find-out__tag-title">${tag.data.attributes.title}</option>`).join('')
    const contentTypesDropdown = (`<select><option value='everything' selected>everything</option>${contentTypesSelectOptions}</select`)
    document.getElementById('find-out__dropdown-content-type').innerHTML = contentTypesDropdown

    const topicAreas = response.filter(tag => tag.data.attributes.tag_type === 'topic_area')
    const topicAreasSelectOptions = topicAreas.map(tag => `<option data-id=${tag.data.attributes.id} value=${tag.data.attributes.title} class="find-out__tag-title">${tag.data.attributes.title}</option>`).join('')
    const topicAreasDropdown = (`<select><option value='all topic areas' selected>all topic areas</option>${topicAreasSelectOptions}</select`)
    document.getElementById('find-out__dropdown-topic-area').innerHTML = topicAreasDropdown

    onTagClick()
  })
}

const onTagClick = () => {
  $('select').on('change', (event) => {
    event.preventDefault()

    const selectedOptions = Array.from(document.getElementsByTagName('option')).filter(tag => tag.selected)
    const dataObject = {
      content_type: selectedOptions[0].innerText,
      topic_area: selectedOptions[1].innerText
    }
    fetchFilteredTaggings(dataObject)
  })
}

const loadTopicAreaNarrative = (title, body) => {
  $('.find-out__topic-area-narrative-title').text(title)
  $('.find-out__topic-area-narrative-body').text(body)
}

const fetchFilteredTaggings = (dataObject) => {
  $.get({
    url: '/taggings.json',
    dataType: 'json',
    data: dataObject,
  }).done(response => {
    loadTopicAreaNarrative(dataObject.topic_area, response.topic_area_narrative)

    const resultsDiv = $('.find-out__results')
    resultsDiv.empty()

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
  })
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
    this.id = reportResponse.data.attributes.id
    this.title = reportResponse.data.attributes.title
    this.link = reportResponse.data.attributes.link
    this.image_id = reportResponse.data.attributes.image_id
    this.position = reportResponse.data.attributes.position
  }
}

Report.prototype.reportCardHtml = function reportCardHtml() {
  const tagsHtml = this.tags.map(tag => {
    return (`
    <span><em> *${tag.title}</em></span>
    `)
  }).join('')
  return (`
  <div class="find-out__tagged-item">
    <h3><strong>Publication: </strong>${this.title}</h3>
    <p>${this.body}</p>
    <img class="find-out__report__image " src=${this.image_url} />
    <hr />
    <p><strong>Tags: </strong>${tagsHtml}</>
  </div>
  `)
}

// Event api, class and find-out card html
function createEvent(eventObject, resultsDiv) {
  $.get(`/events/${eventObject.data.attributes.event_id}.json`)
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
    this.image_id = eventResponse.data.attributes.image_id
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
    return (`
      <span><em> *${tag.title}</em></span>
    `)
  }).join('')
  return (`
  <div class="find-out__tagged-item">
    <h3><strong>Event: </strong>${this.title}</h3>
    <p>type: ${this.type}</p>
    <p>event_type: ${this.event_type}</p>
    <p>description: ${this.description}</p>
    <p>registration_link: ${this.registration_link}</p>
    <p>start: ${this.start}</p>
    <p>end: ${this.end}</p>
    <p>address: ${this.address}</p>
    <p>city: ${this.city}</p>
    <p>state: ${this.state}</p>
    <p>zipcode: ${this.zipcode}</p>
    <img class="find-out__event__image " src=${this.image_url} />
    <hr />
    <p><strong>Tags: </strong>${tagsHtml}</p>
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
    this.id = announcementResponse.data.attributes.id
    this.title = announcementResponse.data.attributes.title
    this.body = announcementResponse.data.attributes.body
    this.tags = announcementResponse.data.attributes.tags
    this.link = announcementResponse.data.attributes.link
    this.image_url = announcementResponse.included[0].attributes.url
  }
}

Announcement.prototype.announcementCardHtml = function announcementCardHtml() {
  const tagsHtml = this.tags.map(tag => {
    return (`
      <span><em> *${tag.title}</em></span>
    `)
  }).join('')
  return (`
  <div class="find-out__tagged-item">
    <h3><strong>News: </strong>${this.title}</h3>
    <p>body: ${this.body}</p>
    <p>link: ${this.link}</p>
    <img class="find-out__announcement__image " src=${this.image_url} />
    <hr />
    <p><strong>Tags: </strong>${tagsHtml}</>
  </div>
`)
}
