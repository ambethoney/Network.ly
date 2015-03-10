console.log("linked");



 //   View & Hide Contacts
$('.view_button').on("click", function(e){
  e.preventDefault();
  $('li').css('display', 'block');
  $('.search').css('display', 'block');
  $('#contact-search').css('display', 'block');
   $( this ).off( e );
})


function searchTitles(){
  $("#contact-search").keydown(function(e) {
      if ( event.which == 13 ) {
        event.preventDefault();
        var search = $(this).val();
        var that = this;
        $(".all-contacts li").each( function() {
          var liText = $(this).text();
          if(liText.toLowerCase().indexOf(search)!=-1) {
            $(this).show();
          }
          else {
            $(this).hide();
          }
        });
      }
  })
}
  searchTitles();

$(document).ready(function(){
})






// Send Messages
$('.send').on("click", function(e){
  e.preventDefault();
  console.log("send");
})

