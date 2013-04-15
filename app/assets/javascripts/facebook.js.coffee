jQuery ->
  $('body').prepend('<div id="fb-root"></div>')

  ((d, s, id) ->
    js = undefined
    fjs = d.getElementsByTagName(s)[0]
    return  if d.getElementById(id)
    js = d.createElement(s)
    js.id = id
    js.src = "//connect.facebook.net/en_US/all.js"
    fjs.parentNode.insertBefore js, fjs
  ) document, "script", "facebook-jssdk"

  $('#mfs-button').click ->
    event.preventDefault()
    sendRequestViaMultiFriendSelector()

  $('li.friend').click ->
    event.preventDefault()
    id = $(this).data('friendid')
    sendMessageToFriend(id)

  $('#Search').fastLiveFilter('#friends');

sendMessageToFriend = (id) ->
  FB.ui
    method: "send"
    link: "http://jupiterapp.herokuapp.com"
    to: id
  , requestCallback

sendRequestViaMultiFriendSelector = ->
  FB.ui
    method: "apprequests"
    message: "Hi!  I want to schedule activities with you on Jupiter.  Sign up and let's plan to get together soon!"
  , requestCallback

requestCallback = (response) ->
  alert "Facebook response"

window.fbAsyncInit = ->
  FB.init(appId: gon.global.FACEBOOK_APP_ID, cookie: true)

  $('#sign_in').click (e) ->
    e.preventDefault()
    FB.login (response) ->
      if response.authResponse
        console.log "Welcome!  Fetching your information.... "
        window.location.replace('/auth/facebook/callback')
      else
        console.log("User cancelled login or did not fully authorize.")
    , scope: gon.global.FACEBOOK_PERMISSION