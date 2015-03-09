console.log("linked");

 //   View & Hide Contacts
$('.view_button').on("click", function(e){
  e.preventDefault();
  $('li').css('display', 'block');
  $('.search').css('display', 'block');
  $('.contact-search').css('display', 'block');
   $( this ).off( e );
})

//   Search Contacts
$('.contact-search').keydown(function(e) {
  e.preventDefault();
  if (event.keyCode == 13) {
    var search = $('.contact-search').val();
      return search;
  }
})


// Send Messages
$('.send').on("click", function(e){
  e.preventDefault();
  console.log("send");
})


// Dribbble Ajax Call
// $('.dribbble').on("click", function(e){
//     $.ajax({
//       url: 'https://dribbble.com/oauth/token',
//       type: 'GET',
//       dataType: 'json',

//     })
// })
