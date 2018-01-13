
/* append article text to the bootstrap tabs for small screens */

function articleTextForMobiles() {
    var windowWidth = $(window).width();
    if(windowWidth < 992){
        $('#full-article-block').appendTo('#nav-article');
    }
};

(function ($) {
    articleTextForMobiles();
}(jQuery));

$(window).on('resize', function(event){
    var windowWidth = $(window).width();
    if(windowWidth < 992){
        articleTextForMobiles();
    } else {
        $('#full-article-block').appendTo('.article-text-row'); // return to previous position on resizing;
    }
});

/* goto article section */

(function ($) {
    var windowWidth = $(window).width();
    if(windowWidth < 992){
        $("#navbar-article-links a").click(function() {
            $("#nav-content").removeClass("show active");
            $("#nav-home-tab").removeClass("active");
            $("#nav-article").addClass("show active");
            $("#nav-article-tab").addClass("active");
        });
    }
}(jQuery));

/* floating content menu */

(function ($) {
    $("#floating-mobile-content").hide();
    var navTopPosition = $("#myTab").offset();
    $(document).scroll(function() {
        if(navTopPosition !== undefined &&($(window).scrollTop() < (navTopPosition.top + 30))) {
            $("#floating-mobile-content").hide();
        } else {
            $("#floating-mobile-content").show();
        }
    });
}(jQuery));

/* GOTO top */
$("#goto-top").click(function () {
    $("html, body").animate({ scrollTop: 0 }, "slow");
});

/* GOTO content */
$("#goto-content").click(function () {
   $("#nav-article").removeClass("show active");
   $("#nav-article-tab").removeClass("active");
   $("#nav-content").addClass("show active");
   $("#nav-home-tab").addClass("active");
   window.scrollTo(0, 0);
});

/* articles by the same author plugin rendering */
(function ($) {
    $("#articlesBySameAuthorList li").addClass("alert alert-secondary");
    $("#articlesBySameAuthorList li > a").addClass("alert-link");
}(jQuery));