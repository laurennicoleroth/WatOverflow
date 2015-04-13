// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$( document ).ready(function() {
    console.log( "ready!" );
    $("#vote").val('0');

    // Create a click handler for your increment button
    $("#increaseButton").click(function () {
        var newValue = 1 + parseInt($("#vote").val());
        $("#vote").val(newValue);
    });
    // .. and your decrement button
    $("#decreaseButton").click(function () {
        var newValue = parseInt($("#vote").val()) - 1;
        $("#vote").val(newValue);
    });

    $("#most-recent-button").click(function () {
        alert("most recent");
    });


  $('.answers-new').on('submit', '#new-answer-form', function(event){
    event.preventDefault();
    $target = $(event.target);
    var url = $target.attr('action');
    var data = $target.serialize();
    $.ajax({
      method: "post",
      url: url,
      data: data,
    }).done(function(response){
      $('.answers-show').replaceWith(response);
    });
  });
});


