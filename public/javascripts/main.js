console.log("linked");

$('.view_button').on("click", function(e){
  e.preventDefault();
  $('li').css('display', 'block');
  $('.search').css('display', 'block');
  $('.contact-search').css('display', 'block');
   $( this ).off( e );
})

$('.contact-search').keydown(function(event) {
  if (event.keyCode == 13) {
    var search = $('.contact-search').val();
    if(search == search){
      return search;
    }
  }
})

$('.send').on("click", function(e){
  e.preventDefault();
  console.log("send");
})
