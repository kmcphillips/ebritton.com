shiny_datetimepicker = (element) ->

  element.find("select").each (index, select) ->
    year = 0;
    month = 0;
    day = 0;

    switch index
      when 0 # year
        year = $(select).val()
        $(select).hide()

      when 1 # month
        month = $(select).val();
        $(select).hide();

      when 2 # day
        day = $(select).val();
        $(select).hide();

      when 3 # hour
        selected = $(select).val()
        $(select).children().remove()

        for index in [0..23]
          text = if index == 0
            "AM 12"
          else if index < 12

            "AM " + index
          else if index == 12
            "PM 12"
          else
            "PM " + (index - 12)

          $(select).append("<option value='" + index + "' " + (selected == index ? "selected='selected'" : "") + ">" + text + "</option>")

      when 4 # minute
        $(select).find("option").each ->
          $(this).remove() if($(this).val() != "00" && $(this).val() != "15" && $(this).val() != "30" && $(this).val() != "45")

        if year == 0 and month == 0 and day == 0
          value = ""
        else
          value = year + "/" + month + "/" + day

        element.find("ol").prepend("<input type='text' size='10' class='datetime_picker' value='" + value + "' style='width: auto; float: left; margin-right: 10px' />")
        element.find("input[type=text]").datepicker
          changeMonth: false
          changeYear: false
          dateFormat: "yy/mm/dd"
          onClose: (text) ->
            tokens = text.split("/");
            for index in [0..2]
              $(element.find("select")[index]).val(tokens[index].replace(/^[0]/g,""))

$ ->
  $("ol li.datetime").each (index, element) ->
    shiny_datetimepicker($(element))
