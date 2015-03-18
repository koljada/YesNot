
$(document).on('ready page:load', function () {
    $('.card.clickable').on('click',function(e){
        if(e.target==this){
            window.location=$(this).find('.topic a').attr('href')
            return false;
        }
    });

    $(".pl").css('height', $(".answers").outerHeight());

    $('.answers').on( 'keyup', 'textarea', function (e){
        $(this).css('height', 'auto' );
        $(this).height( this.scrollHeight );

        $(this).parent().find('.pl').css('height', this.scrollHeight);
    });
    $('.answers').find( 'textarea' ).keyup();
   

    $('.likes').on('click',function(event){
        target=$(event.target).parent();
        counter=$(this).find('.counter');
        debugger
        if (target.is(".liked")) {
            target.removeClass('liked').addClass('unliked');
            like = -1;
        }
       else if (target.is(".unliked"))
        {
            target.removeClass('unliked').addClass('liked');
            like=1;
        }

        $.ajax({
            url: target.attr('href'),
            beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
            type: 'PUT',
            success: function(data) {
                counter.html(+counter.html()+like);
            }
        });
        return false;
    })
});






