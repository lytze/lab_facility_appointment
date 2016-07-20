var timetableHandler = new Shiny.OutputBinding();
$.extend(timetableHandler, {
    find: function(scope) {
        return $(scope).find(".time-table-handler");
    },
    renderValue: function(el, data) {
        $(".time-block-info").html(null);
        $(".time-block-used").removeClass("time-block-used");
        for (i = 0; i < data.length; i++) {
            info = data[i];
            timeb = $("#timeblock" + info.time);
            if (info.hasOwnProperty("samp") ||
                info.hasOwnProperty("antm") ||
                info.hasOwnProperty("extn") ||
                info.hasOwnProperty("cycl") ||
                info.hasOwnProperty("addi")) {
                info_text = "";
                if (info.hasOwnProperty("samp")) info_text +=
                    "<strong>" + info.samp + "</strong> Samples<br>";
                if (info.hasOwnProperty("antm")) info_text +=
                    "Annealing at <strong>" + info.antm + "</strong> ˚C<br>";
                if (info.hasOwnProperty("extn")) info_text +=
                    "<strong>" + info.extn + "</strong> sec Extension per Cycle<br>";
                if (info.hasOwnProperty("cycl")) info_text +=
                    "<strong>" + info.cycl + "</strong> Cycles<br>";
                if (info.hasOwnProperty("addi")) info_text += info.addi;
                timeb.find(".time-block-info").html("<a><i class=\"fa fa-info-circle\"></i> " +
                    info.name + "</a>");
                timeb.find("a").popover({
                    content: info_text,
                    html: true,
                    trigger: "hover",
                    placement: "top"});
            } else {
                timeb.find(".time-block-info").html("<span>" + info.name + "</span>");
            }
            timeb.addClass("time-block-used");
        }
    }
});
Shiny.outputBindings.register(timetableHandler, "pcrappointment.timetableHandler");
