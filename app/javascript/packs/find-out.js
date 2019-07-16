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
    const contentTypesSelectOptions = contentTypes.slice(0, 1).map(tag => `<option data-id=${tag.data.attributes.id} value=${tag.data.attributes.title} class="find-out__tag-title">${tag.data.attributes.title}</option>`).join('')
    const contentTypesDropdown = (`<select><option value='everything' selected>everything</option>${contentTypesSelectOptions}</select`)
    document.getElementById('find-out__dropdown-content-type').innerHTML = contentTypesDropdown

    const topicAreas = response.filter(tag => tag.data.attributes.tag_type === 'topic_area')
    const topicAreasSelectOptions = topicAreas.map(tag => `<option data-id=${tag.data.attributes.id} value=${tag.data.attributes.title} class="find-out__tag-title">${tag.data.attributes.title}</option>`).join('')
    const topicAreasDropdown = (`<select><option value='all topic areas' selected>all topic areas</option>${topicAreasSelectOptions}</select`)
    document.getElementById('find-out__dropdown-topic-area').innerHTML = topicAreasDropdown

    onTagClick()
  })
}

const closeOverlay = () => {
  $('div.overlay').on('click', (event) => {
    event.preventDefault()
    $('div.overlay').html('').removeClass('overlay')
  })
}

const openOverlay = () => {
  $('div.overlay').html('')
  $('body').append('<div class="overlay"></div>')
}

const onTagClick = () => {
  $('select').on('change', (event) => {
    event.preventDefault()

    const selectedOptions = Array.from(document.getElementsByTagName('option')).filter(tag => tag.selected)
    const dataObject = {
      content_type: selectedOptions[0].innerText,
      topic_area: selectedOptions[1].innerText
    }

    openOverlay()
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
      if (res.data.attributes.report_id) {
        createReport(res, resultsDiv)
      }
    })
    closeOverlay()
  })
}

function createReport(obj, resultsDiv) {
  $.get(`/reports/${obj.data.attributes.report_id}.json`)
    .then(reportResponse => {
      const report = new Report(reportResponse)
      const reportCard = report.reportCardHtml()
      resultsDiv.append(reportCard)
    })
}

class Report {
  constructor(obj) {
    this.title = obj.data.attributes.title
    this.tags = obj.data.attributes.tags
    this.id = obj.data.attributes.id
    this.title = obj.data.attributes.title
    this.link = obj.data.attributes.link
    this.image_id = obj.data.attributes.image_id
    this.position = obj.data.attributes.position
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
    <p><strong>Tags: </strong>${tagsHtml}</>
  </div>
`)
}
