# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# JavaScript Document

$ ->
  #-- Add loaded class after delay
  setTimeout (->
    $('body').addClass 'delayloaded'
    return
  ), 2000

  #-- Show / Hide About
  $('.btn-about').on 'click', (e) ->
    e.preventDefault()
    $('body').addClass 'showabout'
    return

  $('.about .btn-close').on 'click', (e) ->
    e.preventDefault()
    $('body').removeClass 'showabout'
    return

  forceTwoDigits = (val) ->
    if val < 10
      return "0#{val}"
    return val

  #-- Date picker
  if $('.btn-pickdate').length != 0

    $('.btn-pickdate').on 'click', (e) ->
      e.preventDefault()

    $('.btn-pickdate').datepicker(
      orientation: 'bottom auto'
      autoclose: true
      todayHighlight: false
      format: 'M/dd/yyyy'
      disableTouchKeyboard: true

      beforeShowDay: (date) ->
        dateFormat = date.getFullYear() + '-' + forceTwoDigits((date.getMonth() + 1)) + '-' + forceTwoDigits(date.getDate())        

        index = 0
        while index < gon.dates_with_news.length
          date_with_news = gon.dates_with_news[index]          
          ++index
          #console.log dateFormat
          #console.log date_with_news.sent_at
          if date_with_news.sent_at == dateFormat
            #console.log ' ***************** dentro do IF'
            return {classes: 'today', tooltip: 'This day has News'}          
        if index == gon.dates_with_news.length               
          return {classes: 'disabled'}
          

    ).on 'changeDate', (e) ->
      date = e.date
      mm = (date.getMonth() + 1).toString();
      dd = date.getDate().toString();

      redirect_url = "/#{[!dd[1] and '0', dd,'-', !mm[1] and '0', mm,'-', date.getFullYear()].filter((e)-> e != false ).join('')}";   
      window.location = redirect_url

    $('.btn-pickdate-alt').on 'click', (e) ->
      e.preventDefault()
      $('.btn-pickdate').datepicker 'show'
      return
    #-- Scroll to the top of the page and open calendar
    $('.btn-prevdays').on 'click', (e) ->
      e.preventDefault()
      $('html, body').animate { scrollTop: 0 }, 1000, ->
        $('.btn-pickdate').datepicker 'show'
        return
      return
  #-- Newsletter btn state change

  ###
  $('.btn-newslettermore').on('click', function(e){
    $(this).toggleClass('open');
  }); 
  ###

  $('[role=popup]').on 'click', (e) ->
    e.preventDefault();
    window.open($(this).attr('href'), 'Share', 'resizable,scrollbars,status,width=600,height=350,left='+((screen.width / 2) - (600 / 2)) + ',top=' + ((screen.height / 2) - (350 / 2)))

  $('.btn-newslettermore').on 'click', (e) ->
    if $(e.target).hasClass('btn-newslettermore')
      $('.btn-newslettermore').toggleClass 'open'
    else if $(e.target).parents('.form-newsletter').length == 0
      $('#newsletter-plus').collapse 'show'
      $('.btn-newslettermore').addClass 'open'

  #-- Newsletter subscribe Thank you message
  $('.btn-subscribe').on 'click', (e) ->
    e.preventDefault()
    $.post $(this).closest('form').attr('action'), $(this).closest('form').serialize(), ->
      $('.newsletter .twocols, .btn-newslettermore, #newsletter-plus').fadeOut ->
        $('.newsletter-thankyou').fadeIn()

  #-- News Blocks slider
  if $('.newslider').length != 0
    $('.newslider').owlCarousel
      singleItem: true
      mouseDrag: false
      touchDrag: true
      pagination: false
      slideSpeed: 800
      autoHeight: true
      rewindNav: false
      afterInit: ->
        @jumpTo 1
        return

    slider = $('.newslider').data('owlCarousel')

    #- Slider navigation - change dates
    $('.btn-calnext').on 'click', (e) ->
      e.preventDefault()
      if !$(this).hasClass('disabled')
        slider.next()
      return
    $('.btn-calprev').on 'click', (e) ->
      e.preventDefault()
      if !$(this).hasClass('disabled')
        slider.prev()
      return
    #-- Navigate slider with keys
    $(document).keyup (e) ->
      key = e.which
      if key == 39
        slider.next()
      if key == 37
        slider.prev()
      return
  return
