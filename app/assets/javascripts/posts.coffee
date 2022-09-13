do ->
  HOST = "https://api.cloudinary.com/v1_1/blog-site-h"
  CLOUDINARY_UPLOAD_PRESET = "mpdzbgxl"
  # POST https://api.cloudinary.com/v1_1/demo/image/upload
  uploadFileAttachment = (attachment) ->

    setProgress = (progress) ->
      attachment.setUploadProgress progress
      return

    setAttributes = (attributes) ->
      attachment.setAttributes attributes
      return

    uploadFile attachment.file, setProgress, setAttributes
    return

  uploadFile = (file, progressCallback, successCallback) ->
    key = createStorageKey(file)
    formData = createFormData(key, file)
    xhr = new XMLHttpRequest
    xhr.open 'POST', HOST, true
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.upload.addEventListener 'progress', (event) ->
      progress = event.loaded / event.total * 100
      progressCallback progress
      return
    xhr.addEventListener 'load', (event) ->
      if xhr.status == 204
        attributes =
          url: HOST + key
          href: HOST + key + '?content-disposition=attachment'
        successCallback attributes
      return
    xhr.send formData
    return

  createStorageKey = (file) ->
    date = new Date
    day = date.toISOString().slice(0, 10)
    name = date.getTime() + '-' + file.name
    [
      'tmp'
      day
      name
    ].join '/'

  createFormData = (key, file) ->
    data = new FormData
    data.append 'key', key
    data.append 'Content-Type', file.type
    data.append 'file', file
    data

  addEventListener 'trix-attachment-add', (event) ->
    if event.attachment.file
      uploadFileAttachment event.attachment
    return
  return
