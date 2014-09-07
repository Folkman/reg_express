#= require jquery
#= require jquery_ujs


$ ->
  $('body').height($(window).height())

  train_position_x = 0
  train = $('#train')
  depot = $('#depot')
  chasm = $('#chasm')
  bridge = $('#bridge')

  move_train = setInterval ->
    train_position_x += 1
    train.offset(left: train_position_x)

    after_bridge = train_position_x > bridge.offset().left + bridge.width()
    after_chasm = train_position_x >= chasm.offset().left + chasm.width()

    if after_bridge && !after_chasm
      train_position_y = train.offset().top + 5
      train.offset(top: train_position_y)
      if train.offset().top > $(window).height() - train.height()
        alert 'Uh oh!'
        clearInterval(move_train)
    else if train.offset().left > depot.offset().left + 40
      alert 'Hooray!'
      clearInterval(move_train)
  , 50

  $('#regex').on 'keypress', (e)->
    if e.keyCode == 13
      target_1 = $('#target_1').html()
      target_2 = $('#target_2').html()
      regex = new RegExp($('#regex').val())

      if target_1.match(regex) && !target_2.match(regex)
        move_bridge = bridge.offset().left + 30
        bridge.offset(left: move_bridge )
        $('#regex').val('')
        random_words = shuffle(words)[0..1]
        $('#target_1').html(random_words[0])
        $('#target_2').html(random_words[1])


  window.pause = ->
    clearInterval(move_train)


  words = ['555-555-5555', '(555)555-5555', 'example@example.com', 'example',
    'example@example.io', 'abc123', 'John Doe', 'Jane Doe', 'example@example',
    '555 Road Way', '12345', '@you', '#hash_tag', 'Hello, World!']


  shuffle = (a) ->
    i = a.length
    while --i > 0
      j = ~~(Math.random() * (i + 1))
      t = a[j]
      a[j] = a[i]
      a[i] = t
    a
