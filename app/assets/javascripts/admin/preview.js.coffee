$ ->
  $("textarea.body").closest("li").after('<li><label class="label">Preview</label><div class="preview"></div></li>')
  refresh_preview()
  $(document).on("keypress keydown keyup", "textarea.body", window.body_changed)  


window.preview_changed = true

window.body_changed = ->
  window.preview_changed = true


window.refresh_preview = ->
  if preview_changed
    window.preview_changed = false
    body = $("textarea.body").val()

    $("div.preview").load "/admin/preview.js", {body: body}, (response, status, xhr) ->
      alert "server error" if status == "error"
          
  setTimeout refresh_preview, 3000

