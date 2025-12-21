static const char norm_fg[] = "#d3d0bd";
static const char norm_bg[] = "#0d0c09";
static const char norm_border[] = "#939184";

static const char sel_fg[] = "#d3d0bd";
static const char sel_bg[] = "#6D694B";
static const char sel_border[] = "#d3d0bd";

static const char urg_fg[] = "#d3d0bd";
static const char urg_bg[] = "#605D46";
static const char urg_border[] = "#605D46";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
