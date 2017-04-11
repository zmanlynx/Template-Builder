$('div.divTableCell').click(function() {
  if ($(this).is(':last-child')) return;
  var template_id = $(this.parentNode).prop('id');
  var url_show = '/' + template_id + '/show';
  $(location).attr('href', url_show);
});


//Delete function
$(document).ready(function(){

    var delete_modal = $("#delete-modal");
    var delete_button = $('#modal-delete-btn');
    var delete_template_info = $('#template_delete_info');

    $("a.destroy-template").on("click", function(e){
        e.preventDefault();
        var parent = $(this.parentNode.parentNode);
        var template_id = parent.prop('id');
        delete_modal.attr('delete_id', template_id );
        delete_template_info.text(template_id.toUpperCase());
    });

    delete_button.on("click", function() {
        var delete_id = delete_modal.attr('delete_id');
        $.ajax({
            url: '/delete',
            type: 'DELETE',
            data:{ id: delete_id },
            success: function(result) {

                $('.divTableRow').each(function(index, element){
                    if (delete_id==element.id) {
                        $(element).remove();
                        return;
                    }
                });
                delete_modal.attr('delete_id','');
            }
        });
    });

});
