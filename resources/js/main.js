$(document).ready(function () {

	//TODO return carousel text on resize

	$("#carouselIssues").on("slid.bs.carousel", function () {
		addEllipsis();
	});

	$(window).on("resize", function () {
		addEllipsis();
	});

	addEllipsis();

	function addEllipsis() {
		var activeItem = $(".carousel-item.active .carousel-caption");
		var children = $(activeItem).children();
		var height = 0;
		children.each(function () {
			if (!$(this).hasClass("carousel-text")) {
				height += $(this).height();
			}
		});

		var neededHeight = activeItem.height() - height;
		var carouselText = activeItem.children(".carousel-text");
		carouselText.height(neededHeight);
		while(carouselText.prop("scrollHeight") > neededHeight) {
			carouselText.html(function(index, html) {
				return html.replace(/\W*\s(\S)*$/, "...");
			});
		}
	}
});

// Styling for the html galley page
$(document).ready(function () {
	var htmlContainerMain = $("#htmlContainer").parent();
	if (htmlContainerMain) {
		htmlContainerMain.css("padding-bottom", "0");
		htmlContainerMain.css("padding-top", "5px");
	}
});
