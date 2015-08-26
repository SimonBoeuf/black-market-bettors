// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require websocket_rails/main
$(document).ready(function(){
    $("#summoner-btn").click(function(){
        $("#summoner").toggle();
    });
    $("#summoner-by-name-btn").click(function(){
        $("#summoner-by-name").toggle();
    });
    $("#summoner-by-id-btn").click(function(){
        $("#summoner-by-id").toggle();
    });
    $("#summoner-masteries-btn").click(function(){
        $("#summoner-masteries").toggle();
    });
    $("#summoner-by-ids-btn").click(function(){
        $("#summoner-by-ids").toggle();
    });
    $("#summoner-runes-btn").click(function(){
        $("#summoner-runes").toggle();
    });


    $("#stats-btn").click(function(){
        $("#stats").toggle();
    });
    $("#stats-ranked-btn").click(function(){
        $("#stats-ranked").toggle();
    });
    $("#stats-summary-btn").click(function(){
        $("#stats-summary").toggle();
    });


    $("#champion-btn").click(function(){
        $("#champion").toggle();
    });
    $("#champion-all-btn").click(function(){
        $("#champion-all").toggle();
    });
    $("#champion-by-id-btn").click(function(){
        $("#champion-by-id").toggle();
    });

    $("#game-btn").click(function(){
        $("#game").toggle();
    });
    $("#game-recent-btn").click(function(){
        $("#game-recent").toggle();
    });
});//= require websocket_rails/main

