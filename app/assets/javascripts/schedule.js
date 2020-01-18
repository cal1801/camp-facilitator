$(document).ready(function() {
  //seach by camp name function
  $('#seach_group_name').keyup(function(){
    $('.gg_card').hide() //hide all groups to begin with
    $('.gg_name').each(function() {
      //find names of groups that contain the search string
      if($(this).text().toLowerCase().includes($('#seach_group_name').val().toLowerCase())) {
        //find the containing bootstrap card element and show it
        $(this).closest('.gg_card').show()
      }
    });
    //no need to code nil or blank case since every name by default has those
  });
});