$(document).ready(function() {
    st = ($("#startTime").data("from") - 8) * 2 + 1;
	et = ($("#startTime").data("to") - 8) * 2 + 1;
	for (i = 1; i < 32; i++) {
		timeblock = $("#timeblock" + i);
		if (i >= st && i < et && !(timeblock.hasClass("time-block-selected"))) {
			timeblock.addClass("time-block-selected");
		} else if ((i < st || i >= et) && timeblock.hasClass("time-block-selected")) {
			timeblock.removeClass("time-block-selected");
		}
	}
})
$("#startTime").on("change", function() {
	st = ($("#startTime").data("from") - 8) * 2 + 1;
	et = ($("#startTime").data("to") - 8) * 2 + 1;
	for (i = 1; i < 32; i++) {
		timeblock = $("#timeblock" + i);
		if (i >= st && i < et && !(timeblock.hasClass("time-block-selected"))) {
			timeblock.addClass("time-block-selected");
		} else if ((i < st || i >= et) && timeblock.hasClass("time-block-selected")) {
			timeblock.removeClass("time-block-selected");
		}
	}
})
