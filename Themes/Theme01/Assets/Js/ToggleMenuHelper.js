function ToggleMenu(toggleMenuWrapSelector, event) {
    event.stopPropagation();

    $(".toggle-menu-wrap:not('" + toggleMenuWrapSelector + "')").removeClass("expanded");

    var $toggleMenuWrap = $(toggleMenuWrapSelector);
    
    if ($toggleMenuWrap.hasClass("expanded")) {
        $toggleMenuWrap.removeClass("expanded");
    } else {
        $toggleMenuWrap.addClass("expanded");
    }
}

function HideToggleMenu() {
    $(".toggle-menu-wrap").removeClass("expanded");
}

$(document)
    .click(function() {
        HideToggleMenu();
    });

$(".toggle-menu-wrap")
        .click(function (event) {
            event.stopPropagation();
        });
$(".toggle-menu-btn")
        .click(function (event) {
            event.stopPropagation();
        });