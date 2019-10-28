(function(d, s, id) {
	var js, fjs = d.getElementsByTagName(s)[0];
	if (d.getElementById(id)) return;
	js = d.createElement(s); js.id = id;
	js.src = "https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v3.0";
	fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

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
