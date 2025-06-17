static const char norm_fg[] = "#e2d099";
static const char norm_bg[] = "#0c0c0b";
static const char norm_border[] = "#9e916b";

static const char sel_fg[] = "#e2d099";
static const char sel_bg[] = "#C5773E";
static const char sel_border[] = "#e2d099";

static const char urg_fg[] = "#e2d099";
static const char urg_bg[] = "#906C2B";
static const char urg_border[] = "#906C2B";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
