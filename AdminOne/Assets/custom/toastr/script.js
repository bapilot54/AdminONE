//------------TOASTR-------------//

function toastify(type, msg, title, position, showclosebutton) {
    if (position == null || position == '') {
        toastr.options.positionClass = 'toast-top-right';
    }
    else {
        toastr.options.positionClass = position;
    }
    if (showclosebutton == null || showclosebutton == '' || showclosebutton == 'true') {
        toastr.options.closeButton = true;
    }
    else {
        toastr.options.closeButton = false;
    }
    toastr.options.timeOut = '5000';
    toastr.options.progressBar = true;
    switch (type) {
        case 'success': toastr.success(msg, title);
            break;
        case 'info': toastr.info(msg, title);
            break;
        case 'warning': toastr.warning(msg, title);
            break;
        case 'error': toastr.error(msg, title);
            break;
    }
    //toastr.clear();
}