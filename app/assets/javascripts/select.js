    $().ready(function() {
        $('.kwicks').kwicks({
            maxSize : 250,
            behavior: 'menu'
        });
        $('#panel-01').click(function(){
          $('#panel-01').css("background-color", "#ff00ff");
        }); 
        $(".kwicks li").click(function(event) {
          var ele = document.getElementById(event.target.id);
          var color = $(ele).css("background-color"); //event.target.backgroundColor;
          var col = new RGBColor (color); //Usando la clase RGB color incluida en assets
            $(ele).css("background-color", color);
          $('body').css("background-color", color);
     //    alert(event.target.id + ' '  +  col.toHex_n()  );
          changeEstanque( col.toHex_n());
        });
    });

function changeEstanque(color) {
  //  document.getElementById('est-app');
    var arq = 'custom_app/perspectiva/per_estanque_'+color+'.png';
    var image_path = "<%= asset_path('" + color +"') %>"
    var path =  '<%= asset_path 'custom/perspectiva/per_estanque_00A1F8.png' %>';
  //  $('#est-app').attr("src", nuevaImag);
    var s = document.getElementById('est-app').src;
    alert(arq + " | " + image_path + " | "+s );
//    $('#est-app').attr("src",asset-path("custom_app/perspectiva/per_estanque_00A1F8.png"));
    $('#est-app').attr("src",  '<%= asset_path 'custom_app/perspectiva/per_estanque_00A1F8.png '%>'); 
};
