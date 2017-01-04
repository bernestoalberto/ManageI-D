/**
 * Created by Charlietyn on 6/21/14.
 */

$(function(){
//          var  x=$("a");
//          x.hover(entraMouse,saleMouse);
//
//            function entraMouse()
//            {
//                $(this).css("background-color","#f472d0");
//            }
//
//            function saleMouse()
//            {
//                $(this).css("background-color","#fff");
//            }

$("#calendarid").calendar({
    format: "yyyy-mm-dd", //default 'yyyy-mm-dd'
    multiSelect: false, //default true (multi select date)
    startMode: 'day', //year, month, day
    date: new Date(), //the init calendar date (example: '2013-01-01' or '2012-01')
    otherDays: false, // show days for previous and next months,
    weekStart: 0,//start week from sunday - 0 or monday - 1
    getDates: function(data){

    }, // see example below
click: function(data){
    var div= $("#fecha").append(data+"</br>");


    } // fired when user clicked on day, in "d" stored date
});
$("#calendartema").calendar({
    format: "yyyy-mm-dd", //default 'yyyy-mm-dd'
    multiSelect: false, //default true (multi select date)
    startMode: 'day', //year, month, day
    date: new Date(), //the init calendar date (example: '2013-01-01' or '2012-01')
    otherDays: false, // show days for previous and next months,
    weekStart: 0,//start week from sunday - 0 or monday - 1
    getDates: function(data){

    }, // see example below
click: function(data){
    alert(data);
    } // fired when user clicked on day, in "d" stored date
});
$("#calendarid").addClass("calendar small");
$("#calendartema").addClass("calendar small");
});
