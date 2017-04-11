$(document).ready(function() {
    var searchInput = $('#filter_string');
    var filterButton = $('#filter_button');
    var globalTimeout = null;

    function onAjaxSuccess(data)
    {
        $('#content_body').html(data);
    }

    function doRequest(){
        globalTimeout = null;
        $.post( "/", { filter_string: searchInput.val() }, onAjaxSuccess );
    };

    searchInput.keyup(function (e) {
        if (globalTimeout != null) clearTimeout(globalTimeout);
        if ($(this).val().length> 1)
            globalTimeout = setTimeout(doRequest, 200);
    });

    filterButton.click(doRequest);

    searchInput.bind('input', function(){
        if ($(this).val()=='') {
            $(location).attr('href', '/');
            $(this).disabled = true;
        };
    });

    searchInput.focus();

});