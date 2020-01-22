// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require_tree .
//= require cocoon

$(document).ready(function() {
  $('.navbar-brand').hover(
    function () {
      $('.navbar-brand .fa-pencil-alt').show();
    }, 
    function () {
      $('.navbar-brand .fa-pencil-alt').hide();
    }
  )
})

function openNav() {
  document.getElementById("mySidenav").style.width = "250px";
  $("#mySidenav").addClass("px-3");
  document.getElementById("exmain").style.marginLeft = "250px";
}

/* Set the width of the side navigation to 0 and the left margin of the page content to 0 */
function closeNav() {
  document.getElementById("mySidenav").style.width = "0";
  $("#mySidenav").removeClass("px-3");
  document.getElementById("exmain").style.marginLeft = "0";
}