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
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery-fileupload/basic

//= require cocoon
//= require bootstrap-sprockets
//= require filterrific/filterrific-jquery
//= require chardinjs
//= require masonry/jquery.masonry
//= require jquery.simpleGal
//= require_tree .
$(document).ready(function () {
    $('.thumbnails').simpleGal({
      mainImage: '.custom'
    });


    $('input:file').change(function(){
                  if ($(this).val()) {
                    $('input:submit').attr('disabled',false); 
                  } 
              }
            );

    setTimeout(function() {
      $('#alert-info').fadeOut("slow", function() {
        $(this).remove();
      })
    }, 4500);


  });

