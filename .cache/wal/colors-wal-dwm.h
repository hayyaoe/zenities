static const char norm_fg[] = "#d3f2ef";
static const char norm_bg[] = "#231b30";
static const char norm_border[] = "#93a9a7";

static const char sel_fg[] = "#d3f2ef";
static const char sel_bg[] = "#3698F3";
static const char sel_border[] = "#d3f2ef";

static const char urg_fg[] = "#d3f2ef";
static const char urg_bg[] = "#3FADC6";
static const char urg_border[] = "#3FADC6";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
