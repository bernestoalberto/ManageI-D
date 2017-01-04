/**
 * Created by Charlietyn on 8/12/14.
 */
function submit_btn(){
        var user =  $('#edit-name').attr('value');
        var pass =  $('#edit-pass').attr('value');
        $.ajax({
                url: 'drupal/user/login',
                type: "POST",
                data:"&edit-name="+user+"$edit-pass="+pass
            }
        )

}

$(function(){
    $("#dialog-login").hide();
    $("#createlogin").on('click', function(){
        $.Dialog({
            overlay: true,
            shadow: true,
            flat: true,
            padding: 10,
            icon: '<span class="icon-user-2"></span>',
            title: 'User Login',
            content: $("#dialog-login")[0].innerHTML,
            onShow:function(d)
            {
                $.Dialog.title("Loguearse");
            }
        });
    });
});