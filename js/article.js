/* Enabling Bootstrap popovers */
$(function () {
    $('[data-toggle="popover"]').popover()
});

/* Enabling Bootstrap tooltips  */
$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip();
});


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

/* hide user menu on article detail page */
(function ($) {
    $('#article-absolute-position').scroll(function(event){
        $('#article-absolute-position').css('bottom', '-40px');
        $('#nav-absolute-position').css('bottom', '-40px');
        $('#navigationUser').hide();
        $('#show-user-menu').removeClass('hidden');
    });
}(jQuery));

/* show user menu on article detail page */
$( "#show-user-menu" ).click(function() {
    $('#article-absolute-position').css('bottom', '0');
    $('#nav-absolute-position').css('bottom', '0');
    $('#navigationUser').show();
    $('#show-user-menu').addClass('hidden');
});

/* Open reference tab on citation clicking and go by the link */

(function () {
    var intextCitations = document.getElementsByClassName("intext-citation bibr");
    var i;
    for (i = 0; i < intextCitations.length; i++) {
        intextCitations[i].addEventListener("click", function (event) {
            var citAnchor = this.getAttribute("href");
            var referenceTab = document.getElementById('nav-profile-tab');
            var reference = document.getElementById(citAnchor.slice(1));
            if (!referenceTab.classList.contains('active')) {
                event.preventDefault();

                // The event related to Bootstrap (triggered by this click) seems to be asynchronous; need to wait till ends
                referenceTab.click();

                setTimeout(function () {
                    location.hash = citAnchor;
                    reference.scrollIntoView();
                }, 200);
            }
            // Adding some styling
            var parentRef = reference.parentElement;
            var allReferences = document.getElementsByClassName("ref");
            $('li.ref.active').removeClass("active");
            parentRef.classList.add("active");
        });
    }
})();



