$ ->
	isEmail = (email) ->
	  regex = /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/
	  regex.test email

	searchTable = (inputVal) ->
  table = $("#contacts")
  table.find("tr").each (index, row) ->
    allCells = $(row).find("td")
    if allCells.length > 0
      found = false
      allCells.each (index, td) ->
        regExp = new RegExp(inputVal, "i")
        if regExp.test($(td).text())
          found = true
          false

      if found is true
        $(row).show()
      else
        $(row).hide()

	addToInviteList = (name, email) ->
		if name == ""
			name = email.split("@")[0]
		$("#no-invites").hide()
		html = "<tr>"
		html += "<td class='name' contenteditable='true'>"+name+"</td>"
		html += "<td class='email' contenteditable='true'>"+email+"</td>"
		html += "<td><button class='btn btn-mini remove pull-right'>&times;</button></td>"
		html += "</tr>"

		$("#invite-list table").prepend(html)
		# alert "Added " + email + " to Invite List"

	removeFromInviteList = (name, email) ->
		$("#invite-list td").each ->
			if $(this).text() == email
				$(this).parent("tr").remove()

	$(document).on "click", ".remove", ->
		email = $(this).parent('td').siblings('.email').text()
		$(this).parent('td').parent('tr').remove()
		$('#contacts tr td.email').each ->
			if $(this).text() == email
				$(this).siblings('.button-cell').children(".invite-button").removeClass("btn-success")


	$('#invite-email-button').click ->
		email = $('#invite-email-field').val()
		if isEmail email
			addToInviteList("", email)
			$('#invite-email-field').val('')
		else
			$("#invalid-email-error-message").show().delay(2000).fadeOut()

	$('.invite-button').click ->
		name = $(this).parent().siblings('.name').text()
		email = $(this).parent().siblings('.email').text()

		$(this).toggleClass('btn-success')
		
		if $(this).hasClass('btn-success')
			addToInviteList(name, email)
		else
			removeFromInviteList(name, email)
		event.preventDefault()

	$('.slimscroll').slimscroll
		height: '350px'

	$("#search-contacts").keyup ->
    searchTable $(this).val()

  $("#clear-search-contacts").click ->
  	event.preventDefault()
  	$("#search-contacts").val("")
  	$("#contacts").find("tr").each (index, row) ->
  		$(row).show()