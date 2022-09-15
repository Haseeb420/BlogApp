$(document).ready ->

  uploadAttachment = (attachment) ->
    csrfToken = $('meta[name="csrf-token"]').attr('content')
    file = attachment.file
    form = new FormData
    endpoint = '/images.json'
    form.append 'Content-Type', file.type
    form.append 'image[attachment]', file
    xhr = new XMLHttpRequest
    xhr.open 'POST', endpoint, true
    xhr.setRequestHeader 'X-CSRF-Token', Rails.csrfToken()

    xhr.upload.onprogress = (event) ->
      progress = event.loaded / event.total * 100
      attachment.setUploadProgress progress

    xhr.onload = ->
      if @status >= 200 and @status < 300
        data = JSON.parse(@responseText)
        return attachment.setAttributes(
          url: data.attachment_url
          href: data.attachment_url)
      return

    xhr.send form

  Trix.config.attachments.preview.caption =
    name: false
    size: false
  document.addEventListener 'trix-attachment-add', (event) ->
    attachment = event.attachment
    if attachment.file
      return uploadAttachment(attachment)
    return
  return


