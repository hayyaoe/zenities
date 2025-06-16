static const char norm_fg[] = "#f0d8c6";
static const char norm_bg[] = "#0a090a";
static const char norm_border[] = "#a8978a";

static const char sel_fg[] = "#f0d8c6";
static const char sel_bg[] = "#3E838B";
static const char sel_border[] = "#f0d8c6";

static const char urg_fg[] = "#f0d8c6";
static const char urg_bg[] = "#957560";
static const char urg_border[] = "#957560";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
